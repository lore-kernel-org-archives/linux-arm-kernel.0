Return-Path: <SRS0=baBj=PW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19753C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 12:16:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DBFDA2086D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 12:16:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="MjiMKiMB";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=orpaltech.com header.i=@orpaltech.com header.b="gxwDNVMW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBFDA2086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=orpaltech.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=fDW8wXGOwdN7/rEOqrINoMvbkTKgVHhcFfVe/NEuDq0=; b=MjiMKiMB+dSW72/B0jWbnyW4p
	kkd8FjVyN1LrGV6P8zfjsHCCH3Pyy84zw1IBMTTQia/YZYheGE0LMIk/c8l0BPkGAwfPrtTvChgTA
	M/LTObxv4y3fDXX5EJ57gwiD2HgAysPTMy/k5COXD/WX6kimc9cKTN2vRIOShi/iUvKtQ9qL78Jug
	7EtiBZ58pR8G8DRU70gIfAKVrxHFGYCf84lYK5ry+p5pMiVLzSusneqmU2M1RdgxMjHvzqsP6r5b7
	9wToMRSLw8+rTlYsyDagIYns+T6QHnl6Ydw3goys9XcAUTvirPTRJd+j/kZ9zDt0N4PKvbuN33Lwm
	bhLtq48eg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gj1Af-00063Z-4K; Mon, 14 Jan 2019 12:16:49 +0000
Received: from smtpng1.m.smailru.net ([94.100.181.251])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gj1Ab-000635-GE; Mon, 14 Jan 2019 12:16:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=orpaltech.com; s=mailru; 
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject;
 bh=S7DEZF1EwRxvIJEQAouh7YcfmSNIafCxI2a9mpJ1Xik=; 
 b=gxwDNVMWDnnPxHcxoTeHWRnIyRdi/jBQsFseawnh5eU3DHO7FR5JYyf8fby4vP15n/V4V+sXQO4D5DRLRPNUNxV1ugFBq1Jg8tBTG/NGZowx+lCxoUjRPlT0ZyPQeE5YFe2dCc8J4bC1pE1pjKbR9qHwFRe5gvx/mf/8NtWmyjo=;
Received: by smtpng1.m.smailru.net with esmtpa (envelope-from
 <ssuloev@orpaltech.com>)
 id 1gj1AU-00056V-VU; Mon, 14 Jan 2019 15:16:39 +0300
Subject: Re: [PATCH V4 2/3] ARM: dts: add Raspberry Pi 3 A+
To: Stefan Wahren <stefan.wahren@i2se.com>
References: <1545780008-22271-1-git-send-email-stefan.wahren@i2se.com>
 <1545780008-22271-3-git-send-email-stefan.wahren@i2se.com>
 <2da60463-f536-84f4-a176-4f8df30f6eaf@orpaltech.com>
 <458895695.364954.1547321694901@email.ionos.de>
From: Sergey Suloev <ssuloev@orpaltech.com>
Message-ID: <6c732f16-5fb2-cfd3-b3ba-bb2a79037f44@orpaltech.com>
Date: Mon, 14 Jan 2019 15:16:37 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <458895695.364954.1547321694901@email.ionos.de>
Content-Language: en-US
Authentication-Results: smtpng1.m.smailru.net;
 auth=pass smtp.auth=ssuloev@orpaltech.com
 smtp.mailfrom=ssuloev@orpaltech.com
X-77F55803: 3FFC80838138E3AB5A78504BD2AC2941382F125FEC086B480E1FAFC2752476513002C618E2A3A003A4C54F9029984AAC
X-7FA49CB5: 0D63561A33F958A5C5A073BAC2CB17065D264AFBE2AA25D2FC213B1652CE35C08941B15DA834481FA18204E546F3947CEDCF5861DED71B2F389733CBF5DBD5E9C8A9BA7A39EFB7666BA297DBC24807EA117882F44604297287769387670735209ECD01F8117BC8BEA471835C12D1D977C4224003CC836476C0CAF46E325F83A522CA9DD8327EE4930A3850AC1BE2E73529A0D09392F1F0961FEF1DC2AFBE5AC2731C566533BA786A40A5AABA2AD371193C9F3DD0FB1AF5EB82E77451A5C57BD33C9F3DD0FB1AF5EB4E70A05D1297E1BBCB5012B2E24CD356
X-Mailru-Sender: 689FA8AB762F7393E78166CB31B43AE46FA11229B238F09AB0662F410409ED83778B5FB1219D8779F6BCD4B1DE95BF653AE5922765F965CDF1D7D1B96E5495AE10FCEA6DFE3E0A150D4ABDE8C577C2ED
X-Mras: OK
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190114_041645_793892_67782D86 
X-CRM114-Status: GOOD (  12.32  )
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
Cc: devicetree@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>,
 Scott Branden <sbranden@broadcom.com>, Ray Jui <rjui@broadcom.com>,
 Phil Elwell <phil@raspberrypi.org>, Eric Anholt <eric@anholt.net>,
 bcm-kernel-feedback-list@broadcom.com, linux-rpi-kernel@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Stefan

On 1/12/19 10:34 PM, Stefan Wahren wrote:
> Hi Sergey,
>
>> Sergey Suloev <ssuloev@orpaltech.com> hat am 12. Januar 2019 um 19:11 geschrieben:
>>
>>
>> Hi, Stefan,
>>
>> is this patch the only update required to run Rpi3 A+ with kernel 4.20?
> this patch depends on the "Improve VCHIQ cache line size handling" series. But you could also use the RPi 3 B+ DTB.
>
> Btw you are replying to an outdated version of this series. V5 has been applied.
yes I know
>
> Stefan
>
>> Thank you,
>> Sergey


I tested your patch with 4.20 and 5.0-rc1 and Rpi3 A+, it seems to work 
fine.

Sergey



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
