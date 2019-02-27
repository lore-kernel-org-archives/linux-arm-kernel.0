Return-Path: <SRS0=CF3g=RC=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B94EAC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 09:12:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A5D4218C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 09:12:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gbubQKH5";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NW6JurUs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A5D4218C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=PcohY0KUEC4C4Bl0vGVz/CYA3mdpvEkMeLoPVlX76E4=; b=gbubQKH50gWYex
	5EJkb5zYbpzYvKiIsY/QEtZXfG0rz9xD68/3qqlcDs3vsPVrnjPho3/5zX52oFI0Bn3dIbqg7mrzZ
	ErG4hIFnTt4R21HgjlYuYqo9UtBLXEYEMmUTglTnYZhCEyooQKlbu4EPjNo6FpXkZaDwl78Bgd/Yd
	ChyiK0qxIyxEJAyrLYs66qJjFjMcjjyahJufuR3Oz/h7WlqYLdjXpKgNaTYTL5N6zCdjQIlL2EOe4
	00plNPiR4+ZkitFH1TN9Z92G1wQh1JZMVZHLs7H78Zv6QhIIGdgdfkwZS8N+nBMgQBvbxEzJKK/Fr
	HU4MKD3arnIlnKW5LI0Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gyvFt-00025n-RH; Wed, 27 Feb 2019 09:11:57 +0000
Received: from mail-ua1-x942.google.com ([2607:f8b0:4864:20::942])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gyvFq-00024n-Se
 for linux-arm-kernel@lists.infradead.org; Wed, 27 Feb 2019 09:11:56 +0000
Received: by mail-ua1-x942.google.com with SMTP id e15so13502264uam.3
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 27 Feb 2019 01:11:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=kw8tusPCA1LkwwPgvJXNDPcc4GR2+4CJ0mI3cYf1BkI=;
 b=NW6JurUsFRBVGoroaa+zeoQy2/PFjytXZNZqRWxNnjdraqjWti0Y7TE7stuzyMby0J
 pxzTIxUPwrb5z6IHqEVqn15wlB0v+qfNMHApva8CksWdK15+niZ9Hmc6jrCJSWX81e2U
 ITnth/3ALPjaSfQO8MLrN1RZeN+G1mzuDqdzAiMkMJG/L4jtSrmvti0QE8OTGpq9BHkq
 hyLq512TRv5CrdVA8Xn9IcjSTdWMSUvi4R3uVI8EMc6sN8d5ZjkIdTJPiViuxgMfqjeH
 H4sj5D9HDUSIOW7mtmNxDdUbWqKISgUDs67gFjbp1N+0GAehZIewxg30xKnCQEGuDuaC
 xxbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=kw8tusPCA1LkwwPgvJXNDPcc4GR2+4CJ0mI3cYf1BkI=;
 b=LUfDekFokQDKgRezQkyhhDiso8E1cXChd8Ds+2wFiky42A53ZctkQuOOmWzmeLRpKs
 WityC8VTYHJr8ZDoUsgWH/vtkyXsQT5ApACs89OXIm45NvKCWY+tNVFriXR1ACoerczX
 zkHunqhrtBRJJsPR1xfkJGG1EPGwa+P1QXtPtnv3gdC5VV5Kz0ptZJFvDYvkewor7Qo5
 z9J5HhGv/Ea4xqkauN17Bl2K/S2p28GUxpwm+mQ1NPj6jBxfCC1Ey2b0X2Ek4pNTa4Tl
 J7fYflPvvZx605mU3l8GBsNpW/MuWbTPgiYFK6pfZjslzb9buTT7hCskWyqvWHoR7xmN
 Mzaw==
X-Gm-Message-State: AHQUAuZSPd0wfGwBHEu+4yQINONfrtxj9g8CDsAQd5GjFNk0N9qANbxQ
 POY9PqOov0Axkx9xpgnrIJCFGwKWj/Keya8FW1qY9A==
X-Google-Smtp-Source: AHgI3IaQqA1hiqd+sfYZ3tlX1mFzyAUGnsDVblZH9Yvb4jtfwPOWLyNntcNO6dtLDbSsZzqjuQ3HvMHgvHdRjyo0wRs=
X-Received: by 2002:a67:8055:: with SMTP id b82mr1203928vsd.200.1551258713237; 
 Wed, 27 Feb 2019 01:11:53 -0800 (PST)
