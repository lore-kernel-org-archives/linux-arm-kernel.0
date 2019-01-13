Return-Path: <SRS0=Fp1N=PV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1347C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 07:24:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F52B2084C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 07:24:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="r4HMoACl";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="iYZnMMzS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F52B2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=FKS9h04YgUgHxnx9k9y4+OCNpDB41jgXTG68j3wFnJM=; b=r4HMoAClkoP6vT
	bSGAuZtt3m3xbCphcGmCGq4uBengc2gnMJz2fJUEs27ttkVgFQ7QlwrfosoooW0stmEOUccqdU1kQ
	KHmEARxd28FrlTQQU/UGE/EYmEs8cKUEY9zHBd1Fe6kXy7WIfhgEIyLZETCgk5W9+ehYfF/85DjLN
	lEQEPek4oRFSsT7zHr2npggABBFVz91jEwDj+Cmw8D4w2ophokC3a/uZsYQnInY6FLtvwPGef0v1S
	IsupK5NnIgvNG+JnT3yXRjzbWIvuzR+txf4U5eiew+mOR1JJCpJCeHL4RC+kcDqM36+3AK3OlB/Fu
	OTyxfBz7D1mEoJawQUDg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gia7z-00080u-UC; Sun, 13 Jan 2019 07:24:15 +0000
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gia7v-00080P-2g
 for linux-arm-kernel@lists.infradead.org; Sun, 13 Jan 2019 07:24:13 +0000
Received: by mail-pf1-x444.google.com with SMTP id q1so8912999pfi.5
 for <linux-arm-kernel@lists.infradead.org>;
 Sat, 12 Jan 2019 23:24:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=9SZ3yvIxPZ4Gy974jD5vsjVZjIobNTtfni7SYA3WGH0=;
 b=iYZnMMzSV1+q4EESa8AawpWmqrPnSfu7XVfs4rhTIuuJVHY272QLgrE1nSnDV1E/9l
 7GrAJ1Bearb0oH8tNX362QaRs1MQou19OGeSKmHWxy3/r0s/U1NUD/QBTcVMaPAx9JAI
 eKm3hwurynSu05xpUTborJuWrAqE04hZqQdXA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=9SZ3yvIxPZ4Gy974jD5vsjVZjIobNTtfni7SYA3WGH0=;
 b=YrCB/gAxwUpRJQmCmVG49+PxHoYk/B5+1vKbfFn68+wTJ180QH50LOYfSW04R7lhzM
 yFGQ1u8zS3OQF7y+eWsgvUGUtm0oF5C1jPQNHSk7QHJgCC3pATEULjic4hRciz17HR25
 oN9q/kGpvfHY98adbcRstilQsg15NNrmFPdcSFAO1ME6S5jn87qVcPDmknx9m+PBG4lr
 6sQTvtjIVnFeuWB5ESHsjVx8WGxxfOA9yMoZAFz5ZJD9fOUAlt0Rphvbz+bMfda7Mf6Q
 wuNsWq86UsR4nhsRGrBajRzyrfEMqJFvJJX/TdImvwuHDt2GH9IWsbx+9j2/0FllOX4n
 8HgA==
X-Gm-Message-State: AJcUukf+YdAppGkNRZD9qg4ZLu7TE2OkvrdgzzkymSONzrN/6RHkx2dy
 hziod18yQhdfRd5zupN0sIMOvA==
X-Google-Smtp-Source: ALg8bN4mYeimtrPrgX00e5hzojvH/EkRC2HWvxhOp/Y7cYHYzkcuKvLq1Vr6BWYeui1EN/x9EOhzwg==
X-Received: by 2002:a63:ff16:: with SMTP id k22mr19103506pgi.244.1547364248082; 
 Sat, 12 Jan 2019 23:24:08 -0800 (PST)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net.
 [104.188.17.28])
 by smtp.gmail.com with ESMTPSA id u126sm189490404pgb.2.2019.01.12.23.24.06
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sat, 12 Jan 2019 23:24:07 -0800 (PST)
Date: Sat, 12 Jan 2019 23:23:19 -0800
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Subject: Re: [PATCH 1/3] arm64: dts: qcom: sdm845: Add Coresight support
Message-ID: <20190113072319.GB28907@builder>
References: <cover.1547054308.git.saiprakash.ranjan@codeaurora.org>
 <a13ad49d3ae8d9a5a972027283b7212ab19f97d0.1547054308.git.saiprakash.ranjan@codeaurora.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <a13ad49d3ae8d9a5a972027283b7212ab19f97d0.1547054308.git.saiprakash.ranjan@codeaurora.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190112_232411_191054_671A1F26 
