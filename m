Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5244FC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 17:03:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1586420659
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 17:03:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="md6jjkhX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1586420659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=free.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=++nd3xmE7Zj5FpXC0kgbCm7cgZYyEJO4zdRFFXPF2Kk=; b=md6jjkhXXTOhNr
	ZDfz6bMaNO4PnMkRq17zHkiHmg9WILaovHTtQ0Pktci7xuRv7jNJhrVDn9Wv9zTv68FMH9V5Dhx8i
	NpLIYt0ADLpm24EiuZfhMXllGOpRrY2G0su0FIDqC4P8xwt8ASJ4FPt0huI0V3jhwsnJV9FX/Vc1i
	34IFXJ+kR/apofLpd7ea/+snGQXLjgXGQtoQ/VsMbC/GtNMTZ0H6PsrDTCa/u3pxVGVJZYfBpYNpc
	L73oo6Lv2lWTwi0YrzH05usMY6HzEaD8lu7YaZ6T7zIdmO41GWlcdEfdiP6v3WQswvDLFI4UYAh+X
	ytAP7uUqa35uqOKar4QQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUE6t-0006Nu-Es; Tue, 04 Dec 2018 17:03:47 +0000
Received: from smtp3-g21.free.fr ([2a01:e0c:1:1599::12])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUE6q-0006Mb-38
 for linux-arm-kernel@lists.infradead.org; Tue, 04 Dec 2018 17:03:45 +0000
Received: from [192.168.108.68] (unknown [213.36.7.13])
 (Authenticated sender: marc.w.gonzalez)
 by smtp3-g21.free.fr (Postfix) with ESMTPSA id 198A813F7E2;
 Tue,  4 Dec 2018 18:03:17 +0100 (CET)
Subject: Re: WIP: UFS on apq8098
To: Jeffrey Hugo <jhugo@codeaurora.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 Nicolas Dechesne <nicolas.dechesne@linaro.org>,
 Niklas Cassel <niklas.cassel@linaro.org>, Andy Gross <andy.gross@linaro.org>
References: <ab9c8bec-35be-9e01-a567-bc2e4b2bef87@free.fr>
 <2b186a33-aea2-629c-6fbf-aefe16ff7b0a@free.fr>
 <bc40674c-9be7-3e5e-9409-42aa8bb0b376@free.fr>
 <ec633e12-b6c1-5de9-690c-a58b8ecdb2b8@free.fr>
 <48b1a7ce-afb7-18d3-6855-69196972d640@codeaurora.org>
From: Marc Gonzalez <marc.w.gonzalez@free.fr>
Message-ID: <a4c0c2e1-09d8-c48f-d434-6147c047c3a8@free.fr>
Date: Tue, 4 Dec 2018 18:03:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <48b1a7ce-afb7-18d3-6855-69196972d640@codeaurora.org>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_090344_289658_A031D530 
X-CRM114-Status: GOOD (  13.38  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 04/12/2018 17:35, Jeffrey Hugo wrote:

> On 12/4/2018 9:17 AM, Marc Gonzalez wrote:
> 
>> I booted a downstream kernel with UFS debug enabled (log provided below)
>>
>> The one difference that jumps out at me is:
>>
>> DOWNSTREAM
>> [   10.902119] ufshcd-qcom 1da4000.ufshc: ufshcd_init_clocks: clk: core_clk_unipro, rate: 150000000
>> [   10.902161] ufshcd-qcom 1da4000.ufshc: ufshcd_init_clocks: clk: core_clk_ice, rate: 300000000
>> [   10.902198] ufshcd-qcom 1da4000.ufshc: ufshcd_init_clocks: clk: ref_clk, rate: 1000
>>
>> UPSTREAM
>> [    2.072820] ufshcd-qcom 1da4000.ufshc: ufshcd_init_clocks: clk: core_clk_unipro, rate: 0
>> [    2.080304] ufshcd-qcom 1da4000.ufshc: ufshcd_init_clocks: clk: core_clk_ice, rate: 0
>> [    2.088547] ufshcd-qcom 1da4000.ufshc: ufshcd_init_clocks: clk: ref_clk, rate: 0
>>
>>
>> Jeffrey, I will check the regulators per your suggestion.
>> I'm all ears if you have suggestions for the clocks as well.
> 
> Hmm, this is interesting.
> 
> I know you mentioned before that the clock rates were 0.  Even with the 
> downstream kernel, I've seen clock rates be zero (for other use-cases).
> 
> Since we have a delta between downstream and upstream, that seems 
> significant.
> 
> When I've seen a clock keep its rate 0 like this, its been because of a 
> bad parent.  You can check this in upstream via debugfs - 
> <debugfs>/clk/clk_summary
> In downstream, I recall having to go into the individual clock sub 
> directory, and reading the parent file.
> 
> However, maybe a simple solution.  Do you have 
> https://patchwork.codeaurora.org/patch/657871/ ?

Yep!

$ git show --pretty=fuller 79bf268a13bf
commit 79bf268a13bf24e46db54fd836807fdfccaf7d59
Author:     Jeffrey Hugo <jhugo@codeaurora.org>
AuthorDate: Thu Nov 15 13:44:53 2018 -0700
Commit:     Marc Gonzalez <marc.w.gonzalez@free.fr>
CommitDate: Thu Nov 29 10:03:33 2018 +0100

    arm64: dts: qcom: msm8998: correct xo clock name


Not sure I have the clk debug config knob, /sys/kernel/debug is empty.
I'm off to tweak :-)

Regards.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
