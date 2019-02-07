Return-Path: <SRS0=LcWp=QO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5299C282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 20:20:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2A2721721
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 20:20:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="cWAEJ/rI";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XOCiZF7x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2A2721721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=uNVZchvqOxPH+mEeKeXonbVE/A7sGFeTkaVSZ02qMr4=; b=cWAEJ/rIo/1JZ5
	bRibBpQXGP0ubjomtfZdmeGQErzfrpyImx3oqVmN+CMJsFIklPw//k2rLqKNgEZKjIO0ADNJPdzZr
	S/yjWEIqgPqWnlydTS3/qR8VJS1eI55smaTP7Oww4kGXyII4L6bI9NBsdg8FygDoFf3eC6WTQO8uU
	2gxyhwzPJBu7UQ80yY6ssNVthu5VhHuIR5WHxTi5qddavTwFu4vdo4KVcgHXqvh/1qtHxLEYAeUbE
	2AApebWtA/JHAFdm5x/Tnn9/t8/mjKd9D7BUGzaBx0tG3oTJdTi9D6LgiqH4ES1CSHtOt4P2/W/JC
	Gmq1nVnCrpCktX9h5dLA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grqAC-0004OE-Sw; Thu, 07 Feb 2019 20:20:48 +0000
Received: from mail-it1-x144.google.com ([2607:f8b0:4864:20::144])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grqA8-0004N9-HI
 for linux-arm-kernel@lists.infradead.org; Thu, 07 Feb 2019 20:20:46 +0000
Received: by mail-it1-x144.google.com with SMTP id r6so3208830itk.0
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 07 Feb 2019 12:20:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=tWzwCKldWlDuITTwMKAcHQgrlKV0RwGXY1y6DlMqVYc=;
 b=XOCiZF7xJp01MIe3SOcVn3LKlEANd4CgDVy2wJMARJAwHCPM68qCpBkBVKtwSupN+J
 9BejkhK7882IEyaUXzPx7hEmRF8OAK8CiMQX+7ydT/bPkr0vh+8aQRqIbEquJXSsM4zo
 1mmYCc++HL9GOBxW9eoGZlBg3leMG/jRp3LP17r+JwSbxcXSzCN/o2UznZK6QRiBQlFv
 HWbVveeEaYQlhFSRPFxbKiv4euujbpAjjIeC5hKmX7+KGw0HeR/ZE6JPezBNdOV7XOsY
 kkkKN4nPj2P4eVwf1Py9RAHsoQ4HIShB505kLd8ASEdFhDFN29EfwebsCdyhilsz3ncC
 u9Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=tWzwCKldWlDuITTwMKAcHQgrlKV0RwGXY1y6DlMqVYc=;
 b=Ucdh2dOiMIcwjRDDrtOXML68kQJ5M2ll+R9srvSAZOOQYzLOSBbgwKFAUU7petdJTu
 T4byJ6TQoEU8rQg5JfWrZICkuODY0n91f5CKucmL+iT1f9yVEpDscM51yZb/G08X3lrJ
 pJ7Jqoe4Qy1zyOiLVAM3xJmOpNzNNYQA8KYnO4vgfm0oIt3kRCaIrfDAhpLfqLZksmmx
 OAvIbWSxRinrJmu0j2BWYETurYXMec2/52I/wraizub3rnAyhmnIt13p1Sufpwn9sgpc
 idc4hey3Y/4SUrZtg/Vkoi8P5XK2GPdvfbdcww8D+9Ymb4ibPdGkppgbXD/lmz5BehYo
 DtJA==
X-Gm-Message-State: AHQUAuZgQDFSyc0w1oYkcB8EOVq2AZKba8m/ztl7Pk+Y/AW/0boQKHey
 XhCcp7vConlV6x5KAWYjuR5jvFcblj5JpyKJmVxZ+Q==
X-Google-Smtp-Source: AHgI3IZ2u/S5LEE6Ry5w1eOwwLQC/nk2IyU9DvfSvOEjESn5FRiPx+07Dfwce4nL4uTXafwoj6WAcMsEWKJPGt2Ieug=
X-Received: by 2002:a24:db02:: with SMTP id c2mr6795769itg.137.1549570843200; 
 Thu, 07 Feb 2019 12:20:43 -0800 (PST)
