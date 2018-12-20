Return-Path: <SRS0=AHqO=O5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67DC8C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 10:00:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35AD121741
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 10:00:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="A2dBqBHC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35AD121741
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=avNTgqN3FljlZY31fakDloEh0g+alLPJ+TPhp8AqOy4=; b=A2dBqBHCgpxYmo+M0OlXA2FPe
	GyMvq/2nZZF5szZkOvmn/XhbrJMTZD8qMDmCS65joxwcPZFUihtYSzrlcoTKIkRGgtmb8uUGoGXvU
	rOBdT0xblB9WOE7HEP4CM3RzVAH1Tf6EFfh+iqQyWV/lgpCwsYKYQljqZDpXH6v/lCT/EtN8IwtJD
	ErTm5Abss3nqTs9GCNt0gNka/YOSTuiOfvmx4ZZv6VGkzs+ndP1DxnylXybTBPRvPXhkGycK0iQ+e
	v/uZXflh08HfR+JUIR54bI9cLvafBzevXZSP6AwtnzMQW1SkqERJZpoJXv84MLKX9fuMgS5/+2Rcn
	8O4ZggRYg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZv8M-0001iD-TB; Thu, 20 Dec 2018 10:00:50 +0000
Received: from mail-ed1-f65.google.com ([209.85.208.65])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZv8F-0001gn-Bt
 for linux-arm-kernel@lists.infradead.org; Thu, 20 Dec 2018 10:00:48 +0000
Received: by mail-ed1-f65.google.com with SMTP id h50so1201160ede.5
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 20 Dec 2018 02:00:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ylwzKhANp4Cl8xusWKqb85xW+2cdSkQ3nxCl1I5yYWs=;
 b=dAb1/UdJoclBpXbIQtcwIfpcz/zcQXlUhCqFn0Mn4OsaoxczVckPS6Sd9h3F0l1XHn
 CEeShj7AK/+r27JtttUk4CI9ujA1T2CZzESpgC+WgHNJui1av4ya1lL0FlCHyShTlIN3
 9zaubouOgnddY2EfgSKNZ/DY9/MD9JDWpK3qtoKxbbgRnotT4LBPen0xqxpZNt5CxEDF
 uDG68/nKlAXz4braJ5Hb7umyU1BDay+1KIOqxF9KT4VuDh/EtU1byBGV3bsFgDtpTk6y
 1JFFgLyaBcT79TBsF5wvGtqiMhoMzwyskFfAI1ugxI4utiD+w4u5045B9JlLxLzPznHQ
 NLow==
X-Gm-Message-State: AA+aEWbLOMVKyek6RsgRI61T+mZODGL2YwUTGoNbErCbuAt7MKmlwGAJ
 flhih7tiUlswnE+ri72ILg2ioA==
X-Google-Smtp-Source: AFSGD/U+z0NW0ZSR9XZ3d8SpPEG73Cd5o78YWj37ciMqJWCZXrwore7exMuiLuL3XBB9kBNGDHua7g==
X-Received: by 2002:a50:d643:: with SMTP id c3mr22291753edj.178.1545300031177; 
 Thu, 20 Dec 2018 02:00:31 -0800 (PST)
Received: from shalem.localdomain (546A5441.cm-12-3b.dynamic.ziggo.nl.
 [84.106.84.65])
 by smtp.gmail.com with ESMTPSA id s3sm6001255edm.31.2018.12.20.02.00.30
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 20 Dec 2018 02:00:30 -0800 (PST)
Subject: Re: [PATCH 01/10] i2c: add suspended flag and accessors for i2c
 adapters
To: Wolfram Sang <wsa@the-dreams.de>
References: <20181219164827.20985-1-wsa+renesas@sang-engineering.com>
 <20181219164827.20985-2-wsa+renesas@sang-engineering.com>
 <20181219172250.ytronxeq2yc4vp4r@wunner.de>
 <83b17734-2437-5a04-8843-e18ccf7ad398@redhat.com>
 <20181219223341.GA998@kunai>
From: Hans de Goede <hdegoede@redhat.com>
Message-ID: <e8bfcadc-7c1a-6659-7173-4ce484ceeca3@redhat.com>
Date: Thu, 20 Dec 2018 11:00:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20181219223341.GA998@kunai>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181220_020043_407453_93D5E96C 
X-CRM114-Status: GOOD (  23.29  )
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
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org,
 Wolfram Sang <wsa+renesas@sang-engineering.com>,
 Lukas Wunner <lukas@wunner.de>, linux-i2c@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi,

On 19-12-18 23:33, Wolfram Sang wrote:
> Hi Lukas, Hans,
> 
> On Wed, Dec 19, 2018 at 07:36:54PM +0100, Hans de Goede wrote:
>> Hi,
>>
>> On 19-12-18 18:22, Lukas Wunner wrote:
>>> On Wed, Dec 19, 2018 at 05:48:17PM +0100, Wolfram Sang wrote:
>>>> +static inline void i2c_mark_adapter_suspended(struct i2c_adapter *adap)
>>>> +{
>>>> +	i2c_lock_bus(adap, I2C_LOCK_ROOT_ADAPTER);
>>>> +	set_bit(I2C_ALF_IS_SUSPENDED, &adap->locked_flags);
>>>> +	i2c_unlock_bus(adap, I2C_LOCK_ROOT_ADAPTER);
>>>> +}
>>>
>>> This looks like a duplication of the is_suspended flag in struct dev_pm_info.
>>> Any reason why you can't use that?  If so, it would be good to document the
>>> reason in the commit message.
>>
>> Oh, that is a very good point and that one only gets set on system suspend
>> and not on resume suspend, working around the problems with the i2c-designware
> 
> Just to make it clear: you mean runtime suspend, not resume suspend, or?

Yes I mean runtime-suspend, sorry.

>> driver.
>>
>> I think this might be as simple as adding:
>>
>> 	if (WARN_ON(adap->dev.parent->power.is_suspended))
>> 		return -ESHUTDOWN;
> 
> I have seen this flag but decided against it. One reason is because it
> is marked as "PM core only".

Right and we definitely should not be touching it, but reading it should
be fine.

> The other reason is that it doesn't know
> about the adapter lock. It might get set while a transfer is on going.
> Or even right after the suggested if-block above. The code from this
> series gets the mutex first which ensures that on going transfers are
> completed and no new ones are started in parallel.
> 
> Unless I am totally overlooking something...

No you are right, there is a race here, but I don't think we are likely to
hit that race. Normally there won't be any ongoing i2c-transfers during
a system suspend and more over, the goal of adding this check is to help
find problems, so even if the check sometimes does not trigger because
of the race that is not really a big deal.

I think we need to get really unlucky to have both a suspend ordering
problem in the first case (already a somewhat rare thing) combined with
hitting this race in such a way *each time* that we don't trigger the
WARN_ON.

To me this seems a case of perfect being the enemy of good. When we
first started discussing this you wanted to not have to modify the
adapter/bus drivers for the check, using adap->dev.parent->power.is_suspended
gives us that and it will also work for complex cases like
the i2c-designware case, so I believe the benefits outway the downsides.

Regards,

Hans

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
