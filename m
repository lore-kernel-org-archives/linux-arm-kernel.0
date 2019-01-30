Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF0A3C282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 22:08:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4583E218AF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 22:08:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jaYO2OOQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4583E218AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=etiS9MLEQ1Zm3I0/6FTsUG8mhubVKrbeY9jxre2wd1o=; b=jaYO2OOQnGi59S
	E4IjwCLtb0SLuu9uyxh7KSEJeRYkn/vx5hAttCrxDIMHtsmcBYFz7AYJe5v2IRxCRKYIHSoH4bnnK
	ufMJbMapTvN6TNGopfh3LfBUtWP1Nwib2jfc5h6HAR9U22Bkl6jZm9kXzaf1n04NxSjjazl3ZlWea
	OIg/7524LTqGhCorwFA9HtG/SQunMcvSeLgXomGBfsHRNjZWarw4hbL0pti6cGuiQ39b43jysEhSg
	B6/LsQPPWcAnMX3FMwk786W8Od8I8QBQ6UON+qLAutOzZs7r35QeBrjKYcINWq3vyvEAOuNnhlZbl
	/S+0YA3O++fAX8lPCZrQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goy1y-0003Dw-0Q; Wed, 30 Jan 2019 22:08:26 +0000
Received: from mail-qt1-f196.google.com ([209.85.160.196])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goy1t-0003DI-Ni
 for linux-arm-kernel@lists.infradead.org; Wed, 30 Jan 2019 22:08:23 +0000
Received: by mail-qt1-f196.google.com with SMTP id d19so1347777qtq.9
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 30 Jan 2019 14:08:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=t01+gCS+WM+qXgR1rsy2UEMvM9ugzvk9Cf0i9QDT+Wc=;
 b=Mg4w12TIBrwdsSKinw9P8L5xqouRyupMCMsyXivnz5IVnwmaVKvjNLMf3W6545+LJ3
 6250E9WyfPAb/TD2aVuIPe/YxQANVR/nWM8uwYkfBfODTlV/i4OWvIdjlWYR4g7yBdl+
 uW1aMlcFOM961QtGpgiLGs/R+Ye9iR4dfkR0aCAdtNARLHsAFSSM/8E8pjL72RSynYq3
 dDMhg1oW3GhVRHtXnSsWEPod6hSd+OnTwHYW8HoBQIxpVxY11IrBCgG5MTXxFpsAfwMb
 UEysJFROAddSAQ625WDiYlCV5BHRI2kFonWq2UsO2NKtACRUvjV3x9HpthkaEa7mslom
 9AWA==
X-Gm-Message-State: AJcUukdb6A1P6OWafrwfIfIjSSNqmID6cw68cWy7gEC7G6Q1F/iz8AhM
 tWc+PLiUplXVj8HSDkhKK4S0+N7ZoMshYdnLeRU=
X-Google-Smtp-Source: ALg8bN5MRWCZierZp/fuwUKclMqrrOKdqyazVCd14yj20c7KbOUCV+z4GySg+Y7u5gN6CptrfDJcSZo9RqX+52g9YsA=
X-Received: by 2002:a0c:dc0f:: with SMTP id s15mr29550044qvk.40.1548886100579; 
 Wed, 30 Jan 2019 14:08:20 -0800 (PST)
MIME-Version: 1.0
References: <20190107134510.32494-1-koen.vandeputte@ncentric.com>
 <20190124115656.GA23362@e107981-ln.cambridge.arm.com>
 <47437c58-d7b3-f77c-7bc7-973373f1e78e@ncentric.com>
 <20190124162759.GA28871@e107981-ln.cambridge.arm.com>
In-Reply-To: <20190124162759.GA28871@e107981-ln.cambridge.arm.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 30 Jan 2019 23:08:04 +0100
Message-ID: <CAK8P3a2ftPvdBnVacbGcxDpCW6CvBj3ZGBXuVQE46JocXewvgQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] arm: cns3xxx: fix writing to wrong PCI registers
 after alignment
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_140821_780128_F6A96AFA 
X-CRM114-Status: GOOD (  15.48  )
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
Cc: Rob Herring <robh@kernel.org>, linux-pci <linux-pci@vger.kernel.org>,
 Russell King <linux@armlinux.org.uk>, "# 3.4.x" <stable@vger.kernel.org>,
 Robin Leblon <robin.leblon@ncentric.com>, Olof Johansson <olof@lixom.net>,
 Koen Vandeputte <koen.vandeputte@ncentric.com>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Jan 24, 2019 at 5:29 PM Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
> On Thu, Jan 24, 2019 at 04:23:05PM +0100, Koen Vandeputte wrote:
> > On 24.01.19 12:56, Lorenzo Pieralisi wrote:
> > >On Mon, Jan 07, 2019 at 02:45:09PM +0100, Koen Vandeputte wrote:

> >
> > Thank you for taking care of the wrappings etc.?? it seems my auto-wrap was
> > disabled in my git tooling ..
> > Your adaptions look more than fine.
> >
> >
> > Purely for my information:
> >
> > Testing on a lot of devices here shows a huge improvement towards stability.
> > Is it possible to get it merged sooner?
> > Does "queued for 5.1" also mean that backporting to stables only will happen
> > at 5.1_rc1 release?
>
> Yes, I will ask Bjorn if we can send them for one of the upcoming -rc*
> (so effectively you will get them in v5.0 and propagated to stable
> earlier), I do not think it is that urgent either though, let me handle
> that.

We can take them through the soc tree if that's easier, but
going through Bjorn's tree is also fine.

      Arnd

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
