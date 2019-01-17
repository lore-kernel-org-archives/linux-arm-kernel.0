Return-Path: <SRS0=6Gta=PZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 022E6C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 10:39:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C198120851
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 10:39:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="BKvRPoJk";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="TqsTivjY";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="TqsTivjY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C198120851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=xLBHSwlR4c2C7mNnpi7p8iYyQDb34W8mlULBd9LFwYk=; b=BKvRPoJkQNliJIO/Nd6MGCvjP
	Fvj/FiZ9GUl1Wj4RZBdEQmVz9sCZ2JSFN4jXASvm58wHZSwgJU8tWIkR9Wj+gzsrSkms7crKdBpQD
	Yy6Xk1n+XCO3/e0EwYeFnEDHbklBvZUeDQiqgOqHn9HxXUjfCZqsHcEDWzY03WJYkA1p+fAXZpnIQ
	mBPW0j45nNTGwhZtxGvkwniS9nUcfWrI1KwONGHONlgzjqRk8W4tE5+9VwLFpCXUYSnUN8ILL84ll
	tokcwPzCRQGUSniOPiiu3j+L6tXnYIrdVSNZrlqhnX+wMD4NT1auhSwbb5FMuin2q7turJt0te+F/
	/2IWojgPQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gk54g-00022j-Lk; Thu, 17 Jan 2019 10:39:02 +0000
Received: from smtp.codeaurora.org ([198.145.29.96])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gk54d-00022D-T6
 for linux-arm-kernel@lists.infradead.org; Thu, 17 Jan 2019 10:39:01 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
 id AC7B7607DD; Thu, 17 Jan 2019 10:38:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1547721538;
 bh=Qavo8mmtgJddz2ii2CbmcaSj9WDDVzTXexKEQj41nCA=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=TqsTivjYgfgg/tJuNEWhxrbIHcpU+HDyurK/L2f4mdlzoSVSW+0U9LICjsPUbOOkJ
 aWU8foc1i+sRrgdzzOcbdcu8WodEVsRxl+6zVYKPGgwWrSRzZANWh1K66Ii0tjmf4N
 BCIoqmIrqBP2aNR1LTyNcmUlAIm5TUTnks6kG2xM=
Received: from [10.79.128.65]
 (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: saiprakash.ranjan@smtp.codeaurora.org)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id 4BBF36024C;
 Thu, 17 Jan 2019 10:38:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1547721538;
 bh=Qavo8mmtgJddz2ii2CbmcaSj9WDDVzTXexKEQj41nCA=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=TqsTivjYgfgg/tJuNEWhxrbIHcpU+HDyurK/L2f4mdlzoSVSW+0U9LICjsPUbOOkJ
 aWU8foc1i+sRrgdzzOcbdcu8WodEVsRxl+6zVYKPGgwWrSRzZANWh1K66Ii0tjmf4N
 BCIoqmIrqBP2aNR1LTyNcmUlAIm5TUTnks6kG2xM=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4BBF36024C
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none
 smtp.mailfrom=saiprakash.ranjan@codeaurora.org
Subject: Re: [PATCH] watchdog: qcom: Add suspend/resume support
To: Brian Masney <masneyb@onstation.org>
References: <20190117091555.2018-1-saiprakash.ranjan@codeaurora.org>
 <20190117093113.GA23389@basecamp>
From: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Message-ID: <91108b9b-fe05-1068-b07e-872cb4cd4012@codeaurora.org>
Date: Thu, 17 Jan 2019 16:08:52 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190117093113.GA23389@basecamp>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190117_023859_961866_0ED93676 
X-CRM114-Status: GOOD (  13.78  )
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

Hi Brian,

On 1/17/2019 3:01 PM, Brian Masney wrote:
> 
> You can use the __maybe_unused attribute to remove the #ifdef:
> 
> static int __maybe_unused qcom_wdt_suspend(struct device *dev)
> 

Thanks for looking into this.

As for __maybe_unused, I think it's better to keep #ifdef rather than
this attribute which seems to be meaning unused when actually its 
possible that it's used often(PM_SLEEP is def y). It's like saying 
unused when you are actually using it. The attribute seems like a
hack to avoid compilation error. Please correct me if I am wrong.

  - Sai
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
