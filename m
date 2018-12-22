Return-Path: <SRS0=zEjV=O7=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83896C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 10:47:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FA0320869
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 10:47:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="eCEj+38Q";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="E9YfPaYj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FA0320869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Gizvn/+uK3UyqMCak3JLaY9ohEWqVBStTSA1lOponY0=; b=eCEj+38Q4ajtkz
	6dblRTbP4FOgNCYTyOgAdHqyZcV2UKjnuwnsbeDfMcO52xN5aABNERtRT9YKxbx1/HldnT9xcBHML
	Y38+1UaKCCgr712dXGW0ezl4qmjwGP9TxRCuv0iIh0oekRr+KRpZ0dBWJLsn2QK5i1Mof74JVhvN1
	6r3YqwU09ehtW7ODkv4sEgjwfRmdiPZT9qqcikzKcSvusNvEke3E7Ut5x7u+x8F7R4823or3Dn+ca
	DfMKI7VNrOu/IpEjr0Qhzi1hS2ToceLinhQacxAR8joXLi+nCoQA10kR+V4gXSggcYzeiE6pzDudx
	kjEihHqr3+8W20Osl0eg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gaeoG-00070a-QJ; Sat, 22 Dec 2018 10:47:08 +0000
Received: from mail-ed1-x543.google.com ([2a00:1450:4864:20::543])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gaeoC-0006zc-5q
 for linux-arm-kernel@lists.infradead.org; Sat, 22 Dec 2018 10:47:06 +0000
Received: by mail-ed1-x543.google.com with SMTP id b3so6711821ede.1
 for <linux-arm-kernel@lists.infradead.org>;
 Sat, 22 Dec 2018 02:46:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=HcTJq9S4pekiX261QyleJ3Opovebfy8X7OPB+LNbWNI=;
 b=E9YfPaYj/eRUXvtG3GqS9T9fOBlsbHBRkcYk1Wum819hTSeN9q4yEldPFvezWJl2WH
 a4Ijh0BsA2wteu8Y7TZYemAKhjYJy4R/oV1daafw/krlEis6kD02BmxwVPD0MkJcNvIE
 GVhRF1yJkDNI9cpjSpH3K7fNVY8fMmy4S+hBQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=HcTJq9S4pekiX261QyleJ3Opovebfy8X7OPB+LNbWNI=;
 b=JPjizjQTlZDeaBf1klUhBVtPNIiVsanc/G2k97amln0FLL+19jNTmHAGiiINU9f40P
 JoTgNFMYK3fwdqaerfXkkzz+ixJvjhr/4jKYOqJcvZr/kxwnV0cO4U8nJuK/0PL2FjmU
 b1ri2bF/yx1B49RR8PfZjMJL8CCSfWbN8aabrJNecVISmCIYXY8HYXIwmSLU05+wTy/p
 3+knigEyNCDe5lcwC1tZS+2oApbl+tBsMGrrWhoJgAeEEhLBJr76g3OJQ6xF6NOaJWxk
 5wUEueAO7KNxdKR+imHNxO0CwvARtAW5PAW7Tq7yDXAiADKtXwUlLE8XbqPxzgGIOI8c
 PJww==
X-Gm-Message-State: AA+aEWYCRRH4OeLvN/qwPlMNYMuq1/ogDKrMpLfY5N9ld9ptMmmGcHyI
 4p6T+rCYUNv2+JM6XzBh2OYfYg==
X-Google-Smtp-Source: AFSGD/XadCoQIT1rvY78sKakkC003b315+MCWIqfPgWfQwpxW3aHv4hVw7+5b+++N7duuqwSzSjJBw==
X-Received: by 2002:a17:906:1001:: with SMTP id
 1-v6mr4228223ejm.91.1545475611211; 
 Sat, 22 Dec 2018 02:46:51 -0800 (PST)
