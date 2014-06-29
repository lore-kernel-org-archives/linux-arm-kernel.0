From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 29 Jun 2014 09:34:16 +0100
Subject: [PATCH v7 7/9] ARM: add vdso user-space code
In-Reply-To: <53AF3510.7030707@mentor.com>
References: <1403493118-7597-1-git-send-email-nathan_lynch@mentor.com>
 <1403493118-7597-8-git-send-email-nathan_lynch@mentor.com>
 <20140628152609.GH32514@n2100.arm.linux.org.uk> <53AEE9B6.7000609@mentor.com>
 <20140628181212.GJ32514@n2100.arm.linux.org.uk> <53AF1B65.5000904@mentor.com>
 <20140628201120.GK32514@n2100.arm.linux.org.uk> <53AF3510.7030707@mentor.com>
Message-ID: <20140629083415.GL32514@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jun 28, 2014 at 04:35:12PM -0500, Nathan Lynch wrote:
> That's consistent with my results on iMX6.  The reported 1.00x "speedup"
> for clock-gettime-monotonic etc indicates the VDSO is falling back to
> syscall.
> 
> Thanks for testing.

Here's another issue which cropped up when I ran this patch set through
the autobuilder last night - allnoconfig's now fail with:

mm/memory.c: In function 'gate_vma_init':
mm/memory.c:3410:22: error: 'FIXADDR_USER_START' undeclared (first use in this function)
mm/memory.c:3411:20: error: 'FIXADDR_USER_END' undeclared (first use in this function)
mm/memory.c: In function 'in_gate_area_no_mm':
mm/memory.c:3432:15: error: 'FIXADDR_USER_START' undeclared (first use in this function)
mm/memory.c:3432:46: error: 'FIXADDR_USER_END' undeclared (first use in this function)
make[2]: *** [mm/memory.o] Error 1

Any ideas?

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
