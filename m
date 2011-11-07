From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 7 Nov 2011 17:07:23 +0000
Subject: [PATCH] ARM: Allow kernel unaligned accesses on ARMv6+ processors
In-Reply-To: <1d0610da-0dc0-4130-9d14-8524820b9846@WA4EHSMHS001.ehs.local>
References: <1320489687-9642-1-git-send-email-catalin.marinas@arm.com>
 <1d0610da-0dc0-4130-9d14-8524820b9846@WA4EHSMHS001.ehs.local>
Message-ID: <20111107170723.GD24887@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 07, 2011 at 02:11:24AM +0000, John Linn wrote:
> > -----Original Message-----
> > From: Catalin Marinas [mailto:catalin.marinas at gmail.com] On Behalf Of
> > Catalin Marinas
> > Sent: Saturday, November 05, 2011 3:41 AM
> > To: linux-arm-kernel at lists.infradead.org
> > Cc: John Linn
> > Subject: [PATCH] ARM: Allow kernel unaligned accesses on ARMv6+
> > processors
> > 
> > Recent gcc versions generate unaligned accesses by default on ARMv6
> and
> > later processors. This patch ensures that the SCTLR.A bit is always
> > cleared on such processors to avoid kernel traping before
> > alignment_init() is called.
> > 
> > Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: John Linn <John.Linn@xilinx.com>
> 
> It worked great, thanks Catalin. I'd love to see a solution merged in
> the mainline and this seems reasonable.
> I'm being pushed to newer tools which require a solution.
> 
> Tested-by: John Linn <john.linn@xilinx.com>

Thanks. I pushed it to Russell's patch system as:

http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=7150/1

-- 
Catalin
