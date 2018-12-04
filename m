Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3743DC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 16:36:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 058B5206B6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 16:36:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="pfdkBucY";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="VT91f3+Q";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Ov1aY4Sd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 058B5206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=n9QBWXrCavu1egHLEJXVORvvdtFhGrC0GTNozf61p4c=; b=pfdkBucYYHhopOt9ymGdGLMoe
	/enq/XEhWXVa/u8xhe/Ua1d2hKoqhgm9mrFqgV2uMg5jk5AUkdVwkLfB2tQw/wRtKxO8hiWaup5kL
	02izu4rjKfAAOUAa+GHHs2p2RdiNAv58WJsg1iyHDKGp3sR5pgQoEB0XHcbd9s8E52UQivTShMfDF
	eHiKiwWRi5mRyoPI4hgUgYAYiZr/e51y24ef224H2zavqR5OTHjAkJeVRgFPJrANqVxXJIZNcp1ER
	4c+7nWb8MFsGOSW6RgrNMx866QLg9dcR8hOSLXQ4DsIvKyOy+JoKSsf/hBzkFB3t2z4qMSXCI+14j
	An2+E8vtQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUDg5-00037b-DI; Tue, 04 Dec 2018 16:36:05 +0000
Received: from smtp.codeaurora.org ([198.145.29.96])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUDg1-00036t-Qf
 for linux-arm-kernel@lists.infradead.org; Tue, 04 Dec 2018 16:36:03 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
 id 142DB6028B; Tue,  4 Dec 2018 16:35:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1543941351;
 bh=DKzr6EhlOL1N81MMw2SBuO8OloR37kaiYfAQQwDmUbY=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=VT91f3+Qr1SMQdPt/7KxMDWEniUeJUq+OqR+Mlc9bKa+K76gK1dl65ieSs2QAiDbk
 mtJbzgi+cooz9crNSarRIWxKsvvo+fOC/GxxKq7ZOutd6Kb+CoeDiJAaHTWGPQ/Nsw
 jiG3PwRwCKYMQF7lQBdJephTEjDnW8qjRVk7kuso=
Received: from [10.226.60.81] (i-global254.qualcomm.com [199.106.103.254])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: jhugo@smtp.codeaurora.org)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id A60956063A;
 Tue,  4 Dec 2018 16:35:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1543941350;
 bh=DKzr6EhlOL1N81MMw2SBuO8OloR37kaiYfAQQwDmUbY=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=Ov1aY4SddLTcbX3q4XdE3phAJQth7VZctXuP6S6I1lWVAZwopNubIMACHTb9WIS43
 ajnyZlyCtCts0FWhgEqXL+rfNdqDoTAOtHUCDVbzX1qAv/Li/RNtnwNAF0lQoMPzoo
 /kkp9pwKVQd9urEL7TYU5otaPWPKDr4exzKGrgpA=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A60956063A
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
From: Jeffrey Hugo <jhugo@codeaurora.org>
Message-ID: <48b1a7ce-afb7-18d3-6855-69196972d640@codeaurora.org>
Date: Tue, 4 Dec 2018 09:35:49 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <ec633e12-b6c1-5de9-690c-a58b8ecdb2b8@free.fr>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_083601_978320_7560012E 
X-CRM114-Status: GOOD (  14.55  )
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

On 12/4/2018 9:17 AM, Marc Gonzalez wrote:

> 
> I booted a downstream kernel with UFS debug enabled (log provided below)
> 
> The one difference that jumps out at me is:
> 
> DOWNSTREAM
> [   10.902119] ufshcd-qcom 1da4000.ufshc: ufshcd_init_clocks: clk: core_clk_unipro, rate: 150000000
> [   10.902161] ufshcd-qcom 1da4000.ufshc: ufshcd_init_clocks: clk: core_clk_ice, rate: 300000000
> [   10.902198] ufshcd-qcom 1da4000.ufshc: ufshcd_init_clocks: clk: ref_clk, rate: 1000
> 
> UPSTREAM
> [    2.072820] ufshcd-qcom 1da4000.ufshc: ufshcd_init_clocks: clk: core_clk_unipro, rate: 0
> [    2.080304] ufshcd-qcom 1da4000.ufshc: ufshcd_init_clocks: clk: core_clk_ice, rate: 0
> [    2.088547] ufshcd-qcom 1da4000.ufshc: ufshcd_init_clocks: clk: ref_clk, rate: 0
> 
> 
> Jeffrey, I will check the regulators per your suggestion.
> I'm all ears if you have suggestions for the clocks as well.
> 

Hmm, this is interesting.

I know you mentioned before that the clock rates were 0.  Even with the 
downstream kernel, I've seen clock rates be zero (for other usecases).

Since we have a delta between downstream and upstream, that seems 
significant.

When I've seen a clock keep its rate 0 like this, its been because of a 
bad parent.  You can check this in upstream via debugfs - 
<debugfs>/clk/clk_summary
In downstream, I recall having to go into the individual clock sub 
directory, and reading the parent file.

However, maybe a simple solution.  Do you have 
https://patchwork.codeaurora.org/patch/657871/ ?

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
