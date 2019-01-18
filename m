Return-Path: <SRS0=p0aQ=P2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 355B9C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 11:48:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA57520823
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 11:48:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Eu3NrZfX";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="LFgvatob";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Ec33FAKf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA57520823
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=sVBwldM6geefd6+KJEDFqyBSDLMQtAgdE3Xpa14S4p8=; b=Eu3NrZfXufcpAERDl+7v+D0XU
	Oky503DpCEyHIG1ETTRBl8v4e1ragqByPFMK5plbWiHbhZcynl5nR+pVwX6D6yxHrzhPiawKQUZqP
	fWe1H4MDpe18uwO57+d/4GP0Mf9bNY1/8tOfjC7brygCiPfdT294/tMvHeqZWW1YZB9ZMu4ntBDqC
	jKTKrvy/XdB5HV2m5pevhSWwFBCnhRFaMEZBQzGrD3jZWLYde9vzn76pr3bQU7mKAihNppKxv3UK8
	42aozWX3y3w7xkCoNJZVnOYFgb9g3194MPILL1PkPGCHEwLifzrtU/d1WlkyPO6h1SIFsDOTdtJwf
	2OEB/hbVA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkSdC-000255-LU; Fri, 18 Jan 2019 11:48:14 +0000
Received: from smtp.codeaurora.org ([198.145.29.96])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkSd9-00024j-3v
 for linux-arm-kernel@lists.infradead.org; Fri, 18 Jan 2019 11:48:12 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
 id 8533A60591; Fri, 18 Jan 2019 11:48:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1547812090;
 bh=MShgtf1g2WW51ztF9muOxPJZV5eRh6Y1ynlNDp9Rvm0=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=LFgvatobMk6GpbFSI/8oXHx//+0LIUpCLeGjp4dFs4cegoIcZ50FqOY8OtBb58z6Z
 kpBNxXe5yc1oTCRUBTcYFOFt5Neog9X3DMpDjqdFzugWLzsfp/RMQyP32cjF7Xba8R
 CzjdCcMhId4lVAXItkKttDx+l7seygdLDJ0zRKfc=
Received: from [10.79.129.0]
 (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: saiprakash.ranjan@smtp.codeaurora.org)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id AB07660388;
 Fri, 18 Jan 2019 11:48:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1547812089;
 bh=MShgtf1g2WW51ztF9muOxPJZV5eRh6Y1ynlNDp9Rvm0=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=Ec33FAKffme3+o2l24D5MR08kw2B1FanTvhXwaKCrU6KVt34UVHTWSPXIIk+V7w54
 ARr8zyJ7a+pEAf9jd0p491iwcRbChfje5Qn0O+vlytEhEX8t+rsqbuQLjr4x8v6T6V
 /rEyAUfcg3nK9brr98ka/JXI2qALJ2mUXNYhvFY0=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org AB07660388
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none
 smtp.mailfrom=saiprakash.ranjan@codeaurora.org
Subject: Re: [PATCHv2 2/4] arm64: dts: qcom: msm8996: Add Coresight support
To: Suzuki K Poulose <suzuki.poulose@arm.com>, robh+dt@kernel.org,
 mathieu.poirier@linaro.org, leo.yan@linaro.org,
 alexander.shishkin@linux.intel.com, andy.gross@linaro.org,
 david.brown@linaro.org, vivek.gautam@codeaurora.org, dianders@chromium.org,
 sboyd@kernel.org, bjorn.andersson@linaro.org, devicetree@vger.kernel.org,
 mark.rutland@arm.com
References: <cover.1547798966.git.saiprakash.ranjan@codeaurora.org>
 <552e408950525b1bac39d05b8b4f2ae1975397e0.1547798966.git.saiprakash.ranjan@codeaurora.org>
 <1311e78a-21f6-6470-7861-39b3499974ce@arm.com>
From: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Message-ID: <6543ad5c-bbcf-b3ec-332c-115e8e3d0825@codeaurora.org>
Date: Fri, 18 Jan 2019 17:18:01 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1311e78a-21f6-6470-7861-39b3499974ce@arm.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190118_034811_199599_BF22B8FC 
X-CRM114-Status: GOOD (  14.22  )
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
Cc: linux-arm-msm@vger.kernel.org, rnayak@codeaurora.org, sibis@codeaurora.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Suzuki,

On 1/18/2019 4:27 PM, Suzuki K Poulose wrote:
> 
> If you want to use the scatter-gather mode, you must add 
> "arm,scatter-gather"
> property to the node here.
> 
> Have you tested the scatter-gather mode on the chip ? Does that work at 
> all ?
> Note: You could try this by setting a buffer_size > 1M for the ETR and use
> it as a sink from the sysfs mode.
> 

Yes the chip supports scatter-gather mode[1]. But is it required in
dt node since it's an optional property?

[1] 
https://source.codeaurora.org/quic/la/kernel/msm-3.18/tree/arch/arm/boot/dts/qcom/msm8996-coresight-v3.dtsi?h=LA.BR.5.6#n24

Thanks,
Sai
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
