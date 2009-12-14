From: chripell@gmail.com (christian pellegrin)
Date: Mon, 14 Dec 2009 18:48:14 +0100
Subject: shared memory problem on ARM v5TE using threads
In-Reply-To: <309002C0DA137042828828FC53D7A9347E2630F364@IL-MB01.marvell.com>
References: <20091207114218.GA19348@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.0912071027480.31174@xanadu.home>
	<20091207170546.GB26821@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.0912071219100.31174@xanadu.home>
	<20091207175608.GE26821@n2100.arm.linux.org.uk>
	<309002C0DA137042828828FC53D7A9347E2630EEC2@IL-MB01.marvell.com>
	<20091213120033.GA10698@n2100.arm.linux.org.uk>
	<20091213120615.GB10698@n2100.arm.linux.org.uk>
	<cabda6420912140513k40a998b7k8cf56c35cc535cfb@mail.gmail.com>
	<309002C0DA137042828828FC53D7A9347E2630F364@IL-MB01.marvell.com>
Message-ID: <cabda6420912140948t23c07676tb5f44eb4febbc584@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 14, 2009 at 3:46 PM, Ronen Shitrit <rshitrit@marvell.com> wrote:

> "
>
> I think your patch doesn't cover the PIO mode...
>

Has someone a suggestion on how to write a test-case for this? I tried
various forms of mixing read/write syscalls (or a mmap wit
MAP_PRIVATE) and access via two mmap with MAP_SHARED aliasing the same
address (I checked that adjust_pte was called by them) but didn't get
any problem. I have to admit that I really don't understand how PIO in
kernel mode can refer to mappings that are aliased (and so market
uncacheable) made by user-space programs. Thank you for your patience.

-- 
Christian Pellegrin, see http://www.evolware.org/chri/
"Real Programmers don't play tennis, or any other sport which requires
you to change clothes. Mountain climbing is OK, and Real Programmers
wear their climbing boots to work in case a mountain should suddenly
spring up in the middle of the computer room."
