Return-Path: <SRS0=LcWp=QO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 883DAC282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 20:23:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2ED6B21721
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 20:23:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="p2Us86yf";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gHL9u8sr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2ED6B21721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=arXFKfEQf1FCn8BsyTaL7i9tHD+J9pny3I6oyG7E9ys=; b=p2Us86yfET5dJl
	NGx36d141xrDCjayAqjatDihkB52s6YpeAr56IGxszeEK8mN67b2JWmh4zlwOLyCEbVCn2EzYR37F
	I6LTulYRFhiFAxSOgaqqikoXB2KGXDK8ZWSkQ3NgZSbGoNSF99EXZAhvT2cpkfm8OwTIPYG8C0NMS
	evMIv3fS9HpvZ4fWXh55k7il3Pp/AuLEpOH/nJTqM4NS0VHn5PHw1sxpY6PM627O7ikzONFzhYqMN
	cXAUNeSpPc0jQbgOqrDShW8bjDgNoqQFaXfmWRCXlUZHKy/eUS3qS71gaeW6n//PsuXZZNg5nriDi
	j+dJoDbioxhNBLvnWegA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grqCe-0004tB-2t; Thu, 07 Feb 2019 20:23:20 +0000
Received: from mail-it1-x143.google.com ([2607:f8b0:4864:20::143])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grqCa-0004sr-95
 for linux-arm-kernel@lists.infradead.org; Thu, 07 Feb 2019 20:23:18 +0000
Received: by mail-it1-x143.google.com with SMTP id w18so3210194ite.1
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 07 Feb 2019 12:23:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=L4HXxOdaCsnVhGkRh0bnCJqnJ0aqU7nV07dCxuZntys=;
 b=gHL9u8srUxNTIpQT2qQAUYMuQUI1QSKbLTB5bxMbsZtEZaqoHD6IrkJPhw1e/irLxI
 4hb7XtHXfM4ekMWaRJ6ESAsRgWqexnmwVx88Lpv3km8/BH7hYcQdwZTJCM4qHw70hley
 8hXDRhFhpuLr3P+5PENQN0pvaIFpefPJyO1OYHTyBPyokNfFLyEHXywyeELZatq92idw
 0mVz3rU3cBiA4i0zrV8yk+/IrZHIFw7CwWVXRDLRUtfm+vXTT8P3yES1wKmbfe9ekKNZ
 ZLCp51qN6WdWQCFSb3ZyCj50G4/b+ATFjn+AKQ1+E2WfDGwDo3UD5pYqY4Y7w2CCO+NX
 xfOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=L4HXxOdaCsnVhGkRh0bnCJqnJ0aqU7nV07dCxuZntys=;
 b=G0yg1AiizU5jgZCmjXG8+IWxcMBNrFM4d8lQtvJ3E42VfS+vWPU4Hjce8oj8O8dHLO
 aSTO/qyZNGSjUyMNT5BqSH+OfRXON/06VvfZDD+hDxUSVjRsLRABsmMpVREQwHiE/Egk
 WUUp3xKUJRJ7DdG4ZilYf4dtdBFxPcMhuvJCUFDtNZEqiYA2JvcCoUwTHSFF6pWmziJ8
 q8g3SnyMHKJaqoHoDIRGYnULZr5KP6JdgkyMEHWqhMSQ/UMb9/m26t7xw3BYxv2F8DI7
 OBLxjhcdNOVWEq7Mh4ry4E5x9/tXf7DOtZ0s3gdMHi1fCfHLV93rOj/JOrjQyOP89lmQ
 NoLw==
X-Gm-Message-State: AHQUAubyJKjgTEEfYTSaW9p9d6u8QcA1WFBbRMi6exGpCtT/+V3QHEiS
 ZfsVR5E3HcbKikNWosGdCedo/RstWoX0Lf1Y67HLFw==
X-Google-Smtp-Source: AHgI3IY4f8asq1f4WKMWVTBAkw7h95UGCdCus9g8BQMD/J6goLzRgo+Ri/wXiDWcq3YRqHO9YUioWeOYr1giRH2LRnk=
X-Received: by 2002:a24:fa04:: with SMTP id v4mr5651042ith.175.1549570995242; 
 Thu, 07 Feb 2019 12:23:15 -0800 (PST)
