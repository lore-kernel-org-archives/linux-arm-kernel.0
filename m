Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95248C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 05:39:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66FD42081C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 05:39:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dEmeaaU3";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iHAwpwZt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66FD42081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=yWSdoMyeKVVUKz4I7mqvOdOQis1bYW4yF97jrKCxJ98=; b=dEmeaaU3kJWN4k
	PHNHCDI4Fph8j0ASu3GCoSwUw0dcR9k6xTfsUJhgIf6Iya7ru5eCamfzBUc2PPLyz32KbvPv5N437
	9VWK+JZDKQBEsHIIC646VYFM4euaBNijkTokDbCtmAjouMLcR5UW9xhjQ/Sigdfq+sCfXFKVa3CwE
	ZZ2QU1q9Mrwuf6ygMGiPXxa9RClGDUrOgIfPcpv5irQMEXQr3du9lf2Bs841YHf8tLFh/02DKAxX4
	glKObunfCwJQqN6yf6s3ZHWRmqy5wY0cbjYJ6yg7F7VLPuBtGhQ9YYtwvcvkcVAC+nS8WRUiWCj6K
	jA3cGKMVt7clKEVlfppg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUPtk-00034L-HW; Wed, 05 Dec 2018 05:39:00 +0000
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUPth-000334-FX
 for linux-arm-kernel@lists.infradead.org; Wed, 05 Dec 2018 05:38:59 +0000
Received: by mail-pf1-x442.google.com with SMTP id i12so9431195pfo.7
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 04 Dec 2018 21:38:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=5D03bw7rj+ZBHz2TkJccRilu8chwwcqH2sItZw55+d8=;
 b=iHAwpwZtd9pLz1Tm1K23khFtx2oIGFSw+aPiOOX8Xto/Vp+4FotyBCO9EqLoAehkE+
 ElIjRn0Rczx/KeVT+wQ8BzaQAP9KSAqQIUj91Boon+pX5trro3jx144i878eay3WRlQJ
 rjjzCtuHf2Ypra/uZwPzkpWLt5e+vEg2t6+y/OADX0uzrJU53yoHpesiXjoeF8x5Hqa2
 8nYypBTRnnXl7udqvHa8ZgSIU2uqrfr4gqorNCOveze8ydPyHc0rNXNfWjxD9xtnBVwA
 k1QcOiv8MqJbnlBVnZtOz+NTTaDsFdFmMj/Urh41a6B5cGGOBgU/Q9dOqwsgutGeLXLl
 NDcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=5D03bw7rj+ZBHz2TkJccRilu8chwwcqH2sItZw55+d8=;
 b=SR6MEdwSLi3NBMotAANsL8Mghmh+Dg/TVYe3tOCvvFetJO2HeeeY2xBhUhxYinJLVs
 jKDMyy3L6fOgC23R/K0wLm0NShXnCHeiw6fUtyC3/f6pMxMFdsw+STWU8rRAzPf3+XtH
 E8TD3kbL/tMEUMDiI0OfJ3hDyLSXN4PfcEJe/BhlKx8karFHHxEj3yatlMw2zJuJs1Lf
 9z16HUQ8rIaVIwTL1YWqE4wwA6dMIJs/6SL2Vm9VOsjNX56rBQsuhS9+ruZ6xXTEOU4s
 JduSSNcqRrE09Cw0t76NPJ2d8sxh5mgboni6XHq4kn3i/DsAfxdYHNEVs6su0d8eLefE
 j7Gw==
X-Gm-Message-State: AA+aEWYNSjiioXab/mDE2aNfUc12ik/TI7R5hAWd6Sv2SQclEzvixjs2
 0z2WwKU48bFkDuv9nPxkY34=
X-Google-Smtp-Source: AFSGD/WIj8w8NdX8EwO0uhXq+cYF/xAiVr66KtpsNO9PlN2EdNP130T7h/bkLdGLFRyo9LBD+NAQIA==
X-Received: by 2002:a63:f811:: with SMTP id n17mr19804874pgh.23.1543988325540; 
 Tue, 04 Dec 2018 21:38:45 -0800 (PST)
Received: from localhost.localdomain ([63.145.95.70])
 by smtp.gmail.com with ESMTPSA id t67sm3715308pfd.90.2018.12.04.21.38.44
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 04 Dec 2018 21:38:44 -0800 (PST)
Date: Tue, 4 Dec 2018 21:38:43 -0800
From: Eduardo Valentin <edubezval@gmail.com>
To: Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: Re: [PATCH] thermal: armada: fix broken temperature sensor in 4.19
Message-ID: <20181205053842.GB29413@localhost.localdomain>
References: <alpine.LRH.2.02.1811241838180.7275@file01.intranet.prod.int.rdu2.redhat.com>
 <20181125005453.GV30658@n2100.armlinux.org.uk>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181125005453.GV30658@n2100.armlinux.org.uk>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_213857_526137_8D50A65C 
X-CRM114-Status: GOOD (  24.67  )
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
Cc: Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
 Mikulas Patocka <mpatocka@redhat.com>, linux-arm-kernel@lists.infradead.org,
 Miquel Raynal <miquel.raynal@bootlin.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Sun, Nov 25, 2018 at 12:54:53AM +0000, Russell King - ARM Linux wrote:
> On Sat, Nov 24, 2018 at 06:45:00PM -0500, Mikulas Patocka wrote:
> > The patch 8c0e64ac4075b7ca870098ed2ad6089868f5fa7b ("thermal: armada: get
> > rid of the ->is_valid() pointer") breaks temperature readings on the
> > MacchiatoBIN board. Reading the temperature with
> > 	cat /sys/devices/virtual/thermal/thermal_zone*/temp
> > results in errors:
> > 
> > armada_thermal f06f808c.thermal: Temperature sensor reading not valid
> > armada_thermal f2400078.thermal: Temperature sensor reading not valid
> > armada_thermal f4400078.thermal: Temperature sensor reading not valid
> > 
> > The patch was meant as simple refactoring, but unfortunatelly, it reverses
> > the condition in armada_get_temp_legacy, so that the error is reported if
> > armada_is_valid returns true.
> 
> I sent a patch for exactly this issue on 9th November... it doesn't
> seem to have made it into mainline yet.

I applied Russell's patch.

> 
> > 
> > Fixes: 8c0e64ac4075 ("thermal: armada: get rid of the ->is_valid() pointer")
> > Cc: stable@vger.kernel.org	# 4.19
> > 
> > ---
> >  drivers/thermal/armada_thermal.c |    2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > Index: linux-4.19.4/drivers/thermal/armada_thermal.c
> > ===================================================================
> > --- linux-4.19.4.orig/drivers/thermal/armada_thermal.c	2018-11-25 00:19:20.000000000 +0100
> > +++ linux-4.19.4/drivers/thermal/armada_thermal.c	2018-11-25 00:39:49.000000000 +0100
> > @@ -357,7 +357,7 @@ static int armada_get_temp_legacy(struct
> >  	int ret;
> >  
> >  	/* Valid check */
> > -	if (armada_is_valid(priv)) {
> > +	if (!armada_is_valid(priv)) {
> >  		dev_err(priv->dev,
> >  			"Temperature sensor reading not valid\n");
> >  		return -EIO;
> 
> -- 
> RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
> FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
> According to speedtest.net: 11.9Mbps down 500kbps up

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
