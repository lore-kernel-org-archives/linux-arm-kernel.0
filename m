Return-Path: <SRS0=niBm=QV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE16DC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 17:37:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69209222DA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 17:37:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="aj4GprVm";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="g4M8cFGj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69209222DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=F277U71MiWGYc3LezNjoL0aVtqmH42L+yXib0XH1yLA=; b=aj4GprVmDVfNO+
	1rN/IeiS+5a2ZlSwWGRLqB74xb6p4zHw0vODoxteomETKET4N+P1lY+/AbkolnyNixB+52IjMQmXE
	h8XY9wwwyoC3NpRTQVy68McmuQ/o6yKD+TlXL7Qw22B8AdjlhMCkWBp+rK+NfVIq9RmnmPhsjc+L9
	kB6MukQdOhiPusfyeW+gQ4rTqU+2Y2DMbBr+QOU4J20KcwC5XanTEthElZXkB6K/Y/48HfwPrQr4K
	8ljyzZu6yeCT+UFT4x5GVX1D0z2CzvriFflXKjNIuLRSBp9GpigMpPaGeFm48mAu/1n9eWw3pZSVZ
	EhyICHwyYeDtnEzHlQtQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guKwT-0008F1-NL; Thu, 14 Feb 2019 17:36:57 +0000
Received: from mail-ed1-x544.google.com ([2a00:1450:4864:20::544])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guKwK-00081H-86
 for linux-arm-kernel@lists.infradead.org; Thu, 14 Feb 2019 17:36:51 +0000
Received: by mail-ed1-x544.google.com with SMTP id 10so5685506eds.7
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 14 Feb 2019 09:36:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=broadcom.com; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=ryRC4W/SA5dnQCgYQdvbKL45VGQoqpZT+NFh8c9Rb0I=;
 b=g4M8cFGjJsYULIePc+YAzDxv9Q1Jn5NGPBH5cGIhkbSuMsp6t9AqUmRl7+BwbYC8eX
 EqmuilLKK0NZ6TL40QjzDZaY6LM5cVcy6iR38Dq4hXT729L3grO6WYQcevkD0wCYmrQz
 SbiCmaWrLy5QPVwclGbOiHj9Vju3I+Aos64g8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ryRC4W/SA5dnQCgYQdvbKL45VGQoqpZT+NFh8c9Rb0I=;
 b=dXh8qNq1KH2IOnm4+3cEMlpPU/WH8oLA4DOAP8cKHoxl/WdFBL0te720+4pmEV29TG
 rCLCCI+pmxuzvGMjenqxdi15JvnAiDUZxteu3M9jqHpJggGQUdgoBsdyLwXQBDTJDeex
 zdfwDHEEcBowPDXFip6/LhTGRrgns94aZkB5x/IA2D81zSR08SBtHBMMJmzO/4qX/rp4
 gzA0Dc/fUV7vO0nLv1R/+Y4qVMjAtgm+jb0yQ/DLduF4uzjmMizuq1vUctQt0bJfpSGU
 M+nQEVnx8ls4OfWzWWzsDfiZIoR53iL60Z12MXrp/llbXlZlkfYt561VwyjIog3d3VM9
 hR5Q==
X-Gm-Message-State: AHQUAub3e82/YiDOV5WqcShiet3wJa5FUJ2JRBfjS9O4i2t5qoVJ6CEg
 h6fiNVnV1AzhjQLmoDgmVvTQ9Q==
X-Google-Smtp-Source: AHgI3Ib7bHgeOFreWspwUxtqqjRsnvGYB8RrCKmzKT4Vlh/VjJ0HZd6XAb8PTnbT/eOeMZC+5hOzlQ==
X-Received: by 2002:a17:906:a456:: with SMTP id
 cb22mr3633823ejb.80.1550165806455; 
 Thu, 14 Feb 2019 09:36:46 -0800 (PST)