MIME-Version: 1.0
References: <cover.1548981329.git.saiprakash.ranjan@codeaurora.org>
 <bcff6cd655c565568caa2d5a9b20d95e619afb1e.1548981329.git.saiprakash.ranjan@codeaurora.org>
In-Reply-To: <bcff6cd655c565568caa2d5a9b20d95e619afb1e.1548981329.git.saiprakash.ranjan@codeaurora.org>
From: Mathieu Poirier <mathieu.poirier@linaro.org>
Date: Thu, 7 Feb 2019 13:20:32 -0700
Message-ID: <CANLsYkwc_HQf=ghP7La7szKuPwVmdzjcr-91Z70hmzEGAEC+_A@mail.gmail.com>
Subject: Re: [PATCHv7 2/6] arm64: dts: qcom: msm8998: Add Coresight support
To: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190207_122044_578091_902A0527 
X-CRM114-Status: GOOD (  14.30  )
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
> Enable coresight support by adding device nodes for the
> available source, sinks and channel blocks on MSM8998.
>
> Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
>
> ---
> For testing, all dependent patches are in below tree:
>  * https://github.com/saiprakash-ranjan/linux/tree/coresight-next
>
> This depends on MSM8998 rpm clocks and rpmcc node by Jeffrey Hugo
> and Marc Gonzalez [1][2][3].
>
> [1] https://lore.kernel.org/lkml/1545099336-5615-1-git-send-email-jhugo@codeaurora.org/
> [2] https://lore.kernel.org/lkml/1548866144-30265-1-git-send-email-jhugo@codeaurora.org/
> [3] https://lore.kernel.org/lkml/6da00186-e7c9-c93d-a80a-65eda2516451@free.fr/
> ---
>  arch/arm64/boot/dts/qcom/msm8998.dtsi | 435 ++++++++++++++++++++++++++
>  1 file changed, 435 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/msm8998.dtsi b/arch/arm64/boot/dts/qcom/msm8998.dtsi
> index eb691be6e171..3020a76ed201 100644
> --- a/arch/arm64/boot/dts/qcom/msm8998.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8998.dtsi
> @@ -566,6 +566,441 @@
>                         #interrupt-cells = <0x2>;
>                 };
>
> +               stm@6002000 {
> +                       compatible = "arm,coresight-stm", "arm,primecell";
> +                       reg = <0x06002000 0x1000>,
> +                             <0x16280000 0x180000>;
> +                       reg-names = "stm-base", "stm-data-base";
> +
> +                       clocks = <&rpmcc RPM_SMD_QDSS_CLK>, <&rpmcc RPM_SMD_QDSS_A_CLK>;
> +                       clock-names = "apb_pclk", "atclk";
> +
> +                       out-ports {
> +                               port {
> +                                       stm_out: endpoint {
> +                                               remote-endpoint = <&funnel0_in7>;
> +                                       };
> +                               };
> +                       };
> +               };
> +
> +               funnel@6041000 {
> +                       compatible = "arm,coresight-funnel", "arm,primecell";
> +                       reg = <0x06041000 0x1000>;
> +
> +                       clocks = <&rpmcc RPM_SMD_QDSS_CLK>, <&rpmcc RPM_SMD_QDSS_A_CLK>;
> +                       clock-names = "apb_pclk", "atclk";
> +
> +                       out-ports {
> +                               port {
> +                                       funnel0_out: endpoint {
> +                                               remote-endpoint =
> +                                                 <&merge_funnel_in0>;
> +                                       };
> +                               };
> +                       };
> +
> +                       in-ports {
> +                               #address-cells = <1>;
> +                               #size-cells = <0>;
> +
> +                               port@7 {
> +                                       reg = <7>;
> +                                       funnel0_in7: endpoint {
> +                                               remote-endpoint = <&stm_out>;
> +                                       };
> +                               };
> +                       };
> +               };
> +
> +               funnel@6042000 {
> +                       compatible = "arm,coresight-funnel", "arm,primecell";
> +                       reg = <0x06042000 0x1000>;
> +
> +                       clocks = <&rpmcc RPM_SMD_QDSS_CLK>, <&rpmcc RPM_SMD_QDSS_A_CLK>;
> +                       clock-names = "apb_pclk", "atclk";
> +
> +                       out-ports {
> +                               port {
> +                                       funnel1_out: endpoint {
> +                                               remote-endpoint =
> +                                                 <&merge_funnel_in1>;
> +                                       };
> +                               };
> +                       };
> +
> +                       in-ports {
> +                               #address-cells = <1>;
> +                               #size-cells = <0>;
> +
> +                               port@6 {
> +                                       reg = <6>;
> +                                       funnel1_in6: endpoint {
> +                                               remote-endpoint =
> +                                                 <&apss_merge_funnel_out>;
> +                                       };
> +                               };
> +                       };
> +               };
> +
> +               funnel@6045000 {
> +                       compatible = "arm,coresight-funnel", "arm,primecell";
> +                       reg = <0x06045000 0x1000>;
> +
> +                       clocks = <&rpmcc RPM_SMD_QDSS_CLK>, <&rpmcc RPM_SMD_QDSS_A_CLK>;
> +                       clock-names = "apb_pclk", "atclk";
> +
> +                       out-ports {
> +                               port {
> +                                       merge_funnel_out: endpoint {
> +                                               remote-endpoint =
> +                                                 <&etf_in>;
> +                                       };
> +                               };
> +                       };
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
> +               };
> +
> +               replicator@6046000 {
> +                       compatible = "arm,coresight-dynamic-replicator", "arm,primecell";
> +                       reg = <0x06046000 0x1000>;
> +
> +                       clocks = <&rpmcc RPM_SMD_QDSS_CLK>, <&rpmcc RPM_SMD_QDSS_A_CLK>;
> +                       clock-names = "apb_pclk", "atclk";
> +
> +                       out-ports {
> +                               port {
> +                                       replicator_out: endpoint {
> +                                               remote-endpoint = <&etr_in>;
> +                                       };
> +                               };
> +                       };
> +
> +                       in-ports {
> +                               port {
> +                                       replicator_in: endpoint {
> +                                               remote-endpoint = <&etf_out>;
> +                                       };
> +                               };
> +                       };
> +               };
> +
> +               etf@6047000 {
> +                       compatible = "arm,coresight-tmc", "arm,primecell";
> +                       reg = <0x06047000 0x1000>;
> +
> +                       clocks = <&rpmcc RPM_SMD_QDSS_CLK>, <&rpmcc RPM_SMD_QDSS_A_CLK>;
> +                       clock-names = "apb_pclk", "atclk";
> +
> +                       out-ports {
> +                               port {
> +                                       etf_out: endpoint {
> +                                               remote-endpoint =
> +                                                 <&replicator_in>;
> +                                       };
> +                               };
> +                       };
> +
> +                       in-ports {
> +                               port {
> +                                       etf_in: endpoint {
> +                                               remote-endpoint =
> +                                                 <&merge_funnel_out>;
> +                                       };
> +                               };
> +                       };
> +               };
> +
> +               etr@6048000 {
> +                       compatible = "arm,coresight-tmc", "arm,primecell";
> +                       reg = <0x06048000 0x1000>;
> +
> +                       clocks = <&rpmcc RPM_SMD_QDSS_CLK>, <&rpmcc RPM_SMD_QDSS_A_CLK>;
> +                       clock-names = "apb_pclk", "atclk";
> +                       arm,scatter-gather;
> +
> +                       in-ports {
> +                               port {
> +                                       etr_in: endpoint {
> +                                               remote-endpoint =
> +                                                 <&replicator_out>;
> +                                       };
> +                               };
> +                       };
> +               };
> +
> +               etm@7840000 {
> +                       compatible = "arm,coresight-etm4x", "arm,primecell";
> +                       reg = <0x07840000 0x1000>;
> +
> +                       clocks = <&rpmcc RPM_SMD_QDSS_CLK>, <&rpmcc RPM_SMD_QDSS_A_CLK>;
> +                       clock-names = "apb_pclk", "atclk";
> +
> +                       cpu = <&CPU0>;
> +
> +                       out-ports {
> +                               port {
> +                                       etm0_out: endpoint {
> +                                               remote-endpoint =
> +                                                 <&apss_funnel_in0>;
> +                                       };
> +                               };
> +                       };
> +               };
> +
> +               etm@7940000 {
> +                       compatible = "arm,coresight-etm4x", "arm,primecell";
> +                       reg = <0x07940000 0x1000>;
> +
> +                       clocks = <&rpmcc RPM_SMD_QDSS_CLK>, <&rpmcc RPM_SMD_QDSS_A_CLK>;
> +                       clock-names = "apb_pclk", "atclk";
> +
> +                       cpu = <&CPU1>;
> +
> +                       out-ports {
> +                               port {
> +                                       etm1_out: endpoint {
> +                                               remote-endpoint =
> +                                                 <&apss_funnel_in1>;
> +                                       };
> +                               };
> +                       };
> +               };
> +
> +               etm@7a40000 {
> +                       compatible = "arm,coresight-etm4x", "arm,primecell";
> +                       reg = <0x07a40000 0x1000>;
> +
> +                       clocks = <&rpmcc RPM_SMD_QDSS_CLK>, <&rpmcc RPM_SMD_QDSS_A_CLK>;
> +                       clock-names = "apb_pclk", "atclk";
> +
> +                       cpu = <&CPU2>;
> +
> +                       out-ports {
> +                               port {
> +                                       etm2_out: endpoint {
> +                                               remote-endpoint =
> +                                                 <&apss_funnel_in2>;
> +                                       };
> +                               };
> +                       };
> +               };
> +
> +               etm@7b40000 {
> +                       compatible = "arm,coresight-etm4x", "arm,primecell";
> +                       reg = <0x07b40000 0x1000>;
> +
> +                       clocks = <&rpmcc RPM_SMD_QDSS_CLK>, <&rpmcc RPM_SMD_QDSS_A_CLK>;
> +                       clock-names = "apb_pclk", "atclk";
> +
> +                       cpu = <&CPU3>;
> +
> +                       out-ports {
> +                               port {
> +                                       etm3_out: endpoint {
> +                                               remote-endpoint =
> +                                                 <&apss_funnel_in3>;
> +                                       };
> +                               };
> +                       };
> +               };
> +
> +               funnel@7b60000 { /* APSS Funnel */
> +                       compatible = "arm,coresight-etm4x", "arm,primecell";
> +                       reg = <0x07b60000 0x1000>;
> +
> +                       clocks = <&rpmcc RPM_SMD_QDSS_CLK>, <&rpmcc RPM_SMD_QDSS_A_CLK>;
> +                       clock-names = "apb_pclk", "atclk";
> +
> +                       out-ports {
> +                               port {
> +                                       apss_funnel_out: endpoint {
> +                                               remote-endpoint =
> +                                                 <&apss_merge_funnel_in>;
> +                                       };
> +                               };
> +                       };
> +
> +                       in-ports {
> +                               #address-cells = <1>;
> +                               #size-cells = <0>;
> +
> +                               port@0 {
> +                                       reg = <0>;
> +                                       apss_funnel_in0: endpoint {
> +                                               remote-endpoint =
> +                                                 <&etm0_out>;
> +                                       };
> +                               };
> +
> +                               port@1 {
> +                                       reg = <1>;
> +                                       apss_funnel_in1: endpoint {
> +                                               remote-endpoint =
> +                                                 <&etm1_out>;
> +                                       };
> +                               };
> +
> +                               port@2 {
> +                                       reg = <2>;
> +                                       apss_funnel_in2: endpoint {
> +                                               remote-endpoint =
> +                                                 <&etm2_out>;
> +                                       };
> +                               };
> +
> +                               port@3 {
> +                                       reg = <3>;
> +                                       apss_funnel_in3: endpoint {
> +                                               remote-endpoint =
> +                                                 <&etm3_out>;
> +                                       };
> +                               };
> +
> +                               port@4 {
> +                                       reg = <4>;
> +                                       apss_funnel_in4: endpoint {
> +                                               remote-endpoint =
> +                                                 <&etm4_out>;
> +                                       };
> +                               };
> +
> +                               port@5 {
> +                                       reg = <5>;
> +                                       apss_funnel_in5: endpoint {
> +                                               remote-endpoint =
> +                                                 <&etm5_out>;
> +                                       };
> +                               };
> +
> +                               port@6 {
> +                                       reg = <6>;
> +                                       apss_funnel_in6: endpoint {
> +                                               remote-endpoint =
> +                                                 <&etm6_out>;
> +                                       };
> +                               };
> +
> +                               port@7 {
> +                                       reg = <7>;
> +                                       apss_funnel_in7: endpoint {
> +                                               remote-endpoint =
> +                                                 <&etm7_out>;
> +                                       };
> +                               };
> +                       };
> +               };
> +
> +               funnel@7b70000 {
> +                       compatible = "arm,coresight-funnel", "arm,primecell";
> +                       reg = <0x07b70000 0x1000>;
> +
> +                       clocks = <&rpmcc RPM_SMD_QDSS_CLK>, <&rpmcc RPM_SMD_QDSS_A_CLK>;
> +                       clock-names = "apb_pclk", "atclk";
> +
> +                       out-ports {
> +                               port {
> +                                       apss_merge_funnel_out: endpoint {
> +                                               remote-endpoint =
> +                                                 <&funnel1_in6>;
> +                                       };
> +                               };
> +                       };
> +
> +                       in-ports {
> +                               port {
> +                                       apss_merge_funnel_in: endpoint {
> +                                               remote-endpoint =
> +                                                 <&apss_funnel_out>;
> +                                       };
> +                               };
> +                       };
> +               };
> +
> +               etm@7c40000 {
> +                       compatible = "arm,coresight-etm4x", "arm,primecell";
> +                       reg = <0x07c40000 0x1000>;
> +
> +                       clocks = <&rpmcc RPM_SMD_QDSS_CLK>, <&rpmcc RPM_SMD_QDSS_A_CLK>;
> +                       clock-names = "apb_pclk", "atclk";
> +
> +                       cpu = <&CPU4>;
> +
> +                       port{
> +                               etm4_out: endpoint {
> +                                       remote-endpoint = <&apss_funnel_in4>;
> +                               };
> +                       };
> +               };
> +
> +               etm@7d40000 {
> +                       compatible = "arm,coresight-etm4x", "arm,primecell";
> +                       reg = <0x07d40000 0x1000>;
> +
> +                       clocks = <&rpmcc RPM_SMD_QDSS_CLK>, <&rpmcc RPM_SMD_QDSS_A_CLK>;
> +                       clock-names = "apb_pclk", "atclk";
> +
> +                       cpu = <&CPU5>;
> +
> +                       port{
> +                               etm5_out: endpoint {
> +                                       remote-endpoint = <&apss_funnel_in5>;
> +                               };
> +                       };
> +               };
> +
> +               etm@7e40000 {
> +                       compatible = "arm,coresight-etm4x", "arm,primecell";
> +                       reg = <0x07e40000 0x1000>;
> +
> +                       clocks = <&rpmcc RPM_SMD_QDSS_CLK>, <&rpmcc RPM_SMD_QDSS_A_CLK>;
> +                       clock-names = "apb_pclk", "atclk";
> +
> +                       cpu = <&CPU6>;
> +
> +                       port{
> +                               etm6_out: endpoint {
> +                                       remote-endpoint = <&apss_funnel_in6>;
> +                               };
> +                       };
> +               };
> +
> +               etm@7f40000 {
> +                       compatible = "arm,coresight-etm4x", "arm,primecell";
> +                       reg = <0x07f40000 0x1000>;
> +
> +                       clocks = <&rpmcc RPM_SMD_QDSS_CLK>, <&rpmcc RPM_SMD_QDSS_A_CLK>;
> +                       clock-names = "apb_pclk", "atclk";
> +
> +                       cpu = <&CPU7>;
> +
> +                       port{
> +                               etm7_out: endpoint {
> +                                       remote-endpoint = <&apss_funnel_in7>;
> +                               };
> +                       };
> +               };
> +
>                 spmi_bus: spmi@800f000 {
>                         compatible = "qcom,spmi-pmic-arb";
>                         reg =   <0x800f000 0x1000>,
> --
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
> of Code Aurora Forum, hosted by The Linux Foundation
>

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
