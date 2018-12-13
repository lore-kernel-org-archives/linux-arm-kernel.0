Return-Path: <SRS0=qRPW=OW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11D9DC65BAE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 04:42:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D606720849
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 04:42:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rJ7aiIDW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D606720849
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amlogic.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=9Foh6p3bx1b1UyF0XAdM0DpZbBtFeSMXrjkO03SfUFU=; b=rJ7aiIDWDlRUrJ
	sJkQUUXuL9b/aISpUgpUh5+6H4D1NPqeDeQ9ElDTIpCGDzoHWGPw0lxDCoP637H5VFe2kvXGsB/ex
	KY3OXu0RzgXs1y9KLCAzS2WYlhPwJRGu75kco4ztqhKjcUP9f1hbT9mApmDCkSajpo7WjXBdC9he4
	9aZ8kfMpO8hdZGX0rV0t+uTNNBCdG5cN+rcyF8c9sQfwX+kl5g/RYxED/91xkIfbDhhhqYrkUboBh
	fMwuOfzw+YNZH2cOI4hnzx2ir/2KLzLxI6uf7ZXH4wiK9lEcHFs7ircx5fUfmmlcmzpLI0jdPrCWL
	jDYqTr5Hbp/rfsBWeBpQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXIp4-0000XI-LY; Thu, 13 Dec 2018 04:42:06 +0000
Received: from mail-sh2.amlogic.com ([58.32.228.45])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXIp0-0000VU-Hs; Thu, 13 Dec 2018 04:42:03 +0000
Received: from [10.18.29.207] (10.18.29.207) by mail-sh2.amlogic.com
 (10.18.11.6) with Microsoft SMTP Server (TLS) id 15.0.1320.4; Thu, 13 Dec
 2018 12:42:02 +0800
Subject: Re: [PATCH RESEND v7 1/4] clk: meson: add emmc sub clock phase delay
 driver
To: Jerome Brunet <jbrunet@baylibre.com>, Neil Armstrong
 <narmstrong@baylibre.com>
References: <1544457877-51301-1-git-send-email-jianxin.pan@amlogic.com>
 <1544457877-51301-2-git-send-email-jianxin.pan@amlogic.com>
 <8e1c711b477eeee60809f33926cf9c6a52f530cd.camel@baylibre.com>
From: Jianxin Pan <jianxin.pan@amlogic.com>
Message-ID: <33721ac4-3564-1347-3b7b-2c795db63851@amlogic.com>
Date: Thu, 13 Dec 2018 12:42:02 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.2
MIME-Version: 1.0
In-Reply-To: <8e1c711b477eeee60809f33926cf9c6a52f530cd.camel@baylibre.com>
Content-Language: en-US
X-Originating-IP: [10.18.29.207]
X-ClientProxiedBy: mail-sh2.amlogic.com (10.18.11.6) To mail-sh2.amlogic.com
 (10.18.11.6)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181212_204202_592285_768EB02A 
X-CRM114-Status: UNSURE (   8.70  )
X-CRM114-Notice: Please train this message.
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
Cc: Rob Herring <robh@kernel.org>, Hanjie Lin <hanjie.lin@amlogic.com>,
 Victor Wan <victor.wan@amlogic.com>, devicetree@vger.kernel.org,
 Stephen Boyd <sboyd@kernel.org>, Kevin Hilman <khilman@baylibre.com>,
 Michael Turquette <mturquette@baylibre.com>, Yixun Lan <yixun.lan@amlogic.com>,
 linux-kernel@vger.kernel.org, Boris Brezillon <boris.brezillon@bootlin.com>,
 Liang Yang <liang.yang@amlogic.com>, Jian Hu <jian.hu@amlogic.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, Carlo Caione <carlo@caione.org>,
 linux-amlogic@lists.infradead.org,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Qiufang Dai <qiufang.dai@amlogic.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

HI Jerome,

On 2018/12/12 0:28, Jerome Brunet wrote:
> On Tue, 2018-12-11 at 00:04 +0800, Jianxin Pan wrote:
>> From: Yixun Lan <yixun.lan@amlogic.com>
>>
[...]
>> +
>> +static inline struct meson_clk_phase_delay_data *
>> +meson_clk_get_phase_delay_data(struct clk_regmap *clk)
>> +{
>> +	return clk->data;
>> +}
> 
> This is only usefull in the related clock driver, no need to export it
OK, I will move it to clk-phase-delay.c.
Thanks for the review.
> 
>> +
>>  /* clk_ops */
>>  extern const struct clk_ops meson_clk_pll_ro_ops;
>>  extern const struct clk_ops meson_clk_pll_ops;
>> @@ -112,5 +124,6 @@ struct clk_regmap _name = {				
>> 		\
>>  extern const struct clk_ops meson_clk_mpll_ro_ops;
>>  extern const struct clk_ops meson_clk_mpll_ops;
>>  extern const struct clk_ops meson_clk_phase_ops;
>> +extern const struct clk_ops meson_clk_phase_delay_ops;
>>  
>>  #endif /* __CLKC_H */
> 
> 
> .
> 


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
