Return-Path: <SRS0=FFYW=O2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EA2CC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 17:19:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4BEEA2133F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 17:19:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="HMOvBIT5";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h3J5kLXL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BEEA2133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=vYDM+Ys2V6VQJlBWCKLkHNqKLsMhnwJzZDvVPTIGi/k=; b=HMOvBIT51F+sN0
	Vmyronfypn97v6hY7wB21ZO7mlFxrQKRm4LESN6eit6W91in+fFM1oncnfVD1gAVFmKTbTJkX1QbQ
	cGmz4VjzN6eebVRSaFi+9x+Vf/ququzI59N96p6xynu+LF7BSS+Nd3A0DYTfGeh9Z7lZtJdEmxHyX
	Bj/2/PKi9LXIx7b3lsnbnURTgLJHDCSJ7kF6gQcH1D2KLdPuRy+x4yQnsCjlmjqDqyZaWLdOlPF2T
	d66UdLlVUANyjsrzzOSmXxS04ZsQWtdEI4PpjSj28V1FxFASinLelTh1XgZjJcm/+Q24V2vqwD99n
	8YesEsDE0pYkcXDk3vOQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gYwXl-0001tm-NN; Mon, 17 Dec 2018 17:19:01 +0000
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gYwXi-0001sZ-5o
 for linux-arm-kernel@lists.infradead.org; Mon, 17 Dec 2018 17:18:59 +0000
Received: by mail-wm1-x342.google.com with SMTP id y139so13056342wmc.5
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 17 Dec 2018 09:18:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=kvrFg58Xr7iAG870iC1XAuJqs0RSBPPYSssQ5mYZXxo=;
 b=h3J5kLXLyG4YEqNDrWlYKIgTR7jr1V+sRY12WOWpzfeRJrS6riohdYo1B9ljvFfg3y
 PNENQkDoXNPA74fP/K8Lm8ozH9iWDXXLDNfiv1YsW3kDyZMPgBNxmQnoz2DKq3KKOIfV
 BcoDAMkpZjDgQfzUCwwl1Gz5lnL71Wqf3WPQn5pzVmXZqhCBl4+575YBpubSzvwGu905
 KrO9f1Twm/4HV7j/rvwJ/1l++hsQBxPW2Fl9AR/Wyc2SLefir1bauY5/m+i9xsmjnIvw
 w+ADBoTZinP585lTbGg4M7diXewzqugyuOlq8jHiP2jAa4zMhyXdoHOS9q3YyNh5hBlT
 u3LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=kvrFg58Xr7iAG870iC1XAuJqs0RSBPPYSssQ5mYZXxo=;
 b=K4nw0YSlWzzibrPGzDqHlQveqtg2O/OLJvl1W+/JQMT+ww7Ym32bxp+eZsi6vG1RNK
 0O3VL73H0M6n76F2CmatAap+gJMGKER+yLreEePRf2UkoYFNfBKaG0kBFIlQ+UnNWIMp
 Bkz1wJ2tvHJRC4ZtkH+ythJegmBRx91HWHyIspNAbcxbqmnddhb+/yWkUYBrjv2lt4WZ
 rvncH4nCedoTsaSRqZZ+Wfy+5dXEo6XUJYNM6yX4ve9HpymX1X8e6igLX+8mlquG/8QM
 l4CVNZhv7lHyunpsSZywMPR+HmisT2nSZDcpdHq7FuSss+xsc1aWPNFYIAhG0MmFOPgb
 NVKg==
X-Gm-Message-State: AA+aEWa7d24AqjqfaOuMob7DhSQwGd9TeFPTMIjTVz7j8E4JFqce9MeS
 U1McDerROAM14dRxeL5JBAJLV88oZQHFNHtChxg=
X-Google-Smtp-Source: AFSGD/UKs/hdAbRBRBaOpV1wODw4xv0GWd5eBW79CPX2dWIkg7rWWmPQpVgmnHx+ftNSuxNfbkf3B5NZcoBqQyxsPLs=
X-Received: by 2002:a1c:c10f:: with SMTP id r15mr12584685wmf.27.1545067125966; 
 Mon, 17 Dec 2018 09:18:45 -0800 (PST)
MIME-Version: 1.0
References: <20181216230916.22982-1-andrew.smirnov@gmail.com>
 <20181217110028.GA14261@e107981-ln.cambridge.arm.com>
In-Reply-To: <20181217110028.GA14261@e107981-ln.cambridge.arm.com>
From: Andrey Smirnov <andrew.smirnov@gmail.com>
Date: Mon, 17 Dec 2018 09:18:34 -0800
Message-ID: <CAHQ1cqGoMV1EF2kpATvdp=bYueYM5MRSV+Lstf+gv-SZDEWRYw@mail.gmail.com>
Subject: Re: [PATCH 0/3] Fixes for "PCIE support for i.MX8MQ"
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181217_091858_220966_45D8BDC9 
X-CRM114-Status: GOOD (  13.00  )
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
Cc: "A.s. Dong" <aisheng.dong@nxp.com>, Richard Zhu <hongxing.zhu@nxp.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 linux-pci@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>,
 Fabio Estevam <fabio.estevam@nxp.com>, dl-linux-imx <linux-imx@nxp.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Leonard Crestez <leonard.crestez@nxp.com>,
 Chris Healy <cphealy@gmail.com>, Lucas Stach <l.stach@pengutronix.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Dec 17, 2018 at 3:01 AM Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
>
> On Sun, Dec 16, 2018 at 03:09:13PM -0800, Andrey Smirnov wrote:
> > Lorenzo:
> >
> > These are patches fixing things pointed out by Bjorn in [1] and [2] as
> > well as something I noticed while giving pci/next branch a try (#endif
> > placement). Hopefully this is at least somewhat helpful.
> >
> > Thanks,
> > Andrey Smirnov
> >
> > [1] lkml.kernel.org/r/20181214203828.GD20725@google.com
> > [2] lkml.kernel.org/r/20181214203042.GC20725@google.com
> >
> > Andrey Smirnov (3):
> >   PCI: imx6: Fixup Kconfig and #endif placement
> >   PCI: imx6: Invert checks in imx6_pcie_reset_phy() and
> >     imx6_setup_phy_mpll()
> >   PCI: imx6: Make fallthrough comments more consistent
> >
> >  drivers/pci/controller/dwc/Kconfig    |  4 ++--
> >  drivers/pci/controller/dwc/pci-imx6.c | 29 ++++++++++++++++++---------
> >  2 files changed, 21 insertions(+), 12 deletions(-)
>
> Andrey,
>
> please follow-up Lucas' remarks and submit a self-consistent patchset
> that I can apply on top of my pci/dwc branch (where I removed your
> previously queued patches).
>

Sure, will do.

Thanks,
Andrey Smirnov

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
