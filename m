Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0211BC07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:36:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC73620855
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:36:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="czgCt2Mx";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=openedev.com header.i=@openedev.com header.b="g0rKSNMi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC73620855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=openedev.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=yXFWoBamdwmb6WE99olZofUMwrc6STt1S5b29sZmaWY=; b=czgCt2Mx1fxN17zWCj1oQyoHk
	vzsCGfJtkmpAoU4x/T4Up0h79PogBefPKJiHl9SFnOYtGGV0VgJr8n68RFJgI7l2zlP0iLMo/UYFJ
	nw/sabpyuoGVr1k8h5hMaDMdHD9mfAf1MkfAE1125QdiMcYvcdUCSjSjw2ndyDCmF6CdQMyCz/ajT
	B7CJ+45kFxrMriV6ws0CNtaj5LUdJLo2F61/UyoQmoksPqcszfO5bN+7qnMKTbhS2W73GlzPx4lI6
	shSZDFdhn++Kkl0Pc1vinI7gCs0CR79neJGA+BmwfXhwFu16jI5CcqNr2Nu/5Mo/mOJhEuTo+C//i
	fR2X7ptqA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWl1E-0001DK-QG; Tue, 11 Dec 2018 16:36:24 +0000
Received: from se15t.web-hosting.com ([162.255.118.154])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWl19-0000v2-EC
 for linux-arm-kernel@lists.infradead.org; Tue, 11 Dec 2018 16:36:22 +0000
Received: from [68.65.123.203] (helo=server153.web-hosting.com)
 by se15.registrar-servers.com with esmtpsa
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <jagan@openedev.com>)
 id 1gWl0j-0002FE-WC; Tue, 11 Dec 2018 08:36:02 -0800
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=openedev.com; s=default; h=Content-Transfer-Encoding:Content-Type:
 In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=45zotkRurVEs0HRhLtz1lXcKq9ANWXhV0XLWFrlcrc8=; b=g0rKSNMiRvKSn5/U5D5ajFSrc0
 gbr96TDPM7iPCJ1u9PD8BFAocylf/JgLm+YnIDx1K9lzlrrZFTuUh2jXvmkQE+ShKlVfWwuiTknzb
 ZUnZnvmT13isTBVARcGJko7IgPlb2rB7kvwMXbnh8XvsVk2Ie4idgTG3XjRdiDWHeiExTZIMWmjhr
 BUY+EDn1jT/KC5WluenSlzmrX7IqRz3OePs3m2domlVLpzzJSxKoj6K3zPLVZtbSIuUZyOPLKDo51
 OBM60cWFAbodk8572MMVuYT+yrsxfuPy9W98rVRw+GuAftPxwBGwDeTjKu3+NWWvK0X4DoGX3Hif2
 TiJu7eCQ==;
Received: from ip-160-131.sn-213-198.clouditalia.com ([213.198.160.131]:20839
 helo=[192.168.1.101]) by server153.web-hosting.com with esmtpsa
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.91)
 (envelope-from <jagan@openedev.com>)
 id 1gWl0f-001Nbr-E1; Tue, 11 Dec 2018 11:35:50 -0500
Subject: Re: [linux-sunxi] Re: [PATCH v5 15/17] clk: sunxi-ng: a64: Add
 minimum rate for PLL_MIPI
To: maxime.ripard@bootlin.com, Jagan Teki <jagan@amarulasolutions.com>
References: <20181210161729.29720-1-jagan@amarulasolutions.com>
 <20181210161729.29720-16-jagan@amarulasolutions.com>
 <20181211163222.hk647c24cjhmwrz4@flea>
From: Jagan Teki <jagan@openedev.com>
Message-ID: <14061728-2ca3-3342-2cf3-b8588b112f5f@openedev.com>
Date: Tue, 11 Dec 2018 22:05:43 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181211163222.hk647c24cjhmwrz4@flea>
Content-Language: en-US
X-OutGoing-Spam-Status: No, score=-1.0
X-Originating-IP: 68.65.123.203
X-SpamExperts-Domain: nctest.net
X-SpamExperts-Username: whmcalls3
Authentication-Results: registrar-servers.com;
 auth=pass (login) smtp.auth=whmcalls3@nctest.net
