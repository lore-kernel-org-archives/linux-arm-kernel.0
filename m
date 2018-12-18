Return-Path: <SRS0=e5Gl=O3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A41F4C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 21:45:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70963218A4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 21:45:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ZAnDp56n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70963218A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=9nLNwchA2JYEqYiO1DDCFgYq50zV14wHYIsG2rgya30=; b=ZAnDp56nDVKYYLfF7Vpdt6eFR
	GoXzMXNDBVDhoRTNlihxW8daK9huOiRklDFJo0NSkZQiB+jHgt2DoMpDjX6qlYA4gguetZn9zIxeH
	YdzZ7x7Udgx47OZhEy4hB9DhmfmMA7EdWm96UrjQZD4LWoH2Oj7Try2osZAg+XcOiDL0PisYhCEE3
	qdZdgdsv2KDMJaRdwSqE5dy18yCCaJZjLR5Oh1fAzyMYUasjqWUo9XVYbjvcTzu9M0M9WjJ+5rN69
	Fcsn9kjMdRZIny+QHLvi9c4Z6iwRT9KJm4b++JuM/Mq2Wbq5yoCkA4Du+p6Hi23Hi3C0UgunbY3ed
	ULj0KpTtQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZNAf-0000S6-61; Tue, 18 Dec 2018 21:44:57 +0000
Received: from mail-ed1-f67.google.com ([209.85.208.67])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZNAa-0000QY-Ty
 for linux-arm-kernel@lists.infradead.org; Tue, 18 Dec 2018 21:44:55 +0000
Received: by mail-ed1-f67.google.com with SMTP id h15so15190907edb.4
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 18 Dec 2018 13:44:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=/4YM38h5I7FYM3fZcCUxJRlotVc6EBl5uu1FPsKe3r8=;
 b=lEjPRBWUJm6Kh3rTWzuW5etineCrKHzxLN+dc/D7vYiXl7fwKaPkmrOEqtmyxQfOzZ
 ocLsxM6MXjeyMsYQ9aIdmbuJZcXHrKLe6HCSntFLRi9r52NfetSQoTz75Px1wX8BW2tS
 zVB4Wb7OsvA5BsXf4HISsz24DjXZ2VNfwomIaW/s/S6kwY3bqqbic+2Q9DUcnG4Z9I3b
 l+ZsZqhkYDTXTKSPs0Z7Xs+FUyscuM8foZqI2A9f3ZfMjWPlclXOdrzzGXQbz2K0AUam
 aTx1Xpz7/VkTNw70LC7cEAGUA9LjqUdXwxS4WBPoOX0Cz0I2zL3UigZ8ju5msFZsjoC+
 4zgw==
X-Gm-Message-State: AA+aEWZU2FP0rdnB3/lOq7Q1V9Sale6htDmXFV1Sh40JtAWdg/SfpOiI
 2YCjZNwsGXkODcvVN5TDgUayxw==
X-Google-Smtp-Source: AFSGD/VHkxHMyI/ltmGdbYIuLESE9T25ZVzawZaz1WNlpDqyn8n1Mb+Jxvt12rWJR7J5C+DetMFWVg==
X-Received: by 2002:a05:6402:758:: with SMTP id
 p24mr18247129edy.92.1545169480431; 
 Tue, 18 Dec 2018 13:44:40 -0800 (PST)
Received: from shalem.localdomain (546A5441.cm-12-3b.dynamic.ziggo.nl.
 [84.106.84.65])
 by smtp.gmail.com with ESMTPSA id 24sm4713243eds.97.2018.12.18.13.44.39
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 18 Dec 2018 13:44:39 -0800 (PST)
Subject: Re: [RFC/RFT 00/10] i2c: move handling of suspended adapters to the
 core
To: Wolfram Sang <wsa@the-dreams.de>
References: <20181210210310.12677-1-wsa+renesas@sang-engineering.com>
 <2094a0d4-733f-7f74-abd2-bdb28edd0f80@redhat.com>
 <20181211234102.GA6701@kunai>
 <e8c68ef5-5085-e304-4959-82c4959f4511@redhat.com>
 <20181218201725.2uqfmsethlkasdvc@ninjato>
From: Hans de Goede <hdegoede@redhat.com>
Message-ID: <0e6b0ea6-e472-19f2-bb2f-61a1d66e6091@redhat.com>
Date: Tue, 18 Dec 2018 22:44:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20181218201725.2uqfmsethlkasdvc@ninjato>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181218_134452_967632_36503CFA 
X-CRM114-Status: GOOD (  23.01  )
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
Cc: linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 Wolfram Sang <wsa+renesas@sang-engineering.com>,
 bcm-kernel-feedback-list@broadcom.com, linux-i2c@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi,

On 18-12-18 21:17, Wolfram Sang wrote:
> Hans, all,
> 
>>> ... this. I don't know what these flags do (and reading SMART in there
>>> gives me more a 'uh-oh' feeling)
>>
>> On x86 the lines between runtime suspend and system-suspend are blurring
>> with technologies like "connected standby" and in general devices moving
>> to suspend2idle as system-suspend state, I guess this also applies to
>> modern smartphone platforms but I'm not following those closely.
> 
> I'd guess so, too. I am not aware of any existing mechanism for that at
> the moment, though. If somebody does, please enlighten us.
> 
>> The "SMART" bit is really not all that smart, SMART_PREPARE means that
>> the drivers pm prepare callback will return positive non 0 (e.g. 1) to
>> indicate that the device may not be kept in its runtime suspended
>> state when transitioning to system-suspend, otoh when the prepare
>> callback returns 0 and the SMART_PREPARE flag is set then *all* suspend/
>> resume handling can be skipped during a system suspend.
> 
> Thanks for the detailed explanation! Much appreciated.
> 
>>> Looking at the open coded version you did for the designware driver, I
>>> wonder now if it is better to just leave it at driver level? Need to
>>> sleep over it, though.
>>
>> I myself was thinking in the same direction (leave the entire suspended
>> check at the driver level).
> 
> So, I was giving it some more thoughts, and my feeling is to still apply
> this series with the review comments addressed. Plus, clearly mark the
> new 'is_suspended' flag and the helper function as *optional* to allow
> for driver specific solutions as well. The then-to-be-added
> documentation would state that it is mostly useful for seperated system
> suspend and runtime suspend. For more complex situations, custom
> solutions are accepted, too. Which means your patch for designware
> should be added to the series.
> 
> My take is there are enough drivers out there already which can benefit
> from this new helper. If it turns out to be useless somewhen in the
> future, we can still remove it.
> 
> What do you (and all others, of course) think?

I've been thinking along the same lines: your series for the drivers
with separate runtime and system suspend handlers, "custom" driver
specific code for troublesome cases like i2c-designware.

Do you want me to send out a new version of my patch for the i2c-designware
code?

Regards,

Hans

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
