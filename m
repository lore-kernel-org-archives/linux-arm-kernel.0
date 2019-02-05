Return-Path: <SRS0=y9BX=QM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 195B0C282CB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 06:09:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DBC732080D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 06:09:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="OJgp5U41";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mobiveil.co.in header.i=@mobiveil.co.in header.b="aHKYf56s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBC732080D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mobiveil.co.in
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=g4yd3uTfWK5I0L6Eu0q8OI6Q2BqNz3qRTONF6BzU55c=; b=OJgp5U41JmfMga
	6WrKy2remuVa5ubFc1GYqogNweTylXVAg9POJmjzEIol+7lRQGF6cxmrlKHSdU8D6enHgphA/a8Ck
	nwO9au1gwFKcEtjk6AB/bq0bhN1x+qqYF93r8z9Ud5GH6MAcMvOhGYdj8hzR20x05V4eJPop5yT+E
	W+pLWqlFLF9i+/bDG64QqM+RLJcAQpXN11Jkgc0hCDOrpaKKazTTdGHgEylrB7YX9LEJYG8FLz8gX
	ZyYWIOgmoyZJPaJuTnDesMk9+7WscGARDGPi3guzrlgrcRN4MXEEGZ3mxE+YDG/CbopmGnMRN4BRi
	mCWSi3u7oWnZ6UDCCiEA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqtv3-0001Ru-Fc; Tue, 05 Feb 2019 06:09:17 +0000
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqtv0-0001RD-Hf
 for linux-arm-kernel@lists.infradead.org; Tue, 05 Feb 2019 06:09:16 +0000
Received: by mail-wm1-x342.google.com with SMTP id d15so2239746wmb.3
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 04 Feb 2019 22:09:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mobiveil.co.in; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=lcuTAIKDk5Jru1SXfKsJlExjF4BZoU+yuw8KbMKy3Xg=;
 b=aHKYf56soptJIGbTxy7Ay36ZHzUZt9ByQKrEbQ7YWyTZVa+yiJZOJHfEKe98OTeMoS
 Ljq2AWY7gjINK4jUO3Z9Z7PD/iKhdYAFp/MgKTrbZdzECgYkGrc91tdIBO29k8lt0mRX
 FBKJTN6RWQS6W35+KhHDJ1ni4pNvaHl/6QKSo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20130820;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=lcuTAIKDk5Jru1SXfKsJlExjF4BZoU+yuw8KbMKy3Xg=;
 b=K+yny79AxMuGJv9wMSzZWWgixDAV91z8YNCbHJzfkPpBTyy6WhTc+2etffwz6ZGczY
 QZCjumBYnWEgMc5LbeXJMB+sxgDqSVwLkyfcfQKqOeLhd85P8NBpxv5LRpYWwS6PYppZ
 D4u3dkh+I7ioeOxmHOHOEZTOpydYOBIkONypI5Y2+g0FnUV1f79THVKCGE22ChwEtw5K
 c1acLaIVoQ2paKln1TFxD2SjQLb3ULI0Ww0r3jGBojOnvdgd1abL4fZRSXY8738yHf6e
 1KLom8QMLLywq/dqOdtVZEwkMU8WPudtYPrHIiZmuTxd/5ZZPAVYDLFAmOFUaSVDKZNq
 e9gA==
X-Gm-Message-State: AHQUAuZpaBXOw+ZWjJnOQwwnQfgp5c96Us4gpm3b3gKhdf88ps1lgWvu
 Q8YIGtgehtiZMeInXK8t6O4xnBw7rCAv8iDNgIwL/A==
X-Google-Smtp-Source: AHgI3IZumWg/zzG2QOKGcQXa9PNHDYnUquuVdKoMcZ7AX7vf59yven64VfaW8r82JD0Gxa7ySeRxSWJBzW1SPVxlXTc=
X-Received: by 2002:a1c:2d44:: with SMTP id t65mr1986937wmt.0.1549346952749;
 Mon, 04 Feb 2019 22:09:12 -0800 (PST)
MIME-Version: 1.0
References: <20190129080926.36773-1-Zhiqiang.Hou@nxp.com>
 <20190129080926.36773-12-Zhiqiang.Hou@nxp.com>
In-Reply-To: <20190129080926.36773-12-Zhiqiang.Hou@nxp.com>
From: Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
Date: Tue, 5 Feb 2019 11:41:46 +0530
Message-ID: <CAFZiPx0ea9Dnef_H+R0WcS-7V1WDCQTCU1dzta5+LsJjo+M_BQ@mail.gmail.com>
Subject: Re: [PATCHv3 11/27] PCI: mobiveil: only fix up the Class Code field
To: "Z.q. Hou" <zhiqiang.hou@nxp.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190204_220914_587266_8C929951 
X-CRM114-Status: GOOD (  15.42  )
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
> Fix up the Class Code to PCI bridge, do not change the Revision ID.
> And move the fixup to mobiveil_host_init function.
>
> Fixes: 9af6bcb11e12 ("PCI: mobiveil: Add Mobiveil PCIe Host Bridge
> IP driver")
> Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> Reviewed-by: Minghuan Lian <Minghuan.Lian@nxp.com>
> ---
> V3:
>  - No change
>
>  drivers/pci/controller/pcie-mobiveil.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/pci/controller/pcie-mobiveil.c b/drivers/pci/controller/pcie-mobiveil.c
> index 78e575e71f4d..8eee1ab7ee24 100644
> --- a/drivers/pci/controller/pcie-mobiveil.c
> +++ b/drivers/pci/controller/pcie-mobiveil.c
> @@ -653,6 +653,12 @@ static int mobiveil_host_init(struct mobiveil_pcie *pcie)
>                                    type, resource_size(win->res));
>         }
>
> +       /* fixup for PCIe class register */
> +       value = csr_readl(pcie, PAB_INTP_AXI_PIO_CLASS);
> +       value &= 0xff;
> +       value |= (PCI_CLASS_BRIDGE_PCI << 16);
> +       csr_writel(pcie, value, PAB_INTP_AXI_PIO_CLASS);
> +
>         /* setup MSI hardware registers */
>         mobiveil_pcie_enable_msi(pcie);
>
> @@ -896,9 +902,6 @@ static int mobiveil_pcie_probe(struct platform_device *pdev)
>                 goto error;
>         }
>
> -       /* fixup for PCIe class register */
> -       csr_writel(pcie, 0x060402ab, PAB_INTP_AXI_PIO_CLASS);
> -
>         /* initialize the IRQ domains */
>         ret = mobiveil_pcie_init_irq_domain(pcie);
>         if (ret) {
> --
> 2.17.1
>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
