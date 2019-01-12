Return-Path: <SRS0=Pwbl=PU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29CD5C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 00:00:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EBCFB20835
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 00:00:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="d0BX22rY";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="hZbJUPab"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBCFB20835
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:References:To:From:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=LaBOwBJYEGMXijF/lH5GT33Zhjf5v7NcF+jfQceoBno=; b=d0BX22rYs+NLbd
	al14rIdp0pVdr7pDolDEFZ24EidftYrzLSHQMjDsWGM0BfJW5FhfJ+rAuRIG7A/WLt7UU9p6IWYBM
	VY1ylEDCmcHQgG7gaJjSdHUSL+K9oUvhvjdhiN4LBcJ85wQ3BbvrruOXyez6AmfMWQhCy5dqz4HM/
	Aek9geUZrYGHj1Z71KaWqCDHoRMTAWsCj6PISGKjw11WFQXTErEsBkckQe6ki258Lw3eLA1rojLZF
	gUuzKtHo6eZtldLI0SmoS/SLTs2KQEzQ/e4zPsKj+ORapCKWd9lxrbDj4yINBt0VJaGxMFMlmoGL/
	XuKJR/3awjh12PzrYXSg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gi6ig-0000Iw-TK; Sat, 12 Jan 2019 00:00:10 +0000
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gi6id-0008Dz-DP
 for linux-arm-kernel@lists.infradead.org; Sat, 12 Jan 2019 00:00:08 +0000
Received: by mail-pf1-x444.google.com with SMTP id w73so7659726pfk.10
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 11 Jan 2019 16:00:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=broadcom.com; s=google;
 h=subject:from:to:cc:references:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=DIb5ZZ61dhJIsm5eebZpvwyPOg9fvjGO5QFZAz5c3pU=;
 b=hZbJUPabkl9in2iiBjnWYzk8UbY26yaewu/ypOFm1xJvr/GG94DumCeDxXm/TC7w4W
 Cn9JS2USdW6L2VKDg4m5jskquiuO4FHOrPSqkdii2aaVVApSokYhgTJXfdTh0pF//osU
 XyMTo5a9Wq3xbRKi+YfVxyZwIBZ0fM/xsYLvM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=DIb5ZZ61dhJIsm5eebZpvwyPOg9fvjGO5QFZAz5c3pU=;
 b=OGzSBzAXHl42DGA8zswFjMHWrLcynDaqBI4tD2Mk/68dplm+amJisvnBvgu7d7ztII
 lruX8Mv2gBX5afDZU1OHNFM+RmckLwFBpvcS3pXsPlafhRaZ8mZIwSFqBhi/XaQNYdQE
 xqvnf7ZxBo0pGgyZPMwYmW1cfH/gWfYrkWZUnYxX7WldPn6BjOkgeGGxaIIfw47FPplD
 NtEVT32EVEkZ1kXorZgwDbww1drqWhpTIAhKTAQxGVkDQlahoRrgzIlCWEe7GihQ/2/o
 wlMcfUQ4e5RPR7CJkkW4t0/bJsg3RcPy2RVW0kVF+W8P+7YDQNfcZB1sR37qNLPG6hJL
 8hqg==
X-Gm-Message-State: AJcUukc0uNrUXoR4fLwm0A/SzijRwSU3OzI2wh5sVnbJO55XFjqdtSx0
 YYGAERelGmi0QFtyDoyKhv67taTkJDNl6jeMmADvPPrvH4WS8nmioed8VJ23VaQ3ntRgi/AUPth
 +APGRAgIEH7VCdVzYnWidEsngnS1t5yxEwkIUsu08lZXJ+mXLMkb6JJzlNMbyEYYbavN+5GSO6X
 SUoFAlrk66fic=
X-Google-Smtp-Source: ALg8bN4Q/mF7DRfyKP6GSmsmR4tjPIiDsgaCYqss7xOssnsfPRn/ohM8P/D1V1G6RiMqtsTTcjBrZQ==
X-Received: by 2002:a62:9f1b:: with SMTP id g27mr16055565pfe.87.1547251206166; 
 Fri, 11 Jan 2019 16:00:06 -0800 (PST)
Received: from [10.136.8.252] ([192.19.228.250])
 by smtp.gmail.com with ESMTPSA id v9sm115020476pfg.144.2019.01.11.16.00.03
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 11 Jan 2019 16:00:05 -0800 (PST)
Subject: Re: [PATCH INTERNAL V3 0/3] Add support for PWM Configure and
 stablize for PWM kona
From: Ray Jui <ray.jui@broadcom.com>
To: Sheetal Tigadoli <sheetal.tigadoli@broadcom.com>,
 Thierry Reding <thierry.reding@gmail.com>, Rob Herring <robh+dt@kernel.org>,
 Florian Fainelli <f.fainelli@gmail.com>, Ray Jui <rjui@broadcom.com>,
 Scott Branden <sbranden@broadcom.com>
References: <1547183284-19956-1-git-send-email-sheetal.tigadoli@broadcom.com>
 <4678b237-d0df-ef85-182f-759125a5c085@broadcom.com>
Message-ID: <2b177b2c-e7f1-791b-087c-b01d9b81f923@broadcom.com>
Date: Fri, 11 Jan 2019 16:00:02 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <4678b237-d0df-ef85-182f-759125a5c085@broadcom.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190111_160007_493066_E952962D 
X-CRM114-Status: GOOD (  13.02  )
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
Cc: linux-pwm@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org



On 1/11/2019 3:58 PM, Ray Jui wrote:
> Please remove 'INTERNAL' in all of your patches and cover letter.
> 

Never mind, saw your next patchset with this issue fixed....

> On 1/10/2019 9:08 PM, Sheetal Tigadoli wrote:
>> Hi,
>> 	This patchset contain support to make PWM changes configure
>> 	and stablize
>> 	Following are brief changes done
>> 	a. Add support for version2 compatible string
>> 	b. Change PWM config and stablize delay in PWM Kona
>>
>> Praveen Kumar B (3):
>>   dt-bindings: pwm: kona: Add new compatible for new version pwm-kona
>>   drivers: pwm: pwm-bcm-kona: Add pwm-kona-v2 support
>>   ARM: dts: cygnus: Change pwm compatible to new version
>>
>>  .../devicetree/bindings/pwm/brcm,kona-pwm.txt      |   2 +-
>>  arch/arm/boot/dts/bcm-cygnus.dtsi                  |   2 +-
>>  drivers/pwm/pwm-bcm-kona.c                         | 128 ++++++++++++++++-----
>>  3 files changed, 100 insertions(+), 32 deletions(-)
>>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