Received: from leoy-ThinkPad-X240s ([95.179.158.15])
 by smtp.gmail.com with ESMTPSA id k24-v6sm3883038eja.60.2018.12.22.02.46.46
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 22 Dec 2018 02:46:50 -0800 (PST)
Date: Sat, 22 Dec 2018 18:46:42 +0800
From: leo.yan@linaro.org
To: Wanglai Shi <shiwanglai@hisilicon.com>
Subject: Re: [PATCH] dts: arm64: add CoreSight trace support for hi3660
Message-ID: <20181222104642.GB9950@leoy-ThinkPad-X240s>
References: <1544522749-54071-1-git-send-email-shiwanglai@hisilicon.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1544522749-54071-1-git-send-email-shiwanglai@hisilicon.com>
User-Agent: Mutt/1.10+31 (9cdd884) (2018-06-19)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181222_024704_239813_A856993E 
X-CRM114-Status: GOOD (  25.54  )
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
 Coresight ML <coresight@lists.linaro.org>, linux-kernel@vger.kernel.org,
 xuwei5@hisilicon.com, robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Wanglai,

[ + CoreSight mailing list ]

On Tue, Dec 11, 2018 at 06:05:49PM +0800, Wanglai Shi wrote:
> This patch adds devicetree entries for the CoreSight trace
>  components on hi3660.
> 
> Signed-off-by: Wanglai Shi <shiwanglai@hisilicon.com>
> ---
>  .../arm64/boot/dts/hisilicon/hi3660-coresight.dtsi | 428 +++++++++++++++++++++
>  1 file changed, 428 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/hisilicon/hi3660-coresight.dtsi

This patch doesn't work on Hikey960 due CoreSight related dt binding
has not been really included by dts file.

