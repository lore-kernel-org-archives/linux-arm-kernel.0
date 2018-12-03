Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6AF5C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 16:09:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A100320834
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 16:09:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="cPXRFrOd";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ArIxDxG6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A100320834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=wCopAI5n233mWSUxI7bCV4S0LvqTX761+l4JzImTLjk=; b=cPXRFrOdYHCRii
	ejRXTsHgQcuOxVAUOxKOVfrYKtMju+pqcKnnEsOrM7IOCv3qojoM2ekSJcK7vO/xgdFLtBWbgApxg
	DXDybY7mf1GzvSxCIre3am7UziIc2RceHrCwkAFM7xDPydtTReWkd3VXV4c6Z76qIt/AaA0sWHIFb
	vh46BOrMlcIENFwcEbkG0s7VfuJZUF1me5HxrFD9WJdyn2hqk+3QS7U1HbZONgMX2k6MdlJfQDrLo
	K8ZqS4TcIFIVnWTXUJukxg3xjj/bVonglSFl0IMZnofgbXT+ZTnmhBTXB4AmSjlwVUHmg2jTakesj
	Gia4fFqd1wiDiWYf3g1g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTqmi-00042M-HF; Mon, 03 Dec 2018 16:09:24 +0000
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTqme-0003xG-MX
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 16:09:23 +0000
Received: by mail-pg1-x544.google.com with SMTP id n2so5918989pgm.3
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 03 Dec 2018 08:09:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to
 :user-agent; bh=FUPS2UI8C5UuanwQhOJhODfipKh/EVBWkytwMbTS5VM=;
 b=ArIxDxG6LMhXZ+WeEYAJ+zr2yiKBUJuCrrtzHhgqX82CFJxetZN/3+qs5WRBNioFHu
 NE9JChH4gf5qLk3B+hC2+id8VePpLs+SKwyxUkYfJlo1j3fcMxG1U/l0iir5b3p8rjsY
 02z1xohdmTUoqcSsje7LXxHnNnaFwFW9VjmCY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=FUPS2UI8C5UuanwQhOJhODfipKh/EVBWkytwMbTS5VM=;
 b=kPpJ5tAsN+ZkbCKc6r7V1TCEbkKWqUMbuF3hFT84ud7NkZVBx1OH9z658nJ5Z+QCkr
 IL3Xmv1PD0tHFG3Qw5P4OmmRD4ztFrDnfT9K1RJEQvVPfe4xMS1/kbQrwDTMMD5LtA5y
 PaorPF7/yk95zZZSA7JDkcx+SGtPyPf9AE1q4WsmUlF5UEqXF8kGDJQ9h0QIY9FFzM5J
 9FU/0zTEKYdwyinG7HUT6F7cz7oNNdfIlcrfxv3b0OyGGQ+KfojW3Fo0o+EAPTy1BnaN
 G9hRLlcBNsKSDMu3EtFSttgEcFkdBIaVvjnMesrbBEH9KsDIWc4mwOVQ5En24HLizbk2
 cz7A==
X-Gm-Message-State: AA+aEWa0C7ktoxKjf0OWcnk65yacafI7kOJkBJ4sLBYi4uFH11MwCitj
 Hi0V0u8+ZeRyou8izeYO6YHohA==
X-Google-Smtp-Source: AFSGD/VByWhvCRaSfTmJP5kzL4c4p8G6M7HirsfVYvuLftbT8zbSUYAD3fca8PWNs3riYZ7VCEfuew==
X-Received: by 2002:a62:13c3:: with SMTP id 64mr16342799pft.93.1543853349469; 
 Mon, 03 Dec 2018 08:09:09 -0800 (PST)
Received: from minitux (104-188-17-28.lightspeed.sndgca.sbcglobal.net.
 [104.188.17.28])
 by smtp.gmail.com with ESMTPSA id c23sm20174078pfi.83.2018.12.03.08.09.08
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 03 Dec 2018 08:09:08 -0800 (PST)
Date: Mon, 3 Dec 2018 08:09:05 -0800
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Jeffrey Hugo <jhugo@codeaurora.org>
Subject: Re: WIP: UFS on apq8098
Message-ID: <20181203160905.GR2225@minitux>
References: <ab9c8bec-35be-9e01-a567-bc2e4b2bef87@free.fr>
 <de223e7a-3b60-0566-997f-b607bbc15007@codeaurora.org>
 <7d588806-5699-2d87-e95e-f1388de01a74@codeaurora.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <7d588806-5699-2d87-e95e-f1388de01a74@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_080920_746358_0CDA3592 
