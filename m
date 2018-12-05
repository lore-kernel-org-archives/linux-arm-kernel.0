Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E841C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 23:04:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D44A208E7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 23:04:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="r7Be2RCy";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Q53J8Kh1";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="QwhXxL12"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D44A208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=3P6t2CN1lOWvmdhTX7vCFgQXBce57lYWqv18OGIM+9E=; b=r7Be2RCyVf+P2a/PjHB9qE8iV
	6cctYnrOFVtf1G0nrrBl61DwlfQbig9tTe1rfFHfBYosRStNYb+9WAAN9hTmZyWVQK84sCoB+/YzN
	pPz+594b3l9bs327BCb+qZAkdz1e5FjhV88+Ba7O4+lrrgL1Kd894gcZpfMq0xN9bMnH9J1rOym//
	bESFhLjAriQXBNuflp9kr3MKzSxJrsufS27i1IB1SDYyfUkyZbLCoTdjrVXMiwOSxqeqTDlUSdaif
	f1cZrSqLi/oBBVusOsBEfdoe0XWqP71+kYxo+DoPHo1TdBqsYnzAdvIbU7bqn6EvXpJdjDNlZN3ME
	WzREsAfyQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUgDJ-0007e2-AK; Wed, 05 Dec 2018 23:04:17 +0000
Received: from smtp.codeaurora.org ([198.145.29.96])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUgDG-0007Su-2t
 for linux-arm-kernel@lists.infradead.org; Wed, 05 Dec 2018 23:04:15 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
 id 5A6DC606FA; Wed,  5 Dec 2018 23:04:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1544051043;
 bh=Eglx7t3Y7vXWXnHQ8vj5rXv0DbKx8TM1m5e2Pg4Ibos=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=Q53J8Kh1QGzy4Uzl/JvlXIsKpurpXDA5NYd85wCAyZKIagnt4+1EQSTagtAmuWsZr
 H/NPQcbxYcxduy5QqK/yXZqKq7af6Zx6NaLddqDbMl7nlRl0TJD0N0kk73xbBxQveU
 o/UecQOHqAki43hLfHb2GYOHL7yWQn5c3i9loLDI=
Received: from [10.226.60.81] (i-global254.qualcomm.com [199.106.103.254])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: jhugo@smtp.codeaurora.org)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id F13EC601C4;
 Wed,  5 Dec 2018 23:04:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1544051042;
 bh=Eglx7t3Y7vXWXnHQ8vj5rXv0DbKx8TM1m5e2Pg4Ibos=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=QwhXxL12J9Gn9ctLjv2rsXWahTCcqyHOO/uup1duoxQgQTDPuutup0XIApwdGbM/A
 JfyMVeQk3lYGh40dme0Fnu8zJM1Fnf94oGKYO7UF4ZsJYWyqnjkSwFOS5x69HNI1sG
 bLmh80Fa32deqRs3Qe7rGzCgMqI6e6nocENOzfn0=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org F13EC601C4
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
 spf=none smtp.mailfrom=jhugo@codeaurora.org
Subject: Re: [PATCH v2 1/3] arm64: dts: qcom: msm8998: correct xo clock name
To: Stephen Boyd <sboyd@kernel.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 Andy Gross <andy.gross@linaro.org>
References: <1542314695-24071-1-git-send-email-jhugo@codeaurora.org>
 <1542314695-24071-2-git-send-email-jhugo@codeaurora.org>
 <b50bc3d4-f80b-6adb-c28b-1be254eb7e16@free.fr>
 <0ba54ffd-1d47-5ae9-ae9c-4a03d57e6ff3@codeaurora.org>
 <20181205164843.GB1492@tuxbook-pro>
 <05b9ee40-d51e-3f80-8ca4-217fa6fbd51c@codeaurora.org>
 <154404384283.88331.2522037578224950651@swboyd.mtv.corp.google.com>
 <14cad8f0-7388-16a0-b1ba-4cd5a469a17e@codeaurora.org>
 <154404615332.88331.10043835293734703587@swboyd.mtv.corp.google.com>
