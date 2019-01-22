Return-Path: <SRS0=B2vk=P6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEAB2C3712D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 00:19:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E4BD2089F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 00:19:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qaQVzrNP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E4BD2089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Xb1Am3WGUYcxNjUwVQ8URBnarP7yVtQ9vvA/R6wuC3Y=; b=qaQVzrNPOzB78L
	HMYGEeiuVdTNlLWPn+UdmXLpNJujyeCQ2rM07zEKZcKdev5qNurTwKXEKgDnRDCjNAl0nrSA2zfq1
	RPQb0YzVokl+S2aBpeRZZ4rM4UiQk+B8j8FJkHMz8kmj0NeHBuilYzZoAy7mViB+uyTHhiyuo/pdj
	38Adyw5SE+29rsvYEAOfHBF6u73aMYzyxWYqTo1UVpUQqVMT5mPOyLk9DkZZcgJrWCHwSpIxw/ftw
	HCx7p3HtKEieoQ1y3jmOZCmB/rzS3Ibq37aNCRWkzquccxAe00sow8wR5MUBbCQ8qZKgSP2bhnNbu
	+wiLGh5Y+68ix4x03QuQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gljmk-00026R-Ts; Tue, 22 Jan 2019 00:19:22 +0000
Received: from mail-ot1-f67.google.com ([209.85.210.67])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gljmi-000267-5K
 for linux-arm-kernel@lists.infradead.org; Tue, 22 Jan 2019 00:19:21 +0000
Received: by mail-ot1-f67.google.com with SMTP id k98so22137957otk.3
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 21 Jan 2019 16:19:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=5uCyXnnGfFbiQg6fSTWCRBCQgl6eqCHGAfdzWE9E2OY=;
 b=GPEww3jRuiZylIPcmmbZZDldRHbT6w9ESc0YASp6JgTF4vBc5RHCFOTyeBakCJi1lp
 4fFM7vqQW5VX9DRGcT8OsV8ju+vW5fewbjGT/dGUXggCDb5TVNo7TZlspuW/I+UnCC4V
 2gaN5tNc22xHOOBXyhQEVMRxRlAg7nV4Rej2g0oVY3zHVgJ9hVDNLmcxWYuR4LxAECQq
 5hg4JNaHSmPC29a5Lf2WxHyePMopZDeJymnHBktqXi1mDOYnee/RiAXMxoX6JhO5azmw
 NOQihI43cc/m4HJdknoSe8vHnEXOPPr/lJKZ5UO6XWXvtc1MxBRhoWE6ExqKrYsq4uYC
 Y3+w==
X-Gm-Message-State: AJcUukd7du5b9v1xNmyCN3doYVFIrciR0CaWrKo3e7XemRF2XBW9qvgd
 vBw0Kiacsc8P1ZhrFgNF6TpGE5vyqg==
X-Google-Smtp-Source: ALg8bN5tGyQfgsz8Qibh5c9U/V1vKGStMgN7eNkGmxtb8BiQO+UrRmQ9ow9YayylM9E6/Hs3EDyNIA==
X-Received: by 2002:a9d:77d4:: with SMTP id w20mr20274216otl.196.1548116359080; 
 Mon, 21 Jan 2019 16:19:19 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id l20sm6204181otp.47.2019.01.21.16.19.18
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 21 Jan 2019 16:19:18 -0800 (PST)
Date: Mon, 21 Jan 2019 18:19:17 -0600
From: Rob Herring <robh@kernel.org>
To: Chen-Yu Tsai <wens@csie.org>
Subject: Re: [PATCH 1/3] media: dt: bindings: sunxi-ir: Add A64 compatible
Message-ID: <20190122001917.GA31407@bogus>
References: <20190111173015.12119-1-jernej.skrabec@siol.net>
 <20190111173015.12119-2-jernej.skrabec@siol.net>
 <CAGb2v66DiqK9sL-hQev4Wy08d9T7f1Yc2DFWJ0gYOnqChJyBRw@mail.gmail.com>
 <20190121095014.b6iq5dubfi7x2pi4@flea>
 <CAGb2v66d0wM8Yt2uS4MMhU6PP02h8CKwKjinasO6jtZ4ue1CAQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAGb2v66d0wM8Yt2uS4MMhU6PP02h8CKwKjinasO6jtZ4ue1CAQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190121_161920_244203_2665B0E2 
X-CRM114-Status: GOOD (  25.20  )
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

On Mon, Jan 21, 2019 at 05:57:57PM +0800, Chen-Yu Tsai wrote:
> On Mon, Jan 21, 2019 at 5:50 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> >
> > Hi,
> >
> > I'm a bit late to the party, sorry for that.
> >
> > On Sat, Jan 12, 2019 at 09:56:11AM +0800, Chen-Yu Tsai wrote:
> > > On Sat, Jan 12, 2019 at 1:30 AM Jernej Skrabec <jernej.skrabec@siol.net> wrote:
> > > >
> > > > A64 IR is compatible with A13, so add A64 compatible with A13 as a
> > > > fallback.
> > >
> > > We ask people to add the SoC-specific compatible as a contigency,
> > > in case things turn out to be not so "compatible".
> > >
> > > To be consistent with all the other SoCs and other peripherals,
> > > unless you already spotted a "compatible" difference in the
> > > hardware, i.e. the hardware isn't completely the same, this
> > > patch isn't needed. On the other hand, if you did, please mention
> > > the differences in the commit log.
> >
> > Even if we don't spot things, since we have the stable DT now, if we
> > ever had that compatible in the DT from day 1, it's much easier to
> > deal with.
> >
> > I'd really like to have that pattern for all the IPs even if we didn't
> > spot any issue, since we can't really say that the datasheet are
> > complete, and one can always make a mistake and overlook something.
> >
> > I'm fine with this version, and can apply it as is if we all agree.
> 
> I'm OK with having the fallback compatible. I'm just pointing out
> that there are and will be a whole bunch of them, and we don't need
> to document all of them unless we are actually doing something to
> support them.

Yes, you do. Otherwise, how will we validate what is and isn't a valid 
set of compatible strings? It's not required yet, but bindings are 
moving to json-schema.

Rob

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
