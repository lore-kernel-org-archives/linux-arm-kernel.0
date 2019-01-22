Return-Path: <SRS0=B2vk=P6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9906EC282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 13:59:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6952821726
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 13:59:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bElJQkBV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6952821726
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=ER2HV7oykX4d6XVH421hTp8WKGuJgxRBJ8SikAlC07w=; b=bElJQkBVGWoFHzXL1LKRmuTEV
	0iL9aSlg5XOk6Qz6eFHWs6hoaAzZTY8OD0ugjkKi+rvcbpemXBUd4TpVSnUpF2/SkiQeFFf1knbNy
	a/UNxrUvA7BAulUoiLbD0B5dXFizI+aHAF99F8pxIxEVkpAaSIZ2+vPbOyTk1KO/g9FNcFsffHHW9
	srsdJ/KG1hmqgNwWXvHd2vW4yCnps1AarV/crwGcA1XLV5s31udHKFRxl/a0LYf9A1DapV7JFX7E/
	LKWoIpctPFoShYr5kpZrXYK+uH0FCP0K+wl7QtHCALpWkv+Yv3fXkRRlYrEX3glOB/jbHCf7W2/7x
	l1Z3lS8Pg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glwZx-0002d8-A3; Tue, 22 Jan 2019 13:59:01 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glwZt-0002cN-P1
 for linux-arm-kernel@lists.infradead.org; Tue, 22 Jan 2019 13:58:59 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 61A7DEBD;
 Tue, 22 Jan 2019 05:58:54 -0800 (PST)
Received: from [10.37.10.44] (unknown [10.37.10.44])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7C73B3F614;
 Tue, 22 Jan 2019 05:58:50 -0800 (PST)
Subject: Re: [PATCHv4 1/4] arm64: dts: qcom: sdm845: Add Coresight support
To: saiprakash.ranjan@codeaurora.org, robh+dt@kernel.org,
 mathieu.poirier@linaro.org, leo.yan@linaro.org,
 alexander.shishkin@linux.intel.com, andy.gross@linaro.org,
 david.brown@linaro.org, vivek.gautam@codeaurora.org, dianders@chromium.org,
 sboyd@kernel.org, bjorn.andersson@linaro.org, devicetree@vger.kernel.org,
 mark.rutland@arm.com
References: <cover.1548133311.git.saiprakash.ranjan@codeaurora.org>
 <ad16cfb9b6f5efb85149458d5f5a1abf43fa027c.1548133311.git.saiprakash.ranjan@codeaurora.org>
From: Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <1bd39862-0725-70ce-6535-fdb59569f683@arm.com>
Date: Tue, 22 Jan 2019 14:00:40 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <ad16cfb9b6f5efb85149458d5f5a1abf43fa027c.1548133311.git.saiprakash.ranjan@codeaurora.org>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190122_055857_815162_6821F2F5 
X-CRM114-Status: GOOD (  17.51  )
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

Hi Sai,

On 01/22/2019 01:37 PM, Sai Prakash Ranjan wrote:
> Add coresight components found on Qualcomm SDM845 SoC.
> 
> Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
> 

Sorry, but I hadn't noticed the PID override strings below. Please
find the question.

> ---
> Depends on AOSS QMP side channel patches and AMBA bus pclk change
> by Bjorn Andersson [1][2].
> Also depends on patch ("arm64: dts: qcom: sdm845: Increase address
> and size cells for soc") [3].
> 
> [1] https://lore.kernel.org/lkml/20190106080915.4493-1-bjorn.andersson@linaro.org/
> [2] https://lore.kernel.org/lkml/20190106080915.4493-7-bjorn.andersson@linaro.org/
> [3] https://lore.kernel.org/lkml/20190117042940.25487-2-bjorn.andersson@linaro.org/

[...]

	};
> +
> +		etr@6048000 {
> +			compatible = "arm,coresight-tmc", "arm,primecell";
> +			reg = <0 0x06048000 0 0x1000>;
> +
> +			power-domains = <&aoss_qmp AOSS_QMP_QDSS_CLK>;
> +			arm,scatter-gather;
> +
> +			in-ports {
> +				port {
> +					etr_in: endpoint {
> +						remote-endpoint =
> +						  <&replicator_out>;
> +					};
> +				};
> +			};
> +		};
> +
> +		/*
> +		 * On QCOM SDM845, we bypass the normal AMBA bus discovery
> +		 * method by forcing the peripheral ID because of the wrong
> +		 * value read from ETM PID registers.
> +		 */

What is the value read back from the ETM PIDx registers ? Do they
provide inconsistent or incompatible value w.r.t the ETM/Coresight
architecture ? If it is an unsupported CPU with proper values,
you must add them to the table in etm4x driver.

> +		etm@7040000 {
> +			compatible = "arm,coresight-etm4x", "arm,primecell";
> +			arm,primecell-periphid = <0x000bb95d> > +			reg = <0 0x07040000 0 0x1000>;
> +
> +			cpu = <&CPU0>;
> +

You seem to be specifying the PID of A53 ETM all over, while at least
one of your cores is ETMv4.2 (from the other patch) and A53 is not
ETMv4.2. As above, it would be good to add the PID to the table.

Suzuki

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
