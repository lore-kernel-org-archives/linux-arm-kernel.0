Return-Path: <SRS0=RmN+=PK=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20F69C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 02:18:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E352D2171F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 02:18:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="kn7FBN7u";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q/FK7wKA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E352D2171F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=/2Vo5YwqZV99JRso5HcUY1VgAEjEflTcw64qPE/MLpY=; b=kn7FBN7uR9JYpq
	sxyH8c8PBXue1ZDXZl4pxIL4GFc4nQILBLeQhaAXJ6N3fhD6l7WYMkFHGIMcQnAjjZr9mNuh4KKOl
	5KrfhrSN1Iy2XdQAzq+x1UPw8OMK4x34PC3dNpEkRRJw5qvUWbnL3OoUiKktQ8cxmWHFb8xu++x8y
	88fs1O1VEvfhFcqpurd2mDxTu8m19s8mMAK/YdidiqR70lraBdf0m7lmJ4NErcwV4Wwda1iHtzjlJ
	Nf2t/e0+aH18s71lr67+Keq3sqrWeeSFsZoZ7JCSvzAt0Cxgp5ruiBABCymDWUxROhau68Om0yvyE
	ATXr3YGQ8X365S+18xxg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1geW6t-0003sS-BF; Wed, 02 Jan 2019 02:18:19 +0000
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1geW6p-0003rC-4T
 for linux-arm-kernel@lists.infradead.org; Wed, 02 Jan 2019 02:18:16 +0000
Received: by mail-pf1-x441.google.com with SMTP id w73so14525290pfk.10
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 01 Jan 2019 18:18:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to
 :user-agent; bh=7xDoBsxjL/9axgZjE/eujXcLSvapi3M61/4VaHpVYlk=;
 b=Q/FK7wKAi+CV+qI2Qe6dNoo5WOyW1NMIKQeiCJAQRbRYIOiA5VTx3DE7DVFOQVmUgt
 fxamEOckC5bhhaVS7If37fdVOECTpaBp3dxeMWSCH0fw6ZaHGcKDzv6A/5rHeWG0UZA7
 zWdRU4kErM2eGrVH/JWqzkpcg3iVcdtDLV098=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=7xDoBsxjL/9axgZjE/eujXcLSvapi3M61/4VaHpVYlk=;
 b=ADp0c8YVl/4CMsXTk40PqmpWuLuMbRTEmkpAABtTpWIMy/lH0z3VoD2xkNZny7rMEG
 uvYUWDr2UroerzgdijBifui7owjW22Tm207ykPc/rqijR/IVz21ku9iC8uNvtPwUoXjE
 kqrfZmD8pDM7iHusy6Sn5DCFALGhD7QxLSgNKzwgZFLuSZqK01iy/vCWSxiMnQe7i4hE
 4XTNXCBsjUagwlzl9HT+WG0abE4KsBKEK/fyNEiVYo8oXCgi2V9OcMfPDeNF2ZSZbupm
 9Am1EuEsORoPqMTfZcRENrJHGv0jyPiBWIvWYg6gzRSr0AIZMSWp4HihQ0IYeRi6BKat
 QW4A==
X-Gm-Message-State: AA+aEWZp60MZU1tzipQ4Wa3RapvjaqU9+as3nlvamKnUG/86hwJTGgN+
 LZavltXIWxQ2z/pP0Vha+b/E
X-Google-Smtp-Source: ALg8bN5SUCGVmvhme59s+8LtsbcA++xANlPWDiYXloYoDEXcIZLGke+BRJXtXhX2kE9wbeWAV9u8+w==
X-Received: by 2002:a62:33c1:: with SMTP id
 z184mr42657566pfz.104.1546395493326; 
 Tue, 01 Jan 2019 18:18:13 -0800 (PST)
