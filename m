Return-Path: <SRS0=fRgi=OV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D562C65BAF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 19:27:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F9AA20851
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 19:27:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jEJyWIPJ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RFMUL/06"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F9AA20851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=P1ChsLoKpDWEBIrvbbw6Kgq9GiZNBVT+pfejLympgfE=; b=jEJyWIPJkpDP5T
	+816PfDjroKIoYq+30V/lPfrY/4GF4wqZaNkEjY2ADCbVX6j8jI3nkRHIG6OlCSCI/2JAxy/m24Pc
	PIJyxwHV2t3mdbhz53Pv79SVlhPaKINXlOAgUlzP8/GH/BBKudX48zLqOqSmmlInu1m9d+Bf4HenV
	hvPxvtTnS+OQa6et2dTbBxsNfzaB92GPx1XjgQ69eDcYfjT0QEXKwunvx9Tk9ZCt8tN24D+8GCJEQ
	/2KpJDmQQtVD4ZorzI/X9eM6gmwC2KVF2JnxZKnBfW8SgjXofJL0PL2IxAkNEbUXG5rwqwaDgjuAN
	6ywWpg3sr2+9jt5Xiibw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXA9q-0003g9-5G; Wed, 12 Dec 2018 19:26:58 +0000
Received: from mail-vs1-xe42.google.com ([2607:f8b0:4864:20::e42])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXA9m-0003fj-8A
 for linux-arm-kernel@lists.infradead.org; Wed, 12 Dec 2018 19:26:56 +0000
Received: by mail-vs1-xe42.google.com with SMTP id y27so11778574vsi.1
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 12 Dec 2018 11:26:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Su+mM15VARNhOU5hvWfXX3SyFIp6WfeIgVaKtC/Q4NE=;
 b=RFMUL/060JhPrjLnBK0VaLaqHUIsk3oSlZDBQ/sDNjGIJuT4IB+CLKiGS7eDoP/sbQ
 lSP3FoBZgsE3PQmUvnfSCSnW42ZvDuwqD1AthDVS6CZWzZGKm7tuVvehDQM6KihmTbVK
 en0zgY5ZAX34f51/dDgO1srLk3iml9i8QlsYE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Su+mM15VARNhOU5hvWfXX3SyFIp6WfeIgVaKtC/Q4NE=;
 b=l0Ad+EKQiaLSTvI7qPnPHdXaBwQR4q0TbklQhHsd6r18di1nkm/zgZqm5nMsmDIpRp
 JvgYUXKnrHtaZL+LoJX2Yzt7Z0FKG2W4QiqJ+YdtfEX8O1L6XXHa2YwvJEGX5LvU48ul
 jHcg9xZPIonGjdD4he9Q9sl9An/fuflfn5MFphuQ5pRQugACw6AFZLT/beFhtAubFFM7
 D7J+9HuRnXEShx/GjpgCd7bh62reCyliXuJ3A+1/OtTTLf9LXKzdiDrPTSkMXybP6kWk
 t5cORv3dhBdC5Qo23JubiEQS7uogtz+pAw89+0G6Pf3vn0/hkm5V2AFTjoAOQot4itIT
 YdvA==
X-Gm-Message-State: AA+aEWaBps5O5PNr+3MgnAQlwJux+dR5X4yT0b6LIyjgip7oPh2iTKiL
 eEWnP+ma/s5n4p49YJNEske/NpDH1vg=
X-Google-Smtp-Source: AFSGD/VxX30rdvrNqHgId6kELQPzm4trK6FeI1uMr2FTPDO7htsgepz5AIDVKHWNUZozDsDcqGHY9Q==
X-Received: by 2002:a67:e44f:: with SMTP id n15mr10293289vsm.116.1544642801819; 
 Wed, 12 Dec 2018 11:26:41 -0800 (PST)
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com.
 [209.85.217.43])
 by smtp.gmail.com with ESMTPSA id n200sm5481652vke.44.2018.12.12.11.26.40
 for <linux-arm-kernel@lists.infradead.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 12 Dec 2018 11:26:40 -0800 (PST)
Received: by mail-vs1-f43.google.com with SMTP id t17so11750961vsc.8
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 12 Dec 2018 11:26:40 -0800 (PST)
X-Received: by 2002:a67:1505:: with SMTP id 5mr8771599vsv.20.1544642799828;
 Wed, 12 Dec 2018 11:26:39 -0800 (PST)
MIME-Version: 1.0
References: <20181212173106.29618-1-jcrouse@codeaurora.org>
 <20181212173106.29618-3-jcrouse@codeaurora.org>
