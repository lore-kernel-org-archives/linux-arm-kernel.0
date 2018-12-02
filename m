Return-Path: <SRS0=zgA4=OL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD691C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 22:35:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FC6520881
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 22:35:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="UYm3Mm7D";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="jOP7iBQu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FC6520881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=3T4Tyv2ryKqLXm+p5CTfWBpqVifiSKvQuem/pbyK2oc=; b=UYm3Mm7D7lxi3U
	acMDTLyiotG3MPwRIjIRAF+tNb6QGCYwTPWpS/bVbEmdy5hhgIqKh2u9bKKonXC69GSv5wmj2dAgi
	1t8gBOw7dV87MMU8TpK3oTOOY0SemUWRbaZji1umSDFiAVYrEtdft+0chP30b5JODhp5WePuEFKc4
	1+pGRqzj973NCMR32W43DUWlaFaUBXAivbnNME+gslp2MKdqfJMiMzTJ2z3BaO0+A867ADtEubfKF
	U3c5i525dSZM9favj+lp2ibUlo8OkdTGg/s9j/u6MHd3ZCWyQXlp2/ScPaTOTVz8lYU+jpb0bey7v
	MRvL7LnPTOSdEcn+slGA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTaLA-00019k-Py; Sun, 02 Dec 2018 22:35:52 +0000
Received: from mail-qt1-x842.google.com ([2607:f8b0:4864:20::842])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTaL6-00019I-It
 for linux-arm-kernel@lists.infradead.org; Sun, 02 Dec 2018 22:35:50 +0000
Received: by mail-qt1-x842.google.com with SMTP id l11so11798587qtp.0
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 02 Dec 2018 14:35:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jms.id.au; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Skq7Nk66uKbHPDaWITxydr3bznpZc6wV1G4sQvhyxJE=;
 b=jOP7iBQuijGwwQb31gorluZ3vOOcixj8aEcRI4UaEqaUh/s38vzwWw4vdFgz9JNRM8
 Poq8wt1jn2EcF02JVGVeBDHwBOE8rQcIqI6k6pm1qIh07k4l8uv2B4CCxF4iL+/+jgxT
 sqJtbDP6ehA4ibpJ+p3ca2cAAIwwCO1cOz/Hg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Skq7Nk66uKbHPDaWITxydr3bznpZc6wV1G4sQvhyxJE=;
 b=Q+MqP2fjG+bxcrjSUzeTjjc5lZQC2mPPSy4uwp/c/PQalmaRzMgKNwzWSrsejmEF6w
 kjoa7Rm+ilpCDruAVAvCMEZ1UdeBG6icxagY4MXQxqvaOWxGiR/a/BDrLicVprxSutfN
 Js7ez5/W8Kk6nxJJyBTxh8y7r+iMgfYalwC4v2xWDdBbd6IgZn4xbHEXEW8kLDhNIg6Y
 rscPsZDaZ5HRWufMP6bzoqppjIHqyIk9rAOtEslYwC9VeHC3B3PEQ9RD2Tps2+VKsCSg
 f3JJIcAM4XmEB/Heli4gwoo4Tdn4qXpo814bOrf7SA4mlnKWGLsw8mjpT2pL0sXt8Pvl
 KPgQ==
X-Gm-Message-State: AA+aEWaL47go2egwEwww7iZKexNcWEDaGntwGo6YJvbNj1zAcnxYlouK
 UGv84Gjyan7bRqqUQIBBprnbq0ULK7JGr2bgtfQ=
X-Google-Smtp-Source: AFSGD/Wj7SVn3SxZ8VVACU3t56hru/3rDqr3AnYc+MWEw7n/o8kL6M0mBpt8U8ebYP90zzAYs7+j65UT2dxXyNf6RZ4=
X-Received: by 2002:a0c:a4a3:: with SMTP id x32mr13485430qvx.89.1543790136932; 
 Sun, 02 Dec 2018 14:35:36 -0800 (PST)
MIME-Version: 1.0
References: <20181130015251.20754-1-robh@kernel.org>
 <20181130232040.z4i4sm5dsycxbmlu@localhost>
In-Reply-To: <20181130232040.z4i4sm5dsycxbmlu@localhost>
From: Joel Stanley <joel@jms.id.au>
Date: Mon, 3 Dec 2018 09:05:25 +1030
Message-ID: <CACPK8XeGny9xqQ7VUy033TEd9ybSV5GpN9wzSHT7itxqkH6dxA@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: aspeed: add missing memory unit-address
To: Olof Johansson <olof@lixom.net>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181202_143548_671933_AB00CB4C 
X-CRM114-Status: GOOD (  12.49  )
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
Cc: Rob Herring <robh@kernel.org>, linux-aspeed@lists.ozlabs.org,
 devicetree <devicetree@vger.kernel.org>, Andrew Jeffery <andrew@aj.id.au>,
 arm <arm@kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Sat, 1 Dec 2018 at 10:27, Olof Johansson <olof@lixom.net> wrote:
>
> On Thu, Nov 29, 2018 at 07:52:51PM -0600, Rob Herring wrote:
> > The base aspeed-g5.dtsi already defines a '/memory@80000000' node, so
> > '/memory' in the board files create a duplicate node. We're probably
> > getting lucky that the bootloader fixes up the memory node that the
> > kernel ends up using. Add the unit-address so it's merged with the base
> > node.
> >
> > Found with DT json-schema checks.
> >
> > Cc: Joel Stanley <joel@jms.id.au>
> > Cc: Andrew Jeffery <andrew@aj.id.au>
> > Cc: devicetree@vger.kernel.org
> > Cc: linux-arm-kernel@lists.infradead.org
> > Cc: linux-aspeed@lists.ozlabs.org
> > Signed-off-by: Rob Herring <robh@kernel.org>
> > ---
> > Might be better to just remove the node altogether from the SoC dtsi
> > file. It's only saving the device_type definition.
>
> Since I'm sweeping DT pull requests right now, and this is pretty
> straightforward, I've applied it to next/dt directly.

Thanks Rob and Olof.

Cheers,

Joel

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
