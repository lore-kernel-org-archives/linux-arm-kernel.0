Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C89C2C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 17:05:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 994C820661
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 17:05:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ocVxvHCP";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="XLFkWpnL";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="I/SpN5aU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 994C820661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=tmfNz+8yJQBp2CdQznl5rxVrNN+NmFv2dULo7xGt944=; b=ocVxvHCPmqzycbzCLnKUnt6VL
	5s7ZHUVMt5Vb8lUZSeLll1cWWXhAecW6n2S72YRJfOUZfKPIwx9XsD0U0VIcwXYEaOPeBe/adRPjJ
	zL+JAoDzPNtxiL8iWbAxH5vgnovhttG90gbFZJn8chrG0WFEwRKt7tebz8cRbc76E/t12BIAiFSsU
	20viGuKY5HCgmmQOF6Wu2+Tt6D3miLx/1cSF6dYYIU3VZAMNQzDKA2l0cMW6BsJgNulONWUNfiCbG
	riy+bCcaEr7HcS1q0AJ6VyqT8vPjg3CHtTkg5xTzGaz9Oiu6aiDCtZiepIJ9yuHyBVjSdCK/mfBJh
	yyTrbN4Xg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUE8S-0000oI-5S; Tue, 04 Dec 2018 17:05:24 +0000
Received: from smtp.codeaurora.org ([198.145.29.96])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUE8N-0000FI-SD
 for linux-arm-kernel@lists.infradead.org; Tue, 04 Dec 2018 17:05:21 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
 id 3128260AD8; Tue,  4 Dec 2018 17:05:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1543943109;
 bh=GhuMFNvek3FLhRMtVTBJbsVEn7HZIh7hoVZun39QyP0=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=XLFkWpnLACKpxyPwDZ4fsTZPlhnboYcnItcrmCGrO0LMgjMeS6SAq1v/Z3eVAHPD3
 1JnwTTl8SZKvmogxv8tBZN8EXXqy6DmsKHOV4+kcEZrhqZ6zdEPPayRDEhNXGt6j4/
 +LV3MlslTq5dhKw7BGJhtzqvF+6IVrA+9snnt+48=
Received: from [10.226.60.81] (i-global254.qualcomm.com [199.106.103.254])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: jhugo@smtp.codeaurora.org)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id 3C9A8606FA;
 Tue,  4 Dec 2018 17:05:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1543943108;
 bh=GhuMFNvek3FLhRMtVTBJbsVEn7HZIh7hoVZun39QyP0=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=I/SpN5aUn4CPQnb1n0x+bO3//f0oMUCIa4Dy3YrPEfLTJJzr/cggYxFj4ulCLfi2o
 /IKUBUasRh0KCUilD9LM6yn83yhbKIohBxyuZnNFO1YVztMA9lVEAcBi6tIL96yUeL
 XFy9wJgkd2OenY2Kna8kf3q2c0G8C/+da2UgCA+M=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3C9A8606FA
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
 spf=none smtp.mailfrom=jhugo@codeaurora.org
Subject: Re: WIP: UFS on apq8098
To: Marc Gonzalez <marc.w.gonzalez@free.fr>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 Nicolas Dechesne <nicolas.dechesne@linaro.org>,
 Niklas Cassel <niklas.cassel@linaro.org>, Andy Gross <andy.gross@linaro.org>
References: <ab9c8bec-35be-9e01-a567-bc2e4b2bef87@free.fr>
 <2b186a33-aea2-629c-6fbf-aefe16ff7b0a@free.fr>
 <bc40674c-9be7-3e5e-9409-42aa8bb0b376@free.fr>
 <ec633e12-b6c1-5de9-690c-a58b8ecdb2b8@free.fr>
 <48b1a7ce-afb7-18d3-6855-69196972d640@codeaurora.org>
 <a4c0c2e1-09d8-c48f-d434-6147c047c3a8@free.fr>
From: Jeffrey Hugo <jhugo@codeaurora.org>
Message-ID: <d99567c7-9c1c-6d7e-6dd1-2930b82db7d8@codeaurora.org>
Date: Tue, 4 Dec 2018 10:05:07 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <a4c0c2e1-09d8-c48f-d434-6147c047c3a8@free.fr>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_090519_950095_4C28A28C 
X-CRM114-Status: GOOD (  15.77  )
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
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 12/4/2018 10:03 AM, Marc Gonzalez wrote:
> On 04/12/2018 17:35, Jeffrey Hugo wrote:
> 
>> On 12/4/2018 9:17 AM, Marc Gonzalez wrote:
>>
>>> I booted a downstream kernel with UFS debug enabled (log provided below)
>>>
>>> The one difference that jumps out at me is:
>>>
>>> DOWNSTREAM
>>> [   10.902119] ufshcd-qcom 1da4000.ufshc: ufshcd_init_clocks: clk: core_clk_unipro, rate: 150000000
>>> [   10.902161] ufshcd-qcom 1da4000.ufshc: ufshcd_init_clocks: clk: core_clk_ice, rate: 300000000
>>> [   10.902198] ufshcd-qcom 1da4000.ufshc: ufshcd_init_clocks: clk: ref_clk, rate: 1000
>>>
>>> UPSTREAM
>>> [    2.072820] ufshcd-qcom 1da4000.ufshc: ufshcd_init_clocks: clk: core_clk_unipro, rate: 0
>>> [    2.080304] ufshcd-qcom 1da4000.ufshc: ufshcd_init_clocks: clk: core_clk_ice, rate: 0
>>> [    2.088547] ufshcd-qcom 1da4000.ufshc: ufshcd_init_clocks: clk: ref_clk, rate: 0
>>>
>>>
>>> Jeffrey, I will check the regulators per your suggestion.
>>> I'm all ears if you have suggestions for the clocks as well.
>>
>> Hmm, this is interesting.
>>
>> I know you mentioned before that the clock rates were 0.  Even with the
>> downstream kernel, I've seen clock rates be zero (for other use-cases).
>>
>> Since we have a delta between downstream and upstream, that seems
>> significant.
>>
>> When I've seen a clock keep its rate 0 like this, its been because of a
>> bad parent.  You can check this in upstream via debugfs -
>> <debugfs>/clk/clk_summary
>> In downstream, I recall having to go into the individual clock sub
>> directory, and reading the parent file.
>>
>> However, maybe a simple solution.  Do you have
>> https://patchwork.codeaurora.org/patch/657871/ ?
> 
> Yep!
> 
> $ git show --pretty=fuller 79bf268a13bf
> commit 79bf268a13bf24e46db54fd836807fdfccaf7d59
> Author:     Jeffrey Hugo <jhugo@codeaurora.org>
> AuthorDate: Thu Nov 15 13:44:53 2018 -0700
> Commit:     Marc Gonzalez <marc.w.gonzalez@free.fr>
> CommitDate: Thu Nov 29 10:03:33 2018 +0100
> 
>      arm64: dts: qcom: msm8998: correct xo clock name
> 
> 
> Not sure I have the clk debug config knob, /sys/kernel/debug is empty.
> I'm off to tweak :-)

mount -t debugfs none /sys/kernel/debug


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
