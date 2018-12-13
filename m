Return-Path: <SRS0=qRPW=OW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00880C65BAE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 08:03:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C30AB20672
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 08:03:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="TaStYJIr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C30AB20672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amlogic.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=LERGsmLn3Lu1GftNWZ+yaxn3NcGflLVEgpZTH8wqqJ0=; b=TaStYJIrlYlkar
	ow8fE7OneuLWTfCfEr9UDmHWTqZchxLwLMY1FN3IKa4FB6+tVuj8w1zC+HW+PJ/uHqR6WttzrkEtK
	lhML/E8Frbtpxs3V/t1mfkiorh67SswklWHgvkucrB3OSpDipPvbWPHx+fvBvpvbnUco3bx8REIAV
	Vb1oxfjxXeqAfBc2Pt1kt2hqssDbITf67DmGKDJcrlvkleN50ssDNYOx3fR9Y8VkMN99Wcv0UCY4v
	K0V8EM6P3DdEhCOpz+hAOAuzEKhMcvxnM5lMRN43YfyFCiXDqOQemsD0i3z1wYCkAQCeBmPwBCcEs
	3P6LA1RNDCSRo35OvLzg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXLyB-0006Ee-SW; Thu, 13 Dec 2018 08:03:43 +0000
Received: from mail-sh2.amlogic.com ([58.32.228.45])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXLy6-0006Co-D1; Thu, 13 Dec 2018 08:03:40 +0000
Received: from [10.18.29.207] (10.18.29.207) by mail-sh2.amlogic.com
 (10.18.11.6) with Microsoft SMTP Server (TLS) id 15.0.1320.4; Thu, 13 Dec
 2018 16:03:40 +0800
Subject: Re: [PATCH RESEND v7 4/4] clk: meson: add one based divider support
 for sclk divider
To: Jerome Brunet <jbrunet@baylibre.com>, Neil Armstrong
 <narmstrong@baylibre.com>
References: <1544457877-51301-1-git-send-email-jianxin.pan@amlogic.com>
 <1544457877-51301-5-git-send-email-jianxin.pan@amlogic.com>
 <4da764c237b8f752af1dc33a011e2a4b73068f02.camel@baylibre.com>
From: Jianxin Pan <jianxin.pan@amlogic.com>
Message-ID: <d748a030-441f-dab0-83f7-aa8fc1106cb4@amlogic.com>
Date: Thu, 13 Dec 2018 16:03:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.2
MIME-Version: 1.0
In-Reply-To: <4da764c237b8f752af1dc33a011e2a4b73068f02.camel@baylibre.com>
Content-Language: en-US
X-Originating-IP: [10.18.29.207]
X-ClientProxiedBy: mail-sh2.amlogic.com (10.18.11.6) To mail-sh2.amlogic.com
 (10.18.11.6)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181213_000338_616502_0AC396F2 
X-CRM114-Status: GOOD (  21.49  )
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
 Victor Wan <victor.wan@amlogic.com>, Stephen Boyd <sboyd@kernel.org>,
 Kevin Hilman <khilman@baylibre.com>,
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

Hi Jerome,

Thanks for the fully review, we really appreciate your time.

