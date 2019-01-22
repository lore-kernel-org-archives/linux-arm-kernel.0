Return-Path: <SRS0=B2vk=P6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3191CC282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 13:38:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9F4820870
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 13:38:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rzmsaXmX";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="p6P9jCix"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9F4820870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=b45YrGqO+uvCgUBK3YDmh+QFrTmMfQXp/eonNY6yxqE=; b=rzmsaXmXqI6BbU
	SG5NbkpAnZV8GwtWbcrxXgbvDX37qB1vB/73Q/kNIjx/7rLrB8Agq0pyLykc6/GVI7O9Hvn7whIiX
	QzB2tPppNhW2fwKX8LuSEA+biAjCsvHmtui4SKHp/2jL524IUwwx1NeancsQBGHm68UTX3orB9weP
	yRL2RHCjEhnfvljTkkjAFLGoj58w2iFXeVPpld5OHEkgjphAhyUI0Usb8h+6HITCQyx7p0HXM/I4o
	yylVdROsRZZqkwv3IeuzTK9/vXeYSAsYDmgBqSdUgCOB4fdLZSAk1meNYg2zQMwmuokqE1+Zi+a8C
	hNmIBLGIaL4JWcmH+Cvg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glwFn-0004VS-E6; Tue, 22 Jan 2019 13:38:11 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glwFg-0004Tn-Rw
 for linux-arm-kernel@lists.infradead.org; Tue, 22 Jan 2019 13:38:07 +0000
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com
 [209.85.160.177])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id DE21C21721
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 22 Jan 2019 13:38:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1548164284;
 bh=jodr6i6s3jvg2nhf0kijRpn+bTr+EGnPky61yayyNdU=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=p6P9jCixubpZqW9mQ9FjNqhZFrMnRzLp5ynzREMTh8/uSUtAePuOsv8uKy5l+Sgo/
 LELpzJWUSSF5w6N2yFOUyfUkzVDkL/zWL9sP/vSlMZap+3XllIO+aUhtYB2hmyrl12
 etYfCwZuEHYfaVsJfqQ11c1/w//DdrHkW3AiyT10=
Received: by mail-qt1-f177.google.com with SMTP id v11so27595107qtc.2
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 22 Jan 2019 05:38:03 -0800 (PST)
X-Gm-Message-State: AJcUukdS+hvCM0/jqcF3pIYQIW0QBRtopVJLYnsR0/T9GRYfMMnjrhVX
 xd5FYOjFVNKfqIxY6Ck72XyYHchAEkhy7JIFpA==
X-Google-Smtp-Source: ALg8bN4etqq10Dl4Ve0aHvgW7iUFq/uRu0ytKakxodDc1gBLnyubvCHhqLHe7MWZZ23Nm1vbcopo7UiQdvK1GbtoFO8=
X-Received: by 2002:ac8:1712:: with SMTP id w18mr30740377qtj.76.1548164283123; 
 Tue, 22 Jan 2019 05:38:03 -0800 (PST)
MIME-Version: 1.0
References: <20190111173015.12119-1-jernej.skrabec@siol.net>
 <20190111173015.12119-2-jernej.skrabec@siol.net>
 <CAGb2v66DiqK9sL-hQev4Wy08d9T7f1Yc2DFWJ0gYOnqChJyBRw@mail.gmail.com>
 <20190121095014.b6iq5dubfi7x2pi4@flea>
 <CAGb2v66d0wM8Yt2uS4MMhU6PP02h8CKwKjinasO6jtZ4ue1CAQ@mail.gmail.com>
 <20190122001917.GA31407@bogus>
 <CAGb2v67YsevDvjvTSh67wJNSJSUBuZ613hQWyorEiSzCUqjjkQ@mail.gmail.com>