In-Reply-To: <20181212173106.29618-3-jcrouse@codeaurora.org>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 12 Dec 2018 11:26:28 -0800
X-Gmail-Original-Message-ID: <CAD=FV=UTG-jhLCQGw0Frp0WAU-ChAYDj_eNZp_+irPfxCyVexw@mail.gmail.com>
Message-ID: <CAD=FV=UTG-jhLCQGw0Frp0WAU-ChAYDj_eNZp_+irPfxCyVexw@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] arm64: dts: sdm845: Add gpu and gmu device nodes
To: jcrouse@codeaurora.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181212_112654_306514_0FD1BA8C 
X-CRM114-Status: GOOD (  17.46  )
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
Cc: Nishanth Menon <nm@ti.com>, devicetree@vger.kernel.org,
 Rajendra Nayak <rnayak@codeaurora.org>, linux-pm@vger.kernel.org,
 linux-arm-msm <linux-arm-msm@vger.kernel.org>,
 dri-devel <dri-devel@lists.freedesktop.org>, vireshk@kernel.org,
 freedreno <freedreno@lists.freedesktop.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi,

On Wed, Dec 12, 2018 at 9:31 AM Jordan Crouse <jcrouse@codeaurora.org> wrote:
>
> Add the nodes to describe the Adreno GPU and GMU devices.
>
> Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
> ---
>  arch/arm64/boot/dts/qcom/sdm845.dtsi | 123 +++++++++++++++++++++++++++
>  1 file changed, 123 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> index c27cbd3bcb0a..daa404b05a70 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> @@ -7,9 +7,11 @@
>
>  #include <dt-bindings/clock/qcom,dispcc-sdm845.h>
>  #include <dt-bindings/clock/qcom,gcc-sdm845.h>
> +#include <dt-bindings/clock/qcom,gpucc-sdm845.h>

Probably don't need to add this in your patch since (presumably) your
patch needs to be based atop
<https://lore.kernel.org/patchwork/patch/1018365/> and that already
adds the #include (and also the node that you depend on).


