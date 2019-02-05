Return-Path: <SRS0=y9BX=QM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AF33C282CC
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 05:50:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48E372146F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 05:50:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dnEbUnhP";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mobiveil.co.in header.i=@mobiveil.co.in header.b="E+UDUSp/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48E372146F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mobiveil.co.in
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=iSWEwrEAvBXDr6jzVTgUIcgSRekrXWAw+qQ6dAQE1s8=; b=dnEbUnhPalnJJM
	rfeXR66a0TSR3vbE8z5ubSAC4bRyf05S2+QKsyIWlYWeF5lyEWDAeRgA4v5x5JT371rkdYoxOjeqU
	DvcrBwrI7Q1JM0fdhHSzLqdE5smdJYqCoXTCCm8Os4d74bkgHyG59djtWFiZcS+X3m32XuwVfqUf+
	W+rrCkcFA+CgC/7MgZGkF+c9ei0Am9BLAluCjG1fN4QDKwI5CvH0ft4chJkgY1Hha2mGWTSIK79xG
	cOjAmYsIb2B2IMFzJoFofE4YsHg+wNONm1Vt5mZH362EeF/FIP/VlBR224mbCZsRP1dKInHDTpzWA
	TehrkKcsINKRZGgfJ9ng==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqtdC-0002bJ-GG; Tue, 05 Feb 2019 05:50:50 +0000
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqtd8-0002SC-Ku
 for linux-arm-kernel@lists.infradead.org; Tue, 05 Feb 2019 05:50:48 +0000
Received: by mail-wr1-x444.google.com with SMTP id p4so2246132wrt.7
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 04 Feb 2019 21:50:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mobiveil.co.in; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=DGP7CYkwt8gajGxukPC10TzFSfh8YkD3ft+233LUnPc=;
 b=E+UDUSp/GyYiWB43ftq1KJ9tO71GKLpyU+hJeJ3PcAFENA0vlGACg92Eb8fAZTbKx8
 cQnTD+MUm6PGEWDUOIPsK0hojZqxaecuK3/N7LjjbkcNPfOYzlP7NJfkzzYQka/3h8rv
 Hwid220rMqd32SgWUa9Zu1JZWqHyAwieojzx4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=DGP7CYkwt8gajGxukPC10TzFSfh8YkD3ft+233LUnPc=;
 b=Pt2vCeZUizl1hNtyeosUtgALUL+53v/GrIcz/LvaboGktVRdufwRJDarjU4IFf1fe5
 UU80qN+WwdJQfYV7xRMWbg5RA2lyd3bOap3sG39seV8vHSI+t9pMV7bGKVtrEM6lEt43
 XB0JR0b0MYoNj8CsaB92Br/MfX2hFtzgLw+CfeXJs8XyxcHvfIQtwsit27X+AGlJNuAK
 9yZ0s0WWEZgkrgDgDfLJ3sgNmuq1nXO5UmiBETmcQ5MScNkEljFQxikAV/ftJ09fRGTY
 AmvpTu0gBZDN+57BRDKYciaqfqkViIbud5Hqv5PW7C9i34dD1RrJROzAS4/DK+Oln311
 MisQ==
X-Gm-Message-State: AHQUAuZtU4tDq3msua7Lh2D04e6ROcX7PFEbdF7b+DLWMWRiscprkqHx
 2uuKPf8tyk7hQOx0g2g869doi0G2ccPvV3xuGmFlNw==
X-Google-Smtp-Source: AHgI3IZ9lcUK/himpXBmGtHLRnUU/pMEVpRnfCRfaNkF03EF1nUqC0gZHNkj/MWPyz652Z64RDZuDcZgK0CxF48E1hM=
X-Received: by 2002:a5d:4250:: with SMTP id s16mr2087442wrr.253.1549345843781; 
 Mon, 04 Feb 2019 21:50:43 -0800 (PST)
MIME-Version: 1.0
References: <20190129080926.36773-1-Zhiqiang.Hou@nxp.com>
 <20190129080926.36773-4-Zhiqiang.Hou@nxp.com>
In-Reply-To: <20190129080926.36773-4-Zhiqiang.Hou@nxp.com>
From: Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
Date: Tue, 5 Feb 2019 11:23:17 +0530
Message-ID: <CAFZiPx0wjqHFbu_b9cphSfsbBSU9W6Nupn6QS6R9MgmO_S0Vnw@mail.gmail.com>
Subject: Re: [PATCHv3 03/27] PCI: mobiveil: correct the returned error number
To: "Z.q. Hou" <zhiqiang.hou@nxp.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190204_215046_683143_368A78D5 
X-CRM114-Status: GOOD (  17.01  )
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

On Tue, Jan 29, 2019 at 1:38 PM Z.q. Hou <zhiqiang.hou@nxp.com> wrote:
>
> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
>
> This patch corrected the returned error number by convention,
> and removed a unnecessary error check.
>
> Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> Reviewed-by: Minghuan Lian <Minghuan.Lian@nxp.com>
> ---
> V3:
>  - No change
>
>  drivers/pci/controller/pcie-mobiveil.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/pci/controller/pcie-mobiveil.c b/drivers/pci/controller/pcie-mobiveil.c
> index b87471f08a40..563210e731d3 100644
> --- a/drivers/pci/controller/pcie-mobiveil.c
> +++ b/drivers/pci/controller/pcie-mobiveil.c
> @@ -819,7 +819,7 @@ static int mobiveil_pcie_init_irq_domain(struct mobiveil_pcie *pcie)
>
>         if (!pcie->intx_domain) {
>                 dev_err(dev, "Failed to get a INTx IRQ domain\n");
> -               return -ENODEV;
> +               return -ENOMEM;
>         }
>
>         raw_spin_lock_init(&pcie->intx_mask_lock);
> @@ -845,11 +845,9 @@ static int mobiveil_pcie_probe(struct platform_device *pdev)
>         /* allocate the PCIe port */
>         bridge = devm_pci_alloc_host_bridge(dev, sizeof(*pcie));
>         if (!bridge)
> -               return -ENODEV;
> +               return -ENOMEM;
>
>         pcie = pci_host_bridge_priv(bridge);
> -       if (!pcie)
> -               return -ENOMEM;
>
>         pcie->pdev = pdev;
>
> @@ -866,7 +864,7 @@ static int mobiveil_pcie_probe(struct platform_device *pdev)
>                                                     &pcie->resources, &iobase);
>         if (ret) {
>                 dev_err(dev, "Getting bridge resources failed\n");
> -               return -ENOMEM;
> +               return ret;
>         }
>
>         /*
> --
> 2.17.1
>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
