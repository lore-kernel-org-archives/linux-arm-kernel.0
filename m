Return-Path: <SRS0=p0aQ=P2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5644C1B0F7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 20:58:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9164E20883
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 20:58:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="UufcfF2v";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="boihO4tv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9164E20883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=i7DhN+l5sghd2i0jHUKs2CWv4JSPikpzmr2wcDaO4Ok=; b=UufcfF2v8Y8zjuJ5JqLK1y7MQr
	OLn0/3VJD25/R8XP4xHSROtJlVJiQmgkh9JHT74E8dzUcvrgBe/AJPWpWrUbWJNSbQfd1S8sm3rVc
	EkJEYbM8zWMfoPKLkrOp9oVYq55SgwOX4vIhOK7zBe0XEWudI0M2x4kSps/xqazK73fwzdkjl9YAq
	XFNR7xJL+BgvzeyH5pRomAEGBJenGAIzbiUgQw1gxGgr3EVZiQBFELW2yI8x/XHSMf+gvOTaccAQC
	qT8GIsOW6H5gjUZCRvD4vYfPY1ySLjcCRJPN8A44BMcS7Xosdui4n6Pn+nZ3H0fFr1pjMzC4uWqwL
	EZu/TjJA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkbE5-0001ke-EN; Fri, 18 Jan 2019 20:58:53 +0000
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkbE2-0001kG-G7
 for linux-arm-kernel@lists.infradead.org; Fri, 18 Jan 2019 20:58:51 +0000
Received: by mail-wm1-x344.google.com with SMTP id n190so5771113wmd.0
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 18 Jan 2019 12:58:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=Mw+4BwoijmnZQmQytiaM8DgYyoBfL7aoHLbbz6mMx4Y=;
 b=boihO4tvTUE8DaNhC5AIaJ5ekSTlMDe1ns0o3BuFn7YmOrc+gW+O/oAu2YjLaJQSJB
 JV19T5GiX1zjlGZaWKiuGi3M/8PVkThhXo1LYb9i+3VVaJTR9VRJtw/GRlYFn7O23RUd
 y0WGivmQ5oh0boczXhItzNHW5eI/SfxjAhDDWhEtdLwkbmHun28pka2Qu5aiNwtBYhJ2
 0G6Fmq/0wfheiDkmPEKgFSQ76+vcQ2ISNwwtzibhKflSqZXTsqIRKXBa+e/GXoHxUiK4
 fvoacsqn3vMMHEfd3VPRPP5X9sZAGD4Yu5HXV8AbstNHVQj89WiF32K52C7sIm0DDZIY
 L+/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Mw+4BwoijmnZQmQytiaM8DgYyoBfL7aoHLbbz6mMx4Y=;
 b=Mw8GHBkwWaRJ0ul2ajUxWo0ZY2KX7nvERwHNGoE0fzJfVL3HU1qwNIWaf3fp+tBbes
 G+Rj5l1/qxz4Ti11mVehzrUEcNGFznfYPDqQA9yEndGFZVu3rPCB5ibLqAG/tmkikH5b
 VZfRR2L05Opsx4D3EdCbAx9JvLyJK9bqMb2Zat4I13VWTUPO1rCMYjTzlEPvG78/CPq2
 xUnS5PIMFcUo05mRBakyONOdYrAEWPbzxq+bBjNf8+wQw2I04GBEubeuo4/R0tOzz0k0
 /Dk/5dsQ5hvSthKA8TSOLAYS7W4EigkPaE+MzW+yodADKBTLWm0W7p1RF8/2GK0tSs+w
 cWGQ==
X-Gm-Message-State: AJcUukfiTlXGNt52Ir/XTBuzFVr5jnAmY04IiKluTmJf8d+DnJPo6Crm
 g5cWtPqGqNSjWx4LR9EKMeYbusU1
X-Google-Smtp-Source: ALg8bN4DXtrFmvxXwOLfR/NqMe110m7fLXE14oLo8/47CSAbt2TZMEqks4sDxOyz2cogoNnfWeozhA==
X-Received: by 2002:a1c:8c05:: with SMTP id o5mr15945029wmd.29.1547845127815; 
 Fri, 18 Jan 2019 12:58:47 -0800 (PST)
Received: from ?IPv6:2003:ea:8bf1:e200:8c88:93e4:233d:557?
 (p200300EA8BF1E2008C8893E4233D0557.dip0.t-ipconnect.de.
 [2003:ea:8bf1:e200:8c88:93e4:233d:557])
 by smtp.googlemail.com with ESMTPSA id w12sm76161479wrr.23.2019.01.18.12.58.46
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 18 Jan 2019 12:58:47 -0800 (PST)
Subject: Re: [BUG bisect] Missing Micrel driver on VF50 (net: phy: check
 return code when requesting PHY driver module)
To: Krzysztof Kozlowski <krzk@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Stefan Agner <stefan@agner.ch>
References: <CAJKOXPdHhUGoQmrX8_23MfbibozipkAzXA_5woVSFJSK9BvbXw@mail.gmail.com>
 <CAJKOXPe7ot9TLajErKJjSAkbs2vObMJfATzEFwxpT16aFdXHqg@mail.gmail.com>
From: Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <67560e58-93b3-2bfa-9d5d-5956dae47806@gmail.com>
Date: Fri, 18 Jan 2019 21:58:35 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAJKOXPe7ot9TLajErKJjSAkbs2vObMJfATzEFwxpT16aFdXHqg@mail.gmail.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190118_125850_569744_96288273 
X-CRM114-Status: GOOD (  15.66  )
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

On 18.01.2019 09:48, Krzysztof Kozlowski wrote:
> On Fri, 18 Jan 2019 at 09:39, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>>
>> Hi,
>>
>> On today's next (next-20190118) my Colibri VF50 board fails to boot up
>> from network (DHCP, NFSv4 root). Looks like missing network adapter.
>> Expected:
>> [ 3.041773] Micrel KSZ8041 400d1000.ethernet-1:00: attached PHY driver
>> [Micrel KSZ8041] (mii_bus:phy_addr=400d1000.ethernet-1:00, irq=POLL)
>>
>> Result:
>> [ 15.614964] Root-NFS: no NFS server address
>> [ 15.619353] VFS: Unable to mount root fs via NFS, trying floppy.
>> [ 15.626762] VFS: Cannot open root device "nfs" or unknown-block(2,0): error -6
>> [ 15.634252] Please append a correct "root=" boot option; here are the
>> available partitions:
>> [ 15.642791] 0100 16384 ram0
>> [ 15.642804] (driver?)
>> [ 15.649076] Kernel panic - not syncing: VFS: Unable to mount root fs
>> on unknown-block(2,0)
>> [ 15.657423] ---[ end Kernel panic - not syncing: VFS: Unable to mount
>> root fs on unknown-block(2,0) ]---
>>
>> Bisect pointed to:
>>     net: phy: check return code when requesting PHY driver module
> 
> I see now in the logs:
> [ 2.436822] mdio_bus 400d1000.ethernet-1:00: error -2 loading PHY
> driver module for ID 0x00221513
> which is kind of misleading. There is no initramfs so there is no
> usermod library at this point. It is not needed. This seems to break
> all DHCP/NFS root boots without initrd/initramfs.
> 
Thanks for the report. Could you please provide your kernel config
and the syslog of a boot before or w/o the patch in question?

If you boot via nfs then I'd expect that the PHY driver is built-in and
not a module. Therefore it's not fully clear to me yet why
request_module() returns -ENOENT.

> Best regards,
> Krzysztof
> 
Heiner

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
