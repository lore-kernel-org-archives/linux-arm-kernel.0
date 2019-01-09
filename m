Return-Path: <SRS0=Odjb=PR=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EF92C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 10:13:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7DF12064C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 10:13:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lBFDo/o5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7DF12064C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=uLCLJ3ycYNorlzGcVNaWvCyG5eR9F7flEjVfBpPw4og=; b=lBFDo/o5ypIQSl
	AnohCLLynvh0W3S3aCLw5VPa3rWP5cQGBXDHDAys617ejWbSEJ7IXdv829O708eZmyW9rU5JIAvvB
	kFF0R4A4mR93J45kNlSDSfyd1sw4b8UjdZrt7AsUUb/TCZlcp0uNxSFEaCxgoldpyIPU7xJPA1qKS
	dGM63WAJhjzOhEb9bPyaZDBWu7CdbszMyx0XY7U7W3CbgQ99oPdn/773olQb2unt2ncOkYOxxquAQ
	x+A1H1aypJZPwmra9eu80sMVRtReJvy+gF8J4CSiBZMjDg+vCTqVjwU+kmiIXBPdEH2SmgyhDiEes
	2J1o3Ag9SQ/D42pCGC0w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghArq-0008FL-Nw; Wed, 09 Jan 2019 10:13:46 +0000
Received: from mail-ed1-f67.google.com ([209.85.208.67])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghArn-0008Ep-0E
 for linux-arm-kernel@lists.infradead.org; Wed, 09 Jan 2019 10:13:44 +0000
Received: by mail-ed1-f67.google.com with SMTP id g22so6806781edr.7
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 09 Jan 2019 02:13:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=n7yQbhSiniQkONQT8QwDM7yKGzR8/XPXa9/njSg9+oE=;
 b=LyS9EeF9aB55f53P2EXd1/roGyWzEnI/STHMeQ3BtkRuMg+SCzBmtj+7FZUZkhkiQ6
 xktTeD7X2SYyEfbw1zryGXFZR09Q8K4UvYrLANb7ct/n6Tdu0VAVnzm+a1Yro78OmYuZ
 yhA1vC+cOn2PRBwZNd3Ngmdu5kuoNAh9hnQFIyFcwWmCN7O14Ck8TBXEiOoMb64lqWRL
 vX3wKvlNKpjyoFjY3TORTeA1f7SGOXSDlj2K9BRirlxpgJLX2pYimt4aFzSQqAZPKx5q
 C8uhnjctn7waIF5OGZaT6tIzigwTjApzCmcSNqslOiNzHiKtChf0fGTpKUbtQpLd/nJV
 fFTQ==
X-Gm-Message-State: AJcUukfE3yZb28eYaf9gQ8v4BoL1e4dKhW4BefDp0tfcVi+Qxqsyg2Ze
 utmLQ8nUilxkgm2G8/DBuRBDamEYG4M=
X-Google-Smtp-Source: ALg8bN4JRa5/tWUCU+ZKuHhY8mvwFAkYbTG6Yyc3fzGXFfbeY85vBcXzf1HdIjCGBuYLvWeE4isLqg==
X-Received: by 2002:a17:906:5795:: with SMTP id
 k21-v6mr4966805ejq.238.1547028820408; 
 Wed, 09 Jan 2019 02:13:40 -0800 (PST)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com.
 [209.85.221.52])
 by smtp.gmail.com with ESMTPSA id q4sm864778eda.50.2019.01.09.02.13.39
 for <linux-arm-kernel@lists.infradead.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 09 Jan 2019 02:13:40 -0800 (PST)
Received: by mail-wr1-f52.google.com with SMTP id s12so7058418wrt.4
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 09 Jan 2019 02:13:39 -0800 (PST)
X-Received: by 2002:adf:a1d2:: with SMTP id v18mr4272475wrv.87.1547028819339; 
 Wed, 09 Jan 2019 02:13:39 -0800 (PST)
MIME-Version: 1.0
References: <20190108191840.16007-1-jernej.skrabec@siol.net>
 <20190109101228.alsaaw6s57dbapfe@flea>
In-Reply-To: <20190109101228.alsaaw6s57dbapfe@flea>
From: Chen-Yu Tsai <wens@csie.org>
Date: Wed, 9 Jan 2019 18:13:24 +0800
X-Gmail-Original-Message-ID: <CAGb2v64QM9gyPTtpw0C0fpANW5R9DEsWFSDA_tJPYhdgF_FAhQ@mail.gmail.com>
Message-ID: <CAGb2v64QM9gyPTtpw0C0fpANW5R9DEsWFSDA_tJPYhdgF_FAhQ@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: sun8i: h3: Add ethernet0 alias to Beelink X2
To: Maxime Ripard <maxime.ripard@bootlin.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190109_021343_036189_6DB372EA 
X-CRM114-Status: GOOD (  13.81  )
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
 linux-kernel <linux-kernel@vger.kernel.org>,
 linux-sunxi <linux-sunxi@googlegroups.com>, Rob Herring <robh+dt@kernel.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Jan 9, 2019 at 6:12 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> On Tue, Jan 08, 2019 at 08:18:40PM +0100, Jernej Skrabec wrote:
> > Because "ethernet0" alias is missing, U-Boot doesn't generate board
> > specific MAC address. Effect of this is random MAC address every boot
> > and thus new IP address is assigned to the board.
> >
> > Fix this by adding alias.
> >
> > Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
>
> Applied, thanks!
> Maxime

Might we add a fixes tag, so the patch gets backported?

ChenYu

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
