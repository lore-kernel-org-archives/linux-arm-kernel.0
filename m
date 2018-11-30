Return-Path: <SRS0=AWyS=OJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA8E5C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 08:19:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC107206B7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 08:19:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ty7EwPgb";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="TrC0mYZ7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC107206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:Subject:Message-ID:References:
	In-Reply-To:From:To:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=oJ8m5F7+LtAoJ0x3k/v/kNVm3ktXG95lcJfPjkJ1GAk=; b=ty7EwPgbvZhsoA
	btcWQ5pCDeUi0yIMhSxmbA1xsB+ewNukg+1onhTupbOJRQTKamx5oHW/N51zyIyTOgIR3HyZjI9o7
	KgZrQik4vBBRTZ0KSoNHdFdfdFLm+z/Id1xIWPyp1b9bPhWxqNX9QREZ+2FdmjNtC5Izn/k/hzWOu
	RGyHLxZ1i0R+qOnXnsQc+hrpXikQURq2ZU2qcPCk6KV2lXTA5NlzB3ZCXRfd59qXyAcZ70yny0a8v
	SlFKTAE7y9lPf9TEGjvs0H6xAbaZ1e+fOBcjmzoWn3vQ6OfWHPtAN/FihZ1PJVwVsR1cbkpiIsEHm
	35KBRuTgduMtl25WBuqQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSe1Y-0002JU-G8; Fri, 30 Nov 2018 08:19:44 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSe1U-0002Hl-Ut
 for linux-arm-kernel@lists.infradead.org; Fri, 30 Nov 2018 08:19:42 +0000
Received: from localhost (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 56A21206B7;
 Fri, 30 Nov 2018 08:19:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1543565970;
 bh=89c0y6qOCfya/pnqhwHBjoAmqS816Oq09i7UpfPG0Es=;
 h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
 b=TrC0mYZ7YwvaMw3L77EHb1B5MFqE4Vl0b1c/agUIY6jb0LrBxELk4tCjow8RLFT50
 avKoH+bfm6ll7CeNLJVCTRFOe2LoGNTbHO4paE/r4m2k3010zPQDIQngwWqR+1MpYy
 BYW4OsCvDxIjhWSGJFKnbxVT0uX4DVZLZsVZAsGc=
MIME-Version: 1.0
To: Sugaya Taichi <sugaya.taichi@socionext.com>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1542589274-13878-7-git-send-email-sugaya.taichi@socionext.com>
References: <1542589274-13878-1-git-send-email-sugaya.taichi@socionext.com>
 <1542589274-13878-7-git-send-email-sugaya.taichi@socionext.com>
Message-ID: <154356596981.88331.14415961625410424962@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH 06/14] dt-bindings: clock: milbeaut: add Milbeaut clock
 description
Date: Fri, 30 Nov 2018 00:19:29 -0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181130_001941_052582_70D6E9D9 
X-CRM114-Status: GOOD (  15.28  )
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 Masami Hiramatsu <masami.hiramatsu@linaro.org>,
 Sugaya Taichi <sugaya.taichi@socionext.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Michael Turquette <mturquette@baylibre.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Russell King <linux@armlinux.org.uk>, Jassi Brar <jaswinder.singh@linaro.org>,
 Rob Herring <robh+dt@kernel.org>, Jiri Slaby <jslaby@suse.com>,
 Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Quoting Sugaya Taichi (2018-11-18 17:01:11)
> Add DT bindings document for Milbeaut clock.
> 
> Signed-off-by: Sugaya Taichi <sugaya.taichi@socionext.com>
> ---
>  .../devicetree/bindings/clock/milbeaut-clock.txt   | 93 ++++++++++++++++++++++
>  1 file changed, 93 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/milbeaut-clock.txt
> 
> diff --git a/Documentation/devicetree/bindings/clock/milbeaut-clock.txt b/Documentation/devicetree/bindings/clock/milbeaut-clock.txt
> new file mode 100644
> index 0000000..5c093c8
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/milbeaut-clock.txt
> @@ -0,0 +1,93 @@
> +Milbeaut M10V Clock Controller Binding
> +----------------------------------------
> +Milbeaut clock controller is consists of few oscillators, PLL, multiplexer
> +and few divider modules
> +
> +This binding uses common clock bindings
> +[1] Documentation/devicetree/bindings/clock/clock-bindings.txt
> +
> +Required properties:
> +- compatible: shall be "socionext,milbeaut-m10v-clk-regs"
> +- reg: shall contain base address and length of clock registers
> +- #clock-cells: shall be 0
> +
> +Example:
> +       m10v-clk-tree@ {
> +               compatible = "socionext,milbeaut-m10v-clk-regs";
> +               reg = <0x1d021000 0x4000>;
> +
> +               clocks {
> +                       #address-cells = <0>;
> +                       #size-cells = <0>;
> +
> +                       uclk40xi: uclk40xi {
> +                               compatible = "fixed-clock";
> +                               #clock-cells = <0>;
> +                               clock-frequency = <40000000>;
> +                       };
> +               };

This style of binding is highly discouraged. We don't describe each and
every clk in DT, we describe clk controllers and their outputs and
inputs in DT. The driver is the place where the clock controller
describes the internal clk topology of that controller. Also, fixed
frequency clks are typically oscillators and those would come from the
board dts file, but otherwise I wouldn't expect to see fixed frequency
clks in DT.

> +       }
> +
> +The clock consumer shall specify the desired clock-output of the clock
> +controller (as defined in [2]) by specifying output-id in its "clock"
> +phandle cell
> +[2] arch/arm/boot/dts/milbeaut-m10v-clk.h
> +
[...]
> +
> +Example
> +       piclk_mux_0: spiclk_mux_0 {
> +               compatible = "socionext,m10v-clk-div";
> +               #clock-cells = <0>;
> +               clocks = <&pll10_div_1_2>;
> +               offset = <bSPICLK>;
> +               mask = <0x3>;
> +               ratios = <4 0x5 2 0x4>;
> +       };
> +
> +       pll10: pll10 {
> +               compatible = "socionext,m10v-pll-fixed-factor";
> +               #clock-cells = <0>;
> +               clocks = <&uclk40xi>;
> +               offset = <10>;
> +               clock-div = <5>;
> +               clock-mult = <108>;
> +       };
> +
> +       emmcclk: emmcclk {
> +               compatible = "socionext,m10v-clk-div";
> +               #clock-cells = <0>;
> +               clocks = <&pll11>;
> +               offset = <bEMMCCLK>;
> +               mask = <0x3>;
> +               ratios = <15 0x7 10 0x6 9 0x5 8 0x4>;

Yeah, please no. This whole binding needs a rewrite to not have one node
per clk.


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
