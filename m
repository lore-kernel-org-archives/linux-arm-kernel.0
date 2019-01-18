Return-Path: <SRS0=p0aQ=P2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E3DDC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 04:25:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A93220855
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 04:25:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="SeGQD/uv";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="LFVyLszD";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="RLZGz5Ob"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A93220855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=ZajY6GtU1arrcQ/F6M9moj7a5C9KM/9X6AKHlihMyc8=; b=SeGQD/uvw4jip33KCRdR4A+Zj
	1TMln1uZzJP2c4Kw2+tmo7Z8Zk1lno8+2Cd1HATuamHs3RIpMllJE5/r5jBUx6Wj6i1U9XwB4tCok
	Dyb9Dt5CxtenDFohb1NVkXLKqKwWp6XuzhAroiVjZMr8kg5HHE+V2TpcMi6rks3iHtqQx0vSJkOgv
	mRZFkZWH6qwzaTBV/VZkEvDoQAfQS5ekKshl0n0Tf/uTGrRorY01IqoOLRkJkyzm8Z8NeYzpMXRp8
	6ri5PMmIlnWgdY3yGuO/UQKCmIfVfSINPm+UiNsmkJMKpnPpbxX5m+MbwfQqugXzkmkfC9gaplQK2
	sHrQJRBWg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkLig-0006Bd-Po; Fri, 18 Jan 2019 04:25:26 +0000
Received: from smtp.codeaurora.org ([198.145.29.96])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkLid-0006BB-Kj
 for linux-arm-kernel@lists.infradead.org; Fri, 18 Jan 2019 04:25:24 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
 id 9745E60854; Fri, 18 Jan 2019 04:25:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1547785522;
 bh=zxdnncJvdfjdoXVz+A3Xi39ceyRU/E+klUDVEQZ4emg=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=LFVyLszDEMrcknMKOZeM6b54rIChsDyn9gwd1AX0H9Fz0CPTJFvCLFpOTVzzy1q+3
 hwzfPGCimXVkWx6auqNUsj4yxy2s3G6rx6Evf4mJfzGEgfW0YsUiuq3OuXdEicaZyy
 aAXi8UQRnv9Y8bBOHRv/Py7Pp+ulTtUGp7yg0qkI=
Received: from [10.79.129.0]
 (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: saiprakash.ranjan@smtp.codeaurora.org)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id DB36660734;
 Fri, 18 Jan 2019 04:25:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1547785520;
 bh=zxdnncJvdfjdoXVz+A3Xi39ceyRU/E+klUDVEQZ4emg=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=RLZGz5ObjbK2akWBSTMikndWPAZAVKCFVsndNNlhdSCdLNXdagBgoQ/rXWjpA291i
 qEEhG3BC+xrdT7XPsHI/Lv0E0Ww3pe1AoGYSZ3Tbkwg2OzC5ug5vGoRQanoYkR2PmK
 8fOh8XQDwkbVI+2bzsLq+13RZq+/6/yvcVuIABrM=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DB36660734
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none
 smtp.mailfrom=saiprakash.ranjan@codeaurora.org
Subject: Re: [PATCHv2] watchdog: qcom: Add suspend/resume support
To: Guenter Roeck <linux@roeck-us.net>
References: <20190117151942.6092-1-saiprakash.ranjan@codeaurora.org>
 <20190117181603.GA14800@roeck-us.net>
 <bae21498-32be-6842-adce-1fc5b9c7e263@codeaurora.org>
 <a10264b5-74a2-2d80-a523-2ab1f4ca02b9@roeck-us.net>
From: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Message-ID: <93e399e9-06ec-e695-54c4-71b6a22f0f29@codeaurora.org>
Date: Fri, 18 Jan 2019 09:55:14 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <a10264b5-74a2-2d80-a523-2ab1f4ca02b9@roeck-us.net>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190117_202523_766592_FE7D914B 
X-CRM114-Status: GOOD (  13.23  )
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

On 1/18/2019 9:23 AM, Guenter Roeck wrote:
> On 1/17/19 6:58 PM, Sai Prakash Ranjan wrote:
>> On 1/17/2019 11:46 PM, Guenter Roeck wrote:
>>> On Thu, Jan 17, 2019 at 08:49:42PM +0530, Sai Prakash Ranjan wrote:
>>>> This adds the support for qcom watchdog suspend and resume
>>>> when entering and exiting deep sleep states. Otherwise
>>>> having watchdog active after suspend would result in unwanted
>>>> crashes/resets if resume happens after a long time.
>>>>
>>>> Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
>>>
>>> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
>>>
>>
>> Thanks Guenter. Should I send a v3 with your reviewed-by?
>>
> 
> I add it to my watchdog-next branch and Wim will pick it up from there.
> No need to resend.
> 

Ok thanks.

- Sai

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
