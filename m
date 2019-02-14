Return-Path: <SRS0=niBm=QV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DB82C4360F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 10:12:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1ED382177E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 10:12:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="T83fFMvW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1ED382177E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=qXWr4N9tyZukoV4y5HQ2QUXRu7mWCt1gh22rfaoJP0o=; b=T83fFMvW0pHMKn
	Azv2u7dMcn5gRfRS8aeFqIgqX3pOYEpbF9bYV+WmnhUr1yFRGz5gKisu5ECgx5Tho5pNIQN2vI5lB
	8R3n9bLeB5N93tuzjbKzU7THRPN9VsqZY0oyA9tnmYSsHY7Tq9i3wcDs4jtrotxR/WHEhgWV94Sq8
	F9s/qX8h1ctpjDcxO5Uth6ayfOYnoCoPbtB7H4Woj9qOPcNTTEGWi9yZZyM84BKB5vPtTKsKpLF80
	6JIK7sJo+nxtpcr7YDi8A2dV+R52iWLArR3RObR5ZJ2ZATCi0bhpJibMEZNqX1DonPl+VXaKSkEdl
	kw3iJWYSCUQ7G6bM03IA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guE0K-0006dK-6Q; Thu, 14 Feb 2019 10:12:28 +0000
Received: from mail-lj1-f195.google.com ([209.85.208.195])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guE0E-0006ZB-CL; Thu, 14 Feb 2019 10:12:23 +0000
Received: by mail-lj1-f195.google.com with SMTP id r10-v6so4717615ljj.4;
 Thu, 14 Feb 2019 02:12:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=3qxerFGMWahyMCWOq0ia4/lTLwF5vmBx2M/yvwTR9Wc=;
 b=t9+Gb5wXcFGU3x5X9bGFiDt9Fbuz1dawAfIyHIhXS1MbUW1PvN19E3Pu81DwmptWyG
 iUf+s7N5e+7lS2J1mmRAn1jGSfywReQmCF9twYyD8xbA3AQEjEWgv0CN4DxqPhy0PH1v
 /T6yhQvFARBIZhejyxAxIHooU6RxURY4shZDn1cg+U+m5qPdZreCc058UJLnI280Hq0i
 /zIV5WE0pC6sXnUCu9zwIq8CIXcok4mC855d7GQSjGgVsnzzd7QDpg5mb7GfgIkF78Vd
 6756ZtsjFh99UXynqlWYvcmrp0J/S+trr7nC8dljLvGNq2CkS/Aho4c/D9Jx/f8SBIx8
 NRIQ==
X-Gm-Message-State: AHQUAuan/Y8kXeH6by5d5EZ3YYXrsMoMAz0JY4KSBqBeeYWZECvzEOZD
 MGTtHYFHgRXCEATiPZFKzqI=
X-Google-Smtp-Source: AHgI3IYMjxeC+55ZGGeACmD0LbPG9pfvF4TuCOWHxIs4cmGHsYI2wF62bBVZRN6uQumAO8+1FXUkow==
X-Received: by 2002:a2e:8719:: with SMTP id
 m25-v6mr1947042lji.121.1550139140032; 
 Thu, 14 Feb 2019 02:12:20 -0800 (PST)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se.
 [85.230.190.116])
 by smtp.gmail.com with ESMTPSA id p14sm382839lfk.16.2019.02.14.02.12.18
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 14 Feb 2019 02:12:19 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.91)
 (envelope-from <johan@kernel.org>)
 id 1guE04-0002MM-OH; Thu, 14 Feb 2019 11:12:12 +0100
Date: Thu, 14 Feb 2019 11:12:12 +0100
From: Johan Hovold <johan@kernel.org>
To: Corentin Labbe <clabbe.montjoie@gmail.com>
Subject: Re: [PATCH v4 4/4] gnss: add driver for mediatek receivers
Message-ID: <20190214101212.GJ28278@localhost>
References: <1550070569-18588-1-git-send-email-lollivier@baylibre.com>
 <1550070569-18588-5-git-send-email-lollivier@baylibre.com>
 <20190214100019.GA4197@Red>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190214100019.GA4197@Red>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190214_021222_417266_7E2F70E8 
X-CRM114-Status: GOOD (  17.70  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Kevin Hilman <khilman@baylibre.com>, Loys Ollivier <lollivier@baylibre.com>,
 Johan Hovold <johan@kernel.org>, linux-kernel@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>, linux-mediatek@lists.infradead.org,
 linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Feb 14, 2019 at 11:00:19AM +0100, Corentin Labbe wrote:
> On Wed, Feb 13, 2019 at 04:09:29PM +0100, Loys Ollivier wrote:
> > Add driver for serial-connected Mediatek-based GNSS receivers.
> > 
> > These devices typically boot transmitting vendor specific NMEA output
> > sequences. The serial port bit rate is read from the device tree
> > "current-speed".
> > 
> > Note that the driver uses the generic GNSS serial implementation and
> > therefore essentially only manages power abstracted into three power
> > states: ACTIVE, STANDBY, and OFF.
> > 
> > For mediatek receivers with a main supply and no enable-gpios, this simply
> > means that the main supply is disabled in STANDBY and OFF (the optional
> > backup supply is kept enabled while the driver is bound).
> > 
> > Note that the timepulse-support is left unimplemented.
> > 
> > Signed-off-by: Loys Ollivier <lollivier@baylibre.com>

> > +static int mtk_set_active(struct gnss_serial *gserial)
> > +{
> > +	struct mtk_data *data = gnss_serial_get_drvdata(gserial);
> > +	int ret;
> > +
> > +	ret = regulator_enable(data->vcc);
> > +	if (ret)
> > +		return ret;
> > +
> > +	return 0;
> > +}
> 
> Hello
> 
> This could be simplified to return regulator_enable(data->vcc);

Indeed, but I prefer this style which clearly separates the error path
from the success path while making the success return value explicit.

> Furthermore, after this simplification, the function seems useless.

Why do you think so? You still need to retrieve the regulator from the
driver data. Sure, this could be folded into mtk_set_power(), but that
would be less ideal if there are more resources that need to be managed
(e.g. an external lna supply).

Thanks,
Johan

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
