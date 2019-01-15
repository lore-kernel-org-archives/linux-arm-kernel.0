Return-Path: <SRS0=3lKL=PX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89B96C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 01:52:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E7272063F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 01:52:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="XqVCti7K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E7272063F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rock-chips.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Fn9+cTi6/AO3QkkYPK3stOwGtmgO+MUUf2/E/PtdQJA=; b=XqVCti7KgoeBOZ4HRoiQcmqR+
	/jg22EsaQGjIXDw6Q3hs3B4prIzzuXtYmYP0OENLVzQ1Xb2GwMov7olMIubP7K/BbuAPiWvERxUzk
	KyFlBk1MRW+QsC2/jA8GCZfXpc76bkzSebIvP8URJuHq50D4HBXh1GiNAVN2TiIA9UH5UYKE1237v
	x5t93igOGriitrAZpxjQfQZJauNQBZ+78G7LwH38ZDf0YyvX8Pe5crtZrReg+YKJnOzqfAh6uSMjN
	NeeuNKiWy4Irqq6w1m4FK5TgglN3HXgxKyKHzUa7dfMpEWa8ajRL5Qo8pG6UTdqh6PhIXS2AxsXWP
	DKG+5ywMg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjDuO-0001cV-UU; Tue, 15 Jan 2019 01:52:52 +0000
Received: from lucky1.263xmail.com ([211.157.147.132])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjDuL-0001bz-JL; Tue, 15 Jan 2019 01:52:51 +0000
Received: from shawn.lin?rock-chips.com (unknown [192.168.167.70])
 by lucky1.263xmail.com (Postfix) with ESMTP id 6E0421198;
 Tue, 15 Jan 2019 09:52:41 +0800 (CST)
X-263anti-spam: KSV:0;
X-MAIL-GRAY: 1
X-MAIL-DELIVERY: 0
X-KSVirus-check: 0
X-ABS-CHECKED: 4
Received: from [172.16.12.37] (unknown [58.22.7.114])
 by smtp.263.net (postfix) whith ESMTP id
 P23568T140054489974528S1547517158769871_; 
 Tue, 15 Jan 2019 09:52:40 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <e1a9c467c5e308c9a57ff0dd8e477239>
X-RL-SENDER: shawn.lin@rock-chips.com
X-SENDER: lintao@rock-chips.com
X-LOGIN-NAME: shawn.lin@rock-chips.com
X-FST-TO: linux-arm-kernel@lists.infradead.org
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
Subject: Re: [PATCH v2 00/15] PCI: endpoint: Cleanup EPC features
To: Kishon Vijay Abraham I <kishon@ti.com>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
 Alan Douglas <adouglas@cadence.com>, Heiko Stuebner <heiko@sntech.de>
References: <20190114111513.21618-1-kishon@ti.com>
From: Shawn Lin <shawn.lin@rock-chips.com>
Message-ID: <29d44805-9cfb-450c-e7b3-7556dc36fc40@rock-chips.com>
Date: Tue, 15 Jan 2019 09:52:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190114111513.21618-1-kishon@ti.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190114_175249_824011_435494A9 
X-CRM114-Status: GOOD (  21.60  )
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
Cc: Jingoo Han <jingoohan1@gmail.com>, shawn.lin@rock-chips.com,
 linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
 linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
 linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


On 2019/1/14 19:14, Kishon Vijay Abraham I wrote:
> Hi Lorenzo,
> 
> The Endpoint controller driver uses features member in 'struct pci_epc'
> to advertise the list of supported features to the endpoint function
> driver.
> 
> There are a few shortcomings with this approach.
>    *) Certain endpoint controllers support fixed size BAR (e.g. TI's
>       AM654 uses Designware configuration with fixed size BAR). The
>       size of each BARs cannot be passed to the endpoint function
>       driver.
>    *) Too many macros for handling EPC features.
>       (EPC_FEATURE_NO_LINKUP_NOTIFIER, EPC_FEATURE_BAR_MASK,
>        EPC_FEATURE_MSIX_AVAILABLE, EPC_FEATURE_SET_BAR,
>        EPC_FEATURE_GET_BAR)
>    *) Endpoint controllers are directly modifying struct pci_epc
>       members. (I have plans to move struct pci_epc to
>       drivers/pci/endpoint so that pci_epc members are referenced
>       only by endpoint core).
> 
> To overcome the above shortcomings, introduced pci_epc_get_features()
> API, pci_epc_features structure and a ->get_features() callback.
> 
> Also added a patch to set BAR flags in pci_epf_alloc_space and
> remove it from pci-epf-test function driver.
> 
> Changes from v1:
> *) Fixed helper function to return '0' (or BAR_0) for any incorrect
>     values in reserved BAR.
> *) Do not set_bar or alloc space for BARs if the BARs are reserved
> *) Fix incorrect check of epc_features in pci_epf_test_bind
> 
> Tested on TI's DRA7xx platform and AM654 platform. Support for PCIe
> in AM654 platform will be posted shortly.
> 


----8<-----

>   drivers/pci/controller/pcie-rockchip-ep.c     | 16 +++-

Acked-by: Shawn Lin <shawn.lin@rock-chips.com>




_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
