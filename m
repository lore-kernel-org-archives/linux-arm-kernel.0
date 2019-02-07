Return-Path: <SRS0=LcWp=QO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2CBAC282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 20:20:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5871C2175B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 20:20:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="E3Bozc5b";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="I3WLKB38"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5871C2175B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=JdazLzAG/s1iTA3xQ5xLHB7kGT3jhbgVrZ4bJ9a9zi0=; b=E3Bozc5bPcvRmv
	lrsc90DcteqvdqDVMKFEZHGJ9PHLfxGSfQ2yq2r+Spr0xVrQWRANYg/8g4XaMoQEN6lgBR6yVijOs
	gtXTbUC7x5OoQUz9KU5mkZhvTBNJJ7Ak/4nAL9tuANIuYhomXRhTpMZdkJVSRkaaibmpRb4jmDBbz
	zY/9ppXUCbKY3RECemuL+8L9dshyuVvCwJao2vVsPX4MyhUE9tayq0TJwkVjQDktIlb6Hdl9t4WpW
	mykAxt4agHVUdTwQ59Gj4xACZ1N8Jypbr4e/jwSOErhlJGXnLW8Ne9/GCjgWfuZ8JlP6UnAKZ2nvY
	lNc48iJu6i3YYxjs0+aQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grq9W-0003Am-UO; Thu, 07 Feb 2019 20:20:06 +0000
Received: from mail-it1-x144.google.com ([2607:f8b0:4864:20::144])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grq9S-0002oL-KG
 for linux-arm-kernel@lists.infradead.org; Thu, 07 Feb 2019 20:20:04 +0000
Received: by mail-it1-x144.google.com with SMTP id z7so3208896iti.0
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 07 Feb 2019 12:20:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Jd6Vn44Ds9llNxhimEhOJ4Nz7VLPTCK8kFHEDz2iY3c=;
 b=I3WLKB38MvmcYZFvL1bune86uhxzTahX8TYjT+9RdeZu+GDzPWh6+T3eRnwHVfjFrI
 7zzqUUQ3cKfEfmpM/x0lK+yXSSOfoeTdsaxGQfEhMOjUpJl/aGqEqMoFvsmI9gYXMmei
 6kOma3TQzLysDj6A6uKFRlsDF6wJWgh7lIp4X7q+Q2oTZAZao8zXJ/pR8MamWcd8k1QQ
 WhfedisibXOdYXFV9ev/pN1HITSMDWJag+FU9r8qlU3BIFJcvP9TeQRiN568KLteb933
 /LHv74tSwt8d7prMZpmt1SZszfXWGYdNOY9xHeIH5KiHBZsXGCtNM3+K2PUnfbLo6lEI
 ZJvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Jd6Vn44Ds9llNxhimEhOJ4Nz7VLPTCK8kFHEDz2iY3c=;
 b=n1Gus/Ki9TrNMb1R9LcDxNidseplAzo0cysMFEi1XhQGreBAznxiEdgc4t1VWvYHTD
 hlxCsWuLJWBwP+I/PRWURk3uow+pkf+SLqSIarSf/YRkU5SWzG6emWV5ZWXjrEVxEunX
 d2U/Sx8wnXlQPv5ffKicdfLYzIeQTBQzaGFZfKWplcHHEkh9Tqvz5MQVM/iKDXoetM4z
 ivhzXFcxCwSd05WpBebRtI67WYxEOlAGkdNuZC16zR/vhUZSkPKzW1VkQMKeQAjv1Vxf
 /QNk+ZL/wEIocZ6vkvE1laYvvob4HNK1OCrXVoHlhprYdk0FGfadgxkEvXamhs8ODsVV
 iVwA==
X-Gm-Message-State: AHQUAubIMRFioq1q874Rx9ahMdVzIZFV2ybZC6ub9GG9ywj5QGosxEmG
 sIYSLOqM8dTjKgGsDb28S/pyHYzmeeFRsquYsgzS0w==
X-Google-Smtp-Source: AHgI3IYoM6DUohbpI4dzh4n2mDHyJqLXGzUglERjrTYLpCNKj0O52KZ5VAJEUZGklwA/WH+zpZ/XdggsVOrLgEwu52w=
X-Received: by 2002:a5d:960e:: with SMTP id w14mr8729064iol.86.1549570800018; 
 Thu, 07 Feb 2019 12:20:00 -0800 (PST)
MIME-Version: 1.0
References: <cover.1548981329.git.saiprakash.ranjan@codeaurora.org>
 <b672119cd1ffb5cba9da27ab5974fd5978e55b31.1548981329.git.saiprakash.ranjan@codeaurora.org>
