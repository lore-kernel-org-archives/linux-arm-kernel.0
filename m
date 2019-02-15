Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF385C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 12:25:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7FE2D21929
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 12:25:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="CP4r0nyM";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="nRrFNkH4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FE2D21929
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:
	In-reply-to:Subject:To:From:References:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=M7Q4wBxUCp3srAl7vzqksgz6xy2RPlfK+fw3bTny9lY=; b=CP4r0nyMlxBelAPAATprLGfHnY
	BQSgzFscuY8k1xXHco5dOtMiYSyD2c9YNRbnu33yehqkbvfXpY7XghLgQQWQqYesAAqAnoeFCEZbV
	TawxHqpxy6/73+3bpDEKQr4KLxL+YMHxXNJQvydeTiz7MgPDrLjJFPSP5i8DoDl8kVzyE83ppWegA
	q3fxoX36vnb9EG62/6Spsp+dYGuPOBg2NX6VJXHfV1YsUvqrXbkR1etqnn7Z2Y0wo/GK6wnIujYCQ
	kntbEYyTMqONNXseuuI5EjLKIolKdddv8VuDcme+ituLNq7TIPr+n50CdQtUuI0sEk30Mb0ApDCFg
	XCpqhe/g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gucYb-0004Og-Qg; Fri, 15 Feb 2019 12:25:29 +0000
Received: from mail-ed1-x543.google.com ([2a00:1450:4864:20::543])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gucYX-0004NI-Qz
 for linux-arm-kernel@lists.infradead.org; Fri, 15 Feb 2019 12:25:27 +0000
Received: by mail-ed1-x543.google.com with SMTP id h58so7790002edb.5
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 15 Feb 2019 04:25:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version;
 bh=kaYhpM3K1lORUrG4TIL1K2D+s9nWHtiHPzXDKda8A0E=;
 b=nRrFNkH4Rf5YL6oIfpcUZxZDrnILQ/wVBi0OglfDxNwG3jevICe+YCnXBUKUIlWcLd
 C3A1rh9wOGdBpMs10ko4HdFZtAbREng0aKZp/WG/fW9BP2hsSNLOsVdpIqhyawKYAW+T
 UqSXXeU+TH+02NhJnZ6YY7WiP5G0uU9rJTO3iAKregSBEHy1F5aI7knhYPU28dR1Xbzc
 zMZTme+eZH1NwlJ/TkiBSRPyTbaEwahPugkN9FBEdSZmFFTt9Kxp/fz/kW61tNBlsTyV
 2UFidFtkZzXvFO/ia6scjaivvj6GpkZeJRtLlXBp4PH/9dZiZFGtp0yrFUzsjp6DtVnJ
 tezQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version;
 bh=kaYhpM3K1lORUrG4TIL1K2D+s9nWHtiHPzXDKda8A0E=;
 b=dk7qWuzHNMwNY9s4m0nM654wCguzz/zKW6YMX7aMK96z/Y/oIdW4gqN0HQfmTHjbnx
 AiftbknNY8ImA3G9pvj1wOE1sfUZvewY6TwbLfre+/mBhqZufBaay60VktA8qWTGjTrB
 nqh2AmjZpk7YPNAoafs8bIWMD03twx56HkuBhTrn3DcUZo0Ox99kWBPHYRbAXMjxqwub
 sfuozQnu0BR4famvelRmOPavKz5St/T8OgpYWGr3/RfMadnZzOIeMRRNWjCxTzjVxBs1
 ztk4kmDAyZQuF+nE08UST7n5Gi1yZzgbGy6VnKqhC+S7Jjha63KH7yPbCeFEWr2i0ytG
 qQ5A==
X-Gm-Message-State: AHQUAuay0GwFtHOXnAO2TQzxZ25ODO6QXRN7S1jLcc2dywFRiBucpmAn
 VBD03YEyg5F9RdvXA9GsHX4YuQ==
X-Google-Smtp-Source: AHgI3Ia/AePt867GBuhHiFAwymq6ydcEdV1qGEvztO6A8kE+RS2ElAgaOZuQ6A1eaTnIiBYuvDB0pg==
X-Received: by 2002:a17:906:32c7:: with SMTP id
 k7mr6496809ejk.180.1550233524020; 
 Fri, 15 Feb 2019 04:25:24 -0800 (PST)
Received: from localhost ([2620:10d:c092:180::1:2b])
 by smtp.gmail.com with ESMTPSA id c25sm512455ejx.59.2019.02.15.04.25.22
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 15 Feb 2019 04:25:23 -0800 (PST)
References: <1550070569-18588-1-git-send-email-lollivier@baylibre.com>
 <1550070569-18588-5-git-send-email-lollivier@baylibre.com>
 <20190214100019.GA4197@Red> <20190214101212.GJ28278@localhost>
User-agent: mu4e 1.0; emacs 25.3.2
From: Loys Ollivier <lollivier@baylibre.com>
To: Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH v4 4/4] gnss: add driver for mediatek receivers
In-reply-to: <20190214101212.GJ28278@localhost>
Date: Fri, 15 Feb 2019 13:25:20 +0100
Message-ID: <86d0ntfdcf.fsf@baylibre.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_042526_018902_A081357E 
X-CRM114-Status: GOOD (  19.60  )
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
 linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
 Corentin Labbe <clabbe.montjoie@gmail.com>, linux-amlogic@lists.infradead.org,
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


On Thu 14 Feb 2019 at 10:12, Johan Hovold <johan@kernel.org> wrote:

> On Thu, Feb 14, 2019 at 11:00:19AM +0100, Corentin Labbe wrote:
>> On Wed, Feb 13, 2019 at 04:09:29PM +0100, Loys Ollivier wrote:
>> > Add driver for serial-connected Mediatek-based GNSS receivers.
>> > 
>> > These devices typically boot transmitting vendor specific NMEA output
>> > sequences. The serial port bit rate is read from the device tree
>> > "current-speed".
>> > 
>> > Note that the driver uses the generic GNSS serial implementation and
>> > therefore essentially only manages power abstracted into three power
>> > states: ACTIVE, STANDBY, and OFF.
>> > 
>> > For mediatek receivers with a main supply and no enable-gpios, this simply
>> > means that the main supply is disabled in STANDBY and OFF (the optional
>> > backup supply is kept enabled while the driver is bound).
>> > 
>> > Note that the timepulse-support is left unimplemented.
>> > 
>> > Signed-off-by: Loys Ollivier <lollivier@baylibre.com>
>
>> > +static int mtk_set_active(struct gnss_serial *gserial)
>> > +{
>> > +	struct mtk_data *data = gnss_serial_get_drvdata(gserial);
>> > +	int ret;
>> > +
>> > +	ret = regulator_enable(data->vcc);
>> > +	if (ret)
>> > +		return ret;
>> > +
>> > +	return 0;
>> > +}
>> 
>> Hello
>> 
>> This could be simplified to return regulator_enable(data->vcc);
>
> Indeed, but I prefer this style which clearly separates the error path
> from the success path while making the success return value explicit.
>

It respects the coding style/standard and I prefer the original version.
It's also easier to debug if you want to add extra code on error.

>> Furthermore, after this simplification, the function seems useless.
>
> Why do you think so? You still need to retrieve the regulator from the
> driver data. Sure, this could be folded into mtk_set_power(), but that
> would be less ideal if there are more resources that need to be managed
> (e.g. an external lna supply).

I would be in favor to keep mtk_set_active. It clearly shows when the
regulator is enabled.
It also seems logic to have an enable/standby function in the driver.
Even if those are trivial (for now).

>
> Thanks,
> Johan


-- 
-L

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
