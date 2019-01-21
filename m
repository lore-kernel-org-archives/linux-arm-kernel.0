Return-Path: <SRS0=flTa=P5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1E3EC31681
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 18:37:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E04920989
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 18:37:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="VbE4QE+7";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="GLWcqNJW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E04920989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=INW/JDq/XiiJhOTO7B6W9kiQcykJ3MmjWiiBc3NetUo=; b=VbE4QE+7tU6sfY
	C/WdQK7FmxaJjsEjP4clEq9vFgY235QJ0kxJgl9PKzkJA5JlWQuuL+dX4W4Ge3cbDmSV+pUB8rUxH
	fK4eOu7lCl04o7IHeo2UPaUoTf11NLsQGaXbl0lpevFmMYiszoS9sMpbzvxiarnWbABOlQ8gbnNZv
	8mBc67z/4U7LpnCCYCPHb/AZu2YSy6qGRFe5jV5gWu+kZArQ+w5OFUUcAcdgAHc+q2iWYpk1rfrpY
	Vc6Mz7oz+tAjoznvyKU8cCEEYKyLKzG7aWwh5RO50QAgYuYe3K4iwWcuJ1cZL86GjbZrRGx7XV5qd
	lbbdot9PyR74x/ACivBw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gleS3-0007x6-6V; Mon, 21 Jan 2019 18:37:39 +0000
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gleRz-0007wE-Bp
 for linux-arm-kernel@lists.infradead.org; Mon, 21 Jan 2019 18:37:37 +0000
Received: by mail-pl1-x641.google.com with SMTP id b5so10206856plr.4
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 21 Jan 2019 10:37:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=LfgJ80J4ZDHkhQuyoK/VfsoNOr02tH+WlRfi74Gc2uQ=;
 b=GLWcqNJWr+XpBZtN6M20mDlRp2rFGOgTHsyFvfQEEptC0X1A38rnF3QyMe8kz5a7bF
 vmRp9sX4r4lBMSaZhdAEFCc8rhdZy8y0Y6wP36PH6ePMFPV5uLRaIT7EmrCVhuit+DYi
 ZwR8LbXabmzXFZQIXtGXmYL12CJ+0HfZL/utc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=LfgJ80J4ZDHkhQuyoK/VfsoNOr02tH+WlRfi74Gc2uQ=;
 b=ny9hpsTKV81SBnXiSPHIMT23ej+ZOJaDcWqRahc1NRtWFYAm2+nL0pbeLXDTqPAgXx
 zvlsV78VoRNF/2dQMIrGUepkE5De8P/2dKVf1d22H8+vQLEyAC9CSUQWQENcxouTQFnz
 wZextQGBY4DTFa758as8gsVG9oMHG5doAKpvpQbXhO68R5naBd1qO9YzxkyAOiYPJOzf
 Xi5WqF5EOjcIxFai0Yrfu5zATmTc8Za71iCboNIA9tOzPuOZBtdwBMxpL+01FRQLT+NZ
 AsK4nnAwf292qzgvw2jgTZe5of4ApS45LHLbTGnhKUM9t/6Z1pBELdWhuyRJMDnRkeYo
 bsZA==
X-Gm-Message-State: AJcUuke5kbscDcvrkCDdf8WPuslZmG45fS6Ss4TeaPZ8szIVI161Lx68
 xT6x4qUepV+t9x255jzeyhifIg==
X-Google-Smtp-Source: ALg8bN5ZEUlC/cSB8/6MadC6hzC6RoB4ii6H/V6gFm+I282frYQBNnhaIU9awTdPLSqqfKHZ08RAcA==
X-Received: by 2002:a17:902:d68c:: with SMTP id
 v12mr30899276ply.4.1548095854252; 
 Mon, 21 Jan 2019 10:37:34 -0800 (PST)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
 by smtp.gmail.com with ESMTPSA id c7sm17729771pfa.24.2019.01.21.10.37.32
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 21 Jan 2019 10:37:33 -0800 (PST)
Date: Mon, 21 Jan 2019 11:37:31 -0700
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Subject: Re: [PATCHv3 1/4] arm64: dts: qcom: sdm845: Add Coresight support
Message-ID: <20190121183731.GA14049@xps15>
References: <cover.1547813804.git.saiprakash.ranjan@codeaurora.org>
 <73bf137fd5d6cb6bddecdf13026156afcf9d473b.1547813804.git.saiprakash.ranjan@codeaurora.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <73bf137fd5d6cb6bddecdf13026156afcf9d473b.1547813804.git.saiprakash.ranjan@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190121_103735_403641_21403ED2 
