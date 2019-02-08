Return-Path: <SRS0=fpAU=QP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87977C282CB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 12:39:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34CD22177B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 12:39:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="YMRfqHSn";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mobiveil.co.in header.i=@mobiveil.co.in header.b="RRsVGm7H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34CD22177B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mobiveil.co.in
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=dK2QX0zWiuP5cxNdk9AXCtXZo/UTDcRQG9x9q7hT45s=; b=YMRfqHSn8ZlQLF
	hld++rGiSf16roGVsOyFQ4XpJc1gObO8ConralXHJaotv6GCBce6I644YymyPSsiB0G+wx9QBhUda
	fGXLYokSjJokNrgqZSn6wrqpw7hZmzO3tT1jS9EBPyssNOe4us0qpC0FiXLrNGOSt2Lb0W1OjGPd1
	Hw66/wZG5QBDUCIt4eA/BePVaxYSYZ68p9vzsvaWODgbDCYkhZjqZUpr191un3+uIOx3suxCxIDdU
	RDFXTCJbb0YtuQ7hrzvhbplenhLwwWGQj0Bjmry7rWvdYEFVGs5cKqcXGhK6PIf+Hk653ilUM9j13
	cJ+2dgp3W/tKOHesXW+Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gs5RR-0008TQ-AC; Fri, 08 Feb 2019 12:39:37 +0000
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gs5RO-0008SX-MC
 for linux-arm-kernel@lists.infradead.org; Fri, 08 Feb 2019 12:39:36 +0000
Received: by mail-wm1-x344.google.com with SMTP id d15so3269275wmb.3
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 08 Feb 2019 04:39:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mobiveil.co.in; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=8TiUMbeW9gx3E0RaTlHXWjEpmH+gOGQ7pHr2BlHGy88=;
 b=RRsVGm7He3M1H0dan/L6W9QFbvDfV4DdV22eijIGeVYXVK7Fj4k2o8H3QdRJhyv0Rr
 7n10xPbAa1F4rmoR21AM5Lg2l/uNqfcx630EIcVu2AW4AIqDUfyGDv9NJUf49sk7ddvQ
 XmvC0OGenZFfPlD42kmOca47Wol7zADKtTD1Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=8TiUMbeW9gx3E0RaTlHXWjEpmH+gOGQ7pHr2BlHGy88=;
 b=azY63UNkKoa746xh0TDZPYMIoC7BEVrKE1fRdpB/ClFIkyHEb9tGWFydx1/0Gs8zlw
 QriBveC5nnlpH7zn9esu6sxKc+eKiWPzaMEHwV7exv8A1YDy2nDBXRkzfvJ5tj9xDlDM
 um1yXTQeyT8ts9QCBKltZy7cEUjgM4ZhKkjGFR/Z3gE4Ti21U/wmYPWBmlh0AJ1O4Qnj
 /7H3sJJXGrvGB7cw1qWWnIazeRW/kFogBYLGZpcpV+b8Xr3DOafJ6kvDgTV5aSC/ZIkN
 aD62P2kfzFnMnZg3lF9H782PmI5jmZdN0LuszBH4CnreHwVDLzoVvfNQWvUZ5BY2j4F/
 Vuyw==
X-Gm-Message-State: AHQUAuZvz0O6Hs0TCvw58nduVFBbUW6ytlAKor7qJeJ0568pWb8vGk9d
 e1hX1BZmigNwLQIFygmv5XEJox+C2Nhd7Bdhhrv3qA==
X-Google-Smtp-Source: AHgI3IYytYbKN3VNWvXrhJ8UXMmfHdlGAb4mQC3bNjTkJAEpyHTpW4Q3ArQ7aHNEE3zrZzqi5u7Jngf15GXxJYIcaMQ=
X-Received: by 2002:a1c:9e4a:: with SMTP id h71mr11825119wme.82.1549629572788; 
 Fri, 08 Feb 2019 04:39:32 -0800 (PST)
MIME-Version: 1.0
References: <20190129080926.36773-1-Zhiqiang.Hou@nxp.com>
 <20190129080926.36773-20-Zhiqiang.Hou@nxp.com>
In-Reply-To: <20190129080926.36773-20-Zhiqiang.Hou@nxp.com>
From: Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
Date: Fri, 8 Feb 2019 18:12:12 +0530
Message-ID: <CAFZiPx1B7iTKgyr4uRJDescLx+NRLdOhjBdMyCoYA2Hja6Xy2g@mail.gmail.com>
Subject: Re: [PATCHv3 19/27] PCI: mobiveil: disabled IB and OB windows set by
 bootloader
