Return-Path: <SRS0=LcWp=QO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4052C282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 10:35:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8599F2147C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 10:35:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="NbhzBK+W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8599F2147C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=9YJSTkGDyjsdv30Mf7fJqGN7fnvM/a2qV1EC+tUlJKE=; b=NbhzBK+Wqu0cMO
	gKfKaCWFqsRTDn0n9jqzAHHvJv9rIkMt7nf3PcF4S6bENkto6JSO0fEnw3TlUgjuv6xXhLcanQz5j
	jycBkJpaYB0rvvvAZOwOCONA0cJNlNp0ev5K+Uu9lpBIikrsewxpKr7uwMFF2aIasySDQbceuXflK
	JXKBRMjOcvcvV5dqIUJXFp9iA2FKjz91RQEjJZQv98ZdA/xMCkPBgxnBsaQgyyMVnTkB6UGZEkIYF
	rK/0cFxB9T6PJFwxDbOoWA2WrD+EDeonH2Do1t/Lw6z67AazjDxo6N39UZFJbH/3BbuZeIvmYKOyB
	tXeExzMDbCwx1Iq+ILsw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grh2A-0005ub-Fh; Thu, 07 Feb 2019 10:35:54 +0000
Received: from metis.ext.pengutronix.de ([2001:67c:670:201:290:27ff:fe1d:cc33])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grh25-0005sl-RG
 for linux-arm-kernel@lists.infradead.org; Thu, 07 Feb 2019 10:35:51 +0000
Received: from lupine.hi.pengutronix.de
 ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
 by metis.ext.pengutronix.de with esmtp (Exim 4.89)
 (envelope-from <p.zabel@pengutronix.de>)
 id 1grh22-0007Wm-9V; Thu, 07 Feb 2019 11:35:46 +0100
Message-ID: <1549535746.4557.3.camel@pengutronix.de>
Subject: Re: [PATCH v3] dt-bindings: reset: meson: add g12a bindings
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Jerome Brunet <jbrunet@baylibre.com>, Kevin Hilman <khilman@baylibre.com>
Date: Thu, 07 Feb 2019 11:35:46 +0100
In-Reply-To: <20190201125003.25022-1-jbrunet@baylibre.com>
References: <20190201125003.25022-1-jbrunet@baylibre.com>
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-arm-kernel@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190207_023550_059204_0AF48772 
X-CRM114-Status: GOOD (  17.33  )
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
Cc: devicetree@vger.kernel.org, Neil Armstrong <narmstrong@baylibre.com>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-amlogic@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Jerome,

is there any public documentation for the G12A reset controller?

On Fri, 2019-02-01 at 13:50 +0100, Jerome Brunet wrote:
> Add device tree bindings for the reset controller of g12a SoC family.
> 
> Acked-by: Neil Armstrong <narmstrong@baylibre.com>
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
> 
> Changes since v2 [0]:
> * Dropped useless g12a compatible

What if in the future somebody notices that a g12a specific workaround
needs to be added to the driver? I agree that we don't have to list all
compatibles in the driver, but unless you are certain that the reset
controller is identical to the one from another SoC, it would be better
to have a SoC specific compatible in the device tree, even if the driver
only matches to a more generic compatible. For example:

	compatible = "amlogic,meson-g12a-reset", "amlogic,meson8b-reset";

if the reset controller behaves identical to the one in meson8b.

