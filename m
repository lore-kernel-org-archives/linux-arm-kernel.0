Return-Path: <SRS0=B2vk=P6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CA76C282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 13:43:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CA5B20879
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 13:43:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="M+p8ttXC";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="kKT1dETN";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="MAN6vjpV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CA5B20879
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=3iopjkGXBV3QN72WCRal9fW9AM3Vq6xsjlGfWgzMySQ=; b=M+p8ttXCZSqfjRhJ3CLeqNM8/
	WjQfBur2LcqaTtxmkIKY4UuLpWFgKTqwDCZW9AFb+ulUjXQgFktJkXxpAy0A06utID7z3PDtNVZW0
	0Lc5ZGpt/PWMIC216eLcIbo0X7SW6Rcrv08pfaY6/v7iBVDabA/IHBx+lZXi0jdAqyhQG8wHH6bNK
	x7jHDInsKDmk2Ms9ypJZHixWwRR4Sty/0D9hOKXJ0pTViV/BX96SQcbPDfO/KnmgrLmTQGocBco0Y
	4a2gFlq0X6/3zvQ+JaQa4qiJZCq74GCld0nwTH1jVp0W9bBcHawUTa7X7Rmqdz4AWhMaJrRbYOyDq
	0DjBKQW9A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glwKo-0000q6-M2; Tue, 22 Jan 2019 13:43:22 +0000
Received: from smtp.codeaurora.org ([198.145.29.96])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glwKj-0000nH-Ke
 for linux-arm-kernel@lists.infradead.org; Tue, 22 Jan 2019 13:43:20 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
 id 4B94E60C68; Tue, 22 Jan 2019 13:43:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1548164597;
 bh=t9oCec/gWTXaMpJdxDp9S6sq0yovyApjlUqU66yj8x4=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=kKT1dETN9WTwLJeXVyc/2QNLW+ImfiBhJPHFIH97Tqh57h/HKgKGnhXG3zsKMF3KR
 xUN2MCducf40A9EBmAMHYEbcnMQHjWIA6ZURi2QE3+vBCKbICBSZSp0x7MANf62W+0
 Dh4PLk1yrnaf3/MTa0LiQFt+CvTTdLYMKzWaeKjU=
Received: from [192.168.1.100] (unknown [157.49.207.12])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: saiprakash.ranjan@smtp.codeaurora.org)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id 82D1760854;
 Tue, 22 Jan 2019 13:43:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1548164593;
 bh=t9oCec/gWTXaMpJdxDp9S6sq0yovyApjlUqU66yj8x4=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=MAN6vjpV4HcqM9hBhNROy2bxn4O9myQl32uvlRGDk1tBbKH4aCOtLhFCKz03FVTkW
 OF4slqR7jD+BsKG6lZGQX2sZ7guwBJyeutySUzk2ysORyOXWSpvcXS3AMXxWs8FbhL
 icEQtrSZircVdCuUlfjWIF37sz9SzjkV0UlbEf/Q=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 82D1760854
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none
 smtp.mailfrom=saiprakash.ranjan@codeaurora.org
Subject: Re: [PATCHv3 3/4] coresight: etm4x: Add support to enable ETMv4.2
To: Mathieu Poirier <mathieu.poirier@linaro.org>,
 Vivek Gautam <vivek.gautam@codeaurora.org>
References: <cover.1547813804.git.saiprakash.ranjan@codeaurora.org>
 <d52546764f8570e8c07ac8e3e2841e087e66648c.1547813804.git.saiprakash.ranjan@codeaurora.org>
 <cc71cfa9-8a11-9356-ac41-e27564a9f7b4@codeaurora.org>
 <20190121184831.GB14049@xps15>
 <CANLsYkw5h+-fWhiit+kNJHnGPF__Bz1MHc94sG=WOyfTPHi_NQ@mail.gmail.com>
