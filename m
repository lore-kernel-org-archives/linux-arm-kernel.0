Return-Path: <SRS0=FIMe=QE=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32392C282C8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 12:36:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF26220880
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 12:36:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Tb36WOuL";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="O3rM4aou"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF26220880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:Message-Id:
	In-Reply-To:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	References:List-Owner; bh=XqgZ36t8WAeZ1wmEfn7/2JO54B7mBIBIuXhJ3W3Pka4=; b=Tb3
	6WOuL3s/5wsOsnUg2kfNDkmm/cvI4yRWT8q8jjtHwsHyMgZ/y5AaWA6E245rUBS75rajI8mKpm3af
	59REto6rsFlXqoaTIXz6aeIzcqU2NPTyWamNlmKe4I+OmkHX/f/8REmnR6d1mqtbqLkaJpht4vauy
	hR51C4ZzOA2q0Wt0srZ6ZuA4B3jupbOpMrRx8n3glUtyoizlkP9AZFPMWpLxxBbFMRtschxOxUat5
	FIGGEGmO+r7gJ4tOF8IPZLJl+YsyFMc0UMPoNBP2N9Y+BwbyBpNs4s9DOWcdbBmSvJ2skLGh7VHi1
	Zonn3vq386/R58i+WTOWNkXkOWsYw5A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1go69D-00080C-9W; Mon, 28 Jan 2019 12:36:19 +0000
Received: from heliosphere.sirena.org.uk ([2a01:7e01::f03c:91ff:fed4:a3b6])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1go699-0007z1-6h; Mon, 28 Jan 2019 12:36:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
 Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
 List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
 List-Archive; bh=ssq7PrBnwKvktPZbjkTclsAqRfHWNYmxUlpKAfHPHjE=; b=O3rM4aousyjW
 atyGti837Tacwol4KD/l6Nn6t+HRYBmDn0agJpa5bFJiXN+rOOvpSTiB21RdKI+LFU7MT3nJsgEk7
 xjCTGkmMsCN6t5w0eljbuG7DaqG/uOE9VLFjMYlnes4cQkrgLr2w/qblSrAvKMPrN6a2yAbzSbPwQ
 JiSGE=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net
 ([82.37.168.47] helo=debutante.sirena.org.uk)
 by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
 (envelope-from <broonie@sirena.org.uk>)
 id 1go695-0002U8-M4; Mon, 28 Jan 2019 12:36:11 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
 id 2F8641127D29; Mon, 28 Jan 2019 12:36:06 +0000 (GMT)
From: Mark Brown <broonie@kernel.org>
To: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
Subject: Applied "MAINTAINERS: add maintainers for the NXP FlexSPI driver" to
 the spi tree
In-Reply-To: <1547553487-9936-6-git-send-email-yogeshnarayan.gaur@nxp.com>
X-Patchwork-Hint: ignore
Message-Id: <20190128123606.2F8641127D29@debutante.sirena.org.uk>
Date: Mon, 28 Jan 2019 12:36:06 +0000 (GMT)
X-Bad-Reply: In-Reply-To but no 'Re:' in Subject.
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190128_043615_415238_10078358 
X-CRM114-Status: GOOD (  10.52  )
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
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "bbrezillon@kernel.org" <bbrezillon@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "frieder.schrempf@kontron.de" <frieder.schrempf@kontron.de>,
 linux-spi@vger.kernel.org, "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
 "broonie@kernel.org" <broonie@kernel.org>,
 "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
 "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "robh@kernel.org" <robh@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The patch

   MAINTAINERS: add maintainers for the NXP FlexSPI driver

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

From c71f9fd4503addcfa306f9bec95c3e7deade7ce1 Mon Sep 17 00:00:00 2001
From: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
Date: Tue, 15 Jan 2019 12:00:37 +0000
Subject: [PATCH] MAINTAINERS: add maintainers for the NXP FlexSPI driver

Add maintainers for the NXP FlexSPI driver

Signed-off-by: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8b6c0d454d7e..5e7ec7cda3bb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10927,6 +10927,14 @@ F:	lib/objagg.c
 F:	lib/test_objagg.c
 F:	include/linux/objagg.h
 
+NXP FSPI DRIVER
+R:	Yogesh Gaur <yogeshgaur.83@gmail.com>
+M:	Ashish Kumar <ashish.kumar@nxp.com>
+L:	linux-spi@vger.kernel.org
+S:	Maintained
+F:	drivers/spi/spi-nxp-fspi.c
+F:	Documentation/devicetree/bindings/spi/spi-nxp-fspi.txt
+
 OBJTOOL
 M:	Josh Poimboeuf <jpoimboe@redhat.com>
 M:	Peter Zijlstra <peterz@infradead.org>
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
