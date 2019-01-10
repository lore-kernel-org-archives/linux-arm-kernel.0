Return-Path: <SRS0=vaNk=PS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C65CDC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 17:13:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9759C20874
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 17:13:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ZvgxXSd3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9759C20874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=v3.sk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=9zMF4lGIKvR77847d/D8t/qywQjDsdUNIKBGxjRF8dY=; b=ZvgxXSd38wiSuk
	3FbVkeNJbWfKBV6l3MDn8ppa9PR5DiDoN+cRMm356B6PsVqBbSXujFa2K7GCRt3yiyAanfZirv5+Y
	UNneIkUm3/CK0cOb9gvpds0K2D3ZQblgF9tN6AwZMHW+bG+u1y/0ALjL1Z/LywGX+ECxpm02UqxB8
	auuTyBYGmWBHDzwwY7JkJjiADnSPgid3fCpwP0qP/Hln8RFNvfUMucAir5DcjbkC8zJuRkaltF6uU
	Gm2tOhIEVdYsXyuGz8cpkOPGRGbAFfHAtTcJ26nd/F3Lw//AyMo2LWmI/MCBo7eqdLhoTJW0R5Nzk
	CNU9LGtC3NLL5Wdk7rMA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghdtG-0003Y0-Ne; Thu, 10 Jan 2019 17:13:10 +0000
Received: from shell.v3.sk ([90.176.6.54])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghdtD-0003XK-Gh
 for linux-arm-kernel@lists.infradead.org; Thu, 10 Jan 2019 17:13:09 +0000
Received: from localhost (localhost [127.0.0.1])
 by zimbra.v3.sk (Postfix) with ESMTP id E578F100296;
 Thu, 10 Jan 2019 18:13:01 +0100 (CET)
Received: from shell.v3.sk ([127.0.0.1])
 by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id KkhhTbL_Ncq1; Thu, 10 Jan 2019 18:12:59 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zimbra.v3.sk (Postfix) with ESMTP id A98641002DC;
 Thu, 10 Jan 2019 18:12:58 +0100 (CET)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
 by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id gqUusq9IuSHV; Thu, 10 Jan 2019 18:12:57 +0100 (CET)
Received: from belphegor (nat-pool-brq-t.redhat.com [213.175.37.10])
 by zimbra.v3.sk (Postfix) with ESMTPSA id 6C256100296;
 Thu, 10 Jan 2019 18:12:57 +0100 (CET)
Message-ID: <fb3a50bde8975ea6843508a3c4220ee8013069e1.camel@v3.sk>
Subject: Re: [PATCH v4 06/15] Platform: OLPC: Move EC-specific functionality
 out from x86
From: Lubomir Rintel <lkundrak@v3.sk>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 10 Jan 2019 18:12:56 +0100
In-Reply-To: <CAHp75Vf7ctTmncjOfMKL7MDAi=4rr2huBmZ7RsAnPKyJv7HTQQ@mail.gmail.com>
References: <20190108175818.705110-1-lkundrak@v3.sk>
 <20190108175818.705110-7-lkundrak@v3.sk>
 <CAHp75Vf7ctTmncjOfMKL7MDAi=4rr2huBmZ7RsAnPKyJv7HTQQ@mail.gmail.com>
User-Agent: Evolution 3.30.3 (3.30.3-1.fc29) 
Mime-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190110_091307_866402_EFC23DD8 
X-CRM114-Status: GOOD (  17.88  )
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
 devicetree <devicetree@vger.kernel.org>, James Cameron <quozl@laptop.org>,
 Linux PM <linux-pm@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "maintainer:X86
 ARCHITECTURE \(32-BIT AND 64-BIT\)" <x86@kernel.org>,
 Russell King <linux@armlinux.org.uk>,
 Platform Driver <platform-driver-x86@vger.kernel.org>,
 Rob Herring <robh+dt@kernel.org>,
 linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
 Pavel Machek <pavel@ucw.cz>, Sebastian Reichel <sre@kernel.org>,
 Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, 2019-01-09 at 13:23 +0200, Andy Shevchenko wrote:
> On Tue, Jan 8, 2019 at 7:59 PM Lubomir Rintel <lkundrak@v3.sk> wrote:
> > Move the olpc-ec driver away from the X86 OLPC platform so that it could be
> > used by the ARM based laptops too. Notably, the driver for the OLPC battery,
> > which is also used on the ARM models, builds on this driver's interface.
> > 
> > It is actually plaform independent: the OLPC EC commands with their argument
> > and responses are mostly the same despite the delivery mechanism is
> > different.
> > 
> > Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> > Acked-by: Pavel Machek <pavel@ucw.cz>
> >  #define OLPC_F_PRESENT         0x01
> >  #define OLPC_F_DCON            0x02
> > -#define OLPC_F_EC_WIDE_SCI     0x04
> 
> Still same concern, i.e. if the initially added definitions are
> coupled together by some reason, why we split them?
> As I told either move all, or none or put in commit message how
> decoupling would benefit.

I'm not moving this one -- I'm deleting it, because it's no longer used
or useful. I don't mind keeping it there if you think it should stay
though.

> > +       /* EC version 0x5f adds support for wide SCI mask */
> > +       if (ec->version >= 0x5f) {
> > +               __be16 ec_word = cpu_to_be16(bits);
> > +
> > +               return olpc_ec_cmd(EC_WRITE_EXT_SCI_MASK, (void *) &ec_word, 2, NULL, 0);
> 
> No space is needed in "(void *)&ec_word".
> 
> > +       } else {
> > +               unsigned char ec_byte = bits & 0xff;
> 
> Shouldn't be u8?
> 
> > +               return olpc_ec_cmd(EC_WRITE_SCI_MASK, &ec_byte, 1, NULL, 0);
> > +       }
> > +}
> > +EXPORT_SYMBOL_GPL(olpc_ec_mask_write);
> > +int olpc_ec_sci_query(u16 *sci_value)
> > +{
> > +       struct olpc_ec_priv *ec = ec_priv;
> > +       int ret;
> > +
> > +       if (WARN_ON(!ec))
> > +               return -ENODEV;
> > +
> > +       /* EC version 0x5f adds support for wide SCI mask */
> > +       if (ec->version >= 0x5f) {
> > +               __be16 ec_word;
> > +
> > +               ret = olpc_ec_cmd(EC_EXT_SCI_QUERY, NULL, 0, (void *)&ec_word, 2);
> > +               if (ret == 0)
> > +                       *sci_value = be16_to_cpu(ec_word);
> > +       } else {
> > +               unsigned char ec_byte;
> 
> u8?
> 
> > +
> > +               ret = olpc_ec_cmd(EC_SCI_QUERY, NULL, 0, &ec_byte, 1);
> > +               if (ret == 0)
> > +                       *sci_value = ec_byte;
> > +       }
> > +
> > +       return ret;
> > +}
> > +EXPORT_SYMBOL_GPL(olpc_ec_sci_query);

I'll follow up with fixes for the above.

Thanks.

Lubo


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
