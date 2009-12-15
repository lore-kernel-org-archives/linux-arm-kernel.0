From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 15 Dec 2009 17:18:55 +0000
Subject: shared memory problem on ARM v5TE using threads
In-Reply-To: <cabda6420912150731s1570aa04w4eaff03bc93ee6a6@mail.gmail.com>
References: <309002C0DA137042828828FC53D7A9347E2630EEC2@IL-MB01.marvell.com>
	<20091213120033.GA10698@n2100.arm.linux.org.uk>
	<20091213120615.GB10698@n2100.arm.linux.org.uk>
	<cabda6420912140513k40a998b7k8cf56c35cc535cfb@mail.gmail.com>
	<309002C0DA137042828828FC53D7A9347E2630F364@IL-MB01.marvell.com>
	<cabda6420912140948t23c07676tb5f44eb4febbc584@mail.gmail.com>
	<alpine.LFD.2.00.0912141503360.23173@xanadu.home>
	<c70ff3ad0912142350v2231938dqc9c0aedc214120bd@mail.gmail.com>
	<cabda6420912150301n2c1a54d6ta7407d89f4d0f9cf@mail.gmail.com>
	<cabda6420912150731s1570aa04w4eaff03bc93ee6a6@mail.gmail.com>
Message-ID: <20091215171855.GB15855@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 15, 2009 at 04:31:35PM +0100, christian pellegrin wrote:
> The patch here does what was described by Russell and seems to solve
> the read/write and the MAP_PRIVATE in test cases like the one I
> posted. As noted it may not be enough.

This might be enough (but needs thorough testing).  However, adding
the requirement for L2 cache flushing in flush_dcache_page() because
you have an L2 cache is unfair on those L2's which don't suffer from
this problem.

I think we need to have a little more information about the behaviour
of the L2 cache so that we can decide how much flushing is required,
and where.
