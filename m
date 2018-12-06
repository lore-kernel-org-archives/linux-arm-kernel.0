Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3773EC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 13:06:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0692B20838
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 13:06:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="PtomCcTB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0692B20838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=78aWmBwxa71T9mNUaRi1+31UN8eYYu/Z7P2cPIuHe2c=; b=PtomCcTBe3EKJU
	vOmey9vB+Yio7ngrZjy8AUzNDji8iCGVBolHvnPDjGMP8BEzQmDzmiSPhlOwPq34KC1pnHIoaQUVE
	bEa/u8Z4JFKqUURrxVvM+Z25wPhQXyH1oEEFqNkc6cwQEpbNyf4xrbaRD3Pz5khb8q5X12sDFdRN5
	y0YQ9Wn1PCpgUdM5V3mHixx6miUScWdatDrEsEEtdsflRCFDsOrD1s/WNUHX35m3ZmZcllFaFjXjl
	fTyi7BCIa6TwbkpMGBFKm70cTPWnmyX+S+/g4Jb33dhLfY9rGxWItmZFrC0qPaZBRO+ECUA8qpu5c
	dAo42AfG9mgkURPQUr+g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUtMX-0003cn-C6; Thu, 06 Dec 2018 13:06:41 +0000
Received: from metis.ext.pengutronix.de ([2001:67c:670:201:290:27ff:fe1d:cc33])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUtMU-0003c0-A3
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 13:06:40 +0000
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
 by metis.ext.pengutronix.de with esmtps
 (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.89)
 (envelope-from <ukl@pengutronix.de>)
 id 1gUtMB-0000DV-L0; Thu, 06 Dec 2018 14:06:19 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.89)
 (envelope-from <ukl@pengutronix.de>)
 id 1gUtM9-0004IO-HC; Thu, 06 Dec 2018 14:06:17 +0100
Date: Thu, 6 Dec 2018 14:06:17 +0100
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
To: kbuild test robot <lkp@intel.com>
Subject: Re: [shawnguo:imx/soc 2/2] arch/arm/Kconfig.debug:1445: syntax error
Message-ID: <20181206130617.c3x353tgwyxjszc4@pengutronix.de>
References: <201812062028.Xnf6p6GZ%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <201812062028.Xnf6p6GZ%fengguang.wu@intel.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-arm-kernel@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_050638_509639_C6D57FE3 
X-CRM114-Status: GOOD (  11.41  )
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
Cc: kernel@pengutronix.de, Shawn Guo <shawnguo@kernel.org>, kbuild-all@01.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hello,

On Thu, Dec 06, 2018 at 08:44:30PM +0800, kbuild test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.gi=
t imx/soc
> head:   911dccedb00e5b45cf2d0fafc21aba233b58e115
> commit: 911dccedb00e5b45cf2d0fafc21aba233b58e115 [2/2] ARM: debug-imx: on=
ly define DEBUG_IMX_UART_PORT if needed
> config: arm-hackkit_defconfig
> compiler: arm-linux-gnueabi-gcc (Debian 7.2.0-11) 7.2.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbi=
n/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         git checkout 911dccedb00e5b45cf2d0fafc21aba233b58e115
>         GCC_VERSION=3D7.2.0 make.cross ARCH=3Darm  hackkit_defconfig
>         GCC_VERSION=3D7.2.0 make.cross ARCH=3Darm =

> =

> All errors (new ones prefixed by >>):
> =

> >> arch/arm/Kconfig.debug:1445: syntax error
> >> arch/arm/Kconfig.debug:1444: invalid option

hmm, I was sure I tested that, but I can confirm it fails for me, too.

The obvious fix is:

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index 3f057593db01..c253a4e79868 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -1441,18 +1441,18 @@ config DEBUG_OMAP2PLUS_UART
 =

 config DEBUG_IMX_UART_PORT
 	int "i.MX Debug UART Port Selection"
-	depends on DEBUG_IMX1_UART ||
-		   DEBUG_IMX25_UART ||
-		   DEBUG_IMX21_IMX27_UART ||
-		   DEBUG_IMX31_UART ||
-		   DEBUG_IMX35_UART ||
-		   DEBUG_IMX50_UART ||
-		   DEBUG_IMX51_UART ||
-		   DEBUG_IMX53_UART ||
-		   DEBUG_IMX6Q_UART ||
-		   DEBUG_IMX6SL_UART ||
-		   DEBUG_IMX6SX_UART ||
-		   DEBUG_IMX6UL_UART ||
+	depends on DEBUG_IMX1_UART || \
+		   DEBUG_IMX25_UART || \
+		   DEBUG_IMX21_IMX27_UART || \
+		   DEBUG_IMX31_UART || \
+		   DEBUG_IMX35_UART || \
+		   DEBUG_IMX50_UART || \
+		   DEBUG_IMX51_UART || \
+		   DEBUG_IMX53_UART || \
+		   DEBUG_IMX6Q_UART || \
+		   DEBUG_IMX6SL_UART || \
+		   DEBUG_IMX6SX_UART || \
+		   DEBUG_IMX6UL_UART || \
 		   DEBUG_IMX7D_UART
 	default 1
 	help

@Shawn: Can you squash this into the original commit?

Best regards and sorry for the breakage,
Uwe

-- =

Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
