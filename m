Return-Path: <SRS0=6Gta=PZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7940CC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 15:07:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A0AF20855
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 15:07:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="J9mbb8fX";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="n3upj/q5";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="GLFI0x/V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A0AF20855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=V98lD2wJdhDJ6N49IS/nY/l4dSj9ZypHHs7jZTyrxpY=; b=J9mbb8fXSTJa7uS+Bq35fvqEJ
	zmRJmzKirP1cO9hZT6QU9j4Rj9iwymbgpDCvoAK0rVXsYX6Qx91jgwsNVPVNLEzihrp0wvT9TDIwt
	sDp2h605XmKPnZ32lKxLqVFjc379wF8SAY7rivepgb3nD7knUIPm/Rt4vsu4xjody9926Mr2NDXjq
	8xRgVTbqp3eMi85dMm8yT7gAxrRKj1eSjkHsKSRnaVwejIzkydnfCOSl5jL0YLZ6Lr2apqyO3xUGQ
	kC9QwFhNBpdSJh0JV+DNeqLQfqkE3YlsT+4eYIAlBdPQqqoHtERmHF/CRNURPSXb9Pv3QOLe9vXnf
	gSRY+bSdQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gk9GP-0000Ou-4O; Thu, 17 Jan 2019 15:07:25 +0000
Received: from smtp.codeaurora.org ([198.145.29.96])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gk9GL-0000Gh-JJ
 for linux-arm-kernel@lists.infradead.org; Thu, 17 Jan 2019 15:07:22 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
 id 020CD601B4; Thu, 17 Jan 2019 15:07:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1547737641;
 bh=B94wqvUG1zQiQ7J/DXu6pKDX2bWVrpTumpBEZo9Wp8U=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=n3upj/q5AHlbdPJ8EHdOfiGoHJSfGM87KCD1c1f1VfoS+2G9AV0i9fP+qKasiEocy
 mxOjSmJ97A36w/9Su610VExcfFEv+fFSP7cKjZfmDjOY42BJT5VyHGDWBwHQeEtedk
 ShF/p2RXRLgPNwjgf3S18Xdo+VSCrhIJ4tJoSuWI=
Received: from [192.168.1.100] (unknown [157.45.228.214])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: saiprakash.ranjan@smtp.codeaurora.org)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id 3F6A5606E1;
 Thu, 17 Jan 2019 15:07:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1547737640;
 bh=B94wqvUG1zQiQ7J/DXu6pKDX2bWVrpTumpBEZo9Wp8U=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=GLFI0x/VM/jnJ/w/1V3u4xcNCtHIYPL1ZZVNLW+0TJi8ihJEV44fa1DcA5ITAKBvT
 U+DJQiVvYOalcaD0XZuEYcclzmtQ5Pd10S8oyO4m9KhZcKLuYVlH9EK75hApzO7PkU
 pKoiKCT+CwPnghjsYx3LETSIBKre0XGpr858qTzY=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3F6A5606E1
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none
 smtp.mailfrom=saiprakash.ranjan@codeaurora.org
Subject: Re: [PATCH] watchdog: qcom: Add suspend/resume support
To: Guenter Roeck <linux@roeck-us.net>
References: <20190117091555.2018-1-saiprakash.ranjan@codeaurora.org>
 <20190117093113.GA23389@basecamp>
 <91108b9b-fe05-1068-b07e-872cb4cd4012@codeaurora.org>
 <20190117112730.GA25198@basecamp>
 <b9f573ec-3787-2b05-52e3-60f11c061dd7@codeaurora.org>
 <20190117143044.GA30757@roeck-us.net>
From: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Message-ID: <4bd782a4-1534-28bf-78d3-c14b677641b0@codeaurora.org>
Date: Thu, 17 Jan 2019 20:37:10 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190117143044.GA30757@roeck-us.net>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190117_070721_653578_41DD3B4E 
X-CRM114-Status: GOOD (  11.73  )
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
Cc: Rajendra Nayak <rnayak@codeaurora.org>, linux-watchdog@vger.kernel.org,
 Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
 Doug Anderson <dianders@chromium.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 Sibi Sankar <sibis@codeaurora.org>, Vivek Gautam <vivek.gautam@codeaurora.org>,
 linux-arm-msm@vger.kernel.org, Guenter Roeck <groeck@chromium.org>,
 Wim Van Sebroeck <wim@linux-watchdog.org>,
 linux-arm-kernel@lists.infradead.org, Brian Masney <masneyb@onstation.org>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Guenter,

On 1/17/2019 8:00 PM, Guenter Roeck wrote:
> 
> I personally very much prefer __maybe_unused over #ifdef, for the reasons
> stated above. Other maintainers may think differently.
> 

Thanks for making your preference clear. I will post the second version
soon with the changes.

- Sai
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
