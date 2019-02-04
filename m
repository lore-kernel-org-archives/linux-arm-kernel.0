Return-Path: <SRS0=7SeU=QL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49B6BC282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 20:21:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18F8E2175B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 20:21:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="HTeph0Jo";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DaK44ok2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18F8E2175B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=L9MPD0d7d6rifSwqZj5/WOK+dRG6VtVfh9cJlhLT+D4=; b=HTeph0JoLI/2lg
	+3ltnPzGRyllsxIwCNhJ+1l5rNnLQAqXgmiNbT6YlH8MsRYpBDi0F3E/3kL/60vPuoLsit8Xwr+9L
	SlcTfMomm7lUFiW/+RU44FN9d+wg70Ope81mMWkBQC626S4ODblgV5EyjFp3XC8bsafDAM6m4uqkn
	28rYNMmzOzEQiWO3YVIVimjC7MOPiNTZrI+GRPfVsi3cfV3GOH+xRUX1bwWWlxNnFKgtIjnJBEDb6
	EB5A7Hay+/D/g/p8KZ47VaFwTpg6jaTZF7yhCVIkOwAdVIQKYQQP4AbtfH6BzR1TQ3iNnCT07bAVE
	j+4Tv8ZKW4YpNrfV3fnQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqkkQ-0001QJ-8t; Mon, 04 Feb 2019 20:21:42 +0000
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqkkN-0001N2-Ew
 for linux-arm-kernel@lists.infradead.org; Mon, 04 Feb 2019 20:21:41 +0000
Received: by mail-ot1-x342.google.com with SMTP id k98so2072452otk.3
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 04 Feb 2019 12:21:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=77PDMoZYnq2ZgZLEMPBVLN8rFVn+ehqiJapB9ocHbzI=;
 b=DaK44ok2frNNNyG9zL1VjYcPw2VABzR/6TfQAyRLr5l2r+M/Z3Abp7F6a6rHRzfiiG
 +tt6ueLxNUwbieiKPHokNauC2MV9rQMpJQ+jDVDnzFU3uzJ1/Kv6sLiVXbGf8bJv9J3g
 dyEqXivL2qyhUrkk+AMQcUTeumiaQyCLolG9feaTUzoQS2syGDvYhH3PEHxpM/x6nz8N
 o9fAGoum69c3VteDLWT6IlOieGZJyUdZq6tsptWbIeRubfLevBskJggw2I7lHuK71IGD
 qrK9a52CgXQFH0sRGqad9iqZtHZ25vzzVHBUKxxzGp3+fxeL91Lfws7hq8ofTZNeD6eF
 UhdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=77PDMoZYnq2ZgZLEMPBVLN8rFVn+ehqiJapB9ocHbzI=;
 b=nBY8kChnqu1GhWTS1pBp/q0lbPAhSbJbmR/tGnGAN/YOHIQu8bD2OeQRa3h0dJYC6+
 O++JKoK18FcSNnsb9aoISUji7DV45HaQ0MNL43nmoFRTaq8gE4GBgczncpHMDenvymc3
 h4wEnq8Ro5Uy5ZTwoZ0/NP4774grujuN9FbvPCP4TbOPYG59kf4tZtLCQihbGoybV9Ol
 V9C+hMaXw5KjgCrYiPStUvokZqwjN+2l/+ZCbWcbAi/rUK0cjSU/cGL0gVoKPFqNI7UP
 +C85Cug2Vie48AvsnYzVyKV1WbT/qeAzUzS/pf+XOPi7Mti0vqNzdw8NlooPFSdnZYwK
 8iyw==
X-Gm-Message-State: AHQUAubNX3ylmDuJIABO3q2zHDE2gsuST7calT6aoA8LtWt4IKY6msDe
 JHRo3DOaeMKV7rU8FvU6tbobyw/Ux2h7zSotlGk=
X-Google-Smtp-Source: AHgI3IYc78yXpnw/CsdPHuo/lUtmY85Ufmkv9hF0CtQ9Ti4M4Ip+jl38i3SEJWh5919XxqM65qhgOyfasVXkUBZrJIs=
X-Received: by 2002:aca:c142:: with SMTP id r63mr657213oif.98.1549311698096;
 Mon, 04 Feb 2019 12:21:38 -0800 (PST)
MIME-Version: 1.0
References: <20181018073327.64942-1-icenowy@aosc.io>
 <20190204122250.GB7660@lst.de>
In-Reply-To: <20190204122250.GB7660@lst.de>
From: Vasily Khoruzhick <anarsoul@gmail.com>
Date: Mon, 4 Feb 2019 12:21:42 -0800
Message-ID: <CA+E=qVfHMqo_ZWPTgvr+5G2J29Yy-TU4aceVD0oHLeyaOxVogA@mail.gmail.com>
Subject: Re: [PATCH 0/9] Analogix ANX6345 RGB-(e)DP bridge support
To: Torsten Duwe <duwe@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190204_122139_521485_1DC12219 
X-CRM114-Status: GOOD (  12.07  )
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
Cc: devicetree <devicetree@vger.kernel.org>,
 Archit Taneja <architt@codeaurora.org>, David Airlie <airlied@linux.ie>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 Andrzej Hajda <a.hajda@samsung.com>,
 linux-sunxi <linux-sunxi@googlegroups.com>, Rob Herring <robh+dt@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Maxime Ripard <maxime.ripard@bootlin.com>, Chen-Yu Tsai <wens@csie.org>,
 arm-linux <linux-arm-kernel@lists.infradead.org>,
 Icenowy Zheng <icenowy@aosc.io>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Feb 4, 2019 at 4:22 AM Torsten Duwe <duwe@lst.de> wrote:
>
> On Thu, Oct 18, 2018 at 03:33:18PM +0800, Icenowy Zheng wrote:
> > This patchset brings the support for Analogix ANX6345 RGB-(e)DP bridge,
> > which is used by some Allwinner A64 laptops, such as Pinebook and Olimex
> > TERES-I.
> >
>
> So what's the status here? I'm working on the Teres-I and I find myself
> recreating the chunks in this patchset almost verbatim (only DT so far),
> one by one, so there must be something right about them ;-)
>
> Whose turn is it?

I've sent v2 yesterday, however I tested it only on Pinebook.

>
>         Torsten
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
