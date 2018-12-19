Return-Path: <SRS0=AchV=O4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EBA2C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 04:41:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2150021850
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 04:41:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="PZF8TY4g";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="POXlfHvO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2150021850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=hXmeQy1AYKZveCSqguXt11RS2cDAIVChTKzDt6cvw14=; b=PZF8TY4gxqqO4t
	8ljMCK5qmiXDvuIBoCN9z01U8QDjUMkHNwngSVe2Z3R72d4YVNT+1E9JY7DrewhtfbuvoWJxQ8ZHB
	dI9RP76XRH8E5XcRPVpW5AnXhQxfJb2pYmWDBlIs/pWioN+EAT4M294KPd+StG7wn7dlTeEpMFIN0
	mU7hfTFBE2KeHFGe7ssjBeC+F1uxzggs1t1lVrN2rhqC7rOejWNO9XoxdpY1zLL8u6DYSNGZW5weW
	iy+G9BQQH6pe83OG8riXgq21WuXGutXMZOsgcDpuqI5FQE6qcex9fGCQC4lDWUePOIzihFN5KqMwi
	w/Ko87Bt/DlFALGS/awA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZTfC-0001l9-He; Wed, 19 Dec 2018 04:40:54 +0000
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZTf8-0001kS-U2
 for linux-arm-kernel@lists.infradead.org; Wed, 19 Dec 2018 04:40:52 +0000
Received: by mail-pl1-x641.google.com with SMTP id u18so8876519plq.7
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 18 Dec 2018 20:40:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to
 :user-agent; bh=9CtqSlbudu7D+c5BQzNrzEJNN8qRbqDiu4S1Yf7LT3Y=;
 b=POXlfHvOZkLqKPHzljdwvRhBWZ8ylt4Jx+a3bUjYdS3aBTpNZ0fbl3FVw3q2uDP42Q
 PYZfQIjNdo+e68BBPkFsMBv3CLn4t/tTjB4MfBsseRpJjjZ9Gt58y6ENPU7WmKPxSjYl
 X+RyWF4X5zCL5wHMeSnW7xDvo+jo5XznoJnvo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=9CtqSlbudu7D+c5BQzNrzEJNN8qRbqDiu4S1Yf7LT3Y=;
 b=cI9WWjzT6YTY0J9ObDE1BZ36Iibq4IeMdoIV2MGMd19zeOkQr89oRaaKTBBG+iZSUa
 /PYluJDrhCNapIWtBJbCn7LcxolPFJ9LnJYhl9LM7iQ1GdXzvhQ8LU+vRi0/WPN3Nb2F
 8ef7YEkkIP3p/O6AOk442zPcHXOGgpxkbN8a7+plp44+7v3Pg5whY+1o9t2OLTMBpqUM
 u1h1UAl+KgriBiotDYpMhbvoF9Kq7r3ujYyn/DMLHJ+ybeqEnKigLmixMA0hx80LkvZJ
 OuhWavlGMqK3UyxLJO+onjYg2X71LO1e7WG45CMDnfPu+yvtpFmYqJ3VRSbW+8oRdsIl
 Du3w==
X-Gm-Message-State: AA+aEWb6y6xPSTja++l4WrVWEeOTzuiFmDlM4pAz6gS4dg/CBS8+5lgl
 yzCUwTMXLQh12YSwWx/aDtk1RQ==
X-Google-Smtp-Source: AFSGD/Veb1E1q1IhKLok3mqgJihkrqyIM2o1N8sXWZh+eupN1JNJd5ni7T/SfsPk07kUFXdKkx3rQA==
X-Received: by 2002:a17:902:4624:: with SMTP id
 o33mr18592312pld.289.1545194438160; 
 Tue, 18 Dec 2018 20:40:38 -0800 (PST)
Received: from localhost ([122.172.23.29])
 by smtp.gmail.com with ESMTPSA id f67sm37749916pff.29.2018.12.18.20.40.36
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 18 Dec 2018 20:40:36 -0800 (PST)
Date: Wed, 19 Dec 2018 10:10:34 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Gregory CLEMENT <gregory.clement@bootlin.com>
Subject: Re: [PATCH v3 2/2] cpufreq: ap806: add cpufreq driver for Armada 8K
Message-ID: <20181219044034.s2zikr22xs73pmcv@vireshk-i7>
References: <20181211164249.26985-1-gregory.clement@bootlin.com>
 <20181211164249.26985-3-gregory.clement@bootlin.com>
 <20181217111026.7b3tds2yz4g7opdt@vireshk-i7>
 <87mup2hpmr.fsf@bootlin.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87mup2hpmr.fsf@bootlin.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181218_204050_971309_6A04A036 
X-CRM114-Status: GOOD (  15.76  )
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
Cc: Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>,
 linux-pm@vger.kernel.org, Antoine Tenart <antoine.tenart@bootlin.com>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 =?utf-8?Q?Miqu=C3=A8l?= Raynal <miquel.raynal@bootlin.com>,
 linux-arm-kernel@lists.infradead.org,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 18-12-18, 15:32, Gregory CLEMENT wrote:
>  On lun., d=E9c. 17 2018, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > On 11-12-18, 17:42, Gregory CLEMENT wrote:
> >> +++ b/drivers/cpufreq/armada-8k-cpufreq.c

> >> +		for (i =3D 0; i < nb_cpus; i++) {
> >> +			if (clk_is_match(clk, freq_tables[i].clk)) {
> >> +				skip =3D 1;
> >
> > Why not do devm_clk_put() from right here and "continue" after that. Th=
at way
> > you can avoid "skip" variable as well.
> =

> We need to keep a reference to the clk when it used later in the loop.

Maybe I wasn't able to clarify what I was suggesting. This code can be writ=
ten
as:

		for (i =3D 0; i < nb_cpus; i++) {
			if (clk_is_match(clk, freq_tables[i].clk)) {
                                devm_clk_put(cpu_dev, clk);
                                continue;
                        }
                }

I don't see how the current code is different than this.

> I think you missed the fact that no variable are passed to the exit
> function but we still need to have a reference on the OPP to free, so we
> cant do without this global variable. However I could reduce the amount
> by hiding them in a platform data associated to the platform_device.

Maybe, lets see how the simplified form of the driver looks like. And then =
see
if something is still left to be done.

-- =

viresh

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
