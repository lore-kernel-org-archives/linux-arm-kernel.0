Return-Path: <SRS0=x1Tr=QU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8347AC282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 15:22:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FE71222CD
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 15:22:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="pI+Spmpb";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="pflZjFWW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FE71222CD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:
	In-reply-to:Subject:To:From:References:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=M856cGO8VJ2r7/ZFHk+FFhE+hNcsVw3O5QBgcaR03b4=; b=pI+SpmpblQtyMv+0iJbY8zaN9R
	VNE1Naa+vU/kVFHIFgngtKJ8e4GiPOfK3djsrixQdTcvC7oFGUlIH26WdVrZRnQeCmKq/Wo6wbX79
	Yot/C7dkz0WLwpwhvzi5H4Teeo9xfRMhTHt0bAssuoknjOmc1/YgT1YHM6Kvek+GQVOlBUFE2hAib
	RpP4e+CL7/196ZwuRXeKE9oPnvP8RqECXWNZbkyfY6ayOKpDp9OmLAMB7+92pWMtzCJhUTTSARsEH
	Becyzw3inVgFMv7GBirIWyiWa9aCXkyv51bVluS7FHUK2nhkCKNETaLnXJBlbToiYkrsH+H1xTEke
	QXNa7m9g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtwMj-0005SJ-Ub; Wed, 13 Feb 2019 15:22:25 +0000
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtwMd-0005Ox-Lf
 for linux-arm-kernel@lists.infradead.org; Wed, 13 Feb 2019 15:22:23 +0000
Received: by mail-wm1-x342.google.com with SMTP id r17so2868193wmh.5
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 13 Feb 2019 07:22:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version;
 bh=zCTBS95HOfXoiRWrgEvh7FtEvMXNrSB3FuomsjeF4Kg=;
 b=pflZjFWWDAz/fM+e1VlkgbPbYLDnO0ygiMMDYgv6ga46W2+QUy8S3KXuZ703g9uUhm
 3jfZ0xeqSVL9Dwl7BKPi93fpLcB3G08C+dokFOibYDnFUMW5p0MpkAcbJJxlNLSbCX/0
 9lQGMeVvmLQ5aHDCzua1uRZWLQ1XQmZNitJr/6ANUuGSwOIDIe1LRe2RAWQ77YWCftMl
 /TCDvcoiIrZBDmSw8I+N6gxz83JstFEf2S+PmGUNl/4rrovt3VIw+o5oxiqiTx0Kh9aT
 VycSaU0vpupvUIJ/ZYKZA5QUFkyCYBpksmS7WPbMIcjYWZ50ZRB89nDwAVDumo9tieTY
 +6kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version;
 bh=zCTBS95HOfXoiRWrgEvh7FtEvMXNrSB3FuomsjeF4Kg=;
 b=iVYxxWCnSGt+p2FRf9j/MRRbyM9wG1Gq6ijfPkUpdUKZ73eZG24muNrxMPswzhvrIY
 4w9Z6DH5zDxvMPTPq8+BuVohw/P0CdHkugm6CVV2CxQ4nzrh69xZWvY6nX/U9T4xC+aD
 kwBrYtJyeoTaO5QtSACYEq0FipJPQKs4KiGJRgiNmMZoxgIfNIg6uNIMIvSLDLdEirmn
 fx/b34RYOf2blvkfzbiBZ7FN/4zGU3+pOFapk314Hr7du6HKYMPgzVQSyg/h/XXEPvuh
 Rr7BtK41IvlSGSB/19/y73S8C+dNzt5yMZZ/jaBJrDLdpYy9iqPgrBcdvYMDoTpOI9PQ
 w7Mw==
X-Gm-Message-State: AHQUAubM6APGMXo4HgLAjcWd3PQgnUT21u19AG+mAbb8gmc0dNURgg88
 oyped3r6DADYlVDBzDJ8VKQk8A==