Received: from [10.136.8.252] ([192.19.228.250])
 by smtp.gmail.com with ESMTPSA id j4sm646599ejx.75.2019.02.14.09.36.43
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 14 Feb 2019 09:36:45 -0800 (PST)
Subject: Re: [PATCH v4 3/8] dt-bindings: i2c: iproc: make 'interrupts' optional
To: Rob Herring <robh@kernel.org>
References: <20190204231554.87666-1-ray.jui@broadcom.com>
 <20190204231554.87666-4-ray.jui@broadcom.com> <20190213211651.GA10705@bogus>
 <796d9a96-f3f9-cb9a-faa3-4baf0e72da65@broadcom.com>
 <CAL_JsqK+QLRp7LqkMzQCXdLPaJU3fbiNWU_uyuPFJ4qDkP=siA@mail.gmail.com>
From: Ray Jui <ray.jui@broadcom.com>
Message-ID: <e17b1cd0-8ffb-d014-bcce-57a3ca227506@broadcom.com>
Date: Thu, 14 Feb 2019 09:36:42 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <CAL_JsqK+QLRp7LqkMzQCXdLPaJU3fbiNWU_uyuPFJ4qDkP=siA@mail.gmail.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190214_093648_381434_00120520 
X-CRM114-Status: GOOD (  17.35  )
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
 Wolfram Sang <wsa@the-dreams.de>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE"
 <bcm-kernel-feedback-list@broadcom.com>, Linux I2C <linux-i2c@vger.kernel.org>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org



On 2/14/2019 6:16 AM, Rob Herring wrote:
> On Wed, Feb 13, 2019 at 4:06 PM Ray Jui <ray.jui@broadcom.com> wrote:
>>
>> Hi Rob,
>>
>> On 2/13/2019 1:16 PM, Rob Herring wrote:
>>> On Mon, Feb 04, 2019 at 03:15:49PM -0800, Ray Jui wrote:
>>>> In prep for the introduction of polling mode into the driver, update the
>>>> binding document to make the 'interrupts' property optional
>>>>
>>>> Signed-off-by: Ray Jui <ray.jui@broadcom.com>
>>>> Signed-off-by: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
>>>> ---
>>>>  .../devicetree/bindings/i2c/brcm,iproc-i2c.txt         | 10 +++++++---
>>>>  1 file changed, 7 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/i2c/brcm,iproc-i2c.txt b/Documentation/devicetree/bindings/i2c/brcm,iproc-i2c.txt
>>>> index 81f982ccca31..d3a3620b1f06 100644
>>>> --- a/Documentation/devicetree/bindings/i2c/brcm,iproc-i2c.txt
>>>> +++ b/Documentation/devicetree/bindings/i2c/brcm,iproc-i2c.txt
>>>> @@ -9,9 +9,6 @@ Required properties:
>>>>      Define the base and range of the I/O address space that contain the iProc
>>>>      I2C controller registers
>>>>
>>>> -- interrupts:
>>>> -    Should contain the I2C interrupt
>>>> -
>>>>  - clock-frequency:
>>>>      This is the I2C bus clock. Need to be either 100000 or 400000
>>>>
>>>> @@ -21,6 +18,13 @@ Required properties:
>>>>  - #size-cells:
>>>>      Always 0
>>>>
>>>> +Optional properties:
>>>> +
>>>> +- interrupts:
>>>> +    Should contain the I2C interrupt. If unspecified, driver will fall back to
>>>> +    polling mode
>>>
>>> What determines when you want to use polling mode? I'm not sure DT
>>> is the best way to control this unless it's really a property of
>>> the h/w. Driver behavior is really outside the scope of the DT. u-boot
>>> would use polling even if an interrupt is specified, for example.
>>>
>> It's tied to the particular revision of the I2C controller, i.e., the
>> iProc NIC i2c controller does not have interrupt line wired. In this
>> case, the behavior is determined by the DT compatible string of the
>> iProc I2C device. I thought that it makes sense to now move the
>> 'interrupts' property to be under "Optional" than "Required" which is
>> basically what this change is.
> 
> Okay, please put this detail into the commit msg.

Will do! Thanks.

> 
> Rob
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
