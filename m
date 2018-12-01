Return-Path: <SRS0=4WgJ=OK=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BC92C64EB4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 00:47:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B42C20867
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 00:47:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ttZtrbRU";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="A7LzCfW8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B42C20867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=hcdmPg6FpJWKTcLDvxmaz5dFZ5EG4EvCOeldmZ58RYs=; b=ttZtrbRU4btVJ1
	9EI2+Rppl5/bfmAynT3X2O8c9TfjxZBVeQi2GlicVtxHO0IAwZpQCT4h4pCztKs+hBC19U++aJ/UL
	/B9Ce8Z/+bWGJemLbbL70MJI+kXdc7snGEadcFHOdxgX1C+P7urhAzxriwlrbxxAsANP42df7ULGN
	VtqhIDNhuR88SwKez4L81z5s6P3a7hHMLWvYAllhyPR2CnPPgNKPdnEGMu8tSuyCd0eF4ktFGErge
	vpFHDud75rdswGo4ruC5qmwF+Adhuu2ZNrjjoItXYHl/n5RAUrtl+IPtKDepSOYpgaXJ6NGUofuW4
	hHyFq2xjBScwmy50QCNQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gStRG-0001DP-FI; Sat, 01 Dec 2018 00:47:18 +0000
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gStRB-0001CD-Uz
 for linux-arm-kernel@lists.infradead.org; Sat, 01 Dec 2018 00:47:16 +0000
Received: by mail-lj1-x244.google.com with SMTP id v1-v6so6563903ljd.0
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 30 Nov 2018 16:47:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=kUwgOG2FwKn73vdyjMJ9x8UdUTas2QjkWsYuqenQdmk=;
 b=A7LzCfW8fURMHCJvh+eCrnoMDst+w2MVobrY/ZRoPlxnsGPWMEUvJXYP77/Y0ZJnSA
 2Vhypd2U8MDqCiOJmmUADxU5zMOS6bPMoXSseYHpjLXLLJJ8sq/v2roeVEOBMODAFJle
 Znz3Vp4EV3lEU+OabVzWSKhiwqKwKnRyH1oUs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=kUwgOG2FwKn73vdyjMJ9x8UdUTas2QjkWsYuqenQdmk=;
 b=eHqKqe8DPORe+G6SxGhjEiju1N18jy9MwbuxttT3+Bx4RT5WqukhjuDqp253qb/atS
 yRBAghYFNiEDrmaE9z0PoU76hpVOiBdIyqgnN1dRNk+Rbf1iZWiI1otRjOPajXapptJM
 nblyrW2n+3mTU8GI5JjGyWQR22aS9vO9weze0kG9indWVaKjV0bT+o0MHq8HwYCPkiBA
 E7TaeK3wMAxuJQ36EA8nCZbdzCoIxXEc/90ng+bulycXIKU5XoiioEgnOz+TAlUnB3Kl
 MfIq5DQ0Iqn/f2FDNxGgLBqGhThcd06t4lxX/Z4pTHINj+4IQ0WxP/3ArlmI0gLU6aD7
 vVYg==
X-Gm-Message-State: AA+aEWZ2XYMHvdBY7TCGKV7zYfhcfUOAx27gUg8kVf+qhS4NNLelnjLM
 EmJOTw7CkE5qNFa9FkMtEnmFYHS01S4=
X-Google-Smtp-Source: AFSGD/WeB2pZlT/jeR+vMUvQqdW6Zv1S2pmLd1O53leFNR7gyguRS7Hv6SgHUz62MQVcF27B/WQZSg==
X-Received: by 2002:a2e:7615:: with SMTP id
 r21-v6mr4934886ljc.131.1543625222181; 
 Fri, 30 Nov 2018 16:47:02 -0800 (PST)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com.
 [209.85.208.181])
 by smtp.gmail.com with ESMTPSA id y12-v6sm1036191ljy.76.2018.11.30.16.47.01
 for <linux-arm-kernel@lists.infradead.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 30 Nov 2018 16:47:01 -0800 (PST)
Received: by mail-lj1-f181.google.com with SMTP id u6-v6so6560748ljd.1
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 30 Nov 2018 16:47:01 -0800 (PST)
X-Received: by 2002:a2e:501:: with SMTP id 1-v6mr5641242ljf.74.1543624747961; 
 Fri, 30 Nov 2018 16:39:07 -0800 (PST)
MIME-Version: 1.0
References: <20181127180349.29997-1-georgi.djakov@linaro.org>
 <20181127180349.29997-3-georgi.djakov@linaro.org>
