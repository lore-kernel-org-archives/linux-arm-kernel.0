Return-Path: <SRS0=fpAU=QP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5845C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 12:38:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8A2B2177B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 12:38:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="MCySTl2b";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mobiveil.co.in header.i=@mobiveil.co.in header.b="OVoNxJ6L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8A2B2177B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mobiveil.co.in
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Yka6w7HW8eADiwpN33wIFyFz7RGBF4Lpm2uw7HAlU4w=; b=MCySTl2b9nOYZ1
	AcRME/lrvCj8qRbGsO50/eIhGBPyWLUZk4I6FBphS4nbs2VUeZhTE0Dj/xFTUyFBHRBZnYxCBjUGv
	T6hu3vE/KetcqN//NBgz+lLcLXyXc5IB0VbS3/TvllgKcbxPP5vb8MNQCSD9pX9p0Ws3aDgE+XOd9
	ZrJZEDy0BxGGJTZF1Zm6WhiczgA1S6QamfwgsAicZflvW3JuXhXWLAKiaXsIqavS9X2DFZSvm3rsI
	jcy1F4NwsnliM8sTykyQcRQWMXfq45WqqohziAuPI6NSuBwyw7zDUqhz6urALe3W/wXxCw9miTVHx
	SdJzkXxqjmPCQ3BS5Aag==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gs5QY-0007wK-94; Fri, 08 Feb 2019 12:38:42 +0000
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gs5QU-0007vs-UI
 for linux-arm-kernel@lists.infradead.org; Fri, 08 Feb 2019 12:38:40 +0000
Received: by mail-wr1-x441.google.com with SMTP id z3so3433535wrv.3
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 08 Feb 2019 04:38:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mobiveil.co.in; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=za3n79uTXhuAg89Odl5K7zA3/4teHlFt8f/2UCul1pI=;
 b=OVoNxJ6L+4h0zmcRL0/+4rPL4qAp+s8E3C9mBgNG/yVgl7yp+6sLCgN44Re9Gu9Wik
 f5q3MpCGafDHKYYqZ/Yl9KI4QDOZQ+NY+A1WSs8brIvZ5W/8k1hH5FE+Ltz5vD5IW5Y0
 t+A80vouwIa00ZgMDXFMn6bwZrkAi9VYz/t4k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=za3n79uTXhuAg89Odl5K7zA3/4teHlFt8f/2UCul1pI=;
 b=CpEyW043oqtnp8w3ppkA5S7yGip2/uz4eINAuI1+4rUw5U3Pky96LhKgzY1NIPTV/A
 B79H+hY8Eru/EBJM+8MGfCQbjlyrabQlOBWiNVtAWCNSmoi54dHQf1qyf8huiMW8akvr
 bKla2To4KHO737kqOcj5xHos2gxz0lP1Z2F6iANULjsw7C9hhAeOJJFtB+XS2xy0ue4A
 GZ+MEUdv48i7shGEFsYHC6tLxRdomkyY+IEg9aKgqz5iN/MwwXiejXqZifUhJANOk+uV
 Kos0Uj7sGN7HgTUtL3xgc88SkTHxzy89Qvccur3EA/QYzZoEKfFCRxIvdG3lDCPIpRRk
 ww+Q==
X-Gm-Message-State: AHQUAuZDnak1ecxF7+m7W5Gkr/drE8TnjzKm3XUmy6UgRfaIgY5wS3Tk
 DWPpkqv61Pu5HFyrgy8aKnDcNr8xpOvxoYjRTcwtJA==
X-Google-Smtp-Source: AHgI3Iatp5BtTgrEbIDAPsLDPC8Il8bwT1QG2XB42RwPY79StgZWtwjcGnSo0DQr+93S2X94tfqQdYfUBTw6ZWcFbfU=
X-Received: by 2002:a5d:468e:: with SMTP id u14mr14295242wrq.253.1549629516223; 
 Fri, 08 Feb 2019 04:38:36 -0800 (PST)
MIME-Version: 1.0
References: <20190129080926.36773-1-Zhiqiang.Hou@nxp.com>
 <20190129080926.36773-18-Zhiqiang.Hou@nxp.com>
In-Reply-To: <20190129080926.36773-18-Zhiqiang.Hou@nxp.com>
From: Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
Date: Fri, 8 Feb 2019 18:11:15 +0530
Message-ID: <CAFZiPx0faPHN1mqPV28XTZfOxA2GgDPuc=RVdXEiGGNAUe=Fxw@mail.gmail.com>
Subject: Re: [PATCHv3 17/27] PCI: mobiveil: fix the checking of valid device
To: "Z.q. Hou" <zhiqiang.hou@nxp.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190208_043839_008497_D9643C8B 
X-CRM114-Status: GOOD (  17.71  )
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

On Tue, Jan 29, 2019 at 1:40 PM Z.q. Hou <zhiqiang.hou@nxp.com> wrote:
>
> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
>
> Avoid to issue CFG transactions to link partner when the PCIe
> link is not up. And allow CFG transactions to all functions of
> Endpoint implemented multiple functions.
>
> Fixes: 9af6bcb11e12 ("PCI: mobiveil: Add Mobiveil PCIe Host
> Bridge IP driver")
> Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> Reviewed-by: Minghuan Lian <Minghuan.Lian@nxp.com>
> ---
> V3:
>  - No change
>
>  drivers/pci/controller/mobiveil/pcie-mobiveil-host.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c b/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c
> index dc5324d94466..1ae82e790562 100644
> --- a/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c
> +++ b/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c
> @@ -29,6 +29,10 @@ static bool mobiveil_pcie_valid_device(struct pci_bus *bus, unsigned int devfn)
>  {
>         struct mobiveil_pcie *pcie = bus->sysdata;
>
> +       /* If there is no link, then there is no device */
> +       if (bus->number > pcie->rp.root_bus_nr && !mobiveil_pcie_link_up(pcie))
> +               return false;
> +
>         /* Only one device down on each root port */
>         if ((bus->number == pcie->rp.root_bus_nr) && (devfn > 0))
>                 return false;
> @@ -37,7 +41,7 @@ static bool mobiveil_pcie_valid_device(struct pci_bus *bus, unsigned int devfn)
>          * Do not read more than one device on the bus directly
>          * attached to RC
>          */
> -       if ((bus->primary == pcie->rp.root_bus_nr) && (devfn > 0))
> +       if ((bus->primary == pcie->rp.root_bus_nr) && (PCI_SLOT(devfn) > 0))
here change "primary" to "number", as it's a bug in the original driver too.

>                 return false;
>
>         return true;
> --
> 2.17.1
>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
