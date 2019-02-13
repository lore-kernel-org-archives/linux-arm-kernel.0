Return-Path: <SRS0=x1Tr=QU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7908DC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 22:06:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 482A420842
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 22:06:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="a1CpYC0S";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="f50/eK6a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 482A420842
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=JYGfYMBl0Jffc3fpf1GRZ7Mq1L3x27s0e75G9+aWP4w=; b=a1CpYC0S7LwEcG
	w2W6mOOd22/Y/RH4WxorO1t+TPYhZWzCF0OWdTI9/G75mXOEcJt6dNp/fiSsHPsUyoj+fK3iERb7v
	y03H8D1XT2o80ISyUIvZSnLvkSdvzQTH36IfKS0yRpqK0Gjnhn7Dg1gwFsjzw95zIo0j+kPWGxNFz
	GP0yF/CFnXqCGHFjs4vujS6U+WNGakAmc2bnCUMvq4QOOE65qGMS1EvsY4KXM853pqHo5/TRwfNGI
	B3WzjcJSkg3BtRhk+95XxdxB5xNz0U1h4miW3m5o68JXdrxcsYvbnPO9NXwo+uVRfmTn54w08z22H
	xFC4kIoI8OCo0ErZMlrA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gu2g5-0000SD-7a; Wed, 13 Feb 2019 22:06:49 +0000
Received: from mail-yw1-xc42.google.com ([2607:f8b0:4864:20::c42])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gu2g1-0000Qb-Au
 for linux-arm-kernel@lists.infradead.org; Wed, 13 Feb 2019 22:06:46 +0000
Received: by mail-yw1-xc42.google.com with SMTP id n12so1518801ywn.13
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 13 Feb 2019 14:06:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=broadcom.com; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=u6wAtHf633+1b21qJHTj2XIY7UMZA9Tc9wGB3tQtIL0=;
 b=f50/eK6ap/0A0DEKg9r4vUamHcuETcc4wdkTPpA/avW84GZ78cWqIaE06oTh4Pj5S7
 FyHveOfdXAwWoehd1KeJFm453WEQ4P/6VudysCZfZ772xRlETy8V8/pCVMlnzHGlluFP
 gXdf2CN6cIXh+Kv3fzlo0uIGAzrtVuVZBRqtM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=u6wAtHf633+1b21qJHTj2XIY7UMZA9Tc9wGB3tQtIL0=;
 b=VjCUrpSEMpvIy9L0mYpaYqfey34k2Yde5BL4qBCilPlTPU1QNgQLuscRdm0y+NTS/Q
 Qo2b0XNc+jX+WFdh0Mcb2R68OS21d8xtwSzeZunzjWkPzuZQwQUGwCebB1VzfB4P+2is
 Wtfp/7paxzsmSd4rp23Y41jrORQPtD8EysCxJQIPnMfweYrdBbY/HYvuJ7eq+1UH6zwq
 suOUoKzAGg1rfsaj6St0zsjnIZGASe6152eyzmRHKMLB6T/MdiSBWjDjt3B+TpZsFhO2
 wfgkS/SoeOvr/RX/UorOVzbNPmrQDKXXUaVG970Now1I7OxIUg2p7ISiaagLaG5JxfXD
 q9zg==
X-Gm-Message-State: AHQUAubxjarLPXFrV91dl6DFkWFHZgxodZHxH4BtDnsTBDaWCo7DjPTl
 uvfqU0k+JvWvIwlr4rO5LY732A==
X-Google-Smtp-Source: AHgI3Ibp06o8aSa9CppmplGOGwJjf7IUwfBw4SrSNmuULA6zqp6WiNNZRJBOFpESEZQr+nK1nW+xnw==
X-Received: by 2002:a0d:f8c6:: with SMTP id i189mr348312ywf.286.1550095603260; 
 Wed, 13 Feb 2019 14:06:43 -0800 (PST)
Received: from [10.136.8.252] ([192.19.228.250])
 by smtp.gmail.com with ESMTPSA id w2sm184144ywe.62.2019.02.13.14.06.40
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 13 Feb 2019 14:06:42 -0800 (PST)
Subject: Re: [PATCH v4 3/8] dt-bindings: i2c: iproc: make 'interrupts' optional
To: Rob Herring <robh@kernel.org>
References: <20190204231554.87666-1-ray.jui@broadcom.com>
 <20190204231554.87666-4-ray.jui@broadcom.com> <20190213211651.GA10705@bogus>
From: Ray Jui <ray.jui@broadcom.com>
Message-ID: <796d9a96-f3f9-cb9a-faa3-4baf0e72da65@broadcom.com>
Date: Wed, 13 Feb 2019 14:06:38 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190213211651.GA10705@bogus>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190213_140645_389522_1E2BEA66 
X-CRM114-Status: GOOD (  18.80  )
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
 linux-kernel@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
 linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Rob,

On 2/13/2019 1:16 PM, Rob Herring wrote:
> On Mon, Feb 04, 2019 at 03:15:49PM -0800, Ray Jui wrote:
>> In prep for the introduction of polling mode into the driver, update the
>> binding document to make the 'interrupts' property optional
>>
>> Signed-off-by: Ray Jui <ray.jui@broadcom.com>
>> Signed-off-by: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
>> ---
>>  .../devicetree/bindings/i2c/brcm,iproc-i2c.txt         | 10 +++++++---
>>  1 file changed, 7 insertions(+), 3 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/i2c/brcm,iproc-i2c.txt b/Documentation/devicetree/bindings/i2c/brcm,iproc-i2c.txt
>> index 81f982ccca31..d3a3620b1f06 100644
>> --- a/Documentation/devicetree/bindings/i2c/brcm,iproc-i2c.txt
>> +++ b/Documentation/devicetree/bindings/i2c/brcm,iproc-i2c.txt
>> @@ -9,9 +9,6 @@ Required properties:
>>      Define the base and range of the I/O address space that contain the iProc
>>      I2C controller registers
>>  
>> -- interrupts:
>> -    Should contain the I2C interrupt
>> -
>>  - clock-frequency:
>>      This is the I2C bus clock. Need to be either 100000 or 400000
>>  
>> @@ -21,6 +18,13 @@ Required properties:
>>  - #size-cells:
>>      Always 0
>>  
>> +Optional properties:
>> +
>> +- interrupts:
>> +    Should contain the I2C interrupt. If unspecified, driver will fall back to
>> +    polling mode
> 
> What determines when you want to use polling mode? I'm not sure DT 
> is the best way to control this unless it's really a property of 
> the h/w. Driver behavior is really outside the scope of the DT. u-boot 
> would use polling even if an interrupt is specified, for example.
> 
It's tied to the particular revision of the I2C controller, i.e., the
iProc NIC i2c controller does not have interrupt line wired. In this
case, the behavior is determined by the DT compatible string of the
iProc I2C device. I thought that it makes sense to now move the
'interrupts' property to be under "Optional" than "Required" which is
basically what this change is.

> Rob
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