X-Google-Smtp-Source: AHgI3Ia0hwslWfHZSw4X5NkH0y6KRX9SyiTgQVjvvivQf6Mr8gWhRHhp/1Q4bQf04fh3UtNFwlhDUg==
X-Received: by 2002:a1c:f00a:: with SMTP id a10mr733736wmb.148.1550071337998; 
 Wed, 13 Feb 2019 07:22:17 -0800 (PST)
Received: from localhost ([2620:10d:c092:180::1:4505])
 by smtp.gmail.com with ESMTPSA id u184sm17675746wmg.45.2019.02.13.07.22.16
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 13 Feb 2019 07:22:17 -0800 (PST)
References: <1547744074-28308-1-git-send-email-lollivier@baylibre.com>
 <1547744074-28308-3-git-send-email-lollivier@baylibre.com>
 <20190125090755.GB3691@localhost> <867eeo7pjm.fsf@baylibre.com>
 <20190211083349.GU4686@localhost> <86mun2v27r.fsf@baylibre.com>
User-agent: mu4e 1.0; emacs 25.3.2
From: Loys Ollivier <lollivier@baylibre.com>
To: Loys Ollivier <lollivier@baylibre.com>
Subject: Re: [PATCH v2 2/4] dt-bindings: gnss: add mediatek binding
In-reply-to: <86mun2v27r.fsf@baylibre.com>
Date: Wed, 13 Feb 2019 16:22:14 +0100
Message-ID: <86sgwrsogp.fsf@baylibre.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190213_072219_709634_60F65F47 
X-CRM114-Status: GOOD (  12.57  )
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
 Kevin Hilman <khilman@baylibre.com>, Johan Hovold <johan@kernel.org>,
 linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
 linux-mediatek@lists.infradead.org, linux-amlogic@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


On Mon 11 Feb 2019 at 14:17, Loys Ollivier <lollivier@baylibre.com> wrote:

> On Mon 11 Feb 2019 at 08:33, Johan Hovold <johan@kernel.org> wrote:
>
>> On Mon, Jan 28, 2019 at 04:46:53PM +0100, Loys Ollivier wrote:
>>> 
>>> On Fri 25 Jan 2019 at 09:07, Johan Hovold wrote:
>>> 
>>> > On Thu, Jan 17, 2019 at 05:54:32PM +0100, Loys Ollivier wrote:
    >>> >> +Required properties (I2C):
>>> >> +- reg		: I2C slave address
>>> >> +
>>> >> +Required properties (SPI):
>>> >> +- reg		: SPI chip select address
>>> >
>>> > While the mt3339 appears to support these interfaces, the globaltop one
>>> > does not.
>>> >
>>> > Have you looked around for a small sample of mt3339-based receivers, to
>>> > see whether anyone actually provides these?
>>> 
>>> Again I'm confused by the fact that it is the Mediatek bindings.
>>> Hence why I have added it and why it was not present in the v1 that was
>>> only for Globaltop.
>>
>> This is no different from the sirfstar driver for receivers based on
>> those chipsets but manufactured by various other vendors.
>>
> Indeed.
>
>>> I find it odd mentionning the chipset but not all its interfaces.
>>> I will remove these sections and only list supported interfaces (i.e.
>>> UART). Other interfaces can be added afterward if one finds a board that
>>> provides them.
>>
>> Right, but please do look around for other receivers using this chipset
>> so that we can make the binding generic enough to cover those as well
>> (e.g. by choosing representative resource names).
>>
> OK will have a look.

The only mt3339-based receivers I have found are:
- [0] Globaltop
- [1] Locosys / Pololu
They both only provide the UART interface and do not list the I2C/SPI
interfaces.

[0] https://cdn-shop.adafruit.com/datasheets/GlobalTop-FGPMMOPA6H-Datasheet-V0A.pdf
[1] https://www.pololu.com/file/0J641/LS20030~3_datasheet_v1.3.pdf

Loys
>
>> Johan


-- 
-L

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
