Return-Path: <SRS0=Ql45=PY=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C09BC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 21:29:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF42420868
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 21:29:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GOKM8thm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF42420868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=pISITbmkTch5RaREsb+TJ9fgd1ijVDwKvIEtBTKNvfc=; b=GOKM8thmxT6SA0
	ROpX82J6pkFxmlGWqHQ3J2laSdfyDULN/bYVkEYVsfHy51BQaMpq2cpW2C7QR8oLZjqL3Wo0rvJ2z
	pe7u+ud0HOC5E30IGRAN3xe7A0QpoKK5P8skAKYcpRK4oZYVn+0dd5w/3K62i2n5HQYxBUgUMqqha
	EE7jwcBQIXnw2tul6q4LXaHy4ZxhzIhaOUGIzPkH62r2J32t4/DzBpbRC+eqI94+eOgGnxpb4U7v9
	EJq+DN0PL0+Y01Xrqmk/RX08klSc9C2wZqZx/obxlHjawIghXTblyy7bvkLFozxQgPV9e89fc4Cat
	/+j5dD/i0PtjENtfqzHQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjskj-0004TE-PK; Wed, 16 Jan 2019 21:29:37 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjskd-0004R8-Sk; Wed, 16 Jan 2019 21:29:34 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id 05F3B207AC; Wed, 16 Jan 2019 22:29:26 +0100 (CET)
Received: from localhost (lfbn-lyo-1-59-119.w86-202.abo.wanadoo.fr
 [86.202.150.119])
 by mail.bootlin.com (Postfix) with ESMTPSA id CFEB0206A6;
 Wed, 16 Jan 2019 22:29:25 +0100 (CET)
Date: Wed, 16 Jan 2019 22:29:26 +0100
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: Re: [PATCH v5 2/2] rtc: support for the Amlogic Meson RTC
Message-ID: <20190116212926.GG2627@piout.net>
References: <20181202220847.24364-1-martin.blumenstingl@googlemail.com>
 <20181202220847.24364-3-martin.blumenstingl@googlemail.com>
 <85aa8e12-0bca-6432-e1a8-0faceff1dd5e@codethink.co.uk>
 <CAFBinCBDUxTc+ofCYm-zEeiFdU90U6DQOkX4B659q=MvRK64fg@mail.gmail.com>
 <CAFBinCAY7+-zA5-hY6oXmFz2i8aj9wFJsb-HBbKt_Swn9BtMMg@mail.gmail.com>
 <CAFBinCCKeb+wGJ4h_PfsT-Ms8AtLmNSwStTpeMqA3shkySjGkg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAFBinCCKeb+wGJ4h_PfsT-Ms8AtLmNSwStTpeMqA3shkySjGkg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190116_132932_081205_37D510D1 
X-CRM114-Status: GOOD (  18.06  )
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
Cc: linux-rtc@vger.kernel.org, a.zummo@towertech.it, ccaione@baylibre.com,
 linux-kernel@vger.kernel.org, ben.dooks@codethink.co.uk,
 linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 12/01/2019 13:52:00+0100, Martin Blumenstingl wrote:
> Hi Ben,
> 
> On Tue, Dec 18, 2018 at 12:48 AM Martin Blumenstingl
> <martin.blumenstingl@googlemail.com> wrote:
> >
> > Hi Ben,
> >
> > On Wed, Dec 5, 2018 at 11:15 PM Martin Blumenstingl
> > <martin.blumenstingl@googlemail.com> wrote:
> > [...]
> > > > > Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> > > > > [resurrected Ben's patches after 2 years]
> > > > > Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> > > >
> > > > Just checking if the change of author is deliberate?
> > > > not sure how to do >1 author on patches like this.
> > > I changed the author on purpose after seeing how much I changed
> > > (compared to your v4). this is also why I added you to the CC list
> > > however, I left in your copyright (just like you kept Carlo's
> > > copyright note) and MODULE_AUTHOR
> > please let me know:
> > 1. whether you want to be the author of the patch or if you're fine
> > with my name in there
> > 2. if you are fine with both of us being listed as Signed-off-by or if
> > you want me to switch to Co-authored-by
> > 3. about any other concerns you have
> >
> > I would like to update this patch next weekend so it can be reviewed
> > (and merged once all is fine) for v4.22
> gentle ping on this one now that the holiday season is over.
> 

I would think you can resend as they are. Or, you could resend v4 from
Ben and then a patch with your modifications.


-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
