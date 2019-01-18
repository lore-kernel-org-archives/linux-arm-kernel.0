Return-Path: <SRS0=p0aQ=P2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41A97C1B0F7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 21:30:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0091020883
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 21:30:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="eFzUX/uS";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dYgbsueP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0091020883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:References:To:From:Subject:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=r5TrW/Vg0OvHgUuSHK19jNkVxPHJ1s54V8039SQ9pK4=; b=eFzUX/uSnUGEl+fnBd+GKt5mNK
	Ly4yPtYBF/rdTrfCkQUPeBnDkwQ+RUCHkthMoRm7yxeKub1qfLRxW7WdydHDz/+zstOznIJG2By7L
	nK9jxYo+D5GqWSH5IPicOda3nQ3NBBCiBvHKeWnNshaTG4lx1yGEbv/JehxT/NnZjNTKFPCjUFnJC
	AZe2pAG5y2cmdM4nlbh8OQZ9SEcm1X3qK6Jw335k4GeLEz6cnN0jkGwxwmGC3cAIZemUdceRhn99O
	xplkZLSQmZ8kOsifADeLNI6xBh5pXWlRW9JVzDD3eEU1eIuBMU8d9m6GcVe3XOweKE0ipXIMq6iHy
	zhaAfLxw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkbij-0005lf-JG; Fri, 18 Jan 2019 21:30:33 +0000
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkbig-0005l2-DF
 for linux-arm-kernel@lists.infradead.org; Fri, 18 Jan 2019 21:30:31 +0000
Received: by mail-wr1-x442.google.com with SMTP id z5so16732354wrt.11
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 18 Jan 2019 13:30:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:from:to:references:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=ASyPkJe1vUYkZLryeTFK6WGSsiVqG9H7NEDFjFCVtZ4=;
 b=dYgbsueP/Ucli5LOj5DxeKQNo1gnS3SAmSUlOm0n4INDqCU36hNvZpKsa1tdy/goqG
 cPZbgOIOuwJ1bDS6EWlnAVbsPrVSnlhPdCwPxao86xY9mWFGufSbdjYu5WnMcHa56Ovi
 di2kI6ayOwsqhP5EGZJOKesNG+GZKP1gV7BCi7adytjwCuPzHpSfMWQyaIuGGQgMmDrN
 Djl1VRqbIMvYMMDYq8jmGX6UKesc7mHTkiQA4Na9X5qtOBYZh3t4y4XM+iyw5aSd3tli
 dyranaesc+lbB3Ky4nuoybiATIbXqQ8cOGVyn/JN4tEVQJfAmjfbS0KlSm6da1xOaZ0i
 2+Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ASyPkJe1vUYkZLryeTFK6WGSsiVqG9H7NEDFjFCVtZ4=;
 b=hyswEfjluQqQ3U8b1DAVwBnHxBq3OH9gIIgtEcPAZP1ndoiDZRJJmOwVEJAWuVpmCt
 1IKxAqOvVRg7oDIwnGIKRJ8jENCWCHpnTjQTK19/KDPwy70emCy7dTBTJUVeMjE+Zkrv
 ezgoSU/gp1PhIZtjZfUTwRRuz5VIsjV2htitC7oNjciuWwT1efu5BEao/Tn6CEOi22PX
 tA5BseQMOQ5MqU07F4bfMNM+k0NmldiSXS0gtnwwvCBBl5xO4a8xEYPCXO/4zfF/NlFt
 fk/8H87qupcmlQjigAZNQYVSHIZOz7WUatr0SciihF/fjrFXIul8m8kd8eoKvuF5DrP8
 uqFA==
X-Gm-Message-State: AJcUukdiVYSSpJOJBipzKtJMp8Yg2wiWgJJQqfuJAnYoIlzB0eE6naIO
 /siSPQn6E/RUMTNid1Hn6D4=
