Return-Path: <SRS0=Ql45=PY=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58353C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 15:11:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25A3F206C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 15:11:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WpP3M/f/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25A3F206C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=j4iFjmY2Hso3STIzJxbO2+YnFAau5VhsbMs9w2gRXqQ=; b=WpP3M/f/KfHnj6
	1MQGT8LPybIDxu+uwAb+8+stQuivkZcWofecII3CEOXKWgIJDLjd04OfM8bk+aAhnowvd7i+51Im3
	sOCJeHBFMKyykGzkk38PhPrmoSnz5Z/4e7yyh9dshb5JFRXC3teF8LCNAr9mgIHWBuzY0c5ZFV7Zo
	mqui7+kn53bun+y1pVdD02BZNWsl8gNbnTWAJvlUzmX+BUNxAIoBXXeFljzo3xz2pLYTycMUW7NDh
	ou14318vE6zluMIntU1Aip5rpgf0/+54g6zhEztVzhr3BZCnqxHXUmfBPuGCKWRBSRw0Mn01GNVyM
	hX/BOoAOtL2IQaCQ+o/g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjmqp-0000l8-Lp; Wed, 16 Jan 2019 15:11:31 +0000
Received: from mail-qt1-f193.google.com ([209.85.160.193])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjmqm-0000kS-2e
 for linux-arm-kernel@lists.infradead.org; Wed, 16 Jan 2019 15:11:29 +0000
Received: by mail-qt1-f193.google.com with SMTP id t33so7479990qtt.4
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 16 Jan 2019 07:11:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=4IMG7jlqdMP9fj1j/3+ne8Scrl1K/KH+xgzb4mZhEV0=;
 b=dkjf/UzGglSeEQD0ws4Zm3rj/E7Skj1BL8xRJcBxsMJtpvEQw1JNQQWNG98OCKSMTZ
 aehkuWzPcuFcgzHkL1/RJVuJy9e1WEIRoATFgBziRAOnoidAU2r32GBZ9wXT3aJIIQPe
 KCp84Eym+41rMSwQ1HX49mRNPuy/Hc2i3VCb53OKxrNdYCHd0bg97Vbczig+AA77Hunu
 1SxKZ/9ErmBz4wNsoLXHcs6HBzKULgDMtGDDX/N59fk69x60VV5RFttnRZLsMQ3egbzz
 vGeuRwzTncxtWYR9gofxfzA8hgi5L10O9M7LVzs4LjepG28b7H6FzaCo4zv5jydA0cjh
 8eRQ==
X-Gm-Message-State: AJcUukcgEeTeFkX4BizmVT8Ad58xKLJr71eGTJggCwFqYQV1uXxBiMXp
 ttzWJ5jWyQ8/xMGgOfAJw2/PQ4aO7cKLAakSM4E=
X-Google-Smtp-Source: ALg8bN4MHIpOwtix2a/9wSEs3En9UrRmeCKYXHdJzIxZZCLyKqC9gqX6rkyLnf9nTjE5CgELUF2MJJxfv35dxC2atSk=
X-Received: by 2002:ac8:4141:: with SMTP id e1mr7088485qtm.96.1547651485740;
 Wed, 16 Jan 2019 07:11:25 -0800 (PST)
MIME-Version: 1.0
References: <1544604495-4082-1-git-send-email-fabrice.gasnier@st.com>
 <1544604495-4082-3-git-send-email-fabrice.gasnier@st.com>
 <CAK8P3a1MucNG86=bXwVVsasGBOLJ67kuRSpoeneF6M5aB6GmQA@mail.gmail.com>
 <9e0ee154-a399-9bff-3beb-adfd9d6c6fee@st.com>
In-Reply-To: <9e0ee154-a399-9bff-3beb-adfd9d6c6fee@st.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 16 Jan 2019 16:11:08 +0100
Message-ID: <CAK8P3a0kV4-OF7JPwM9cEqxaPvNM9dFZdyZetc47t+D5izkFwQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] mfd: syscon: Add optional clock support
To: Fabrice Gasnier <fabrice.gasnier@st.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190116_071128_126171_9C4A6C6D 
X-CRM114-Status: GOOD (  22.64  )
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

On Wed, Jan 16, 2019 at 3:10 PM Fabrice Gasnier <fabrice.gasnier@st.com> wrote:
>
> On 1/16/19 1:14 PM, Arnd Bergmann wrote:
> > (sorry for the late reply, I just realized that I had never sent out the
> > mail after Lee asked me for a review last year and I had drafted
> > my reply).
>
> Hi Arnd,
>
> Many thanks for reviewing, no worries :-)
>
> >
> > On Wed, Dec 12, 2018 at 9:48 AM Fabrice Gasnier <fabrice.gasnier@st.com> wrote:
> >>
> >> Some system control registers need to be clocked, so the registers can
> >> be accessed. Add an optional clock and attach it to regmap.
> >>
> >> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
> >
> > This looks ok to me in principle, but I have one question: When we
> > do a clk_get() and clk_prepare() as part of regmap_mmio_attach_clk(),
> > does that change the behavior of syscon nodes that are otherwise
> > unused?
>
> I'm not sure I correctly understand this question. I don't think it will
> change the behavior for "unused" nodes. These should remain unused with
> this patch.

What I mean is that nodes that listed as 'compatible="syscon"' get
probed by the syscon driver even when no other driver references
them, and that in turn would acquire the clock, right?

> > I think we have a bunch of devices that started out as a syscon but
> > then we added a proper driver for them, which would handle the
> > clocks explicitly. Is it guaranteed that this will keep working (including
> > shutting down the clocks when they are unused) if we have two drivers
> > that call clk_get() on the same device node?
>
> I'd expect nothing wrong happens when two drivers call clk_get() for the
> same clock.
> Are there some case where two drivers are bind (e.g. syscon driver +
> another driver) for the same piece of hardware ?

You won't actually have two drivers binding to the same device, but you
could have a driver and a syscon user that does relies on the
syscon_regmap_lookup_by_*() functions.

I think we've had a couple of cases where we started out representing
a device as syscon, and then later decided that a high-level abstraction
would be needed because syscon didn't quite support all the needed
features.

Since each syscon node should also have a more specific
compatible value, you can then have another driver that binds
to that compatible string.

      Arnd

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
