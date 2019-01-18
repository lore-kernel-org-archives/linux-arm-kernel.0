Return-Path: <SRS0=p0aQ=P2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60563C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 12:08:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 314D92087E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 12:08:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nF0oQ6bo";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="htjKPRRp";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="RyJsqdoN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 314D92087E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=jeNkXB4HYnLxyqFBfFYPAtO8O8r9rKyrfq4judP2GrI=; b=nF0oQ6boREKCgBzlRb6KViQO2
	gv7pmh+XSkw0jBTv8RqmOGhEHZ2+hi5GvsfACfF9+F6MSXHWt+2CvnwfdqwujMQIze8o464WC2a4W
	bIrJVd6pwH32JlvmBe/bNs1ZVXal0gl9f2EI0ovkuR+Yeu5D81p1oag31To31NOkYPIycJAJEH6cp
	HxMlf5ktBgLXeaHU2UuhXo4Deew1V1K/z4igxXhaPPw3y+kTfJHxNgk8V4i61X6DJJxwszfE/dHby
	K0ezvQBB/mENsae0+lzjl1HpgtlGWy8puFk36CK3VG6Y1ZT+R4Ks98jb4GhHU4UhkO+T83eW8ptQx
	l29gMF0Ig==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkSww-0001Ev-24; Fri, 18 Jan 2019 12:08:38 +0000
Received: from smtp.codeaurora.org ([198.145.29.96])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkSws-0001Dx-U8
 for linux-arm-kernel@lists.infradead.org; Fri, 18 Jan 2019 12:08:36 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
 id 74F3A6085C; Fri, 18 Jan 2019 12:08:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1547813314;
 bh=AuMRxhZnW/nS9eRSCZAqfikgkQPIMNT9WIGr/bfc/9E=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=htjKPRRpfAc1Oad8zywhO2EaiL5tiW6O3ijvs6HP/Jh9AM2S4vpED0vP/52ZdjYe/
 GDn57/tGpOITcmkaEEn/vl/9iM5spvAVkaGzbXQ9759k9vkCNB4JqNHVnR/cAZEnbk
 3w0K3ehXwrH8ykX5Gq/X5B8NeBRmtG9eTHcvYQT8=
Received: from [10.79.129.0]
 (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: saiprakash.ranjan@smtp.codeaurora.org)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id 5A60A604B4;
 Fri, 18 Jan 2019 12:08:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1547813313;
 bh=AuMRxhZnW/nS9eRSCZAqfikgkQPIMNT9WIGr/bfc/9E=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=RyJsqdoN9iVzcLxty4zNLVr/WfkiC4ROoAcFZRDF16dm/mWHS/GPDy933RZYSdk64
 4e0YyUEtXXiNX8bgjX4c5CHyg+xjFxzVhsFm6ptgkOoMLIEbHs2vjHpvsgspX0btfg
 7JV0zX9h1mc2B837GMkb9x3Yh+OyBd8jhhykxfYs=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5A60A604B4
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
 <6543ad5c-bbcf-b3ec-332c-115e8e3d0825@codeaurora.org>
 <1b7d4c2f-98f7-4b80-4e32-6e0fe5c906ce@arm.com>
From: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Message-ID: <7a82a0c1-a449-f062-0cc3-944102472fb0@codeaurora.org>
Date: Fri, 18 Jan 2019 17:38:25 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1b7d4c2f-98f7-4b80-4e32-6e0fe5c906ce@arm.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190118_040835_006457_57F55310 
X-CRM114-Status: GOOD (  13.53  )
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

On 1/18/2019 5:34 PM, Suzuki K Poulose wrote:
> If you would like to use the scatter-gather mode, you must specify it
> explicitly. We have had some other boards with broken scatter-gather
> mode integration which causes mysterious issues when used. So we have
> a white-list approach for enabling the scatter-gather mode in the driver.
> 
> So, if you have tested to make sure that the mode works fine with a recent
> kernel version (v4.19 onwards), you may want to add the property.
> 
> Suzuki
> 

Will add scatter-gather and post v3 soon for both SDM845 and MSM8996.

Thanks,
Sai
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