X-CRM114-Status: GOOD (  16.98  )
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
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Suzuki K Poulose <suzuki.poulose@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 David Brown <david.brown@linaro.org>, Rob Herring <robh+dt@kernel.org>,
 Sibi Sankar <sibis@codeaurora.org>, Vivek Gautam <vivek.gautam@codeaurora.org>,
 Leo Yan <leo.yan@linaro.org>, Andy Gross <andy.gross@linaro.org>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed 09 Jan 09:46 PST 2019, Sai Prakash Ranjan wrote:

> Add coresight components found on Qualcomm SDM845 SoC.
> 
> Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>

Hi Sai,

The content of this patch looks good, but please fold it into
sdm845.dtsi (keep the nodes sorted by address).

And mention below the --- that this depends on my AMBA bus pclk change
and include the URL:

https://lore.kernel.org/lkml/20190106080915.4493-7-bjorn.andersson@linaro.org/

Regards,
Bjorn

> ---
>  .../arm64/boot/dts/qcom/sdm845-coresight.dtsi | 437 ++++++++++++++++++
>  arch/arm64/boot/dts/qcom/sdm845.dtsi          |   2 +
>  2 files changed, 439 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/sdm845-coresight.dtsi
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm845-coresight.dtsi b/arch/arm64/boot/dts/qcom/sdm845-coresight.dtsi
> new file mode 100644
> index 000000000000..b6ef250b9186
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/sdm845-coresight.dtsi
> @@ -0,0 +1,437 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * SDM845 Coresight DTS
> + *
> + * Copyright (c) 2019, The Linux Foundation. All rights reserved.
> + */
> +
> +&soc {
> +	stm@6002000 {
> +		compatible = "arm,coresight-stm", "arm,primecell";
> +		reg = <0x06002000 0x1000>,
> +		      <0x16280000 0x180000>;
> +		reg-names = "stm-base", "stm-stimulus-base";
> +
> +		power-domains = <&aoss_qmp AOSS_QMP_QDSS_CLK>;
> +
> +		out-ports {
> +			port {
> +				stm_out: endpoint {
> +					remote-endpoint = <&funnel0_in7>;
> +				};
> +			};
> +		};
> +	};
> +
> +	funnel@6041000 {
> +		compatible = "arm,coresight-funnel", "arm,primecell";
> +		reg = <0x06041000 0x1000>;
> +
> +		power-domains = <&aoss_qmp AOSS_QMP_QDSS_CLK>;
> +
> +		out-ports {
> +			port {
> +				funnel0_out: endpoint {
> +					remote-endpoint =
> +						<&merge_funnel_in0>;
> +				};
> +			};
> +		};
> +
> +		in-ports {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			port@7 {
> +				reg = <7>;
> +				funnel0_in7: endpoint {
> +					remote-endpoint = <&stm_out>;
> +				};
> +			};
> +		};
> +	};
> +
> +	funnel@6043000 {
> +		compatible = "arm,coresight-funnel", "arm,primecell";
> +		reg = <0x06043000 0x1000>;
> +
> +		power-domains = <&aoss_qmp AOSS_QMP_QDSS_CLK>;
> +
> +		out-ports {
> +			port {
> +				funnel2_out: endpoint {
> +					remote-endpoint =
> +					  <&merge_funnel_in2>;
> +				};
> +			};
> +		};
> +
> +		in-ports {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			port@5 {
> +				reg = <5>;
> +				funnel2_in5: endpoint {
> +					remote-endpoint =
> +					  <&apss_merge_funnel_out>;
> +				};
> +			};
> +		};
> +	};
> +
> +	funnel@6045000 {
> +		compatible = "arm,coresight-funnel", "arm,primecell";
> +		reg = <0x06045000 0x1000>;
> +
> +		power-domains = <&aoss_qmp AOSS_QMP_QDSS_CLK>;
> +
> +		out-ports {
> +			port {
> +				merge_funnel_out: endpoint {
> +					remote-endpoint = <&etf_in>;
> +				};
> +			};
> +		};
> +
> +		in-ports {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			port@0 {
> +				reg = <0>;
> +				merge_funnel_in0: endpoint {
> +					remote-endpoint =
> +						<&funnel0_out>;
> +				};
> +			};
> +
> +			port@2 {
> +				reg = <2>;
> +				merge_funnel_in2: endpoint {
> +					remote-endpoint =
> +						<&funnel2_out>;
> +				};
> +			};
> +		};
> +	};
> +
> +	replicator@6046000 {
> +		compatible = "arm,coresight-dynamic-replicator", "arm,primecell";
> +		reg = <0x06046000 0x1000>;
> +
> +		power-domains = <&aoss_qmp AOSS_QMP_QDSS_CLK>;
> +
> +		out-ports {
> +			port {
> +				replicator_out: endpoint {
> +					remote-endpoint = <&etr_in>;
> +				};
> +			};
> +		};
> +
> +		in-ports {
> +			port {
> +				replicator_in: endpoint {
> +					remote-endpoint = <&etf_out>;
> +				};
> +			};
> +		};
> +	};
> +
> +	etf@6047000 {
> +		compatible = "arm,coresight-tmc", "arm,primecell";
> +		reg = <0x06047000 0x1000>;
> +
> +		power-domains = <&aoss_qmp AOSS_QMP_QDSS_CLK>;
> +
> +		out-ports {
> +			port {
> +				etf_out: endpoint {
> +					remote-endpoint = <&replicator_in>;
> +				};
> +			};
> +		};
> +
> +		in-ports {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			port@1 {
> +				reg = <1>;
> +				etf_in: endpoint {
> +					remote-endpoint = <&merge_funnel_out>;
> +				};
> +			};
> +		};
> +	};
> +
> +	etr@6048000 {
> +		compatible = "arm,coresight-tmc", "arm,primecell";
> +		reg = <0x06048000 0x1000>;
> +
> +		power-domains = <&aoss_qmp AOSS_QMP_QDSS_CLK>;
> +
> +		in-ports {
> +			port {
> +				etr_in: endpoint {
> +					remote-endpoint = <&replicator_out>;
> +				};
> +			};
> +		};
> +	};
> +
> +	etm@7040000 {
> +		compatible = "arm,coresight-etm4x", "arm,primecell";
> +		arm,primecell-periphid = <0x000bb95d>;
> +		reg = <0x07040000 0x1000>;
> +
> +		cpu = <&CPU0>;
> +
> +		power-domains = <&aoss_qmp AOSS_QMP_QDSS_CLK>;
> +
> +		out-ports {
> +			port {
> +				etm0_out: endpoint {
> +					remote-endpoint = <&apss_funnel_in0>;
> +				};
> +			};
> +		};
> +	};
> +
> +	etm@7140000 {
> +		compatible = "arm,coresight-etm4x", "arm,primecell";
> +		arm,primecell-periphid = <0x000bb95d>;
> +		reg = <0x07140000 0x1000>;
> +
> +		cpu = <&CPU1>;
> +
> +		power-domains = <&aoss_qmp AOSS_QMP_QDSS_CLK>;
> +
> +		out-ports {
> +			port {
> +				etm1_out: endpoint {
> +					remote-endpoint = <&apss_funnel_in1>;
> +				};
> +			};
> +		};
> +	};
> +
> +	etm@7240000 {
> +		compatible = "arm,coresight-etm4x", "arm,primecell";
> +		arm,primecell-periphid = <0x000bb95d>;
> +		reg = <0x07240000 0x1000>;
> +
> +		cpu = <&CPU2>;
> +
> +		power-domains = <&aoss_qmp AOSS_QMP_QDSS_CLK>;
> +
> +		out-ports {
> +			port {
> +				etm2_out: endpoint {
> +					remote-endpoint = <&apss_funnel_in2>;
> +				};
> +			};
> +		};
> +	};
> +
> +	etm@7340000 {
> +		compatible = "arm,coresight-etm4x", "arm,primecell";
> +		arm,primecell-periphid = <0x000bb95d>;
> +		reg = <0x07340000 0x1000>;
> +
> +		cpu = <&CPU3>;
> +
> +		power-domains = <&aoss_qmp AOSS_QMP_QDSS_CLK>;
> +
> +		out-ports {
> +			port {
> +				etm3_out: endpoint {
> +					remote-endpoint = <&apss_funnel_in3>;
> +				};
> +			};
> +		};
> +	};
> +
> +	etm@7440000 {
> +		compatible = "arm,coresight-etm4x", "arm,primecell";
> +		arm,primecell-periphid = <0x000bb95d>;
> +		reg = <0x07440000 0x1000>;
> +
> +		cpu = <&CPU4>;
> +
> +		power-domains = <&aoss_qmp AOSS_QMP_QDSS_CLK>;
> +
> +		out-ports {
> +			port {
> +				etm4_out: endpoint {
> +					remote-endpoint = <&apss_funnel_in4>;
> +				};
> +			};
> +		};
> +	};
> +
> +	etm@7540000 {
> +		compatible = "arm,coresight-etm4x", "arm,primecell";
> +		arm,primecell-periphid = <0x000bb95d>;
> +		reg = <0x07540000 0x1000>;
> +
> +		cpu = <&CPU5>;
> +
> +		power-domains = <&aoss_qmp AOSS_QMP_QDSS_CLK>;
> +
> +		out-ports {
> +			port {
> +				etm5_out: endpoint {
> +					remote-endpoint = <&apss_funnel_in5>;
> +				};
> +			};
> +		};
> +	};
> +
> +	etm@7640000 {
> +		compatible = "arm,coresight-etm4x", "arm,primecell";
> +		arm,primecell-periphid = <0x000bb95d>;
> +		reg = <0x07640000 0x1000>;
> +
> +		cpu = <&CPU6>;
> +
> +		power-domains = <&aoss_qmp AOSS_QMP_QDSS_CLK>;
> +
> +		out-ports {
> +			port {
> +				etm6_out: endpoint {
> +					remote-endpoint = <&apss_funnel_in6>;
> +				};
> +			};
> +		};
> +	};
> +
> +	etm@7740000 {
> +		compatible = "arm,coresight-etm4x", "arm,primecell";
> +		arm,primecell-periphid = <0x000bb95d>;
> +		reg = <0x07740000 0x1000>;
> +
> +		cpu = <&CPU7>;
> +
> +		power-domains = <&aoss_qmp AOSS_QMP_QDSS_CLK>;
> +
> +		out-ports {
> +			port {
> +				etm7_out: endpoint {
> +					remote-endpoint = <&apss_funnel_in7>;
> +				};
> +			};
> +		};
> +	};
> +
> +	funnel@7800000 { /* APSS Funnel */
> +		compatible = "arm,coresight-funnel", "arm,primecell";
> +		reg = <0x07800000 0x1000>;
> +
> +		power-domains = <&aoss_qmp AOSS_QMP_QDSS_CLK>;
> +
> +		out-ports {
> +			port {
> +				apss_funnel_out: endpoint {
> +					remote-endpoint =
> +					    <&apss_merge_funnel_in>;
> +				};
> +			};
> +		};
> +
> +		in-ports {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			port@0 {
> +				reg = <0>;
> +				apss_funnel_in0: endpoint {
> +					remote-endpoint =
> +						<&etm0_out>;
> +				};
> +			};
> +
> +			port@1 {
> +				reg = <1>;
> +				apss_funnel_in1: endpoint {
> +					remote-endpoint =
> +						<&etm1_out>;
> +				};
> +			};
> +
> +			port@2 {
> +				reg = <2>;
> +				apss_funnel_in2: endpoint {
> +					remote-endpoint =
> +						<&etm2_out>;
> +				};
> +			};
> +
> +			port@3 {
> +				reg = <3>;
> +				apss_funnel_in3: endpoint {
> +					remote-endpoint =
> +						<&etm3_out>;
> +				};
> +			};
> +
> +			port@4 {
> +				reg = <4>;
> +				apss_funnel_in4: endpoint {
> +					remote-endpoint =
> +						<&etm4_out>;
> +				};
> +			};
> +
> +			port@5 {
> +				reg = <5>;
> +				apss_funnel_in5: endpoint {
> +					remote-endpoint =
> +						<&etm5_out>;
> +				};
> +			};
> +
> +			port@6 {
> +				reg = <6>;
> +				apss_funnel_in6: endpoint {
> +					remote-endpoint =
> +						<&etm6_out>;
> +				};
> +			};
> +
> +			port@7 {
> +				reg = <7>;
> +				apss_funnel_in7: endpoint {
> +					remote-endpoint =
> +						<&etm7_out>;
> +				};
> +			};
> +		};
> +	};
> +
> +	funnel@7810000 {
> +		compatible = "arm,coresight-funnel", "arm,primecell";
> +		reg = <0x07810000 0x1000>;
> +
> +		power-domains = <&aoss_qmp AOSS_QMP_QDSS_CLK>;
> +
> +		out-ports {
> +			port {
> +				apss_merge_funnel_out: endpoint {
> +					remote-endpoint =
> +					    <&funnel2_in5>;
> +				};
> +			};
> +		};
> +
> +		in-ports {
> +			port {
> +				apss_merge_funnel_in: endpoint {
> +					remote-endpoint =
> +					    <&apss_funnel_out>;
> +				};
> +			};
> +		};
> +	};
> +};
> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> index c27cbd3bcb0a..03683179b8f7 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> @@ -1853,3 +1853,5 @@
>  		};
>  	};
>  };
> +
> +#include "sdm845-coresight.dtsi"
> -- 
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
> of Code Aurora Forum, hosted by The Linux Foundation
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
