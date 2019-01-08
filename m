Return-Path: <SRS0=tBLO=PQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2729CC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 22:35:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7E3720665
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 22:35:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gsWBMJen"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7E3720665
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=MPWtVihxJMKJoeeex5pBoXFu84ngGU3NbzhMyz8kPzo=; b=gsWBMJenxmqRqTJoaOzgr7u6n
	kWT9OJADLL6rG2WSCO+WkR0zFkF8Jq5ZzGlIinWc9b8UjIlOc3cPG4saxeVXLwvecNTD/3x9HXNAs
	f0dsucKBvR9OnIY2o5zpj0oFz6pdr+nN04vTYWmBJH4tr+ZxP27pzlRrvPxKFGXWkljiAMmWb3Rfl
	Hb72kIAzLxpmWSDluiXGz0bgcHe4CLLpnWT3oMVB5kBbW5rdKNFkMHmVhIgm1mBlwUj4j99O3tjwm
	7CAr4Jk+j4RkGi1Kr3hmNdNR00FuTDUCuL256h7tXflZF40znoh8wDCJg0+o44HeC4MvNOhMoNPbZ
	yjstnWVWA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ggzyU-0005XY-1B; Tue, 08 Jan 2019 22:35:54 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ggzyQ-0005X6-Uv; Tue, 08 Jan 2019 22:35:52 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9296F80D;
 Tue,  8 Jan 2019 14:35:50 -0800 (PST)
Received: from [192.168.1.123] (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 455C73F5AF;
 Tue,  8 Jan 2019 14:35:48 -0800 (PST)
Subject: Re: [PATCH 2/5] arm64: dts: rockchip: Add DT for NanoPi M4
To: Heiko Stuebner <heiko@sntech.de>
References: <cover.1546981251.git.robin.murphy@arm.com>
 <324b75bbeef2552ddde62f4e1834ac908a45bebd.1546981251.git.robin.murphy@arm.com>
 <1755553.je4OVlYtzY@phil>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <a9934783-7562-c872-fdcd-1f8e72e85881@arm.com>
Date: Tue, 8 Jan 2019 22:35:40 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <1755553.je4OVlYtzY@phil>
Content-Language: en-GB
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190108_143551_021337_7FA2C586 
X-CRM114-Status: GOOD (  20.96  )
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
Cc: linux-rockchip@lists.infradead.org, tomeu.vizoso@collabora.com,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Heiko,

On 2019-01-08 10:15 pm, Heiko Stuebner wrote:
> Hi Robin,
> 
> Am Dienstag, 8. Januar 2019, 22:57:24 CET schrieb Robin Murphy:
>> There are a number of subtle differences between the nanopi4 variants,
>> and where they disagree, the common DTSI currently follows the details
>> of NanoPi M4. In order to improve matters even more, let's add a
>> separate DTS for the M4 to which we can start splitting things out
>> appropriately. The third variant, NanoPi NEO4, is a lot closer to the M4
>> than either is to the larger T4, so arguably could get away with just
>> sharing the M4 DT for now (plus I have neither of the smaller boards to
>> actually test with).
>>
>> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> 
> I'm not sure if Rob actually checks the devicetree list or relies on
> patches Cc'ed directly to him for binding review, so you might want
> to add the 2 dt maintainers explicitly.

Er, that's embarassing... I somehow failed to register that my mindless 
copy-paste job ends up adding a new binding that *isn't* the one Rob 
already reviewed :(

>> ---
>>   .../devicetree/bindings/arm/rockchip.yaml      |  5 +++++
>>   arch/arm64/boot/dts/rockchip/Makefile          |  1 +
>>   .../boot/dts/rockchip/rk3399-nanopi-m4.dts     | 18 ++++++++++++++++++
>>   3 files changed, 24 insertions(+)
>>   create mode 100644 arch/arm64/boot/dts/rockchip/rk3399-nanopi-m4.dts
>>
>> diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
>> index bcc60c492a12..b4756e0cb7d0 100644
>> --- a/Documentation/devicetree/bindings/arm/rockchip.yaml
>> +++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
>> @@ -92,6 +92,11 @@ properties:
>>             - const: friendlyarm,nanopc-t4
>>             - const: rockchip,rk3399
>>   
>> +      - description: FriendlyElec NanoPi M4
>> +        items:
>> +          - const: friendlyarm,nanopi-m4
>> +          - const: rockchip,rk3399
>> +
> 
> When we hashed out the Rockchip yaml thingy, there also
> came up the possibility of grouping the similar boards together
> into an enum, see the rk3399-firefly or the rk3288-evb-* for example.
> 
> So the binding for both could possibly become:
> 
>        - description: FriendlyElec NanoPi
>          items:
> 	  - enum:
>            	- friendlyarm,nanopi-m4
>            	- friendlyarm,nanopi-t4
>            - const: rockchip,rk3399
> 
> We didn't come up with a hard rule for all cases, but the
> Nano PI feels like it qualifies ;-)

...but I completely agree with that idea anyway - as the commit log 
alludes to, this was really just somewhere to move the existing nodes to 
without much thought involved. I'll give it a day or two for any more 
comments, then respin at least this patch and make sure the binding 
update goes to the maintainers properly.

Cheers,
Robin.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
