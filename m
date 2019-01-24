Return-Path: <SRS0=pdKw=QA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD6ECC282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 18:53:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D0E7218A6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 18:53:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="IIoo6ByU";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Dq6Jhcuc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D0E7218A6
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=+pvgn1eZs4/HrDiKMNbgN8VyZhwnj0vlscz0P1VlwzE=; b=IIoo6ByUk0psHeIGj8lrKOJ7t
	TACWvan7S868ZMxGgZHRnrgvoNHzOhO4Hl43hoOrYlVkV78ngwq5e3+o09VD4BICrX36u0K04SSX0
	O6L2F1Wqv0RZlUybml+pduFQkN2Hb48aHQQFXirPV97CQESlGS/wHjM18Ku5647fY1uix676+v+S/
	dw0/tLJ7cq2jIIo3nb8JyA2TBwvm6W0tLvTJiAM0/zOf0ut4OEYgIY8bFlOXt7oDWfyZbp2SmPzVf
	vp+mx43jrIQqsVzQ5vppdGDP9TByYMP1ssa6T5rwTOpbZecJcPyoFdPTv4vyqwdml7b/7Fc8WQ86z
	2fjGADThQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmk7x-00032C-SS; Thu, 24 Jan 2019 18:53:25 +0000
Received: from mail-yw1-xc44.google.com ([2607:f8b0:4864:20::c44])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmk7t-00031Z-Oc
 for linux-arm-kernel@lists.infradead.org; Thu, 24 Jan 2019 18:53:23 +0000
Received: by mail-yw1-xc44.google.com with SMTP id i73so2859705ywg.3
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 24 Jan 2019 10:53:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=broadcom.com; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=QLX/QOlTZWw+tAjbeYdhZ1fbepA115XW5TiGiA4xmLk=;
 b=Dq6JhcucpvslU26/DgU8IrHLcL5OW6lM5Qact4C3MklLOPQCJ8JDGfJ3MjaszwAowi
 Qi7qU86ZReDZb5ddWwoAz+QEnNNCvh+JGxAjhD1QFHxrI5Ft3p/ql3ujbI4YZ1FwlIz+
 drLN3zuh/zcyc1g5o5KzIO6VQ9Hm1Xo0+ohCc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=QLX/QOlTZWw+tAjbeYdhZ1fbepA115XW5TiGiA4xmLk=;
 b=VW5zNUdAFY/1hqJVQvCp0A2SZ4F3+nn6DTveQY7vVy34s9E/69Y0/pdvJ+9HA9oS3o
 gS4EwqsasPbjMDSGT2qn4dFpjS+uAxeYAziMi+TTXSCHLLQhqEy2oKr7WaXRey5u3eSj
 HCFfGNdRESn6SCfiNIUT/jeDalESXX/lwYCFFSFpbnoF68uDn2bOoumObepdHLLP5P6d
 PNZWdh663xdW+kpCuRm3GHiU21M1t7nE2sQkUAREqgPXY7+O2RRk80i4CzZUqodgd15M
 FBjjJeBQISTKGUogNBzGFONMXphEbVvfcdsBG22kUt4URNQgdVgGpb+q/b7h7eTikQtc
 eCxA==
X-Gm-Message-State: AJcUukeZy1TRfzlbOvYBmiirYRSQRWg7E13wO4F2UO6ba/7hkQohDRUl
 W2g3lbn0CfsWKOpUaD7R3FK/NENaGmGIvK5MH39LvoBmqlriFHkuknHLzLaIheyPOqjA/T2QF2n
 145OrkLVX0sxa2XamnVKcV1Uc6nRL6XVgSJAu7ibk18vtedaYvJZEPFpdqQeEYbgY6Kt2c3mc24
 Do01ofN0+MXdec7DflIekaGw==
X-Google-Smtp-Source: ALg8bN6q+CR6Vk03gZAPXk5rLYW55vjDQWgY12zyiMsgkmQI4hdpu/dAu0FJa7pll3bnhemMYwOyGA==
X-Received: by 2002:a81:8d44:: with SMTP id w4mr7798014ywj.121.1548355999404; 
 Thu, 24 Jan 2019 10:53:19 -0800 (PST)
Received: from [10.136.13.65] ([192.19.228.250])
 by smtp.gmail.com with ESMTPSA id b144sm16274777ywa.33.2019.01.24.10.53.16
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 24 Jan 2019 10:53:18 -0800 (PST)
Subject: Re: [PATCH V2] soc: bcm: Make PM driver default for BCM2835
To: Eric Anholt <eric@anholt.net>, Stefan Wahren <stefan.wahren@i2se.com>,
 Florian Fainelli <f.fainelli@gmail.com>, Ray Jui <rjui@broadcom.com>,
 Scott Branden <sbranden@broadcom.com>
References: <1548353060-4900-1-git-send-email-stefan.wahren@i2se.com>
 <87imydvs55.fsf@anholt.net>
From: Scott Branden <scott.branden@broadcom.com>
Message-ID: <fc40f7a3-8c28-f6fe-c9c0-0af0b55a9ffe@broadcom.com>
Date: Thu, 24 Jan 2019 10:53:13 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <87imydvs55.fsf@anholt.net>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190124_105321_803284_BC82CD40 
X-CRM114-Status: GOOD (  13.08  )
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
Cc: Arnd Bergmann <arnd@arndb.de>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>, bcm-kernel-feedback-list@broadcom.com,
 linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


On 2019-01-24 10:15 a.m., Eric Anholt wrote:
> Stefan Wahren <stefan.wahren@i2se.com> writes:
>
>> Since commit 52a4adbaebcc ("ARM: bcm283x: Switch V3D over to using the
>> PM driver instead of firmware.") VC4 on BCM2835 requires the power driver.
>>
>> Otherwise the driver won't probe and HDMI output stays black:
>> vc4_v3d 20c00000.v3d: ignoring dependency for device, assuming no driver
>>
>> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
> Reviewed-by: Eric Anholt <eric@anholt.net>
Reviewed-by: Scott Branden <scott.branden@broadcom.com>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