To: "Z.q. Hou" <zhiqiang.hou@nxp.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190208_043934_719480_8B9359E8 
X-CRM114-Status: GOOD (  15.32  )
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

On Tue, Jan 29, 2019 at 1:40 PM Z.q. Hou <zhiqiang.hou@nxp.com> wrote:
>
> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
>
> Disabled all inbound and outbound windows before set up the windows
> in kernel, in case transactions match the window set by bootloader.
>
> Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> Reviewed-by: Minghuan Lian <Minghuan.Lian@nxp.com>
> ---
> V3:
>  - No change
>
>  .../controller/mobiveil/pcie-mobiveil-host.c   |  7 +++++++
>  .../pci/controller/mobiveil/pcie-mobiveil.c    | 18 ++++++++++++++++++
>  .../pci/controller/mobiveil/pcie-mobiveil.h    |  2 ++
>  3 files changed, 27 insertions(+)
>
> diff --git a/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c b/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c
> index d1765d572f44..d028cdf31d0e 100644
> --- a/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c
> +++ b/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c
> @@ -221,6 +221,13 @@ static int mobiveil_host_init(struct mobiveil_pcie *pcie)
>  {
>         u32 value, pab_ctrl, type;
>         struct resource_entry *win;
> +       int i;
> +
> +       /* Disable all inbound/outbound windows */
> +       for (i = 0; i < pcie->apio_wins; i++)
> +               mobiveil_pcie_disable_ob_win(pcie, i);
> +       for (i = 0; i < pcie->ppio_wins; i++)
> +               mobiveil_pcie_disable_ib_win(pcie, i);
>
>         /* setup bus numbers */
>         value = csr_readl(pcie, PCI_PRIMARY_BUS);
> diff --git a/drivers/pci/controller/mobiveil/pcie-mobiveil.c b/drivers/pci/controller/mobiveil/pcie-mobiveil.c
> index 370658d6546d..49d471b75925 100644
> --- a/drivers/pci/controller/mobiveil/pcie-mobiveil.c
> +++ b/drivers/pci/controller/mobiveil/pcie-mobiveil.c
> @@ -226,3 +226,21 @@ int mobiveil_bringup_link(struct mobiveil_pcie *pcie)
>
>         return -ETIMEDOUT;
>  }
> +
> +void mobiveil_pcie_disable_ib_win(struct mobiveil_pcie *pci, int win_num)
> +{
> +       u32 val;
> +
> +       val = csr_readl(pci, PAB_PEX_AMAP_CTRL(win_num));
> +       val &= ~(1 << AMAP_CTRL_EN_SHIFT);
> +       csr_writel(pci, val, PAB_PEX_AMAP_CTRL(win_num));
> +}
> +
> +void mobiveil_pcie_disable_ob_win(struct mobiveil_pcie *pci, int win_num)
> +{
> +       u32 val;
> +
> +       val = csr_readl(pci, PAB_AXI_AMAP_CTRL(win_num));
> +       val &= ~(1 << WIN_ENABLE_SHIFT);
> +       csr_writel(pci, val, PAB_AXI_AMAP_CTRL(win_num));
> +}
> diff --git a/drivers/pci/controller/mobiveil/pcie-mobiveil.h b/drivers/pci/controller/mobiveil/pcie-mobiveil.h
> index eb4cb61291a8..81685840b378 100644
> --- a/drivers/pci/controller/mobiveil/pcie-mobiveil.h
> +++ b/drivers/pci/controller/mobiveil/pcie-mobiveil.h
> @@ -171,6 +171,8 @@ void program_ob_windows(struct mobiveil_pcie *pcie, int win_num, u64 cpu_addr,
>                         u64 pci_addr, u32 type, u64 size);
>  void program_ib_windows(struct mobiveil_pcie *pcie, int win_num, u64 cpu_addr,
>                         u64 pci_addr, u32 type, u64 size);
> +void mobiveil_pcie_disable_ob_win(struct mobiveil_pcie *pci, int win_num);
> +void mobiveil_pcie_disable_ib_win(struct mobiveil_pcie *pci, int win_num);
>  u32 csr_read(struct mobiveil_pcie *pcie, u32 off, size_t size);
>  void csr_write(struct mobiveil_pcie *pcie, u32 val, u32 off, size_t size);
>
> --
> 2.17.1
>
Reviewed-by: Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
