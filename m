Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51BC3C5CFFE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 10:24:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16BE42082F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 10:24:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="FaIGaloV";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T8fQOt76"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16BE42082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=mAkonShQ1IetOEUdkgqnKI9lzRl7JMED7aB9FSD+zr8=; b=FaIGaloVZddiayaZfYf4XIFQ/
	eqvv+YZwN9zcv48Ll0O8G+40NU2oQn8hAUNZ0+pVOj8DLMD7TCvDN2BmbLm0aP69BQlQTkl2BRcDz
	hbb1RgTzRKR+RM7PEjjpqIoL2IaAgyNALx+WVsxGUGq8O+iivEgf0afuvE0BwxzDRmE99nTaZmrwQ
	MoVObsEjF1wuuhvAn7eOrOVcXCiGc2bWkyqD7HIOgIXDe0GyeLnNqCwY2G0128N0Vzd7JGblb6RA0
	YzwX+RvbBKfMHFVFZKGC3xmV94YayXeYC92WUXY9gNy5bcshYsyCKvI+9ovvk0QiJObXdz9W9CgpI
	fDYtCnDLA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWIk3-0003QX-7c; Mon, 10 Dec 2018 10:24:47 +0000
Received: from mail-ed1-x542.google.com ([2a00:1450:4864:20::542])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWIjv-0003DC-De; Mon, 10 Dec 2018 10:24:41 +0000
Received: by mail-ed1-x542.google.com with SMTP id o10so8964371edt.13;
 Mon, 10 Dec 2018 02:24:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=T5s+vWGDNu0URzPIc4N55TS3CBxfZ3zxGIH4FuWt11Y=;
 b=T8fQOt76GAVJcx+KksoUNwLAvTT8MeqAALppTU3MdmYxipxTpVcEtdbzr21wmZ7KKu
 ca5VDnoTyA7KanTZQpHD3RK2KqdoIXmMDna7Kk5Q8/sS28IeW33VDqC9b0B0WzT9JasB
 CPp6JmvAzDb9nwOeE4G7SsXZEbiBzPiCRXpVeeLTZOt5Vll/XR5spodjxXBci/fa0mTn
 U9yxydmp2a8cNLBsY3EzSNTjcrjGQHIlFAkArFHMbzLcxucFM+zyU/k021oiM5+J+KBx
 qBuj/GhvbqZlAKTKk45SHjh68XMGhaifC3dupzKkGVx1lSs0Y+dTRgAHjN1QGqwk/Mbg
 xqug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=T5s+vWGDNu0URzPIc4N55TS3CBxfZ3zxGIH4FuWt11Y=;
 b=ojYzm1Qm/Dk55EpH0bys4B0j5rymcP8X5d6wiNPzyh740RCx42AZs3Wm8lI4ljCHSp
 WHWpmCBbGbBcEDQX7TPUI+wFQGb6MBJKdP332Ij4osmF4CE0ZzZ3HTYRzg+eR7Dx/8Ee
 iYORDC4xP27RNh2yM3gTx0/4QgHvmEj1UOGCm1KD8oe7mk+VIuAhikl4bui8oVe9yVGt
 gtlTBHZGM8IDqjqwhd7Dcd8kn0y+hMoqJZEaKtVBFc4gOADSAoothtEH095pkzm2z4U0
 DTY2I6Mf3GlJeNCcNIl0TjJaT2X3U/JY3oEVLz6iH66mM5FY75yI8pEoQj/WDFaXXVYD
 NfJg==
X-Gm-Message-State: AA+aEWaQ5WNGrv/kYOERf1AfSraRu+fpq0jtfi7QAuqiMK1rVwf/4DQg
 oSYdqQy02XtVByF2dIKAA6M=
X-Google-Smtp-Source: AFSGD/U2tYA6H5q/99/QAoeZjlGHA9pUW8sp5miw3+uswwapW3ITTDycM41phcjgFTvEmGgzqF5n5w==
X-Received: by 2002:a50:ec19:: with SMTP id g25mr10799696edr.38.1544437467736; 
 Mon, 10 Dec 2018 02:24:27 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
 by smtp.gmail.com with ESMTPSA id b25-v6sm1761162ejo.55.2018.12.10.02.24.26
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 10 Dec 2018 02:24:27 -0800 (PST)
Date: Mon, 10 Dec 2018 11:24:26 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: Re: [PATCH 7/7] drm: Split out drm_probe_helper.h
Message-ID: <20181210102426.GG15154@ulmo>
References: <20181210100359.22507-1-daniel.vetter@ffwll.ch>
 <20181210101133.5364-1-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
