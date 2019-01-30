Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17C0CC282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 21:12:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C21CE218AF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 21:12:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="o35UTy+O";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="yghME5RO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C21CE218AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=tW3cV9MbEJJlA0srW0xhJSp4Olorz4TyM7/fju02tTA=; b=o35UTy+OH3jeLu
	PGWUlNnHBRr81Dmryk1PkVlXx3UKw1PI8V3doFOCzMbTP9QFwZKHTiUsmlAAaim0uiGg0O9JuWhe1
	3YR1Lj7wtDUuQ3Kn+FnBmEeVyDc8YPHJyrGPllUoGRW/GcwAirB+ALHve3wDdM6XbtgkKIyKGr19g
	Tk/QKRGQZkijPEQEBf0aeI+aJJObF4qWS0+4tsZPcn3OETlKLTuh2NC1as8+fb+BgK7y2xIyjhJPj
	r71MjdX29bL0ep07f3kvrYx+HY+r7LQ1zB6xwn6Tfa2lDBs8AufPQhZKC0TVwconsjCE7q+FskRBl
	Wg6xGwPOQa+mvRyDj9ZQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gox9w-00047e-VA; Wed, 30 Jan 2019 21:12:36 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gox9t-00047C-P5; Wed, 30 Jan 2019 21:12:35 +0000
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id CBFA2218AF;
 Wed, 30 Jan 2019 21:12:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1548882753;
 bh=Yqt6SM7PMKFBikFCGORlO+/wGTguLWm650gwRlVzdfQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=yghME5ROvkceOHz0qC/lzqRWBdIK3ynwBTmFPhftUBoeJ4oe6LuMuWHomuT8Ge3/z
 bgYlJsjY7qcHZdhh7+mL0kLzWYEBXqoWmOsOP9fg5UystRulO4GoO7NGafhU39GlbF
 TTLVtfKucBwB4HrzOLxttDjrN63IPIqEkMi656B8=
Date: Wed, 30 Jan 2019 22:12:31 +0100
From: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To: Carlos Henrique Lima Melara <charlesmelara@outlook.com>
Subject: Re: [PATCH v2] staging: mt7621-eth/ethtool.c: Correction of SPDX
 license identifier
Message-ID: <20190130211231.GA25919@kroah.com>
References: <SC1P15201MB2014C3E0CAB4DA9ADF330797A8900@SC1P15201MB2014.LAMP152.PROD.OUTLOOK.COM>
 <20190130152956.GA4195@kroah.com>
 <RO1P15201MB201234F951531D13328C4FF2A8900@RO1P15201MB2012.LAMP152.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <RO1P15201MB201234F951531D13328C4FF2A8900@RO1P15201MB2012.LAMP152.PROD.OUTLOOK.COM>
User-Agent: Mutt/1.11.2 (2019-01-07)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_131233_848569_D948DB3B 
X-CRM114-Status: GOOD (  21.75  )
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
Cc: "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "neil@brown.name" <neil@brown.name>,
 "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
 "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Jan 30, 2019 at 08:01:13PM +0000, Carlos Henrique Lima Melara wrote:
> On 30/01/2019 13:29, gregkh@linuxfoundation.org wrote:
> > On Wed, Jan 30, 2019 at 02:48:27PM +0000, Carlos Henrique Lima Melara wrote:
> >> 	This patch fix the checkpatch.p1 warning:
> >>
> >> 	WARNING: Missing or malformed SPDX-License-Identifier tag in line 1
> >> 	+/*
> >
> > Why did you not fix up the indentation that was already mentioned?
> 
> The Warning was about the missing SPDX License Identifier, so I added the 
> identifier according to the "license-rules.rst" for C source that is:

I mean the indentation of the text in your changelog, nothing to do with
the actual change in your patch below, sorry for the confusion.

> >   The SPDX license identifier is added in form of a comment.  The comment
> >   style depends on the file type::
> >
> >      C source:	// SPDX-License-Identifier: <SPDX License Expression>
> >      C header:	/* SPDX-License-Identifier: <SPDX License Expression> */
> >      ASM:	/* SPDX-License-Identifier: <SPDX License Expression> */
> >      scripts:	# SPDX-License-Identifier: <SPDX License Expression>
> >      .rst:	.. SPDX-License-Identifier: <SPDX License Expression>
> >      .dts{i}:	// SPDX-License-Identifier: <SPDX License Expression>
> 
> I think that was the correction needed, right?

Yes.

> Still have a question about the license comment in the "ethtooll.c". 
> 
> > /*   This program is free software; you can redistribute it and/or modify
> >  *   it under the terms of the GNU General Public License as published by
> >  *   the Free Software Foundation; version 2 of the License
> >  *
> >  *   This program is distributed in the hope that it will be useful,
> >  *   but WITHOUT ANY WARRANTY; without even the implied warranty of
> >  *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> >  *   GNU General Public License for more details.
> >  *
> >  *   Copyright (C) 2009-2016 John Crispin <blogic@openwrt.org>
> >  *   Copyright (C) 2009-2016 Felix Fietkau <nbd@openwrt.org>
> >  *   Copyright (C) 2013-2016 Michael Lee <igvtee@gmail.com>
> >  */
> 
> It puts 3 spaces between the * and the text, should it be corrected to 
> only one space?

If you really want to, but it's not needed.

All of the "boilerplate" license text can also be removed after the SPDX
line is added, if you want to do that.  But leave the copyright lines,
that needs to stay.

thanks,

greg k-h

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
