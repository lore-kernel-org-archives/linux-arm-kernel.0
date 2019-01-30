Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5045EC282D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 14:26:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 224B220855
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 14:26:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ciV6gymr";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nLYHa8w6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 224B220855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=1I6U0hwzY3aWkEIG7i6/WVlr9Stv6n+W43O5TlRMuMw=; b=ciV6gymrCkUUG4
	ntVFhmSdYzKw1+thYwXJDnomgawBzdpc4VNVcDBPMa6ErfdtXEgwhpZyW82IEt9VfAhD3oFe1hSUc
	lh8uilVWyXrm49PumMCd9j6kPOD5QqxnJVQMWna+XgWPOYSmAtN7QcCsRzXbOcBwlpKGQqySgVkAs
	E+8chLTvHgPa2dqy/TjiZJAVdN95wkDGall4XDFSsKhJudYi1kesJ5IFfA5QxzHRqm4zkiAaKiU04
	3SvHHWmftXrxLvE8D5bi/xQsBGpR8TdCm143c2ebU5r6aiFncPy+oVatYvILS9nuFud8vfs/A3trY
	/aBbV4q4j6sroMnb4FSw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goqoj-0005r9-PZ; Wed, 30 Jan 2019 14:26:17 +0000
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goqog-0005qh-Uq; Wed, 30 Jan 2019 14:26:16 +0000
Received: by mail-pl1-x642.google.com with SMTP id b5so11109189plr.4;
 Wed, 30 Jan 2019 06:26:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=VM3p6/s4SVy5fZUAia87KEQ5MWuRdZWo7LUOAtBmQU0=;
 b=nLYHa8w66+qrneKZnCCbqE31p44ZKWGoYR5IiBhfdXYWJkAa8uxeZe1/xbqBohz9FF
 l3u/s74nE0bN8+lMvpbXmxM6SzQpMVRtYLDGC3JMMzgOVy3NB5swxxJAvcu/c8Iyz/BT
 CxEcfa/ZYNw9pHkCYhmNMmhkA9IlPxh9n2+rThc9+Jo/qtJV8TFwp163z8o6H8iuidnT
 t6UvNZwtjO8kgX0/816iYqYB6UB3m+DY5UhksR3Mq59zHpDWQZtW2+QOoyqP/iUqHoWl
 vZQxwFV3RDrvVPpQaLYByZf3+Mwi31w2nZ0irehfrPCKbINzRrCKosixSJLP7/qbgf9r
 GYQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=VM3p6/s4SVy5fZUAia87KEQ5MWuRdZWo7LUOAtBmQU0=;
 b=oAYRylwnV0XY9ZX+W/W6CbT+sWb7e3xKpUFb9k47UYhuXRTs+e25XALCZVxWIyAQ9r
 AEwPo0LpbDXYf1byHZYd9tCKFAutoe08DsjdsFPc02AapJEIArio0WDenYsDMee3Ebi1
 4sANTZivbkAwnQcb8IQHBnL4ZuoBTEDjQaAIIOKjGwgl5zt2zQqRA/XUVD/SoTSXmz8f
 ThMQLnlXLP6cKEOyMLf2rWDOwL7PXLndpniHKS2cqmmINyR0FViWQa00OqGIrMvblwku
 aCCmYYTifvgwKKOhba5jWRqiY3QM9gR1ujh9bjSscliCz06xWMGv284QkXGQEL3twnfZ
 9aGg==
X-Gm-Message-State: AJcUukfN3LtnNW0Co/o2IrRKv1g/CCBeDiTPCoZ5au+4nQhzXJnz+HeT
 4MH56faYHYOlT+sFAZEC9ME=
X-Google-Smtp-Source: ALg8bN7Z2n67V/khSr8jW7o6rC2vZTkoUwukGWZqFX/Zl264nG9Ydtaze3ojN0g3enJfw3NYDk8v+w==
X-Received: by 2002:a17:902:ab84:: with SMTP id
 f4mr29937393plr.207.1548858373930; 
 Wed, 30 Jan 2019 06:26:13 -0800 (PST)
Received: from nishad ([106.51.25.107])
 by smtp.gmail.com with ESMTPSA id l22sm3330164pfj.179.2019.01.30.06.26.08
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 30 Jan 2019 06:26:13 -0800 (PST)
Date: Wed, 30 Jan 2019 19:56:03 +0530
From: Nishad Kamdar <nishadkamdar@gmail.com>
To: Paul Burton <paul.burton@mips.com>
Subject: Re: [PATCH] MIPS: Select PINCTRL_RT2880 when RALINK is enabled
Message-ID: <20190130142601.GA26071@nishad>
References: <20190129152522.GA24872@nishad>
 <20190129200905.vnb3amouxq6o57fn@pburton-laptop>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190129200905.vnb3amouxq6o57fn@pburton-laptop>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_062614_990180_E108D387 
X-CRM114-Status: GOOD (  15.71  )
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
 Kees Cook <keescook@chromium.org>,
 Sergio Paracuellos <sergio.paracuellos@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
 Ralf Baechle <ralf@linux-mips.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Joe Perches <joe@perches.com>, Matthias Brugger <matthias.bgg@gmail.com>,
 James Hogan <jhogan@kernel.org>, NeilBrown <neil@brown.name>,
 "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Jan 29, 2019 at 08:09:07PM +0000, Paul Burton wrote:
> Hi Nishad,
> 
> On Tue, Jan 29, 2019 at 08:55:27PM +0530, Nishad Kamdar wrote:
> > This patch selects config PINCTRL_RT2880 when config RALINK is
> > enabled as per drivers/staging/mt7621-pinctrl/TODO list. PINCTRL
> > is also selected when RALINK is enabled to avoid config dependency
> > warnings.
> > 
> > Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
> > ---
> >  arch/mips/Kconfig | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> > index e2fc88da0223..cea529cf6284 100644
> > --- a/arch/mips/Kconfig
> > +++ b/arch/mips/Kconfig
> > @@ -623,6 +623,8 @@ config RALINK
> >  	select CLKDEV_LOOKUP
> >  	select ARCH_HAS_RESET_CONTROLLER
> >  	select RESET_CONTROLLER
> > +	select PINCTRL
> > +	select PINCTRL_RT2880
> >  
> >  config SGI_IP22
> >  	bool "SGI IP22 (Indy/Indigo2)"
> 
> Wouldn't this also require selecting STAGING? Perhaps that's why it
> wasn't done in the first place?
> 
> Thanks,
>     Paul
Ok, got it.

Thanks for the review.

Regards,
Nishad

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
