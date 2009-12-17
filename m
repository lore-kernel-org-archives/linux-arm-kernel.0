From: rshitrit@marvell.com (Ronen Shitrit)
Date: Thu, 17 Dec 2009 09:35:53 +0200
Subject: shared memory problem on ARM v5TE using threads
In-Reply-To: <cabda6420912160938m6ea11da5t947c2bf082c430b7@mail.gmail.com>
References: <20091207175608.GE26821@n2100.arm.linux.org.uk>
	<20091213120615.GB10698@n2100.arm.linux.org.uk>
	<cabda6420912140513k40a998b7k8cf56c35cc535cfb@mail.gmail.com>
	<309002C0DA137042828828FC53D7A9347E2630F364@IL-MB01.marvell.com>
	<cabda6420912140948t23c07676tb5f44eb4febbc584@mail.gmail.com>
	<alpine.LFD.2.00.0912141503360.23173@xanadu.home>
	<c70ff3ad0912142350v2231938dqc9c0aedc214120bd@mail.gmail.com>
	<cabda6420912150301n2c1a54d6ta7407d89f4d0f9cf@mail.gmail.com>
	<20091215171440.GA15855@n2100.arm.linux.org.uk>
	<cabda6420912160835k714b9de4m7c647da97055f91b@mail.gmail.com>
	<cabda6420912160938m6ea11da5t947c2bf082c430b7@mail.gmail.com>
Message-ID: <309002C0DA137042828828FC53D7A9347E264E7B4D@IL-MB01.marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



-----Original Message-----
From: christian pellegrin [mailto:chripell at gmail.com] 
Sent: Wednesday, December 16, 2009 7:39 PM
To: Russell King - ARM Linux
Cc: saeed bishara; Ronen Shitrit; linux-arm-kernel at lists.infradead.org; Nicolas Pitre
Subject: Re: shared memory problem on ARM v5TE using threads

On Wed, Dec 16, 2009 at 5:35 PM, christian pellegrin <chripell@gmail.com> wrote:

>
> I'm trying some more elaborate tests where just one case of
> inconsistency will stop the counting.
>

Here is the program that implements Russell's ideas (at least I think
so) but is easier to use. By giving the parameter 1 or -1 you can test
different kind of consistency issues (missing flush in r/w or
inconsistent mapping's cacheness). It is also quite fun to watch at
with the buggy kernel on an idle system: it looks like that every
couple of seconds the 256kb L2 cache get flushed anyway
[Ronen Shitrit] The L2 dirty line eviction is always a result of L1 line fill request, or a specific CP15 flush command.

(so even on
the kernel without the patch every now and then you get some
progress). I had it running for tens of minutes on a patched kernel
without stops.
[Ronen Shitrit] Nice :)
