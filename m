Return-Path: <SRS0=6Gta=PZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 961BFC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 13:01:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E11820657
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 13:01:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="taEs9cI/";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="W3Y5E5SZ";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="UOWTVvWX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E11820657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=T72dl4pKymDSLmJ43ZA4KjLL5BBzZ2YWqktBBitmZZg=; b=taEs9cI/tC81mxN1ttGsMp4yr
	G0nJjhv38ppr4e9fIy/Z09a1m805QaXljBg6B9I11+1vNA/b8eS1NIkzmAheYTSKRls+1kt8DuXfL
	xD4h5muk+GHmVKZo/yRTiueItL5DIS8fLJuel41WFa8p4a3H/RoeryEKaD7Jel2U24Bu2uRBXwqNA
	Kvc5TmBCjr9WOw3tWJ/FCZaWh6tSB6NMhclnPFtPYjSyyms8uX6r9UN7n4wFSnVTTiWBilhf7Ftt2
	61Y9iPyMA44CS1LG+4YHeuj3Gi3fiWbU1+w02lfTJw+hF8is9fIUjrHWe24+P64OR/vv5yG1u40ma
	L2MX4KgRQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gk7IN-0004EB-Ja; Thu, 17 Jan 2019 13:01:19 +0000
Received: from smtp.codeaurora.org ([198.145.29.96])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gk7Hw-0003qr-19
 for linux-arm-kernel@lists.infradead.org; Thu, 17 Jan 2019 13:00:59 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
 id 700A060807; Thu, 17 Jan 2019 13:00:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1547730051;
 bh=Z2vlCHQaX9hPpwydG9WyKUvmg7ZYlm2Wytwvz3kS4vw=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=W3Y5E5SZ4b86u+yjU6zPgLBzSC2HSQaS+akm7S9JhQtfj3boQYC3G+M2Szr63K6Ta
 a94dk0qcFdMRQurwD6DoWgXVnDrZ/SIjqnszmnxLiTzfmhVJ+iL1XrwTB6wUhuZt94
 X9ATYZcpD7stR+ghyd74OhuiMFeGCcX+rdETfXa4=
Received: from [192.168.43.47] (unknown [106.193.6.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: saiprakash.ranjan@smtp.codeaurora.org)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id 700EE6053B;
 Thu, 17 Jan 2019 13:00:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1547730050;
 bh=Z2vlCHQaX9hPpwydG9WyKUvmg7ZYlm2Wytwvz3kS4vw=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=UOWTVvWXExdPIS5ZaKGB+GKYWDcRiB1O2ZGZItmOlwkj3Sdrd0AxmWOMODLLX/AB5
 bBIg0stevM853SzYZhQEdRN5vXPf7dmHP+dy4Uw2/tIiMLPjvwEJE3L1R7atYwEJom
 ZyuUufrTaOjCwwYYg2pXdc5IsGNdn0xxmO9c6y0g=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 700EE6053B
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none
 smtp.mailfrom=saiprakash.ranjan@codeaurora.org
Subject: Re: [PATCH] watchdog: qcom: Add suspend/resume support
To: Brian Masney <masneyb@onstation.org>
References: <20190117091555.2018-1-saiprakash.ranjan@codeaurora.org>
 <20190117093113.GA23389@basecamp>
 <91108b9b-fe05-1068-b07e-872cb4cd4012@codeaurora.org>
 <20190117112730.GA25198@basecamp>
From: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Message-ID: <b9f573ec-3787-2b05-52e3-60f11c061dd7@codeaurora.org>
Date: Thu, 17 Jan 2019 18:30:41 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190117112730.GA25198@basecamp>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190117_050052_313256_E53FB427 
X-CRM114-Status: GOOD (  23.59  )
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
Cc: linux-arm-kernel@lists.infradead.org,
 Rajendra Nayak <rnayak@codeaurora.org>, linux-watchdog@vger.kernel.org,
 Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
 Doug Anderson <dianders@chromium.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 Sibi Sankar <sibis@codeaurora.org>, Vivek Gautam <vivek.gautam@codeaurora.org>,
 linux-arm-msm@vger.kernel.org, Guenter Roeck <groeck@chromium.org>,
 Wim Van Sebroeck <wim@linux-watchdog.org>, Guenter Roeck <linux@roeck-us.net>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 1/17/2019 4:57 PM, Brian Masney wrote:
> 
> That attribute suppresses a warning from the compiler if the function is
> unused when PM_SLEEP is disabled.  I don't consider it hackish since the
> function name no longer appears outside the #ifdef. For example:
> 
> 	#ifdef CONFIG_PM_SLEEP
> 	static int qcom_wdt_suspend(struct device *dev)
> 	{
> 		...
> 	}
> 	#endif /* CONFIG_PM_SLEEP */
> 
> 	static SIMPLE_DEV_PM_OPS(..., qcom_wdt_suspend, ...);
> 
> SIMPLE_DEV_PM_OPS (actually SET_SYSTEM_SLEEP_PM_OP) includes the check
> for PM_SLEEP and its a noop if PM_SLEEP is disabled so this works.
> 
> Now here's the code with __maybe_unused:
> 
> 	static int __maybe_unused qcom_wdt_suspend(struct device *dev)
> 	{
> 		...
> 	}
> 
> 	static SIMPLE_DEV_PM_OPS(..., qcom_wdt_suspend, ...);
> 
> This will still be a NOOP when power management is disabled, but have
> the benefit of increased compile-time test coverage in that situation.
> The symbols won't be included in the final executable. I personally
> think the code a is cleaner with __maybe_unused.
> 
> This pattern is already in use across various subsystems in the kernel
> for suspend and resume functions:
> 
> $ git grep __maybe_unused | egrep "_suspend|_resume"  | wc -l
> 767
> 

Thanks for the explanation Brian.

But I did see the maybe_unused attribute usage in other suspend and 
resume functions before posting and decided to go with ifdef because
I think this attribute wastes CPU time by building and later discarding 
if the function is unused (it may be negligible).

I did not understand the increased compile-time test coverage
you mentioned when PM_SLEEP=n because why would we need to compile
when the config is disabled? We could just discard it. We would just
increase the build time with this attribute (although for this case it 
would be negligible but say we compile with PM_SLEEP disabled for all 
those suspend/resume functions with maybe_unused attribute).

Looking at previous discussions in LKML[1] as to why the pm 
suspend/resume functions used __maybe_unused seemes to be because of
wrong ifdef usage. For ex: Using #ifdef CONFIG_PM instead of
#ifdef CONFIG_PM_SLEEP would result in a warning when
CONFIG_PM_SLEEP=n but CONFIG_PM=y.

Anyways, *I am OK with either of them*, after some more review on the
patch I can make the change in next version of the patch.

[1] https://lore.kernel.org/patchwork/patch/732981/

- Sai
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
