From: bp@alien8.de (Borislav Petkov)
Date: Fri, 12 Aug 2016 07:22:17 +0200
Subject: [PATCH 1/5] arm/defconfigs: Remove CONFIG_IPV6_PRIVACY
In-Reply-To: <1769762.X0BZWCkYAE@wuerfel>
References: <1459338168-29334-1-git-send-email-bp@alien8.de>
 <4958578.R1lMSWqhcA@wuerfel> <20160811213521.GD10636@nazgul.tnic>
 <1769762.X0BZWCkYAE@wuerfel>
Message-ID: <20160812052217.GA12013@nazgul.tnic>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 11, 2016 at 11:51:38PM +0200, Arnd Bergmann wrote:
> That patch looks good, sorry I missed it. I see that Vladimir already
> did the lpc32xx portion of it, can you send the part for s3c24xx
> to the exynos maintainers?

I see you've added them to CC, thanks Arnd. Here it is:

---
From: Borislav Petkov <bp@suse.de>
Date: Fri, 12 Aug 2016 07:18:20 +0200
Subject: [PATCH] arm/s3c2410_defconfig: Remove CONFIG_IPV6_PRIVACY

Option is long gone, see

  5d9efa7ee99e ("ipv6: Remove privacy config option.")

Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: Kukjin Kim <kgene@kernel.org>
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 arch/arm/configs/s3c2410_defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/configs/s3c2410_defconfig b/arch/arm/configs/s3c2410_defconfig
index b3ade552a2a5..bc4bfe02e611 100644
--- a/arch/arm/configs/s3c2410_defconfig
+++ b/arch/arm/configs/s3c2410_defconfig
@@ -76,7 +76,6 @@ CONFIG_TCP_CONG_LP=m
 CONFIG_TCP_CONG_VENO=m
 CONFIG_TCP_CONG_YEAH=m
 CONFIG_TCP_CONG_ILLINOIS=m
-CONFIG_IPV6_PRIVACY=y
 CONFIG_IPV6_ROUTER_PREF=y
 CONFIG_INET6_AH=m
 CONFIG_INET6_ESP=m
-- 
2.8.4

> If you have larger chunks like CONFIG_INET_LRO removal, we can take
> that directly through arm-soc as a single patch for all defconfigs.

I'll leave that to someone who wants to get their feet wet with patching
the kernel - should be a simple task. :-)

Thanks!

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
