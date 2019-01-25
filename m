Return-Path: <SRS0=vAN3=QB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0BC0C282C6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 02:30:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 916AF218CD
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 02:30:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="c+qTWJO9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 916AF218CD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Hi5+5K92IGZWU5jBebVMueahTbKtWyWifw81g3HR0CY=; b=c+qTWJO9j/HNCL
	zS2GSJuJ4Xz5E90rbgY4IrdviUZ/4uFL3q3eDIctPQV+3dtEkMkNWBE9v492tyzN13CWRm1BSEHkY
	UQ1JoE/hYyDDYh2RetNst2NbDf4TQjtuTbDe8+uVtbn4VSUz90nc2ldmIivMaZqFMSD4EtG+0WO1C
	aRmJhYqm5WoZVMD/vH7Pvv4oisHaut+qSKTrFNKGCN+zfv3s+WNzSELYfXT/63byPAc+U+9gx93v+
	cZgx8JVA1VqGfuT9XBWX38XOL7VLF674LkJxr/cG+AEW+Bzi78EUwSrvn1T9QU7GeyLLzSfh4GRKn
	7NxQeW6v4gYV4jnBr/1A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmrFc-0004Ao-Bk; Fri, 25 Jan 2019 02:29:48 +0000
Received: from mail-ed1-f65.google.com ([209.85.208.65])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmrFD-00040Y-5A
 for linux-arm-kernel@lists.infradead.org; Fri, 25 Jan 2019 02:29:25 +0000
Received: by mail-ed1-f65.google.com with SMTP id y20so6199798edw.9
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 24 Jan 2019 18:29:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=y+BmC2uXY8ot1UEWIZyOUHne2SSY9VMJ558CzqzKfKE=;
 b=jxc6Qi/BEr886FpX1XUAoxkf31IchHirGk9QiIODOCC3St2MYixIWG7yx7+vObjO+H
 93ue1wwAJiWJSDJ+6gE+3lF1cFG9sBYyJDtDLXrEpktQNFiR4bLycfU3uikssc6lf6Kh
 79e5GMinwfVS5sROZ5mALIheHtelZhfsa56RKSyVgVo/feE6PcoYnRvFEdLYi4qLsQTc
 oHzU8HFvu8JUHOmHGFTkoZTQgS6jvP4zM5GHCJ/AUy1GQFymVugajW75I3F42tKMUDSJ
 67RKhzYLNanorxGojFT90N3Nkr43jpMLgURTggRRAG7ohzBmw6UYehGOJpdS6m3Zc6Ye
 DAaw==
X-Gm-Message-State: AJcUukeHWAAyzk0WQ3fhzD1GLQYGQaBm3vxh9XhwxBgN5dluyawb57ea
 f59fW2ty01G2YAeF80O0WjFQjXp0ur8=
X-Google-Smtp-Source: ALg8bN4Uon0mtolJjZP7d0ACEmqpMkJqWqZ0W1jQHphpq5iRNl01W1YvAVmYmhYsmDjkc1io0eUKcA==
X-Received: by 2002:a50:ad55:: with SMTP id z21mr8764206edc.74.1548383361308; 
 Thu, 24 Jan 2019 18:29:21 -0800 (PST)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com.
 [209.85.221.47])
 by smtp.gmail.com with ESMTPSA id k12sm655128ejz.4.2019.01.24.18.29.20
 for <linux-arm-kernel@lists.infradead.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 24 Jan 2019 18:29:20 -0800 (PST)
Received: by mail-wr1-f47.google.com with SMTP id p4so8654474wrt.7
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 24 Jan 2019 18:29:20 -0800 (PST)
X-Received: by 2002:a5d:4f10:: with SMTP id c16mr9694148wru.177.1548383360301; 
 Thu, 24 Jan 2019 18:29:20 -0800 (PST)
MIME-Version: 1.0
References: <20190111173015.12119-1-jernej.skrabec@siol.net>
 <20190111173015.12119-2-jernej.skrabec@siol.net>
 <CAGb2v66DiqK9sL-hQev4Wy08d9T7f1Yc2DFWJ0gYOnqChJyBRw@mail.gmail.com>
 <20190121095014.b6iq5dubfi7x2pi4@flea>
 <CAGb2v66d0wM8Yt2uS4MMhU6PP02h8CKwKjinasO6jtZ4ue1CAQ@mail.gmail.com>
 <20190122001917.GA31407@bogus>
 <CAGb2v67YsevDvjvTSh67wJNSJSUBuZ613hQWyorEiSzCUqjjkQ@mail.gmail.com>
 <CAL_Jsq+u2PdLK3YaYMERHndNpN_PprksPF9gVF+V76c343yrMg@mail.gmail.com>
