Return-Path: <SRS0=fpAU=QP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01B97C282CB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 12:42:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6FB8217D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 12:42:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ZBSJTVji";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mobiveil.co.in header.i=@mobiveil.co.in header.b="LTW9Gy9V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6FB8217D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mobiveil.co.in
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=i2ybBEs3jvIqSxQBtqYLw0yWYxHtPmbCSOYp9TOV2GA=; b=ZBSJTVji+IY9mp
	sYrv/D9c/dxDoWi1Yb5pIot99AXnQlIXvSd6igW7AgklBFr0+SmJ7qWn7lBpWEFlxlagdg/VkDQjn
	5LRActPKsa9Ea9ezH62cpPz5mQCSF9sZ1hkoSZ4+TSqEyNdrYIIRiZuSXhv+E4CBCFGnEk7VooZXg
	rqwEtiAYxFoxJ6FtFvtzh8bxzmUlzT9Q4qJDz4MGLFBnr/8z6aITQAIdUWbg36Qwxy3YPiL/yiOyE
	qHyoCA6+vrCqZms7BmoBV+ju5tg6qK0JXA6K6AKSnmUEJcbxoqz0IjTj8UVuVjEVV9GJFgvGa4O9I
	wneLTR/jtM+5JY1uVpaw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gs5U8-0001u1-HQ; Fri, 08 Feb 2019 12:42:24 +0000
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gs5U5-0001k6-Gf
 for linux-arm-kernel@lists.infradead.org; Fri, 08 Feb 2019 12:42:22 +0000
Received: by mail-wr1-x444.google.com with SMTP id t27so3408772wra.6
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 08 Feb 2019 04:42:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mobiveil.co.in; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=FcNSWtz/94EAq7Zt0ztZtaogVS62SwmBQ8CLMNUPaIE=;
 b=LTW9Gy9VdLkzCaQ8/6LR1RN5CMBX4DNv4zx8Vt+n9WPe5s5U2j2SkWi9d6uJPlV/zx
 q2zfeEvtPuL0+gE773N8fRvWzd+7hhAGOqytTlwdAVErVEIm+4ioBVY8sc175wb7NQiV
 F8Ywgr5UzWMCXiEm92JA1qgPgSj1rA8WtsmdE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=FcNSWtz/94EAq7Zt0ztZtaogVS62SwmBQ8CLMNUPaIE=;
 b=L/1oTojuBN1kB7djDydU5IMXx8Q4VdaZ4v5Lg79+z7+KJpO2cxNTpP5vPlGNTL2cIq
 NRyEEqx1jpuBw3SHc7GOD0wt+mfb7vObFV7EKAzc4ygDv+ASfVl7w3PBxZ2mIuHdulIN
 OaE6zOOPaJBkAvrtM4cdl5oo7COYsLtvQO+CBByaPeRYRF2CB/YyWDzHLC3SYPvTsDhz
 u3EO3o7KrqGvID2T/lpy6gABJzEHxA/HVmd8A6B4uT5h+CkJmU+wqX/B+QB+33nRngxG
 L04khNWZNcxWpHvf/6SonZDKh+l6jWCWKVBuWnLaIHIzrRbe1ag3uLqChhKSkSErPp9r
 JNlQ==
X-Gm-Message-State: AHQUAubRPH4pwOWGwTFlf/3xdMiQLSoYAhmqdEcex/Yx1o1UT6rIg3DW
 Y3CSKaaaaxrNvy3wNW6YJTGRbZqGg9xZ4TzhnxmzQg==
X-Google-Smtp-Source: AHgI3IaFmjXxGwVIVl/tppCIeLz9HYPH8Ihh1C5K04cAMhMPJi87YuzbKG67WoAepyYFp1mHlKOJKR7kpdPF70VdDj4=
X-Received: by 2002:adf:fd81:: with SMTP id d1mr16532537wrr.105.1549629737745; 
 Fri, 08 Feb 2019 04:42:17 -0800 (PST)
MIME-Version: 1.0
References: <20190129080926.36773-1-Zhiqiang.Hou@nxp.com>
 <20190129080926.36773-21-Zhiqiang.Hou@nxp.com>
In-Reply-To: <20190129080926.36773-21-Zhiqiang.Hou@nxp.com>
From: Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
Date: Fri, 8 Feb 2019 18:14:57 +0530
Message-ID: <CAFZiPx1esvy7uqAymR7oU+hXSAUwLbKgUo3dK3CoHSajsD41-A@mail.gmail.com>
Subject: Re: [PATCHv3 20/27] PCI: mobiveil: add Byte and Half-Word width
 register accessors
To: "Z.q. Hou" <zhiqiang.hou@nxp.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190208_044221_550512_10538C35 
X-CRM114-Status: GOOD (  13.82  )
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
> As there are some Byte and Half-Work width registers in PCIe
> configuration space, add Byte and Half-Word width register
> accessors.
>
> Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> Reviewed-by: Minghuan Lian <Minghuan.Lian@nxp.com>
> ---
> V3:
>  - No change
>
>  .../pci/controller/mobiveil/pcie-mobiveil.h   | 20 +++++++++++++++++++
>  1 file changed, 20 insertions(+)
>
> diff --git a/drivers/pci/controller/mobiveil/pcie-mobiveil.h b/drivers/pci/controller/mobiveil/pcie-mobiveil.h
> index 81685840b378..933c2f34bc52 100644
> --- a/drivers/pci/controller/mobiveil/pcie-mobiveil.h
> +++ b/drivers/pci/controller/mobiveil/pcie-mobiveil.h
> @@ -181,9 +181,29 @@ static inline u32 csr_readl(struct mobiveil_pcie *pcie, u32 off)
>         return csr_read(pcie, off, 0x4);
>  }
>
> +static inline u32 csr_readw(struct mobiveil_pcie *pcie, u32 off)
> +{
> +       return csr_read(pcie, off, 0x2);
> +}
> +
> +static inline u32 csr_readb(struct mobiveil_pcie *pcie, u32 off)
> +{
> +       return csr_read(pcie, off, 0x1);
> +}
> +
>  static inline void csr_writel(struct mobiveil_pcie *pcie, u32 val, u32 off)
>  {
>         csr_write(pcie, val, off, 0x4);
>  }
>
> +static inline void csr_writew(struct mobiveil_pcie *pcie, u32 val, u32 off)
> +{
> +       csr_write(pcie, val, off, 0x2);
> +}
> +
> +static inline void csr_writeb(struct mobiveil_pcie *pcie, u32 val, u32 off)
> +{
> +       csr_write(pcie, val, off, 0x1);
> +}
> +
>  #endif /* _PCIE_MOBIVEIL_H */
> --
> 2.17.1
>
Reviewed-by: Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