In-Reply-To: <20181127180349.29997-3-georgi.djakov@linaro.org>
From: Evan Green <evgreen@chromium.org>
Date: Fri, 30 Nov 2018 16:38:31 -0800
X-Gmail-Original-Message-ID: <CAE=gft5z0=Rp_+jj2JTKF4Kn-RB6AK0Ke1ByUuRwrZHwvNDcCg@mail.gmail.com>
Message-ID: <CAE=gft5z0=Rp_+jj2JTKF4Kn-RB6AK0Ke1ByUuRwrZHwvNDcCg@mail.gmail.com>
Subject: Re: [PATCH v10 2/7] dt-bindings: Introduce interconnect binding
To: georgi.djakov@linaro.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181130_164714_676269_1209440F 
X-CRM114-Status: GOOD (  20.44  )
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
Cc: mark.rutland@arm.com, sanjayc@nvidia.com, maxime.ripard@bootlin.com,
 Michael Turquette <mturquette@baylibre.com>, daidavid1@codeaurora.org,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 Saravana Kannan <skannan@codeaurora.org>,
 Alexandre Bailon <abailon@baylibre.com>, lorenzo.pieralisi@arm.com,
 Vincent Guittot <vincent.guittot@linaro.org>, seansw@qti.qualcomm.com,
 khilman@baylibre.com, ksitaraman@nvidia.com, devicetree@vger.kernel.org,
 Arnd Bergmann <arnd@arndb.de>, linux-pm@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, robh+dt@kernel.org, linux-tegra@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, gregkh@linuxfoundation.org,
 rjw@rjwysocki.net, linux-kernel@vger.kernel.org, amit.kucheria@linaro.org,
 thierry.reding@gmail.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Nov 27, 2018 at 10:03 AM Georgi Djakov <georgi.djakov@linaro.org> wrote:
>
> This binding is intended to represent the relations between the interconnect
> controllers (providers) and consumer device nodes. It will allow creating links
> between consumers and interconnect paths (exposed by interconnect providers).
>
> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
> ---
>  .../bindings/interconnect/interconnect.txt    | 60 +++++++++++++++++++
>  1 file changed, 60 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interconnect/interconnect.txt
>
> diff --git a/Documentation/devicetree/bindings/interconnect/interconnect.txt b/Documentation/devicetree/bindings/interconnect/interconnect.txt
> new file mode 100644
> index 000000000000..6775c07e1574
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interconnect/interconnect.txt
> @@ -0,0 +1,60 @@
> +Interconnect Provider Device Tree Bindings
> +=========================================
> +
> +The purpose of this document is to define a common set of generic interconnect
> +providers/consumers properties.
> +
> +
> += interconnect providers =
> +
> +The interconnect provider binding is intended to represent the interconnect
> +controllers in the system. Each provider registers a set of interconnect
> +nodes, which expose the interconnect related capabilities of the interconnect
> +to consumer drivers. These capabilities can be throughput, latency, priority
> +etc. The consumer drivers set constraints on interconnect path (or endpoints)
> +depending on the use case. Interconnect providers can also be interconnect
> +consumers, such as in the case where two network-on-chip fabrics interface
> +directly.
> +
> +Required properties:
> +- compatible : contains the interconnect provider compatible string
> +- #interconnect-cells : number of cells in a interconnect specifier needed to
> +                       encode the interconnect node id
> +
> +Example:
> +
> +               snoc: interconnect@580000 {
> +                       compatible = "qcom,msm8916-snoc";
> +                       #interconnect-cells = <1>;
> +                       reg = <0x580000 0x14000>;
> +                       clock-names = "bus_clk", "bus_a_clk";
> +                       clocks = <&rpmcc RPM_SMD_SNOC_CLK>,
> +                                <&rpmcc RPM_SMD_SNOC_A_CLK>;
> +               };
> +
> +
> += interconnect consumers =
> +
> +The interconnect consumers are device nodes which dynamically express their
> +bandwidth requirements along interconnect paths they are connected to. There
> +can be multiple interconnect providers on a SoC and the consumer may consume
> +multiple paths from different providers depending on use case and the
> +components it has to interact with.
> +
> +Required properties:
> +interconnects : Pairs of phandles and interconnect provider specifier to denote
> +               the edge source and destination ports of the interconnect path.
> +
> +Optional properties:
> +interconnect-names : List of interconnect path name strings sorted in the same
> +                    order as the interconnects property. Consumers drivers will use
> +                    interconnect-names to match interconnect paths with interconnect
> +                    specifier pairs.
> +
> +Example:
> +
> +       sdhci@7864000 {
> +               ...
> +               interconnects = <&pnoc MASTER_SDCC_1 &bimc SLAVE_EBI_CH0>;
> +               interconnect-names = "sdhc-ddr";
> +       };

Reviewed-by: Evan Green <evgreen@chromium.org>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
