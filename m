Return-Path: <SRS0=7qzz=O6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9B18C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 10:43:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8323721906
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 10:43:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="egoxOVtD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8323721906
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=9zKXHH2CroyGenbfQnmbTBAHHPzBuNxYh8ePgR/uXz8=; b=egoxOVtDTR27sQZA/4/tHu1TN
	MUcHCVxw+6MZVxBmwjHkIpLvkbkPXaaa9lrkFrHy8JGpEtWD2k3Gfm191QqIEezBFXznvQ+4/m/fD
	tP/UFmHKFuaCISrSUYlwBRZuFqG1OD8ECug9W86KYtOdGrKJd0aX7zp5JugceSL81oq6CJ2cFX/jV
	Mo5kYHLEKYJAMkUIlu+J7XJP9RE2hHK7uYfI2SngfJDE2hDWeVlvS46EZ8YbeVM13d61+o4ECpVG9
	ai88fn1u8XF7y+0EC/T0Ev8Vug8oAUDzPtI46Ohtn3AWM5KcBVb3439X1cncBDMnnjuWjfGENx8IG
	ocvtPMHEA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gaIHD-0000vj-D8; Fri, 21 Dec 2018 10:43:31 +0000
Received: from mail-wr1-f66.google.com ([209.85.221.66])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gaIH9-0000jO-J8
 for linux-arm-kernel@lists.infradead.org; Fri, 21 Dec 2018 10:43:29 +0000
Received: by mail-wr1-f66.google.com with SMTP id r10so4717974wrs.10
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 21 Dec 2018 02:43:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=PaY6D5AxZFKBHi9C+xt5zlOnJi7qkpMTz/zEAfzHGXA=;
 b=lhFfiGrwLowJ45/9/o9IfkXljlyyVpEAmYFu4svQnAMyqDCKNnZM22F4f1Sx9gNswU
 +Jw2CrNzwy2OJnYs4Pzo685fmgD1CG/a3jdKRwvxo/WR+NFoyj7GyNUXgaGIB7IBma4q
 A1eOxDprvQeBG3qMciJK6PdCrlYTEOotkSz2z6elMmwS9v3yOd83zBLwUBISQHHN3NVH
 YFIMV7lh6th+GeQy1jnZtoC2QheH9oXkkCBvyDM2sAaGFwRqUlu2FLJEG+7xVNOVIsPi
 HcHvPhaDdbWvQ3bfQKpLQWFlPd3/7CPrIuRwg6FK6SROH2xsLf2sx5lR5EJ3GMYjMsZm
 1U0w==
X-Gm-Message-State: AJcUuke5f6fqEQzP3ocHpgKtzl8GKIbC1y/DMNnVtxm0DSVLvvBrzZOd
 wl5MxKfJekc7eENHq0M7QLftvg==
X-Google-Smtp-Source: ALg8bN7hbughlPeqdI0AY47i8WQKwPU516z2cGN32EPiI/L/zImY8rHSoCJ71BoTDAW1kTH46xCAGw==
X-Received: by 2002:a05:6000:100f:: with SMTP id
 a15mr2091384wrx.298.1545388995457; 
 Fri, 21 Dec 2018 02:43:15 -0800 (PST)
Received: from shalem.localdomain (546A5441.cm-12-3b.dynamic.ziggo.nl.
 [84.106.84.65])
 by smtp.gmail.com with ESMTPSA id q3sm16144405wrn.84.2018.12.21.02.43.14
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 21 Dec 2018 02:43:14 -0800 (PST)
Subject: Re: [PATCH 01/10] i2c: add suspended flag and accessors for i2c
 adapters
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
References: <20181219164827.20985-1-wsa+renesas@sang-engineering.com>
 <20181219223341.GA998@kunai>
 <e8bfcadc-7c1a-6659-7173-4ce484ceeca3@redhat.com>
 <2368540.q2jLLRDsj0@aspire.rjw.lan>
From: Hans de Goede <hdegoede@redhat.com>
Message-ID: <6fb7d574-9648-2960-5724-8b02a3348012@redhat.com>
Date: Fri, 21 Dec 2018 11:43:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <2368540.q2jLLRDsj0@aspire.rjw.lan>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181221_024327_629479_5E8F1D1B 
X-CRM114-Status: GOOD (  15.75  )
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
Cc: linux-pm@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>,
 linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 Wolfram Sang <wsa+renesas@sang-engineering.com>,
 Lukas Wunner <lukas@wunner.de>, linux-i2c@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi,

On 20-12-18 22:09, Rafael J. Wysocki wrote:
> On Thursday, December 20, 2018 11:00:29 AM CET Hans de Goede wrote:
>> Hi,
>>
>> On 19-12-18 23:33, Wolfram Sang wrote:
>>> Hi Lukas, Hans,
>>>
>>> On Wed, Dec 19, 2018 at 07:36:54PM +0100, Hans de Goede wrote:
>>>> Hi,
>>>>
>>>> On 19-12-18 18:22, Lukas Wunner wrote:
>>>>> On Wed, Dec 19, 2018 at 05:48:17PM +0100, Wolfram Sang wrote:
>>>>>> +static inline void i2c_mark_adapter_suspended(struct i2c_adapter *adap)
>>>>>> +{
>>>>>> +	i2c_lock_bus(adap, I2C_LOCK_ROOT_ADAPTER);
>>>>>> +	set_bit(I2C_ALF_IS_SUSPENDED, &adap->locked_flags);
>>>>>> +	i2c_unlock_bus(adap, I2C_LOCK_ROOT_ADAPTER);
>>>>>> +}
>>>>>
>>>>> This looks like a duplication of the is_suspended flag in struct dev_pm_info.
>>>>> Any reason why you can't use that?  If so, it would be good to document the
>>>>> reason in the commit message.
>>>>
>>>> Oh, that is a very good point and that one only gets set on system suspend
>>>> and not on resume suspend, working around the problems with the i2c-designware
>>>
>>> Just to make it clear: you mean runtime suspend, not resume suspend, or?
>>
>> Yes I mean runtime-suspend, sorry.
> 
> The power.is_suspended flag is about system-wide suspend, however.

Right, which is why it is good for us to use, when runtime-suspend the
i2c-adapter drivers transfer function will do a runtime_pm_get and all
is well, we want to check for someone trying to do i2c-transfers on
the adapter while it is system-suspended, since then the runtime_pm_get
is a no-op and things fail.

So for this use case it is a good thing that power.is_suspended flag is about
system-wide suspend (which is what I was trying to say in the first place).

Regards,

Hans


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
