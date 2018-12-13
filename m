Return-Path: <SRS0=qRPW=OW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 683AEC65BAE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 13:12:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 353C520849
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 13:12:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="cze7Smpf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 353C520849
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amlogic.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=soRY85KGcOEUqf2OWs9qsKiQ4tCLHcf0pQWGIwGGBug=; b=cze7Smpft1u/Od4tZ7hxAKzij
	wTbfnInFPCGWZhBIZpPgR7VyCGzO+mzBfHxR5C84bx4biygUCPHRmz0FFOc4RpQeH2fbusruVo9gA
	/ZJDkBM/WlCE98We9wyCD5J+rZy0Mugpd7Mr5R8qLU8f3s/ruDWaGNZm0CKJ6/JlIhtEkrQa8DUlO
	5IQGfhQNrqBWtoc/2+TT6a/L2/6VXXy6jdc46eIbgI3vyddloydhahaqgQzZELeUvvXBXvPHsdg0P
	WryrDetbLCYGUX8oFGpZwMtyDtA7aUjYhUh7PBblsJUTjsz8fWz+Fp1TfvGbr0VAeP+7/ix7TzIKM
	/cy9UM1HA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXQmp-0001He-Pv; Thu, 13 Dec 2018 13:12:19 +0000
Received: from mail-sz2.amlogic.com ([211.162.65.114])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXQmj-0000yO-4b; Thu, 13 Dec 2018 13:12:15 +0000
Received: from [10.28.18.96] (10.28.18.96) by mail-sz2.amlogic.com
 (10.28.11.6) with Microsoft SMTP Server (TLS) id 15.0.1320.4; Thu, 13 Dec
 2018 21:12:23 +0800
Subject: Re: [PATCH v2 2/3] spi: meson-axg: enhance output enable feature
To: Neil Armstrong <narmstrong@baylibre.com>, Mark Brown <broonie@kernel.org>
References: <1544690354-16409-1-git-send-email-sunny.luo@amlogic.com>
 <1544690354-16409-3-git-send-email-sunny.luo@amlogic.com>
 <6ba11b0a-3629-5378-61c7-3cc364237f5c@baylibre.com>
From: Sunny Luo <sunny.luo@amlogic.com>
Message-ID: <c85195d4-29e5-0e66-da09-cb86248660a3@amlogic.com>
Date: Thu, 13 Dec 2018 21:12:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <6ba11b0a-3629-5378-61c7-3cc364237f5c@baylibre.com>
Content-Language: en-GB
X-Originating-IP: [10.28.18.96]
X-ClientProxiedBy: mail-sz2.amlogic.com (10.28.11.6) To mail-sz2.amlogic.com
 (10.28.11.6)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181213_051213_534687_E770DE9E 
X-CRM114-Status: GOOD (  11.86  )
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
Cc: Jianxin Pan <jianxin.pan@amlogic.com>, Kevin Hilman <khilman@baylibre.com>,
 Yixun Lan <yixun.lan@amlogic.com>, linux-kernel@vger.kernel.org,
 linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Carlo Caione <carlo@caione.org>, linux-amlogic@lists.infradead.org,
 Xingyu Chen <xingyu.chen@amlogic.com>, Jerome Brunet <jbrunet@baylibre.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Neil,

On 2018/12/13 16:53, Neil Armstrong wrote:
> Hi Sunny,
> 
> On 13/12/2018 09:39, Sunny Luo wrote:
>> The SPICC controller in Meson-AXG is capable of driving the CLK/MOSI/SS
>> signal lines through the idle state (between two transmission operation),
>> which avoid the signals floating in unexpected state.
> 
> This is welcome, because it's really missing on GX...
> I tried implementing it with pinctrl at [1], but it's complex.
> 
> Can you provide more info on how we should implement in on GX to be on par ?
> 
> [1] https://github.com/superna9999/linux/commit/9c3a95659dd532d186556c1570c54d79ea5a4d45
> 
GX is incapable of OEN. To be on par with it ,we have to pullup/down clk 
pin as
you did at[1].

>>   static const struct meson_spicc_data meson_spicc_gx_data = {
>> -	.max_speed_hz	= 30000000,
>> +	.max_speed_hz		= 30000000,
> 
> Nitpick, but I would have kept the indentation here ...
> 
>>   };
>>   
>>   static const struct meson_spicc_data meson_spicc_axg_data = {
>> -	.max_speed_hz	= 80000000,
>> +	.max_speed_hz		= 80000000,
>> +	.has_oen		= true,
> 
> same here
> 
> Anywy it's nitpick,
>  
ok, i will revert it next patch.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
