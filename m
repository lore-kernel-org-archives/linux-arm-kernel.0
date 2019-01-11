Return-Path: <SRS0=KsRD=PT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D31FDC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 21:48:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 975BB2133F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 21:48:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Y0otnxx8";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="W6rbaHOd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 975BB2133F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=XUPN79RCD3o4kzqSxZQRb1+WyxkXH84qj/c70ABV/pg=; b=Y0otnxx8m5SRU8
	RtUIY3/q+6AKaWPbGFgJ0KoEHdRegvWn4QWmizJkcKjPXFc9tZbQMtWo2+fkJKsopmSMIdAIngrHA
	9spcSu6ji32doEDf68ZVCTJCLwol/IeXuRDdVzgZdAqowXWPFSjWzRLo3X2mV0S8jXje5rdWU72bm
	OiOv77ulqe8QnqhuK4z6JjpXbeUbBQqiJC4OC5XC36a31fG3p1FftBbNXsHdgXmCIzrMBNnFZWKuL
	JlDUH9eN416o7fo/Os8HklClnyatTq9UHheULsEvsvc5wTzYkXK8co6crQXxM6chRnKWeWpbcJ+VX
	9fi5jdaIwgJr6I/qijdA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gi4f3-0002qL-4X; Fri, 11 Jan 2019 21:48:17 +0000
Received: from mail-it1-x141.google.com ([2607:f8b0:4864:20::141])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gi4ez-0002pV-28
 for linux-arm-kernel@lists.infradead.org; Fri, 11 Jan 2019 21:48:14 +0000
Received: by mail-it1-x141.google.com with SMTP id h193so4852920ita.5
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 11 Jan 2019 13:48:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=i0lorHmwVBOHi3UsudcO+EMnuoHAfRRrhpYlPMigpUE=;
 b=W6rbaHOdTR03tRm18pHOkKoAActFg1vY6N6m4Nt4FDwD5ll+YItcvl4VvS1vuKokZJ
 Y7YLONn1SXij9CMppFx9xhOtDhG+RrQLCTtDn5A3n/qIYEia40RSBxiGjA/+4WlfxPsB
 NwmJN3gvB6/11Pw0WNcZFXmB8C8Zd2wwMCXkAYKXCh5Y9e8QfHt20G1FYhvF76CMQu0S
 Y3NyuYASCIpP5Uo5KmPc1K+5nv3GRRe1FTd9GKaiV0owofu09OIWGUPFPHUDXhG2getf
 5Po2+xKcoFqwM6Yui2dvbGES+N3PJ4Rxo6IlIlEHsIE4nKZ8uxpVx9zZ+E3cPM7ekx24
 /zNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=i0lorHmwVBOHi3UsudcO+EMnuoHAfRRrhpYlPMigpUE=;
 b=sVbeEjobKbDagObSCjWwxHnuS2SUBwAPuVkq3wA4e2keBDybvjDaFNY8Mukx0HdR1q
 dMf4SbA9uCW3hoRq7NNGS298j40ehmlWJtmXqWwTBelFrBhy8P0UcmNAT8qMf4Ylkqz2
 flPqdnx7qZKWyzHX9Odb/OhCoIra9ub6BZGoXMUCjmMhB3JPUJL4P1jGHxQua/KfIHE5
 R+tjn3gEyTq4bxiVQE7kZfbRj3kt0g6rnddQDoymYZSaTTTuc4KYEGy5nrCKZ8BbGb+y
 WTo8Wy+/KnDpsh3I62vXWItJBYlCiBSVIixRYDpXMNm4Y2RRKxSdVxGXI2R+OMkU8AA/
 ivgA==
X-Gm-Message-State: AJcUukfBlxDLA28YiWp46wHpWa1atAGycNK5RRTtyGKxKSHTu5S79udJ
 wUH7kmlXErymgfezx2M8Pre0lw==
X-Google-Smtp-Source: ALg8bN4eM4RpkLgkZExdfnvmMao7R1xQTEt9queTSTU2bFA2ojIK96hQSqLSISnQ8JvYubONVxJWfw==
X-Received: by 2002:a02:a791:: with SMTP id e17mr12323414jaj.104.1547243291526; 
 Fri, 11 Jan 2019 13:48:11 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
 by smtp.gmail.com with ESMTPSA id e10sm33295537ioa.65.2019.01.11.13.48.09
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 11 Jan 2019 13:48:10 -0800 (PST)
Subject: Re: [PATCH v3 0/7] Bring suspend to RAM support to MVEBU SATA
To: Miquel Raynal <miquel.raynal@bootlin.com>
References: <20181204192831.12440-1-miquel.raynal@bootlin.com>
 <35c5cdcf-0d89-9236-7937-0c750a781d13@kernel.dk>
 <20190111143404.518723a3@xps13>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <b5be50cf-336b-c10f-5cb1-efbf8b69ab61@kernel.dk>
Date: Fri, 11 Jan 2019 14:48:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190111143404.518723a3@xps13>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190111_134813_148867_FDA027A3 
X-CRM114-Status: GOOD (  19.57  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, Andrew Lunn <andrew@lunn.ch>,
 Jason Cooper <jason@lakedaemon.net>, Nadav Haklai <nadavh@marvell.com>,
 devicetree@vger.kernel.org, Antoine Tenart <antoine.tenart@bootlin.com>,
 Gregory Clement <gregory.clement@bootlin.com>, linux-pm@vger.kernel.org,
 Maxime Chevallier <maxime.chevallier@bootlin.com>, linux-ide@vger.kernel.org,
 Hans de Goede <hdegoede@redhat.com>, Rob Herring <robh+dt@kernel.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 linux-arm-kernel@lists.infradead.org,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 1/11/19 6:34 AM, Miquel Raynal wrote:
> Hi Jens,
> 
> Jens Axboe <axboe@kernel.dk> wrote on Tue, 4 Dec 2018 17:11:18 -0700:
> 
>> On 12/4/18 12:28 PM, Miquel Raynal wrote:
>>> Hello,
>>>
>>> As part of an effort to bring suspend to RAM support to Armada 3700
>>> SoCs (main target: ESPRESSObin), this series handles the work around
>>> the SATA IP.
>>>
>>> First, a change in the libahci platform adds support for the new PHY
>>> framework by following the phy_set_mode()/phy_power_on()
>>> sequence. Then, the AHCI MVEBU driver is a bit updated (patch 2 & 3)
>>> and a missing initialization is added for the A3700 in patch 4 (only
>>> done by the Bootloader before). Missing clock support is implemented
>>> in patch 5 to be sure the clock will be resumed before this driver
>>> (see [1] for the series adding device links to the clock core).
>>>
>>> Finally, device trees are updated to reflect the hardware: the missing
>>> PHY is added to the ESPRESSObin DT, and the clock is added to the SoC
>>> DT (patch 6 & 7). Bindings already document the clock and the PHY so
>>> no update is needed on this regard.  
>>
>> Probably the best/easiest to queue this through the libata tree for
>> 4.21. Agree?
>>
> 
> It looks like this patchset got left aside for 5.0, shall I re-send? (I
> rebased on top of 5.0 and the series applied fine).

I never got a reply to the above, so I didn't add it. I've now picked
up 1-5, 6-7 should go in through someone elses tree.

-- 
Jens Axboe


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
