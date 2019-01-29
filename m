Return-Path: <SRS0=P47x=QF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1FE3C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 09:28:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A077E2177E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 09:28:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="AxnhSqVd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A077E2177E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=gr4GIB33QBrumorkaj2Vgj+DkjzZ56NKc4enIERmw0I=; b=AxnhSqVdZDrOQsJwRF53cSZ4N
	+JFKq6lSbs2TgaLMsEAfSFkFV/j0UJQys2ARcl9z3N2AxXDE5W0sFvr5iBneTq4pyfxT3mjiTPiMB
	B4z8W+GHxXsDaFhEAYphqx0/RF4IVrSrYULQjowU3D2Y3B49Kqt1gozFprZ31Mm1mBKZbMRVnx6hm
	D2RnfvyL4G+Uym60lcPYqDTed+NBRyeyVgRXdlEPvPRTA59xPCYlTDYzEPaIynipBJJEhSm0hca67
	KNIPTBPZZOR4aW0l7lQtvHFQ8bcjHKgNZJbroxV2uiODhnQJt8FhTo5a//sjv5RiUbI6RC9tI6jDI
	1AgOMndQg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goPgm-0005pn-EB; Tue, 29 Jan 2019 09:28:16 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goPgi-0005p2-A4
 for linux-arm-kernel@lists.infradead.org; Tue, 29 Jan 2019 09:28:14 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E782E80D;
 Tue, 29 Jan 2019 01:28:10 -0800 (PST)
Received: from [10.1.196.93] (en101.cambridge.arm.com [10.1.196.93])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 030493F7A6;
 Tue, 29 Jan 2019 01:28:04 -0800 (PST)
Subject: Re: [PATCHv5 5/7] coresight: etm4x: Add ETM PIDs for SDM845 and
 MSM8996
To: saiprakash.ranjan@codeaurora.org, robh+dt@kernel.org,
 mathieu.poirier@linaro.org, mike.leach@linaro.org, leo.yan@linaro.org,
 alexander.shishkin@linux.intel.com, andy.gross@linaro.org,
 david.brown@linaro.org, vivek.gautam@codeaurora.org, jhugo@codeaurora.org,
 dianders@chromium.org, sboyd@kernel.org, bjorn.andersson@linaro.org,
 devicetree@vger.kernel.org, mark.rutland@arm.com, marc.w.gonzalez@free.fr
References: <cover.1548419933.git.saiprakash.ranjan@codeaurora.org>
 <cb7d3e715f154942fba1597b91d5b13c25f607e7.1548419933.git.saiprakash.ranjan@codeaurora.org>
From: Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <bf0337b0-2b1c-f296-8a1d-e8a8f993c274@arm.com>
Date: Tue, 29 Jan 2019 09:28:03 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <cb7d3e715f154942fba1597b91d5b13c25f607e7.1548419933.git.saiprakash.ranjan@codeaurora.org>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190129_012812_352869_BA2F3270 
X-CRM114-Status: GOOD (  17.67  )
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
Cc: rnayak@codeaurora.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, sibis@codeaurora.org, tingwei@codeaurora.org,
 linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org



On 28/01/2019 19:14, Sai Prakash Ranjan wrote:
> Instead of overriding the peripheral id(PID) check in AMBA
> by hardcoding them in DT, add the PIDs to the ETM4x driver.
> Here we use Unique Component Identifier(UCI) for MSM8996
> since the ETM and CPU debug module shares the same PIDs.
> SDM845 does not support CPU debug module.
> 
> Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
> 
> ---
> This patch depends on UCI support by Mike Leach in below link:
>   https://lore.kernel.org/lkml/20190121233151.13363-2-mike.leach@linaro.org/
> ---
>   drivers/hwtracing/coresight/coresight-etm4x.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x.c b/drivers/hwtracing/coresight/coresight-etm4x.c
> index fe76b176974a..17731a8ae787 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x.c
> @@ -1080,6 +1080,10 @@ static const struct amba_id etm4_ids[] = {
>   	ETM4x_AMBA_ID(0x000bb95a),		/* Cortex-A72 */
>   	ETM4x_AMBA_ID(0x000bb959),		/* Cortex-A73 */
>   	ETM4x_AMBA_ID(0x000bb9da),		/* Cortex-A35 */
> +	ETM4x_AMBA_UCI_ID(0x000f0205),		/* Qualcomm Kryo */
> +	ETM4x_AMBA_UCI_ID(0x000f0211),		/* Qualcomm Kryo */
> +	ETM4x_AMBA_ID(0x000bb802),		/* Qualcomm Kryo 385 Cortex-A55 */
> +	ETM4x_AMBA_ID(0x000bb803),		/* Qualcomm Kryo 385 Cortex-A75 */
>   	{},
>   };
>   

Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
