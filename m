Return-Path: <SRS0=AchV=O4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC1FDC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 18:37:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C0D52080D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 18:37:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="p1v6YSIT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C0D52080D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=rMDDbzoNfbwnFgcQcD21jOMz3Wof8AHo7jyMYyNn3qE=; b=p1v6YSITe/cbtWoKWY65viugN
	686yQmuk+T8FTL9bv8AvaRwUtmU5Vq01MNENvxV1GLFB+hurITMU5I9fcyFIQi+cTsEyLJgmLoH1u
	sGZKQrNK7139PCrSXK9gS58qOvBHJVWIIFv6VPQLb+Aq6BY/1zenEsUGhcjAixqIKBDsF8TKnYSsp
	rrruJK4tqwbjdBP4FMcKx8SdV84z8t4ffax/kPeYtkozCXuWGiU3yX+hWlO310yk7NYlPAfftocKE
	IJngq9+QHR3FNIKdUYSXJMh43gOdXtWB5WUcmeS8CEAh4zaVAF/3KpOLUg1In54igNAHE2c1dRF/C
	m8h2JFkeQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZgiV-0000wT-8p; Wed, 19 Dec 2018 18:37:11 +0000
Received: from mail-wm1-f67.google.com ([209.85.128.67])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZgiS-0000vo-3E
 for linux-arm-kernel@lists.infradead.org; Wed, 19 Dec 2018 18:37:09 +0000
Received: by mail-wm1-f67.google.com with SMTP id b11so7016527wmj.1
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 19 Dec 2018 10:36:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=SeMoYYRoyywUMQiBfYtyiBEqpBgxDAi4Kzp38E75PII=;
 b=QATaLkcWbgCsuw3nnC70eBIal0MY05cpcAOIjqxgE3mnwHXDvHlmux0J2wNEJvnkVV
 gvwCxCnaa++HUMzm9mqYpmmsT9yqEU81FXBf7ZWxHCqMvPjIB+tNii54KyBQ9RAAfAfI
 P9RtnJY7yXVppB5dXM8qIANxuoDN8Wc8Qf+8VgFqSizzNJufe82bzv7AjgSrtHcI0mX5
 VT160TLT1jW1kcabjng9OOIU1Qr8r3YoBXlNYqQKczEnVbjwTNo+5uAz74exrnNm4VW1
 LSMJruY3SbkMPNUTFxE81FxLrJsn7uWh93TkpDjOtQWoggicUp60oVY8iDtf5Q/4jfbK
 dHTg==
X-Gm-Message-State: AA+aEWYuFXcLdSXMDNqJUhwC4QTFvWAQldL/WB/70LVX3VwvcfoSmUOP
 61XKAlSy0txPd26L9PdEZj478utxTBE=
X-Google-Smtp-Source: AFSGD/VrV7Pi1wSTXLqwxHensRMP9RR7G+tFOZrNU2YmaOlCRChdKNz2h7R0BLMxLh3iekUWzbv5SA==
X-Received: by 2002:a1c:d912:: with SMTP id q18mr8153087wmg.122.1545244615827; 
 Wed, 19 Dec 2018 10:36:55 -0800 (PST)
Received: from shalem.localdomain (546A5441.cm-12-3b.dynamic.ziggo.nl.
 [84.106.84.65])
 by smtp.gmail.com with ESMTPSA id x20sm8926562wme.6.2018.12.19.10.36.54
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 19 Dec 2018 10:36:55 -0800 (PST)
Subject: Re: [PATCH 01/10] i2c: add suspended flag and accessors for i2c
 adapters
To: Lukas Wunner <lukas@wunner.de>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>
References: <20181219164827.20985-1-wsa+renesas@sang-engineering.com>
 <20181219164827.20985-2-wsa+renesas@sang-engineering.com>
 <20181219172250.ytronxeq2yc4vp4r@wunner.de>
From: Hans de Goede <hdegoede@redhat.com>
Message-ID: <83b17734-2437-5a04-8843-e18ccf7ad398@redhat.com>
Date: Wed, 19 Dec 2018 19:36:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20181219172250.ytronxeq2yc4vp4r@wunner.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181219_103708_133949_71188C2F 
X-CRM114-Status: GOOD (  19.73  )
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
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi,

On 19-12-18 18:22, Lukas Wunner wrote:
> On Wed, Dec 19, 2018 at 05:48:17PM +0100, Wolfram Sang wrote:
>> +static inline void i2c_mark_adapter_suspended(struct i2c_adapter *adap)
>> +{
>> +	i2c_lock_bus(adap, I2C_LOCK_ROOT_ADAPTER);
>> +	set_bit(I2C_ALF_IS_SUSPENDED, &adap->locked_flags);
>> +	i2c_unlock_bus(adap, I2C_LOCK_ROOT_ADAPTER);
>> +}
> 
> This looks like a duplication of the is_suspended flag in struct dev_pm_info.
> Any reason why you can't use that?  If so, it would be good to document the
> reason in the commit message.

Oh, that is a very good point and that one only gets set on system suspend
and not on resume suspend, working around the problems with the i2c-designware
driver.

I think this might be as simple as adding:

	if (WARN_ON(adap->dev.parent->power.is_suspended))
		return -ESHUTDOWN;

To __i2c_transfer (and document the -ESHUTDOWN) combined with removing
all the now no longer DIY code from various bus drivers.

Regards,

Hans




> 
> If the point is to constrain refusal of transfers in suspended state to
> certain drivers, those drivers could opt in to that functionality by
> setting a flag, and the i2c core could then gate refusal based on
> that flag and the is_suspended flag in struct dev_pm_info.
> 
> Also, why is it necessary to take a lock to perform an atomic bitop?
> (Sorry if that's a dumb question, seems non-obvious to me.)
> 
> Thanks,
> 
> Lukas
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
