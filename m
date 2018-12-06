Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02D83C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 13:11:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9A7820838
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 13:11:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Jk2y0+B5";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IC17rHMQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9A7820838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=GlyVBkfomVgdBGd6ztJM9MNjzd7fZ/E9NTDYvWOD8nQ=; b=Jk2y0+B53xmFTd
	BhzduxpiS8LI8UwakaZ4BsgfzOzJcCrNunrrdiYFYLpMgel77tSnT1TTFUgk4MugCV6AATG4XxoCl
	yKNmMhEYrGj+e5H8g7hEDUAMHXUrCGTIkqO3v8JEnIlA56gZBPZwabJcnLgsPf+7QCz+k4frq82tr
	S4nEfrg4bYmY2EcCe35CkU7wiNy0zZMNkZHoeAt31+0Xrr+QoUBTWPz8o1V/tJ14wwIqQQ6wltFnx
	MYA3S2jtWXdqdJ9erpZnUrmxgjXk+8QeagMzvFeS2H8CzjPOgiyE5hNt50dXnlJvWqCVA2mcRGdxq
	xmtdJVOk7MHlafayqrXQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUtR8-0005Vj-7q; Thu, 06 Dec 2018 13:11:26 +0000
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUtR5-0005Uc-IX
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 13:11:24 +0000
Received: by mail-ot1-x344.google.com with SMTP id 40so340342oth.4
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 06 Dec 2018 05:11:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=JYAP0FDf9YNBMWgdORmXDMVVswMNNb05wRSae/tf3Nw=;
 b=IC17rHMQEVLCEVVTTDSzu+FUITmT7NEzuxxM7SC5V2CPaXRIFAjZf38gAc5WPopOAp
 QkK5b5HwPsewOIpMZ+BAkL9+DInqfbNistu9DP5s6v1E8ueVV4hF3nZSk+ZZ7gbe+4Ol
 HzfY/v7nlD08H/+mrckcPtNTN1ClP8pDLJNWfDtcySFGyJ9aJxs0GxECFTOslICpxlyM
 CxUaeLxcSDJc6QZxayjuMx+Gbj4mrKU+FsDXyiSsztLBE7vAoRvPbNrdYdMc1ITxGxsb
 vfwAMvC8cMR8vleILmnLdvoAO4IOsPg1RqfWIC9vu2CDEC/+EtB3+lLEJ6CyJeYgaiqh
 fn2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=JYAP0FDf9YNBMWgdORmXDMVVswMNNb05wRSae/tf3Nw=;
 b=o9gbxZBrF+tRAz7qSEz4LzZi5wwX4ajO8m71NiIk1cCEDqlr6cWICIgXFTQjCTn/5d
 4wzJ54HYA1iLYmfYQPVQ8a4KTP2IlLttG2gU4Um7VEKAjaFAOWOcsIWbrm130nIDHXbV
 4ujpFBTtt7gvZNk8r2k3B2U6yLWOqiceJ1nJHPUvow+N3aumVLqoPRS+wh9f+to3F+eP
 den+Bvo00aoGMfR6NXGKFDIzliBHm94epBtcsyEpidnKpXrElOjAuVlO2ruGzADroeJ1
 XmYQthXwhF75W3Vc/KmebR/mziVgUcd46vHOQNyh5593M1azEKhM5Lv5tg17xD5xK46D
 Thjg==
X-Gm-Message-State: AA+aEWYg7lLP12qfbOsS9z/EturTCyQY/cv2/hUFRZ0YK6zF5RcMBJUN
 l2M86NVkSFGkzj6TA5GP+t0X8Dk9MVw9JTvus7U=
X-Google-Smtp-Source: AFSGD/VC104wpPGlWUD6WBJPfNqXxgq8NYycDkUGHv3QStJQA1mDiAw8+87WEC2RTo04a52san2E6+f+xPSD0vOduEA=
X-Received: by 2002:a9d:84e:: with SMTP id 72mr18659071oty.203.1544101872568; 
 Thu, 06 Dec 2018 05:11:12 -0800 (PST)
MIME-Version: 1.0
References: <20180921152726.31742-1-lukma@denx.de>
 <20181009105028.17971-1-lukma@denx.de>
 <CAOMZO5BN5KJ+s6F9CJXQPX=Ta0Ow0PaV_AmFHYSDNr78jLjziQ@mail.gmail.com>
 <20181206092255.2359f7e6@jawa>
 <CAOMZO5CE2ei-Pu-85zpYHTg-MamMT3DahLxBHNFjX4uLEi1XWg@mail.gmail.com>
 <20181206140840.53d49cd6@jawa>
In-Reply-To: <20181206140840.53d49cd6@jawa>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 6 Dec 2018 11:11:02 -0200
Message-ID: <CAOMZO5CUfN7uLf7bsw6Xg4+TNrRYodw11Ekg5ypqyXU6q-UFtg@mail.gmail.com>
Subject: Re: [PATCH v3] ARM: dts: Add support for Liebherr's BK4 device (vf610
 based)
To: Lukasz Majewski <lukma@denx.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_051123_624525_9E14E8E3 
X-CRM114-Status: GOOD (  10.45  )
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 linux-kernel <linux-kernel@vger.kernel.org>, Stefan Agner <stefan@agner.ch>,
 Rob Herring <robh+dt@kernel.org>, Sascha Hauer <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Lukasz,

On Thu, Dec 6, 2018 at 11:08 AM Lukasz Majewski <lukma@denx.de> wrote:

> I will check this latter this week...

Reading the spi dt-binding it states that the spi slave node is optional.

If I remove it like this, then the warning is gone:

--- a/arch/arm/boot/dts/vf610-bk4.dts
+++ b/arch/arm/boot/dts/vf610-bk4.dts
@@ -109,12 +109,6 @@
        bus-num = <3>;
        status = "okay";
        spi-slave;
-
-       slave@0 {
-               compatible = "lwn,bk4";
-               spi-max-frequency = <30000000>;
-               reg = <0>;
-       };
 };

 &edma0 {

Does spi slave still work without it?

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
