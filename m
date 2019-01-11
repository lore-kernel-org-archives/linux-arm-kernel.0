Return-Path: <SRS0=KsRD=PT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78C62C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 18:46:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51BB121841
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 18:46:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="O9ApSffY";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="W2KEl87B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51BB121841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=gavg1JgYVTdh+4lJivAyGPQ5X4fVb8DhBBCOlAkfA2w=; b=O9ApSffYQrdB9F
	MmDsF5QrK1nKIN9l64QdjHZlSIC5dHzkmqdcu2r6rZA0k1fRL25uOAoYuBCRmRusnAfZvmUwmHv0d
	0kYcUfNDWID3XiqwQWp3ziMXww8zI7fn1VsmXldxBwJ76KTXp4m4dVyM7X7YXmLGdLxNm2ul0C2uj
	7KzfDfoDVw5z3JnDH9k1G/QX9rrRVZPGN9tDMnEkmLZfPOuuNuwwNYrBl48JYMiMDkvhLErZ3tFbt
	7xTOP9STS0lQIw+/IGD1/9sLWluAAepWfoPb1H18CyZTeLqHYJiIUJ1l1yaQszZDW1pOLvu9vDEx6
	4klLJcrqUBq6hVU/kXjw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gi1pU-00058g-PC; Fri, 11 Jan 2019 18:46:52 +0000
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gi1pP-00058G-M1
 for linux-arm-kernel@lists.infradead.org; Fri, 11 Jan 2019 18:46:49 +0000
Received: by mail-pl1-x643.google.com with SMTP id gn14so7124947plb.10
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 11 Jan 2019 10:46:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=+aiW6vCZX0/WFCM/Vj9Sk8elzEY6SdravxxXXUCZTOg=;
 b=W2KEl87B/GUUB7ZhuztWx/qVQ69A6aWXXWA2IPhkpoBlYyXcHAXBjSC9JZW9p9TGws
 Ztq6bwy0adshCrGkPOaswohwXVx4L/gzwcgfvM88g6ynpvKFATbV5quvggTjgQrjYAfz
 52nbRTSRu8ghmpIKy1LTVD2l2dXnVEDWb4Dnc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=+aiW6vCZX0/WFCM/Vj9Sk8elzEY6SdravxxXXUCZTOg=;
 b=dfyTWBJV20pB+P8wNeFFBw91cKSful5j+LG1V5lhb1TyNwCbPeoTxakKllMTXPEvdL
 OTI7kC5gxFR2yJwOKcFHIAO2wLinHIlf8LF0h05boRKLdEtu8BKvhsdy4zq2ahhrX8eU
 rnt8d6MzKIFwllLDaHrr/W4370gav1QTDwL80OQ8TxecT6gwSYYqJv2P+K+jQuqPVH6E
 MwBYjmGkUE2RCCtl31Pzo27DaBervOsGa5JCH/roqPAmhcpaKu1zcYwnlmd+i0/JRTCT
 vdvK9XSxJC+5WyBBMpGMSeF1QQOID12BvWS5vmLUxrYYH8UJXTGyD2GLNtpvnOoDnDpI
 aj3g==
X-Gm-Message-State: AJcUukee6/sUjpYdAXjf9LHg1szPKecbBxoNLsT/zWIsM8VY2+hyU+l6
 Bj+DmHRnVT0Yb/Tn2Vkq7DUIWQ==
X-Google-Smtp-Source: ALg8bN7XjW1N8yrLFSeM/GmS7X+6TFocx0wTvygHRKsfrYcuNu2JYZK46wvJRlsL7SZWMDNI9JD/3A==
X-Received: by 2002:a17:902:b090:: with SMTP id
 p16mr6775428plr.190.1547232406407; 
 Fri, 11 Jan 2019 10:46:46 -0800 (PST)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
 by smtp.gmail.com with ESMTPSA id l22sm133225040pfj.179.2019.01.11.10.46.44
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 11 Jan 2019 10:46:45 -0800 (PST)
Date: Fri, 11 Jan 2019 11:46:43 -0700
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Subject: Re: [PATCH 1/3] arm64: dts: qcom: sdm845: Add Coresight support
Message-ID: <20190111184643.GA22691@xps15>
References: <cover.1547054308.git.saiprakash.ranjan@codeaurora.org>
 <a13ad49d3ae8d9a5a972027283b7212ab19f97d0.1547054308.git.saiprakash.ranjan@codeaurora.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <a13ad49d3ae8d9a5a972027283b7212ab19f97d0.1547054308.git.saiprakash.ranjan@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190111_104647_800460_8DD2EFED 
X-CRM114-Status: GOOD (  17.60  )
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
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 David Brown <david.brown@linaro.org>, Rob Herring <robh+dt@kernel.org>,
 Sibi Sankar <sibis@codeaurora.org>, Vivek Gautam <vivek.gautam@codeaurora.org>,
 Leo Yan <leo.yan@linaro.org>, Andy Gross <andy.gross@linaro.org>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Sai,

On Wed, Jan 09, 2019 at 11:16:47PM +0530, Sai Prakash Ranjan wrote:
> Add coresight components found on Qualcomm SDM845 SoC.
> 
> Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
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

I'm a little curious as to why you need to bypass the normal AMBA bus discovery
method by forcing the peripheral ID.  Tracers don't show up the way other
coresight devices do at boot time?

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
