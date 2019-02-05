Return-Path: <SRS0=y9BX=QM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BAF9C282CC
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 06:07:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CAA6C2145D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 06:07:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Ydl215H6";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mobiveil.co.in header.i=@mobiveil.co.in header.b="jumluG8r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAA6C2145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mobiveil.co.in
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=j1LWGddmozFlSQ0/X3LQe0POV0dFwkv4I2zntlGukZ8=; b=Ydl215H6hatnYP
	gLGNN08ybaj/HtG0ZM8v3AYFGrkJwL8v0e3XEwNYuI0aj3R5ckC/bzAItbXWvICV1qraCmXAq6dvW
	s964Hxxrt/Ajz2GMzGAu27SH32AeVzdTMavf+ocH44l9U60jzVrjogn2niqCo63/wdgFd3XxWdpaB
	/I3g/qL8baQcur64M9A9GujNKic6ZBHILmeEpFAVmEN7WokxZHErWDRgnnfimi2sKSAA+DUkhBVWK
	tnjhc8w9Y+acRqsJbqtAYD47w4YAMDOR7MuJZLedY+Z+RUMw6gQNuN+K8DYBGljSizNCFnBxBPfoa
	Ixpyn78lGR2aGgx+QT1g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqttW-0000sD-7v; Tue, 05 Feb 2019 06:07:42 +0000
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqttQ-0000r2-Or
 for linux-arm-kernel@lists.infradead.org; Tue, 05 Feb 2019 06:07:38 +0000
Received: by mail-wr1-x436.google.com with SMTP id x10so2261497wrs.8
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 04 Feb 2019 22:07:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mobiveil.co.in; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=1X7N/dVorY1n8o81SeDGrzaKlbKZ1oT9Ljxn+D684ws=;
 b=jumluG8r5o7eqoHVTBNXM7Z+nNa3LZuGQCTHMO01skLXnrTLcrRBGBPAtx88LvgE6F
 GiPEQHi8dL/1FgSrJ7OTeYohrHuhvJl9tu2ZSF5U0lFuBlcNcH2YveeKRPYW9y12G/a0
 DbYgjwSbSH44ln9wfgDpp8716HSHKAEEio5pY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=1X7N/dVorY1n8o81SeDGrzaKlbKZ1oT9Ljxn+D684ws=;
 b=SN5d0OqxrLTcs3NVlQuIeCmALOYmnLaPynCqIHG20emxgKEiGlGSOBGi3I6RZQ6rWM
 +z4ZSNE0XdewJs5PdpW+BenaHTRZghc37IPQqJJosMlXI/FXfGI1CGX7ivvmRUXgJnkk
 Gu2UqVrU4q2lds0Gai5cxrChpxjRGe1NGjify3YFhqwdXYUhoDaLP1JYYsZxkTjyY9Cj
 HNycjN8Fuxs2t0H16KMa4D84sn8tquUcYvTpzCQ9jtpT8WigJRTZ+xULiGzFuXKdjk+r
 4UV5t61gr6vCOnE+bUCRqPXf1RJuT7HZXwMEiTlyfGcBfxKygEzxeSySNQGaGMsQTMJm
 lZYg==
X-Gm-Message-State: AHQUAuaZSFJLwlalgfTuO0HWXcqFkJwUaeawUoYKTpgIWI3XP2h3jQFX
 0NzkcASRLCkWaFrqsYmgrTTl9ENlh4wLEa7XzrWndg==
X-Google-Smtp-Source: AHgI3IajLMCsjUiL81ay7NlI0dd+u6tmSbiQ8q9kBaX+M8wgdiG6RzjvFLo6n8XPeco0SV0skbS408EoBQX1jwRiKgw=
X-Received: by 2002:a5d:4ec7:: with SMTP id s7mr2206258wrv.14.1549346854954;
 Mon, 04 Feb 2019 22:07:34 -0800 (PST)
MIME-Version: 1.0
References: <20190129080926.36773-1-Zhiqiang.Hou@nxp.com>
 <20190129080926.36773-10-Zhiqiang.Hou@nxp.com>
