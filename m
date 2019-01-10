Return-Path: <SRS0=vaNk=PS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5B00C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 12:11:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95EE3214C6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 12:11:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WH1Bp5w7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95EE3214C6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sntech.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=leVS7mvv9JyDGsGk3mb2OhlPu8D9AkQ6yVVzOJPe4aA=; b=WH1Bp5w7+bXr6Z
	dDUSi2e1ylB2qDluXgWqDIjNiclNRlHg5Iko6GLuzjgO9CmKIytFCfW7+QZml+OB7JfZX/lQESJg7
	tToCsY8JMDkb5pkL/pbp/TbBsffmTSTwjAfKy9cDjJhk+lBr8egosZt2kr/7vbkcATA1DvzcbzD0m
	MayFEGqhImGjV2UKN+dK479fMcBTEy4CJb9oZD2NLFc+O/3tTJ/dI47PwLatlI6gsg/ofMKhZbNwW
	HfNb24SR1vxPy63PcyDY370wURhTdJJqHZXuSziHx0G87f6weE5FKuTCsNF4nSIv1AEqSIsdD19JP
	MHmjJknJ1Wm8lhdWJWlA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghZAp-0006oP-KY; Thu, 10 Jan 2019 12:10:59 +0000
Received: from gloria.sntech.de ([185.11.138.130])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghZAk-0006n0-F1; Thu, 10 Jan 2019 12:10:57 +0000
Received: from wf0848.dip.tu-dresden.de ([141.76.183.80] helo=phil.localnet)
 by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.89) (envelope-from <heiko@sntech.de>)
 id 1ghZAW-0002x4-0E; Thu, 10 Jan 2019 13:10:40 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: Kishon Vijay Abraham I <kishon@ti.com>,
 Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [PATCH 00/15] PCI: endpoint: Cleanup EPC features
Date: Thu, 10 Jan 2019 13:10:39 +0100
Message-ID: <17209565.32fjuqOkZh@phil>
In-Reply-To: <ce1e4bab-5c7c-5593-d28f-2187a04baef6@ti.com>
References: <20190107064148.10152-1-kishon@ti.com> <1936135.agpnLP3rXd@phil>
 <ce1e4bab-5c7c-5593-d28f-2187a04baef6@ti.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190110_041054_646305_781CDBB0 
X-CRM114-Status: GOOD (  19.59  )
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
 Gustavo Pimentel <gustavo.pimentel@synopsys.com>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
 Alan Douglas <adouglas@cadence.com>, Jia-Ju Bai <baijiaju1990@gmail.com>,
 Cyrille Pitchen <cyrille.pitchen@free-electrons.com>,
 Jingoo Han <jingoohan1@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>,
 linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Am Donnerstag, 10. Januar 2019, 06:05:00 CET schrieb Kishon Vijay Abraham I:
> Hi Heiko,
> 
> On 07/01/19 8:05 PM, Heiko Stuebner wrote:
> > Am Montag, 7. Januar 2019, 07:41:33 CET schrieb Kishon Vijay Abraham I:
> >> Hi Lorenzo,
> >>
> >> The Endpoint controller driver uses features member in 'struct pci_epc'
> >> to advertise the list of supported features to the endpoint function
> >> driver.
> >>
> >> There are a few shortcomings with this approach.
> >>   *) Certain endpoint controllers support fixed size BAR (e.g. TI's
> >>      AM654 uses Designware configuration with fixed size BAR). The
> >>      size of each BARs cannot be passed to the endpoint function
> >>      driver.
> >>   *) Too many macros for handling EPC features.
> >>      (EPC_FEATURE_NO_LINKUP_NOTIFIER, EPC_FEATURE_BAR_MASK,
> >>       EPC_FEATURE_MSIX_AVAILABLE, EPC_FEATURE_SET_BAR,
> >>       EPC_FEATURE_GET_BAR)
> >>   *) Endpoint controllers are directly modifying struct pci_epc
> >>      members. (I have plans to move struct pci_epc to
> >>      drivers/pci/endpoint so that pci_epc members are referenced
> >>      only by endpoint core).
> >>
> >> To overcome the above shortcomings, introduced pci_epc_get_features()
> >> API, pci_epc_features structure and a ->get_features() callback.
> >>
> >> Also added a patch to set BAR flags in pci_epf_alloc_space and
> >> remove it from pci-epf-test function driver.
> >>
> >> Tested on TI's DRA7xx platform.
> > 
> > While I don't have that much PCI experience and hence cannot judge
> > this cleanup as a whole, I can at least say, that my Rockchip rk3399
> > still does find its PCIE-connected wifi card, so this series on rk3399
> > 
> > Tested-by: Heiko Stuebner <heiko@sntech.de>
> 
> Thank you for testing this series with PCIe controller configured in RC mode.
> It would be great if it could be tested with EP mode too.
> 
> Thanks for the help.

Sadly I don't have hardware for that, but the support was done by Shawn,
maybe he can help with testing EP mode and will hopefully see this mail
and give it a spin.

Heiko



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
