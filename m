Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA5E3C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 21:20:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71DED208E7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 21:20:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="MYc95TQ6";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="H6GoTnyP";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Xvm3QxJk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71DED208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=mR4ITjIvmoFHknTnh1HYfSvB+2Xna7v2bwGElAmPzdg=; b=MYc95TQ6EJYGoqfzKNX+VMVcH
	hnCTz2FKLbBzXxvd8K/EFQdSdh5j7YAOI5TT7ffBs1YiqUuVHj6wqs2wpNjkoMAuriKqlWKGr2iDM
	Kzhl/7Qk11PbJBVMIkcwCDOsihOLHFA0UsE+ZxdsYKS8uM/1QYc0BqYTXusp1dQ+sP1R5NmQBJrVW
	KdI2f2Y5oxl7zgI9UfT/OV7e2uO5D+s+CT9t3jPRPYkQRgmIywNyVV3DLWow67ajgIdqazBsY6Zi1
	QU3fP1IRo/Rv387uTNu9fXDpqABOofmVV72awTy/SBrc7xpgA1upElWnrnIhgnU2CruwSpct0qvgB
	NXJUf2UQQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUeat-000538-1q; Wed, 05 Dec 2018 21:20:31 +0000
Received: from smtp.codeaurora.org ([198.145.29.96])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUeap-00052J-N2
 for linux-arm-kernel@lists.infradead.org; Wed, 05 Dec 2018 21:20:29 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
 id 2A42360913; Wed,  5 Dec 2018 21:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1544044817;
 bh=5NHrt9PaIBpwHymbbZZwl+a7yRYRKC4UqNPxsK+dcl8=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=H6GoTnyP3VuidohMUc3gqTFIFDoTBqPnryy+MI8s0e3NLS08TvtvkXeqY5hWILeRW
 5WFSjqd76pmPvFJIxzxJMM4MyO8FupsUdQxMwe0ZVQ4DUMDXkA3O8BMnE6e/VtmSsO
 PYLyhoze8m01LpCegVBqDsaq0mHotWHLHyoZ5VvY=
Received: from [10.226.60.81] (i-global254.qualcomm.com [199.106.103.254])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: jhugo@smtp.codeaurora.org)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id 9EF19601B4;
 Wed,  5 Dec 2018 21:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1544044816;
 bh=5NHrt9PaIBpwHymbbZZwl+a7yRYRKC4UqNPxsK+dcl8=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=Xvm3QxJksHSlUoDEqX0WA2WzM3SDxBrTZm9dgq0bY1OkZNMKXFXC7TVInJ49OPcxz
 E+T4p07wXacN9Vlp42252KZ9oWXPnFvK6hZ86x8Ol/Kv56Eckh3aJAnLjHde6gDZxa
 6Uz3aK/g+SCJH4EbBkffbRqbBDigYTtE0ND1D8iE=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9EF19601B4
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
 spf=none smtp.mailfrom=jhugo@codeaurora.org
Subject: Re: [PATCH v2 1/3] arm64: dts: qcom: msm8998: correct xo clock name
To: Stephen Boyd <sboyd@kernel.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>
References: <1542314695-24071-1-git-send-email-jhugo@codeaurora.org>
 <1542314695-24071-2-git-send-email-jhugo@codeaurora.org>
 <b50bc3d4-f80b-6adb-c28b-1be254eb7e16@free.fr>
 <0ba54ffd-1d47-5ae9-ae9c-4a03d57e6ff3@codeaurora.org>
 <20181205164843.GB1492@tuxbook-pro>
 <05b9ee40-d51e-3f80-8ca4-217fa6fbd51c@codeaurora.org>
 <154404384283.88331.2522037578224950651@swboyd.mtv.corp.google.com>
From: Jeffrey Hugo <jhugo@codeaurora.org>
Message-ID: <14cad8f0-7388-16a0-b1ba-4cd5a469a17e@codeaurora.org>
Date: Wed, 5 Dec 2018 14:20:07 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <154404384283.88331.2522037578224950651@swboyd.mtv.corp.google.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_132027_830397_D0F94993 
X-CRM114-Status: GOOD (  25.56  )
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
Cc: Andy Gross <andy.gross@linaro.org>, MSM <linux-arm-msm@vger.kernel.org>,
 Georgi Djakov <georgi.djakov@linaro.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Marc Gonzalez <marc.w.gonzalez@free.fr>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 12/5/2018 2:04 PM, Stephen Boyd wrote:
> Quoting Jeffrey Hugo (2018-12-05 09:03:54)
>> On 12/5/2018 9:48 AM, Bjorn Andersson wrote:
>>> On Wed 05 Dec 08:38 PST 2018, Jeffrey Hugo wrote:
>>>
>>>> On 12/5/2018 9:12 AM, Marc Gonzalez wrote:
>>>>> On 15/11/2018 21:44, Jeffrey Hugo wrote:
>>>>>
>>>>>> The root parent clock of most msm8998 clock is the "xo" clock.  The DT node
>>>>>> is incorrectly named "xo_board", which prevents Linux from correctly
>>>>>> parsing the clock tree, resulting in most clocks being unparented and
>>>>>> unable to be manipulated.  The end result is that we can't turn on clocks
>>>>>> for peripherals like SD, so init usually fails.
>>>>>>
>>>>>> Fixes: 4807c71cc688 (arm64: dts: Add msm8998 SoC and MTP board support)
>>>>>> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
>>>>>> Signed-off-by: Jeffrey Hugo <jhugo@codeaurora.org>
>>>>>> ---
>>>>>>     arch/arm64/boot/dts/qcom/msm8998.dtsi | 2 +-
>>>>>>     1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/arch/arm64/boot/dts/qcom/msm8998.dtsi b/arch/arm64/boot/dts/qcom/msm8998.dtsi
>>>>>> index 78227cc..a948d4b 100644
>>>>>> --- a/arch/arm64/boot/dts/qcom/msm8998.dtsi
>>>>>> +++ b/arch/arm64/boot/dts/qcom/msm8998.dtsi
>>>>>> @@ -53,7 +53,7 @@
>>>>>>             };
>>>>>>             clocks {
>>>>>> -          xo_board {
>>>>>> +          xo {
>>>>>>                             compatible = "fixed-clock";
>>>>>>                             #clock-cells = <0>;
>>>>>>                             clock-frequency = <19200000>;
>>>>>>
>>>>>
>>>>> Isn't there going to be a problem for msm8998 in drivers/clk/qcom/clk-smd-rpm.c
>>>>> which uses "xo_board" for parent_names?
>>>>
>>>> Looks like you are right.  This doesn't seem to be the correct way to
>>>> address the issue then.  I'll have to dig in and take another look.
>>>>
>>>
>>> The appropriate solution is to describe references between clock drivers
>>> explicitly in DeviceTree and by that not rely on a global namespace.
>>> That will also sort out any initialization ordering issues that we might
>>> have.
>>>
>>> But this task has not yet made it off the todo lists where it lives...
>>
>> Ok, that sounds great, but doesn't seem like it helps anyone today.
>>
>> Looks like 8916 and 8974 explicitly register an xo clock off the
>> xo_board clock in the respective gcc drivers.  8996 does not, but I
>> don't know how functional 8996 really is on mainline.  845 seems to
>> register the bi_tcxo clock (the 845 version of xo) in the rpmh driver,
>> off of xo_board.
>>
>> Since both Marc and I are trying to get 8998 to work, it seems like one
>> of those two solutions would be workable, short term.
>>
>> How do you suggest we proceed?
>>
> 
> I don't quite understand the patch in general. The xo_board clk should
> always exist in DT and the fixed factor clk in GCC is there until the
> rpm clk driver can control the XO clk state vote for the kernel.

Sorry, this wasn't apparent.  It doesn't seem like this "requirement" is 
captured anywhere.

As far as the SD clocks are concerned, they are defined in GCC, and 
eventually have a root parent called "xo".  "xo" isn't defined anywhere, 
so the SD clocks can't really be used, and the hardware doesn't come up. 
  This patch "fixed" that, but I missed the link to the rpm driver that 
Marc pointed out.


> 
> If anything, change the DT node to be named xo-board instead of xo_board
> because that matches DT naming schemes and then add a clock-output-names
> = "xo_board" property to it so that we keep the underscore.

I see this now, and I agree with it, but then SD goes back to a broken 
state because there is "xo" clock for GCC.  Its not quite clear to me 
how to make GCC (and thus SD) happy again with this change reverted/fixed.

Bjorn mentioned offline he is going to take a look, but he has a few 
other things on his plate first.

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
