Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96C54C04EBF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 16:38:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52C7620850
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 16:38:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="g7xKP2l4";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="jB0JkzlG";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="PMa9np/o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52C7620850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=oNvbATZlnNOVj3po6+1EaLYE92nu6K+BOwL2P8sOrl0=; b=g7xKP2l4F+aaALLrn68X1ASSA
	EKT+nTRKNv7o0scVuE3qyincVy4pOBzBVXF9lJ+NlpU4gMZwzUs6JIoaXSU3xzB++P/D6kp+8ABgN
	GFnGsfl+Rcv0ZCtmWZJi+EjiGWcwr+BPH/bl5SzcCO1m8gtjRSVveb4f/S/zKxZDxxGnzN86FFKfm
	2clQ+V2qSpB8pfGSdcADNbGEjPSsWFaat+wnXMPhPl5gMQlavi3pezf0CNK/IJO5eb1PJPD3eg3NE
	kQP1818TI2laTZuz1R+PHeyV3E5vlFUWZa2eTQr2QFblTQUF57UgX5ozXG1kdQEEE5JaS0Ugv9IIE
	/WmwGITyw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUaBv-0006bM-8I; Wed, 05 Dec 2018 16:38:27 +0000
Received: from smtp.codeaurora.org ([198.145.29.96])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUaBs-0006Yd-Mq
 for linux-arm-kernel@lists.infradead.org; Wed, 05 Dec 2018 16:38:26 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
 id C621F609F3; Wed,  5 Dec 2018 16:38:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1544027893;
 bh=sqMNqrlx9wPOLr3OerzM1GCBhGW87KuM3L2R+c7ARXI=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=jB0JkzlGHciGezmKq6ImokhDwX7PSnOw213BtscRHl8Kcds6nh/I5QB0UAnBeFM9m
 Vq4zeAOSRbIf7FsUa2E5PC0FX+CBKfOaXdBlJG162NvU/A1O0cR8NK9uYXAZAUIsxp
 n/uXOnTA9CTrwmhDDzxacbnNoy1yVHeOU2r+9/jg=
Received: from [10.226.60.81] (i-global254.qualcomm.com [199.106.103.254])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: jhugo@smtp.codeaurora.org)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id A85BF601D1;
 Wed,  5 Dec 2018 16:38:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1544027892;
 bh=sqMNqrlx9wPOLr3OerzM1GCBhGW87KuM3L2R+c7ARXI=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=PMa9np/oikyjFJpDpIIMnTOb0Iioz7CriKKaGgYRgunB7IY9+nOB/pC1wfBXZNKzW
 3MJrpfoaecGxZn+aK8eu7WRAEYN8nPnnECWFBPxjXSb2YTIYAWINY8jPEuw3TUcvMk
 Qat7c6YkOqrtvAdmBxUdx9ht7/jWl70rG743yDo4=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A85BF601D1
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
 spf=none smtp.mailfrom=jhugo@codeaurora.org
Subject: Re: [PATCH v2 1/3] arm64: dts: qcom: msm8998: correct xo clock name
To: Marc Gonzalez <marc.w.gonzalez@free.fr>
References: <1542314695-24071-1-git-send-email-jhugo@codeaurora.org>
 <1542314695-24071-2-git-send-email-jhugo@codeaurora.org>
 <b50bc3d4-f80b-6adb-c28b-1be254eb7e16@free.fr>
From: Jeffrey Hugo <jhugo@codeaurora.org>
Message-ID: <0ba54ffd-1d47-5ae9-ae9c-4a03d57e6ff3@codeaurora.org>
Date: Wed, 5 Dec 2018 09:38:10 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <b50bc3d4-f80b-6adb-c28b-1be254eb7e16@free.fr>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_083824_776251_9FF70FE0 
X-CRM114-Status: GOOD (  18.18  )
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
Cc: Stephen Boyd <sboyd@kernel.org>, MSM <linux-arm-msm@vger.kernel.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 Andy Gross <andy.gross@linaro.org>, Georgi Djakov <georgi.djakov@linaro.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 12/5/2018 9:12 AM, Marc Gonzalez wrote:
> On 15/11/2018 21:44, Jeffrey Hugo wrote:
> 
>> The root parent clock of most msm8998 clock is the "xo" clock.  The DT node
>> is incorrectly named "xo_board", which prevents Linux from correctly
>> parsing the clock tree, resulting in most clocks being unparented and
>> unable to be manipulated.  The end result is that we can't turn on clocks
>> for peripherals like SD, so init usually fails.
>>
>> Fixes: 4807c71cc688 (arm64: dts: Add msm8998 SoC and MTP board support)
>> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
>> Signed-off-by: Jeffrey Hugo <jhugo@codeaurora.org>
>> ---
>>   arch/arm64/boot/dts/qcom/msm8998.dtsi | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/msm8998.dtsi b/arch/arm64/boot/dts/qcom/msm8998.dtsi
>> index 78227cc..a948d4b 100644
>> --- a/arch/arm64/boot/dts/qcom/msm8998.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/msm8998.dtsi
>> @@ -53,7 +53,7 @@
>>   	};
>>   
>>   	clocks {
>> -		xo_board {
>> +		xo {
>>   			compatible = "fixed-clock";
>>   			#clock-cells = <0>;
>>   			clock-frequency = <19200000>;
>>
> 
> Isn't there going to be a problem for msm8998 in drivers/clk/qcom/clk-smd-rpm.c
> which uses "xo_board" for parent_names?

Looks like you are right.  This doesn't seem to be the correct way to 
address the issue then.  I'll have to dig in and take another look.


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
