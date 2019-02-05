Return-Path: <SRS0=y9BX=QM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2F54C282CB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 06:09:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5E352146F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 06:09:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="X2Dxuc0V";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mobiveil.co.in header.i=@mobiveil.co.in header.b="JQjyNvjZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5E352146F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mobiveil.co.in
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=wPAeZLhuPk3DMhcwqAyBfjAlprNvREebSRTj+g3x7So=; b=X2Dxuc0VmAJg+k
	EjOWTX5LU5baSCwX0gvY0UWkytqYOEzBoRw6R9InvgHTTFnQUhOS8HAxJkny1W7GpUSDiCcrH5id8
	0LIJ1eCfcVZojbEnx0YwBC44J1VYVDP8ge+fUB0cqr61VEYGk8arFDFCtJxrlyUc4q/UtqaIy2gu/
	RiR75/in/DdaC08blHUqxQm4JIc/C1bfGBqF4naLUgdCbaeaHepV+IY4eFePFSVuHWPcdPPMkDSUB
	H5bDTS0zBUbbiY9SLLiDZBlrWS/waWE2NpYPondDStqKUebQ+PUHF+KrtPRlpMcI1RVzjgKRpTVqW
	BVYVOB2lrENFi27KjQEg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqtvV-0001np-ME; Tue, 05 Feb 2019 06:09:45 +0000
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqtvQ-0001mk-F1
 for linux-arm-kernel@lists.infradead.org; Tue, 05 Feb 2019 06:09:44 +0000
Received: by mail-wm1-x342.google.com with SMTP id r24so11695353wmh.0
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 04 Feb 2019 22:09:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mobiveil.co.in; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=RdqnK8Sush9EMCE1fFJIyiI9lYcylVQGWUm228F9l+M=;
 b=JQjyNvjZOBil8q9iAorY2tERlu1QjToI85LOozJUiZE+qJke32JsVqqf1J8KJnK2d5
 22xkaKyZapXLrAXCS2memoDt3mTJ+9JJM52z3Tke1Ddcdv1jx9ER28HzN4BZkwY1xHov
 zuqqHkludEn4JXqX0/+4+4WVBOMIMh0/8+NTA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=RdqnK8Sush9EMCE1fFJIyiI9lYcylVQGWUm228F9l+M=;
 b=MO6QiQJPXBctWN5EOzKNbaoww3Jqjt+xsvNWRoCfq3ODPsQXLNPbs6mUAgwyoZB+Oc
 ouUr5s0DNcOovHW1mEWgFUCmfx1wI6XU3kcGrdEydrK292Y97Q04ugNd7v0l7p9bEPRF
 7hD7AGeQjy9mhnuwGdOSH4kMa7yslsx8Hus8h2V/iwjPtXRApl0IiaH67j/+PNxdNNf3
 xvpeILqmpUhRogmB0JzOcJvXE7cuVW6NvJ3cbVhOSgEzqC/6iq/h5tU3E8Ly77lRkOnu
 ZZH/qBJg2we8Ck7rqVi1TCA9bDxp3jUBrOQkxTWAiCQrUxyvIt/FzaoRwF/UBuD7m/e4
 bsYg==
X-Gm-Message-State: AHQUAuaHw3TuUWCaIurDZygBJlfaBvPfk3Lyr/FIwcquhBT3L6ATeD/Z
 STBA4c/+ICRcq9bf3jYLIDQjoqwqMaoAkDiPbKdMhQ==
X-Google-Smtp-Source: AHgI3IZ94KpSa1rFUiP8ICd+DRFXJ3gmTCXEbGLNFKoo2UQqsYqDvegQhzUIXAFmny8CreI3DLHmbWw4VYKyullADL4=
X-Received: by 2002:a7b:c5d1:: with SMTP id n17mr2163957wmk.152.1549346979076; 
 Mon, 04 Feb 2019 22:09:39 -0800 (PST)
MIME-Version: 1.0
References: <20190129080926.36773-1-Zhiqiang.Hou@nxp.com>
 <20190129080926.36773-13-Zhiqiang.Hou@nxp.com>
In-Reply-To: <20190129080926.36773-13-Zhiqiang.Hou@nxp.com>
From: Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
Date: Tue, 5 Feb 2019 11:42:13 +0530
Message-ID: <CAFZiPx3wPsO3CkLZD9SxUTkqVZR1fW4qqAtsNxcYHMNVsD82gw@mail.gmail.com>
Subject: Re: [PATCHv3 12/27] PCI: mobiveil: move out the link up waiting from
 mobiveil_host_init
To: "Z.q. Hou" <zhiqiang.hou@nxp.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190204_220940_845199_DE2B7194 
X-CRM114-Status: GOOD (  16.72  )
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

Reviewed-by: Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>

On Tue, Jan 29, 2019 at 1:39 PM Z.q. Hou <zhiqiang.hou@nxp.com> wrote:
>
> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
>
> Host initial sequence does not depend on PCIe link up, so move it
> to the place just before the enumeration.
>
> Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> Reviewed-by: Minghuan Lian <Minghuan.Lian@nxp.com>
> ---
> V3:
>  - No change
>
>  drivers/pci/controller/pcie-mobiveil.c | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/pci/controller/pcie-mobiveil.c b/drivers/pci/controller/pcie-mobiveil.c
> index 8eee1ab7ee24..c2848c22b466 100644
> --- a/drivers/pci/controller/pcie-mobiveil.c
> +++ b/drivers/pci/controller/pcie-mobiveil.c
> @@ -582,15 +582,8 @@ static void mobiveil_pcie_enable_msi(struct mobiveil_pcie *pcie)
>  static int mobiveil_host_init(struct mobiveil_pcie *pcie)
>  {
>         u32 value, pab_ctrl, type;
> -       int err;
>         struct resource_entry *win;
>
> -       err = mobiveil_bringup_link(pcie);
> -       if (err) {
> -               dev_info(&pcie->pdev->dev, "link bring-up failed\n");
> -               return err;
> -       }
> -
>         /*
>          * program Bus Master Enable Bit in Command Register in PAB Config
>          * Space
> @@ -662,7 +655,7 @@ static int mobiveil_host_init(struct mobiveil_pcie *pcie)
>         /* setup MSI hardware registers */
>         mobiveil_pcie_enable_msi(pcie);
>
> -       return err;
> +       return 0;
>  }
>
>  static void mobiveil_mask_intx_irq(struct irq_data *data)
> @@ -922,6 +915,12 @@ static int mobiveil_pcie_probe(struct platform_device *pdev)
>         bridge->map_irq = of_irq_parse_and_map_pci;
>         bridge->swizzle_irq = pci_common_swizzle;
>
> +       ret = mobiveil_bringup_link(pcie);
> +       if (ret) {
> +               dev_info(dev, "link bring-up failed\n");
> +               goto error;
> +       }
> +
>         /* setup the kernel resources for the newly added PCIe root bus */
>         ret = pci_scan_root_bus_bridge(bridge);
>         if (ret)
> --
> 2.17.1
>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
