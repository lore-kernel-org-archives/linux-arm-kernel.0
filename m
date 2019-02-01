Return-Path: <SRS0=JyYb=QI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E35A6C282D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 15:51:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE59D2086C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 15:51:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="YnEZ5KhF";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C6/HaNf1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE59D2086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=ospxmk6rXFU+L26gmuGf3+emDoUGDny0ZbAHFve4dvU=; b=YnEZ5KhFc/PubJ9JQKbSamkJh
	Eq8ItlDg1MjAIoByEzyH4giMBlCMOwAIs63WWeHPfSdy+Gy9nfHC6SkzvvlQ5TZeiAQxPESh9qFUh
	U46zsb1H3TQIwiyYGkuvYpFzfd6runjDJ4fVC2qUAyENyHh9Bhl+rcMuMumX2foseGmelWETFE5zp
	YIZagmlDf5Yago5jXze/4v5aVQ8nu7bKMT8SlKXfhgBQ/7OqkwnTJNljiy5IFlO8R5WPvYxh2jzMg
	QB+uFPnnZcOnX2LUwNaueDF5I+GD1RDA9t7XImV4XxN4AshAhL7XkRhy/39CeC7tmC0Yb5bylLH0V
	3KDerWYrA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpb61-0003xv-PE; Fri, 01 Feb 2019 15:51:13 +0000
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpb5O-0003Pu-Ro
 for linux-arm-kernel@lists.infradead.org; Fri, 01 Feb 2019 15:51:11 +0000
Received: by mail-wr1-x444.google.com with SMTP id v13so7594598wrw.5
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 01 Feb 2019 07:50:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=L6vOcIJpjK9OcozAFWiyHaLssJG+aBVI05aeTxUznjY=;
 b=C6/HaNf1iGGTFZzDcthxq7cOmbMcnMTvN71vugTJoS1Qm8FBERiwQS+sfo0OkeBUBb
 rU3ikZypozX1Aqxx3UrdNb/BrLmIJeMXaebudD3bgb69URsmTIsOGlHOS2BKRUCB3zp6
 U2Y4bM7fsjNBqfBA5SAiHKKMA0yxsfozNpvyjySN5SySi8lHiIAbA+czlKeZ8eboOfkI
 YDRqOEfPXy5O2meBO+Jy8TMVV5Ty17P86L29ToGSuiDpCbMoQCODNsQVr6D38XxcyBck
 8puJHjL9frZkxeQ0C/h81gqO9dyg/uWrD4AD8FuOZTruIa4rbLL0du0IXZSwEaBA2FlK
 Fftw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=L6vOcIJpjK9OcozAFWiyHaLssJG+aBVI05aeTxUznjY=;
 b=PccwkRmAFXD3S/cMPo+svLY950brFeEFS1zaK5Sgy4K7n0HwD52OCT6BjyRr1Laynr
 f9J9BxImffiepy08I2ZcuMwnfKHZegzH5vpTFjvuDwRuiV0zDVVKNn+APtyuqYfrNKS5
 HcBQAkgiGgngZI8EqqL5qvlfy9XlQxtNNyxLVm2hDt/Ph6Lfo41wg6jv+p3289fNWp8t
 SY+WffxkA4YXOrBQz8o54Wj0+3w5qUgtOvYSWZK7hhWq0Vxw+YZn4NOaWtAvPG32DpY8
 pC6wreAY1o0797Frk7m+7y0W8bmWfRaHXGZ05VNnSg0Z0ZEVm+zIDPn7SZoKJqa2W3QZ
 Qk7Q==
X-Gm-Message-State: AJcUukdowieqLGeJhmBTqSOC8j0qDoqZvxid0r29ORWjHbirsDtL++nS
 glNKz2l+oqU8aECEwa7mcZEv8pTJ
X-Google-Smtp-Source: ALg8bN6BgsKNaEZZz0FywYtvgiSMzHhYiFFcfmG7jdjF8mHuDkSihOzCGkU6f7wcf7GSJOv5ngjpZQ==
X-Received: by 2002:adf:92a4:: with SMTP id 33mr38753603wrn.11.1549036232337; 
 Fri, 01 Feb 2019 07:50:32 -0800 (PST)
Received: from ?IPv6:2a02:8071:6a3:700:e52b:4fa:c59b:a6af?
 ([2a02:8071:6a3:700:e52b:4fa:c59b:a6af])
 by smtp.gmail.com with ESMTPSA id r200sm5183583wmb.36.2019.02.01.07.50.31
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 01 Feb 2019 07:50:31 -0800 (PST)
Subject: Re: [PATCH] ARM: socfpga: fix base address of SDR controller
To: Dinh Nguyen <dinguyen@kernel.org>, Marek Vasut <marex@denx.de>
References: <20190129200858.19773-1-goldsimon@gmx.de>
 <0711a2e0-b4fb-fa12-7c5c-0b5da73c8b02@kernel.org>
 <CAAh8qszCQROUZVOyX9GCNF_09DebDDUWf_2cfW3M13yG1aJ_Xg@mail.gmail.com>
 <080c0900-4c34-e097-3e0e-4508951b0ddd@kernel.org>
