Return-Path: <SRS0=pdKw=QA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4509C282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 11:20:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2562218AF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 11:20:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="W0hXt+Xw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2562218AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Kx7/keriMs9sYnPTQn0fWfy6b/gdfjb+59rOfvkwrAg=; b=W0hXt+Xwq0JcPROy6XDfj1CJn
	wouFOCWc+rHfIt+ipJBEMNgeAzDgwecFXVgP9MEe61ESMNtBbsPAIQY3lSY52Bukl+eYG9RUjEK0Q
	vKwkt3/ybctCu5RPR2lzaGD2mKNT289UeCDkebnFb3Rp21tDGgochkrWh6viPo0SWxI+PXjBplctV
	8EmrFKuHAn7OuOy9XRvs1BLIMsGG6GTgcgYAaTP0kZdy/k1q2qk6ipfPj6rk63HclLQZ+EHFplisK
	q51OWA+d3YOr7Tli53kT29T3nMPUWwa7XYYFSvDVAxU6cpFgcNFi/m+3vk2+RM6sC/3lp4vDGWLf0
	w9cB5UPhw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmd39-000564-Jh; Thu, 24 Jan 2019 11:19:59 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmd36-00055F-I3
 for linux-arm-kernel@lists.infradead.org; Thu, 24 Jan 2019 11:19:57 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 299191596;
 Thu, 24 Jan 2019 03:19:54 -0800 (PST)
Received: from [10.1.196.93] (en101.cambridge.arm.com [10.1.196.93])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DBBCB3F237;
 Thu, 24 Jan 2019 03:19:50 -0800 (PST)
Subject: Re: [PATCHv4 1/4] arm64: dts: qcom: sdm845: Add Coresight support
To: saiprakash.ranjan@codeaurora.org, robh+dt@kernel.org,
 mathieu.poirier@linaro.org, leo.yan@linaro.org,
 alexander.shishkin@linux.intel.com, andy.gross@linaro.org,
 david.brown@linaro.org, vivek.gautam@codeaurora.org, dianders@chromium.org,
 sboyd@kernel.org, bjorn.andersson@linaro.org, devicetree@vger.kernel.org,
 mark.rutland@arm.com
References: <cover.1548133311.git.saiprakash.ranjan@codeaurora.org>
 <ad16cfb9b6f5efb85149458d5f5a1abf43fa027c.1548133311.git.saiprakash.ranjan@codeaurora.org>
 <1bd39862-0725-70ce-6535-fdb59569f683@arm.com>
 <75ed74af-6946-b86d-092e-42dc16e55308@codeaurora.org>
 <91a90daa-9e14-2d2e-e633-2ddfdc0955bf@arm.com>
 <3906faf1-abbd-9c28-ad55-ed3800f06352@codeaurora.org>
 <c03b63bf-aca8-ea46-70ad-ee4558f0319e@arm.com>
 <5b54c6e0-7d22-ecee-486f-31333f49f84a@codeaurora.org>
From: Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <18b70426-60fe-4871-6388-6e09fd5feb37@arm.com>
Date: Thu, 24 Jan 2019 11:19:49 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <5b54c6e0-7d22-ecee-486f-31333f49f84a@codeaurora.org>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190124_031956_602368_9499DED4 
X-CRM114-Status: GOOD (  18.68  )
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
Cc: rnayak@codeaurora.org, linux-arm-msm@vger.kernel.org, John.Horley@arm.com,
 linux-kernel@vger.kernel.org, sibis@codeaurora.org,
 linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Sai,

On 23/01/2019 12:11, Sai Prakash Ranjan wrote:
> Hi Suzuki,
> 
> On 1/23/2019 1:42 AM, Suzuki K Poulose wrote:
>> Hi Sai,
>>
>> On 01/22/2019 04:48 PM, Sai Prakash Ranjan wrote:
>>> Hi Suzuki,
>>>
> [..]
>>>
>>> SDM845 has 4 Kryo 385 Gold (ARM A75) + 4 Kryo 385 Silver (ARM A55),
>>> so the PID values should be same for 4 ETMs atleast. But here one
>>> pid value(001bb803) is same for 6 ETMs and other one for 2
>>> ETMs(001bb802) which seems odd and hence the doubt if these pids
>>> are even valid ones.
>>
>> Have you checked other SoCs with A55 for the ETM PID ? The drivers
>> usually only care about PID0[7-0], PID1[7-0], PID2[3-0] and ignores
>> the other fields that may change over revisions of the core. So, in your
>> case the ETM ID could be treated as 0xbb802 and 0xbb803.
>>
> 
> Very sorry to have mislead you here. I checked again today on SDM845 and
> as you said 4 ETMs based on A75 has 0xbb803 and other 4 ETMs based on
> A55 has 0Xbb803. I wrongly mentioned it as 6 and 2.
> 
> [    6.688809] resname=etm@7040000 pid = 0x1bb803
> [    6.694957]
> [    6.694957] resname=etm@7140000 pid = 0x1bb803
> [    6.701135]
> [    6.701135] resname=etm@7240000 pid = 0x1bb803
> [    6.707256]
> [    6.707256] resname=etm@7340000 pid = 0x1bb803
> [    6.713454]
> [    6.713454] resname=etm@7440000 pid = 0x1bb802
> [    6.719621]
> [    6.719621] resname=etm@7540000 pid = 0x1bb802
> [    6.725814]
> [    6.725814] resname=etm@7640000 pid = 0x1bb802
> [    6.731971]
> [    6.731971] resname=etm@7740000 pid = 0x1bb802
> 
> So is it ok to add these to table as below in etm4x driver with the
> following comment since these do not exactly match A75 and A55 PIDs
> which you provided? Or any other way you prefer?
> 
> @@ -1079,6 +1079,10 @@ static const struct amba_id etm4_ids[] = {
>           ETM4x_AMBA_ID(0x000bb95a),              /* Cortex-A72 */
>           ETM4x_AMBA_ID(0x000bb959),              /* Cortex-A73 */
>           ETM4x_AMBA_ID(0x000bb9da),              /* Cortex-A35 */
> +       ETM4x_AMBA_ID(0x000f0211),              /* Qualcomm Kryo */
> +       ETM4x_AMBA_ID(0x000f0205),              /* Qualcomm Kryo */
> +       ETM4x_AMBA_ID(0x000bb803),              /* Qualcomm Kryo 385
> Cortex-A75 */
> +       ETM4x_AMBA_ID(0x000bb802),              /* Qualcomm Kryo 385
> Cortex-A55 */
>           {},

That looks fine with me. But as Mathieu said, this needs to be a separate
patch. But before all that please could you provide me the PIDR4 value for
the Kryo A75 and A55 please ?

Kind regards
Suzuki

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
