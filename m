Return-Path: <SRS0=niBm=QV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47C4BC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 17:36:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17E6921928
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 17:36:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="KgHeB7/y";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Z5RhiZHn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17E6921928
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Xmncl6e9XtlU+7iTAIHmEpKs42PjYJxiWXzyI8O3Z5s=; b=KgHeB7/yj51Z5M
	QQ7D4/MWMZRe3lG/tDb5Yz2sFmuqtdhKKad7DR7lAMHtkGyNUbZ+Zjlh1TLOvEK5688pmkGUbxzl/
	LL99rx9oZIJi1chTLbBUsUyxoskNwp3LhJHfcxnfMHqxknJEh/Mkk+Z8dFnkC/yr5cDRJe0AXB1Cb
	IYnBzPizF7Bpfvc2iXLLKvOstr/9GHsBb66v27kyhHcIkLJ+JID/00OIPIxsKu+iYVCudgJQbU2jR
	5AjzmIonoxJLwbzON0GvEdrJZBAUQZRLyOw/Rd2vKwuCPu8CFcUSS1a8Xc8nCgilvlwlY7gLkCl+I
	7Ek4mBWrMKgTO49HH22g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guKvn-0007kP-Ab; Thu, 14 Feb 2019 17:36:15 +0000
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guKvk-0007jx-DF
 for linux-arm-kernel@lists.infradead.org; Thu, 14 Feb 2019 17:36:13 +0000
Received: by mail-pl1-x643.google.com with SMTP id s1so3493020plp.9
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 14 Feb 2019 09:36:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=broadcom.com; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=uhXbHxTxPGQ4MO7jdnSCR/lTxKKRk87s3AJY5Ha2z58=;
 b=Z5RhiZHnq+0pcf3YrfE347lsWCBkaC5gsJyhZZyikSHr8/Ge1eGecW9bWneheBnUa5
 CqhoCdeaLeoG/A4FWK2nbppRSW7qWSrIK74ewN+xUmzUF0fWTVrzaarVxMWf/96CKemi
 UurRAMJmPdX4CLvXyGD66uH3mYf9eLsn5ZJ0o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=uhXbHxTxPGQ4MO7jdnSCR/lTxKKRk87s3AJY5Ha2z58=;
 b=cKORLg8uxLlYf3jTYMYA/Z/JbpPHvLCmkMzWXTA9GyTwhkViUXIb6/8MO/eeNXgr9X
 wxbNmtyng0RsbupduRvXuRb6S4o5J9fe0dvHfRBavrF/tXCEHWKYLG9IpUg4/JjqdrAk
 l9NXmX029dLPAeXbE0C0ftrfEDMON6jDCsby2abY5qPDVhkjyoU7BTpdR1AugepI5FHo
 7ZagCXeNZr9HdivVyGAcj708hV9cTYCmsKkdJDrNbmsz66uJkZOe9BEQwgpE73z7tPfP
 kdN8I49xLkiFMFxMeJcqJD/tSXbNFKUNChWi4OyJvVU9n997u0mcVCfcKqFoog0en03D
 LOxA==
X-Gm-Message-State: AHQUAubJgh5ZBGN58a4/SQv3M3tVTbwTqU7lHDwy3a5raNTwKxmkS3xY
 axcxZx/nOfXOjvjtMU24ODKhnA==
X-Google-Smtp-Source: AHgI3Ib8Mvy87Kp9t/y1Yo/3tjQsBRSR2iy0NbGYlIFkvbpUusKJvbbBI1w7XarAIOyUuAMuf9WvrQ==
X-Received: by 2002:a17:902:7683:: with SMTP id
 m3mr5378816pll.191.1550165771118; 
 Thu, 14 Feb 2019 09:36:11 -0800 (PST)
Received: from [10.136.8.252] ([192.19.228.250])
 by smtp.gmail.com with ESMTPSA id z185sm2492735pfb.17.2019.02.14.09.36.08
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 14 Feb 2019 09:36:09 -0800 (PST)
Subject: Re: [PATCH v4 6/8] dt-bindings: i2c: iproc: add "brcm, iproc-nic-i2c"
 compatible string
To: Rob Herring <robh@kernel.org>
References: <20190204231554.87666-1-ray.jui@broadcom.com>
 <20190204231554.87666-7-ray.jui@broadcom.com> <20190213211807.GA20560@bogus>
 <6de51a50-cd7c-dbf8-15d8-8d2fd441d831@broadcom.com>
 <CAL_Jsq+aH=SGD+NJWNaWKnZm3Y396ro7E_Px_Ud3NnzOYB+eGQ@mail.gmail.com>
From: Ray Jui <ray.jui@broadcom.com>
Message-ID: <723faefb-d13d-caf0-3bbd-9e3e698436a4@broadcom.com>
Date: Thu, 14 Feb 2019 09:36:06 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <CAL_Jsq+aH=SGD+NJWNaWKnZm3Y396ro7E_Px_Ud3NnzOYB+eGQ@mail.gmail.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190214_093612_455802_747F0FB5 
X-CRM114-Status: GOOD (  15.27  )
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



On 2/14/2019 6:02 AM, Rob Herring wrote:
> On Wed, Feb 13, 2019 at 4:09 PM Ray Jui <ray.jui@broadcom.com> wrote:
>>
>>
>>
>> On 2/13/2019 1:18 PM, Rob Herring wrote:
>>> On Mon, Feb 04, 2019 at 03:15:52PM -0800, Ray Jui wrote:
>>>> From: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
>>>>
>>>> Update iProc I2C binding document to add new compatible string
>>>> "brcm,iproc-nic-i2c". Optional property "brcm,ape-hsls-addr-mask" is
>>>> also added that allows configuration of the host view into the APE's
>>>> address for "brcm,iproc-nic-i2c"
>>>>
>>>> Signed-off-by: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
>>>> Signed-off-by: Ray Jui <ray.jui@broadcom.com>
>>>> ---
>>>>  Documentation/devicetree/bindings/i2c/brcm,iproc-i2c.txt | 5 ++++-
>>>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/i2c/brcm,iproc-i2c.txt b/Documentation/devicetree/bindings/i2c/brcm,iproc-i2c.txt
>>>> index d3a3620b1f06..02e82d20239e 100644
>>>> --- a/Documentation/devicetree/bindings/i2c/brcm,iproc-i2c.txt
>>>> +++ b/Documentation/devicetree/bindings/i2c/brcm,iproc-i2c.txt
>>>> @@ -3,7 +3,7 @@ Broadcom iProc I2C controller
>>>>  Required properties:
>>>>
>>>>  - compatible:
>>>> -    Must be "brcm,iproc-i2c"
>>>> +    Must be "brcm,iproc-i2c" or "brcm,iproc-nic-i2c"
>>>>
>>>>  - reg:
>>>>      Define the base and range of the I/O address space that contain the iProc
>>>> @@ -24,6 +24,9 @@ Optional properties:
>>>>      Should contain the I2C interrupt. If unspecified, driver will fall back to
>>>>      polling mode
>>>>
>>>> +- brcm,ape-hsls-addr-mask:
>>>> +    Required for "brcm,iproc-nic-i2c". Host view of address mask into the
>>>> +    'APE' co-processor
>>>
>>> What's the data type and size? What are valid values?
>>
>> It's an unsigned u32 mask value. An example of a valid value is for
>> example 0x03400000. Do you want any of these added to the paragraph above?
> 
> Yes. Bindings should define constraints.

Okay will do! Thanks.

> 
> Rob
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
