Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B45FDC04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 18:40:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 875CB2146D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 18:40:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="flPm3AP1";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lfu1PXI3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 875CB2146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:Subject:Message-ID:References:
	In-Reply-To:From:To:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=xAuyj8DZT27wq8F+TWDC9QKaZhdKelDPuyBIPpRC9js=; b=flPm3AP11/7DJD
	P9jVtg3yzGekwciLteG1fofVpQXElwIXBJN+PQFWgS9Od/L7FwrTbr6U7UXUjLuPZPE71Sr4EUZEA
	tWgprXmn7e+NYgkWtovubvEnsPQ+BrlnSoXD0h3vQoJP8eyK2rywJ4k4cmUGVHCY3NUduKkx+17en
	/3JfILRoMUISYV15XG0589hdz/nnS5EDBuWSw4nIHdRSwsYuklujWCFAM/Rc6wt9tzeV25AgL3yyY
	iOg3/HGI9l/jTPCXKEf0yfJxI4CX+SpWzOnCQPi3k0mZDyzt03TvUQOVR4Os4BuYYJfY9BLxBfVou
	MKCRrWGIo+MLHGG7h8xg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTt8s-0003lN-54; Mon, 03 Dec 2018 18:40:26 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTt2W-00059P-N0
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 18:34:39 +0000
Received: from localhost (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 2273B2145D;
 Mon,  3 Dec 2018 18:33:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1543862021;
 bh=oz6A+bf0ogIWlM0m4roHnd74rx8mLkMWd1Pz55Ek66w=;
 h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
 b=Lfu1PXI3GLjdlaoEzfI+P8qhr+/w7iiwqsddOEquEN10wYiMBgJO0I2aznvwbFXM9
 LZkBYCFVoEgA2VboyEoQIitRZMhmtUb90GfKMKCVpIsscRkkly0qVGpbZnkwOuOh3q
 ULi/EnTEFbmmHM/LLJ1LK16GHQZlCXhvcLumDPzw=
MIME-Version: 1.0
To: "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
 Aisheng DONG <aisheng.dong@nxp.com>
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1542809234-539-3-git-send-email-aisheng.dong@nxp.com>
References: <1542809234-539-1-git-send-email-aisheng.dong@nxp.com>
 <1542809234-539-3-git-send-email-aisheng.dong@nxp.com>
Message-ID: <154386202048.88331.5253991483966563852@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH V8 2/7] clk: imx: add scu clock common part
Date: Mon, 03 Dec 2018 10:33:40 -0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_103354_036572_C1499CA8 
X-CRM114-Status: GOOD (  20.74  )
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
Cc: Aisheng DONG <aisheng.dong@nxp.com>,
 "mturquette@baylibre.com" <mturquette@baylibre.com>,
 dl-linux-imx <linux-imx@nxp.com>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Quoting Aisheng DONG (2018-11-21 06:12:23)
> Add scu clock common part which will be used by client clock drivers.
> SCU clocks are totally different from the legacy clocks (No much
> legacy things can be reused). So a new configuration option
> CONFIG_MXC_CLK_SCU is added.

Why are they different? Can you add more details on what has changed
here? I hope to see something like "it's a firmware interface now".

> 
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Sascha Hauer <kernel@pengutronix.de>
> Cc: Fabio Estevam <fabio.estevam@nxp.com>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: Michael Turquette <mturquette@baylibre.com>
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> diff --git a/drivers/clk/imx/clk-scu.c b/drivers/clk/imx/clk-scu.c
> new file mode 100644
> index 0000000..5f9c1f6
> --- /dev/null
> +++ b/drivers/clk/imx/clk-scu.c
> @@ -0,0 +1,267 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright 2018 NXP
> + *   Dong Aisheng <aisheng.dong@nxp.com>
> + */
> +
> +#include <linux/clk-provider.h>
> +#include <linux/err.h>
> +#include <linux/slab.h>
> +
> +#include "clk-scu.h"
> +
> +struct imx_sc_ipc *ccm_ipc_handle;
> +
> +/*
> + * struct clk_scu - Description of one SCU clock
> + * @hw: the common clk_hw
> + * @rsrc_id: resource ID of this SCU clock
> + * @clk_type: type of this clock resource
> + *
> + * This structure describes one SCU clock

Drop this sentence, it duplicates the first line of this kernel-doc.

> + */
> +struct clk_scu {
> +       struct clk_hw hw;
> +       u32 rsrc_id;
> +       u8 clk_type;
> +};
> +
> +/*
> + * struct imx_sc_msg_req_set_clock_rate - clock set rate protocol
> + * @hdr: SCU protocol header
> + * @rate: rate to set
> + * @resource: clock resource to set rate
> + * @clk: clk type of this resource
> + *
> + * This structure describes the SCU protocol of clock rate set
> + */
> +struct imx_sc_msg_req_set_clock_rate {
> +       struct imx_sc_rpc_msg hdr;
> +       u32 rate;
> +       u16 resource;

These should be __le32 and __le16 presumably because the firmware
interface we're talking to is little endian?

> +       u8 clk;
> +} __packed;
> +
> +struct req_get_clock_rate {
> +       u16 resource;

Same.

> +       u8 clk;
> +} __packed;
> +
> +struct resp_get_clock_rate {
> +       u32 rate;

Same.

> +};
> +
> +/*
> + * struct imx_sc_msg_get_clock_rate - clock get rate protocol
> + * @hdr: SCU protocol header
> + * @req: get rate request protocol
> + * @resp: get rate response protocol
> + *
> + * This structure describes the SCU protocol of clock rate get
> + */
> +struct imx_sc_msg_get_clock_rate {
> +       struct imx_sc_rpc_msg hdr;
> +       union {
> +               struct req_get_clock_rate req;
> +               struct resp_get_clock_rate resp;
> +       } data;
> +} __packed;

