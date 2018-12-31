Return-Path: <SRS0=D6bT=PI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 604FCC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 21:34:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30039218C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 21:34:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="YSn20k+q";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="bnyzvKWL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30039218C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=9rf09YAAdR6fDcxJTbPGMfMX3HGoTg9XWP75Ve3x4nU=; b=YSn20k+qsXf34t
	CIlQjxJS9dmqQgAijdYHCPyFAvkIarum+vssMSIgjQ5xZu41FwP8y3AbcLD+yWk26NngM025sIAlz
	8SvDrAh3mrrcVjVDNy+LO3H+Q7wisjbUCWjQBrPzGY5beXUyus4qgtzUWhMjqmWsRtmq8Ye+EPk4n
	uabucrmcVBCYisnVsTRbB4/jxqoeMBOat2nZMsFpMIYWooTSLAXxE1trSEVAOIo3QNWDGrW8XCDaN
	OJdZcIuB2Ek0BnFVKgMKT/qQ4CeeIx4tX8WYcp/sUUT9n1QjXzxNUiFpJkkX3P6Fhu4+kHa+B9X9M
	xkYuGfmsZ9veqGc1ihlw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ge5D3-0005n6-D4; Mon, 31 Dec 2018 21:34:53 +0000
Received: from mail-lf1-x143.google.com ([2a00:1450:4864:20::143])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ge5Cz-0005kE-Kr
 for linux-arm-kernel@lists.infradead.org; Mon, 31 Dec 2018 21:34:51 +0000
Received: by mail-lf1-x143.google.com with SMTP id e26so18864819lfc.2
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 31 Dec 2018 13:34:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lixom-net.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=Uy5fa1TLSuQ69CNtPL1RugTu3eJ1608hyl6e4NGebXA=;
 b=bnyzvKWLK7raDHo6lVWyh7ticJupmdaV4vnufr8IyHyV9SmnrHxAYKAFx7ppTCUVlJ
 66h6xeAbm6DqTbUqZZsONMdzE4O/iDDkpjsWy/8qnpOPzbL1YKiQEbze8ZuIHVI+ARMt
 dPykBFdFywoJD9pPm6oRoMb5Hfkjh6rf53H+BSfyJKt0MZFNh7wEpnPgKpvnCflMHYne
 heMV/Cj7sjJABaE8BqmmAcAhrDoWHxD+GD8J6ufek6gFbeSt6YUCGN4JbytJtREwVBw5
 jBw0jVFg1axIvs/jJlRYVrgvwEjn/vEAwNhNUk/H1Wuk0c+4B32rd9AleqXzviBVLn1G
 vXug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=Uy5fa1TLSuQ69CNtPL1RugTu3eJ1608hyl6e4NGebXA=;
 b=XAAtW0JLKIn67PpkaKOHNO5rZ/RsqiHGiJPZm9cujhlsb6LtivQRUs/u/ONTemxOE1
 OG4OCNnfcun1mKc+4dxwI3SAH4ck5cR0mO1EBHFTzvDoGetqmt4W2mM+TK6RvXfcrc30
 nqV9VfxoKDqIlCk0QRDYPvYTmL4Wehiy6r34DJNSx0PdfeE63IbegpIvbhmcgPV85qU/
 0pDOWL8KxkFtthJQSMwMdUEBEETvDeobFUeCnsxgxLSw8uzEfLj9y4jEFLbLT7PyN7Yh
 DBmzt1sc5wdBtMx2H4iDm7G5zJ7e4V3zuorMjN8S8pEoPuKJGqgwLF2gYctsTkilv20N
 R0Tw==
X-Gm-Message-State: AA+aEWZmxy1eZq8vJc0MGlxQ0FdKdB9E5IONMAFJs443DJdTW8tGhSBc
 RT1JieH3RCVQ6Ej6ebyxy8SM2Q==
X-Google-Smtp-Source: AFSGD/XmtbLtxyim/Tnj9LgrB3yxJt3M3ChmdLSBrO2uQ+WVunVrAI+BBu+UGWCrsqmeTzaU7oymgg==
X-Received: by 2002:a19:5510:: with SMTP id n16mr18791078lfe.68.1546292081646; 
 Mon, 31 Dec 2018 13:34:41 -0800 (PST)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
 by smtp.gmail.com with ESMTPSA id l3-v6sm10416120ljg.21.2018.12.31.13.34.40
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 31 Dec 2018 13:34:40 -0800 (PST)
Date: Mon, 31 Dec 2018 13:06:17 -0800
From: Olof Johansson <olof@lixom.net>
To: Jens Wiklander <jens.wiklander@linaro.org>
Subject: Re: [GIT PULL] tee driver fix for v4.21
Message-ID: <20181231210617.6cxtq2nqynil2ltw@localhost>
References: <20181212122800.GA29450@jax.ideon.se>
 <20181212213617.mltwlxfcbap4prlj@localhost>
 <CAHUa44F=_DmhnvKxCAfErBcGL96=nmW0eSvgdhkF+pb+c-zhjg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAHUa44F=_DmhnvKxCAfErBcGL96=nmW0eSvgdhkF+pb+c-zhjg@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181231_133449_738471_EB35737C 
X-CRM114-Status: GOOD (  19.94  )
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
Cc: arm-soc <arm@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Dec 13, 2018 at 08:29:06AM +0100, Jens Wiklander wrote:
> On Wed, Dec 12, 2018 at 11:16 PM Olof Johansson <olof@lixom.net> wrote:
> >
> > On Wed, Dec 12, 2018 at 01:28:00PM +0100, Jens Wiklander wrote:
> > > Hello arm-soc maintainers,
> > >
> > > Please pull this tee driver fix for a possible double list_del() in the
> > > OP-TEE driver while uninitializing.
> > >
> > > Thanks,
> > > Jens
> > >
> > > The following changes since commit 40e020c129cfc991e8ab4736d2665351ffd1468d:
> > >
> > >   Linux 4.20-rc6 (2018-12-09 15:31:00 -0800)
> > >
> > > are available in the Git repository at:
> > >
> > >   https://git.linaro.org/people/jens.wiklander/linux-tee.git tags/tee-subsys-fix-for-4.21
> > >
> > > for you to fetch changes up to b2d102bd0146d9eb1fa630ca0cd19a15ef2f74c8:
> > >
> > >   tee: optee: avoid possible double list_del() (2018-12-11 14:38:21 +0100)
> > >
> > > ----------------------------------------------------------------
> > > Avoid possible double list_del in supplicant comms
> > >
> > > A fix for the OP-TEE driver to avoid possible double list_del during
> > > tee-supplicant communication while the system is shutting down.
> >
> > Do you want this for 4.20 or 4.21? Seems like .20 material to me but the tag
> > name is 4.21.
> 
> It's just that we're so late in the 4.20 cycle. If you're OK with
> taking it now I'm happy with that.

I dropped the ball on this before the holidays, I've queued it up in
a next/late branch now so we'll send it in towards the end of the merge window.


-Olof

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
