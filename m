From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 30 Jun 2015 15:54:13 +0100
Subject: [PATCH] keystone: adds cpu_die implementation
In-Reply-To: <55929E0B.9070704@ti.com>
References: <1435600352-32733-1-git-send-email-vitalya@ti.com>
 <20150629175223.GC19863@leverpostej> <559191E0.4080808@ti.com>
 <20150629212814.GE7557@n2100.arm.linux.org.uk>
 <20150629213737.GF7557@n2100.arm.linux.org.uk>
 <55929E0B.9070704@ti.com>
Message-ID: <20150630145412.GG7557@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 30, 2015 at 09:47:55AM -0400, Vitaly Andrianov wrote:
> 
> 
> On 06/29/2015 05:37 PM, Russell King - ARM Linux wrote:
> >Oh, it was Murali who tested it, not yourself.  Sorry.  Suggest you
> >dig out the patches either from mainline (they're in Linus' tip) or
> >ask Murali for them...
> >
> Thanks Russell,
> 
> Excellent. I'll test how it will work using PSCI framework.

The commits in mainline are:

b2c3e38a5471 ARM: redo TTBR setup code for LPAE
1221ed10f2a5 ARM: cleanup early_paging_init() calling
d8dc7fbd53ee ARM: re-implement physical address space switching
c0b759d87eab ARM: keystone2: rename init_meminfo to pv_fixup
39b74fe82f73 ARM: keystone2: move address space switch printk into generic code
c8ca2b4b2928 ARM: keystone2: move update of the phys-to-virt constants into generic code
30b5f4d6128e ARM: keystone2: move platform notifier initialisation into platform init

There are an additional three which are worthwhile testing with them as
they clean up this same code (and fix a subtle but very minor bug in the
errata code paths):

c76f238e261b ARM: proc-v7: sanitise and document registers around errata
4419496884ed ARM: proc-v7: clean up MIDR access
17e7bf86690e ARM: proc-v7: move CPU errata out of line

So, picking the range b787f68c36d4..c76f238e261b will get all of them.
(That's v4.1-rc1 to the tip of the branch holding those commits.)

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
