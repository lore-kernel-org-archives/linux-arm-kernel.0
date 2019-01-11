Return-Path: <SRS0=KsRD=PT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 311DFC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 18:51:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0DE3921841
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 18:51:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="P5X5ZHo9";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="0dWIfn3C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DE3921841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:References
	:In-Reply-To:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=BiU0n/y4oxvNhuBeN6LkBA4ee2ohgH2zsiV7qCRF/6s=; b=P5X5ZHo915O4m2
	suVHOeIihtU/nY8ZnDbi3elmaJ/L9p9AzgKknGSXHC4nskqbeMLbEOyasrUOAy7BE8EoGcd2tzMGX
	w6R1TNgz7rTa2VvJ3llOP9SGiIpAIFM6weYQcCpOQzWx/UtMnsAJfNs6ik9LfaEsZ0p1BQV+cTFxM
	9gIxS3Grc6thpxo1AXNSvYiawL5dDOloVTa98HRCTw9/3blianSWmVG+B52dRrVDKC6Nmv116QDUj
	k6JAgqDSrxvhtld1KoslGMpPULyk3bJ5Pg6+wmsidgolyUceX8TVRcwOLUhtGtbZcA2vUcs6kUKVu
	za+IkBIz8xHoP8qFVhww==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gi1tk-0006mp-SH; Fri, 11 Jan 2019 18:51:16 +0000
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gi1th-0006m7-0t
 for linux-arm-kernel@lists.infradead.org; Fri, 11 Jan 2019 18:51:14 +0000
Received: by mail-pl1-x643.google.com with SMTP id b5so7141349plr.4
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 11 Jan 2019 10:51:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:in-reply-to:references:date:message-id
 :mime-version; bh=pitR8L9WmDjBuoydS++yrSyyfQoqz7HyAqmD7cthpYg=;
 b=0dWIfn3CjL8f3ooGjVaCGCDJ+E/gb8q1ofg/8qdVJKhwf8mLPtIKsn2wGgPtnXaKG9
 tA8XuV0wnp9rQ2UGojIGsK70/wZ5JXOrlX51bwFOF5RC+EoLPCJ79yK3pWStXfvxtCYQ
 bxbEMh97oY6sWMH/xZ0/ykXzyLg5vs7F0WKNUBKCodE8YI4A82rntfjkSgWmm2LCOrhB
 7ahAwskWSE226zgL2Sf6O6sr3glfJth7lHY2wuBYiLKjOyZMMRACniWBPpgnJK7b7qOc
 2mRNqxlBwOwp7qyEq1djyQs/dHeBzW9jKUW3VJMb4kkRrp8JIePQJd8PyeB/XlJHKv/I
 JRJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
 :message-id:mime-version;
 bh=pitR8L9WmDjBuoydS++yrSyyfQoqz7HyAqmD7cthpYg=;
 b=iYlKlD8jsFctwSwP/KEPiz9EcGehXmE87YXBXa0lhxMy2/pIU7DRGyvTzdxMfEUIN+
 D9VrIxmbQJ0VNi2FbLMwt7uTQSN2w8cp4ppe2if5zCn+AS0zl1Q4WxMiStye1B9RLcH8
 O9u5Hq3u2CIR7Q/4m4MpujTAsd7ScdEqTLRU+jQT0f8erw5nZu6tecesyqxcL21YAyVk
 LbasgxzXzUklSjCxoTEEONPDqFxe4QPUGbhlB1AA/ZHRPSLTsw67fQrSRdGUATE790Gh
 ngjeP5s++bMIpEbl0ctNllFpYc7iqLrDrZnMCrbrhMzu7kBq+SqEb2GcWIy1J5YLoJAz
 Xiwg==
X-Gm-Message-State: AJcUukdq+pertRQ+lzdN7qUNK+v+UNRRuIdB8btb7xK+KF5gKQ8Faxtg
 Hpz6sjYIVDpxByQaccsKaZANQw==
X-Google-Smtp-Source: ALg8bN61o21eFQRa/93epFy74wP25uFR1S+FUjQQ/w81s8mnjpvgL+E9yh2cFDpF6OuC8FkmIEO2TQ==
X-Received: by 2002:a17:902:42e4:: with SMTP id
 h91mr16054674pld.18.1547232670911; 
 Fri, 11 Jan 2019 10:51:10 -0800 (PST)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net.
 [71.197.186.152]) by smtp.googlemail.com with ESMTPSA id
 u70sm135770245pfa.176.2019.01.11.10.51.10
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 11 Jan 2019 10:51:10 -0800 (PST)
From: Kevin Hilman <khilman@baylibre.com>
To: Anand Moon <linux.amoon@gmail.com>,
 Neil Armstrong <narmstrong@baylibre.com>
Subject: Re: [PATCH] ARM64: dts: meson-gxbb-odroidc2: Fix usb phy regulator
 warning
In-Reply-To: <CANAwSgTX4Rs7xXzjpNi-zizRyyO0FiFF0baOuQZ0fx9WEM9NCA@mail.gmail.com>
References: <20190111092235.28161-1-linux.amoon@gmail.com>
 <772bd70c-2cd9-a1be-d18f-7824a9ea0556@baylibre.com>
 <CANAwSgTX4Rs7xXzjpNi-zizRyyO0FiFF0baOuQZ0fx9WEM9NCA@mail.gmail.com>
Date: Fri, 11 Jan 2019 10:51:09 -0800
Message-ID: <7h1s5jowo2.fsf@baylibre.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190111_105113_123778_7D83F70F 
X-CRM114-Status: GOOD (  11.17  )
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 devicetree <devicetree@vger.kernel.org>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Linux Kernel <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
 linux-amlogic@lists.infradead.org,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 Jerome Brunet <jbrunet@baylibre.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Anand Moon <linux.amoon@gmail.com> writes:

> Hi Neil,
>
> On Fri, 11 Jan 2019 at 19:10, Neil Armstrong <narmstrong@baylibre.com> wrote:
>>
>> Hi Anand,
>>
>> On 11/01/2019 10:22, Anand Moon wrote:
>> > Add missing vin-supply 5V regulator node on usb_phy nodes needed
>> > to power usb bus ports. Override the dr_mode from "host" to "peripheral"
>> > for initialization of dwc2 usb0 phy node,changes fix the below
>> > warning for usb initialization.
>>
>> I would have switch the dr_mode to peripheral in another patch,
>> fix the regulator issue in this patch only.
>>
>> Neil
>>
> [snip]
>
> Ok will split this into two patches and send after next dts updates.
>

When you split, please be specific about which part fixes which
problem.  e.g. it appears the dr_mode fixes the WARNING from the
regulator core by itself, and the vin-supply fixes the usb resets,
correct?  It wasn't obvious upon reading the changelog.

In either case, feel free to add:

Tested-by: Kevin Hilman <khilman@baylibre.com>

I tested on meson-gxbb-odroidc2 and it looks good.

Thanks for fixing this,

Kevin


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
