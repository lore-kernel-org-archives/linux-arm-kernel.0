Return-Path: <SRS0=vaNk=PS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CD6FC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 05:50:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F7BB2173B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 05:50:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="osNsLSZz";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="NEzs4/8f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F7BB2173B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:References:To:From:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=hoii3eFIcu27K9qWjBny5tvjAitJmj4iHZQeKO0q13E=; b=osNsLSZzHVAp9x
	+a5YghD9aFPj4madWtppIp0ZGHxaNoGOR/MqrLUXp63GCAVPO2CJ0KSSeWXTDMi7OUfjvg5+2QgG3
	XJ7E5HZ/PnslCnDBvpLUVR9RHSxC6dm4duHoG/FlZbDIKahqYbIeskHg6dst9sz+VzJWSiKevmF+Z
	LToPBwz1nNquZzuqVe+dB+VmgjLxLJOX+jJqrQ70szxBp5vMj4kSqcNClTq9LcC55w86FHfaxSEfJ
	3H8jLikkf5FZYqxd5bTYjxAKRTCMTlYgkhj2FNOsjf0s1pzsnvIF/ZgNsLmgmmMgVAE9pmVghh/BX
	OZKGz3gj2s3V/e1HFiiQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghTEb-0006FK-Uw; Thu, 10 Jan 2019 05:50:29 +0000
Received: from lelv0143.ext.ti.com ([198.47.23.248])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghTEX-0006Ew-Uy
 for linux-arm-kernel@lists.infradead.org; Thu, 10 Jan 2019 05:50:27 +0000
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x0A5oHWK069173;
 Wed, 9 Jan 2019 23:50:17 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1547099417;
 bh=5AM9w8DKHn7sr8xi/A/jL8BaWMoPviU7ebwpWRMWGgE=;
 h=Subject:From:To:CC:References:Date:In-Reply-To;
 b=NEzs4/8fODQnCkrzO5bFI39UmLB83+bZSydworOxqBGufzlCTm1BPz/pHfsBrhA09
 nM4MdH9LdYebCdOHErMfbEMmKCNkS7NY3NRTZtSMHURPWBopRe23v/cNKDmfUI+xO2
 inbHgKr+ycYVF0IVPtzv6YEhNMbd9YHtX5ePYMB4=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x0A5oH5X034080
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 9 Jan 2019 23:50:17 -0600
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Wed, 9
 Jan 2019 23:50:16 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Wed, 9 Jan 2019 23:50:16 -0600
Received: from [172.24.191.45] (ileax41-snat.itg.ti.com [10.172.224.153])
 by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x0A5oA1s007190;
 Wed, 9 Jan 2019 23:50:11 -0600
Subject: Re: Regression in v4.20 with net phy soft reset changes
From: Keerthy <j-keerthy@ti.com>
To: Tony Lindgren <tony@atomide.com>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Sekhar Nori <nsekhar@ti.com>
References: <20190109190650.GT5544@atomide.com>
 <a63ca542-db96-40ed-201d-59c609f565ce@gmail.com>
 <20190109213611.GU5544@atomide.com>
 <5bdce91b-cd56-75eb-c6d2-5542869b716e@ti.com>
Message-ID: <63ffba1c-47c1-a32b-68d6-0c3c31b74dd8@ti.com>
Date: Thu, 10 Jan 2019 11:20:10 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <5bdce91b-cd56-75eb-c6d2-5542869b716e@ti.com>
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190109_215026_300568_7F2C9C80 
X-CRM114-Status: GOOD (  19.25  )
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
Cc: Andrew Lunn <andrew@lunn.ch>, Clemens Gruber <clemens.gruber@pqgruber.com>,
 Florian Fainelli <f.fainelli@gmail.com>,
 Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>, WingMan Kwok <w-kwok2@ti.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Tero Kristo <t-kristo@ti.com>, Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 Murali Karicheri <m-karicheri2@ti.com>, linux-arm-kernel@lists.infradead.org,
 Rex Chang <rchang@ti.com>, linux-omap@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>, Chris Healy <cphealy@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org



On Thursday 10 January 2019 10:36 AM, Keerthy wrote:
> 
> 
> On Thursday 10 January 2019 03:06 AM, Tony Lindgren wrote:
>> Hi,
>>
>> * Heiner Kallweit <hkallweit1@gmail.com> [190109 19:28]:
>>> On 09.01.2019 20:06, Tony Lindgren wrote:
>>>> Commit 6e2d85ec0559 ("net: phy: Stop with excessive soft reset") caused
>>>> a regression where suspend resume cycle fails to bring up Ethernet on at
>>>> least cpsw on am437x-sk-evm.
>>>>
>>> What kind of PHY and which PHY driver is used with this board?
>>> I found one schematics of am437x where a KSZ9031RN PHY is used.
>>> Is it the same on your board?
>>
>> Yes that's the phy.
>>
>>> As described in the commit message of this commit you would have
>>> the option to implement the soft_reset callback in the PHY driver.
>>> Can you try to add .soft_reset = genphy_soft_reset to the
>>> KSZ9031 driver config in drivers/net/phy/micrel.c and check whether
>>> it fixes the issue?
>>
>> Yes that seems to work based on a quick test of five suspend
>> resume cycles.
> 

Removing Grygorii as the e-mail no longer exists

To add to Tony's observations. I ran a 100 time suspend/resume adding the
soft_reset hook to the phy_driver structs in drivers/net/phy/micrel.c and
suspend/resume (DS0) works nicely.

> 
>>
>> I wonder what all hardware this issue affects though?
>>
>> It's probably best that the network folks check what all
>> hardare needs patching.
>>
>> For TI hardware, Sekhar and TI network folks, can you guys
>> please check the various TI SoCs for multiple suspend resume
>> cycles with v5.0-rc1 and patch accordingly? See also below
>> for something else to check, 10 seconds to resume a phy
>> seems very long to me :)
>>
>>>> Keerthy noticed this may not happen on the first resume, but usually
>>>> happens after few suspend resume cycles. The most working suspend resume
>>>> cycles I've seen with the commit above is three.
>> ...
>>>> Note that unrelated to the commit above, there may be other issues too
>>>> as the cpsw phy LED seems to come on only after about five seconds with
>>>> about total of 10 seconds before the Ethernet is up again.
>>
>> Regards,
>>
>> Tony
>>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
