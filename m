Return-Path: <SRS0=flTa=P5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5150C7112F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 11:04:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B82C2085A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 11:04:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="AFu/qzrz";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZTfgK8jV";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="msSd51N6";
	dkim=neutral (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="LudqH/NN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B82C2085A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=IsXsDyu2vt65kI0+QKU7VO9210VYuuOsjsuzrwxVUQ0=; b=AFu/qzrzNTUWdtrx1TtrIDYFR
	3t7MFnewrCr4jrOrv8j5nb+SDEqHtqGZYbs0wV0OQ8f7JjmbimzeEWDxcqsiprmmKHxmnVodkDg0s
	lqvsCATfIWJZzSNpMFGdVA01wBJ6zXK1agjzuajRf2KzUoRABWEYy2i8rbJeoQs7aBbmOqRyGvsAw
	F1bzQiSABGgeUDf+h7tyhAR8Du+dfNgCEbOJckiciJxE6xW5gkkt+sDYXOu4VSq6pcmmEiV+g4qt3
	j370HJQI0M3JQBhZZkvPRXuv1y87OOeTvi7lRdBynw68feRgqOt4B15AjArr5z5pXndFfIGJT2puv
	DxbwFy2aQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glXNi-0000a8-Qj; Mon, 21 Jan 2019 11:04:42 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glXNg-0000Qr-NR
 for linux-arm-kernel@bombadil.infradead.org; Mon, 21 Jan 2019 11:04:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
 In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=0NTKWmHzAFTnlgKiJ+9+YWrQN74XbPjbtp3VzvCcAOQ=; b=ZTfgK8jVPg09WN9sM14JsMwS3j
 zUcyGIP+Qu5enfnSsBmeqOiIyVCJLqtae96RBHY9I4JL/RBqF318dP4CuYHR+OAG5FpBMeTm7Uo9Q
 naEIOekoJwS+OJCurgbvu5JXpsE0Vze1lVaog/1Q93pW6gBkE2xXw3iD38JUlrphCGL0i0XpzSW3S
 mCayy85ilrB3718izu9OmSzgdO57QDJ+UuTo3uDxqpDI8nQHuggojNmgEbg4kd2c0g1uNRFVdzLI5
 fBwCEyIh1GnZpNjG2UUILAV1EPb8Cp7hB3iePbPjBT3eaRaIuv1LC9f0ZXltN6EmgVcIyviwUQcQd
 WefQzSXQ==;
Received: from smtp.codeaurora.org ([198.145.29.96])
 by casper.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glX8X-0002eS-L5
 for linux-arm-kernel@lists.infradead.org; Mon, 21 Jan 2019 10:49:03 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
 id 1AEFE60A78; Mon, 21 Jan 2019 10:48:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1548067737;
 bh=0QHfasHGRj/c+tZG+pzV/MmNxDMvVcTPZ/a7hlGP+Ic=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=msSd51N6wy9W5tSZ7Rrnt9Gu+FyFXC29IvtgOMyUUYl/OEtRs/yD+eqFwPGxOnfgE
 E/iERZFOBjSApppl+9BSTad4aAA0aVzo5apK/mkmk51PGm3VJhr9OczcKMlOl4N8qc
 otFMrS9n04N0oLfEHo7xD5PPEb2VstEt2iq01NjY=
Received: from [10.131.114.83]
 (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: vivek.gautam@smtp.codeaurora.org)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id 0C37860DB1;
 Mon, 21 Jan 2019 10:48:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1548067724;
 bh=0QHfasHGRj/c+tZG+pzV/MmNxDMvVcTPZ/a7hlGP+Ic=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=LudqH/NNcoDNJ8ict+I4ko9ORMn1akIXWEFBiXlSOyhTaPhL0w6ShIly9+RqJkS7C
 HwntGxPmSozaTe8H6GJR7XYN6b6VFGlXaGBvak96CSAFv3rSlmgpyExqx6JnBM1OWt
 cXANmEutRqL3ulwt/KCPNbvzNuAUuA0MB8NyioDo=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0C37860DB1
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
 spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
Subject: Re: [PATCHv3 3/4] coresight: etm4x: Add support to enable ETMv4.2
To: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
 Rob Herring <robh+dt@kernel.org>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Leo Yan <leo.yan@linaro.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Andy Gross <andy.gross@linaro.org>, David Brown <david.brown@linaro.org>,
 Doug Anderson <dianders@chromium.org>, Stephen Boyd <sboyd@kernel.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>, devicetree@vger.kernel.org,
 Mark Rutland <mark.rutland@arm.com>
References: <cover.1547813804.git.saiprakash.ranjan@codeaurora.org>
 <d52546764f8570e8c07ac8e3e2841e087e66648c.1547813804.git.saiprakash.ranjan@codeaurora.org>
From: Vivek Gautam <vivek.gautam@codeaurora.org>
Message-ID: <cc71cfa9-8a11-9356-ac41-e27564a9f7b4@codeaurora.org>
Date: Mon, 21 Jan 2019 16:18:36 +0530
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <d52546764f8570e8c07ac8e3e2841e087e66648c.1547813804.git.saiprakash.ranjan@codeaurora.org>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190121_104902_036479_E44E460D 
X-CRM114-Status: GOOD (  21.45  )
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
Cc: linux-arm-msm@vger.kernel.org, Rajendra Nayak <rnayak@codeaurora.org>,
 Sibi Sankar <sibis@codeaurora.org>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


On 1/18/2019 5:52 PM, Sai Prakash Ranjan wrote:
> SDM845 has ETMv4.2 and can use the existing etm4x driver.
> But the current etm driver checks only for ETMv4.0 and
> errors out for other etm4x versions. This patch adds this
> missing support to enable SoC's with ETMv4x to use same
> driver by checking only the ETM architecture major version
> number.
>
> Without this change, we get below error during etm probe:
>
> / # dmesg | grep etm
> [    6.660093] coresight-etm4x: probe of 7040000.etm failed with error -22
> [    6.666902] coresight-etm4x: probe of 7140000.etm failed with error -22
> [    6.673708] coresight-etm4x: probe of 7240000.etm failed with error -22
> [    6.680511] coresight-etm4x: probe of 7340000.etm failed with error -22
> [    6.687313] coresight-etm4x: probe of 7440000.etm failed with error -22
> [    6.694113] coresight-etm4x: probe of 7540000.etm failed with error -22
> [    6.700914] coresight-etm4x: probe of 7640000.etm failed with error -22
> [    6.707717] coresight-etm4x: probe of 7740000.etm failed with error -22
>
> With this change, etm probe is successful:
>
> / # dmesg | grep coresight
> [    6.659198] coresight-etm4x 7040000.etm: CPU0: ETM v4.2 initialized
> [    6.665848] coresight-etm4x 7140000.etm: CPU1: ETM v4.2 initialized
> [    6.672493] coresight-etm4x 7240000.etm: CPU2: ETM v4.2 initialized
> [    6.679129] coresight-etm4x 7340000.etm: CPU3: ETM v4.2 initialized
> [    6.685770] coresight-etm4x 7440000.etm: CPU4: ETM v4.2 initialized
> [    6.692403] coresight-etm4x 7540000.etm: CPU5: ETM v4.2 initialized
> [    6.699024] coresight-etm4x 7640000.etm: CPU6: ETM v4.2 initialized
> [    6.705646] coresight-etm4x 7740000.etm: CPU7: ETM v4.2 initialized
>
> Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
> ---
>   drivers/hwtracing/coresight/coresight-etm4x.c | 2 +-
>   drivers/hwtracing/coresight/coresight-etm4x.h | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x.c b/drivers/hwtracing/coresight/coresight-etm4x.c
> index 53e2fb6e86f6..93d5f1f3145e 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x.c
> @@ -55,7 +55,7 @@ static void etm4_os_unlock(struct etmv4_drvdata *drvdata)
>   
>   static bool etm4_arch_supported(u8 arch)
>   {
> -	switch (arch) {
> +	switch (arch >> 4) {


While this looks good, from what it looks like arch is a combination of 
major version
minor version. So, will it be better to masks, and shifts macros instead 
of a magic
number shift.
But, frankly it's upto Mathieu to decide the readability of this. So, I 
leave it to him.

Thanks
Vivek

>   	case ETM_ARCH_V4:
>   		break;
>   	default:
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x.h b/drivers/hwtracing/coresight/coresight-etm4x.h
> index 52786e9d8926..05d4bd330881 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x.h
> +++ b/drivers/hwtracing/coresight/coresight-etm4x.h
> @@ -136,7 +136,7 @@
>   #define ETM_MAX_RES_SEL			16
>   #define ETM_MAX_SS_CMP			8
>   
> -#define ETM_ARCH_V4			0x40
> +#define ETM_ARCH_V4			0x4
>   #define ETMv4_SYNC_MASK			0x1F
>   #define ETM_CYC_THRESHOLD_MASK		0xFFF
>   #define ETM_CYC_THRESHOLD_DEFAULT       0x100

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
