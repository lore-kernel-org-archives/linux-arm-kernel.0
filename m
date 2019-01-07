Return-Path: <SRS0=txfi=PP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7A12C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 14:36:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A49A92173C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 14:36:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="uA1xcNnE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A49A92173C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sntech.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=JIJO44kewRux5XiVOu5cGRuHv1yk8z5OsVRYFmO9hkk=; b=uA1xcNnE6BvWQp
	IaJ5nQyo1R5iRkLNWqvMLWhrhio3xW/Rr6jL2WlTtLLUI+V+7UJvp8GQdpCz8L5+u52gWB9oEpddK
	7TueIEAIFMrMScd2r5RgRK8sDlDQ4xV2WqyWRETq39Bv35Eoe4aPrAeDYWfaGuly75bAXxvCTTcUi
	G41tg7rev7isR18izCTSfV/8yH+fs589iBl/5LA4NiQ3Pp8fLvrIZFb72mhPAUGMjDJZyHg0Xkh74
	S+yVkSk7VbJ/JZXc4WwuhBNB89wn1b5kBNaLbL1A65c7KpZh3Z2U1ktuLJSHXR9xMSsV9yFkH2JRS
	oIMLfUQjhH5OLaqhRfiQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ggW0l-0001lH-3p; Mon, 07 Jan 2019 14:36:15 +0000
Received: from gloria.sntech.de ([185.11.138.130])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ggW0g-0001jp-Nn; Mon, 07 Jan 2019 14:36:12 +0000
Received: from wf0848.dip.tu-dresden.de ([141.76.183.80] helo=phil.localnet)
 by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.89) (envelope-from <heiko@sntech.de>)
 id 1ggW0R-0003eu-5K; Mon, 07 Jan 2019 15:35:55 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH 00/15] PCI: endpoint: Cleanup EPC features
Date: Mon, 07 Jan 2019 15:35:54 +0100
Message-ID: <1936135.agpnLP3rXd@phil>
In-Reply-To: <20190107064148.10152-1-kishon@ti.com>
References: <20190107064148.10152-1-kishon@ti.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190107_063610_930952_45FC7926 
X-CRM114-Status: GOOD (  13.69  )
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
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
 Shawn Lin <shawn.lin@rock-chips.com>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
 Alan Douglas <adouglas@cadence.com>, Jia-Ju Bai <baijiaju1990@gmail.com>,
 Cyrille Pitchen <cyrille.pitchen@free-electrons.com>,
 Jingoo Han <jingoohan1@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>,
 linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Am Montag, 7. Januar 2019, 07:41:33 CET schrieb Kishon Vijay Abraham I:
> Hi Lorenzo,
> 
> The Endpoint controller driver uses features member in 'struct pci_epc'
> to advertise the list of supported features to the endpoint function
> driver.
> 
> There are a few shortcomings with this approach.
>   *) Certain endpoint controllers support fixed size BAR (e.g. TI's
>      AM654 uses Designware configuration with fixed size BAR). The
>      size of each BARs cannot be passed to the endpoint function
>      driver.
>   *) Too many macros for handling EPC features.
>      (EPC_FEATURE_NO_LINKUP_NOTIFIER, EPC_FEATURE_BAR_MASK,
>       EPC_FEATURE_MSIX_AVAILABLE, EPC_FEATURE_SET_BAR,
>       EPC_FEATURE_GET_BAR)
>   *) Endpoint controllers are directly modifying struct pci_epc
>      members. (I have plans to move struct pci_epc to
>      drivers/pci/endpoint so that pci_epc members are referenced
>      only by endpoint core).
> 
> To overcome the above shortcomings, introduced pci_epc_get_features()
> API, pci_epc_features structure and a ->get_features() callback.
> 
> Also added a patch to set BAR flags in pci_epf_alloc_space and
> remove it from pci-epf-test function driver.
> 
> Tested on TI's DRA7xx platform.

While I don't have that much PCI experience and hence cannot judge
this cleanup as a whole, I can at least say, that my Rockchip rk3399
still does find its PCIE-connected wifi card, so this series on rk3399

Tested-by: Heiko Stuebner <heiko@sntech.de>




_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
