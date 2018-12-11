Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85595C07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 10:11:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55E0A2081B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 10:11:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gRAn4ZXj";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="msTkdMEq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55E0A2081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=CIsyWPrCeQIJppjiGPgtPcRUbXywcDHZkJa/JUk3dCQ=; b=gRAn4ZXjwEAJ/I
	TboDkYwFXBIzw/2SpyMIh+dlF+xWHrYOrk56JhEUL6LYd2vHvKKa7wqomklIjQEPF0D6pcpDgmw40
	08fJ99MAVFPLPmfjdq0Wp2bcZTRCfd9A6+c7Hi0GUchqsexltd5p7sy/ff+pbqN84TXMNMiZPsuA3
	3NHcq8PZPK67GD4+W0HyrfsVlGS/WPe0sBI53DZu93u79VPr965YG+LwGm0e3qs5u6FhJ/WhH7XXF
	4D43N0qSGqV2kaXRrq1Gx28z2hpv/RVe9nx3gfrwgg5hvREJJAJ6AuTG+tMoahjlsEiQN3LKUWc6b
	tnlNj5Z/jjPXnNAhyCJA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWf0Y-0007cQ-UJ; Tue, 11 Dec 2018 10:11:18 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWf0D-0007Nw-0v
 for linux-arm-kernel@bombadil.infradead.org; Tue, 11 Dec 2018 10:10:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=Content-Type:Cc:To:Subject:Message-ID:
 Date:From:In-Reply-To:References:MIME-Version:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=oUptHz8tAupzd+qIgaO0UnYurIGVlvC4FJiiGfsyRnw=; b=msTkdMEqfVtty4JY4xDokBCcO
 jfip6mRgiM2OYIC+ZkhA/xX+AWYGQFmwwyh9FqVgfqhJ4RIkk9xFU+bXnmhtJdT+NrFpDMIlnV5eo
 8mqb/bW+XmHA8t/K11hjWnyYqgRiBegjWLKB+kz2TBPAbSJDjGTEfzsmFoJBfpHadSIjJ9usPI7PF
 LU5uEwPuQYKINIkg74CR43QfadpTdar3koS8703v56im/JS7dGmzvJiTz4e3LmuJu0aPaBQRVS6Di
 HePte/9SvGqNk/+oTbyVHF21xbvaBcMfT9UqjTGxommWwvDCOgSlHPpX/TBckQt2YidVN4DebAFWi
 O/sLwh5Qg==;
Received: from mail-qt1-f195.google.com ([209.85.160.195])
 by merlin.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWf0A-0005lD-5t
 for linux-arm-kernel@lists.infradead.org; Tue, 11 Dec 2018 10:10:55 +0000
Received: by mail-qt1-f195.google.com with SMTP id k12so15703344qtf.7
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 11 Dec 2018 02:10:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=oUptHz8tAupzd+qIgaO0UnYurIGVlvC4FJiiGfsyRnw=;
 b=VqR9PsuIJnp4JoUd8YdlnXR9rmO2fe+kELLfTtrA34nVR5XoGDwzFb2IfeaJniRZ+u
 i0pBfDLB6eXPEFVdAz/tUgW3iJbm8tFWxW9lbZWUZb4Bt2c0vi0jYHSXC/6escg8LTvu
 AdyWeuffAUUpApTI27Fwnn80toGfTNtyOqsoHSQJCJ7mZ77Fd1Z/WOMKMnbccBxlMeAN
 t+tDzdGXCC4VqMhsjUFB0uOUuAVeuHv4UG1C+Fi/LA+fWyTZ9/RUmK7l1VYpRZiDHXwl
 avgr4QTlRxdZdiN+uKqkBIkdSiRXF7A8O+Ezbci4hCa/ti2Aw1899k34bQL5tJM+ugjw
 d/rg==
X-Gm-Message-State: AA+aEWYDBvyYSEhcXOZFLvy/53o5J0kUPMzusAy4b9KH9ZahsjxrjqrY
 PF+SXdbo8hZuFFSshHsWZwFvEFCAcHBsqDyWPus=
X-Google-Smtp-Source: AFSGD/X/XjFG5Gua/YHdVFxncInde8iBADRl4mRhSfY4aL+DBb+3kwNNf6ruT8FqSHHJYj+rbC1ke4VDLxJEd/E/kFk=
X-Received: by 2002:ac8:7451:: with SMTP id h17mr15017284qtr.319.1544523038716; 
 Tue, 11 Dec 2018 02:10:38 -0800 (PST)
MIME-Version: 1.0
References: <20181210215856.2238253-1-arnd@arndb.de>
 <20181210215856.2238253-4-arnd@arndb.de>
 <CAPDyKFogJv0OeaqdXBUyVAtmFqNTxDOJU_EMgMO7tFYdoQMY4A@mail.gmail.com>
In-Reply-To: <CAPDyKFogJv0OeaqdXBUyVAtmFqNTxDOJU_EMgMO7tFYdoQMY4A@mail.gmail.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 11 Dec 2018 11:10:21 +0100
Message-ID: <CAK8P3a0n0zjGjF64F7Dk1rfxsQpn+7R4L2WoZuzXgnKokc-YHg@mail.gmail.com>
Subject: Re: [PATCH 4/4] ARM: pxa: avoid section mismatch warning
To: Ulf Hansson <ulf.hansson@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_051054_265129_965F0A24 
X-CRM114-Status: GOOD (  17.93  )
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
Cc: Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Linus Walleij <linus.walleij@linaro.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Haojian Zhuang <haojian.zhuang@gmail.com>, arm-soc <arm@kernel.org>,
 grinberg@compulab.co.il, Miquel Raynal <miquel.raynal@bootlin.com>,
 Robert Jarzmik <robert.jarzmik@free.fr>, Daniel Mack <daniel@zonque.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Dec 11, 2018 at 10:40 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Mon, 10 Dec 2018 at 23:00, Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > WARNING: vmlinux.o(.text+0x19f90): Section mismatch in reference from the function littleton_init_lcd() to the function .init.text:pxa_set_fb_info()
> > The function littleton_init_lcd() references
> > the function __init pxa_set_fb_info().
> > This is often because littleton_init_lcd lacks a __init
> > annotation or the annotation of pxa_set_fb_info is wrong.
> >
> > WARNING: vmlinux.o(.text+0xf824): Section mismatch in reference from the function zeus_register_ohci() to the function .init.text:pxa_set_ohci_info()
> > The function zeus_register_ohci() references
> > the function __init pxa_set_ohci_info().
> > This is often because zeus_register_ohci lacks a __init
> > annotation or the annotation of pxa_set_ohci_info is wrong.
> >
> > WARNING: vmlinux.o(.text+0xf95c): Section mismatch in reference from the function cm_x300_init_u2d() to the function .init.text:pxa3xx_set_u2d_info()
> > The function cm_x300_init_u2d() references
> > the function __init pxa3xx_set_u2d_info().
> > This is often because cm_x300_init_u2d lacks a __init
> > annotation or the annotation of pxa3xx_set_u2d_info is wrong.
> >
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
> I have queued a bunch of pxa changes via my mmc tree for gpio
> descriptor conversions, by Linus Walleij.
>
> Are those causing this problem? Should I queue this one via mmc tree as well?

Sorry for the lack of description in the changelog. I'm fairly sure that these
are old bugs that only appeared now if you build with CONFIG_NO_AUTO_INLINE,
we should take these through arm-soc, and I should probably add an explanation.

      Arnd

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
