Return-Path: <SRS0=p0aQ=P2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7514C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 02:58:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 809362087E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 02:58:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ELrcZOys";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="BR/2GLE5";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Nb1SWz9z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 809362087E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=JT889VIu0vv08LzxRUpwuBh93Z3IrQdoBRtGoHs266A=; b=ELrcZOys06igVxaggMM+Ufy4i
	/Rp2ZYXtKEfzL4xWqMnrPzMzeRh8spDhU57fVq2+gOryJ79qpJHQBdggYPQAO2x3Io6bIyk27PxaF
	eNbwiBw5Uxz00AyX1/wxvEWHEi1khtBUEIxqt8D8FYtap1qfHqwKZnZw/440EyCdkuLyI95KmFjkw
	MdlN4UpS5XDF2+IwjEqOa+jFoRbjY/WvPob1LzmiV05kjvDFd2+Kxq41N7SN+4eT0OG6Us8X7jYkr
	ALcwP4CU+EeIEzmtjlkiB5hmIIOY1YguebDJ9RhlE2DwwpeyFGkCWC5eBG0yF/INSp2S6qGaRC7Wb
	jGSWaoGTQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkKMw-0001rv-Pk; Fri, 18 Jan 2019 02:58:54 +0000
Received: from smtp.codeaurora.org ([198.145.29.96])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkKMt-0001rZ-5V
 for linux-arm-kernel@lists.infradead.org; Fri, 18 Jan 2019 02:58:52 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
 id 7FFBC60854; Fri, 18 Jan 2019 02:58:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1547780330;
 bh=CSkykrvA55vjxsZCmu5sLXiMDCi4xY1mk5bDpqWwcMI=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=BR/2GLE5kjnm9wr8N9v9a2R+30dlysrr+Xs6LPPi24wlCiaNe3eGVaZkZea620yGX
 cXY4rQmtxBpoO8J0nSRl5E4cglth7YtFl0A6z5eLuV3ZsrpgSXaq3xMTTpS3hb2e4k
 SXdh4feyACzVUZ5I8YUr/o0nEgOo71oDRx4azVKU=
Received: from [10.79.129.0]
 (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: saiprakash.ranjan@smtp.codeaurora.org)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id 7A76D605A0;
 Fri, 18 Jan 2019 02:58:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1547780329;
 bh=CSkykrvA55vjxsZCmu5sLXiMDCi4xY1mk5bDpqWwcMI=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=Nb1SWz9zMPeWfrb/1qfQjUr/E1V/IifhFw6rMJ8IKG7uO9ydvLXqNTxuilcoodgYS
 rKnzUyHCnoHKzlzRwkAhkJRvLXxX781zv76uMA88P8KAg1RSXEGeb0H/fBW7C+BQla
 bmhW+R/NePvXnxrTXM+CiTyZuOs8s9Sh2yIthAKw=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7A76D605A0
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none
 smtp.mailfrom=saiprakash.ranjan@codeaurora.org
Subject: Re: [PATCHv2] watchdog: qcom: Add suspend/resume support
To: Guenter Roeck <linux@roeck-us.net>
References: <20190117151942.6092-1-saiprakash.ranjan@codeaurora.org>
 <20190117181603.GA14800@roeck-us.net>
From: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Message-ID: <bae21498-32be-6842-adce-1fc5b9c7e263@codeaurora.org>
Date: Fri, 18 Jan 2019 08:28:44 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190117181603.GA14800@roeck-us.net>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190117_185851_234877_47F2969F 
X-CRM114-Status: GOOD (  11.37  )
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
 Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org,
 Doug Anderson <dianders@chromium.org>, linux-kernel@vger.kernel.org,
 Sibi Sankar <sibis@codeaurora.org>, Vivek Gautam <vivek.gautam@codeaurora.org>,
 Guenter Roeck <groeck@chromium.org>, Wim Van Sebroeck <wim@linux-watchdog.org>,
 linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 1/17/2019 11:46 PM, Guenter Roeck wrote:
> On Thu, Jan 17, 2019 at 08:49:42PM +0530, Sai Prakash Ranjan wrote:
>> This adds the support for qcom watchdog suspend and resume
>> when entering and exiting deep sleep states. Otherwise
>> having watchdog active after suspend would result in unwanted
>> crashes/resets if resume happens after a long time.
>>
>> Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
> 
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> 

Thanks Guenter. Should I send a v3 with your reviewed-by?

- Sai
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
