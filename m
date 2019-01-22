Return-Path: <SRS0=B2vk=P6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9C5DC37122
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 02:16:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7878D21721
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 02:16:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bUdlKLd/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7878D21721
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=n4D0zDMTiY186z6oEUvWJr7LSiqWTnawK9jpIyuLjPQ=; b=bUdlKLd/vfQze1
	mfM/A13NNtvz+RIR1/B7/HD8ThurGeXUj2LkQOXWUbQoIyOnSQEu8uuP+GULw5PsEaz9fkMd7e1bB
	0MVm0haWwkjoXyMjJ5f6zq363u4SDt32TxwbocdvZGNwOakZOKb+O3bwdCy/764xrUtjI6xX+GpPs
	nb2KDmkxiD65Xh3xYqHW9IERAbkVkW9hPtNUjwKVAAZuzO2CFDH0AU3+T7YT0XKJh+SmTZZYF4TZX
	cEO+qzf4ZPciSkUjFhnuswpBp8NB2D2ggecuVmuXADF20fHyFUwX+//+uVmDae0eulCUPR9dclqTt
	VYDBGy68KR7aXQ+6Stcg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gllcB-0001cR-KB; Tue, 22 Jan 2019 02:16:35 +0000
Received: from mail-ed1-f47.google.com ([209.85.208.47])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gllc7-0001bg-2I
 for linux-arm-kernel@lists.infradead.org; Tue, 22 Jan 2019 02:16:32 +0000
Received: by mail-ed1-f47.google.com with SMTP id b3so18145844ede.1
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 21 Jan 2019 18:16:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=7SoHKgLs7vVuHGn81uBAUlpOTQtoImghD8Y6F22vX1k=;
 b=l1dctmMDvH5aTnSJ47vbEhChEDPfjQf4SKRty/M71cOeSm+O4ZeWeFU0cRSa8cx8bu
 r2l16Pl7vDvXUQTq1eMLgCAzaq8FcKOsaqkK2MeEXsNSw058ZAHSsOPHb9bewzWtOBSs
 ydaVWWEGhiQetMqX6pLD0MGmQZEa9wViC1gOtu5iv6wsYoOfgC957S1A0NZGP1vBGqYK
 wlH7YqlwQ7iD464WsCqQ4FE4BOWwc0uj1NYMcB55lrIxnsfXpfznCsIIar2GecHIRiGH
 6DAPgoLvcF8OtKVStILo8ackw6u8TwMmaTTbM1pf1pllAVUZn2sYKrw03RIk95yj3cSq
 mrAQ==
X-Gm-Message-State: AJcUukd0G9hFnyPdlPGBNfWdju9CSRM2qi9FxuvGNYdRybKnANZBcwY1
 NKzs747lYNgs90VQaH0ig9l0aJ9iiyM=
X-Google-Smtp-Source: ALg8bN7muipKT4sSMHm/T1SWDfmI/x+qWhAwXtkNHTp8IYhf9UzUhlxfFCu5MP7KJpFPxnfMqaArNw==
X-Received: by 2002:a50:d94a:: with SMTP id u10mr28590847edj.214.1548123387656; 
 Mon, 21 Jan 2019 18:16:27 -0800 (PST)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com.
 [209.85.128.42])
 by smtp.gmail.com with ESMTPSA id x10sm9430444edb.58.2019.01.21.18.16.27
 for <linux-arm-kernel@lists.infradead.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 21 Jan 2019 18:16:27 -0800 (PST)
Received: by mail-wm1-f42.google.com with SMTP id t200so12704081wmt.0
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 21 Jan 2019 18:16:27 -0800 (PST)
X-Received: by 2002:a1c:c008:: with SMTP id q8mr1378866wmf.99.1548123386752;
 Mon, 21 Jan 2019 18:16:26 -0800 (PST)
MIME-Version: 1.0
References: <20190111173015.12119-1-jernej.skrabec@siol.net>
 <20190111173015.12119-2-jernej.skrabec@siol.net>
 <CAGb2v66DiqK9sL-hQev4Wy08d9T7f1Yc2DFWJ0gYOnqChJyBRw@mail.gmail.com>
 <20190121095014.b6iq5dubfi7x2pi4@flea>
 <CAGb2v66d0wM8Yt2uS4MMhU6PP02h8CKwKjinasO6jtZ4ue1CAQ@mail.gmail.com>
 <20190122001917.GA31407@bogus>
In-Reply-To: <20190122001917.GA31407@bogus>
From: Chen-Yu Tsai <wens@csie.org>
Date: Tue, 22 Jan 2019 10:16:13 +0800
X-Gmail-Original-Message-ID: <CAGb2v67YsevDvjvTSh67wJNSJSUBuZ613hQWyorEiSzCUqjjkQ@mail.gmail.com>
Message-ID: <CAGb2v67YsevDvjvTSh67wJNSJSUBuZ613hQWyorEiSzCUqjjkQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] media: dt: bindings: sunxi-ir: Add A64 compatible
To: Rob Herring <robh@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190121_181631_104518_1537980B 
X-CRM114-Status: GOOD (  27.79  )
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

On Tue, Jan 22, 2019 at 8:19 AM Rob Herring <robh@kernel.org> wrote:
>
> On Mon, Jan 21, 2019 at 05:57:57PM +0800, Chen-Yu Tsai wrote:
> > On Mon, Jan 21, 2019 at 5:50 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> > >
> > > Hi,
> > >
> > > I'm a bit late to the party, sorry for that.
> > >
> > > On Sat, Jan 12, 2019 at 09:56:11AM +0800, Chen-Yu Tsai wrote:
> > > > On Sat, Jan 12, 2019 at 1:30 AM Jernej Skrabec <jernej.skrabec@siol.net> wrote:
> > > > >
> > > > > A64 IR is compatible with A13, so add A64 compatible with A13 as a
> > > > > fallback.
> > > >
> > > > We ask people to add the SoC-specific compatible as a contigency,
> > > > in case things turn out to be not so "compatible".
> > > >
> > > > To be consistent with all the other SoCs and other peripherals,
> > > > unless you already spotted a "compatible" difference in the
> > > > hardware, i.e. the hardware isn't completely the same, this
> > > > patch isn't needed. On the other hand, if you did, please mention
> > > > the differences in the commit log.
> > >
> > > Even if we don't spot things, since we have the stable DT now, if we
> > > ever had that compatible in the DT from day 1, it's much easier to
> > > deal with.
> > >
> > > I'd really like to have that pattern for all the IPs even if we didn't
> > > spot any issue, since we can't really say that the datasheet are
> > > complete, and one can always make a mistake and overlook something.
> > >
> > > I'm fine with this version, and can apply it as is if we all agree.
> >
> > I'm OK with having the fallback compatible. I'm just pointing out
> > that there are and will be a whole bunch of them, and we don't need
> > to document all of them unless we are actually doing something to
> > support them.
>
> Yes, you do. Otherwise, how will we validate what is and isn't a valid
> set of compatible strings? It's not required yet, but bindings are
> moving to json-schema.

Ideally, if we knew which IP blocks in each SoC were compatible with
each other, we wouldn't need "per-SoC" compatible strings for each
block. However in reality this doesn't happen, due to a combination
of lack of time, lack of / uncertainty of documentation, and lack of
hardware for testing by the contributors.

The per-SoC compatible we ask people to add are a contigency plan,
for when things don't actually work, and we need some way to support
that specific piece of hardware on old DTs. At which point we will
add that SoC-specific compatible as a new compatible string to the
bindings. But not before.

ChenYu

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
