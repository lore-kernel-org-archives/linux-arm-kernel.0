Return-Path: <SRS0=cUnb=OQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79749C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 02:44:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 459872146D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 02:44:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dMDWPR6B";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SJGT/7VV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 459872146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=EGWD0AWCHWATQu4y7gh9Poz6uIlJRTNNGk17KH44tM4=; b=dMDWPR6BR8pu4P
	y870SlwaOmVC8dwZNCDNPApZm2OgtPwGqeDZHjz5gxYBp/lpU3rCXQO4MVlzCagMFPZE2upBjRbGt
	4ZCE+TEY3rH7ctn6Zz4KEIGRnN5285Bme3lWpFcqJtwbeEC/q5Y7+Bva2iAxpyqOjJJfEpFa0ocXC
	u5S3DGBqkzJy5K7T2WFc/U1zAQNn2LKlQ2eP4LHl6qROVgEp+0hZf1VDkxTfUlmj1aeTnnwSkdgSt
	5oXRcuOdJJUV7n6sahpr/D2F0xFM/BrlTy5ud12J1XAtZkulpJgGX+vR3wDt2blNk0w5qLx3z/vXI
	8WG85Pq2lyzT94FACvXg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gV68C-0006ih-V4; Fri, 07 Dec 2018 02:44:44 +0000
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gV685-0006hj-FE
 for linux-arm-kernel@lists.infradead.org; Fri, 07 Dec 2018 02:44:41 +0000
Received: by mail-wr1-x442.google.com with SMTP id z5so2354589wrt.11
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 06 Dec 2018 18:44:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=tU8RiHm05P1blXk/OPWBMPtrN8U4nIicFpULcBRTdYQ=;
 b=SJGT/7VV7VhXQ/z0IEc1ukMq/+p/9IeKvBeQDSbT1SrgP673ATh0cDHCU254NzjpCs
 RQOpk5oevNqTplLdUntfnBu/uHAO63PL9DVKuuwHHzMFQ/G3gMwLXxzLr5CwhI0EZeno
 ANV8dORTFf/8ybCcPmOzU9xv1F+R6NIinx6RDl8y1yXk5U/4LtJyv62WCpKerXjFszbD
 FZYQGTQ6YgOaS0eQLt6vgGKwhPQ4q9bE0TMBtbdC2pdYsZI92HubwU2fyc2Wl4I4aPsW
 T5aTnkUzmBPIS/DEqYS61NhO8JaBnDYwRGM6XaK/MoSYHAUnZhrvNVfubmmCG6xRoZbU
 WGSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=tU8RiHm05P1blXk/OPWBMPtrN8U4nIicFpULcBRTdYQ=;
 b=oJcA3oXler8Sc4pwWGOI+fnNyD61sHpEVPKNVRk5hPQUt5lnIyR5vUFhLfTp5Di73/
 1qpBY6o/Nhm0MFIebnRHEFLEGBd8fJ2DIqNU1RJCjiVWEmK+ztcwrTZd2DR1GYvjNE3O
 AcYnJYeCKkydpvupoAr4ewDZdwFTwdcz6RQIcgvObiP0WZt52rS8oifIRYi/vojlTtpv
 hvP3qszZJI/vbIn1MxNpbHEBz9LA+z4Z3AL1O2SzKUtNOgvNM60rg58FGk1QPxU0gzRu
 F96nixTqNf0JISAjXPCGMQLJxDqjRnQwvDzVC2LeYpg9ZEEYuYaEpG2fUgHJGtzB9joZ
 Npig==
X-Gm-Message-State: AA+aEWbEQVVTRnzXR2cZ/WhOKtG6b8Mu4nQRrqEm4aEuTpLc+4pB49vz
 HWCaa0Q6qpgkL80MBsmzcDjB3Sgv5nMTyBVGZSs=
X-Google-Smtp-Source: AFSGD/XZS8RVwHvM8u7WkQqbK14kEfizMmkJwIFCq4EqhCeIvSkd3cZSukJnW0P2LGAsuDXcqxg3/gWNn6GcSN1AVXk=
X-Received: by 2002:a5d:4b01:: with SMTP id v1mr305977wrq.5.1544150662555;
 Thu, 06 Dec 2018 18:44:22 -0800 (PST)
MIME-Version: 1.0
References: <20181206073545.10967-1-andrew.smirnov@gmail.com>
 <20181206121550.GA2725@e107981-ln.cambridge.arm.com>
In-Reply-To: <20181206121550.GA2725@e107981-ln.cambridge.arm.com>
From: Andrey Smirnov <andrew.smirnov@gmail.com>
Date: Thu, 6 Dec 2018 18:44:11 -0800
Message-ID: <CAHQ1cqHVjNTQrHi2BgR9k74hKD8Wh93FqMoeZPmNEhGWnEmdjQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] PCIE support for i.MX8MQ
To: lorenzo.pieralisi@arm.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_184437_512981_774E755A 
X-CRM114-Status: GOOD (  16.69  )
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
Cc: Dong Aisheng <aisheng.dong@nxp.com>, Mark Rutland <mark.rutland@arm.com>,
 Richard Zhu <hongxing.zhu@nxp.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Fabio Estevam <fabio.estevam@nxp.com>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, linux-imx@nxp.com,
 Bjorn Helgaas <bhelgaas@google.com>, Leonard Crestez <leonard.crestez@nxp.com>,
 Chris Healy <cphealy@gmail.com>, Lucas Stach <l.stach@pengutronix.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Dec 6, 2018 at 4:15 AM Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
>
> On Wed, Dec 05, 2018 at 11:35:42PM -0800, Andrey Smirnov wrote:
> > Everyone:
> >
> > This series contains changes I made in order to enable support of PCIE
> > IP block on i.MX8MQ SoCs (full tree can be found at [github-v2]).
> >
> > NOTE: The last patch have a Kconfig symbol depenency on [imx8mq-kconfig].
> >
> > Changes since [v1]:
> >
> >  - Driver changed to use single "fsl,controller-id" property to
> >    distinguish between two intances of PCIE IP block
> >
> >  - All code pertaining to L1SS was dropped to simplify the patch
> >
> >  - Documented additions to DT bindings
> >
> > Feedback is welcome!
> >
> > Thanks,
> > Andrey Smirnov
>
> Andrey,
>
> I have applied the patches, I would like to make the CC list in standard
> format so I kindly ask you firstname/surname for cphealy@gmail.com, I
> could not find it in the maintainers list but I want to keep the CC
> list as per patches (I removed the lists, though).

Oh, sorry about that! That would be Chris Healy <cphealy@gmail.com>.
Let me know if anything else is needed.

Thanks,
Andrey Smirnov

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
