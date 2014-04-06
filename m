From: gilles.chanteperdrix@xenomai.org (Gilles Chanteperdrix)
Date: Sun, 06 Apr 2014 23:12:49 +0200
Subject: [PATCH] arm/igep0020: fix IGEPv2 boot
In-Reply-To: <CABxcv=k3nrhVtMPw1BqO6Cz07VEtGA9ZBMvkXBJuLrcCSoXpwg@mail.gmail.com>
References: <1396801938-24788-1-git-send-email-gilles.chanteperdrix@xenomai.org>
 <CABxcv=k3nrhVtMPw1BqO6Cz07VEtGA9ZBMvkXBJuLrcCSoXpwg@mail.gmail.com>
Message-ID: <5341C351.5060406@xenomai.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/06/2014 10:04 PM, Javier Martinez Canillas wrote:
> Hello Giles,

Hi,

> It looks suspiciously similar to an issue we had due some DT clock
> changes were the IGEPv2 (or any board that used the "ti,omap3"
> compatible string) were initialized as omap3430 instead of omap3630
> thus using omap3430 clock data which left the UART4 uninitialized.
> 
> I fixed that particular issue on commit fb0cfec ("ARM: dts:
> omap3-igep: fix boot fail due wrong compatible match") which was
> merged on v3.14-rc6 so it should be on your v3.14 kernel so maybe is a
> different issue.
> 
> I wonder why you are having this issue though since I didn't have that
> problem with 3.14 as far as I can remember.
> 
> Can you provide me the exact commit id of your HEAD? or is just the
> tagged v3.14 commit?

It is the tagged v3.14 commit, with omap2plus_defconfig configuration
My IGEPv2 does not have an omap3630, but a 3530.

The boot logs say:
[    0.000000] OMAP3430/3530 ES3.1 (l2cache iva sgx neon isp )

Regards.

-- 
                                                                Gilles.
