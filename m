Return-Path: <SRS0=x1Tr=QU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B995EC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 22:09:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 848C521872
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 22:09:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="D6CWqN5m";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Je4IbZJU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 848C521872
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=fESiPi0XdxRqi9KEaox6v2xDIl4sgM+4uKnegGc4Rgo=; b=D6CWqN5ms6VRiL
	KG/77lhWsgsDDRIXy+8nq2iu7NUCnfaiHS8cogKOh7erz13WvEmGQJVZ817ChUWbAelf9G+CP/9nw
	8L0cR6jdhIKVDBRq1v8b2aYEexBD7hNjSHgDgmnWdgPekdJKcg7PEpT4+jb6iYPlCEOf+uFhToJFP
	hFmX4+RJVuF2zktBa4P8EJpVncUv7NHWOxp6223eDhrGDRvaRuyMlIZxKg9zj1p28w9qA95EE+B4T
	DIq4qX3Z0N831cSjvmsa9zZQv5Z5cJFvOHv9XUbuEawQFwZfI1DAayRf+GL3y18uh/nrf7xtuH6Ku
	VWFaiL1yecwlBnqLyFIQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gu2iU-0000ua-IV; Wed, 13 Feb 2019 22:09:18 +0000
Received: from mail-yb1-xb44.google.com ([2607:f8b0:4864:20::b44])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gu2iR-0000u5-Vv
 for linux-arm-kernel@lists.infradead.org; Wed, 13 Feb 2019 22:09:17 +0000
Received: by mail-yb1-xb44.google.com with SMTP id h40so1588686ybj.3
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 13 Feb 2019 14:09:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=broadcom.com; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=4JlYCdnYOOJpfvtxmzKtdiYFZ9RgWQA+eh2iRMCxSzs=;
 b=Je4IbZJUQJ+mNOfRfiNgk8jH4mTjSSVPcjYWFxcjYwcbXXpg5AiOiOxWGIjga1IE4X
 +0N3njHWH7OEmDMmNJoTbiogb6R2e+sX4klFibeysE4GRzCBPTfTWlo1XMCb14ZKpY3x
 50KisZbxJz3juvnLLqSsmR5y5eMJNzsnyyt6M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=4JlYCdnYOOJpfvtxmzKtdiYFZ9RgWQA+eh2iRMCxSzs=;
 b=gwXfPybQRWklakJfZC0CDCoYNHxgQASLb6Z+cvtDShYaYueVw6sSrtj7QiTUI3S7h7
 UzPFtjDW10eWCeZyhJvokRnvbogUJUSuQO72U3Z1dUIQpWEj+b0Ebu6oplj6uClOJc1x
 spIk+APCHoGHaNumjusBSA32FvN8+IoyTKNDMB0Ssn06kYuNUNuCzSiqTcJl/dJhsBNP
 Q8XAvPrmfMugjl2NitcQLwgYPHDG2DKNctmkG3YFjlkgqz23h0W/Hl99xwP6j6SVHiNu
 sqQ/eJWCpH9QdFxTBzVatF60eWzKHOgx4YIUsLxNu6+P+2M93Ovz/J1KPDv9TmiCkJSA
 Cx2w==
X-Gm-Message-State: AHQUAuaOHvP6ABYmNiX7uPi2pZe6P1++rdlFYURGgvKQUEA00W90F6l2
 Mo80XXt+BOWwDDVnuYHcOXdXAwGPDQdwOggi
X-Google-Smtp-Source: AHgI3IYUntGkhv7heIF1fcfP2jdZiurEGy+tZwvTtpG5EtKZv81+JI7+azU8i2o1UENf2NswKumkDQ==
X-Received: by 2002:a25:da05:: with SMTP id n5mr351869ybf.63.1550095754764;
 Wed, 13 Feb 2019 14:09:14 -0800 (PST)
Received: from [10.136.8.252] ([192.19.228.250])
 by smtp.gmail.com with ESMTPSA id o124sm166394ywe.75.2019.02.13.14.09.11
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 13 Feb 2019 14:09:13 -0800 (PST)
Subject: Re: [PATCH v4 6/8] dt-bindings: i2c: iproc: add "brcm, iproc-nic-i2c"
 compatible string
To: Rob Herring <robh@kernel.org>
References: <20190204231554.87666-1-ray.jui@broadcom.com>
 <20190204231554.87666-7-ray.jui@broadcom.com> <20190213211807.GA20560@bogus>
From: Ray Jui <ray.jui@broadcom.com>
Message-ID: <6de51a50-cd7c-dbf8-15d8-8d2fd441d831@broadcom.com>
Date: Wed, 13 Feb 2019 14:09:10 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190213211807.GA20560@bogus>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190213_140916_030659_D1B4080C 
X-CRM114-Status: GOOD (  15.71  )
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



On 2/13/2019 1:18 PM, Rob Herring wrote:
> On Mon, Feb 04, 2019 at 03:15:52PM -0800, Ray Jui wrote:
>> From: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
>>
>> Update iProc I2C binding document to add new compatible string
>> "brcm,iproc-nic-i2c". Optional property "brcm,ape-hsls-addr-mask" is
>> also added that allows configuration of the host view into the APE's
>> address for "brcm,iproc-nic-i2c"
>>
>> Signed-off-by: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
>> Signed-off-by: Ray Jui <ray.jui@broadcom.com>
>> ---
>>  Documentation/devicetree/bindings/i2c/brcm,iproc-i2c.txt | 5 ++++-
>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/i2c/brcm,iproc-i2c.txt b/Documentation/devicetree/bindings/i2c/brcm,iproc-i2c.txt
>> index d3a3620b1f06..02e82d20239e 100644
>> --- a/Documentation/devicetree/bindings/i2c/brcm,iproc-i2c.txt
>> +++ b/Documentation/devicetree/bindings/i2c/brcm,iproc-i2c.txt
>> @@ -3,7 +3,7 @@ Broadcom iProc I2C controller
>>  Required properties:
>>  
>>  - compatible:
>> -    Must be "brcm,iproc-i2c"
>> +    Must be "brcm,iproc-i2c" or "brcm,iproc-nic-i2c"
>>  
>>  - reg:
>>      Define the base and range of the I/O address space that contain the iProc
>> @@ -24,6 +24,9 @@ Optional properties:
>>      Should contain the I2C interrupt. If unspecified, driver will fall back to
>>      polling mode
>>  
>> +- brcm,ape-hsls-addr-mask:
>> +    Required for "brcm,iproc-nic-i2c". Host view of address mask into the
>> +    'APE' co-processor
> 
> What's the data type and size? What are valid values?

It's an unsigned u32 mask value. An example of a valid value is for
example 0x03400000. Do you want any of these added to the paragraph above?

> 
>>  
>>  Example:
>>  	i2c0: i2c@18008000 {
>> -- 
>> 2.17.1
>>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
