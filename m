Return-Path: <SRS0=sKCI=QH=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7874C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 16:50:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98851218AC
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 16:50:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="s0heLTiY";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="luXkdEMK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98851218AC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:References
	:In-Reply-To:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=5JJyNE+8+OWqwnn+EdZLR1JOsMFkCYKod5zDBBHHOSU=; b=s0heLTiYieCHiV
	Q4Hn1TfXPTeYvvFR0mb9APZPtIf+r7RfHqtfj9hHhabRIalCi2udO5lN/XJuhFMclu3VYNW86oGBK
	3iXTEd3DSl3tMqL93k4Czq16BugN9J3VZl18DLFPH+mi7o8w0QohBPcrOmNIS42JcdgHgAO3CDEuN
	I63cOyiYd+ugK5MOGefokwwxP6Z43hgRo2a6ao3iDicQG9NHph9dn2Yehdl44wBO6jFbrLaVOZQH2
	1HtiyLiM9CgZP97GhTjX32UxfBnwlCzNFE7Ce98VRwAwdKKuzDcbWLaO/RGZUqqAj3o5WbD3Qx5zM
	sG3LRXvhHHJDy71jj80Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpFXQ-0006NN-EU; Thu, 31 Jan 2019 16:50:04 +0000
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpFXI-0006Kw-4r
 for linux-arm-kernel@lists.infradead.org; Thu, 31 Jan 2019 16:50:00 +0000
Received: by mail-wr1-x442.google.com with SMTP id f7so4142231wrp.1
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 31 Jan 2019 08:49:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:in-reply-to:references:date:message-id
 :mime-version; bh=hguvWJc2EDwJ0Br1Pfz9Z4XonQAlIa1Ud1y7I+35X2g=;
 b=luXkdEMKQmBCpwNbO1fO2aUFlnq/I/f9rQPvV6LrHYPL8jOdF0xzrYQNZSouEUWyEK
 IE/RRo/QlHowjUzqmsQj8MAhdJweVnt40PNHKjJbsO+KGY1GQRZNqEU3SObz2nFZlMLL
 aWQs2DnpGA2yfTePDgQutuHNuJDM4h8XwsaUNb64M+5a0BekQToof0QccKZlqZ0px2XK
 2sFHjLsf/NRZTcEdGT5fHC1quakxYiVmgsWJsYUzPREmIpPRKG+c7jgPfhnJO+ILf7S1
 14cUJfdfyQp/5HlKgRDxo56Zo8uhAyJrDzWVgU8EWxzHQGS2PqrVJeoAYVW6JhWZHqy5
 wt+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
 :message-id:mime-version;
 bh=hguvWJc2EDwJ0Br1Pfz9Z4XonQAlIa1Ud1y7I+35X2g=;
 b=SaYjU7n+veIdmOU3XCX3/lf6t7Qr3MslOUmIuNTYvYYi/cQJ//tlrY36SS8PPqS0Db
 Grr43Fd5EW3tUA3i6OuhYW9KKXlofPoZ16cYsfN7gdHSbmq7Vew9hKYoMYAu/SOCtNns
 9AGo180zHGfZ/2LWyjwgiVi//E95hHah4T4V3p6Vc03mbQ/Rl9hdF+pVeaLOOSODUs8i
 6hqGAaxq9MVWzCMI1lt1qjnw2QUkP1zcUOcj7xnYjwr2rt65BfoYfn/MhcrcAVKtPtRE
 +zM6s2JnRBnHdb75nsekdULuaG7GA+lDoMyW+UhzXh1S24SuzMDSNUb7aGoxIYinafFj
 Ep5Q==
X-Gm-Message-State: AJcUukf+1/DRXW0e4Kz5QI8DbmjKsagF/zT8RiYH4x2rB1X3vuEHSCBw
 Vxd9HWfa4NBGWoS9tA6w3RPbgQ==
X-Google-Smtp-Source: ALg8bN7w7STAXXKYrJAk/AGWoFLYGBqWgIQk3HIiKzzc/FkYSCIEVgAxS1y+2+8B9xp1cRAZfgec7w==
X-Received: by 2002:a5d:4fcb:: with SMTP id h11mr35800983wrw.139.1548953394337; 
 Thu, 31 Jan 2019 08:49:54 -0800 (PST)
Received: from localhost (aputeaux-684-1-8-223.w90-86.abo.wanadoo.fr.
 [90.86.125.223])
 by smtp.googlemail.com with ESMTPSA id h13sm6675745wrp.61.2019.01.31.08.49.53
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 31 Jan 2019 08:49:53 -0800 (PST)
From: Kevin Hilman <khilman@baylibre.com>
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: arm: amlogic: add amediatech x96-max
 bindings
In-Reply-To: <CAFBinCBUm+Js1-ZabP9bSmYE0qG9Z9gYr-ua+ayDyPOdXUsEyQ@mail.gmail.com>
References: <20181219233519.35287-1-khilman@baylibre.com>
 <CAFBinCBUm+Js1-ZabP9bSmYE0qG9Z9gYr-ua+ayDyPOdXUsEyQ@mail.gmail.com>
Date: Thu, 31 Jan 2019 17:49:52 +0100
Message-ID: <7hwomkg4b3.fsf@baylibre.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190131_084958_766899_FEF54BAB 
X-CRM114-Status: GOOD (  14.21  )
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
Cc: linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Martin Blumenstingl <martin.blumenstingl@googlemail.com> writes:

> Hi Kevin,
>
> On Thu, Dec 20, 2018 at 12:35 AM Kevin Hilman <khilman@baylibre.com> wrote:
>>
>> Add new vendor for amediatech, and initial board: x96-max
> as we have seen there is no "amediatech" branding anywhere on the board itself
> however, FCC gave us a clue about the manufacturer: [0]
> can you please add this info to the patch description when re-sending?

Yes, will add.

>> Signed-off-by: Kevin Hilman <khilman@baylibre.com>
> Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> (with the two comments below)
>
>>  Documentation/devicetree/bindings/arm/amlogic.txt     | 1 +
>>  Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
> if Rob is fine with vendor-prefixes.txt being updated together with
> adding a new board then I'm as well :)
>
>>  2 files changed, 2 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/arm/amlogic.txt b/Documentation/devicetree/bindings/arm/amlogic.txt
>> index 8dbc259081e4..c50b084b6c59 100644
>> --- a/Documentation/devicetree/bindings/arm/amlogic.txt
>> +++ b/Documentation/devicetree/bindings/arm/amlogic.txt
>> @@ -99,6 +99,7 @@ Board compatible values (alphabetically, grouped by SoC):
>>    - "amlogic,p281" (Meson gxl s905w)
>>    - "oranth,tx3-mini" (Meson gxl s905w)
>>
>> +  - "amediatech,x96-max" (Meson gxm s912)
> I assume that you'll not only fix the SoC here (G12A) as reported by
> Chris Moore but also the ordering

Yes, will fix.

Kevin

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
