Return-Path: <SRS0=3RVO=RB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A31C3C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 22:32:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72CA421873
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 22:32:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WIIHVJVW";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="ZtcxbkeS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72CA421873
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=sAhGnagcl5+jsMA41mmPFLN7O2S6lpmXFrYcMXr7IWk=; b=WIIHVJVWrxJEkV
	OzWSC2rLedpXVfHWyXLhd2/A0/ZauTe/ejbVkp79DEAeQlDDp+vLCaEDjMyx49GDGZ9tYNjbhhD9L
	LQwHm/83LIc30iXbN9dP0poc6A6kOscYClDdMkLmvQAvJNJUt1Y2D/+wFLJELPla4sA68o7tsNKll
	5UIW81w+od/Grw1V8nMU2sdqArcX1T1jfLbrxese7ABbnTlTuGhalF4a8aRl+ey7SkKlYFzt7lgOC
	xCgau/fOBSRIG352EUjNxcAJU7HZZ7JUMpGTIalo3JJngaLeNS0Tu+XdJTtX8MLUyaCf+RgscqPdn
	7MBJw1xAFLWZ75duPa2w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gylHD-0003F2-Uy; Tue, 26 Feb 2019 22:32:39 +0000
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gylHA-0003Ei-Hw
 for linux-arm-kernel@lists.infradead.org; Tue, 26 Feb 2019 22:32:37 +0000
Received: by mail-pg1-x544.google.com with SMTP id 196so6869216pgf.13
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 26 Feb 2019 14:32:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Syx8ZkNs6xbsqFqTcYYoT2xEMErvYw1Uy1r0qmWNWd4=;
 b=ZtcxbkeSYtP27F/OOI0Pu+kjr63YzODu9uoJl3hFPFbF3VvFzLY5zJabn4WrfiuacV
 uKW5KEZsPiaWKuFQRu0aF+2OtKFucTN/1Tbd0MjjZDpLojkebfGiZTCCUMg6iXf1GDVl
 vAcGsKFhSHofZdoUsPSHXmdFSddQU2i05OcCVV9NwNGUI2vLaibQra6ikQwh/VKazRNN
 qIEBEA16ltUQLNc9zl392e4M16j4o6fYNXoYjpj7PMQMsn04hvl4NhM1F4S6Jz1v3AEq
 sJ8C4VhdFuXroGu+fp5MDKMqGT7wHnIgOZX2Fa8cnUFMxqvYf8IK6HIhAHZ/RCGYTaVn
 M/rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Syx8ZkNs6xbsqFqTcYYoT2xEMErvYw1Uy1r0qmWNWd4=;
 b=FX6E3eDFWFBHYpldA9J5vHjbc/RhmP129VeLfv1un5TfDX7Aegynkdon744QZtXjfD
 PBiSGvkC+pqClPJJzwYg4vzHkS+usu+P0oTFrj9Ib7eM9xSLb1BBWsFwjW380la7M8Oc
 OwvpIMQAWovOgbuEurp3RtM/oHqwM1wd6JDzDwDj++I4IbiDGlVfbs03SD4y8WMmUYnx
 EufYiLRuQX1FaYsUeNxRGlLYJritaZJerGSxmOp7pGLYMB4LHgfi6fzl++hUyY/Kcik8
 ezUW46ldBh3ApYZhd/DsnBE4pVzXq8hXnmOa2aM0Z1aXFefy/hjprvXjziciCItDK/9D
 KQug==
X-Gm-Message-State: AHQUAuawvORzXM3uCo2+Z6OLcfpBUcw7SdJ+B1f2ksOMKRL2mVtB8maP
 N2fvrbJKcRkvYEGThIinm8f4H9CYCDfOJWFyoa7s4u4oGOc=
X-Google-Smtp-Source: AHgI3IbKi9AkmGDsGP2NQpNGQ/bfU2eNowpnC4gnQGIRYLj+rGrVReHQEyzTuCo1LynV5tgaPg4gkjH/G6QVNNoF6ds=
X-Received: by 2002:a65:43cc:: with SMTP id n12mr25610546pgp.218.1551220355672; 
 Tue, 26 Feb 2019 14:32:35 -0800 (PST)
MIME-Version: 1.0
References: <20190221222537.137331-1-venture@google.com>
 <692c6c5d-9090-4e1f-9324-a03da381b003@www.fastmail.com>
 <CAO=notx+p5PQ1UXW7XKD=5Lb23RvC5+1R+LcJLxXYEnT6vvgkQ@mail.gmail.com>
 <CAO=notx1OTWbxg5EhgqDUcrpfBpgez3LXXrNKHX5VpOark3GvA@mail.gmail.com>
 <578fe6cd-cc7c-4f6d-8f7e-39c9f183a8e4@www.fastmail.com>
In-Reply-To: <578fe6cd-cc7c-4f6d-8f7e-39c9f183a8e4@www.fastmail.com>
From: Patrick Venture <venture@google.com>
Date: Tue, 26 Feb 2019 14:32:24 -0800
Message-ID: <CAO=notzjZQYeNo8nFmDfj+cw=hAMEmQ7GX-5ccY5786rMC_NEA@mail.gmail.com>
Subject: Re: [PATCH 2/2] drivers/misc: Add Aspeed P2A control driver
To: Andrew Jeffery <andrew@aj.id.au>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190226_143236_617731_9BCCA8A0 
X-CRM114-Status: GOOD (  13.63  )
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
Cc: Arnd Bergmann <arnd@arndb.de>, linux-aspeed@lists.ozlabs.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Joel Stanley <joel@jms.id.au>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Feb 26, 2019 at 2:20 PM Andrew Jeffery <andrew@aj.id.au> wrote:
>
>
>
> On Wed, 27 Feb 2019, at 08:26, Patrick Venture wrote:
> > On Tue, Feb 26, 2019 at 1:42 PM Patrick Venture <venture@google.com> wrote:
> > >
> > > On Sun, Feb 24, 2019 at 5:26 PM Andrew Jeffery <andrew@aj.id.au> wrote:
> > > >
> > >
> > > >
> > > > > +
> > > > > +     /* Access to these needs to be locked, held via probe, mapping ioctl,
> > > > > +      * and release, remove.
> > > > > +      */
> > > > > +     struct mutex tracking;
> > > > > +     u32 readers;
> > > > > +     u32 readerwriters[P2A_REGION_COUNT];
> > > >
> > > > Might be better to use refcount_t here instead of u32?
> > >
> > > Ack
> >
> > refcount requires atomic, is that something we have with the ast2400, 2500?
>
> Ah, we do on the 2500 (armv6) but not the 2400 (armv5)

Ok, so to avoid that complexity I'm not going to swap in refcounts.
but good to know for future reference since it's basically what I was
doing manually.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
