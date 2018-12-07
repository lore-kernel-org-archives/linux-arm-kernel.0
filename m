Return-Path: <SRS0=cUnb=OQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28613C64EB1
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 14:59:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA90C20892
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 14:59:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="YiYrv0Wt";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="JM1gxjoT";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="JFs4IupM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA90C20892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=fC11t3bl/cF35Ibr89kPrPAzo8HXm3NcLpmNUluIoLs=; b=YiYrv0WtKltOX1TJF3jENILux
	yzTLyyJUMJWUzIR1s5e9nIWmXIgiiP75LXYIQInaq/i0dfy1xbisISaCElOWj7jVvHmFnRWTmt1s0
	i8o73VEnSLAviFxN9U6vSzLUJyqut3cAP0ChP4JsuE7RM6WBelf7tvOt0HKtGo99mm5371ZsoO72j
	SAD2zPAi5SYLeJ9uKZRDJptRbWQUXVxmDRiVUrC3NbiEnFLPYkKfhzTsP2RaBtf2xuL7tTEdVgL7/
	CBAVWs7WfnT1jVSmjXFg0KByUg1JUxTeid37QYehAXPDBavaEte/rEaj60rmTiNTtcD+2GmKJe852
	B3D3u9mNA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVHbA-0007hw-VO; Fri, 07 Dec 2018 14:59:24 +0000
Received: from smtp.codeaurora.org ([198.145.29.96])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVHas-0007V5-RP
 for linux-arm-kernel@lists.infradead.org; Fri, 07 Dec 2018 14:59:08 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
 id E364460316; Fri,  7 Dec 2018 14:58:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1544194735;
 bh=aTeUnKsCBSiPptRfDl/iXP4Ri54mkHLnR5AaEYjkUkE=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=JM1gxjoTLbaLhk8sL3f3rhGcO5p0zShP7eu2AOKz+pgCNoAKVmnXF8+LF0UL2RuJm
 y+jfUoyvPyV+70hGWOWBu2jTV9eGCheN7Z4KerC4wM+9ReTrHl9dEkw1NGIAZAu8VE
 MLnCWQpU3oW+/SK5JMTF4eeUHDM3YgVrq0suwPgw=
Received: from [10.226.60.81] (i-global254.qualcomm.com [199.106.103.254])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: jhugo@smtp.codeaurora.org)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id 102516014B;
 Fri,  7 Dec 2018 14:58:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1544194734;
 bh=aTeUnKsCBSiPptRfDl/iXP4Ri54mkHLnR5AaEYjkUkE=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=JFs4IupMRT7OKpDe2qW5q9nsqxnK8d7rhcuWfEkwdxs9RCxmZDIjVcenAUnzZM+Wu
 I/5haKC57ZaNtP5ulAl2XzEtnzOYxQPDKUfN7HwvQ91DwX1CDwuQYvRt4RgLQLikvd
 ytcGZ/S4Y3SHEfTjVQAOJuAZriJihlSLBv9MPAh4=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 102516014B
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
 spf=none smtp.mailfrom=jhugo@codeaurora.org
Subject: Re: [PATCH v2 1/3] arm64: dts: qcom: msm8998: correct xo clock name
To: Marc Gonzalez <marc.w.gonzalez@free.fr>, Stephen Boyd <sboyd@kernel.org>, 
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
 <cdeb3962-81a2-48dc-9b75-d97a817a0da9@codeaurora.org>
 <154412124335.88331.16092762627424651997@swboyd.mtv.corp.google.com>
 <00756abc-6e60-41cb-66bf-a7c9770dc2c9@free.fr>
From: Jeffrey Hugo <jhugo@codeaurora.org>
Message-ID: <8a1ec3da-0c07-7c05-cf5b-f1fef001c972@codeaurora.org>
Date: Fri, 7 Dec 2018 07:58:52 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <00756abc-6e60-41cb-66bf-a7c9770dc2c9@free.fr>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181207_065906_955270_1AFA69BB 
X-CRM114-Status: GOOD (  18.33  )
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
 Bjorn Andersson <bjorn.andersson@linaro.org>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 12/7/2018 2:03 AM, Marc Gonzalez wrote:
> On 06/12/2018 19:34, Stephen Boyd wrote:
>> Quoting Jeffrey Hugo (2018-12-05 15:04:01)
>>> On 12/5/2018 2:42 PM, Stephen Boyd wrote:
>>>> Quoting Jeffrey Hugo (2018-12-05 13:20:07)
>>>>> On 12/5/2018 2:04 PM, Stephen Boyd wrote:
>>>>>> Quoting Jeffrey Hugo (2018-12-05 09:03:54)
>>>>>>
>>>>>> I don't quite understand the patch in general. The xo_board clk should
>>>>>> always exist in DT and the fixed factor clk in GCC is there until the
>>>>>> rpm clk driver can control the XO clk state vote for the kernel.
>>>>>
>>>>> Sorry, this wasn't apparent.  It doesn't seem like this "requirement" is
>>>>> captured anywhere.
>>>>
>>>> Agreed!
>>>>
>>>>>
>>>>> As far as the SD clocks are concerned, they are defined in GCC, and
>>>>> eventually have a root parent called "xo".  "xo" isn't defined anywhere,
>>>>> so the SD clocks can't really be used, and the hardware doesn't come up.
>>>>>     This patch "fixed" that, but I missed the link to the rpm driver that
>>>>> Marc pointed out.
>>>>
>>>> Hmm ok. The SD DT node should just point to the xo_board clk for now and
>>>> later on it can be changed to use the rpm clk when the rpm node is
>>>> created.
>>>>
>>>>>
>>>>>
>>>>>>
>>>>>> If anything, change the DT node to be named xo-board instead of xo_board
>>>>>> because that matches DT naming schemes and then add a clock-output-names
>>>>>> = "xo_board" property to it so that we keep the underscore.
>>>>>
>>>>> I see this now, and I agree with it, but then SD goes back to a broken
>>>>> state because there is "xo" clock for GCC.  Its not quite clear to me
>>>>> how to make GCC (and thus SD) happy again with this change reverted/fixed.
>>>>>
>>>>> Bjorn mentioned offline he is going to take a look, but he has a few
>>>>> other things on his plate first.
>>>>>
>>>>
>>>> There is an XO clk created in drivers/clk/qcom/gcc-msm8996.c, we should
>>>> do the same here until rpm can handle this. I'll pack this patch up and
>>>> merge it to clk-next soon.
>>>
>>> Thanks.  I pulled in the below change into my tree, and fixed up the DT
>>> based on the discussion we had.  SD works, and things look sane to me
>>> per clk_summary in debugfs.
>>>
>>> Feel free to throw my tested-by on if you want.
>>
>> Thanks. I did so and merged it up to clk-next.
> 
> @Andy, don't you still need to revert 634da3307b083ee83eb9b377081fdfd6416a148a
> ("arm64: dts: qcom: msm8998: correct xo clock name") in for-next?

Yes, and no.  The SD changes kind of depend on that, so those would need 
to get sorted as well.

I still haven't heard from Andy, but I guess I'll go ahead and create a 
fixup patch.


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