> diff --git a/arch/arm64/boot/dts/hisilicon/hi3660-coresight.dtsi b/arch/arm64/boot/dts/hisilicon/hi3660-coresight.dtsi
> new file mode 100644
> index 0000000..95c79e4
> --- /dev/null
> +++ b/arch/arm64/boot/dts/hisilicon/hi3660-coresight.dtsi
> @@ -0,0 +1,428 @@
> +/*
> + * dtsi for Hisilicon Hi3660 Coresight
> + *
> + * Copyright (C) 2016-2017 Hisilicon Ltd.

s/2017/2018

> + *
> + * Author: Wanglai Shi <shiwanglai@hisilicon.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * publishhed by the Free Software Foundation.
> + */
> +/ {
> +	amba {

s/amba/soc

> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		compatible = "arm,amba-bus";
> +		ranges;

If under 'soc' node, because 'soc' has defined its address/size cells
length, thus you don't need to define these properties repeatly.

> +
> +		/* A53 cluster internal coresight */
> +		etm@0,ecc40000 {

s/etm@0,ecc40000/etm@ecc40000

> +			compatible = "arm,coresight-etm4x","arm,primecell";

Add extra space between two compatible strings:
                        compatible = "arm,coresight-etm4x", "arm,primecell";

Please apply this rule for all below compatible string bindings.

> +			reg = <0 0xecc40000 0 0x1000>;
> +			clocks = <&pclk>;
> +			clock-names = "apb_pclk";
> +			cpu = <&cpu0>;
> +			port {
> +				etm0_out_port: endpoint {
> +					remote-endpoint = <&funnel0_in_port0>;
> +				};
> +			};

Since Suzuki introduced CoreSight DT bindings for "out-ports" and
"in-ports", so it's suggested to use more explict way to bind hardware
port with specifying direction:

			out-ports {
			        port {
					etm0_out: endpoint {
			                        remote-endpoint =
							<&funnel0_in_port0>;
			                };
			        };
			};

> +		};
> +
> +		etm@1,ecd40000 {

Remove '1,'

> +			compatible = "arm,coresight-etm4x","arm,primecell";
> +			reg = <0 0xecd40000 0 0x1000>;
> +			clocks = <&pclk>;
> +			clock-names = "apb_pclk";
> +			cpu = <&cpu1>;
> +			port {

Suggest for adding 'out-ports'.

> +				etm1_out_port: endpoint {
> +					remote-endpoint = <&funnel0_in_port1>;
> +				};
> +			};
> +		};
> +
> +		etm@2,ece40000 {

Remove '2,'

> +			compatible = "arm,coresight-etm4x","arm,primecell";
> +			reg = <0 0xece40000 0 0x1000>;
> +			clocks = <&pclk>;
> +			clock-names = "apb_pclk";
> +			cpu = <&cpu2>;
> +			port {

Suggest for adding 'out-ports'.

> +				etm2_out_port: endpoint {
> +					remote-endpoint = <&funnel0_in_port2>;
> +				};
> +			};
> +		};
> +
> +		etm@3,ecf40000 {

Remove '3,'

> +			compatible = "arm,coresight-etm4x","arm,primecell";
> +			reg = <0 0xecf40000 0 0x1000>;
> +			clocks = <&pclk>;
> +			clock-names = "apb_pclk";
> +			cpu = <&cpu3>;
> +			port {

Suggest for adding 'out-ports'.

> +				etm3_out_port: endpoint {
> +					remote-endpoint = <&funnel0_in_port3>;
> +				};
> +			};
> +		};
> +
> +		funnel0:funnel@0,ec801000 {

funnel0: funnel@ec801000

> +			compatible = "arm,coresight-funnel","arm,primecell";
> +			reg = <0 0xec801000 0 0x1000>;
> +			clocks = <&pclk>;
> +			clock-names = "apb_pclk";
> +			ports {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +
> +				/* funnel output port */
> +				port@0 {
> +					reg = <0>;
> +					funnel0_out_port: endpoint {
> +						remote-endpoint =
> +							<&etf0_in_port>;
> +					};
> +				};

Suggest for below format:

			out-ports {
				port {
					reg = <0>;
					clusster0_funnel_out_port: endpoint {
						remote-endpoint =
							<&etf0_in_port>;
					};
				};
			};

> +
> +				/* funnel input ports */
> +				port@1 {

Suggest for adding 'in-ports'.

BTW, please keep the consistence between node name and registers;
e.g. port@0 should be consistent with 'reg = <0>;' and port@1 for
'reg = <1>;' ...

So this should be port@0

> +					reg = <0>;
> +					funnel0_in_port0: endpoint {
> +						slave-mode;
> +						remote-endpoint =
> +							<&etm0_out_port>;
> +					};
> +				};
> +
> +				port@2 {

s/port@2/port@1

> +					reg = <1>;
> +					funnel0_in_port1: endpoint {
> +						slave-mode;
> +						remote-endpoint =
> +							<&etm1_out_port>;
> +					};
> +				};
> +
> +				port@3 {

s/port@3/port@2

> +					reg = <2>;
> +					funnel0_in_port2: endpoint {
> +						slave-mode;
> +						remote-endpoint =
> +							<&etm2_out_port>;
> +					};
> +				};
> +
> +				port@4 {

s/port@4/port@3

> +					reg = <3>;
> +					funnel0_in_port3: endpoint {
> +						slave-mode;
> +						remote-endpoint =
> +							<&etm3_out_port>;
> +					};
> +				};
> +			};
> +		};
> +
> +		etf0:etf@0,ec802000 {

etf0: etf@ec802000

> +			compatible = "arm,coresight-tmc","arm,primecell";
> +			reg = <0 0xec802000 0 0x1000>;
> +			clocks = <&pclk>;
> +			clock-names = "apb_pclk";
> +			ports {

Same with upper suggestions: add 'in-ports' and 'out-ports'.

> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				/* input port */
> +				port@0 {
> +					reg = <0>;
> +					etf0_in_port: endpoint {
> +						slave-mode;
> +						remote-endpoint =
> +							<&funnel0_out_port>;
> +					};
> +				};
> +
> +				/* output port */
> +				port@1 {

s/port@1/port@0

> +					reg = <0>;
> +					etf0_out_port: endpoint {
> +						remote-endpoint =
> +							<&funnel2_in_port0>;
> +					};
> +				};
> +			};
> +		};
> +
> +		/* A73 cluster internal coresight */
> +		etm@4,ed440000 {

Same suggestion with CA53 cluster bindings for etm.

> +			compatible = "arm,coresight-etm4x","arm,primecell";
> +			reg = <0 0xed440000 0 0x1000>;
> +			clocks = <&pclk>;
> +			clock-names = "apb_pclk";
> +			cpu = <&cpu4>;
> +			port {
> +				etm4_out_port: endpoint {
> +				remote-endpoint = <&funnel1_in_port0>;
> +				};
> +			};
> +		};
> +
> +		etm@5,ed540000 {
> +			compatible = "arm,coresight-etm4x","arm,primecell";
> +			reg = <0 0xed540000 0 0x1000>;
> +			clocks = <&pclk>;
> +			clock-names = "apb_pclk";
> +			cpu = <&cpu5>;
> +			port {
> +				etm5_out_port: endpoint {
> +				remote-endpoint = <&funnel1_in_port1>;
> +				};
> +			};
> +		};
> +
> +		etm@6,ed640000 {
> +			compatible = "arm,coresight-etm4x","arm,primecell";
> +			reg = <0 0xed640000 0 0x1000>;
> +			clocks = <&pclk>;
> +			clock-names = "apb_pclk";
> +			cpu = <&cpu6>;
> +			port {
> +				etm6_out_port: endpoint {
> +					remote-endpoint = <&funnel1_in_port2>;
> +				};
> +			};
> +		};
> +
> +		etm@7,ed740000 {
> +			compatible = "arm,coresight-etm4x","arm,primecell";
> +			reg = <0 0xed740000 0 0x1000>;
> +			clocks = <&pclk>;
> +			clock-names = "apb_pclk";
> +			cpu = <&cpu7>;
> +			port {
> +				etm7_out_port: endpoint {
> +					remote-endpoint = <&funnel1_in_port3>;
> +				};
> +			};
> +		};
> +
> +		funnel1:funnel@1,ed001000 {

Same suggestion for funnel0.

> +			compatible = "arm,coresight-funnel","arm,primecell";
> +			reg = <0 0xed001000 0 0x1000>;
> +			clocks = <&pclk>;
> +			clock-names = "apb_pclk";
> +			ports {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +
> +				/* funnel output port */
> +				port@0 {
> +					reg = <0>;
> +					funnel1_out_port: endpoint {
> +						remote-endpoint =
> +							<&etf1_in_port>;
> +					};
> +				};
> +
> +				/* funnel input ports */
> +				port@1 {
> +					reg = <0>;
> +					funnel1_in_port0: endpoint {
> +						slave-mode;
> +						remote-endpoint =
> +							<&etm4_out_port>;
> +					};
> +				};
> +
> +				port@2 {
> +					reg = <1>;
> +					funnel1_in_port1: endpoint {
> +						slave-mode;
> +						remote-endpoint =
> +							<&etm5_out_port>;
> +					};
> +				};
> +
> +				port@3 {
> +					reg = <2>;
> +					funnel1_in_port2: endpoint {
> +						slave-mode;
> +						remote-endpoint =
> +							<&etm6_out_port>;
> +					};
> +				};
> +
> +				port@4 {
> +					reg = <3>;
> +					funnel1_in_port3: endpoint {
> +						slave-mode;
> +						remote-endpoint =
> +							<&etm7_out_port>;
> +					};
> +				};
> +			};
> +		};
> +
> +		etf1:etf@1,ed002000 {

Same suggestion for etf0.

> +			compatible = "arm,coresight-tmc","arm,primecell";
> +			reg = <0 0xed002000 0 0x1000>;
> +			clocks = <&pclk>;
> +			clock-names = "apb_pclk";
> +			ports {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				/* input port */
> +				port@0 {
> +					reg = <0>;
> +					etf1_in_port: endpoint {
> +						slave-mode;
> +						remote-endpoint =
> +							<&funnel1_out_port>;
> +					};
> +				};
> +
> +				/* output port */
> +				port@1 {
> +					reg = <0>;
> +					etf1_out_port: endpoint {
> +						remote-endpoint =
> +							<&funnel2_in_port0>;
> +					};
> +				};
> +			};
> +		};
> +
> +		/* Top coresight config */
> +		funnel@2,ec031000 {


> +			compatible = "arm,coresight-funnel","arm,primecell";
> +			reg = <0 0xec031000 0 0x1000>;
> +			clocks = <&pclk>;
> +			clock-names = "apb_pclk";
> +			ports {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +
> +				/* funnel output port */
> +				port@0 {
> +					reg = <0>;
> +					funnel2_out_port: endpoint {
> +						remote-endpoint =
> +							<&etf2_in_port>;
> +					};
> +				};
> +
> +				/* funnel input ports */
> +				port@1 {
> +					reg = <0>;
> +					funnel2_in_port0: endpoint {
> +						slave-mode;
> +						remote-endpoint =
> +							<&etf0_out_port>;
> +					};
> +				};

I think this funnel should have two input ports: one is for etf0 and
another is for connection etf1, but here it misses for etf1.

Do I miss anything for this?

> +			};
> +		};
> +
> +		etf@2,ec036000 {

Same suggestion for etf0/1.

> +			compatible = "arm,coresight-tmc","arm,primecell";
> +			reg = <0 0xec036000 0 0x1000>;
> +			clocks = <&pclk>;
> +			clock-names = "apb_pclk";
> +			ports {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				/* input port */
> +				port@0 {
> +					reg = <0>;
> +					etf2_in_port: endpoint {
> +						slave-mode;
> +						remote-endpoint =
> +							<&funnel2_out_port>;
> +					};
> +				};
> +
> +				/* output port */
> +				port@1 {
> +					reg = <0>;
> +					etf2_out_port: endpoint {
> +						remote-endpoint =
> +							<&replicator0_in_port>;
> +					};
> +				};
> +			};
> +		};
> +
> +		replicator {
> +			compatible = "arm,coresight-replicator";

Replicator doesn't have clock?

> +
> +			ports {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +
> +				/* etr out port  */
> +				port@0 {
> +					reg = <0>;
> +					replicator0_out_port0: endpoint {
> +						remote-endpoint =
> +							<&etr_in_port>;
> +					};
> +				};
> +				/* TPIU out port  */
> +				port@1 {
> +					reg = <1>;
> +					replicator0_out_port1: endpoint {
> +						remote-endpoint =
> +							<&tpiu_in_port>;
> +					};
> +				};
> +				/* input port  */
> +				port@2 {
> +					reg = <0>;
> +					replicator0_in_port: endpoint {
> +						slave-mode;
> +						remote-endpoint =
> +							<&etf2_out_port>;
> +					};
> +				};
> +			};
> +		};
> +
> +		etr@0,ec033000 {
> +			compatible = "arm,coresight-tmc","arm,primecell";
> +			reg = <0 0xec033000 0 0x1000>;
> +			clocks = <&pclk>;
> +			clock-names = "apb_pclk";
> +			ports {
> +				#address-cells = <1>;
> +				#size-cells = <0>;

Usually etr doesn't need to set address-cells and size-cell anymore.

> +
> +				/* etr input port  */
> +				port@0 {
> +					reg = <0>;


> +					etr_in_port: endpoint {
> +						slave-mode;

From Documentation/devicetree/bindings/arm/coresight.txt, I cannot see
there have 'slave-mode' property.

> +						remote-endpoint =
> +						<&replicator0_out_port0>;
> +					};
> +				};
> +			};
> +		};
> +
> +		tpiu@ec032000 {
> +			compatible = "arm,coresight-tpiu", "arm,primecell";
> +			reg = <0 0xec032000 0 0x1000>;
> +
> +			clocks = <&pclk>;
> +			clock-names = "apb_pclk";
> +			port {
> +				tpiu_in_port: endpoint {
> +					slave-mode;
> +					remote-endpoint =
> +						<&replicator0_out_port1>;
> +				};
> +			};
> +		};
> +	};

I don't see CPU debug module DT binding, could you add them as well?
You could use the single one patch to contain CPU debug module or use
one dedicated patch, both will be okay for me.

Thanks,
Leo Yan

> +};
> -- 
> 2.7.4
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