From: Jeffrey Hugo <jhugo@codeaurora.org>
Message-ID: <cdeb3962-81a2-48dc-9b75-d97a817a0da9@codeaurora.org>
Date: Wed, 5 Dec 2018 16:04:01 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <154404615332.88331.10043835293734703587@swboyd.mtv.corp.google.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_150414_168278_39AFA942 
X-CRM114-Status: GOOD (  25.97  )
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
Cc: MSM <linux-arm-msm@vger.kernel.org>,
 Georgi Djakov <georgi.djakov@linaro.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Marc Gonzalez <marc.w.gonzalez@free.fr>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 12/5/2018 2:42 PM, Stephen Boyd wrote:
> Quoting Jeffrey Hugo (2018-12-05 13:20:07)
>> On 12/5/2018 2:04 PM, Stephen Boyd wrote:
>>> Quoting Jeffrey Hugo (2018-12-05 09:03:54)
>>>
>>> I don't quite understand the patch in general. The xo_board clk should
>>> always exist in DT and the fixed factor clk in GCC is there until the
>>> rpm clk driver can control the XO clk state vote for the kernel.
>>
>> Sorry, this wasn't apparent.  It doesn't seem like this "requirement" is
>> captured anywhere.
> 
> Agreed!
> 
>>
>> As far as the SD clocks are concerned, they are defined in GCC, and
>> eventually have a root parent called "xo".  "xo" isn't defined anywhere,
>> so the SD clocks can't really be used, and the hardware doesn't come up.
>>    This patch "fixed" that, but I missed the link to the rpm driver that
>> Marc pointed out.
> 
> Hmm ok. The SD DT node should just point to the xo_board clk for now and
> later on it can be changed to use the rpm clk when the rpm node is
> created.
> 
>>
>>
>>>
>>> If anything, change the DT node to be named xo-board instead of xo_board
>>> because that matches DT naming schemes and then add a clock-output-names
>>> = "xo_board" property to it so that we keep the underscore.
>>
>> I see this now, and I agree with it, but then SD goes back to a broken
>> state because there is "xo" clock for GCC.  Its not quite clear to me
>> how to make GCC (and thus SD) happy again with this change reverted/fixed.
>>
>> Bjorn mentioned offline he is going to take a look, but he has a few
>> other things on his plate first.
>>
> 
> There is an XO clk created in drivers/clk/qcom/gcc-msm8996.c, we should
> do the same here until rpm can handle this. I'll pack this patch up and
> merge it to clk-next soon.

Thanks.  I pulled in the below change into my tree, and fixed up the DT 
based on the discussion we had.  SD works, and things look sane to me 
per clk_summary in debugfs.

Feel free to throw my tested-by on if you want.

Andy,
How would you like this little mess from my patch series to be fixed? 
It looks like you picked up a hybrid of v1 and v2 in your tree, and it 
would appear that went in a pull request to the ARM maintainers.  Do you 
want fixes based upon your next branch?

> 
> ----8<----
> diff --git a/drivers/clk/qcom/gcc-msm8998.c b/drivers/clk/qcom/gcc-msm8998.c
> index c3bb9fffd040..d72b908137e2 100644
> --- a/drivers/clk/qcom/gcc-msm8998.c
> +++ b/drivers/clk/qcom/gcc-msm8998.c
> @@ -117,6 +117,17 @@ static const char * const gcc_parent_names_5[] = {
>   	"core_bi_pll_test_se",
>   };
>   
> +static struct clk_fixed_factor xo = {
> +	.mult = 1,
> +	.div = 1,
> +	.hw.init = &(struct clk_init_data){
> +		.name = "xo",
> +		.parent_names = (const char *[]){ "xo_board" },
> +		.num_parents = 1,
> +		.ops = &clk_fixed_factor_ops,
> +	},
> +};
> +
>   static struct pll_vco fabia_vco[] = {
>   	{ 250000000, 2000000000, 0 },
>   	{ 125000000, 1000000000, 1 },
> @@ -2798,6 +2809,10 @@ static int gcc_msm8998_probe(struct platform_device *pdev)
>   	if (ret)
>   		return ret;
>   
> +	ret = devm_clk_hw_register(&pdev->dev, &xo.hw);
> +	if (ret)
> +		return ret;
> +
>   	return qcom_cc_really_probe(pdev, &gcc_msm8998_desc, regmap);
>   }
>   


-- 
Jeffrey Hugo
Qualcomm Datacenter Technologies as an affiliate of Qualcomm 
Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
