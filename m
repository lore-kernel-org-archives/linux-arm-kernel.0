Return-Path: <SRS0=g9E6=Q2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C099C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 20:00:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52FCA21738
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 20:00:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="kro2ptLj";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="V24mjFjv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52FCA21738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date
	:Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=U6UZY6fMMce/5XQCMQ7rBNfC91lAzDGKtLYHRjuwcSs=; b=kro2ptLjlUf6nl
	yo1xGC52VOcNkCF6C7Yte+0VyF9+XJ98cHHf4r04RyAtiq0Myaj9H+VDlXrpQjR4XvApjkFVhUEOt
	PQbXka8rHO30l1gxMjYkVu/am+1Niv2NTfXtcrv42S8CMp+Lg63XZYvWxkhlaZY6pXd8JoToDLROa
	4aDCtnsp+j7Xojp5x4iv/pq1AkVyF5AosM4BrmHXfYOYrLCyM7r09GpD8hY3BpMmDySCzPd8HgldK
	HD0st56XHhMWDnvjkt8b2NtAh4JnOfDLJLcm/SpQSxhSR1ZsdXejNmDEPh4x9WYGirOcsU7OQyvQW
	0mjwNh3kI00ySNhtMS9g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwBZE-0001il-DZ; Tue, 19 Feb 2019 20:00:36 +0000
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwBZA-0001eN-9o
 for linux-arm-kernel@lists.infradead.org; Tue, 19 Feb 2019 20:00:34 +0000
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (Client did not present a certificate)
 by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 95DCF8025D;
 Wed, 20 Feb 2019 09:00:09 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
 s=mail181024; t=1550606409;
 bh=/yCqWzdJK8jc7zhpDVQMLhrHJ5ps1ZelreD+gsoqY6A=;
 h=From:To:CC:Subject:Date:References;
 b=V24mjFjvNoFv+yhk+bESujB/qx3M/lRKayHgo6SWPBMoXcLmQR2sUzxC+wOVYLSWb
 6gO/zCOVkAVIkDFUgAGAFsmGCqnasN74t/QIxqryw78kAzbnH5sQ19P4Jq2cDg+SMq
 ZaKAjuj4t1JJ7WuD7CCRyK1HAnF5z60691Tsh/rRcP3nzbXSkPFsvK39r5KcUQStT6
 aIJhp2quqeKizdbAYW482TYQ7mu+pcJPdENzkFZ2spcRB4enNCVU0ffRfnuKMZqkMG
 bIzBg6kDORLkIbEr8L9/p0jFweRrnWXDx+H3W5HBaLidnb9HfSmjMgZ3a5jyLxFpF5
 rLI+K4S6OMN7A==
Received: from svr-chch-ex1.atlnz.lc (Not Verified[10.32.16.77]) by
 mmarshal3.atlnz.lc with Trustwave SEG (v7, 5, 8, 10121)
 id <B5c6c60480000>; Wed, 20 Feb 2019 09:00:08 +1300
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) by
 svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) with Microsoft SMTP Server
 (TLS) id 15.0.1156.6; Wed, 20 Feb 2019 09:00:09 +1300
Received: from svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8]) by
 svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8%12]) with mapi id
 15.00.1156.000; Wed, 20 Feb 2019 09:00:09 +1300
From: Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To: Gregory CLEMENT <gregory.clement@bootlin.com>, "andrew@lunn.ch"
 <andrew@lunn.ch>, "jason@lakedaemon.net" <jason@lakedaemon.net>
Subject: Re: [PATCH] ARM: mvebu: kirkwood: remove error message when
 retrieving mac address
Thread-Topic: [PATCH] ARM: mvebu: kirkwood: remove error message when
 retrieving mac address
Thread-Index: AQHUxzQ4aDgGoLLrG0248l+FI4FVAQ==
Date: Tue, 19 Feb 2019 20:00:09 +0000
Message-ID: <ed2e24ed25504979aef666b6f677f34e@svr-chch-ex1.atlnz.lc>
References: <20190218024645.29059-1-chris.packham@alliedtelesis.co.nz>
 <877edv3jmw.fsf@FE-laptop>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [2001:df5:b000:22:3a2c:4aff:fe70:2b02]
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190219_120032_834881_5AF1FBCA 
X-CRM114-Status: GOOD (  14.64  )
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
Cc: Russell King <linux@armlinux.org.uk>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 20/02/19 4:14 AM, Gregory CLEMENT wrote:
> Hi Chris,
>   =

>   On lun., f=E9vr. 18 2019, Chris Packham <chris.packham@alliedtelesis.co=
.nz> wrote:
> =

>> Kirkwood has always had the ability to retrieve the local-mac-address
>> from the hardware (usually this was configured by the bootloader). This
>> is particularly useful when dealing with a legacy non-DT aware
>> bootloader.
>>
>> The "error" message just indicated that the board used an old bootloader
>> and in many cases users can't do anything about this. The message
>> probably should have been pr_info() to inform the user that the kernel
>> has been helpful but rather than than let's remove it entirely to make
>> the kernel less noisy.
>>
>> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> =

> I'm OK with this patch, however as it is not a fix, it's too late for
> 5.1. I will apply it on mvebu/arm for 5.2 once 5.1-rc1 will be released.
> =


No problem with that. We have a local fork I'll cherry pick it into once =

it hits linux-mvebu.

> Thanks,
> =

> gregory
> =

>> ---
>>   arch/arm/mach-mvebu/kirkwood.c | 2 --
>>   1 file changed, 2 deletions(-)
>>
>> diff --git a/arch/arm/mach-mvebu/kirkwood.c b/arch/arm/mach-mvebu/kirkwo=
od.c
>> index 0aa88105d46e..bf3ff0f580c2 100644
>> --- a/arch/arm/mach-mvebu/kirkwood.c
>> +++ b/arch/arm/mach-mvebu/kirkwood.c
>> @@ -107,8 +107,6 @@ static void __init kirkwood_dt_eth_fixup(void)
>>   		clk_prepare_enable(clk);
>>   =

>>   		/* store MAC address register contents in local-mac-address */
>> -		pr_err(FW_INFO "%pOF: local-mac-address is not set\n", np);
>> -
>>   		pmac =3D kzalloc(sizeof(*pmac) + 6, GFP_KERNEL);
>>   		if (!pmac)
>>   			goto eth_fixup_no_mem;
>> -- =

>> 2.20.1
>>
> =



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