MIME-Version: 1.0
References: <cover.1548981329.git.saiprakash.ranjan@codeaurora.org>
 <ac141df0f056c9a50418c2d87a0d1cef17d49556.1548981329.git.saiprakash.ranjan@codeaurora.org>
In-Reply-To: <ac141df0f056c9a50418c2d87a0d1cef17d49556.1548981329.git.saiprakash.ranjan@codeaurora.org>
From: Mathieu Poirier <mathieu.poirier@linaro.org>
Date: Thu, 7 Feb 2019 13:23:04 -0700
Message-ID: <CANLsYkyZARfPS+mCJuQb5y1-KsTUMZ9eqQEHzkuamVyLWAF_JQ@mail.gmail.com>
Subject: Re: [PATCHv7 3/6] arm64: dts: qcom: msm8996: Add Coresight support
To: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190207_122316_334984_219696EE 
X-CRM114-Status: GOOD (  14.28  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, Jeffrey Hugo <jhugo@codeaurora.org>,
 Rajendra Nayak <rnayak@codeaurora.org>, Tingwei Zhang <tingwei@codeaurora.org>,
 Suzuki K Poulose <suzuki.poulose@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-arm-msm <linux-arm-msm@vger.kernel.org>,
 Marc Gonzalez <marc.w.gonzalez@free.fr>, Doug Anderson <dianders@chromium.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 David Brown <david.brown@linaro.org>, devicetree@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>, Sibi Sankar <sibis@codeaurora.org>,
 Vivek Gautam <vivek.gautam@codeaurora.org>, Leo Yan <leo.yan@linaro.org>,
 Andy Gross <andy.gross@linaro.org>, Stephen Boyd <sboyd@kernel.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 Mike Leach <mike.leach@linaro.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, 31 Jan 2019 at 17:54, Sai Prakash Ranjan
<saiprakash.ranjan@codeaurora.org> wrote:
>
> From: Vivek Gautam <vivek.gautam@codeaurora.org>
>
> Enable coresight support by adding device nodes for the
> available source, sinks and channel blocks on msm8996.
>
> This also adds coresight cpu debug nodes.
>
> Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
> Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
> ---
>  arch/arm64/boot/dts/qcom/msm8996.dtsi | 434 ++++++++++++++++++++++++++
>  1 file changed, 434 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
> index 99b7495455a6..3406a10f40db 100644
> --- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
> @@ -429,6 +429,440 @@
>                         reg = <0x300000 0x90000>;
>                 };
>
> +               stm@3002000 {
> +                       compatible = "arm,coresight-stm", "arm,primecell";
> +                       reg = <0x3002000 0x1000>,
> +                             <0x8280000 0x180000>;
> +                       reg-names = "stm-base", "stm-stimulus-base";
> +
> +                       clocks = <&rpmcc RPM_QDSS_CLK>, <&rpmcc RPM_QDSS_A_CLK>;
> +                       clock-names = "apb_pclk", "atclk";
> +
> +                       out-ports {
> +                               port {
> +                                       stm_out: endpoint {
> +                                               remote-endpoint =
> +                                                 <&funnel0_in>;
> +                                       };
> +                               };
> +                       };
> +               };
> +
> +               tpiu@3020000 {
> +                       compatible = "arm,coresight-tpiu", "arm,primecell";
> +                       reg = <0x3020000 0x1000>;
> +
> +                       clocks = <&rpmcc RPM_QDSS_CLK>, <&rpmcc RPM_QDSS_A_CLK>;
> +                       clock-names = "apb_pclk", "atclk";
> +
> +                       in-ports {
> +                               port {
> +                                       tpiu_in: endpoint {
> +                                               remote-endpoint =
> +                                                 <&replicator_out1>;
> +                                       };
> +                               };
> +                       };
> +               };
> +
> +               funnel@3021000 {
> +                       compatible = "arm,coresight-funnel", "arm,primecell";
> +                       reg = <0x3021000 0x1000>;
> +
> +                       clocks = <&rpmcc RPM_QDSS_CLK>, <&rpmcc RPM_QDSS_A_CLK>;
> +                       clock-names = "apb_pclk", "atclk";
> +
> +                       in-ports {
> +                               port {
> +                                       funnel0_in: endpoint {
> +                                               remote-endpoint =
> +                                                 <&stm_out>;
> +                                       };
> +                               };
> +                       };
> +
> +                       out-ports {
> +                               port {
> +                                       funnel0_out: endpoint {
> +                                               remote-endpoint =
> +                                                 <&merge_funnel_in0>;
> +                                       };
> +                               };
> +                       };
> +               };
> +
> +               funnel@3022000 {
> +                       compatible = "arm,coresight-funnel", "arm,primecell";
> +                       reg = <0x3022000 0x1000>;
> +
> +                       clocks = <&rpmcc RPM_QDSS_CLK>, <&rpmcc RPM_QDSS_A_CLK>;
> +                       clock-names = "apb_pclk", "atclk";
> +
> +                       in-ports {
> +                               port {
> +                                       funnel1_in: endpoint {
> +                                               remote-endpoint =
> +                                                 <&apss_merge_funnel_out>;
> +                                       };
> +                               };
> +                       };
> +
> +                       out-ports {
> +                               port {
> +                                       funnel1_out: endpoint {
> +                                               remote-endpoint =
> +                                                 <&merge_funnel_in1>;
> +                                       };
> +                               };
> +                       };
> +               };
> +
> +               funnel@3025000 {
> +                       compatible = "arm,coresight-funnel", "arm,primecell";
> +                       reg = <0x3025000 0x1000>;
> +
> +                       clocks = <&rpmcc RPM_QDSS_CLK>, <&rpmcc RPM_QDSS_A_CLK>;
> +                       clock-names = "apb_pclk", "atclk";
> +
> +                       in-ports {
> +                               #address-cells = <1>;
> +                               #size-cells = <0>;
> +
> +                               port@0 {
> +                                       reg = <0>;
> +                                       merge_funnel_in0: endpoint {
> +                                               remote-endpoint =
> +                                                 <&funnel0_out>;
> +                                       };
> +                               };
> +
> +                               port@1 {
> +                                       reg = <1>;
> +                                       merge_funnel_in1: endpoint {
> +                                               remote-endpoint =
> +                                                 <&funnel1_out>;
> +                                       };
> +                               };
> +                       };
> +
> +                       out-ports {
> +                               port {
> +                                       merge_funnel_out: endpoint {
> +                                               remote-endpoint =
> +                                                 <&etf_in>;
> +                                       };
> +                               };
> +                       };
> +               };
> +
> +               replicator@3026000 {
> +                       compatible = "arm,coresight-dynamic-replicator", "arm,primecell";
> +                       reg = <0x3026000 0x1000>;
> +
> +                       clocks = <&rpmcc RPM_QDSS_CLK>, <&rpmcc RPM_QDSS_A_CLK>;
> +                       clock-names = "apb_pclk", "atclk";
> +
> +                       in-ports {
> +                               port {
> +                                       replicator_in: endpoint {
> +                                               remote-endpoint =
> +                                                 <&etf_out>;
> +                                       };
> +                               };
> +                       };
> +
> +                       out-ports {
> +                               #address-cells = <1>;
> +                               #size-cells = <0>;
> +
> +                               port@0 {
> +                                       reg = <0>;
> +                                       replicator_out0: endpoint {
> +                                               remote-endpoint =
> +                                                 <&etr_in>;
> +                                       };
> +                               };
> +
> +                               port@1 {
> +                                       reg = <1>;
> +                                       replicator_out1: endpoint {
> +                                               remote-endpoint =
> +                                                 <&tpiu_in>;
> +                                       };
> +                               };
> +                       };
> +               };
> +
> +               etf@3027000 {
> +                       compatible = "arm,coresight-tmc", "arm,primecell";
> +                       reg = <0x3027000 0x1000>;
> +
> +                       clocks = <&rpmcc RPM_QDSS_CLK>, <&rpmcc RPM_QDSS_A_CLK>;
> +                       clock-names = "apb_pclk", "atclk";
> +
> +                       in-ports {
> +                               port {
> +                                       etf_in: endpoint {
> +                                               remote-endpoint =
> +                                                 <&merge_funnel_out>;
> +                                       };
> +                               };
> +                       };
> +
> +                       out-ports {
> +                               port {
> +                                       etf_out: endpoint {
> +                                               remote-endpoint =
> +                                                 <&replicator_in>;
> +                                       };
> +                               };
> +                       };
> +               };
> +
> +               etr@3028000 {
> +                       compatible = "arm,coresight-tmc", "arm,primecell";
> +                       reg = <0x3028000 0x1000>;
> +
> +                       clocks = <&rpmcc RPM_QDSS_CLK>, <&rpmcc RPM_QDSS_A_CLK>;
> +                       clock-names = "apb_pclk", "atclk";
> +                       arm,scatter-gather;
> +
> +                       in-ports {
> +                               port {
> +                                       etr_in: endpoint {
> +                                               remote-endpoint =
> +                                                 <&replicator_out0>;
> +                                       };
> +                               };
> +                       };
> +               };
> +
> +               debug@3810000 {
> +                       compatible = "arm,coresight-cpu-debug", "arm,primecell";
> +                       reg = <0x3810000 0x1000>;
> +
> +                       clocks = <&rpmcc RPM_QDSS_CLK>;
> +                       clock-names = "apb_pclk";
> +
> +                       cpu = <&CPU0>;
> +               };
> +
> +               etm@3840000 {
> +                       compatible = "arm,coresight-etm4x", "arm,primecell";
> +                       reg = <0x3840000 0x1000>;
> +
> +                       clocks = <&rpmcc RPM_QDSS_CLK>, <&rpmcc RPM_QDSS_A_CLK>;
> +                       clock-names = "apb_pclk", "atclk";
> +
> +                       cpu = <&CPU0>;
> +
> +                       out-ports {
> +                               port {
> +                                       etm0_out: endpoint {
> +                                               remote-endpoint =
> +                                                 <&apss_funnel0_in0>;
> +                                       };
> +                               };
> +                       };
> +               };
> +
> +               debug@3910000 {
> +                       compatible = "arm,coresight-cpu-debug", "arm,primecell";
> +                       reg = <0x3910000 0x1000>;
> +
> +                       clocks = <&rpmcc RPM_QDSS_CLK>;
> +                       clock-names = "apb_pclk";
> +
> +                       cpu = <&CPU1>;
> +               };
> +
> +               etm@3940000 {
> +                       compatible = "arm,coresight-etm4x", "arm,primecell";
> +                       reg = <0x3940000 0x1000>;
> +
> +                       clocks = <&rpmcc RPM_QDSS_CLK>, <&rpmcc RPM_QDSS_A_CLK>;
> +                       clock-names = "apb_pclk", "atclk";
> +
> +                       cpu = <&CPU1>;
> +
> +                       out-ports {
> +                               port {
> +                                       etm1_out: endpoint {
> +                                               remote-endpoint =
> +                                                 <&apss_funnel0_in1>;
> +                                       };
> +                               };
> +                       };
> +               };
> +
> +               funnel@39b0000 { /* APSS Funnel 0 */
> +                       compatible = "arm,coresight-funnel", "arm,primecell";
> +                       reg = <0x39b0000 0x1000>;
> +
> +                       clocks = <&rpmcc RPM_QDSS_CLK>, <&rpmcc RPM_QDSS_A_CLK>;
> +                       clock-names = "apb_pclk", "atclk";
> +
> +                       in-ports {
> +                               #address-cells = <1>;
> +                               #size-cells = <0>;
> +
> +                               port@0 {
> +                                       reg = <0>;
> +                                       apss_funnel0_in0: endpoint {
> +                                               remote-endpoint = <&etm0_out>;
> +                                       };
> +                               };
> +
> +                               port@1 {
> +                                       reg = <1>;
> +                                       apss_funnel0_in1: endpoint {
> +                                               remote-endpoint = <&etm1_out>;
> +                                       };
> +                               };
> +                       };
> +
> +                       out-ports {
> +                               port {
> +                                       apss_funnel0_out: endpoint {
> +                                               remote-endpoint =
> +                                                 <&apss_merge_funnel_in0>;
> +                                       };
> +                               };
> +                       };
> +               };
> +
> +               debug@3a10000 {
> +                       compatible = "arm,coresight-cpu-debug", "arm,primecell";
> +                       reg = <0x3a10000 0x1000>;
> +
> +                       clocks = <&rpmcc RPM_QDSS_CLK>;
> +                       clock-names = "apb_pclk";
> +
> +                       cpu = <&CPU2>;
> +               };
> +
> +               etm@3a40000 {
> +                       compatible = "arm,coresight-etm4x", "arm,primecell";
> +                       reg = <0x3a40000 0x1000>;
> +
> +                       clocks = <&rpmcc RPM_QDSS_CLK>, <&rpmcc RPM_QDSS_A_CLK>;
> +                       clock-names = "apb_pclk", "atclk";
> +
> +                       cpu = <&CPU2>;
> +
> +                       out-ports {
> +                               port {
> +                                       etm2_out: endpoint {
> +                                               remote-endpoint =
> +                                                 <&apss_funnel1_in0>;
> +                                       };
> +                               };
> +                       };
> +               };
> +
> +               debug@3b10000 {
> +                       compatible = "arm,coresight-cpu-debug", "arm,primecell";
> +                       reg = <0x3b10000 0x1000>;
> +
> +                       clocks = <&rpmcc RPM_QDSS_CLK>;
> +                       clock-names = "apb_pclk";
> +
> +                       cpu = <&CPU3>;
> +               };
> +
> +               etm@3b40000 {
> +                       compatible = "arm,coresight-etm4x", "arm,primecell";
> +                       reg = <0x3b40000 0x1000>;
> +
> +                       clocks = <&rpmcc RPM_QDSS_CLK>, <&rpmcc RPM_QDSS_A_CLK>;
> +                       clock-names = "apb_pclk", "atclk";
> +
> +                       cpu = <&CPU3>;
> +
> +                       out-ports {
> +                               port {
> +                                       etm3_out: endpoint {
> +                                               remote-endpoint =
> +                                                 <&apss_funnel1_in1>;
> +                                       };
> +                               };
> +                       };
> +               };
> +
> +               funnel@3bb0000 { /* APSS Funnel 1 */
> +                       compatible = "arm,coresight-funnel", "arm,primecell";
> +                       reg = <0x3bb0000 0x1000>;
> +
> +                       clocks = <&rpmcc RPM_QDSS_CLK>, <&rpmcc RPM_QDSS_A_CLK>;
> +                       clock-names = "apb_pclk", "atclk";
> +
> +                       in-ports {
> +                               #address-cells = <1>;
> +                               #size-cells = <0>;
> +
> +                               port@0 {
> +                                       reg = <0>;
> +                                       apss_funnel1_in0: endpoint {
> +                                               remote-endpoint = <&etm2_out>;
> +                                       };
> +                               };
> +
> +                               port@1 {
> +                                       reg = <1>;
> +                                       apss_funnel1_in1: endpoint {
> +                                               remote-endpoint = <&etm3_out>;
> +                                       };
> +                               };
> +                       };
> +
> +                       out-ports {
> +                               port {
> +                                       apss_funnel1_out: endpoint {
> +                                               remote-endpoint =
> +                                                 <&apss_merge_funnel_in1>;
> +                                       };
> +                               };
> +                       };
> +               };
> +
> +               funnel@3bc0000 {
> +                       compatible = "arm,coresight-funnel", "arm,primecell";
> +                       reg = <0x3bc0000 0x1000>;
> +
> +                       clocks = <&rpmcc RPM_QDSS_CLK>, <&rpmcc RPM_QDSS_A_CLK>;
> +                       clock-names = "apb_pclk", "atclk";
> +
> +                       in-ports {
> +                               #address-cells = <1>;
> +                               #size-cells = <0>;
> +
> +                               port@0 {
> +                                       reg = <0>;
> +                                       apss_merge_funnel_in0: endpoint {
> +                                               remote-endpoint =
> +                                                 <&apss_funnel0_out>;
> +                                       };
> +                               };
> +
> +                               port@1 {
> +                                       reg = <1>;
> +                                       apss_merge_funnel_in1: endpoint {
> +                                               remote-endpoint =
> +                                                 <&apss_funnel1_out>;
> +                                       };
> +                               };
> +                       };
> +
> +                       out-ports {
> +                               port {
> +                                       apss_merge_funnel_out: endpoint {
> +                                               remote-endpoint =
> +                                                 <&funnel1_in>;
> +                                       };
> +                               };
> +                       };
> +               };
> +

Normally you'd want to have two seperate patches for coresight and
cpu-debug but that is up up to the David and Andy to decide.

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>

>                 kryocc: clock-controller@6400000 {
>                         compatible = "qcom,apcc-msm8996";
>                         reg = <0x6400000 0x90000>;
> --
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
> of Code Aurora Forum, hosted by The Linux Foundation
>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
