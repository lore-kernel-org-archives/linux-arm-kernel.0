Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16E49C10F01
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:08:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DBB8321917
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:08:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Sv7oqwKD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBB8321917
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=XXIdSEpe0yvCtg6Tg1CF7mY/mo+tyglQjt4myi+sC+Q=; b=Sv7oqwKD34G4yj
	L+fQOcUlG1p96lH/vtEBeA6bw/nvG6gGynO8Mu42PJNOZjut++3ehahi+21rmANv02PNlaKwzCNru
	AdEz5KC22kEPhAyCVDDvpFnB0rRFIekBWi4lMWrR7TrueXUy5Kig/E/UyP0FMKzvMrEbMNvm9aoLk
	Ave780ohWsOghF8pgziGIsjqGyZmZloWCNx5F1cbRCYhZN3yP+4VjbzsDT+N/Cz8dqHBV5BvASY/E
	qb0Yu8MdK3RgHsmrESaWcCAv6UsW4xqW/WtYpQh7JXbxa7f/XJY6Gu3/oMAwwna2qjXTKWhC8jXKK
	A/Q+eHYGu8n0z7jpdIYA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvjaZ-0000wU-OJ; Mon, 18 Feb 2019 14:08:07 +0000
Received: from szxga04-in.huawei.com ([45.249.212.190] helo=huawei.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvjaR-0000nD-H7
 for linux-arm-kernel@lists.infradead.org; Mon, 18 Feb 2019 14:08:03 +0000
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 9D2CE9194DBBE3854C73;
 Mon, 18 Feb 2019 22:07:51 +0800 (CST)
Received: from localhost (10.47.94.189) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.408.0; Mon, 18 Feb 2019
 22:07:49 +0800
Date: Mon, 18 Feb 2019 14:07:38 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Gregory CLEMENT <gregory.clement@bootlin.com>
Subject: Re: [PATCH 4/5] iio:adc:lpc32xx Cleanup headers
Message-ID: <20190218140738.0000582a@huawei.com>
In-Reply-To: <87r2c92h34.fsf@FE-laptop>
References: <20190208160944.13281-1-gregory.clement@bootlin.com>
 <20190208160944.13281-5-gregory.clement@bootlin.com>
 <20190209171646.49c75afc@archlinux> <87r2c92h34.fsf@FE-laptop>
Organization: Huawei
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
X-Originating-IP: [10.47.94.189]
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_060759_868996_BE44CD90 
X-CRM114-Status: GOOD (  21.07  )
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
Cc: devicetree@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Rob Herring <robh+dt@kernel.org>,
 linux-arm-kernel@lists.infradead.org,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Hartmut Knaack <knaack.h@gmx.de>, Jonathan Cameron <jic23@kernel.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, 15 Feb 2019 16:42:55 +0100
Gregory CLEMENT <gregory.clement@bootlin.com> wrote:

> Hi Jonathan,
>  =

>  On sam., f=E9vr. 09 2019, Jonathan Cameron <jic23@kernel.org> wrote:
> =

> > On Fri,  8 Feb 2019 17:09:43 +0100
> > Gregory CLEMENT <gregory.clement@bootlin.com> wrote:
> >  =

> >> A few headers was useless: remove them, and also sort them in alphabet=
ic
> >> order.
> >> =

> >> Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>  =

> > Hmm. Given the headers in question are mostly only useless (I think)
> > in the sense they are always included by something else, I'm
> > not sure this patch is worth the churn.
> >
> > It's also tricky to see which ones were actually removed
> > given the combination with sorting.
> > I think it's just kernel.h, device.h, err.h all of which
> > are used in various ways and often directly included.  =

> =

> Actually, as I needed to add a header, I wanted to sort the list to put
> it in the right place and then some of the header looked superfluous
> that why I remove some of them. For example there was no reason to use
> slab.h or of.h.
Agreed on those two. I missed them probably because of the re organization
being combined with them.  No specific allocations except
via interfaces from elsewhere and no direct use of the devicetree
stuff, so fine to drop them.

> =

> >
> > The other one is the iio/sysfs.h file.  That one we could
> > do to eventually kill off entirely, so happy to see that
> > one alone go.  =

> =

> I am nit sure to know what do you want with this patch.

Break it in two.  Drop the unwanted ones first, then reorganize.
That way the diff is easy to read.  Clearly I missed some
changes on my first read as it stands!

Jonathan

> =

> Gregory
> =

> =

> >
> > Jonathan
> >  =

> >> ---
> >>  drivers/iio/adc/lpc32xx_adc.c | 15 ++++-----------
> >>  1 file changed, 4 insertions(+), 11 deletions(-)
> >> =

> >> diff --git a/drivers/iio/adc/lpc32xx_adc.c b/drivers/iio/adc/lpc32xx_a=
dc.c
> >> index e361c1532a75..f391c1e10136 100644
> >> --- a/drivers/iio/adc/lpc32xx_adc.c
> >> +++ b/drivers/iio/adc/lpc32xx_adc.c
> >> @@ -7,20 +7,13 @@
> >>   *  Copyright (C) 2011, 2012 Roland Stigge <stigge@antcom.de>
> >>   */
> >>  =

> >> -#include <linux/module.h>
> >> -#include <linux/platform_device.h>
> >> -#include <linux/interrupt.h>
> >> -#include <linux/device.h>
> >> -#include <linux/kernel.h>
> >> -#include <linux/slab.h>
> >> -#include <linux/io.h>
> >>  #include <linux/clk.h>
> >> -#include <linux/err.h>
> >>  #include <linux/completion.h>
> >> -#include <linux/of.h>
> >> -
> >>  #include <linux/iio/iio.h>
> >> -#include <linux/iio/sysfs.h>
> >> +#include <linux/interrupt.h>
> >> +#include <linux/io.h>
> >> +#include <linux/module.h>
> >> +#include <linux/platform_device.h>
> >>  =

> >>  /*
> >>   * LPC32XX registers definitions  =

> >
> >
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel  =

> =




_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