Received: from Mani-XPS-13-9360 ([2409:4072:710:efc6:504b:339d:2535:e1e1])
 by smtp.gmail.com with ESMTPSA id e65sm94457177pfc.74.2019.01.01.18.18.08
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 01 Jan 2019 18:18:12 -0800 (PST)
Date: Wed, 2 Jan 2019 07:48:05 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Joe Perches <joe@perches.com>, afaerber@suse.de
Subject: Re: [PATCH 6/6] MAINTAINERS: Add linux-actions mailing list for
 Actions Semi
Message-ID: <20190102021805.GA3955@Mani-XPS-13-9360>
References: <20181231185517.18517-1-manivannan.sadhasivam@linaro.org>
 <20181231185517.18517-7-manivannan.sadhasivam@linaro.org>
 <2a7f53c58896e2a9c3115a8630040b98497e5877.camel@perches.com>
 <20190101032622.GC2736@Mani-XPS-13-9360>
 <a935ceb348e5b4efb754484da745425afa1e7713.camel@perches.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <a935ceb348e5b4efb754484da745425afa1e7713.camel@perches.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190101_181815_185269_339E8AA7 
X-CRM114-Status: GOOD (  18.10  )
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
Cc: devicetree@vger.kernel.org, sboyd@kernel.org, mturquette@baylibre.com,
 linux-actions@lists.infradead.org, linux-kernel@vger.kernel.org,
 robh+dt@kernel.org, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Joe,

On Tue, Jan 01, 2019 at 08:56:49AM -0800, Joe Perches wrote:
> On Tue, 2019-01-01 at 08:56 +0530, Manivannan Sadhasivam wrote:
> > Hi Joe,
> =

> Hi Manivannan.
> =

> > On Mon, Dec 31, 2018 at 11:12:18AM -0800, Joe Perches wrote:
> > > On Tue, 2019-01-01 at 00:25 +0530, Manivannan Sadhasivam wrote:
> > > > Add the linux-actions mailing list for Actions Semi SoC architectur=
e.
> > > =

> > > Unrelated to adding this L: entry
> > > =

> > > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > []
> > > > @@ -1240,6 +1240,7 @@ ARM/ACTIONS SEMI ARCHITECTURE
> > > >  M:	Andreas F=E4rber <afaerber@suse.de>
> > > >  R:	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > >  L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscri=
bers)
> > > > +L:	linux-actions@lists.infradead.org (moderated for non-subscriber=
s)
> > > >  S:	Maintained
> > > >  N:	owl
> > > =

> > > The N: entry matches too many non-owl entries like:
> > > =

> > > Documentation/parport-lowlevel.txt
> > > drivers/misc/ibmasm/lowlevel.c
> > > drivers/misc/ibmasm/lowlevel.h
> > > fs/udf/lowlevel.c
> > > net/ipv6/ip6_flowlabel.c
> > > sound/soc/samsung/lowland.c
> > > =

> > > Maybe there should be two entries
> > > =

> > > N:	/owl
> > > N:	-owl
> > > =

> > =

> > Thanks for letting us know. Yes, we need to change it. How about below?
> > =

> > N: owl-
> > N: -owl
> > =

> > Will do it as a follow-up patch if agreed!
> =

> from MAINTAINERS:
> =

> 	   scripts/get_maintainer.pl has different behavior for files that
> 	   match F: pattern and matches of N: patterns.  By default,
> 	   get_maintainer will not look at git log history when an F: pattern
> 	   match occurs.  When an N: match occurs, git log history is used
> 	   to also notify the people that have git commit signatures.
> =

> F: entries are preferred to N: entries because the
> get_maintainer.pl script does not assume that the
> N: entries are exclusively maintained.  Maybe use a
> more comprehensive F: list like:
> =

> F:	Documentation/devicetree/bindings/*/*owl-*
> F:	arch/arm/boot/dts/owl-*
> F:	drivers/*/owl-*
> F:	drivers/*/*-owl*
> F:	drivers/*/*/owl-*
> F:	drivers/*/*/*-owl*
> F:	include/dt-bindings/power/owl-*
> F:	include/linux/soc/actions/owl-sps.h
> =


Makes sense!

Andreas: What is your opinion on above entries?

Thanks,
Mani

> =


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
