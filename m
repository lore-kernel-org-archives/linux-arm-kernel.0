Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67C2FC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 20:48:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33C852084C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 20:48:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="t+iZ/TX1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33C852084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=tdGsE+dWpVPGmddEAI46errnu0Eti94k5mxn8eYwaaY=; b=t+iZ/TX1HVZjec
	OoF+tExcOUn4aopT0xC5e+i+Rzy3ZMjh07AFl5WzjA0jKE1mcjqXRWnfZSBnuZTpq6bX3ycOwNMol
	fQrMazHAaDISswTTJ+kI45o5IJpT0EYsLWMsMPgf2kvC8RolFc3KpJTprJO6/u+O8s3hHVxkU0J0/
	FqGQ58F+vHCeOO5JnnfZ35yYyfi3r9Wt2b4IXYeUAxX4dIQPSSP4LbdNYdpNmU7ZwSFy+wqT1kBYs
	pdPkDU/WoWbtmThFK12ma+gE2j3rKomMZ+Lg60T7t+kANlM09Ssov05pBdzWCkwUsGDz/0RU/ADit
	vvC1NAnfoBPbl2nKqHUQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWSTm-0001jS-QF; Mon, 10 Dec 2018 20:48:38 +0000
Received: from mout.kundenserver.de ([212.227.126.131])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWSTi-0001i1-Rr
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 20:48:36 +0000
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MNtGq-1gqBDO1Ho0-00OELJ; Mon, 10 Dec 2018 21:48:18 +0100
From: Arnd Bergmann <arnd@arndb.de>
To: arm@kernel.org, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH] ARM: imx: fix dependencies on imx7ulp
Date: Mon, 10 Dec 2018 21:47:59 +0100
Message-Id: <20181210204816.2516007-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
X-Provags-ID: V03:K1:/5qOA8hnrs1Q/kzShLRmAfQuhrtQHTybSSKRZpUWS1xzy0VKbI3
 OsS/f+NxMT+PpMq7KI/+w551uRUVFfvbEwGK5fH2DrATqHnapVHNAXGlbsDXkn8Qj0Pyija
 UpcXDb2eyR5jbdOKas1rA6BMyD+ux6Yhk3uPlTE9hCBkewQ0FiuxbZfEM/9fVO24YXYwzYm
 SWudopuCt0jlBNt5OOBMA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:VAJt8o1f5b8=:L/NgnzfoM/vNh5darJ+Ke5
 YlZgQz/NZsyQxK4lNkvCE/krOQPRimxZ4I19YeyPR5T4JlFt7R60MKPgiHZFNH5DW95iAA9oG
 q+IGc48qWCKwK8K/1+GRtbYPxa+WGW2R8QP0vYFfM1ehh3Ki/u94NLCJxqxF3jwylKdRhI8FS
 A/HFvcD05h9xgyhunLNeznkC5HJUA5asVu8LKpiuGm5HHMFrOFL1nTNcZS0y8MMjnebaiYnfp
 Neji3aTmpIY0cPAeYpnKWJVNYH0zMv++cbUoGZEgexJ4Ol2wn8uUX83caG4xebor/7q3VhmkE
 GcTepV+PqXFiR0GHmFuXkgDKJVv0i2+rP849XI3WzGOf57GOkwOP2LH3MOLFAYU3fyx2hmUtX
 GinhVS7CDU51aLkZIqXTUJ3Z5ghUiVI93vwT1dm2is61bYLPQRrWB77pH/HIsRcSz/ddOEVAb
 f2/4ZKp3uZJv9CNbRoR2JSgp5TzKio4CllGMg0+dH7+8xBJ9Z9c4GbOMgWGFmgVD4spYELySR
 QoxjXdDXrfdqvsFo5EZ864hcS/lBpuzg9xF0PeOQ91JKWp8FrH7pUA8em56gkpyr2mWEBxBet
 GudzzUHAQafP4GOdttCCISR4bdcSFMq1h0WknJ1MIxq+BwxY+c18Pr2MgaMQXEkpm0Tt0y7lY
 L0aTFIuH9hi4V2ddKcw4O9vzNyfLPy+zGMWu9+Is1ACKfzVY/aw0auJIa4bf/6O8J1H2ooNZ0
 oblev9ajQbyiaX31xAgrIgTily7maLiXvS8Kng==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_124835_203117_CCB56E96 
X-CRM114-Status: GOOD (  11.66  )
X-BeenThere: linux-arm-kernel@lists.infradead.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-arm-kernel.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: "A.s. Dong" <aisheng.dong@nxp.com>, Arnd Bergmann <arnd@arndb.de>,
 linux-kernel@vger.kernel.org, Oleksij Rempel <linux@rempel-privat.de>,
 NXP Linux Team <linux-imx@nxp.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>, Fabio Estevam <festevam@gmail.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The i.MX7D configuration was reworked, but that change did
not get propagated into the newly added i.MX7ULP, which now
produces a Kconfig warning:

WARNING: unmet direct dependencies detected for HAVE_ARM_ARCH_TIMER
  Depends on [n]: CPU_V7 [=n]
  Selected by [y]:
  - SOC_IMX7ULP [=y] && ARCH_MXC [=y] && (ARCH_MULTI_V7 [=n] || ARM_SINGLE_ARMV7M [=y])

Change it to work the same way as i.MX7D.

Fixes: 1a1f919eb52e ("ARM: imx: Provide support for NXP i.MX7D Cortex-M4")
Fixes: acb83c0eb036 ("ARM: imx: add initial support for imx7ulp")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-imx/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index c12a05cbf268..9b8d4d6aa763 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -560,10 +560,10 @@ config SOC_IMX7D
 
 config SOC_IMX7ULP
 	bool "i.MX7ULP support"
-	select ARM_GIC
 	select CLKSRC_IMX_TPM
-	select HAVE_ARM_ARCH_TIMER
 	select PINCTRL_IMX7ULP
+	select SOC_IMX7D_CA7 if ARCH_MULTI_V7
+	select SOC_IMX7D_CM4 if ARM_SINGLE_ARMV7M
 	help
 	  This enables support for Freescale i.MX7 Ultra Low Power processor.
 
-- 
2.20.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