> [0]: https://lkml.kernel.org/r/20190128181316.30814-1-jbrunet@baylibre.com
> 
>  .../reset/amlogic,meson-g12a-reset.h          | 134 ++++++++++++++++++
>  1 file changed, 134 insertions(+)
>  create mode 100644 include/dt-bindings/reset/amlogic,meson-g12a-reset.h
> 
> diff --git a/include/dt-bindings/reset/amlogic,meson-g12a-reset.h b/include/dt-bindings/reset/amlogic,meson-g12a-reset.h
> new file mode 100644
> index 000000000000..8063e8314eef
> --- /dev/null
> +++ b/include/dt-bindings/reset/amlogic,meson-g12a-reset.h
> @@ -0,0 +1,134 @@
> +/* SPDX-License-Identifier: GPL-2.0+ OR BSD-3-Clause */
> +/*
> + * Copyright (c) 2019 BayLibre, SAS.
> + * Author: Jerome Brunet <jbrunet@baylibre.com>
> + *
> + */
> +
> +#ifndef _DT_BINDINGS_AMLOGIC_MESON_G12A_RESET_H
> +#define _DT_BINDINGS_AMLOGIC_MESON_G12A_RESET_H
> +
> +/*	RESET0					*/
> +#define RESET_HIU			0
> +/*					1	*/
> +#define RESET_DOS			2
> +/*					3-4	*/
> +#define RESET_VIU			5
> +#define RESET_AFIFO			6
> +#define RESET_VID_PLL_DIV		7
> +/*					8-9	*/
> +#define RESET_VENC			10
> +#define RESET_ASSIST			11
> +#define RESET_PCIE_CTRL_A		12
> +#define RESET_VCBUS			13
> +#define RESET_PCIE_PHY			14
> +#define RESET_PCIE_APB			15
> +#define RESET_GIC			16
> +#define RESET_CAPB3_DECODE		17
> +/*					18	*/
> +#define RESET_HDMITX_CAPB3		19
> +#define RESET_DVALIN_CAPB3		20
> +#define RESET_DOS_CAPB3			21
> +/*					22	*/
> +#define RESET_CBUS_CAPB3		23
> +#define RESET_AHB_CNTL			24
> +#define RESET_AHB_DATA			25
> +#define RESET_VCBUS_CLK81		26
> +/*					27-31	*/
> +/*	RESET1					*/
> +/*					32	*/
> +#define RESET_DEMUX			33
> +#define RESET_USB			34
> +#define RESET_DDR			35
> +/*					36	*/
> +#define RESET_BT656			37
> +#define RESET_AHB_SRAM			38
> +/*					39	*/
> +#define RESET_PARSER			40
> +/*					41	*/
> +#define RESET_ISA			42
> +#define RESET_ETHERNET			43
> +#define RESET_SD_EMMC_A			44
> +#define RESET_SD_EMMC_B			45
> +#define RESET_SD_EMMC_C			46
> +/*					47-60 */
> +#define RESET_AUDIO_CODEC		61
> +/*					62-63	*/
> +/*	RESET2					*/
> +/*					64	*/
> +#define RESET_AUDIO			65
> +#define RESET_HDMITX_PHY		66
> +/*					67	*/
> +#define RESET_MIPI_DSI_HOST		68
> +#define RESET_ALOCKER			69
> +#define RESET_GE2D			70
> +#define RESET_PARSER_REG		71
> +#define RESET_PARSER_FETCH		72
> +#define RESET_CTL			73
> +#define RESET_PARSER_TOP		74
> +/*					75-77	*/
> +#define RESET_DVALIN			78
> +#define RESET_HDMITX			79
> +/*					80-95	*/
> +/*	RESET3					*/
> +/*					96-95	*/
> +#define RESET_DEMUX_TOP			105
> +#define RESET_DEMUX_DES_PL		106
> +#define RESET_DEMUX_S2P_0		107
> +#define RESET_DEMUX_S2P_1		108
> +#define RESET_DEMUX_0			109
> +#define RESET_DEMUX_1			110
> +#define RESET_DEMUX_2			111
> +/*					112-127	*/
> +/*	RESET4					*/
> +/*					128-129	*/
> +#define RESET_MIPI_DSI_PHY		130
> +/*					131-132	*/
> +#define RESET_RDMA			133
> +#define RESET_VENCI			134
> +#define RESET_VENCP			135
> +/*					136	*/
> +#define RESET_VDAC			137
> +/*					138-139 */
> +#define RESET_VDI6			140
> +#define RESET_VENCL			141
> +#define RESET_I2C_M1			142
> +#define RESET_I2C_M2			143
> +/*					144-159	*/
> +/*	RESET5					*/
> +/*					160-191	*/
> +/*	RESET6					*/
> +#define RESET_GEN			192
> +#define RESET_SPICC0			193
> +#define RESET_SC			194
> +#define RESET_SANA_3			195
> +#define RESET_I2C_M0			196
> +#define RESET_TS_PLL			197
> +#define RESET_SPICC1			198
> +#define RESET_STREAM			199
> +#define RESET_TS_CPU			200
> +#define RESET_UART0			201
> +#define RESET_UART1_2			202
> +#define RESET_ASYNC0			203
> +#define RESET_ASYNC1			204
> +#define RESET_SPIFC0			205
> +#define RESET_I2C_M3			206
> +/*					207-223	*/
> +/*	RESET7					*/
> +#define RESET_USB_DDR_0			224
> +#define RESET_USB_DDR_1			225
> +#define RESET_USB_DDR_2			226
> +#define RESET_USB_DDR_3			227
> +#define RESET_TS_GPU			228
> +#define RESET_DEVICE_MMC_ARB		229
> +#define RESET_DVALIN_DMC_PIPL		230
> +#define RESET_VID_LOCK			231
> +#define RESET_NIC_DMC_PIPL		232
> +#define RESET_DMC_VPU_PIPL		233
> +#define RESET_GE2D_DMC_PIPL		234
> +#define RESET_HCODEC_DMC_PIPL		235
> +#define RESET_WAVE420_DMC_PIPL		236
> +#define RESET_HEVCF_DMC_PIPL		237
> +/*					238-255	*/
> +
> +#endif

regards
Philipp

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