>  #include <dt-bindings/clock/qcom,rpmh.h>
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
>  #include <dt-bindings/phy/phy-qcom-qusb2.h>
> +#include <dt-bindings/power/qcom-rpmpd.h>
>  #include <dt-bindings/reset/qcom,sdm845-aoss.h>
>  #include <dt-bindings/soc/qcom,rpmh-rsc.h>
>  #include <dt-bindings/clock/qcom,gcc-sdm845.h>
> @@ -1348,6 +1350,127 @@
>                         };
>                 };
>
> +               gpu@5000000 {
> +                       compatible = "qcom,adreno-630.2", "qcom,adreno";
> +                       #stream-id-cells = <16>;
> +
> +                       reg = <0x5000000 0x40000>, <0x509e000 0x10>;
> +                       reg-names = "kgsl_3d0_reg_memory", "cx_mem";

The second register range isn't in your bindings patch.  Can you add it?


> +                       /*
> +                        * Look ma, no clocks! The GPU clocks and power are
> +                        * controlled entirely by the GMU
> +                        */
> +
> +                       interrupts = <GIC_SPI 300 IRQ_TYPE_LEVEL_HIGH>;
> +                       interrupt-names = "kgsl_3d0_irq";
> +
> +                       iommus = <&adreno_smmu 0>;

It it worth mentioning the iommus and #stream-id-cells in the bindings?


> +                       operating-points-v2 = <&gpu_opp_table>;

Is it worth mentioning the operating-points-v2 in the bindings patch?


> +
> +                       qcom,gmu = <&gmu>;
> +
> +                       gpu_opp_table: adreno-opp-table {

nit: since this is no longer at the top level you can just call it
"opp-table" now.  That matches what the latest RPMh PD node looks
like.


> +                               compatible = "operating-points-v2-qcom-level";
> +
> +                               opp-710000000 {
> +                                       opp-hz = /bits/ 64 <710000000>;
> +                                       qcom,level = <RPMH_REGULATOR_LEVEL_TURBO_L1>;
> +                               };
> +
> +                               opp-675000000 {
> +                                       opp-hz = /bits/ 64 <675000000>;
> +                                       qcom,level = <RPMH_REGULATOR_LEVEL_TURBO>;
> +                               };
> +
> +                               opp-596000000 {
> +                                       opp-hz = /bits/ 64 <596000000>;
> +                                       qcom,level = <RPMH_REGULATOR_LEVEL_NOM_L1>;
> +                               };
> +
> +                               opp-520000000 {
> +                                       opp-hz = /bits/ 64 <520000000>;
> +                                       qcom,level = <RPMH_REGULATOR_LEVEL_NOM>;
> +                               };
> +
> +                               opp-414000000 {
> +                                       opp-hz = /bits/ 64 <414000000>;
> +                                       qcom,level = <RPMH_REGULATOR_LEVEL_SVS_L1>;
> +                               };
> +
> +                               opp-342000000 {
> +                                       opp-hz = /bits/ 64 <342000000>;
> +                                       qcom,level = <RPMH_REGULATOR_LEVEL_SVS>;
> +                               };
> +
> +                               opp-257000000 {
> +                                       opp-hz = /bits/ 64 <257000000>;
> +                                       qcom,level = <RPMH_REGULATOR_LEVEL_LOW_SVS>;
> +                               };
> +                       };
> +               };
> +
> +               adreno_smmu: iommu@5040000 {
> +                       compatible = "qcom,sdm845-smmu-v2", "qcom,smmu-v2";
> +                       reg = <0x5040000 0x10000>;
> +                       #iommu-cells = <1>;
> +                       #global-interrupts = <2>;
> +                       interrupts = <GIC_SPI 229 IRQ_TYPE_LEVEL_HIGH>,
> +                                       <GIC_SPI 231 IRQ_TYPE_LEVEL_HIGH>,
> +                                       <GIC_SPI 364 IRQ_TYPE_EDGE_RISING>,
> +                                       <GIC_SPI 365 IRQ_TYPE_EDGE_RISING>,
> +                                       <GIC_SPI 366 IRQ_TYPE_EDGE_RISING>,
> +                                       <GIC_SPI 367 IRQ_TYPE_EDGE_RISING>,
> +                                       <GIC_SPI 368 IRQ_TYPE_EDGE_RISING>,
> +                                       <GIC_SPI 369 IRQ_TYPE_EDGE_RISING>,
> +                                       <GIC_SPI 370 IRQ_TYPE_EDGE_RISING>,
> +                                       <GIC_SPI 371 IRQ_TYPE_EDGE_RISING>;
> +                       clocks = <&gcc GCC_GPU_MEMNOC_GFX_CLK>,
> +                               <&gcc GCC_GPU_CFG_AHB_CLK>;
> +                       clock-names = "bus", "iface";
> +
> +                       power-domains = <&gpucc GPU_CX_GDSC>;
> +               };
> +
> +               gmu: gmu@506a000 {
> +                       compatible="qcom,adreno-gmu";
> +
> +                       reg = <0x506a000 0x30000>,
> +                               <0xb280000 0x10000>,
> +                               <0xb480000 0x10000>;
> +                       reg-names = "gmu", "gmu_pdc", "gmu_pdc_seq";
> +
> +                       interrupts = <GIC_SPI 304 IRQ_TYPE_LEVEL_HIGH>,
> +                            <GIC_SPI 305 IRQ_TYPE_LEVEL_HIGH>;
> +                       interrupt-names = "hfi", "gmu";
> +
> +                       clocks = <&gpucc GPU_CC_CX_GMU_CLK>,
> +                               <&gpucc GPU_CC_CXO_CLK>,
> +                               <&gcc GCC_DDRSS_GPU_AXI_CLK>,
> +                               <&gcc GCC_GPU_MEMNOC_GFX_CLK>;
> +                       clock-names = "gmu", "cxo", "axi", "memnoc";
> +
> +                       power-domains = <&gpucc GPU_CX_GDSC>;
> +                       iommus = <&adreno_smmu 5>;
> +
> +                       operating-points-v2 = <&gmu_opp_table>;
> +
> +                       gmu_opp_table: adreno-gmu-opp-table {

Same here that this can just be called "opp-table".


> +                               compatible = "operating-points-v2-qcom-level";
> +
> +                               opp-400000000 {
> +                                       opp-hz = /bits/ 64 <400000000>;
> +                                       qcom,level = <RPMH_REGULATOR_LEVEL_SVS>;
> +                               };
> +
> +                               opp-200000000 {
> +                                       opp-hz = /bits/ 64 <200000000>;
> +                                       qcom,level = <RPMH_REGULATOR_LEVEL_MIN_SVS>;
> +                               };
> +                       };
> +               };
> +
>                 usb_1_hsphy: phy@88e2000 {

Since you won't compile without the gpucc patch maybe pick it before
sending out your patch?  Then context diff would show gpucc right here
and it will avoid merge conflicts.


-Doug

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