X-SpamExperts-Outgoing-Class: ham
X-SpamExperts-Outgoing-Evidence: Combined (0.05)
X-Recommended-Action: accept
X-Filter-ID: EX5BVjFpneJeBchSMxfU5g7jWpq1/tr8K8nsIJt4IWV602E9L7XzfQH6nu9C/Fh9KJzpNe6xgvOx
 q3u0UDjvO9dX4ZHi2KTdPJq2sFwGM16/7aw6ZDL6gCpHGlnjxa51P/a3oTZXMlz+UdhwK7oslF8p
 YZCrUbRX+v1BemLUP5r/e4EoE8VnbY0WmhMnUEcVsbramU7NHkOygsZkJKqgTTbvowDhMEK/yb1D
 YUdXtBiN7t7bU6UScO15SEoyP8zdZy+oxxLL6P2DauBVCvbXCWa1+/4Wol0EDMzOaSXdF5t+5q65
 t/37jL/wD18gr271WPd9wMp2Wk7NNHZIu78v1X/EDCLJ+Ki55LYF4K/3JpM+Cg2CIV1xlqTHULpT
 1Ej9/7vqxTzAaY6ctxp4g2WHgI8DORX/jSfD0m/fuegcItyS5zy3WPVfny99M+kdoq2BVFfcCf+U
 qoXy/yVRkHm4lwrApvGVmEId0tYoMZsYyYBvzxYv/Fi6Fp6VZudbG0yo9k0QcupFUVMVwNFDTBSb
 rgOdEYKItt9VZAAuHf7tOwyoYizzOVJd0iAs6zSf2DeeYMJ48uIpJwDb9Q3P/x52RQiigdwq0Z3p
 JL8LFIg0bRiTDIAeC1dmCNYjjD1RaEo1Z+IhnFL0+ulH7pLSIYfhSUWDCalQ5c9w96t6xs+MKalI
 PaEmzU9QjpeEAdtWMt9AqC1jWejFl/p4QDhGv5TXXFdAw+pKUNW1n03s4Dq5bQOkhUz6qAc3ygEG
 KiQdzbMc3V7AlQNPHuWfqqAYtP82P/YIREzoqsU/QPCJcf0TG0v7ZmVCeJKhFFHGf5MtKeejzTpc
 yXPDKzVOG3bU3Y8foVZA0RLR4+RHSH0VkFNYkHDfX8TdqEXkwxwMjsp2mNApUXV6QSAO+k9bjHri
 1RsvOMXddNkPVNpiu/BnsT+7IHUgr/U0flMcy2Vi/IcBgY4aTIX4MqJ00EpJRE4KKHUqeqbm1l8N
 Ay9hoSRG51DECq0h23Lg+9vjq7GGkzdFT+3Ipgmzm9xbfh6yfaz+azv0tqSWM6gxTWIh8fCWZqDe
 A9KU8AQyPXUCsQP+Lg2sdg3VbrDkkAqFYl3XQxhyXhqvd8MBD25g6jD/T4Cy9WwwbSDRAMTSSVAZ
 /Tfv9Po1e/xrDd9HEZlrzBTQx32xBEOTWqQS8bnXgaCDrwhWO8ymD52SFQ/uog93A6uWtOKD9McA
 zf0WufrmpmJq6mqrDZ69f2bjO41FyBEqIaDudcVplPHKi8lyfxjIq6n+5ncT+SkCz0gmOTRYyMZu
 ULKNmrPV+Zm9/b2E/M6OuIdx9tHWDo7x9CbKCImL6rLM1DNibzpj7eLLFnKm0ajcQdyvlVLHRzvq
 p4OMkG5MXg2Kgbo+SQTpaVgFKeINzqmqJKFRvnnmExxov/ex1D5pTgvUGv4wS8vPp594mStXk/Xx
 jWkCH0j2OKHH5lr9xXvSM4nM3avg
X-Report-Abuse-To: spam@se16.registrar-servers.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_083619_597949_9F3499FF 
X-CRM114-Status: GOOD (  17.92  )
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
Cc: Stephen Boyd <sboyd@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>,
 linux-sunxi <linux-sunxi@googlegroups.com>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Chen-Yu Tsai <wens@csie.org>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 linux-amarula@amarulasolutions.com, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org



On 11/12/18 10:02 PM, Maxime Ripard wrote:
> On Mon, Dec 10, 2018 at 09:47:27PM +0530, Jagan Teki wrote:
>> Minimum PLL used for MIPI is 500MHz, as per manual, but
>> lowering the min rate by 300MHz can result proper working
>> nkms divider with the help of desired dclock rate from
>> panel driver.
>>
>> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
>> Acked-by: Stephen Boyd <sboyd@kernel.org>
>> ---
>>   drivers/clk/sunxi-ng/ccu-sun50i-a64.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-a64.c b/drivers/clk/sunxi-ng/ccu-sun50i-a64.c
>> index 181b599dc163..b623c8150b4f 100644
>> --- a/drivers/clk/sunxi-ng/ccu-sun50i-a64.c
>> +++ b/drivers/clk/sunxi-ng/ccu-sun50i-a64.c
>> @@ -183,6 +183,7 @@ static struct ccu_nkm pll_mipi_clk = {
>>   	.n		= _SUNXI_CCU_MULT(8, 4),
>>   	.k		= _SUNXI_CCU_MULT_MIN(4, 2, 2),
>>   	.m		= _SUNXI_CCU_DIV(0, 4),
>> +	.min_rate	= 300000000,		/* Actual rate is 500MHz */
> 
> That comment still doesn't make any sense. Is it running at 500MHz or 300?

It running in 300MHz, actual rate is 500MHz.

> 
> Also, IIRC you had a patch adding support for maximum boundaries in
> your previous patch, where did it go?

Since I don't have any usecase to test I droped it. the same mentioned 
on the previous version.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