In-Reply-To: <CAGb2v67YsevDvjvTSh67wJNSJSUBuZ613hQWyorEiSzCUqjjkQ@mail.gmail.com>
From: Rob Herring <robh@kernel.org>
Date: Tue, 22 Jan 2019 07:37:51 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+u2PdLK3YaYMERHndNpN_PprksPF9gVF+V76c343yrMg@mail.gmail.com>
Message-ID: <CAL_Jsq+u2PdLK3YaYMERHndNpN_PprksPF9gVF+V76c343yrMg@mail.gmail.com>
Subject: Re: [PATCH 1/3] media: dt: bindings: sunxi-ir: Add A64 compatible
To: Chen-Yu Tsai <wens@csie.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190122_053805_172841_B8D768CB 
X-CRM114-Status: GOOD (  30.27  )
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
 devicetree <devicetree@vger.kernel.org>,
 Jernej Skrabec <jernej.skrabec@siol.net>,
 Maxime Ripard <maxime.ripard@bootlin.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 linux-sunxi <linux-sunxi@googlegroups.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 Linux Media Mailing List <linux-media@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Jan 21, 2019 at 8:16 PM Chen-Yu Tsai <wens@csie.org> wrote:
>
> On Tue, Jan 22, 2019 at 8:19 AM Rob Herring <robh@kernel.org> wrote:
> >
> > On Mon, Jan 21, 2019 at 05:57:57PM +0800, Chen-Yu Tsai wrote:
> > > On Mon, Jan 21, 2019 at 5:50 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> > > >
> > > > Hi,
> > > >
> > > > I'm a bit late to the party, sorry for that.
> > > >
> > > > On Sat, Jan 12, 2019 at 09:56:11AM +0800, Chen-Yu Tsai wrote:
> > > > > On Sat, Jan 12, 2019 at 1:30 AM Jernej Skrabec <jernej.skrabec@siol.net> wrote:
> > > > > >
> > > > > > A64 IR is compatible with A13, so add A64 compatible with A13 as a
> > > > > > fallback.
> > > > >
> > > > > We ask people to add the SoC-specific compatible as a contigency,
> > > > > in case things turn out to be not so "compatible".
> > > > >
> > > > > To be consistent with all the other SoCs and other peripherals,
> > > > > unless you already spotted a "compatible" difference in the
> > > > > hardware, i.e. the hardware isn't completely the same, this
> > > > > patch isn't needed. On the other hand, if you did, please mention
> > > > > the differences in the commit log.
> > > >
> > > > Even if we don't spot things, since we have the stable DT now, if we
> > > > ever had that compatible in the DT from day 1, it's much easier to
> > > > deal with.
> > > >
> > > > I'd really like to have that pattern for all the IPs even if we didn't
> > > > spot any issue, since we can't really say that the datasheet are
> > > > complete, and one can always make a mistake and overlook something.
> > > >
> > > > I'm fine with this version, and can apply it as is if we all agree.
> > >
> > > I'm OK with having the fallback compatible. I'm just pointing out
> > > that there are and will be a whole bunch of them, and we don't need
> > > to document all of them unless we are actually doing something to
> > > support them.
> >
> > Yes, you do. Otherwise, how will we validate what is and isn't a valid
> > set of compatible strings? It's not required yet, but bindings are
> > moving to json-schema.
>
> Ideally, if we knew which IP blocks in each SoC were compatible with
> each other, we wouldn't need "per-SoC" compatible strings for each
> block. However in reality this doesn't happen, due to a combination
> of lack of time, lack of / uncertainty of documentation, and lack of
> hardware for testing by the contributors.
>
> The per-SoC compatible we ask people to add are a contigency plan,
> for when things don't actually work, and we need some way to support
> that specific piece of hardware on old DTs.

You are right up to here.

> At which point we will
> add that SoC-specific compatible as a new compatible string to the
> bindings. But not before.

No, the point SoC-specific compatibles is they are already present in
the DT and you only have to update the OS to fix issues. The SoC
specific compatible has to be documented when first used in dts files,
not when the OS uses them. That is the rule.

Rob

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