X-CRM114-Status: GOOD (  21.42  )
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
Cc: Rajendra Nayak <rnayak@codeaurora.org>,
 Marc Gonzalez <marc.w.gonzalez@free.fr>, MSM <linux-arm-msm@vger.kernel.org>,
 Niklas Cassel <niklas.cassel@linaro.org>,
 Nicolas Dechesne <nicolas.dechesne@linaro.org>,
 Andy Gross <andy.gross@linaro.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon 03 Dec 07:47 PST 2018, Jeffrey Hugo wrote:

> On 12/3/2018 8:27 AM, Jeffrey Hugo wrote:
> > On 12/3/2018 8:18 AM, Marc Gonzalez wrote:
> > > Hello,
> > > =

> > > I'm trying to enable UFS on apq8098. Just wanted to share my progress
> > > so far, in case someone spots any glaring mistakes.
> > =

> > Excellent.=A0 This was down on my todo list.=A0 I'm glad its getting so=
me
> > attention.
> > =

> > > =

> > > (WIP patch provided at message's end.)
> > > =

> > > rpm_smd_clk_probe() runs successfully, and returns 0.
> > > =

> > > qcom_qmp_phy_probe() fails:
> > > =

> > > [=A0=A0=A0 0.913707] qcom-qmp-phy 1da7000.phy: Failed to get clk 'ref=
': -2
> > > [=A0=A0=A0 0.913761] qcom-qmp-phy: probe of 1da7000.phy failed with e=
rror -2
> > > =

> > > ufs_qcom_probe() also fails (which may be caused by PHY failure)
> > > =

> > > [=A0=A0=A0 2.368486] ufshcd-qcom 1da4000.ufshc: ufshcd_get_vreg: vdd-=
hba
> > > get failed, err=3D-517
> > > [=A0=A0=A0 2.370673] ufshcd-qcom 1da4000.ufshc: Initialization failed
> > > [=A0=A0=A0 2.412908] ufshcd-qcom 1da4000.ufshc: ufshcd_pltfrm_init()
> > > failed -517
> > > =

> > > I'll investigate the PHY init.
> > > =

> > > Regards.
> > > =

> > > =

> > > diff --git a/arch/arm64/boot/dts/qcom/msm8998-mtp.dtsi
> > > b/arch/arm64/boot/dts/qcom/msm8998-mtp.dtsi
> > > index b4276da1fb0d..ad7542f461af 100644
> > > --- a/arch/arm64/boot/dts/qcom/msm8998-mtp.dtsi
> > > +++ b/arch/arm64/boot/dts/qcom/msm8998-mtp.dtsi
> > > @@ -241,3 +241,26 @@
> > > =A0=A0=A0=A0=A0=A0=A0=A0=A0 };
> > > =A0=A0=A0=A0=A0 };
> > > =A0 };
> > > +
> > > +&ufshc {
> > > +=A0=A0=A0 status =3D "ok";
> > > +=A0=A0=A0 vdd-hba-supply =3D <&gcc UFS_GDSC>;
> > > +=A0=A0=A0 vdd-hba-fixed-regulator;
> > > +=A0=A0=A0 vcc-supply =3D <&vreg_l20a_2p95>;
> > > +=A0=A0=A0 vccq-supply =3D <&vreg_l26a_1p2>;
> > > +=A0=A0=A0 vccq2-supply =3D <&vreg_s4a_1p8>;
> > > +=A0=A0=A0 vcc-max-microamp =3D <750000>;
> > > +=A0=A0=A0 vccq-max-microamp =3D <560000>;
> > > +=A0=A0=A0 vccq2-max-microamp =3D <750000>;
> > > +};
> > > +
> > > +&ufsphy {
> > > +=A0=A0=A0 status =3D "ok";
> > > +=A0=A0=A0 vdda-phy-supply =3D <&vreg_l1a_0p875>;
> > > +=A0=A0=A0 vdda-pll-supply =3D <&vreg_l2a_1p2>;
> > > +=A0=A0=A0 vddp-ref-clk-supply =3D <&vreg_l26a_1p2>;
> > > +=A0=A0=A0 vdda-phy-max-microamp =3D <51400>;
> > > +=A0=A0=A0 vdda-pll-max-microamp =3D <14600>;
> > > +=A0=A0=A0 vddp-ref-clk-max-microamp =3D <100>;
> > > +=A0=A0=A0 vddp-ref-clk-always-on;
> > > +};
> > > diff --git a/arch/arm64/boot/dts/qcom/msm8998.dtsi
> > > b/arch/arm64/boot/dts/qcom/msm8998.dtsi
> > > index d291b4713c33..10e7b8a55b8a 100644
> > > --- a/arch/arm64/boot/dts/qcom/msm8998.dtsi
> > > +++ b/arch/arm64/boot/dts/qcom/msm8998.dtsi
> > > @@ -264,6 +264,11 @@
> > > =A0=A0=A0=A0=A0=A0=A0=A0=A0 rpm_requests: rpm-requests {
> > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 compatible =3D "qcom,rpm-msm8=
998";
> > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 qcom,glink-channels =3D "rpm_=
requests";
> > > +
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 rpmcc: qcom,rpmcc {
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 compatible =3D "qcom,r=
pmcc-msm8998";
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 #clock-cells =3D <1>;
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 };
> > > =A0=A0=A0=A0=A0=A0=A0=A0=A0 };
> > > =A0=A0=A0=A0=A0 };
> > > @@ -686,5 +691,79 @@
> > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 redistributor-stride =3D <0x0=
 0x20000>;
> > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 interrupts =3D <GIC_PPI 9 IRQ=
_TYPE_LEVEL_HIGH>;
> > > =A0=A0=A0=A0=A0=A0=A0=A0=A0 };
> > > +
> > > +=A0=A0=A0=A0=A0=A0=A0 ufshc: ufshc@1da4000 {
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 compatible =3D "qcom,msm8998-ufshc=
", "qcom,ufshc",
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 "jedec,=
ufs-2.0";
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 reg =3D <0x1da4000 0x2500>;
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 interrupts =3D <GIC_SPI 265 IRQ_TY=
PE_LEVEL_HIGH>;
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 phys =3D <&ufsphy_lanes>;
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 phy-names =3D "ufsphy";
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 lanes-per-direction =3D <2>;
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 power-domains =3D <&gcc UFS_GDSC>;
> > > +
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 clock-names =3D
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 "core_clk",
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 "bus_aggr_clk",
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 "iface_clk",
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 "core_clk_unipro",
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 "core_clk_ice",
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 "ref_clk",
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 "tx_lane0_sync_clk",
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 "rx_lane0_sync_clk",
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 "rx_lane1_sync_clk";
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 clocks =3D
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 <&gcc GCC_UFS_AXI_CLK>,
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 <&gcc GCC_AGGRE1_UFS_A=
XI_CLK>,
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 <&gcc GCC_UFS_AHB_CLK>,
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 <&gcc GCC_UFS_UNIPRO_C=
ORE_CLK>,
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 <&gcc GCC_UFS_ICE_CORE=
_CLK>,
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 <&rpmcc 0>,
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 <&gcc GCC_UFS_TX_SYMBO=
L_0_CLK>,
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 <&gcc GCC_UFS_RX_SYMBO=
L_0_CLK>,
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 <&gcc GCC_UFS_RX_SYMBO=
L_1_CLK>;
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 freq-table-hz =3D
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 <50000000 200000000>,
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 <0 0>,
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 <0 0>,
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 <37500000 150000000>,
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 <75000000 300000000>,
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 <0 0>,
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 <0 0>,
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 <0 0>,
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 <0 0>;
> > > +
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 resets =3D <&gcc GCC_UFS_BCR>;
> > =

> > I dunno how much this factors into your issues, but the resets defined
> > in gcc-msm8998.c are wrong.=A0 I'm posting a patch later today.=A0 I kn=
ow
> > this was a problem for me with USB.
> > =

> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 reset-names =3D "rst";
> > > +
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 status =3D "disabled";
> > > +=A0=A0=A0=A0=A0=A0=A0 };
> > > +
> > > +=A0=A0=A0=A0=A0=A0=A0 ufsphy: phy@1da7000 {
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 compatible =3D "qcom,sdm845-qmp-uf=
s-phy";
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 reg =3D <0x1da7000 0x18c>;
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 #address-cells =3D <1>;
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 #size-cells =3D <1>;
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ranges;
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 clock-names =3D
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 "ref_clk_src",
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 "ref_clk",
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 "ref_aux_clk";
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 clocks =3D
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 <&rpmcc 0>,
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 <&gcc GCC_UFS_CLKREF_C=
LK>,
> =

> Also, "GCC_UFS_CLKREF_CLK" is not defined in
> include/dt-bindings/clock/qcom,gcc-msm8998.h which is probably the cause =
of
> your -2 error listed above.
> =


I agree, this would cause the problem you're seeing.

Please find this clock at:

https://lore.kernel.org/lkml/20181130065259.26497-4-bjorn.andersson@linaro.=
org/

I will respin patch 1 and post the series again in a few hours.

Regards,
Bjorn

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
