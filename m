Return-Path: <SRS0=6Gta=PZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D4E0C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 15:26:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EFAFE20652
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 15:26:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="devkOo3B";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="AHvhLIpX";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="AHvhLIpX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFAFE20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=EizCfz1K6k+PxM4rMy9jnEcfKGdKqr/CyUwsWYPjD4c=; b=devkOo3Bu+QNWWlV+5bn2snYq
	8yo0bw3E+nVGsFEXlwopF5Ywrs5XvIcHrjteF/n0ZPSJNBFXC3ILki+1i5elZAc53C3IWqzX1nlyq
	WIrOqSXD9dXGtWX695FY6n2tCXqSLS9ES0ZbXwgQDh7stJxEewLjbvifAuke4yrkxf1JmbtEtwJiN
	SCk5F9vI/aHrVnxgBCUnc927MToyAFeI66fPorpwntL4Oi9mpD+tOiMw59hKqDDkzHA79BOhgXQfq
	oBEbcsZEjLVXSok6Z0JwCZ/TyWo7F1V3HkGtmv/vMmhfCDgOiaNFA/DKY8Fgwtt0x1c1Q4DBoCYSl
	L4hlVnENQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gk9Z4-0001ab-GT; Thu, 17 Jan 2019 15:26:42 +0000
Received: from smtp.codeaurora.org ([198.145.29.96])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gk9Z2-0001aD-45
 for linux-arm-kernel@lists.infradead.org; Thu, 17 Jan 2019 15:26:41 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
 id B80E96055C; Thu, 17 Jan 2019 15:26:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1547738799;
 bh=Eh7BZcnU83UYilT74nCSDcWVEqhPxCKF44S8khxhtKw=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=AHvhLIpXUEUCXN9Wp1xuh51lwlGqkJm+YJ+/6wPmn7MjYPTvYaKXD0l54EpnIgWjg
 ZuCtWaNKVrckfUitnqjanIbWmkKOrjhMjEgt4IiprInTS3SJmUNQHFUOdedq4zQMKY
 4QR3FM5DvBK4q5qCtjK5pk2fpBLk3fHiYaAzmDrQ=
Received: from [192.168.1.100] (unknown [157.45.228.214])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: saiprakash.ranjan@smtp.codeaurora.org)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id 02B336053B;
 Thu, 17 Jan 2019 15:26:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1547738799;
 bh=Eh7BZcnU83UYilT74nCSDcWVEqhPxCKF44S8khxhtKw=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=AHvhLIpXUEUCXN9Wp1xuh51lwlGqkJm+YJ+/6wPmn7MjYPTvYaKXD0l54EpnIgWjg
 ZuCtWaNKVrckfUitnqjanIbWmkKOrjhMjEgt4IiprInTS3SJmUNQHFUOdedq4zQMKY
 4QR3FM5DvBK4q5qCtjK5pk2fpBLk3fHiYaAzmDrQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 02B336053B
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none
 smtp.mailfrom=saiprakash.ranjan@codeaurora.org
Subject: Re: [PATCHv2] watchdog: qcom: Add suspend/resume support
To: Guenter Roeck <linux@roeck-us.net>, Brian Masney <masneyb@onstation.org>, 
 Wim Van Sebroeck <wim@linux-watchdog.org>, linux-watchdog@vger.kernel.org, 
 Guenter Roeck <groeck@chromium.org>
References: <20190117151942.6092-1-saiprakash.ranjan@codeaurora.org>
From: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Message-ID: <747da233-8b8c-2aa9-59cf-542ab46cc161@codeaurora.org>
Date: Thu, 17 Jan 2019 20:56:31 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190117151942.6092-1-saiprakash.ranjan@codeaurora.org>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190117_072640_184189_1310730C 
X-CRM114-Status: GOOD (  13.70  )
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
Cc: Rajendra Nayak <rnayak@codeaurora.org>, Stephen Boyd <sboyd@kernel.org>,
 linux-arm-msm@vger.kernel.org, Doug Anderson <dianders@chromium.org>,
 linux-kernel@vger.kernel.org, Sibi Sankar <sibis@codeaurora.org>,
 Vivek Gautam <vivek.gautam@codeaurora.org>,
 linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 1/17/2019 8:49 PM, Sai Prakash Ranjan wrote:
> This adds the support for qcom watchdog suspend and resume
> when entering and exiting deep sleep states. Otherwise
> having watchdog active after suspend would result in unwanted
> crashes/resets if resume happens after a long time.
> 
> Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
> 
> ---
> 
> v2:
>   * Use __maybe_unused instead of #ifdef as suggested by
>     Brian and Guenter
> ---
>   drivers/watchdog/qcom-wdt.c | 23 +++++++++++++++++++++++
>   1 file changed, 23 insertions(+)
> 
> 

Adding Brian.
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
