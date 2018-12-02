Return-Path: <SRS0=zgA4=OL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E972BC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 22:32:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9AD920892
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 22:32:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="krMq2y8C";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VruXrSCq";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SmrWPVeM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9AD920892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=IFu8B6sh+01voOzFRh3ioVQcm0T0KWasyTDGukVEBj4=; b=krMq2y8CojBoPG
	UdpPIWI1yXq2P2EKb4mV5O5tAeKPeqQGPyvfqRRIH6aAk8gYYVPDtZOwGXhjyv5HbyPlOS8j/6fXx
	bhUObUl5Bwc6OYuzxS5XGOjZ+efeJE8laqhWEaAHOwDvyYH0TEv6LoLroueNppph0wFzNaEgVaH7x
	ODgzt2zGBWKwcXjV4Xok2EGlzYZ5ukSe3WqpNv8Aj6pmFA++Pky+LBjJI8up6NxtVQiPkjd8ZyzsP
	KIqUYqyr+245OYX7pKFEX9dOm4FmiBFtGnLaobzsPl6iAOi+AGRGhsgThBHPzbFT3zz7y0IqhF56l
	Viy7orsAsWyULoReMtSw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTaHa-0007kT-OE; Sun, 02 Dec 2018 22:32:10 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTaGy-0006wi-AS
 for linux-arm-kernel@bombadil.infradead.org; Sun, 02 Dec 2018 22:31:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=s7MLxOLgy54TthfzdvQqHtgHm8zv/9fThKbgwRvdpVM=; b=VruXrSCqiR4Vm/EI3efp2dEMJ
 XBR6f0WhBDSvJCFR0a7eFKotpI3BA2bvVd8hy4bKvna+QyrY8RVxW3K9cDwSmwDiqYBeC53QlLykf
 ZMApBQ/Bp+7ZcwbK3YEl7X3jhhPLAUj3yfKdg51juWSbX/cTR4GgtBzyeGBq7bEno0suhbspMf1JY
 DLup6vo+cQY1n/vG1Z3jUvsdDJBzBmte3szQqrnApi1f+5Ro7193DAoLDMX+iC3oApNmsJ9thxgQ3
 +H+oulOgcP8R2JZN8j2GzmhRf6I0mBRK9FRImJtTkaXC86onrOX39sm6jnnTWg56feyJEGiqCcVg1
 rRkHG1vOw==;
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443])
 by merlin.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTYKO-0002Bb-E5
 for linux-arm-kernel@lists.infradead.org; Sun, 02 Dec 2018 20:26:57 +0000
Received: by mail-wr1-x443.google.com with SMTP id r10so10033378wrs.10
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 02 Dec 2018 12:26:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=s7MLxOLgy54TthfzdvQqHtgHm8zv/9fThKbgwRvdpVM=;
 b=SmrWPVeMp763B6LtYCYlKA9vmxoi6Z7EmHBM8uEocYHgvG9Azt3BSsm6Ceb9zaKc+x
 +IzuKYlX566MkJqoyquGbhpVG1LNKZpGdv2cc5pbtNt013igktfmXnyvZ/8JKFciZDO2
 DSnIAp1NQXkfOZs3zqAOY/MtfwsByhr0FHsha0XxuMSxn74DTp2wY0v8PtLTEIb1sxNo
 jEKO85XdFBHTDin7+LxTzKSdKiC7dtAxIuXJ5e3KaH7Y17FDddTABzuii1c873MOpxi0
 dtTbKp9q5SHxmO5Nze1lHp5fUYlY+c/vOOlZ3B+9FtrzKTl7NjrpGEKBwLXeR+dNwS2d
 82Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=s7MLxOLgy54TthfzdvQqHtgHm8zv/9fThKbgwRvdpVM=;
 b=nXQSfHyE21+WkuG/dPJnISMNYWT10OsRtWqoj1HgUxOzgPyUWiOB/h08Ej3mL4G1HH
 OwI9fjxGxHsktXUsq8rUA8m3q9rNAOwP5T+sPICgI9MckKmCH8T68OWaTmjaVPfgM0Uw
 wVg08wrnKTmp10yrNrQBgM0zuJR6QYN1znpKGl+OA8apSw9S7gNL5J3w//xZYSRlkclX
 Hok4W2My8SWxok1Q+IFbOlMSfaog05VB8lV0KY5X0uq/UPk6NNxVmJdrjN9li82QXebb
 KyTnotEW7QnIW8MVe6GA3WWD7IflWV6cG/yUiEX0BtUvVpUBDeEgffE0VNhOf1kV3PzV
 Jpow==
