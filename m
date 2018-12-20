Return-Path: <SRS0=AHqO=O5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BAFFC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 16:33:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7DB021773
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 16:33:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="eBF6zhKp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7DB021773
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=hQGNU7NsfX+mYy+hKSFewKNAd77BRlPaKJTKtTTN2cM=; b=eBF6zhKpC4t4RT
	KoBHAVscmvS+eTgG7OXpKbc7FFfMyk5y7SbWyz37KDjgwJ03WjbJVWf2KwHhzL7jO9OhBSZMTFzl6
	+OOot9SVcZpXECKCTVxqvsvm4fV2Daoflk91uTw6bpW73XfIvBMydzn24u1uRdCFKnya/HZIXpMVA
	qDisohij9RBI63HR8SmU/HGFBujb9AL0kfg2vgcdCr9oJ3ameZqpH0hyWUblJMecRQw7bU9/Lu5fr
	RCc+mp0dVT0fq3vmHe/ARbq04qJr6WkcZ1ufoHK6Y2qIgL4AoI1pzaQRBF6WJuo/D062cRhFLRDEy
	3NJh7iXcS0GtUczH8qVA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ga1GG-0006hR-Qt; Thu, 20 Dec 2018 16:33:24 +0000
Received: from mail-qk1-f193.google.com ([209.85.222.193])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ga1GD-0006eh-64; Thu, 20 Dec 2018 16:33:22 +0000
Received: by mail-qk1-f193.google.com with SMTP id n12so1334696qkh.11;
 Thu, 20 Dec 2018 08:33:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=V6Ic7Z+ngRTDyQ6H5HIiPmOMadMWGa69OQrX5EZVtow=;
 b=ejr54KcbOxx++vcrSDeHWqJg/FgouYhAHzC1O6sJiaTS7zNIo/tgYc3aQ9EiZzngBf
 4+mwEc2g4hWnmR9QrqUfLWTHq0XRs6eYp3vNkI2EtNtAGgTx2q679Fy0yp9DRCBxzelB
 47oUjR4on+LBE1LwpuOBJDc4IFEglpTymjtHxNyacU5pCWXEhvppen2b1JLAEhNMA6BM
 A6uPpwZv2r/zKijp1uJGGRShOYGT495T3JxHVcHOdiqXM9Ft5WIJDzK5PLHE46O0+q11
 MezjYodt1TpxMtcyarvbkvJfv6IXP5/lELbqVrPm7lKDKCnQCDcbOyBjwHGJDrpLpS7q
 81vg==
X-Gm-Message-State: AA+aEWbA6M6PgP17U+2DZeBNVFRchtgvy/L6oj6saTU9UtZ8HyWPm82l
 KaRTUY5mtuLaakj/0OJLcpWeHaO06O2thvOW0bM=
X-Google-Smtp-Source: AFSGD/XUJrTtOMLVyN5Y+bkHUNpb1AKSctnSCnglyp+v8O6pqZf31x9HVgbj7BotlF1ZVq0lE8bHQR/X4h1qRcnlqAc=
X-Received: by 2002:ae9:d8c2:: with SMTP id
 u185mr24053922qkf.107.1545323589901; 
 Thu, 20 Dec 2018 08:33:09 -0800 (PST)
MIME-Version: 1.0
References: <20181216084854.GJ13243@dragon>
 <CAK8P3a34R+Gv+H8_jjGP452i2kSqq+u0PsE-4pDnRRtY14SG0w@mail.gmail.com>
 <a73f86ff-15ce-9512-bbf0-be852cf39a35@kontron.de>
 <CAK8P3a1PMoR-WWcb_G8sTVW9HKUKvKfUZmcinkOEy9mJ5c=Lxw@mail.gmail.com>
 <6dde2248-da0d-7bd3-801b-b42b2974c038@kontron.de>
In-Reply-To: <6dde2248-da0d-7bd3-801b-b42b2974c038@kontron.de>
From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 20 Dec 2018 17:32:52 +0100
Message-ID: <CAK8P3a0WCOcVjSegBKRPw3kkokE8S4JEXManqBkq4CjfcBRSMg@mail.gmail.com>
Subject: Re: [GIT PULL] FSL QSPI device tree cleanup for 4.21
To: frieder.schrempf@kontron.de
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181220_083321_222577_75595BA7 
X-CRM114-Status: GOOD (  19.93  )
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
Cc: linux-spi <linux-spi@vger.kernel.org>, arm-soc <arm@kernel.org>,
 linux-mtd <linux-mtd@lists.infradead.org>, linux-imx@nxp.com,
 Sascha Hauer <kernel@pengutronix.de>, Fabio Estevam <fabio.estevam@nxp.com>,
 Shawn Guo <shawnguo@kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Dec 20, 2018 at 5:23 PM Schrempf Frieder
<frieder.schrempf@kontron.de> wrote:
>
> On 20.12.18 17:11, Arnd Bergmann wrote:
> > On Thu, Dec 20, 2018 at 5:03 PM Schrempf Frieder
> > <frieder.schrempf@kontron.de> wrote:
> >>
> >> Hi Arnd,
> >>
> >> On 20.12.18 16:50, Arnd Bergmann wrote:
> >>> On Sun, Dec 16, 2018 at 9:50 AM Shawn Guo <shawnguo@kernel.org> wrote:
> >>>>
> >>>> Hi,
> >>>>
> >>>> As the series cleans up both i.MX/Freescale arm32 and arm64 device
> >>>> trees, the pull request is based on a merge of tag imx-dt-4.21 and
> >>>> imx-dt64-4.21 that have already been pulled into arm-soc next/dt branch.
> >>>> This comes a bit late, and we appreciate it if you can pull it for 4.21,
> >>>> as it paves the way for new QSPI driver under SPI framework to land in
> >>>> the next release cycle.  Thanks.
> >>>
> >>> Pulled into next/dt. For my understanding, what is going to happen
> >>> with the fsl-quadspi mtd driver? Will it remain as part of the kernel
> >>> to support old DTB files, or will that transitions mean those stop
> >>> working with new kernels and have to be updated the same way?
> >>
> >> Thanks for pulling these late changes. The old SPI NOR driver
> >> (fsl-quadspi.c) will be replaced by the new SPI driver. Old dtb files
> >> will work with the new driver if they already have the reg properties
> >> set up correctly (which should be the case, but who knows what setups
> >> exist out-of-tree).
> >
> > Ok, good.
> >
> >> There will be a performance penalty though if you do not set
> >> spi-[tx/rx]-bus-width to 4.
> >
> > I guess that's acceptable, but what is the reason for requiring
> > this? Would it be possible to have the qspi driver add those
> > properties and print a warning whenever the dtb doesn't
> > already contain them?
>
> As the new driver is a SPI driver, the common rules in
> Documentation/devicetree/bindings/spi/spi-bus.txt apply and
> spi-[tx/rx]-bus-width are defined to default to 1 if not specified.
> So we can't set those properties in the driver if they are missing in
> the dtb as we would deviate from the standard, although it would make
> more sense for a *Quad*-SPI driver to default to 4.

Right, I guess that makes sense.

Now, you could change the binding for the fsl-quadspi driver to
require the bus-width properties, which would then just make
the old dtb files invalid, and you give us an excuse to override
the properties by adding the =4 ones, once that is documented
in the driver specific binding.

Since it's only a performance difference, I suppose we can live
with the limitation and stay a little closer to the normal binding.

     Arnd

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
