Return-Path: <SRS0=qRPW=OW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05873C67839
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 14:37:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCC8A20870
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 14:37:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="T11LKh9m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCC8A20870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amlogic.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=n6Mxv3+pc41cSKooERMy7welY4DwHREE3HO9XEfQBaw=; b=T11LKh9mL1QDvMu3Wk/13CmZb
	wLN2rjUssc5VrYuWzjTglWwiZgx3jL9+eg8aqdDDOkYPrxsGJX9w8B7FI4rNWQX23yvwSFYSP+9AQ
	pcKP0xn1Dy6XfLawGHzBTahHBHNejDfr+h/JfcinyQb9gojY51O/SqtnHFhydrN8fmVp2ggKWOz90
	rHYn7ydO6Nzm2ndTAwNUpDu7trXOVJLb+N4i+r23YKKPHymrDdxigSewop3bUE7VMD8SsRruLT/AB
	vNOf7iCGbLVS8mxVyrzDr9wF+I0A5Vg8mK5907Oe2n3CeMdn+pNr7G/12JmDscdH4wuJoUMcBnG1p
	K8uKLHmBA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXS6w-0000ky-0D; Thu, 13 Dec 2018 14:37:10 +0000
Received: from mail-sz2.amlogic.com ([211.162.65.114])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXS6o-0000R9-7O; Thu, 13 Dec 2018 14:37:06 +0000
Received: from [10.28.18.96] (10.28.18.96) by mail-sz2.amlogic.com
 (10.28.11.6) with Microsoft SMTP Server (TLS) id 15.0.1320.4; Thu, 13 Dec
 2018 22:37:07 +0800
Subject: Re: [PATCH v2 3/3] spi: meson-axg: add a linear clock divider support
To: Jerome Brunet <jbrunet@baylibre.com>, Neil Armstrong
 <narmstrong@baylibre.com>, Mark Brown <broonie@kernel.org>
References: <1544690354-16409-1-git-send-email-sunny.luo@amlogic.com>
 <1544690354-16409-4-git-send-email-sunny.luo@amlogic.com>
 <3cc699dc-4021-b993-2b47-b00b40f380f8@baylibre.com>
 <e6d5220e45a54d5251bec0f8fd3c147307f8b071.camel@baylibre.com>
From: Sunny Luo <sunny.luo@amlogic.com>
Message-ID: <d9ec856c-d93f-4e4a-c5d4-7b2182f93cf7@amlogic.com>
Date: Thu, 13 Dec 2018 22:37:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <e6d5220e45a54d5251bec0f8fd3c147307f8b071.camel@baylibre.com>
Content-Language: en-GB
X-Originating-IP: [10.28.18.96]
X-ClientProxiedBy: mail-sz2.amlogic.com (10.28.11.6) To mail-sz2.amlogic.com
 (10.28.11.6)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181213_063704_048026_72F02F59 
X-CRM114-Status: GOOD (  13.98  )
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
 Xingyu Chen <xingyu.chen@amlogic.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Jerome,

On 2018/12/13 17:28, Jerome Brunet wrote:
> On Thu, 2018-12-13 at 09:55 +0100, Neil Armstrong wrote:

>>> diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
>>>   config SPI_MESON_SPICC
>>>   	tristate "Amlogic Meson SPICC controller"
>>> -	depends on ARCH_MESON || COMPILE_TEST
>>> +	depends on OF && COMMON_CLK && (ARCH_MESON || COMPILE_TEST)
> 
> The purpose of this patch is clock, right ? Why does it add a dependency on OF
> ?
> I did it by the way. Maybe it's better to add it in patch 1.


>>> +static int meson_spicc_clk_init(struct meson_spicc_device *spicc)
>>> +{
>>> +	struct device *dev = &spicc->pdev->dev;
>>> +	struct clk_fixed_factor *div0;
>>> +	struct clk_divider *div1;
> 
> Could you come up with something better than div0 and div1 ? it is confusing,
> especially with the comment above about div3 and 4 ... fixed_factor, div maybe
> ?
> Good, It is really confusing, I will change next patch.


>>> +	div1 = &meson_spicc_div1;
>>> +	div1->reg = spicc->base + (u64)div1->reg;
> 
> So you have static data which you override here. This works only if there is a
> single instance ... and does not really improve readability in your case.
> 
> IMO, you'd be better off without the static data above.

This is a terrible bug for more than one instances. I must overwrite it.


>>> +	if (!spicc->data->has_enhance_clk_div) {
> 
> Do all SoC with 'has_oen' have 'has_enhance_clk_div' too ?
> DO you really need two flags ?

Yes, all Soc with 'has_oen' must have 'has_enhance_clk_div' too.
It is distinct to use two flags here, what do you think of it?

>>> +	mux = &meson_spicc_sel;
>>> +	snprintf(name, sizeof(name), "%s#_sel", dev_name(dev));
>>> +	init.name = name;
>>> +	init.ops = &clk_mux_ops;
>>> +	init.parent_names = mux_parent_names;
>>> +	init.num_parents = 2;
>>> +	init.flags = CLK_SET_RATE_PARENT | CLK_SET_RATE_NO_REPARENT;
> 
> Why CLK_SET_RATE_NO_REPARENT ? CCF should pick the parent that give the best
> results, best to let it do its task ...
> 
There are two div in AXG, one is the coarse old-div and the other is 
enhance-div. From SoCs designer's opinion, the ehance-div aims to take 
place of the old-div.



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
