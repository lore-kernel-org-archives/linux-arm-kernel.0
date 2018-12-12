Return-Path: <SRS0=fRgi=OV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69BC7C65BAF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 19:07:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 248792084E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 19:07:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bGAsRK9A";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rB8yKHkY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 248792084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=eCAtz0GFqvNWXX0qb2NB7x3ejXOiywpYRcQZRt4qFuY=; b=bGAsRK9AtTQqC0
	U0f1qc15VhNQGk26mcqZLGcqKCcvclSCjGxrz1Xsz3k1cP0YLouPrKOG010WLWxT0fb1QQjhfGttN
	La902z8N3b8ONC1k27kOUBCzJ1DCyJOA7lXFOkckKWIUPfbx69JUWwwsOiglqw/Z9GNyZXSbBYadG
	pBqUknh5MFNKgl15H2Tv9TQfoz7NI7+68+IUX/4ogmpO6QPWEYXP/beI3FfZjxdhCrunKe8AgktsA
	VjgVhIwb1OWShJ0RYUC+feLDOc6XtP7u8NAc21ui6apdcy3WKcN7GVSB/HlhTgTGFIdB5HznKJFXZ
	OytcHMiwCV1bC9DF0nCA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gX9qU-0005ii-CZ; Wed, 12 Dec 2018 19:06:58 +0000
Received: from mail-ot1-x32f.google.com ([2607:f8b0:4864:20::32f])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gX9qQ-0005iK-P3
 for linux-arm-kernel@lists.infradead.org; Wed, 12 Dec 2018 19:06:56 +0000
Received: by mail-ot1-x32f.google.com with SMTP id i20so18749847otl.0
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 12 Dec 2018 11:06:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=rIq5QK9jegBt9FSp2PNDq7Cg1XdLQub9YDQaoD9jw5c=;
 b=rB8yKHkYybfhCbm5KtiTnhxGi7UHlGtb3yOCE88gaqR5yJRj8RayPLRxl41d/VM05v
 F/Ct027EuEdiLnzD0SEtVXJwa4HGfuJQUakzAtTGVrs6CuiiumBvEjbrb1jIur+Gf/tR
 7x0zTjDiwiB3Jp02XH9aPCDSCmqnyx8+mBN3vDoUqsHB9BixNBDpwtmMTuNpAN+fGzyz
 NFqU9/Z7JetraePJpjiyoLM9iPZVBg5Bp+M13Dt5Z3AmYltHvKbERayvbv0YTFk55ZC8
 YXSLG6GNEsskeK81vIopRDvgRILifgRZtO7u+4ZDyOzThFhasJL1+V/MKHzPKbPQvq9b
 HJBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=rIq5QK9jegBt9FSp2PNDq7Cg1XdLQub9YDQaoD9jw5c=;
 b=ZuyXFlFUJ1Jeb3Iu5sBBSEWDNQwNpuFiacTJ/qrxTSvXpwJ/7g6clFus4IXbQXcVgh
 dy6IK23m9bgbkJQm7qbN6sYbFtO7vqCtjTbQ9tzu4UtgMGh8FjXqlL+9/ut9ly0LV4SD
 juMmMCICyPXjljgrAIx6RJkiM70QFDSqXFiFO6VTSvzuxfwvVU5qqaHXmZJXQphcBwL+
 TURvIf/NKCiyhZTJs6V0cTiiRwHrvuuwi3qZ2aKFDbQNjYWl2+9wG61IpsQjI2O0tc7c
 vjyCopjPUq4txGtrLwMnVGd/0J4h2Am8BPukZFdO/Pyhq//JErJNwYSGxCxDIy6itfrQ
 1CPw==
X-Gm-Message-State: AA+aEWbjeb+j/40rb0oELCbH14w2zzNPmMiuhIL5gYVMtV8G/vVFONZP
 EO5UPxeOie8aMoCU1a46RYthMsktkSkEMMJ5upw=
X-Google-Smtp-Source: AFSGD/Wcn6Rj5bCCHTuWfGsmvpGuFM0Q8y8EjecPBOD0w6iFBLiJUWVk3Oxqo2gf3WoWnKJuDJP6xWuD2vFgrVfoxGc=
X-Received: by 2002:a9d:282:: with SMTP id 2mr14664883otl.287.1544641603035;
 Wed, 12 Dec 2018 11:06:43 -0800 (PST)
MIME-Version: 1.0
References: <201812121706.3s9Laseu%fengguang.wu@intel.com>
In-Reply-To: <201812121706.3s9Laseu%fengguang.wu@intel.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 12 Dec 2018 17:06:39 -0200
Message-ID: <CAOMZO5C=Yxi+VG4ux56aVcearhhNwuV7B3kN+EfXhJ4gZrMmOw@mail.gmail.com>
Subject: Re: [kbuild-all] [shawnguo:imx8mq/dt 14/19]
 sound/soc//fsl/eukrea-tlv320.c:28:10:
 fatal error: asm/mach-types.h: No such file or directory
To: kbuild test robot <lkp@intel.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181212_110654_837158_41E38F08 
X-CRM114-Status: UNSURE (   9.19  )
X-CRM114-Notice: Please train this message.
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
Cc: Abel Vesa <abel.vesa@nxp.com>, kbuild-all@01.org,
 Fabio Estevam <fabio.estevam@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>, Lucas Stach <l.stach@pengutronix.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Dec 12, 2018 at 7:23 AM kbuild test robot <lkp@intel.com> wrote:

> All errors (new ones prefixed by >>):
>
> >> sound/soc//fsl/eukrea-tlv320.c:28:10: fatal error: asm/mach-types.h: No such file or directory
>     #include <asm/mach-types.h>
              ^~~~~~~~~~~~~~~~~~

Would this be a proper fix?

--- a/sound/soc/fsl/Kconfig
+++ b/sound/soc/fsl/Kconfig
@@ -221,7 +221,7 @@ config SND_SOC_PHYCORE_AC97

 config SND_SOC_EUKREA_TLV320
        tristate "Eukrea TLV320"
-       depends on ARCH_MXC && I2C
+       depends on ARCH_MXC && !ARM64 && I2C
        select SND_SOC_TLV320AIC23_I2C
        select SND_SOC_IMX_AUDMUX
        select SND_SOC_IMX_SSI

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