X-Gm-Message-State: AA+aEWbEWvolnvfywOY/rPDvYT6tnU8WYUmA16B2Evm4334H15csKHTp
 NN7/5OGjNabaz3jQigaXSJQ=
X-Google-Smtp-Source: AFSGD/VktoL7NCwY1/VreWsmiy08/RhD6hdDHtIHQHucfG9sidK3HrY6SxVdtrzFRAotD0QhWHHrJQ==
X-Received: by 2002:a5d:4286:: with SMTP id k6mr11613380wrq.225.1543782404558; 
 Sun, 02 Dec 2018 12:26:44 -0800 (PST)
Received: from localhost ([185.219.177.152])
 by smtp.gmail.com with ESMTPSA id 125-v6sm6507648wmr.22.2018.12.02.12.26.43
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 02 Dec 2018 12:26:44 -0800 (PST)
Date: Sun, 2 Dec 2018 23:26:42 +0300
From: Mesih Kilinc <mesihkilinc@gmail.com>
To: Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v5 13/17] clk: sunxi-ng: add support for suniv F1C100s SoC
Message-ID: <20181202202642.y5me76jyktzbfzbd@ThinkPad>
References: <cover.1543443475.git.mesihkilinc@gmail.com>
 <cc1357c9272628b4d89af007cead83117d9ba6e9.1543443475.git.mesihkilinc@gmail.com>
 <154345243603.88331.17915868280143383591@swboyd.mtv.corp.google.com>
 <20181129063952.623svjr7pti7apah@ThinkPad>
 <154353465409.88331.8677593357765162802@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <154353465409.88331.8677593357765162802@swboyd.mtv.corp.google.com>
User-Agent: NeoMutt/20180716-631-34bcda
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181202_152656_552296_C21D3509 
X-CRM114-Status: GOOD (  18.37  )
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
Cc: devicetree@vger.kernel.org, Marc Zyngier <marc.zyngier@arm.com>,
 Julian Calaby <julian.calaby@gmail.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, linux-kernel@vger.kernel.org,
 Russell King <linux@armlinux.org.uk>, linux-gpio@vger.kernel.org,
 linux-sunxi@googlegroups.com, Rob Herring <robh+dt@kernel.org>,
 Maxime Ripard <maxime.ripard@free-electrons.com>, Chen-Yu Tsai <wens@csie.org>,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Icenowy Zheng <icenowy@aosc.io>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 18/11/29 03:37, Stephen Boyd wrote:
> Quoting Mesih Kilinc (2018-11-28 22:39:52)
> > On 18/11/28 04:47, Stephen Boyd wrote:
> > > Quoting Mesih Kilinc (2018-11-28 14:33:23)
> > > > diff --git a/drivers/clk/sunxi-ng/ccu-suniv-f1c100s.c b/drivers/clk/sunxi-ng/ccu-suniv-f1c100s.c
> > > > new file mode 100644
> > > > index 0000000..d4bc1b8
> > > > --- /dev/null
> > > > +++ b/drivers/clk/sunxi-ng/ccu-suniv-f1c100s.c
> > > > @@ -0,0 +1,541 @@
> > > > +/*
> > > > + * Copyright (c) 2016 Icenowy Zheng <icenowy@aosc.io>
> > > > + *
> > > > + * SPDX-License-Identifier: GPL-2.0
> > > 
> > > Please fix this location.
> > 
> > I am very sorry, I should have been more carefull. Should I resend whole
> > patchset or just resending this patch is enough? 
> > 
> 
> Just this one? Who do you intend to pick up these patches?
> 

I have send as v6 patchset. Thanks! 

Mesih

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