In-Reply-To: <20181210101133.5364-1-daniel.vetter@ffwll.ch>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_022439_466013_FDB7805F 
X-CRM114-Status: GOOD (  11.63  )
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
Cc: linux-samsung-soc@vger.kernel.org, nouveau@lists.freedesktop.org,
 Daniel Vetter <daniel.vetter@intel.com>, linux-arm-msm@vger.kernel.org,
 Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
 etnaviv@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 virtualization@lists.linux-foundation.org, linux-renesas-soc@vger.kernel.org,
 linux-rockchip@lists.infradead.org, linux-mediatek@lists.infradead.org,
 DRI Development <dri-devel@lists.freedesktop.org>,
 linux-amlogic@lists.infradead.org, linux-tegra@vger.kernel.org,
 spice-devel@lists.freedesktop.org, xen-devel@lists.xen.org,
 freedreno@lists.freedesktop.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: multipart/mixed; boundary="===============6982407604161856570=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============6982407604161856570==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="5UGlQXeG3ziZS81+"
Content-Disposition: inline


--5UGlQXeG3ziZS81+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 10, 2018 at 11:11:33AM +0100, Daniel Vetter wrote:
> Having the probe helper stuff (which pretty much everyone needs) in
> the drm_crtc_helper.h file (which atomic drivers should never need) is
> confusing. Split them out.
>=20
> To make sure I actually achieved the goal here I went through all
> drivers. And indeed, all atomic drivers are now free of
> drm_crtc_helper.h includes.
>=20
> Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: virtualization@lists.linux-foundation.org
> Cc: etnaviv@lists.freedesktop.org
> Cc: linux-samsung-soc@vger.kernel.org
> Cc: intel-gfx@lists.freedesktop.org
> Cc: linux-mediatek@lists.infradead.org
> Cc: linux-amlogic@lists.infradead.org
> Cc: linux-arm-msm@vger.kernel.org
> Cc: freedreno@lists.freedesktop.org
> Cc: nouveau@lists.freedesktop.org
> Cc: spice-devel@lists.freedesktop.org
> Cc: amd-gfx@lists.freedesktop.org
> Cc: linux-renesas-soc@vger.kernel.org
> Cc: linux-rockchip@lists.infradead.org
> Cc: linux-stm32@st-md-mailman.stormreply.com
> Cc: linux-tegra@vger.kernel.org
> Cc: xen-devel@lists.xen.org
> ---
>  .../gpu/drm/amd/amdgpu/amdgpu_connectors.c    |  2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |  2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |  2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h      |  1 +
>  .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c |  2 +-
>  .../amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c  |  2 +-
>  .../display/amdgpu_dm/amdgpu_dm_services.c    |  2 +-
>  drivers/gpu/drm/arc/arcpgu_crtc.c             |  2 +-
>  drivers/gpu/drm/arc/arcpgu_drv.c              |  2 +-
>  drivers/gpu/drm/arc/arcpgu_sim.c              |  2 +-
>  drivers/gpu/drm/arm/hdlcd_crtc.c              |  2 +-
>  drivers/gpu/drm/arm/hdlcd_drv.c               |  2 +-
>  drivers/gpu/drm/arm/malidp_crtc.c             |  2 +-
>  drivers/gpu/drm/arm/malidp_drv.c              |  2 +-
>  drivers/gpu/drm/arm/malidp_mw.c               |  2 +-
>  drivers/gpu/drm/armada/armada_510.c           |  2 +-
>  drivers/gpu/drm/armada/armada_crtc.c          |  2 +-
>  drivers/gpu/drm/armada/armada_drv.c           |  2 +-
>  drivers/gpu/drm/armada/armada_fb.c            |  2 +-
>  drivers/gpu/drm/ast/ast_drv.c                 |  1 +
>  drivers/gpu/drm/ast/ast_mode.c                |  1 +
>  .../gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c    |  2 +-
>  drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h  |  2 +-
>  drivers/gpu/drm/bochs/bochs_drv.c             |  1 +
>  drivers/gpu/drm/bochs/bochs_kms.c             |  1 +
>  drivers/gpu/drm/bridge/adv7511/adv7511.h      |  2 +-
>  drivers/gpu/drm/bridge/analogix-anx78xx.c     |  3 +-
>  .../drm/bridge/analogix/analogix_dp_core.c    |  2 +-
>  drivers/gpu/drm/bridge/cdns-dsi.c             |  2 +-
>  drivers/gpu/drm/bridge/dumb-vga-dac.c         |  2 +-
>  .../bridge/megachips-stdpxxxx-ge-b850v3-fw.c  |  2 +-
>  drivers/gpu/drm/bridge/nxp-ptn3460.c          |  2 +-
>  drivers/gpu/drm/bridge/panel.c                |  2 +-
>  drivers/gpu/drm/bridge/parade-ps8622.c        |  2 +-
>  drivers/gpu/drm/bridge/sii902x.c              |  2 +-
>  drivers/gpu/drm/bridge/synopsys/dw-hdmi.c     |  2 +-
>  drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c |  2 +-
>  drivers/gpu/drm/bridge/tc358764.c             |  2 +-
>  drivers/gpu/drm/bridge/tc358767.c             |  2 +-
>  drivers/gpu/drm/bridge/ti-sn65dsi86.c         |  2 +-
>  drivers/gpu/drm/bridge/ti-tfp410.c            |  2 +-
>  drivers/gpu/drm/cirrus/cirrus_drv.c           |  1 +
>  drivers/gpu/drm/cirrus/cirrus_mode.c          |  1 +
>  drivers/gpu/drm/drm_atomic_helper.c           |  1 -
>  drivers/gpu/drm/drm_dp_mst_topology.c         |  2 +-
>  drivers/gpu/drm/drm_modeset_helper.c          |  2 +-
>  drivers/gpu/drm/drm_probe_helper.c            |  2 +-
>  drivers/gpu/drm/drm_simple_kms_helper.c       |  2 +-
>  drivers/gpu/drm/etnaviv/etnaviv_drv.h         |  1 -
>  drivers/gpu/drm/exynos/exynos_dp.c            |  2 +-
>  drivers/gpu/drm/exynos/exynos_drm_crtc.c      |  2 +-
>  drivers/gpu/drm/exynos/exynos_drm_dpi.c       |  2 +-
>  drivers/gpu/drm/exynos/exynos_drm_drv.c       |  2 +-
>  drivers/gpu/drm/exynos/exynos_drm_dsi.c       |  2 +-
>  drivers/gpu/drm/exynos/exynos_drm_fb.c        |  2 +-
>  drivers/gpu/drm/exynos/exynos_drm_fbdev.c     |  2 +-
>  drivers/gpu/drm/exynos/exynos_drm_vidi.c      |  2 +-
>  drivers/gpu/drm/exynos/exynos_hdmi.c          |  2 +-
>  drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_crtc.c    |  2 +-
>  drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c     |  2 +-
>  drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_kms.c     |  2 +-
>  drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_plane.c   |  2 +-
>  drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_rgb.c     |  2 +-
>  drivers/gpu/drm/gma500/psb_intel_drv.h        |  1 +
>  .../gpu/drm/hisilicon/hibmc/hibmc_drm_de.c    |  2 +-
>  .../gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c   |  2 +-
>  .../gpu/drm/hisilicon/hibmc/hibmc_drm_fbdev.c |  2 +-
>  .../gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c  |  2 +-
>  drivers/gpu/drm/hisilicon/kirin/dw_drm_dsi.c  |  2 +-
>  .../gpu/drm/hisilicon/kirin/kirin_drm_ade.c   |  2 +-
>  .../gpu/drm/hisilicon/kirin/kirin_drm_drv.c   |  2 +-
>  drivers/gpu/drm/i2c/ch7006_priv.h             |  2 +-
>  drivers/gpu/drm/i2c/sil164_drv.c              |  2 +-
>  drivers/gpu/drm/i2c/tda998x_drv.c             |  2 +-
>  drivers/gpu/drm/i915/i915_drv.c               |  2 +-
>  drivers/gpu/drm/i915/intel_crt.c              |  2 +-
>  drivers/gpu/drm/i915/intel_display.c          |  2 +-
>  drivers/gpu/drm/i915/intel_dp.c               |  2 +-
>  drivers/gpu/drm/i915/intel_dp_mst.c           |  2 +-
>  drivers/gpu/drm/i915/intel_drv.h              |  2 +-
>  drivers/gpu/drm/imx/dw_hdmi-imx.c             |  2 +-
>  drivers/gpu/drm/imx/imx-drm-core.c            |  2 +-
>  drivers/gpu/drm/imx/imx-ldb.c                 |  2 +-
>  drivers/gpu/drm/imx/imx-tve.c                 |  2 +-
>  drivers/gpu/drm/imx/ipuv3-crtc.c              |  2 +-
>  drivers/gpu/drm/imx/parallel-display.c        |  2 +-
>  drivers/gpu/drm/mediatek/mtk_dpi.c            |  2 +-
>  drivers/gpu/drm/mediatek/mtk_drm_crtc.c       |  2 +-
>  drivers/gpu/drm/mediatek/mtk_drm_drv.c        |  2 +-
>  drivers/gpu/drm/mediatek/mtk_drm_fb.c         |  2 +-
>  drivers/gpu/drm/mediatek/mtk_dsi.c            |  2 +-
>  drivers/gpu/drm/mediatek/mtk_hdmi.c           |  2 +-
>  drivers/gpu/drm/meson/meson_crtc.c            |  2 +-
>  drivers/gpu/drm/meson/meson_drv.c             |  2 +-
>  drivers/gpu/drm/meson/meson_dw_hdmi.c         |  2 +-
>  drivers/gpu/drm/meson/meson_venc_cvbs.c       |  2 +-
>  drivers/gpu/drm/mgag200/mgag200_mode.c        |  1 +
>  drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c      |  2 +-
>  drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c   |  2 +-
>  drivers/gpu/drm/msm/disp/mdp4/mdp4_crtc.c     |  2 +-
>  .../gpu/drm/msm/disp/mdp4/mdp4_dsi_encoder.c  |  2 +-
>  .../gpu/drm/msm/disp/mdp4/mdp4_dtv_encoder.c  |  2 +-
>  .../gpu/drm/msm/disp/mdp4/mdp4_lcdc_encoder.c |  2 +-
>  .../gpu/drm/msm/disp/mdp5/mdp5_cmd_encoder.c  |  2 +-
>  drivers/gpu/drm/msm/disp/mdp5/mdp5_crtc.c     |  2 +-
>  drivers/gpu/drm/msm/disp/mdp5/mdp5_encoder.c  |  2 +-
>  drivers/gpu/drm/msm/msm_drv.h                 |  2 +-
>  drivers/gpu/drm/msm/msm_fb.c                  |  2 +-
>  drivers/gpu/drm/mxsfb/mxsfb_crtc.c            |  2 +-
>  drivers/gpu/drm/mxsfb/mxsfb_drv.c             |  2 +-
>  drivers/gpu/drm/mxsfb/mxsfb_out.c             |  2 +-
>  drivers/gpu/drm/nouveau/dispnv04/tvnv17.c     |  1 +
>  drivers/gpu/drm/nouveau/dispnv50/disp.c       |  2 +-
>  drivers/gpu/drm/nouveau/nouveau_connector.c   |  1 +
>  drivers/gpu/drm/nouveau/nouveau_display.c     |  1 +
>  drivers/gpu/drm/omapdrm/omap_connector.c      |  2 +-
>  drivers/gpu/drm/omapdrm/omap_crtc.c           |  2 +-
>  drivers/gpu/drm/omapdrm/omap_drv.c            |  2 +-
>  drivers/gpu/drm/omapdrm/omap_drv.h            |  2 +-
>  drivers/gpu/drm/omapdrm/omap_encoder.c        |  2 +-
>  drivers/gpu/drm/omapdrm/omap_fb.c             |  2 +-
>  drivers/gpu/drm/pl111/pl111_drv.c             |  2 +-
>  drivers/gpu/drm/qxl/qxl_display.c             |  2 +-
>  drivers/gpu/drm/qxl/qxl_drv.c                 |  3 +-
>  drivers/gpu/drm/qxl/qxl_fb.c                  |  2 +-
>  drivers/gpu/drm/qxl/qxl_kms.c                 |  2 +-
>  drivers/gpu/drm/radeon/radeon_acpi.c          |  1 +
>  drivers/gpu/drm/radeon/radeon_connectors.c    |  1 +
>  drivers/gpu/drm/radeon/radeon_device.c        |  1 +
>  drivers/gpu/drm/radeon/radeon_display.c       |  1 +
>  drivers/gpu/drm/radeon/radeon_dp_mst.c        |  1 +
>  drivers/gpu/drm/radeon/radeon_drv.c           |  1 +
>  drivers/gpu/drm/radeon/radeon_irq_kms.c       |  1 +
>  drivers/gpu/drm/rcar-du/rcar_du_crtc.c        |  2 +-
>  drivers/gpu/drm/rcar-du/rcar_du_drv.c         |  2 +-
>  drivers/gpu/drm/rcar-du/rcar_du_encoder.c     |  2 +-
>  drivers/gpu/drm/rcar-du/rcar_du_kms.c         |  2 +-
>  drivers/gpu/drm/rcar-du/rcar_du_plane.c       |  2 +-
>  drivers/gpu/drm/rcar-du/rcar_du_vsp.c         |  2 +-
>  drivers/gpu/drm/rcar-du/rcar_lvds.c           |  2 +-
>  .../gpu/drm/rockchip/analogix_dp-rockchip.c   |  2 +-
>  drivers/gpu/drm/rockchip/cdn-dp-core.c        |  2 +-
>  drivers/gpu/drm/rockchip/cdn-dp-core.h        |  2 +-
>  drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c   |  2 +-
>  drivers/gpu/drm/rockchip/inno_hdmi.c          |  2 +-
>  drivers/gpu/drm/rockchip/rockchip_drm_drv.c   |  2 +-
>  drivers/gpu/drm/rockchip/rockchip_drm_fb.c    |  2 +-
>  drivers/gpu/drm/rockchip/rockchip_drm_fbdev.c |  2 +-
>  drivers/gpu/drm/rockchip/rockchip_drm_psr.c   |  2 +-
>  drivers/gpu/drm/rockchip/rockchip_drm_vop.c   |  2 +-
>  drivers/gpu/drm/rockchip/rockchip_lvds.c      |  2 +-
>  drivers/gpu/drm/rockchip/rockchip_rgb.c       |  2 +-
>  drivers/gpu/drm/sti/sti_crtc.c                |  2 +-
>  drivers/gpu/drm/sti/sti_drv.c                 |  2 +-
>  drivers/gpu/drm/sti/sti_dvo.c                 |  2 +-
>  drivers/gpu/drm/sti/sti_hda.c                 |  2 +-
>  drivers/gpu/drm/sti/sti_hdmi.c                |  2 +-
>  drivers/gpu/drm/sti/sti_tvout.c               |  2 +-
>  drivers/gpu/drm/stm/drv.c                     |  2 +-
>  drivers/gpu/drm/stm/ltdc.c                    |  2 +-
>  drivers/gpu/drm/sun4i/sun4i_backend.c         |  2 +-
>  drivers/gpu/drm/sun4i/sun4i_crtc.c            |  2 +-
>  drivers/gpu/drm/sun4i/sun4i_drv.c             |  2 +-
>  drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c        |  2 +-
>  drivers/gpu/drm/sun4i/sun4i_lvds.c            |  2 +-
>  drivers/gpu/drm/sun4i/sun4i_rgb.c             |  2 +-
>  drivers/gpu/drm/sun4i/sun4i_tcon.c            |  2 +-
>  drivers/gpu/drm/sun4i/sun4i_tv.c              |  2 +-
>  drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c        |  2 +-
>  drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c         |  2 +-
>  drivers/gpu/drm/sun4i/sun8i_mixer.c           |  2 +-
>  drivers/gpu/drm/sun4i/sun8i_ui_layer.c        |  2 +-
>  drivers/gpu/drm/sun4i/sun8i_vi_layer.c        |  2 +-
>  drivers/gpu/drm/tegra/drm.h                   |  2 +-
>  drivers/gpu/drm/tegra/hdmi.c                  |  2 +-
>  drivers/gpu/drm/tegra/hub.c                   |  2 +-
>  drivers/gpu/drm/tinydrm/core/tinydrm-core.c   |  2 +-
>  drivers/gpu/drm/tinydrm/core/tinydrm-pipe.c   |  2 +-
>  drivers/gpu/drm/tve200/tve200_drv.c           |  2 +-
>  drivers/gpu/drm/udl/udl_connector.c           |  1 +
>  drivers/gpu/drm/udl/udl_drv.c                 |  1 +
>  drivers/gpu/drm/udl/udl_main.c                |  1 +
>  drivers/gpu/drm/vc4/vc4_crtc.c                |  2 +-
>  drivers/gpu/drm/vc4/vc4_dpi.c                 |  2 +-
>  drivers/gpu/drm/vc4/vc4_dsi.c                 |  2 +-
>  drivers/gpu/drm/vc4/vc4_hdmi.c                |  2 +-
>  drivers/gpu/drm/vc4/vc4_kms.c                 |  2 +-
>  drivers/gpu/drm/vc4/vc4_txp.c                 |  2 +-
>  drivers/gpu/drm/vc4/vc4_vec.c                 |  2 +-
>  drivers/gpu/drm/virtio/virtgpu_display.c      |  2 +-
>  drivers/gpu/drm/virtio/virtgpu_drv.h          |  2 +-
>  drivers/gpu/drm/vkms/vkms_crtc.c              |  2 +-
>  drivers/gpu/drm/vkms/vkms_drv.c               |  2 +-
>  drivers/gpu/drm/vkms/vkms_output.c            |  2 +-
>  drivers/gpu/drm/vmwgfx/vmwgfx_kms.h           |  2 +-
>  drivers/gpu/drm/xen/xen_drm_front.c           |  2 +-
>  drivers/gpu/drm/xen/xen_drm_front_conn.c      |  2 +-
>  drivers/gpu/drm/xen/xen_drm_front_gem.c       |  2 +-
>  drivers/gpu/drm/xen/xen_drm_front_kms.c       |  2 +-
>  drivers/gpu/drm/zte/zx_drm_drv.c              |  2 +-
>  drivers/gpu/drm/zte/zx_hdmi.c                 |  2 +-
>  drivers/gpu/drm/zte/zx_tvenc.c                |  2 +-
>  drivers/gpu/drm/zte/zx_vga.c                  |  2 +-
>  drivers/gpu/drm/zte/zx_vou.c                  |  2 +-
>  drivers/staging/vboxvideo/vbox_irq.c          |  2 +-
>  drivers/staging/vboxvideo/vbox_mode.c         |  2 +-
>  include/drm/drm_crtc_helper.h                 | 16 ------
>  include/drm/drm_probe_helper.h                | 50 +++++++++++++++++++
>  208 files changed, 256 insertions(+), 200 deletions(-)
>  create mode 100644 include/drm/drm_probe_helper.h