In-Reply-To: <b672119cd1ffb5cba9da27ab5974fd5978e55b31.1548981329.git.saiprakash.ranjan@codeaurora.org>
From: Mathieu Poirier <mathieu.poirier@linaro.org>
Date: Thu, 7 Feb 2019 13:19:48 -0700
Message-ID: <CANLsYkyu=mPwJh2RzTYiZgfEV+MXgGpEvUKLwXgVdsvBf3nqqQ@mail.gmail.com>
Subject: Re: [PATCHv7 1/6] arm64: dts: qcom: sdm845: Add Coresight support
To: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190207_122002_750505_193B0FD9 
X-CRM114-Status: GOOD (  13.98  )
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

On Thu, 31 Jan 2019 at 17:53, Sai Prakash Ranjan
<saiprakash.ranjan@codeaurora.org> wrote:
>
> Add coresight components found on Qualcomm SDM845 SoC.
>
> Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
>
> ---
> For testing, all dependent patches are in below tree:
>  * https://github.com/saiprakash-ranjan/linux/tree/coresight-next
>
> - Depends on AOSS QMP side channel patches by Bjorn Andersson [1] - [4].
> - AMBA bus pclk change [5].
> - Also depends on patch ("arm64: dts: qcom: sdm845: Increase address
>   and size cells for soc") [6].
>
> [1] https://lore.kernel.org/lkml/20190131003933.11436-5-bjorn.andersson@linaro.org/
> [2] https://lore.kernel.org/lkml/20190131003933.11436-6-bjorn.andersson@linaro.org/
> [3] https://lore.kernel.org/lkml/20190131003933.11436-7-bjorn.andersson@linaro.org/
> [4] https://lore.kernel.org/lkml/20190131003933.11436-10-bjorn.andersson@linaro.org/
> [5] https://lore.kernel.org/lkml/20190131020141.28352-1-bjorn.andersson@linaro.org/
> [6] https://lore.kernel.org/lkml/20190117042940.25487-2-bjorn.andersson@linaro.org/
> ---
>  arch/arm64/boot/dts/qcom/sdm845.dtsi | 434 +++++++++++++++++++++++++++
>  1 file changed, 434 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> index e2aaaa233e45..4121aac6d086 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> @@ -1349,6 +1349,440 @@
>                         };
>                 };
>
> +               stm@6002000 {
> +                       compatible = "arm,coresight-stm", "arm,primecell";
> +                       reg = <0 0x06002000 0 0x1000>,
> +                             <0 0x16280000 0 0x180000>;
> +                       reg-names = "stm-base", "stm-stimulus-base";
> +
> +                       power-domains = <&aoss_qmp AOSS_QMP_QDSS_CLK>;
> +
> +                       out-ports {
> +                               port {
> +                                       stm_out: endpoint {
> +                                               remote-endpoint =
> +                                                 <&funnel0_in7>;
> +                                       };
> +                               };
> +                       };
> +               };
> +
> +               funnel@6041000 {
> +                       compatible = "arm,coresight-funnel", "arm,primecell";
> +                       reg = <0 0x06041000 0 0x1000>;
> +
> +                       power-domains = <&aoss_qmp AOSS_QMP_QDSS_CLK>;
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
> +               funnel@6043000 {
> +                       compatible = "arm,coresight-funnel", "arm,primecell";
> +                       reg = <0 0x06043000 0 0x1000>;
> +
> +                       power-domains = <&aoss_qmp AOSS_QMP_QDSS_CLK>;
> +
> +                       out-ports {
> +                               port {
> +                                       funnel2_out: endpoint {
> +                                               remote-endpoint =
> +                                                 <&merge_funnel_in2>;
> +                                       };
> +                               };
> +                       };
> +
> +                       in-ports {
> +                               #address-cells = <1>;
> +                               #size-cells = <0>;
> +
> +                               port@5 {
> +                                       reg = <5>;
> +                                       funnel2_in5: endpoint {
> +                                               remote-endpoint =
> +                                                 <&apss_merge_funnel_out>;
> +                                       };
> +                               };
> +                       };
> +               };
> +
> +               funnel@6045000 {
> +                       compatible = "arm,coresight-funnel", "arm,primecell";
> +                       reg = <0 0x06045000 0 0x1000>;
> +
> +                       power-domains = <&aoss_qmp AOSS_QMP_QDSS_CLK>;
> +
> +                       out-ports {
> +                               port {
> +                                       merge_funnel_out: endpoint {
> +                                               remote-endpoint = <&etf_in>;
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
> +                               port@2 {
> +                                       reg = <2>;
> +                                       merge_funnel_in2: endpoint {
> +                                               remote-endpoint =
> +                                                 <&funnel2_out>;
> +                                       };
> +                               };
> +                       };
> +               };
> +
> +               replicator@6046000 {
> +                       compatible = "arm,coresight-dynamic-replicator", "arm,primecell";
> +                       reg = <0 0x06046000 0 0x1000>;
> +
> +                       power-domains = <&aoss_qmp AOSS_QMP_QDSS_CLK>;
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
> +                       reg = <0 0x06047000 0 0x1000>;
> +
> +                       power-domains = <&aoss_qmp AOSS_QMP_QDSS_CLK>;
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
> +                               #address-cells = <1>;
> +                               #size-cells = <0>;
> +
> +                               port@1 {
> +                                       reg = <1>;
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
> +                       reg = <0 0x06048000 0 0x1000>;
> +
> +                       power-domains = <&aoss_qmp AOSS_QMP_QDSS_CLK>;
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
> +               etm@7040000 {
> +                       compatible = "arm,coresight-etm4x", "arm,primecell";
> +                       reg = <0 0x07040000 0 0x1000>;
> +
> +                       cpu = <&CPU0>;
> +
> +                       power-domains = <&aoss_qmp AOSS_QMP_QDSS_CLK>;
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
> +               etm@7140000 {
> +                       compatible = "arm,coresight-etm4x", "arm,primecell";
> +                       reg = <0 0x07140000 0 0x1000>;
> +
> +                       cpu = <&CPU1>;
> +
> +                       power-domains = <&aoss_qmp AOSS_QMP_QDSS_CLK>;
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
> +               etm@7240000 {
> +                       compatible = "arm,coresight-etm4x", "arm,primecell";
> +                       reg = <0 0x07240000 0 0x1000>;
> +
> +                       cpu = <&CPU2>;
> +
> +                       power-domains = <&aoss_qmp AOSS_QMP_QDSS_CLK>;
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
> +               etm@7340000 {
> +                       compatible = "arm,coresight-etm4x", "arm,primecell";
> +                       reg = <0 0x07340000 0 0x1000>;
> +
> +                       cpu = <&CPU3>;
> +
> +                       power-domains = <&aoss_qmp AOSS_QMP_QDSS_CLK>;
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
> +               etm@7440000 {
> +                       compatible = "arm,coresight-etm4x", "arm,primecell";
> +                       reg = <0 0x07440000 0 0x1000>;
> +
> +                       cpu = <&CPU4>;
> +
> +                       power-domains = <&aoss_qmp AOSS_QMP_QDSS_CLK>;
> +
> +                       out-ports {
> +                               port {
> +                                       etm4_out: endpoint {
> +                                               remote-endpoint =
> +                                                 <&apss_funnel_in4>;
> +                                       };
> +                               };
> +                       };
> +               };
> +
> +               etm@7540000 {
> +                       compatible = "arm,coresight-etm4x", "arm,primecell";
> +                       reg = <0 0x07540000 0 0x1000>;
> +
> +                       cpu = <&CPU5>;
> +
> +                       power-domains = <&aoss_qmp AOSS_QMP_QDSS_CLK>;
> +
> +                       out-ports {
> +                               port {
> +                                       etm5_out: endpoint {
> +                                               remote-endpoint =
> +                                                 <&apss_funnel_in5>;
> +                                       };
> +                               };
> +                       };
> +               };
> +
> +               etm@7640000 {
> +                       compatible = "arm,coresight-etm4x", "arm,primecell";
> +                       reg = <0 0x07640000 0 0x1000>;
> +
> +                       cpu = <&CPU6>;
> +
> +                       power-domains = <&aoss_qmp AOSS_QMP_QDSS_CLK>;
> +
> +                       out-ports {
> +                               port {
> +                                       etm6_out: endpoint {
> +                                               remote-endpoint =
> +                                                 <&apss_funnel_in6>;
> +                                       };
> +                               };
> +                       };
> +               };
> +
> +               etm@7740000 {
> +                       compatible = "arm,coresight-etm4x", "arm,primecell";
> +                       reg = <0 0x07740000 0 0x1000>;
> +
> +                       cpu = <&CPU7>;
> +
> +                       power-domains = <&aoss_qmp AOSS_QMP_QDSS_CLK>;
> +
> +                       out-ports {
> +                               port {
> +                                       etm7_out: endpoint {
> +                                               remote-endpoint =
> +                                                 <&apss_funnel_in7>;
> +                                       };
> +                               };
> +                       };
> +               };
> +
> +               funnel@7800000 { /* APSS Funnel */
> +                       compatible = "arm,coresight-funnel", "arm,primecell";
> +                       reg = <0 0x07800000 0 0x1000>;
> +
> +                       power-domains = <&aoss_qmp AOSS_QMP_QDSS_CLK>;
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
> +               funnel@7810000 {
> +                       compatible = "arm,coresight-funnel", "arm,primecell";
> +                       reg = <0 0x07810000 0 0x1000>;
> +
> +                       power-domains = <&aoss_qmp AOSS_QMP_QDSS_CLK>;
> +
> +                       out-ports {
> +                               port {
> +                                       apss_merge_funnel_out: endpoint {
> +                                               remote-endpoint =
> +                                                 <&funnel2_in5>;
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
>                 usb_1_hsphy: phy@88e2000 {
>                         compatible = "qcom,sdm845-qusb2-phy";
>                         reg = <0 0x088e2000 0 0x400>;
> --
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
> of Code Aurora Forum, hosted by The Linux Foundation
>

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