In-Reply-To: <CAL_Jsq+u2PdLK3YaYMERHndNpN_PprksPF9gVF+V76c343yrMg@mail.gmail.com>
From: Chen-Yu Tsai <wens@csie.org>
Date: Fri, 25 Jan 2019 10:29:07 +0800
X-Gmail-Original-Message-ID: <CAGb2v67saMfK58vSx7=Mhq6Z06Qbj+vmbFv7=psddzB1X-GHkA@mail.gmail.com>
Message-ID: <CAGb2v67saMfK58vSx7=Mhq6Z06Qbj+vmbFv7=psddzB1X-GHkA@mail.gmail.com>
Subject: Re: [PATCH 1/3] media: dt: bindings: sunxi-ir: Add A64 compatible
To: Rob Herring <robh@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190124_182923_362505_178A99A3 
X-CRM114-Status: GOOD (  33.57  )
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

On Tue, Jan 22, 2019 at 9:38 PM Rob Herring <robh@kernel.org> wrote:
>
> On Mon, Jan 21, 2019 at 8:16 PM Chen-Yu Tsai <wens@csie.org> wrote:
> >
> > On Tue, Jan 22, 2019 at 8:19 AM Rob Herring <robh@kernel.org> wrote:
> > >
> > > On Mon, Jan 21, 2019 at 05:57:57PM +0800, Chen-Yu Tsai wrote:
> > > > On Mon, Jan 21, 2019 at 5:50 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> > > > >
> > > > > Hi,
> > > > >
> > > > > I'm a bit late to the party, sorry for that.
> > > > >
> > > > > On Sat, Jan 12, 2019 at 09:56:11AM +0800, Chen-Yu Tsai wrote:
> > > > > > On Sat, Jan 12, 2019 at 1:30 AM Jernej Skrabec <jernej.skrabec@siol.net> wrote:
> > > > > > >
> > > > > > > A64 IR is compatible with A13, so add A64 compatible with A13 as a
> > > > > > > fallback.
> > > > > >
> > > > > > We ask people to add the SoC-specific compatible as a contigency,
> > > > > > in case things turn out to be not so "compatible".
> > > > > >
> > > > > > To be consistent with all the other SoCs and other peripherals,
> > > > > > unless you already spotted a "compatible" difference in the
> > > > > > hardware, i.e. the hardware isn't completely the same, this
> > > > > > patch isn't needed. On the other hand, if you did, please mention
> > > > > > the differences in the commit log.
> > > > >
> > > > > Even if we don't spot things, since we have the stable DT now, if we
> > > > > ever had that compatible in the DT from day 1, it's much easier to
> > > > > deal with.
> > > > >
> > > > > I'd really like to have that pattern for all the IPs even if we didn't
> > > > > spot any issue, since we can't really say that the datasheet are
> > > > > complete, and one can always make a mistake and overlook something.
> > > > >
> > > > > I'm fine with this version, and can apply it as is if we all agree.
> > > >
> > > > I'm OK with having the fallback compatible. I'm just pointing out
> > > > that there are and will be a whole bunch of them, and we don't need
> > > > to document all of them unless we are actually doing something to
> > > > support them.
> > >
> > > Yes, you do. Otherwise, how will we validate what is and isn't a valid
> > > set of compatible strings? It's not required yet, but bindings are
> > > moving to json-schema.
> >
> > Ideally, if we knew which IP blocks in each SoC were compatible with
> > each other, we wouldn't need "per-SoC" compatible strings for each
> > block. However in reality this doesn't happen, due to a combination
> > of lack of time, lack of / uncertainty of documentation, and lack of
> > hardware for testing by the contributors.
> >
> > The per-SoC compatible we ask people to add are a contigency plan,
> > for when things don't actually work, and we need some way to support
> > that specific piece of hardware on old DTs.
>
> You are right up to here.
>
> > At which point we will
> > add that SoC-specific compatible as a new compatible string to the
> > bindings. But not before.
>
> No, the point SoC-specific compatibles is they are already present in
> the DT and you only have to update the OS to fix issues. The SoC
> specific compatible has to be documented when first used in dts files,
> not when the OS uses them. That is the rule.

We also want to be able to differentiate between per-SoC compatibles
vs actual backwards-compatible tuples, such as

    - "allwinner,sun8i-r40-rtc", "allwinner,sun8i-h3-rtc"

found in Documentation/devicetree/bindings/rtc/sun6i-rtc.txt .

In the future, if someone has the time to do an in-depth comparison
and testing, they should be able to deprecated and/or remove the per-SoC
compatible strings that we added for contingency from the bindings.

As such, I'd like implementors to not target the SoC-specific compatibles,
unless imcompatiblities are discovered, at which point the bindings would
also be updated, removing the fallback compatible.

The SoC-specific compatible strings are really a workaround for the lack
of resources of the community supporting this platform, while being able
to support DT stability. I want to make it clear in some way visible to
all that this is an exception, not the norm. And I'd also like to leave
the door open to later cleanup.

What would be an acceptable way to do this? Add extra notes accompanying
the per-SoC compatibles?

Regards
ChenYu

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
