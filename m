Return-Path: <SRS0=SkGj=QN=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8F31C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 11:49:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94BDB20B1F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 11:49:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="pEIBfZ8E";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="Q8ntOt8U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94BDB20B1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ePTife5LeOhlCRuVB1DxnnG6V1vfoPUIJ0bYoabAla4=; b=pEIBfZ8ELxYuZ7
	/olsmKoKEqnzZ4tIcy/Tm3pSaPgsJ/oQsPRjFwrX8MguGDBAlBm324usaTHwx39iaI1g8RAqWPGST
	QGcR0K19bq338kTf6BGtSOl0vljRq5w2dnjn8rCnZQLgr6QpPdDOyowTSaXCNaG+2C9bG1D7xKPLz
	43wAwHTtfrVPgjPYrjuWhJ7I91EFO7zrxiktuKKy2OFotbHNnzbdL4LKu47WjSUlckD0ApnnNFz1r
	AFgJOiqn4XiXAKO58IsUzo2c5kcLyfr1ZGuYv8tD9zRu51FyH26347wUGe6+Ht1OgUqEvmV6wo0CY
	/9DG6e1DrIn84LP4RMTg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grLhI-0005SD-DM; Wed, 06 Feb 2019 11:48:56 +0000
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grLhE-0005Ro-Vf; Wed, 06 Feb 2019 11:48:54 +0000
Received: by mail-ot1-x341.google.com with SMTP id n8so11327870otl.6;
 Wed, 06 Feb 2019 03:48:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=qgeG3H8iKjqR+ebBuNVpZfVZyCIFGNkh3b7zLCbwooQ=;
 b=Q8ntOt8UN/jh1ta19T9i3MRQDW+ANz+jn7I6iPzyH4wBsAI/UMOOppB7rkukuL1lbr
 eXaqevgG/rWzoecqS/MpJxBMF9OyF3yH4rrjqtJYorNNYVfihKtl0A6ne20HaIrmYGro
 9gBxthdWjYaRTj3lUumTGCgocARuM1qIGlHddml1BW18Mwe1L1mOg748bya5E2bph83W
 0MZOhM5Rw+Qs85M2hSQjIESd+fWgTt8cnPARozOCnHYOXd18QgaAgdYs2eOOeXU3tbnE
 moiluWXIFYsyHiB8fb/LixdD+Osb97ySuTTN4ry1Kb0bvEOBgRTeV9KNUtzJ2oYlnB4u
 V9xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=qgeG3H8iKjqR+ebBuNVpZfVZyCIFGNkh3b7zLCbwooQ=;
 b=DXpUPe3043ZTWAp0GLzpR8rBp24Dc3Kr1oqzd1p/2zdGTsUWr6Pcsu1PDWWLom7SYp
 fWz9gudoeC0sfXt++KUEPlGo6UWaKumwNNTD93wr7c0NZNeyOb3AEfPtuo+qQvq0IW/b
 PmeZ5LQwMG1ebJXvhDpQqpxZXcsTpOGnvAaFwtb3fZYezPNuACM9LD27itHJELSWAN8e
 UZOipAhlMJgTuiaUnLwJtObIj/E/QbN+/MdickN+IFs+UwH1SP1l9GNYduyWDzB02vYx
 7InnIab1lA9zv48vHjV5fnWV0FlOga/Gib119OZkTGJtsEdzZZlh/XV5eVEY1LzmSHxg
 NynA==
X-Gm-Message-State: AHQUAuZbuSJmQv80RFnWqwJDVen45q9VpOuQn/KUYlBM4XijHLFX95Tq
 U41bGRCKpEjVUSqhnow0BYv+4oFugOwtTnfJn+o=
X-Google-Smtp-Source: AHgI3IarhszVaU6gy67WJB4FnMbVnd6vOe9ORRCB9zqDq/qXxSt+mL/DUHTkLDlNGrvTZd9W8yr+HbPYnpu/z6H+6Uc=
X-Received: by 2002:a9d:7749:: with SMTP id t9mr5639594otl.342.1549453731613; 
 Wed, 06 Feb 2019 03:48:51 -0800 (PST)
MIME-Version: 1.0
References: <20190123151209.2080-1-linux.amoon@gmail.com>
 <20190123151209.2080-2-linux.amoon@gmail.com>
 <CAFBinCCOQ_GqHZuYf6n8ba_ZMbOwKmUzc4EJAuXRpn4tTTCUKA@mail.gmail.com>
 <CANAwSgSQH2zta+tOcqnM3JPZ45XkqWEJAWOL3Do0Mnrbam8VSw@mail.gmail.com>
 <CAFBinCD_O7FEX5iLyo2BzqE1KcrmATaZMMq5pFr-Q7wnRBPziw@mail.gmail.com>
 <CANAwSgSh--pom9kmVBWejHwVHJNv2o4Ta93wabR3Ak=f3V4JbQ@mail.gmail.com>
In-Reply-To: <CANAwSgSh--pom9kmVBWejHwVHJNv2o4Ta93wabR3Ak=f3V4JbQ@mail.gmail.com>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Wed, 6 Feb 2019 12:48:40 +0100
Message-ID: <CAFBinCAhjo4ueh6UDE+TKiF8Vc2Pz2JsjzcVsrsPQMU=ZEiLwQ@mail.gmail.com>
Subject: Re: [RFCv1 1/3] phy: meson8b-usb2: Enable otg phy controller on
 Meson8b SoCs
To: Anand Moon <linux.amoon@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190206_034853_026717_712970D5 
X-CRM114-Status: GOOD (  14.45  )
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
Cc: devicetree <devicetree@vger.kernel.org>,
 Neil Armstrong <narmstrong@baylibre.com>, Kevin Hilman <khilman@baylibre.com>,
 Kishon Vijay Abraham I <kishon@ti.com>, Rob Herring <robh+dt@kernel.org>,
 linux-amlogic@lists.infradead.org,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 Jerome Brunet <jbrunet@baylibre.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Anand,

On Tue, Feb 5, 2019 at 8:52 PM Anand Moon <linux.amoon@gmail.com> wrote:
[...]
> > personally I would start with getting device / peripheral mode working for usb0.
> > if you're lucky the PHY driver will work without any changes and you
> > only need to set the correct dr_mode along with the g-* properties.
> >
>
> Yes that should be the goal on getting working usb0 phy and otg port.
> So for now we will drop this patch and disable the usb_phy0 mode in
> dts for Odroid c2
> in order to get ride of the power failed WARNING.
I checked Kevin's Odroid-C2 (GXBB) on Kernel CI and I can't see any
power failed warning: [0]

> When we get the usb0 node to work again with good phy configuration and
> tuning we can re-enable the nodes. I will try to look into this in the future.
>
> Can you share your thought on this.
sounds good to me! especially because it would give us OTG support on
Meson8, Meson8b, Meson8m2 and GXBB (because these SoCs are sharing the
same USB implementation)!

I see four challenges:
1. getting host mode working on the micro USB port. you have already
proven that you can do this :)
2. getting peripheral mode working on the micro USB port. my hope is
that it's only about setting the right dr_mode and the g-* properties
on the usb0 node (but I haven't tried this)
3. make OTG detection work and integrate it with dwc2. I would consult
the dwc2 maintainers to see what can be done
4. bring everything together, making sure that one feature doesn't break another


Regards
Martin


[0] https://storage.kernelci.org/next/master/next-20190130/arm64/defconfig/lab-baylibre-seattle/boot-meson-gxbb-odroidc2.html

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