From: Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>
Message-ID: <e7c314cf-294d-e80a-c9f2-b5e183af6af5@gmail.com>
Date: Fri, 1 Feb 2019 16:50:21 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <080c0900-4c34-e097-3e0e-4508951b0ddd@kernel.org>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190201_075035_352792_CA989602 
X-CRM114-Status: GOOD (  29.84  )
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
 Alan Tull <atull@kernel.org>, linux-fpga@vger.kernel.org,
 linux-kernel@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
 Rob Herring <robh+dt@kernel.org>, Moritz Fischer <mdf@kernel.org>,
 linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Am 01.02.2019 um 16:13 schrieb Dinh Nguyen:
> 
> 
> On 1/30/19 12:00 AM, Simon Goldschmidt wrote:
>> + Marek (as I really want to keep the dts in Linux and U-Boot in sync)
> 
> So can you wait until your patch in U-Boot is in?

Well, yes, this could wait. The problem is we wanted to keep Linux and 
U-Boot dts in sync.

I guess I'll just finish preparing my patch for U-Boot changing the dts 
there and then we'll see which part gets pushed first...

> 
>> On Wed, Jan 30, 2019 at 1:16 AM Dinh Nguyen <dinguyen@kernel.org> wrote:
>>>
>>>
>>>
>>> On 1/29/19 2:08 PM, Simon Goldschmidt wrote:
>>>> From: Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>
>>>>
>>>> The documentation for socfpga gen5 says the base address of the sdram
>>>> controller is 0xffc20000, while the current devicetree says it is at
>>>> 0xffc25000.
>>>>
>>>> While this is not a problem for Linux, as it only accesses the registers
>>>> above 0xffc25000, it *is* a problem for U-Boot because the lower registers
>>>> are used during DDR calibration (up to now, the U-Boot driver does not use
>>>> the dts address, but that should change).
>>>>
>>>> To keep Linux and U-Boot devicetrees in sync, this patch changes the base
>>>> address to 0xffc20000 and adapts the 2 files where it is currently used.
>>>>
>>>> This patch changes the dts and 2 drivers with one commit to prevent
>>>> breaking the code if dts change and driver change would be split.
>>>>
>>>> Signed-off-by: Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>
>>>> ---
>>>>
>>>>   arch/arm/boot/dts/socfpga.dtsi       | 4 ++--
>>>>   arch/arm/mach-socfpga/self-refresh.S | 4 ++--
>>>>   drivers/fpga/altera-fpga2sdram.c     | 2 +-
>>>>   3 files changed, 5 insertions(+), 5 deletions(-)
>>>>
>>>> diff --git a/arch/arm/boot/dts/socfpga.dtsi b/arch/arm/boot/dts/socfpga.dtsi
>>>> index f365003f0..8f6c1a5d6 100644
>>>> --- a/arch/arm/boot/dts/socfpga.dtsi
>>>> +++ b/arch/arm/boot/dts/socfpga.dtsi
>>>> @@ -788,9 +788,9 @@
>>>>                        reg = <0xfffec000 0x100>;
>>>>                };
>>>>
>>>> -             sdr: sdr@ffc25000 {
>>>> +             sdr: sdr@ffc20000 {
>>>>                        compatible = "altr,sdr-ctl", "syscon";
>>>> -                     reg = <0xffc25000 0x1000>;
>>>> +                     reg = <0xffc20000 0x6000>;
>>>
>>> I don't see the U-Boot device tree having this change. Yes, the
>>> documentation does state that the SDR address starts at 0xffc20000, but
>>> all of the pertinent registers start at 0x5000 offset. Thus, the
>>> starting address should be 0xffc25000.[1]
>>
>> You don't see it in U-Boot as I'm working on a patch for that.
>> As I wrote in the commit message, U-Boot currently does not use the
>> devicetree for the SDR driver, but I want to convert it to do that.
>>
>> But before converting, I need to find a clean way to provide the
>> register addresses to the driver. That doesn't work with the current dts.
>>
>>>
>>> [1]
>>> https://www.intel.com/content/www/us/en/programmable/documentation/sfo1410143707420.html#sfo1411577366917
>>
>> Well, in [2], you see that the peripheral's address range actually starts
>> at 0xffc20000. It's only the public documented registers that start at
>> 0xffc25000. I don't know why the lower address range is undocumented.
>> Maybe you can help me here?
>>
> 
> Yes, the reason these register are not documented is that the ddr
> engineers didn't really want anyone outside of their team messing around
> with the calibration. These registers, from the limited documentation I
> have, are related to the PHY settings. I've been told the calibration
> sequence is something of a "black" magic.

That's exactly how I thought it would be. However, that's not the best 
attitued for getting code into an open source project like U-Boot. For 
example, I wanted to take a look at the code to see if it can be made 
smaller, but that's unnecessary hard if the registers are not documented...

Regards,
Simon

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