X-Google-Smtp-Source: ALg8bN7ifnm7rTmyd9Mtws4mAhEkEHKatS4tY0+cTyVGgxo7QdJaPJXyHSox4/Bze6pIZcJIIfwJAw==
X-Received: by 2002:adf:ff09:: with SMTP id k9mr17372666wrr.97.1547847028753; 
 Fri, 18 Jan 2019 13:30:28 -0800 (PST)
Received: from ?IPv6:2003:ea:8bf1:e200:8c88:93e4:233d:557?
 (p200300EA8BF1E2008C8893E4233D0557.dip0.t-ipconnect.de.
 [2003:ea:8bf1:e200:8c88:93e4:233d:557])
 by smtp.googlemail.com with ESMTPSA id
 c202sm47595679wmd.40.2019.01.18.13.30.27
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 18 Jan 2019 13:30:28 -0800 (PST)
Subject: Re: [BUG bisect] Missing Micrel driver on VF50 (net: phy: check
 return code when requesting PHY driver module)
From: Heiner Kallweit <hkallweit1@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Stefan Agner <stefan@agner.ch>
References: <CAJKOXPdHhUGoQmrX8_23MfbibozipkAzXA_5woVSFJSK9BvbXw@mail.gmail.com>
 <CAJKOXPe7ot9TLajErKJjSAkbs2vObMJfATzEFwxpT16aFdXHqg@mail.gmail.com>
 <67560e58-93b3-2bfa-9d5d-5956dae47806@gmail.com>
Message-ID: <68b565a2-7813-57a2-1687-43568e53fade@gmail.com>
Date: Fri, 18 Jan 2019 22:30:16 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <67560e58-93b3-2bfa-9d5d-5956dae47806@gmail.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190118_133030_482629_C3188E6A 
X-CRM114-Status: GOOD (  16.99  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 18.01.2019 21:58, Heiner Kallweit wrote:
> On 18.01.2019 09:48, Krzysztof Kozlowski wrote:
>> On Fri, 18 Jan 2019 at 09:39, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>>>
>>> Hi,
>>>
>>> On today's next (next-20190118) my Colibri VF50 board fails to boot up
>>> from network (DHCP, NFSv4 root). Looks like missing network adapter.
>>> Expected:
>>> [ 3.041773] Micrel KSZ8041 400d1000.ethernet-1:00: attached PHY driver
>>> [Micrel KSZ8041] (mii_bus:phy_addr=400d1000.ethernet-1:00, irq=POLL)
>>>
>>> Result:
>>> [ 15.614964] Root-NFS: no NFS server address
>>> [ 15.619353] VFS: Unable to mount root fs via NFS, trying floppy.
>>> [ 15.626762] VFS: Cannot open root device "nfs" or unknown-block(2,0): error -6
>>> [ 15.634252] Please append a correct "root=" boot option; here are the
>>> available partitions:
>>> [ 15.642791] 0100 16384 ram0
>>> [ 15.642804] (driver?)
>>> [ 15.649076] Kernel panic - not syncing: VFS: Unable to mount root fs
>>> on unknown-block(2,0)
>>> [ 15.657423] ---[ end Kernel panic - not syncing: VFS: Unable to mount
>>> root fs on unknown-block(2,0) ]---
>>>
>>> Bisect pointed to:
>>>     net: phy: check return code when requesting PHY driver module
>>
>> I see now in the logs:
>> [ 2.436822] mdio_bus 400d1000.ethernet-1:00: error -2 loading PHY
>> driver module for ID 0x00221513
>> which is kind of misleading. There is no initramfs so there is no
>> usermod library at this point. It is not needed. This seems to break
>> all DHCP/NFS root boots without initrd/initramfs.
>>
> Thanks for the report. Could you please provide your kernel config
> and the syslog of a boot before or w/o the patch in question?
> 
> If you boot via nfs then I'd expect that the PHY driver is built-in and
> not a module. Therefore it's not fully clear to me yet why
> request_module() returns -ENOENT.
> 
OK, I see. The -ENOENT could refer to the modprobe binary, not the PHY
driver module. Still it would be helpful to see the kernel config and
the requested log.

>> Best regards,
>> Krzysztof
>>
> Heiner
> 


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
