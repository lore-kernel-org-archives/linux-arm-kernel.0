Return-Path: <SRS0=cUnb=OQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06C2CC07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 09:04:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD26520882
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 09:04:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="NbMg7DeD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD26520882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=free.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=MOtCEZELpOP6ne7dhSX4lXKOWiY2vfZNd41klCU9e6A=; b=NbMg7DeDwcU4dK
	wJHt85OdD13Np2lkXZUI79qqMiOqUY/rJsrvZkmCJcwkuAOpLxIkDPePZBLuRTZwojdOWJ9rE7OCP
	9XsH8wv2J14lzHnCWq028w2TyktnXSJtyEBrH2xWRAuVbj92MHbbHRILEfFzM54eRqd1l6G8l7Y8K
	RIsOoJreLhdv0UBiaECVGnTEBNvTJv4y70oHVId7iEdgq/gpQVHT3xzt9i3dxs4Wt7+X1tS3/coDp
	7gaNGW0QaiSNADNwKDorqxyZyHYKT7vOCHYy9SKs/lLmi6rAkctRV8tNq1lycLl3TAUudw2miKbGe
	FQfog6vU0v4kBD47dYew==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVC3j-0005qo-40; Fri, 07 Dec 2018 09:04:31 +0000
Received: from smtp3-g21.free.fr ([2a01:e0c:1:1599::12])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVC3b-0005q4-8j
 for linux-arm-kernel@lists.infradead.org; Fri, 07 Dec 2018 09:04:29 +0000
Received: from [192.168.108.68] (unknown [213.36.7.13])
 (Authenticated sender: marc.w.gonzalez)
 by smtp3-g21.free.fr (Postfix) with ESMTPSA id B42F013F861;
 Fri,  7 Dec 2018 10:03:50 +0100 (CET)
Subject: Re: [PATCH v2 1/3] arm64: dts: qcom: msm8998: correct xo clock name
To: Stephen Boyd <sboyd@kernel.org>, Andy Gross <andy.gross@linaro.org>
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
From: Marc Gonzalez <marc.w.gonzalez@free.fr>
Message-ID: <00756abc-6e60-41cb-66bf-a7c9770dc2c9@free.fr>
Date: Fri, 7 Dec 2018 10:03:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <154412124335.88331.16092762627424651997@swboyd.mtv.corp.google.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181207_010423_464396_9CFE3987 
X-CRM114-Status: GOOD (  13.83  )
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
Cc: Jeffrey Hugo <jhugo@codeaurora.org>, MSM <linux-arm-msm@vger.kernel.org>,
 Georgi Djakov <georgi.djakov@linaro.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 06/12/2018 19:34, Stephen Boyd wrote:
> Quoting Jeffrey Hugo (2018-12-05 15:04:01)
>> On 12/5/2018 2:42 PM, Stephen Boyd wrote:
>>> Quoting Jeffrey Hugo (2018-12-05 13:20:07)
>>>> On 12/5/2018 2:04 PM, Stephen Boyd wrote:
>>>>> Quoting Jeffrey Hugo (2018-12-05 09:03:54)
>>>>>
>>>>> I don't quite understand the patch in general. The xo_board clk should
>>>>> always exist in DT and the fixed factor clk in GCC is there until the
>>>>> rpm clk driver can control the XO clk state vote for the kernel.
>>>>
>>>> Sorry, this wasn't apparent.  It doesn't seem like this "requirement" is
>>>> captured anywhere.
>>>
>>> Agreed!
>>>
>>>>
>>>> As far as the SD clocks are concerned, they are defined in GCC, and
>>>> eventually have a root parent called "xo".  "xo" isn't defined anywhere,
>>>> so the SD clocks can't really be used, and the hardware doesn't come up.
>>>>    This patch "fixed" that, but I missed the link to the rpm driver that
>>>> Marc pointed out.
>>>
>>> Hmm ok. The SD DT node should just point to the xo_board clk for now and
>>> later on it can be changed to use the rpm clk when the rpm node is
>>> created.
>>>
>>>>
>>>>
>>>>>
>>>>> If anything, change the DT node to be named xo-board instead of xo_board
>>>>> because that matches DT naming schemes and then add a clock-output-names
>>>>> = "xo_board" property to it so that we keep the underscore.
>>>>
>>>> I see this now, and I agree with it, but then SD goes back to a broken
>>>> state because there is "xo" clock for GCC.  Its not quite clear to me
>>>> how to make GCC (and thus SD) happy again with this change reverted/fixed.
>>>>
>>>> Bjorn mentioned offline he is going to take a look, but he has a few
>>>> other things on his plate first.
>>>>
>>>
>>> There is an XO clk created in drivers/clk/qcom/gcc-msm8996.c, we should
>>> do the same here until rpm can handle this. I'll pack this patch up and
>>> merge it to clk-next soon.
>>
>> Thanks.  I pulled in the below change into my tree, and fixed up the DT 
>> based on the discussion we had.  SD works, and things look sane to me 
>> per clk_summary in debugfs.
>>
>> Feel free to throw my tested-by on if you want.
> 
> Thanks. I did so and merged it up to clk-next.

@Andy, don't you still need to revert 634da3307b083ee83eb9b377081fdfd6416a148a
("arm64: dts: qcom: msm8998: correct xo clock name") in for-next?

Regards.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