Does this need __packed? struct imx_sc_rpc_msg is naturally aligned so I
think we don't need this.

> +
> +/*
> + * struct imx_sc_msg_req_clock_enable - clock gate protocol
> + * @hdr: SCU protocol header
> + * @resource: clock resource to gate
> + * @clk: clk type of this resource
> + * @enable: whether gate off the clock
> + * @autog: HW auto gate enable
> + *
> + * This structure describes the SCU protocol of clock gate
> + */
> +struct imx_sc_msg_req_clock_enable {
> +       struct imx_sc_rpc_msg hdr;
> +       u16 resource;
> +       u8 clk;
> +       u8 enable;
> +       u8 autog;
> +} __packed;
> +
> +static inline struct clk_scu *to_clk_scu(struct clk_hw *hw)
> +{
> +       return container_of(hw, struct clk_scu, hw);
> +}
> +
> +/*
> + * clk_scu_recalc_rate - Get clock rate for a SCU clock
> + * @hw: clock to get rate for
> + * @parent_rate: parent rate provided by common clock framework, not used
> + *
> + * Gets the current clock rate of a SCU clock. Returns the current
> + * clock rate, or zero in failure.
> + */
> +static unsigned long clk_scu_recalc_rate(struct clk_hw *hw,
> +                                        unsigned long parent_rate)
> +{
> +       struct clk_scu *clk = to_clk_scu(hw);
> +       struct imx_sc_msg_get_clock_rate msg;

I really hope msg isn't DMAed to the firmware, because the response is
in there!

> +       struct imx_sc_rpc_msg *hdr = &msg.hdr;
> +       int ret;
> +
> +       hdr->ver = IMX_SC_RPC_VERSION;
> +       hdr->svc = IMX_SC_RPC_SVC_PM;
> +       hdr->func = IMX_SC_PM_FUNC_GET_CLOCK_RATE;
> +       hdr->size = 2;
> +
> +       msg.data.req.resource = clk->rsrc_id;
> +       msg.data.req.clk = clk->clk_type;
> +
> +       ret = imx_scu_call_rpc(ccm_ipc_handle, &msg, true);
> +       if (ret) {
> +               pr_err("%s: failed to get clock rate %d\n",
> +                      clk_hw_get_name(hw), ret);
> +               return 0;
> +       }
> +
> +       return msg.data.resp.rate;
> +}
> +
> +/*
> + * clk_scu_round_rate - Round clock rate for a SCU clock
> + * @hw: clock to round rate for
> + * @rate: rate to round
> + * @parent_rate: parent rate provided by common clock framework, not used
> + *
> + * Returns the current clock rate, or zero in failure.
> + */
> +static long clk_scu_round_rate(struct clk_hw *hw, unsigned long rate,
> +                              unsigned long *parent_rate)
> +{
> +       /*
> +        * Assume we support all the requested rate and let the SCU firmware
> +        * to handle the left work
> +        */
> +       return rate;
> +}
> +
> +/*
> + * clk_scu_set_rate - Set rate for a SCU clock
> + * @hw: clock to change rate for
> + * @rate: target rate for the clock
> + * @parent_rate: rate of the clock parent, not used for SCU clocks
> + *
> + * Sets a clock frequency for a SCU clock. Returns the SCU
> + * protocol status.
> + */
> +static int clk_scu_set_rate(struct clk_hw *hw, unsigned long rate,
> +                           unsigned long parent_rate)
> +{
> +       struct clk_scu *clk = to_clk_scu(hw);
> +       struct imx_sc_msg_req_set_clock_rate msg;
> +       struct imx_sc_rpc_msg *hdr = &msg.hdr;
> +
> +       hdr->ver = IMX_SC_RPC_VERSION;
> +       hdr->svc = IMX_SC_RPC_SVC_PM;
> +       hdr->func = IMX_SC_PM_FUNC_SET_CLOCK_RATE;
> +       hdr->size = 3;
> +
> +       msg.rate = rate;
> +       msg.resource = clk->rsrc_id;
> +       msg.clk = clk->clk_type;
> +
> +       return imx_scu_call_rpc(ccm_ipc_handle, &msg, true);

This function returns normal error codes? Or some firmware special error
code? Please make sure we return normal linux errno values from this
driver.

> +}
> +
> +static int sc_pm_clock_enable(struct imx_sc_ipc *ipc, u32 resource,
> +                             u8 clk, bool enable, bool autog)
> +{
> +       struct imx_sc_msg_req_clock_enable msg;
> +       struct imx_sc_rpc_msg *hdr = &msg.hdr;
> +
> +       hdr->ver = IMX_SC_RPC_VERSION;
> +       hdr->svc = IMX_SC_RPC_SVC_PM;
> +       hdr->func = IMX_SC_PM_FUNC_CLOCK_ENABLE;
> +       hdr->size = 3;
> +
> +       msg.resource = resource;
> +       msg.clk = clk;
> +       msg.enable = enable;
> +       msg.autog = autog;
> +
> +       return imx_scu_call_rpc(ccm_ipc_handle, &msg, true);
> +}
> +
> +/*
> + * clk_scu_prepare - Enable a SCU clock
> + * @hw: clock to enable
> + *
> + * Enable the clock at the DSC slice level
> + */
> +static int clk_scu_prepare(struct clk_hw *hw)
> +{
> +       struct clk_scu *clk = to_clk_scu(hw);
> +
> +       return sc_pm_clock_enable(ccm_ipc_handle, clk->rsrc_id,
> +                                 clk->clk_type, true, false);
> +}
> +
> +/*
> + * clk_scu_unprepare - Disable a SCU clock
> + * @hw: clock to enable
> + *
> + * Disable the clock at the DSC slice level
> + */
> +static void clk_scu_unprepare(struct clk_hw *hw)
> +{
> +       struct clk_scu *clk = to_clk_scu(hw);
> +       int ret;
> +
> +       ret = sc_pm_clock_enable(ccm_ipc_handle, clk->rsrc_id,
> +                                clk->clk_type, false, false);
> +       if (ret)
> +               pr_warn("%s: clk unprepare failed %d\n", clk_hw_get_name(hw),
> +                       ret);
> +}
> +
> +static const struct clk_ops clk_scu_ops = {
> +       .recalc_rate = clk_scu_recalc_rate,
> +       .round_rate = clk_scu_round_rate,
> +       .set_rate = clk_scu_set_rate,
> +       .prepare = clk_scu_prepare,
> +       .unprepare = clk_scu_unprepare,
> +};
> +
> +struct clk_hw *imx_clk_scu(const char *name, u32 rsrc_id, u8 clk_type)
> +{
> +       struct clk_init_data init;
> +       struct clk_scu *clk;
> +       struct clk_hw *hw;
> +       int ret;
> +
> +       clk = kzalloc(sizeof(*clk), GFP_KERNEL);
> +       if (!clk)
> +               return ERR_PTR(-ENOMEM);
> +
> +       clk->rsrc_id = rsrc_id;
> +       clk->clk_type = clk_type;
> +
> +       init.name = name;
> +       init.ops = &clk_scu_ops;
> +       init.num_parents = 0;
> +       /*
> +        * Note on MX8, the clocks are tightly coupled with power domain
> +        * that once the power domain is off, the clock status may be
> +        * lost. So we make it NOCACHE to let user to retrieve the real
> +        * clock status from HW instead of using the possible invalid
> +        * cached rate.
> +        */
> +       init.flags = CLK_GET_RATE_NOCACHE;
> +       clk->hw.init = &init;
> +
> +       hw = &clk->hw;
> +       ret = clk_hw_register(NULL, hw);
> +       if (ret) {
> +               kfree(clk);
> +               hw = ERR_PTR(ret);
> +       }
> +
> +       return hw;
> +}
> diff --git a/drivers/clk/imx/clk-scu.h b/drivers/clk/imx/clk-scu.h
> new file mode 100644
> index 0000000..09f381b
> --- /dev/null
> +++ b/drivers/clk/imx/clk-scu.h
> @@ -0,0 +1,21 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * Copyright 2018 NXP
> + *   Dong Aisheng <aisheng.dong@nxp.com>
> + */
> +
> +#ifndef __IMX_CLK_SCU_H
> +#define __IMX_CLK_SCU_H
> +
> +#include <linux/firmware/imx/sci.h>
> +
> +extern struct imx_sc_ipc *ccm_ipc_handle;
> +
> +static inline int imx_clk_scu_init(void)

Is this supposed to return EPROBE_DEFER or something? Who calls this?

> +{
> +       return imx_scu_get_handle(&ccm_ipc_handle);
> +}
> +
> +struct clk_hw *imx_clk_scu(const char *name, u32 rsrc_id, u8 clk_type);
> +

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