In-Reply-To: <20190129080926.36773-10-Zhiqiang.Hou@nxp.com>
From: Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
Date: Tue, 5 Feb 2019 11:40:08 +0530
Message-ID: <CAFZiPx2Qc50LpfdaBm=FYcQPmO5eB5j4SB8w-rNVs0jmJc6jqw@mail.gmail.com>
Subject: Re: [PATCHv3 09/27] PCI: mobiveil: correct inbound/outbound window
 setup routines
To: "Z.q. Hou" <zhiqiang.hou@nxp.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190204_220736_872590_0BCEFB90 
X-CRM114-Status: GOOD (  20.93  )
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
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
 Xiaowei Bao <xiaowei.bao@nxp.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "will.deacon@arm.com" <will.deacon@arm.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Leo Li <leoyang.li@nxp.com>, "M.h. Lian" <minghuan.lian@nxp.com>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>, Mingkai Hu <mingkai.hu@nxp.com>,
 "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 "bhelgaas@google.com" <bhelgaas@google.com>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

ZQ,
please correct the tab spacing of the macro definitions, otherwise its OK.

Reviewed-by: Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>

On Tue, Jan 29, 2019 at 1:39 PM Z.q. Hou <zhiqiang.hou@nxp.com> wrote:
>
> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
>
> Outbound window routine:
>  - Removed unused var definition and register read operations.
>  - Added the upper 32-bit cpu address setup of the window.
>  - Instead of blindly write, only change the fields specified.
>  - Masked the lower bits of window size in case override the
>    control bits.
>  - Check if the passing window number is available, instead of
>    the total number of the initialized windows.
>
> Inbound window routine:
>  - Added parameter 'u64 cpu_addr' to specify the cpu address
>    of the window instead of using 'pci_addr'.
>  - Changed 'int pci_addr' to 'u64 pci_addr', and added setup
>    of the upper 32-bit pci address of the window.
>  - Moved the PCIe PIO master enablement to mobiveil_host_init().
>  - Instead of blindly write, only change the fields specified.
>  - Masked the lower bits of window size in case override the
>    control bits.
>  - Check if the passing window number is available, instead of
>    the total number of the initialized windows.
>  - And added the statistic of initialized inbound windows.
>
> Fixes: 9af6bcb11e12 ("PCI: mobiveil: Add Mobiveil PCIe Host
> Bridge IP driver")
> Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> Reviewed-by: Minghuan Lian <Minghuan.Lian@nxp.com>
> ---
> V3:
>  - No change
>
>  drivers/pci/controller/pcie-mobiveil.c | 70 +++++++++++++++-----------
>  1 file changed, 42 insertions(+), 28 deletions(-)
>
> diff --git a/drivers/pci/controller/pcie-mobiveil.c b/drivers/pci/controller/pcie-mobiveil.c
> index e88afc792a5c..4ba458474e42 100644
> --- a/drivers/pci/controller/pcie-mobiveil.c
> +++ b/drivers/pci/controller/pcie-mobiveil.c
> @@ -65,9 +65,13 @@
>  #define PAB_AXI_AMAP_CTRL(win)         PAB_REG_ADDR(0x0ba0, win)
>  #define  WIN_ENABLE_SHIFT              0
>  #define  WIN_TYPE_SHIFT                        1
> +#define  WIN_TYPE_MASK                 0x3
> +#define  WIN_SIZE_SHIFT                        10
> +#define  WIN_SIZE_MASK                 0x3fffff
>
>  #define PAB_EXT_AXI_AMAP_SIZE(win)     PAB_EXT_REG_ADDR(0xbaf0, win)
>
> +#define PAB_EXT_AXI_AMAP_AXI_WIN(win)  PAB_EXT_REG_ADDR(0x80a0, win)
>  #define PAB_AXI_AMAP_AXI_WIN(win)      PAB_REG_ADDR(0x0ba4, win)
>  #define  AXI_WINDOW_ALIGN_MASK         3
>
> @@ -82,8 +86,10 @@
>  #define PAB_PEX_AMAP_CTRL(win)         PAB_REG_ADDR(0x4ba0, win)
>  #define  AMAP_CTRL_EN_SHIFT            0
>  #define  AMAP_CTRL_TYPE_SHIFT          1
> +#define  AMAP_CTRL_TYPE_MASK           3
>
>  #define PAB_EXT_PEX_AMAP_SIZEN(win)    PAB_EXT_REG_ADDR(0xbef0, win)
> +#define PAB_EXT_PEX_AMAP_AXI_WIN(win)  PAB_EXT_REG_ADDR(0xb4a0, win)
>  #define PAB_PEX_AMAP_AXI_WIN(win)      PAB_REG_ADDR(0x4ba4, win)
>  #define PAB_PEX_AMAP_PEX_WIN_L(win)    PAB_REG_ADDR(0x4ba8, win)
>  #define PAB_PEX_AMAP_PEX_WIN_H(win)    PAB_REG_ADDR(0x4bac, win)
> @@ -455,49 +461,51 @@ static int mobiveil_pcie_parse_dt(struct mobiveil_pcie *pcie)
>  }
>
>  static void program_ib_windows(struct mobiveil_pcie *pcie, int win_num,
> -                              int pci_addr, u32 type, u64 size)
> +                              u64 cpu_addr, u64 pci_addr, u32 type, u64 size)
>  {
> -       int pio_ctrl_val;
> -       int amap_ctrl_dw;
> +       u32 value;
>         u64 size64 = ~(size - 1);
>
> -       if ((pcie->ib_wins_configured + 1) > pcie->ppio_wins) {
> +       if (win_num >= pcie->ppio_wins) {
>                 dev_err(&pcie->pdev->dev,
>                         "ERROR: max inbound windows reached !\n");
>                 return;
>         }
>
> -       pio_ctrl_val = csr_readl(pcie, PAB_PEX_PIO_CTRL);
> -       pio_ctrl_val |= 1 << PIO_ENABLE_SHIFT;
> -       csr_writel(pcie, pio_ctrl_val, PAB_PEX_PIO_CTRL);
> -
> -       amap_ctrl_dw = csr_readl(pcie, PAB_PEX_AMAP_CTRL(win_num));
> -       amap_ctrl_dw |= (type << AMAP_CTRL_TYPE_SHIFT) |
> -                       (1 << AMAP_CTRL_EN_SHIFT) |
> -                       lower_32_bits(size64);
> -       csr_writel(pcie, amap_ctrl_dw, PAB_PEX_AMAP_CTRL(win_num));
> +       value = csr_readl(pcie, PAB_PEX_AMAP_CTRL(win_num));
> +       value &= ~(AMAP_CTRL_TYPE_MASK << AMAP_CTRL_TYPE_SHIFT |
> +                WIN_SIZE_MASK << WIN_SIZE_SHIFT);
> +       value |= (type << AMAP_CTRL_TYPE_SHIFT) | (1 << AMAP_CTRL_EN_SHIFT) |
> +                (lower_32_bits(size64) & WIN_SIZE_MASK << WIN_SIZE_SHIFT);
> +       csr_writel(pcie, value, PAB_PEX_AMAP_CTRL(win_num));
>
>         csr_writel(pcie, upper_32_bits(size64),
>                    PAB_EXT_PEX_AMAP_SIZEN(win_num));
>
> -       csr_writel(pcie, pci_addr, PAB_PEX_AMAP_AXI_WIN(win_num));
> +       csr_writel(pcie, lower_32_bits(cpu_addr),
> +                  PAB_PEX_AMAP_AXI_WIN(win_num));
> +       csr_writel(pcie, upper_32_bits(cpu_addr),
> +                  PAB_EXT_PEX_AMAP_AXI_WIN(win_num));
> +
> +       csr_writel(pcie, lower_32_bits(pci_addr),
> +                  PAB_PEX_AMAP_PEX_WIN_L(win_num));
> +       csr_writel(pcie, upper_32_bits(pci_addr),
> +                  PAB_PEX_AMAP_PEX_WIN_H(win_num));
>
> -       csr_writel(pcie, pci_addr, PAB_PEX_AMAP_PEX_WIN_L(win_num));
> -       csr_writel(pcie, 0, PAB_PEX_AMAP_PEX_WIN_H(win_num));
> +       pcie->ib_wins_configured++;
>  }
>
>  /*
>   * routine to program the outbound windows
>   */
>  static void program_ob_windows(struct mobiveil_pcie *pcie, int win_num,
> -                              u64 cpu_addr, u64 pci_addr,
> -                              u32 config_io_bit, u64 size)
> +                              u64 cpu_addr, u64 pci_addr, u32 type, u64 size)
>  {
>
> -       u32 value, type;
> +       u32 value;
>         u64 size64 = ~(size - 1);
>
> -       if ((pcie->ob_wins_configured + 1) > pcie->apio_wins) {
> +       if (win_num >= pcie->apio_wins) {
>                 dev_err(&pcie->pdev->dev,
>                         "ERROR: max outbound windows reached !\n");
>                 return;
> @@ -507,10 +515,12 @@ static void program_ob_windows(struct mobiveil_pcie *pcie, int win_num,
>          * program Enable Bit to 1, Type Bit to (00) base 2, AXI Window Size Bit
>          * to 4 KB in PAB_AXI_AMAP_CTRL register
>          */
> -       type = config_io_bit;
>         value = csr_readl(pcie, PAB_AXI_AMAP_CTRL(win_num));
> -       csr_writel(pcie, 1 << WIN_ENABLE_SHIFT | type << WIN_TYPE_SHIFT |
> -                  lower_32_bits(size64), PAB_AXI_AMAP_CTRL(win_num));
> +       value &= ~(WIN_TYPE_MASK << WIN_TYPE_SHIFT |
> +                WIN_SIZE_MASK << WIN_SIZE_SHIFT);
> +       value |= 1 << WIN_ENABLE_SHIFT | type << WIN_TYPE_SHIFT |
> +                (lower_32_bits(size64) & WIN_SIZE_MASK << WIN_SIZE_SHIFT);
> +       csr_writel(pcie, value, PAB_AXI_AMAP_CTRL(win_num));
>
>         csr_writel(pcie, upper_32_bits(size64), PAB_EXT_AXI_AMAP_SIZE(win_num));
>
> @@ -518,11 +528,10 @@ static void program_ob_windows(struct mobiveil_pcie *pcie, int win_num,
>          * program AXI window base with appropriate value in
>          * PAB_AXI_AMAP_AXI_WIN0 register
>          */
> -       value = csr_readl(pcie, PAB_AXI_AMAP_AXI_WIN(win_num));
> -       csr_writel(pcie, cpu_addr & (~AXI_WINDOW_ALIGN_MASK),
> +       csr_writel(pcie, lower_32_bits(cpu_addr) & (~AXI_WINDOW_ALIGN_MASK),
>                    PAB_AXI_AMAP_AXI_WIN(win_num));
> -
> -       value = csr_readl(pcie, PAB_AXI_AMAP_PEX_WIN_H(win_num));
> +       csr_writel(pcie, upper_32_bits(cpu_addr),
> +                  PAB_EXT_AXI_AMAP_AXI_WIN(win_num));
>
>         csr_writel(pcie, lower_32_bits(pci_addr),
>                    PAB_AXI_AMAP_PEX_WIN_L(win_num));
> @@ -604,6 +613,11 @@ static int mobiveil_host_init(struct mobiveil_pcie *pcie)
>         value |= APIO_EN_MASK;
>         csr_writel(pcie, value, PAB_AXI_PIO_CTRL);
>
> +       /* Enable PCIe PIO master */
> +       value = csr_readl(pcie, PAB_PEX_PIO_CTRL);
> +       value |= 1 << PIO_ENABLE_SHIFT;
> +       csr_writel(pcie, value, PAB_PEX_PIO_CTRL);
> +
>         /*
>          * we'll program one outbound window for config reads and
>          * another default inbound window for all the upstream traffic
> @@ -616,7 +630,7 @@ static int mobiveil_host_init(struct mobiveil_pcie *pcie)
>                            CFG_WINDOW_TYPE, resource_size(pcie->ob_io_res));
>
>         /* memory inbound translation window */
> -       program_ib_windows(pcie, WIN_NUM_0, 0, MEM_WINDOW_TYPE, IB_WIN_SIZE);
> +       program_ib_windows(pcie, WIN_NUM_0, 0, 0, MEM_WINDOW_TYPE, IB_WIN_SIZE);
>
>         /* Get the I/O and memory ranges from DT */
>         resource_list_for_each_entry(win, &pcie->resources) {
> --
> 2.17.1
>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