X-CRM114-Status: GOOD (  22.16  )
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
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 Doug Anderson <dianders@chromium.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 David Brown <david.brown@linaro.org>, Rob Herring <robh+dt@kernel.org>,
 Sibi Sankar <sibis@codeaurora.org>, Vivek Gautam <vivek.gautam@codeaurora.org>,
 Leo Yan <leo.yan@linaro.org>, Andy Gross <andy.gross@linaro.org>,
 Stephen Boyd <sboyd@kernel.org>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Sai,

On Fri, Jan 18, 2019 at 05:52:53PM +0530, Sai Prakash Ranjan wrote:
> Add coresight components found on Qualcomm SDM845 SoC.
> 
> Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
> 
> ---
> This depends on AMBA bus pclk change by Bjorn Andersson [1].
> Also depends on patch ("arm64: dts: qcom: sdm845: Increase address
> and size cells for soc") [2].
> 
> [1] https://lore.kernel.org/lkml/20190106080915.4493-7-bjorn.andersson@linaro.org/
> [2] https://lore.kernel.org/lkml/20190117042940.25487-2-bjorn.andersson@linaro.org/

Thank you for making modifications to this patch - I am happy with how it stands
now.  I tried to compile it on my side on a 5.0-rc3 kernel and even after
applying the above two patches you pointed out I get the following error:

Error: /home/mpoirier/work/coresight/kernel-maint/arch/arm64/boot/dts/qcom/sdm845.dtsi:1356.31-32 syntax error
FATAL ERROR: Unable to parse input tree

From what I see neither aoss_qmp or AOSS_QMP_QDSS_CLK are defined.  Are there
more patches that need to be applied?

Thanks,
Mathieu


> ---
>  arch/arm64/boot/dts/qcom/sdm845.dtsi | 448 +++++++++++++++++++++++++++
>  1 file changed, 448 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> index c27cbd3bcb0a..2c589f7f13a8 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> @@ -1348,6 +1348,454 @@
>  			};
>  		};
>  
> +		stm@6002000 {
> +			compatible = "arm,coresight-stm", "arm,primecell";
> +			reg = <0 0x06002000 0 0x1000>,
> +			      <0 0x16280000 0 0x180000>;
> +			reg-names = "stm-base", "stm-stimulus-base";
> +
> +			power-domains = <&aoss_qmp AOSS_QMP_QDSS_CLK>;
> +
> +			out-ports {
> +				port {
> +					stm_out: endpoint {
> +						remote-endpoint =
> +						  <&funnel0_in7>;
> +					};
> +				};
> +			};
> +		};
> +
> +		funnel@6041000 {
> +			compatible = "arm,coresight-funnel", "arm,primecell";
> +			reg = <0 0x06041000 0 0x1000>;
> +
> +			power-domains = <&aoss_qmp AOSS_QMP_QDSS_CLK>;
> +
> +			out-ports {
> +				port {
> +					funnel0_out: endpoint {
> +						remote-endpoint =
> +						  <&merge_funnel_in0>;
> +					};
> +				};
> +			};
> +
> +			in-ports {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +
> +				port@7 {
> +					reg = <7>;
> +					funnel0_in7: endpoint {
> +						remote-endpoint = <&stm_out>;
> +					};
> +				};
> +			};
> +		};
> +
> +		funnel@6043000 {
> +			compatible = "arm,coresight-funnel", "arm,primecell";
> +			reg = <0 0x06043000 0 0x1000>;
> +
> +			power-domains = <&aoss_qmp AOSS_QMP_QDSS_CLK>;
> +
> +			out-ports {
> +				port {
> +					funnel2_out: endpoint {
> +						remote-endpoint =
> +						  <&merge_funnel_in2>;
> +					};
> +				};
> +			};
> +
> +			in-ports {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +
> +				port@5 {
> +					reg = <5>;
> +					funnel2_in5: endpoint {
> +						remote-endpoint =
> +						  <&apss_merge_funnel_out>;
> +					};
> +				};
> +			};
> +		};
> +
> +		funnel@6045000 {
> +			compatible = "arm,coresight-funnel", "arm,primecell";
> +			reg = <0 0x06045000 0 0x1000>;
> +
> +			power-domains = <&aoss_qmp AOSS_QMP_QDSS_CLK>;
> +
> +			out-ports {
> +				port {
> +					merge_funnel_out: endpoint {
> +						remote-endpoint = <&etf_in>;
> +					};
> +				};
> +			};
> +
> +			in-ports {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +
> +				port@0 {
> +					reg = <0>;
> +					merge_funnel_in0: endpoint {
> +						remote-endpoint =
> +						  <&funnel0_out>;
> +					};
> +				};
> +
> +				port@2 {
> +					reg = <2>;
> +					merge_funnel_in2: endpoint {
> +						remote-endpoint =
> +						  <&funnel2_out>;
> +					};
> +				};
> +			};
> +		};
> +
> +		replicator@6046000 {
> +			compatible = "arm,coresight-dynamic-replicator", "arm,primecell";
> +			reg = <0 0x06046000 0 0x1000>;
> +
> +			power-domains = <&aoss_qmp AOSS_QMP_QDSS_CLK>;
> +
> +			out-ports {
> +				port {
> +					replicator_out: endpoint {
> +						remote-endpoint = <&etr_in>;
> +					};
> +				};
> +			};
> +
> +			in-ports {
> +				port {
> +					replicator_in: endpoint {
> +						remote-endpoint = <&etf_out>;
> +					};
> +				};
> +			};
> +		};
> +
> +		etf@6047000 {
> +			compatible = "arm,coresight-tmc", "arm,primecell";
> +			reg = <0 0x06047000 0 0x1000>;
> +
> +			power-domains = <&aoss_qmp AOSS_QMP_QDSS_CLK>;
> +
> +			out-ports {
> +				port {
> +					etf_out: endpoint {
> +						remote-endpoint =
> +						  <&replicator_in>;
> +					};
> +				};
> +			};
> +
> +			in-ports {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +
> +				port@1 {
> +					reg = <1>;
> +					etf_in: endpoint {
> +						remote-endpoint =
> +						  <&merge_funnel_out>;
> +					};
> +				};
> +			};
> +		};
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
> +
> +		etm@7040000 {
> +			compatible = "arm,coresight-etm4x", "arm,primecell";
> +			arm,primecell-periphid = <0x000bb95d>;
> +			reg = <0 0x07040000 0 0x1000>;
> +
> +			cpu = <&CPU0>;
> +
> +			power-domains = <&aoss_qmp AOSS_QMP_QDSS_CLK>;
> +
> +			out-ports {
> +				port {
> +					etm0_out: endpoint {
> +						remote-endpoint =
> +						  <&apss_funnel_in0>;
> +					};
> +				};
> +			};
> +		};
> +
> +		etm@7140000 {
> +			compatible = "arm,coresight-etm4x", "arm,primecell";
> +			arm,primecell-periphid = <0x000bb95d>;
> +			reg = <0 0x07140000 0 0x1000>;
> +
> +			cpu = <&CPU1>;
> +
> +			power-domains = <&aoss_qmp AOSS_QMP_QDSS_CLK>;
> +
> +			out-ports {
> +				port {
> +					etm1_out: endpoint {
> +						remote-endpoint =
> +						  <&apss_funnel_in1>;
> +					};
> +				};
> +			};
> +		};
> +
> +		etm@7240000 {
> +			compatible = "arm,coresight-etm4x", "arm,primecell";
> +			arm,primecell-periphid = <0x000bb95d>;
> +			reg = <0 0x07240000 0 0x1000>;
> +
> +			cpu = <&CPU2>;
> +
> +			power-domains = <&aoss_qmp AOSS_QMP_QDSS_CLK>;
> +
> +			out-ports {
> +				port {
> +					etm2_out: endpoint {
> +						remote-endpoint =
> +						  <&apss_funnel_in2>;
> +					};
> +				};
> +			};
> +		};
> +
> +		etm@7340000 {
> +			compatible = "arm,coresight-etm4x", "arm,primecell";
> +			arm,primecell-periphid = <0x000bb95d>;
> +			reg = <0 0x07340000 0 0x1000>;
> +
> +			cpu = <&CPU3>;
> +
> +			power-domains = <&aoss_qmp AOSS_QMP_QDSS_CLK>;
> +
> +			out-ports {
> +				port {
> +					etm3_out: endpoint {
> +						remote-endpoint =
> +						  <&apss_funnel_in3>;
> +					};
> +				};
> +			};
> +		};
> +
> +		etm@7440000 {
> +			compatible = "arm,coresight-etm4x", "arm,primecell";
> +			arm,primecell-periphid = <0x000bb95d>;
> +			reg = <0 0x07440000 0 0x1000>;
> +
> +			cpu = <&CPU4>;
> +
> +			power-domains = <&aoss_qmp AOSS_QMP_QDSS_CLK>;
> +
> +			out-ports {
> +				port {
> +					etm4_out: endpoint {
> +						remote-endpoint =
> +						  <&apss_funnel_in4>;
> +					};
> +				};
> +			};
> +		};
> +
> +		etm@7540000 {
> +			compatible = "arm,coresight-etm4x", "arm,primecell";
> +			arm,primecell-periphid = <0x000bb95d>;
> +			reg = <0 0x07540000 0 0x1000>;
> +
> +			cpu = <&CPU5>;
> +
> +			power-domains = <&aoss_qmp AOSS_QMP_QDSS_CLK>;
> +
> +			out-ports {
> +				port {
> +					etm5_out: endpoint {
> +						remote-endpoint =
> +						  <&apss_funnel_in5>;
> +					};
> +				};
> +			};
> +		};
> +
> +		etm@7640000 {
> +			compatible = "arm,coresight-etm4x", "arm,primecell";
> +			arm,primecell-periphid = <0x000bb95d>;
> +			reg = <0 0x07640000 0 0x1000>;
> +
> +			cpu = <&CPU6>;
> +
> +			power-domains = <&aoss_qmp AOSS_QMP_QDSS_CLK>;
> +
> +			out-ports {
> +				port {
> +					etm6_out: endpoint {
> +						remote-endpoint =
> +						  <&apss_funnel_in6>;
> +					};
> +				};
> +			};
> +		};
> +
> +		etm@7740000 {
> +			compatible = "arm,coresight-etm4x", "arm,primecell";
> +			arm,primecell-periphid = <0x000bb95d>;
> +			reg = <0 0x07740000 0 0x1000>;
> +
> +			cpu = <&CPU7>;
> +
> +			power-domains = <&aoss_qmp AOSS_QMP_QDSS_CLK>;
> +
> +			out-ports {
> +				port {
> +					etm7_out: endpoint {
> +						remote-endpoint =
> +						  <&apss_funnel_in7>;
> +					};
> +				};
> +			};
> +		};
> +
> +		funnel@7800000 { /* APSS Funnel */
> +			compatible = "arm,coresight-funnel", "arm,primecell";
> +			reg = <0 0x07800000 0 0x1000>;
> +
> +			power-domains = <&aoss_qmp AOSS_QMP_QDSS_CLK>;
> +
> +			out-ports {
> +				port {
> +					apss_funnel_out: endpoint {
> +						remote-endpoint =
> +						  <&apss_merge_funnel_in>;
> +					};
> +				};
> +			};
> +
> +			in-ports {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +
> +				port@0 {
> +					reg = <0>;
> +					apss_funnel_in0: endpoint {
> +						remote-endpoint =
> +						  <&etm0_out>;
> +					};
> +				};
> +
> +				port@1 {
> +					reg = <1>;
> +					apss_funnel_in1: endpoint {
> +						remote-endpoint =
> +						  <&etm1_out>;
> +					};
> +				};
> +
> +				port@2 {
> +					reg = <2>;
> +					apss_funnel_in2: endpoint {
> +						remote-endpoint =
> +						  <&etm2_out>;
> +					};
> +				};
> +
> +				port@3 {
> +					reg = <3>;
> +					apss_funnel_in3: endpoint {
> +						remote-endpoint =
> +						  <&etm3_out>;
> +					};
> +				};
> +
> +				port@4 {
> +					reg = <4>;
> +					apss_funnel_in4: endpoint {
> +						remote-endpoint =
> +						  <&etm4_out>;
> +					};
> +				};
> +
> +				port@5 {
> +					reg = <5>;
> +					apss_funnel_in5: endpoint {
> +						remote-endpoint =
> +						  <&etm5_out>;
> +					};
> +				};
> +
> +				port@6 {
> +					reg = <6>;
> +					apss_funnel_in6: endpoint {
> +						remote-endpoint =
> +						  <&etm6_out>;
> +					};
> +				};
> +
> +				port@7 {
> +					reg = <7>;
> +					apss_funnel_in7: endpoint {
> +						remote-endpoint =
> +						  <&etm7_out>;
> +					};
> +				};
> +			};
> +		};
> +
> +		funnel@7810000 {
> +			compatible = "arm,coresight-funnel", "arm,primecell";
> +			reg = <0 0x07810000 0 0x1000>;
> +
> +			power-domains = <&aoss_qmp AOSS_QMP_QDSS_CLK>;
> +
> +			out-ports {
> +				port {
> +					apss_merge_funnel_out: endpoint {
> +						remote-endpoint =
> +						  <&funnel2_in5>;
> +					};
> +				};
> +			};
> +
> +			in-ports {
> +				port {
> +					apss_merge_funnel_in: endpoint {
> +						remote-endpoint =
> +						  <&apss_funnel_out>;
> +					};
> +				};
> +			};
> +		};
> +
>  		usb_1_hsphy: phy@88e2000 {
>  			compatible = "qcom,sdm845-qusb2-phy";
>  			reg = <0x88e2000 0x400>;
> -- 
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
> of Code Aurora Forum, hosted by The Linux Foundation
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
