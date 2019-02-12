Return-Path: <SRS0=CPNf=QT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D7BFC282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 15:07:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E47D21773
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 15:07:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="a7Fi+ZBA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E47D21773
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=5xY5Zn3zl1+2YkhzFKd1QBXB2xu1+vTAZsOtMIibfp0=; b=a7Fi+ZBAVTLFK9
	UkyBRDSp5p2sliWrv5e/HgSPLuP0BLQ9dkPTLacKvrzR6OYYdgcHHnmj5+GFBWRu4anoNulYrpbZI
	6KU9r9PWMtrCZBRfhEOJwyJX3sXLtpWIpfukpEKXef/0EZB0MPLeMwmN4o0xoo3xun1qEr/tLlyuc
	2vigFK6928gOD8hRiCTVcz2HInigFZq7ygv8cfDqZ930x7GgNNhXcRWdLLLToDVxdyptr1XlptbY3
	fUEDnP6Dp9ofq+Do46pLB/hcOHvsB/LzHPO+Rb7F4IKWmIbVsCPsQ6uSsa42ykQcWuBkkXn5gWV+7
	dhqEIxOqYpR7QDPK2ETQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtZep-00045D-FQ; Tue, 12 Feb 2019 15:07:35 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtZej-00044B-6L; Tue, 12 Feb 2019 15:07:33 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1F6E280D;
 Tue, 12 Feb 2019 07:07:26 -0800 (PST)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.cambridge.arm.com
 [10.1.197.40])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B810B3F575;
 Tue, 12 Feb 2019 07:07:23 -0800 (PST)
Date: Tue, 12 Feb 2019 15:07:18 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH 11/15] PCI: pci-epf-test: Use pci_epc_get_features to get
 EPC features
Message-ID: <20190212150718.GA28306@e107981-ln.cambridge.arm.com>
References: <20190107064148.10152-1-kishon@ti.com>
 <20190107064148.10152-12-kishon@ti.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190107064148.10152-12-kishon@ti.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190212_070729_248474_F59284AD 
X-CRM114-Status: GOOD (  17.45  )
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
Cc: Heiko Stuebner <heiko@sntech.de>,
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

On Mon, Jan 07, 2019 at 12:11:44PM +0530, Kishon Vijay Abraham I wrote:

[...]

>  static int pci_epf_test_bind(struct pci_epf *epf)
>  {
>  	int ret;
>  	struct pci_epf_test *epf_test = epf_get_drvdata(epf);
>  	struct pci_epf_header *header = epf->header;
> +	const struct pci_epc_features *epc_features;
> +	enum pci_barno test_reg_bar = BAR_0;
>  	struct pci_epc *epc = epf->epc;
>  	struct device *dev = &epf->dev;
> +	bool linkup_notifier = false;
> +	bool msix_capable = false;
> +	bool msi_capable = true;
>  
>  	if (WARN_ON_ONCE(!epc))
>  		return -EINVAL;
>  
> -	if (epc->features & EPC_FEATURE_NO_LINKUP_NOTIFIER)
> -		epf_test->linkup_notifier = false;
> -	else
> -		epf_test->linkup_notifier = true;
> -
> -	epf_test->msix_available = epc->features & EPC_FEATURE_MSIX_AVAILABLE;
> +	epc_features = pci_epc_get_features(epc, epf->func_no);

I think it would work out better if struct pci_epc_features was
allocated in the caller (stack) and pci_epc_get_features() take a
pointer parameter to it rather than the callee and the callee would just
have to fill it out, this also removes data in the driver that is not
really useful.

Is there any other reason behind the current design choice ?

Thanks,
Lorenzo

> +	if (!epc_features) {
> +		linkup_notifier = epc_features->linkup_notifier;
> +		msix_capable = epc_features->msix_capable;
> +		msi_capable = epc_features->msi_capable;
> +		test_reg_bar = pci_epc_get_first_free_bar(epc_features);
> +		pci_epf_configure_bar(epf, epc_features);
> +	}
>  
> -	epf_test->test_reg_bar = EPC_FEATURE_GET_BAR(epc->features);
> +	epf_test->test_reg_bar = test_reg_bar;
>  
>  	ret = pci_epc_write_header(epc, epf->func_no, header);
>  	if (ret) {
> @@ -492,13 +509,15 @@ static int pci_epf_test_bind(struct pci_epf *epf)
>  	if (ret)
>  		return ret;
>  
> -	ret = pci_epc_set_msi(epc, epf->func_no, epf->msi_interrupts);
> -	if (ret) {
> -		dev_err(dev, "MSI configuration failed\n");
> -		return ret;
> +	if (msi_capable) {
> +		ret = pci_epc_set_msi(epc, epf->func_no, epf->msi_interrupts);
> +		if (ret) {
> +			dev_err(dev, "MSI configuration failed\n");
> +			return ret;
> +		}
>  	}
>  
> -	if (epf_test->msix_available) {
> +	if (msix_capable) {
>  		ret = pci_epc_set_msix(epc, epf->func_no, epf->msix_interrupts);
>  		if (ret) {
>  			dev_err(dev, "MSI-X configuration failed\n");
> @@ -506,7 +525,7 @@ static int pci_epf_test_bind(struct pci_epf *epf)
>  		}
>  	}
>  
> -	if (!epf_test->linkup_notifier)
> +	if (!linkup_notifier)
>  		queue_work(kpcitest_workqueue, &epf_test->cmd_handler.work);
>  
>  	return 0;
> @@ -523,17 +542,6 @@ static int pci_epf_test_probe(struct pci_epf *epf)
>  {
>  	struct pci_epf_test *epf_test;
>  	struct device *dev = &epf->dev;
> -	const struct pci_epf_device_id *match;
> -	struct pci_epf_test_data *data;
> -	enum pci_barno test_reg_bar = BAR_0;
> -	bool linkup_notifier = true;
> -
> -	match = pci_epf_match_device(pci_epf_test_ids, epf);
> -	data = (struct pci_epf_test_data *)match->driver_data;
> -	if (data) {
> -		test_reg_bar = data->test_reg_bar;
> -		linkup_notifier = data->linkup_notifier;
> -	}
>  
>  	epf_test = devm_kzalloc(dev, sizeof(*epf_test), GFP_KERNEL);
>  	if (!epf_test)
> @@ -541,8 +549,6 @@ static int pci_epf_test_probe(struct pci_epf *epf)
>  
>  	epf->header = &test_header;
>  	epf_test->epf = epf;
> -	epf_test->test_reg_bar = test_reg_bar;
> -	epf_test->linkup_notifier = linkup_notifier;
>  
>  	INIT_DELAYED_WORK(&epf_test->cmd_handler, pci_epf_test_cmd_handler);
>  
> -- 
> 2.17.1
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