MIME-Version: 1.0
References: <1550743851-13588-1-git-send-email-ludovic.Barre@st.com>
 <20190221102739.cc37au6elqu6gvfe@shell.armlinux.org.uk>
 <20190221103049.tspc5igoe6wmt3jd@shell.armlinux.org.uk>
 <a736b773-d6e6-eb81-90d6-ebeab7b401cb@st.com>
 <20190221140300.y3tunrvsh3gyig5f@shell.armlinux.org.uk>
 <9c88d76c-2080-71b1-c9c6-c24d0f0aeb91@st.com>
In-Reply-To: <9c88d76c-2080-71b1-c9c6-c24d0f0aeb91@st.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 27 Feb 2019 10:11:17 +0100
Message-ID: <CAPDyKFpgvLdcmpFkhAm8vPNZruF9e6GT8wnhpLQYsG9L=h_5Cg@mail.gmail.com>
Subject: Re: [PATCH 0/2] mmc: mmci: add quirk property to add stm32 transfer
 mode
To: Ludovic BARRE <ludovic.barre@st.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190227_011154_944472_003C9AC9 
X-CRM114-Status: GOOD (  21.54  )
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
Cc: DTML <devicetree@vger.kernel.org>,
 Alexandre Torgue <alexandre.torgue@st.com>,
 "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
 Russell King - ARM Linux admin <linux@armlinux.org.uk>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Rob Herring <robh+dt@kernel.org>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 linux-stm32@st-md-mailman.stormreply.com,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, 25 Feb 2019 at 11:49, Ludovic BARRE <ludovic.barre@st.com> wrote:
>
> hi Russell & Ulf
>
> On 2/21/19 3:03 PM, Russell King - ARM Linux admin wrote:
> > On Thu, Feb 21, 2019 at 02:38:36PM +0100, Ludovic BARRE wrote:
> >> hi Russell & Ulf
> >>
> >> On 2/21/19 11:30 AM, Russell King - ARM Linux admin wrote:
> >>> On Thu, Feb 21, 2019 at 10:27:39AM +0000, Russell King - ARM Linux admin wrote:
> >>>> On Thu, Feb 21, 2019 at 11:10:49AM +0100, Ludovic Barre wrote:
> >>>>> From: Ludovic Barre <ludovic.barre@st.com>
> >>>>>
> >>>>> This patch series introduces a bitmap of hardware quirks that require
> >>>>> some special action. This should reduce the number of boolean
> >>>>> into variant structure.
> >>>>> And adds quirk bit to define sdmmc specific transfer modes.
> >>>>
> >>>> Please find some other way to deal with these differences.  As far as
> >>>> I'm concerned, introducing a quirk bitmask such as what was done in
> >>>> sdhci is a complete disaster and leads to long-term maintanability
> >>>> problems.
> >>>>
> >>>> We already have a way to deal with variants in mmci.
> >>>
> >>> ... to finish what I was saying ...
> >>>
> >>> and I think that:
> >>>
> >>>           if (variant->blksz_datactrl16)
> >>>                   datactrl = variant->datactrl_dpsm_enable | (data->blksz << 16);
> >>>           else if (variant->blksz_datactrl4)
> >>>                   datactrl = variant->datactrl_dpsm_enable | (data->blksz << 4);
> >>>           else
> >>>                   datactrl = variant->datactrl_dpsm_enable | blksz_bits << 4;
> >>>
> >>> ought to become a variant function call which returns the appropriate
> >>> datactrl value.  This would shrink the amount of variant testing in this
> >>> path, and also means that going forward we aren't facing an endlessly
> >>> increasing number of tests here.
> >>
> >> For blksz_datactrl case:
> >> We could create an inline function for datactrl16 and blksz_datactrl4
> >> which returns the appropriate datactrl value (specific for ux500v2 and
> >> qcom). This function could be register in mmci_host_ops structure.
> >
> > Yes, this is what I'm proposing (except for the "inline" bit which
> > seems meaningless if it's called via the mmci_host_ops structure.)
> > I'm also proposing that it shouldn't just be the blksz that's
> > returned but anything that the variant needs to take account of,
> > including the stm transfer mode.
>
> Ulf, are you alright with this callback approach (just to be sure that
> every body is align, before send a patch)?

Go ahead, let's see how it looks!

>
> This mmci_host_ops callback could return datactrl config to
> start data (defined by variant).

Yes.

[...]

Kind regards
Uffe

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