Looks good to me:

Acked-by: Thierry Reding <treding@nvidia.com>

--5UGlQXeG3ziZS81+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlwOPtoACgkQ3SOs138+
s6FjgxAAv4Px+LYOIfaEush22dtJ6p25QYNu587a0AoOcxpfNGVOW5yPiHpVQayr
EDjK676jszSUAMyIvAuGTFqr4CPVCS/+crzorwE/kebJBpYNVcCQRzG/CzVtYpvZ
ehsaTNaynGORa9YAM9DKonMK43BG3FqV9hdluHcXWjWMgdGrCKSpDA/odsVkeOW2
c2/zcbDDp9G2w22A0/oP6KaZc8iBcpAtgFHvKKLbH76oJreDe1rD0Gy6kntwb6x4
MmaDOY9PQUMsBOUM10kIFmaIFaJWtymD7VsOLIm4bd42n8eXuui+MrFkBH9Qx7rZ
X66pRPDDX68+0kkBXKUm7TdGoGT9rnqj7Hh84oNZ1vM90FWfpKlxxa8QXg8JND4D
hN5turzIwCCzU7S98wDLh+kAjXy1r0ymkAedfTtRYdHY7DdxFGY3yD/8WbeQGse1
4Pyx8RjiiL/nsXB0qWkQF2ELGWJTUYhawYihC8GO6Kr+En9HH93pghN8lN91xEXo
61pDxNb3gVTtyVHQgJzkEU7WtOoPEleSZshzDGz0A89X7MdtcdqgfEVWvRoYFZ+Z
uyeJXxM7z1aPcCKOkaYApsVodXjqgzOzw/8rVGeqmNzhUeGkK237Sg0sIhpXB0Ni
unh1SkebIx7oX7bWiX0ZKquZKgY9RWegTeryawHw8MZJjX9dcS0=
=bfFN
-----END PGP SIGNATURE-----

--5UGlQXeG3ziZS81+--


--===============6982407604161856570==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============6982407604161856570==--