From: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Message-ID: <6824138d-fa5f-0bec-d5f7-9c10d9a40948@codeaurora.org>
Date: Tue, 22 Jan 2019 19:13:04 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CANLsYkw5h+-fWhiit+kNJHnGPF__Bz1MHc94sG=WOyfTPHi_NQ@mail.gmail.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190122_054317_993987_5E561463 
X-CRM114-Status: GOOD (  21.53  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 Rajendra Nayak <rnayak@codeaurora.org>,
 Suzuki K Poulose <suzuki.poulose@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-arm-msm <linux-arm-msm@vger.kernel.org>,
 Doug Anderson <dianders@chromium.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 David Brown <david.brown@linaro.org>, Rob Herring <robh+dt@kernel.org>,
 Sibi Sankar <sibis@codeaurora.org>, Leo Yan <leo.yan@linaro.org>,
 Andy Gross <andy.gross@linaro.org>, Stephen Boyd <sboyd@kernel.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 1/22/2019 3:07 AM, Mathieu Poirier wrote:
> On Mon, 21 Jan 2019 at 11:48, Mathieu Poirier
> <mathieu.poirier@linaro.org> wrote:
>>
>> On Mon, Jan 21, 2019 at 04:18:36PM +0530, Vivek Gautam wrote:
>>>
>>> On 1/18/2019 5:52 PM, Sai Prakash Ranjan wrote:
>>>> SDM845 has ETMv4.2 and can use the existing etm4x driver.
>>>> But the current etm driver checks only for ETMv4.0 and
>>>> errors out for other etm4x versions. This patch adds this
>>>> missing support to enable SoC's with ETMv4x to use same
>>>> driver by checking only the ETM architecture major version
>>>> number.
>>>>
>>>> Without this change, we get below error during etm probe:
>>>>
>>>> / # dmesg | grep etm
>>>> [    6.660093] coresight-etm4x: probe of 7040000.etm failed with error -22
>>>> [    6.666902] coresight-etm4x: probe of 7140000.etm failed with error -22
>>>> [    6.673708] coresight-etm4x: probe of 7240000.etm failed with error -22
>>>> [    6.680511] coresight-etm4x: probe of 7340000.etm failed with error -22
>>>> [    6.687313] coresight-etm4x: probe of 7440000.etm failed with error -22
>>>> [    6.694113] coresight-etm4x: probe of 7540000.etm failed with error -22
>>>> [    6.700914] coresight-etm4x: probe of 7640000.etm failed with error -22
>>>> [    6.707717] coresight-etm4x: probe of 7740000.etm failed with error -22
>>>>
>>>> With this change, etm probe is successful:
>>>>
>>>> / # dmesg | grep coresight
>>>> [    6.659198] coresight-etm4x 7040000.etm: CPU0: ETM v4.2 initialized
>>>> [    6.665848] coresight-etm4x 7140000.etm: CPU1: ETM v4.2 initialized
>>>> [    6.672493] coresight-etm4x 7240000.etm: CPU2: ETM v4.2 initialized
>>>> [    6.679129] coresight-etm4x 7340000.etm: CPU3: ETM v4.2 initialized
>>>> [    6.685770] coresight-etm4x 7440000.etm: CPU4: ETM v4.2 initialized
>>>> [    6.692403] coresight-etm4x 7540000.etm: CPU5: ETM v4.2 initialized
>>>> [    6.699024] coresight-etm4x 7640000.etm: CPU6: ETM v4.2 initialized
>>>> [    6.705646] coresight-etm4x 7740000.etm: CPU7: ETM v4.2 initialized
>>>>
>>>> Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
>>>> ---
>>>>    drivers/hwtracing/coresight/coresight-etm4x.c | 2 +-
>>>>    drivers/hwtracing/coresight/coresight-etm4x.h | 2 +-
>>>>    2 files changed, 2 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/hwtracing/coresight/coresight-etm4x.c b/drivers/hwtracing/coresight/coresight-etm4x.c
>>>> index 53e2fb6e86f6..93d5f1f3145e 100644
>>>> --- a/drivers/hwtracing/coresight/coresight-etm4x.c
>>>> +++ b/drivers/hwtracing/coresight/coresight-etm4x.c
>>>> @@ -55,7 +55,7 @@ static void etm4_os_unlock(struct etmv4_drvdata *drvdata)
>>>>    static bool etm4_arch_supported(u8 arch)
>>>>    {
>>>> -   switch (arch) {
>>>> +   switch (arch >> 4) {
>>>
>>>
>>> While this looks good, from what it looks like arch is a combination of
>>> major version
>>> minor version. So, will it be better to masks, and shifts macros instead of
>>> a magic
>>> number shift.
>>> But, frankly it's upto Mathieu to decide the readability of this. So, I
>>> leave it to him.
>>
>> The layout of the architecture is already well defined in etm4_init_arch_data()
>> [1].  As such just doing the following would be fine with me:
>>
>>          /* Mask out the minor version nuber */
>>          switch (arch & 0xf) {
> 
> s/0xf/0xf0
> 
> Apologies for the confusion.
> 

Thanks Mathieu, made this change in v4 of this series.

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
