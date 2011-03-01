From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 1 Mar 2011 23:50:51 +0000
Subject: [PATCH 6/6] ARM: nmk: update GPIO chained IRQ handler to use
	EOI in parent chip
In-Reply-To: <alpine.LFD.2.00.1103020033080.2701@localhost6.localdomain6>
References: <1298900022-21516-7-git-send-email-will.deacon@arm.com>
	<20110228140327.GA1937@n2100.arm.linux.org.uk>
	<001401cbd772$a1f93ae0$e5ebb0a0$@deacon@arm.com>
	<alpine.LFD.2.00.1102281949050.2701@localhost6.localdomain6>
	<20110228214445.GD1937@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1103011140560.2701@localhost6.localdomain6>
	<20110301201904.GA27107@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1103012133530.2701@localhost6.localdomain6>
	<20110301231432.GG27107@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1103020033080.2701@localhost6.localdomain6>
Message-ID: <20110301235051.GH27107@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 02, 2011 at 12:44:05AM +0100, Thomas Gleixner wrote:
> The problem which caused that discussion has nothing to do with the
> above. It's about bog standard nested controllers which do not have a
> tight coupling to the the primary chip. But changing the primary chip
> from ack based to eoi based requires to touch multiple demux handlers
> while a primary chip agnostic solution for these cases would avoid
> that. W/O any negative side effects.

If you think its soo damned simple, maybe you should put the effort in
and fix all this up, get it tested as fully working on the affected
platforms, and show the patches then.
