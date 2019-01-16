Return-Path: <SRS0=Ql45=PY=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80566C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 12:14:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F84120657
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 12:14:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nId+MR9k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F84120657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=3Cqi/xmnU151PSoMkYFXWwedWcvlQxpy/yyEPWVbfXY=; b=nId+MR9kPMPEQw
	bMT66JqKhjP4CE47STOHuKQeTFtGWpbrJFpGi3kL/3jpDfwKkMgsUOZChqiv9wmJVDcM5UgbO3F2K
	wPGFLVut8S+SPTE4awSD3LKJlVCroJEDB6jB0bUrM7UHNMg7FVfURxRDAsdYajmh06ciJsUq/5N2r
	Soryzz17nDOjhTJSSj91UbkO+XiRxb7dwhdie7qSeGEa686ZIfVBNc3m4TQ7DJURQZ8mdmqlbJbVA
	F3q3/5WkBvmD4aLdKhNmDhUbpO0VoXpAuYE9Q4cCAAhIVxMd+2LcyORfTrrVyKI7PDfNI6zvInK06
	7RZPPSk8P4HXs34V7iJw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjk5d-0005Ft-8S; Wed, 16 Jan 2019 12:14:37 +0000
Received: from mail-qt1-f194.google.com ([209.85.160.194])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjk5Z-0005F9-G8
 for linux-arm-kernel@lists.infradead.org; Wed, 16 Jan 2019 12:14:34 +0000
Received: by mail-qt1-f194.google.com with SMTP id r14so6894865qtp.1
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 16 Jan 2019 04:14:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=BvT8UEGTNgUOWn4aDzojgNkCEy0NRz+atz8DCKuaLjQ=;
 b=MC+ZU6o5xxdITT/nfXWnoKpp0DfvkkEDi9ugrJyxzWB3micbY5ZXUeIk6nElLRvDHW
 do8BMs8HmeOTgTMSSrWWiLbwr4nGZHmCJ+ISWjKBpKb94xfIfTsSEL/p84i+DxdaC8l/
 eWbOwaCRlq4NRhxOwBF0zTyfLNQ6Ps49RzUiX8MliO3R7im4Y+peuCA3mrrMuzD5VAKD
 +HgTbM0296tnRzUFIvlO+8F+uk5NY4I6idGU++8zL0YH5OeIUUrgChTDMdnsja1DII3z
 sj8qxDjxb/tMVINWSuldOPv9/U5qSEhvdOOj6LxOC+rrWiwnDW8aspCbZm7DT//vfuyM
 dIFA==
X-Gm-Message-State: AJcUukcM7xSAenyG+vLLqpXqbOYwfJR0JitEvzqzSJ0K/x2SrNHD7Jw8
 olQTU6M2HsEDACpVS0/YnbLnlxuXiKIAh0Bz2ms=
X-Google-Smtp-Source: ALg8bN6aCvJfHDZ/arzelyorZUeaRxresG0MORoNVuPOOaH7xlxYOTSsvtpPZK/HmB40aVs+havkmS7bLtR/ZVAVHVE=
X-Received: by 2002:ac8:4141:: with SMTP id e1mr6496899qtm.96.1547640870312;
 Wed, 16 Jan 2019 04:14:30 -0800 (PST)
MIME-Version: 1.0
References: <1544604495-4082-1-git-send-email-fabrice.gasnier@st.com>
 <1544604495-4082-3-git-send-email-fabrice.gasnier@st.com>
In-Reply-To: <1544604495-4082-3-git-send-email-fabrice.gasnier@st.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 16 Jan 2019 13:14:13 +0100
Message-ID: <CAK8P3a1MucNG86=bXwVVsasGBOLJ67kuRSpoeneF6M5aB6GmQA@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] mfd: syscon: Add optional clock support
To: Fabrice Gasnier <fabrice.gasnier@st.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190116_041433_537156_EC9DC678 
X-CRM114-Status: GOOD (  11.70  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, DTML <devicetree@vger.kernel.org>,
 Alexandre Torgue <alexandre.torgue@st.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-stm32@st-md-mailman.stormreply.com, Rob Herring <robh+dt@kernel.org>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, Lee Jones <lee.jones@linaro.org>,
 Gabriel Fernandez <gabriel.fernandez@st.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

(sorry for the late reply, I just realized that I had never sent out the
mail after Lee asked me for a review last year and I had drafted
my reply).

On Wed, Dec 12, 2018 at 9:48 AM Fabrice Gasnier <fabrice.gasnier@st.com> wrote:
>
> Some system control registers need to be clocked, so the registers can
> be accessed. Add an optional clock and attach it to regmap.
>
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>

This looks ok to me in principle, but I have one question: When we
do a clk_get() and clk_prepare() as part of regmap_mmio_attach_clk(),
does that change the behavior of syscon nodes that are otherwise
unused?

I think we have a bunch of devices that started out as a syscon but
then we added a proper driver for them, which would handle the
clocks explicitly. Is it guaranteed that this will keep working (including
shutting down the clocks when they are unused) if we have two drivers
that call clk_get() on the same device node?

       Arnd

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
