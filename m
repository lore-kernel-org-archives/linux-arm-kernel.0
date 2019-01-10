Return-Path: <SRS0=vaNk=PS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2459FC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 00:38:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E275E214C6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 00:38:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="PXVZbZCs";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SxD8qkXR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E275E214C6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:Message-ID:References:From:
	In-Reply-To:To:Subject:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=DCXz0FYsllntMAxoAcT9EixLLPtJrP3nUjPVGiob2ss=; b=PXVZbZCsSD1CID
	LCf3aXSAgLGRX1OmLSU/HSuI9lVDjZxcUCn7hRexl+ksHylx0AL8BqeguGg8u1ImW6vdRKa3rzNlq
	IuDJW+zKOOHue2dLo3y09ABX9padLbwvdSsctwujN2o3UVisPKCwAaQnoJ1xjyhYVAcbHrBRhdAxS
	1Qy4pl6/kY6OdJu6nUvIAcdK/dE31W8JpRZmf3DqZ9DHE0NcBRpnrJuw11BCgl10C01kt7aBE763w
	fOLRgwo0Fq7MLhmI/lafUZmFu479r/lBpVl+fiUEIEYOKl5dILE5DuECveZXDq1AQqRH0QiX5MLE/
	dR2CSMN0NqqAs0LSprWQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghOMy-0003NB-A8; Thu, 10 Jan 2019 00:38:48 +0000
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghOMu-0003M2-Fz
 for linux-arm-kernel@lists.infradead.org; Thu, 10 Jan 2019 00:38:46 +0000
Received: by mail-pf1-x444.google.com with SMTP id 64so4444097pfr.9
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 09 Jan 2019 16:38:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:content-transfer-encoding:subject:cc:to:in-reply-to
 :from:user-agent:references:message-id:date;
 bh=7WJ4rS6UbtbSjPMBzCBVUR0lxQo/vQgH/95PF2OSySM=;
 b=SxD8qkXRrECUTbPvm/OqXdkswxKkXoA6mHB1JizP17W0jf/FHbjglt5QyF6Ccj/67m
 DHxOB3rNaUjF/K30wrTMUWtpub1zxn8KUTEr7c/PQpYuKpXl/4/vvlORXINb15cB3KT2
 w1jHtC9WIDNL3Eh209pc7fUiuKYL/kkM45yrw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:content-transfer-encoding:subject
 :cc:to:in-reply-to:from:user-agent:references:message-id:date;
 bh=7WJ4rS6UbtbSjPMBzCBVUR0lxQo/vQgH/95PF2OSySM=;
 b=fFKgmFAQkwALcERAc2AyvAkV8T6AihzTYLDEjx/AfCwgWVD3NKBEAXGgmtMNAqPzAz
 RWNBs50rSmuxLw09b5kjN+JprlGWJj8Hr//VIGF9a43Nl28Tv6HK3gZ6KC5Ea65tsWb3
 iNtilpkekolw0akhbf2/3cZ8tJARoUhmZbE9LRyc+Vf0Qxghm/4cW3jvhd6Ht0JF+cHF
 V9LHBaWRQmwYyK546AliKtsYvpSg7Y29zk6MHIRC35Y3nd0uM/NAHgyTSbxPFtNVCLhh
 WNcXx9461a5hwUnaISJ7pU0scAydo3Iv6JMagaUGD80k3Y9YCmmxN94bbA3n8vpQKulm
 2Ghg==
X-Gm-Message-State: AJcUukckisnrTvY3S3nUtJuL9ybZTysVeZT9j46/CUmHenT46453DXio
 djPJkP2Mk/UM7aew/84gvzFYKA==
X-Google-Smtp-Source: ALg8bN6E+p7lSVwmR9A34DRJksj54T3Keq/wC14EILMp8v2LTElWDf6KOFhMf1/ZODuM7PkRNX8HMA==
X-Received: by 2002:a62:3305:: with SMTP id z5mr8225520pfz.112.1547080723204; 
 Wed, 09 Jan 2019 16:38:43 -0800 (PST)
Received: from localhost ([2620:15c:202:1:fa53:7765:582b:82b9])
 by smtp.gmail.com with ESMTPSA id r80sm123239082pfa.111.2019.01.09.16.38.42
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 09 Jan 2019 16:38:42 -0800 (PST)
MIME-Version: 1.0
Subject: Re: [RFC RESEND PATCH 6/7] soc: mediatek: add MT8183 dvfsrc support
To: Henry Chen <henryc.chen@mediatek.com>
In-Reply-To: <1546859353.6818.132.camel@mtksdaap41>
From: Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.8
References: <1546438198-1677-1-git-send-email-henryc.chen@mediatek.com>
 <1546438198-1677-7-git-send-email-henryc.chen@mediatek.com>
 <154655691363.15366.15223653253336032554@swboyd.mtv.corp.google.com>
 <1546859353.6818.132.camel@mtksdaap41>
Message-ID: <154708072159.15366.10685577152949535083@swboyd.mtv.corp.google.com>
Date: Wed, 09 Jan 2019 16:38:41 -0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190109_163844_569653_00F0C20B 
X-CRM114-Status: GOOD (  13.18  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, "JamesJJ Liao \(廖建智\)" <jamesjj.liao@mediatek.com>, Ulf Hansson <ulf.hansson@linaro.org>, Kees Cook <keescook@chromium.org>, "Weiyi Lu \(呂威儀\)" <Weiyi.Lu@mediatek.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Viresh Kumar <vireshk@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Fan Chen \(陳凡\)" <fan.chen@mediatek.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>, Matthias Brugger <matthias.bgg@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Quoting Henry Chen (2019-01-07 03:09:13)
> On Fri, 2019-01-04 at 07:08 +0800, Stephen Boyd wrote:
> > Quoting Henry Chen (2019-01-02 06:09:57)
> > > +       val = dvfsrc_read(dvfsrc, DVFSRC_INT);
> > > +       dvfsrc_write(dvfsrc, DVFSRC_INT_CLR, val);
> > > +       dvfsrc_write(dvfsrc, DVFSRC_INT_CLR, 0x0);
> > > +       if (val & DVFSRC_IRQ_TIMEOUT_EN)
> > > +               dev_warn(dvfsrc->dev, "timeout at spm = %x", val);
> > > +
> > 
> > Do you need to handle the irq at all? It looks like you are cleaning up
> > something and then complaining if there's a timeout, but otherwise
> > nothing goes on so perhaps the irq can just be ignored and nobody will
> > be the wiser?
> 
> ok, it only for alarm system a timeout message. 

Well if it's some timeout do you need to fail some dvfs operation if it
times out? Or take the whole system down in that scenario?


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