On 2018/12/12 1:16, Jerome Brunet wrote:
> On Tue, 2018-12-11 at 00:04 +0800, Jianxin Pan wrote:
>> When CLK_DIVIDER_ONE_BASED flag is set, the sclk divider will be:
>> one based divider (div = val), and zero value gates the clock
>>
>> Signed-off-by: Jianxin Pan <jianxin.pan@amlogic.com>
>> ---
>>  drivers/clk/meson/clkc-audio.h |  1 +
>>  drivers/clk/meson/sclk-div.c   | 28 ++++++++++++++++++----------
>>  2 files changed, 19 insertions(+), 10 deletions(-)
> 
> Such a patch should be done earlier in the series, at least before using sclk
> in your controller, otherwise thing will be broken in between
> 
I will move it to the first one of the patchset. 
> In general, I would prefer if you had added two helper function to deal with
> the translation between register value and divider value.
> 
> Only these function should care about CLK_DIVIDER_ONE_BASED, the rest should
> just call them.
> 
> This, we will be able to deal the with HI (duty cycle) part as well, which you
> completly skiped.
> 
> I know your device does not have this, but still the code has to make sense.
> 
OK, I will add two helper for value and register translation, and then appy them to both div and hi.
>>
>> diff --git a/drivers/clk/meson/clkc-audio.h b/drivers/clk/meson/clkc-audio.h
>> index 0a7c157..9bd6ced 100644
>> --- a/drivers/clk/meson/clkc-audio.h
>> +++ b/drivers/clk/meson/clkc-audio.h
>> @@ -20,6 +20,7 @@ struct meson_sclk_div_data {
>>  	struct parm hi;
>>  	unsigned int cached_div;
>>  	struct clk_duty cached_duty;
>> +	u8	flags;
>>  };
>>  
>>  extern const struct clk_ops meson_clk_triphase_ops;
>> diff --git a/drivers/clk/meson/sclk-div.c b/drivers/clk/meson/sclk-div.c
>> index bc64019..d98707b 100644
>> --- a/drivers/clk/meson/sclk-div.c
>> +++ b/drivers/clk/meson/sclk-div.c
>> @@ -24,22 +24,23 @@
>>  	return (struct meson_sclk_div_data *)clk->data;
>>  }
>>  
>> -static int sclk_div_maxval(struct meson_sclk_div_data *sclk)
>> -{
>> -	return (1 << sclk->div.width) - 1;
>> -}
>> -
>>  static int sclk_div_maxdiv(struct meson_sclk_div_data *sclk)
>>  {
>> -	return sclk_div_maxval(sclk) + 1;
>> +	if (sclk->flags & CLK_DIVIDER_ONE_BASED)
>> +		return clk_div_mask(sclk->div.width);
>> +	else
>> +		return clk_div_mask(sclk->div.width) + 1;
> 
> seems over complicated.
> why no call clk_div_mask just once, and add 1 if necessary ?
Yes, I will use helper here.
> 
>>  }
>>  
>>  static int sclk_div_getdiv(struct clk_hw *hw, unsigned long rate,
>>  			   unsigned long prate, int maxdiv)
>>  {
>>  	int div = DIV_ROUND_CLOSEST_ULL((u64)prate, rate);
>> +	struct clk_regmap *clk = to_clk_regmap(hw);
>> +	struct meson_sclk_div_data *sclk = meson_sclk_div_data(clk);
>> +	int mindiv = (sclk->flags & CLK_DIVIDER_ONE_BASED) ? 1 : 2;
> 
> This is why I want helpers, don't like this above
OK, I will replace it with helpers.
> 
>>  
>> -	return clamp(div, 2, maxdiv);
>> +	return clamp(div, mindiv, maxdiv);
>>  }
>>  
>>  static int sclk_div_bestdiv(struct clk_hw *hw, unsigned long rate,
>> @@ -47,7 +48,7 @@ static int sclk_div_bestdiv(struct clk_hw *hw, unsigned
>> long rate,
>>  			    struct meson_sclk_div_data *sclk)
>>  {
>>  	struct clk_hw *parent = clk_hw_get_parent(hw);
>> -	int bestdiv = 0, i;
>> +	int bestdiv = 0, i, mindiv;
>>  	unsigned long maxdiv, now, parent_now;
>>  	unsigned long best = 0, best_parent = 0;
>>  
>> @@ -64,8 +65,9 @@ static int sclk_div_bestdiv(struct clk_hw *hw, unsigned
>> long rate,
>>  	 * unsigned long in rate * i below
>>  	 */
>>  	maxdiv = min(ULONG_MAX / rate, maxdiv);
>> +	mindiv = (sclk->flags & CLK_DIVIDER_ONE_BASED) ? 1 : 2;
>>  
>> -	for (i = 2; i <= maxdiv; i++) {
>> +	for (i = mindiv; i <= maxdiv; i++) {
>>  		/*
>>  		 * It's the most ideal case if the requested rate can be
>>  		 * divided from parent clock without needing to change
>> @@ -153,10 +155,14 @@ static int sclk_div_get_duty_cycle(struct clk_hw *hw,
>>  static void sclk_apply_divider(struct clk_regmap *clk,
>>  			       struct meson_sclk_div_data *sclk)
>>  {
>> +	unsigned int div;
>> +
>>  	if (MESON_PARM_APPLICABLE(&sclk->hi))
>>  		sclk_apply_ratio(clk, sclk);
>>  
>> -	meson_parm_write(clk->map, &sclk->div, sclk->cached_div - 1);
>> +	div = (sclk->flags & CLK_DIVIDER_ONE_BASED) ?
>> +		sclk->cached_div : (sclk->cached_div - 1);
> 
> helpers again.
OK!
> 
>> +	meson_parm_write(clk->map, &sclk->div, div);
>>  }
>>  
>>  static int sclk_div_set_rate(struct clk_hw *hw, unsigned long rate,
>> @@ -223,6 +229,8 @@ static void sclk_div_init(struct clk_hw *hw)
>>  	/* if the divider is initially disabled, assume max */
>>  	if (!val)
>>  		sclk->cached_div = sclk_div_maxdiv(sclk);
>> +	else if (sclk->flags & CLK_DIVIDER_ONE_BASED)
>> +		sclk->cached_div = val;
>>  	else
>>  		sclk->cached_div = val + 1;
> 
> same ...
OK, I will fix them. Thanks again for your time!
> 
>>  
> 
> 
> .
> 


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
