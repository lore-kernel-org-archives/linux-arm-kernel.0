Return-Path: <SRS0=e5Gl=O3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A68ABC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 22:47:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73B4721841
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 22:47:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="q+EwUMc+";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Awod3BNW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73B4721841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=F7pOCSnrD+GWjDjy8CIUQTD82zNlxThimNytHY2hQDs=; b=q+EwUMc+WFTIMR
	mKvTBc2Wb2MyDJa5oQmy1zuWE+DgYKA/O9ctW6KOjYhCXEw9kcAOrYUEo5P9W6bEq99+nA5/51L71
	lbHQ/36gns77XckDQFClDOSykoI1KCZM2z3Z/4BYc0BCJ/JjoKeYkpvEyKn72FWbTcTLfJ/fsI32x
	ub7yoCnM+/iCOLZqiuxwU915LoZa+rAsmF+AQjwVh/1xLKhJSjCMshgfZzgK/SaEKfbz8Y3rhWdSU
	bg4d8tjdaTfjrnDyf/XUdpt1LXLaavFEY4XFz3sITsGrshWFJQLE/zeGqt30PwJg+7VK9xo/u9zuj
	zcpOclIP9a8Jj9BFH3lw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZO97-0000bZ-BA; Tue, 18 Dec 2018 22:47:25 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZO93-0000ZH-5X; Tue, 18 Dec 2018 22:47:22 +0000
Received: from localhost (unknown [69.71.4.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 1894221871;
 Tue, 18 Dec 2018 22:47:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1545173230;
 bh=cnK5XvLVRJ49GBJdmk7hCbJ8Up1l19H1A9AWUVBiAus=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Awod3BNW073KN9DVtn3VhAkdFK+WH3vOTctETw/JfwkJwGZHl0RHyuR0Cjuo2tE/6
 1YBGfxDYGlVweug7AQGTYUl1MoAt97mRz+zaLmo7f3+yhhAy60hDXY/oaGpAy6xvUm
 EA1QJ8u+HjHA73K6yjpWDIepyjDKVHOhM9GaRpSI=
Date: Tue, 18 Dec 2018 16:47:08 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Hanjie Lin <hanjie.lin@amlogic.com>
Subject: Re: [PATCH v8 2/2] PCI: amlogic: Add the Amlogic Meson PCIe
 controller driver
Message-ID: <20181218224708.GB22610@google.com>
References: <1545120286-129258-1-git-send-email-hanjie.lin@amlogic.com>
 <1545120286-129258-3-git-send-email-hanjie.lin@amlogic.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1545120286-129258-3-git-send-email-hanjie.lin@amlogic.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181218_144721_243869_5A750F94 
X-CRM114-Status: GOOD (  15.72  )
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
Cc: Yixun Lan <yixun.lan@amlogic.com>, Rob Herring <robh@kernel.org>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Jianxin Pan <jianxin.pan@amlogic.com>, Kevin Hilman <khilman@baylibre.com>,
 Shawn Lin <shawn.lin@rock-chips.com>,
 Philippe Ombredanne <pombredanne@nexb.com>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, Yue Wang <yue.wang@amlogic.com>,
 Qiufang Dai <qiufang.dai@amlogic.com>, Jian Hu <jian.hu@amlogic.com>,
 Liang Yang <liang.yang@amlogic.com>,
 Cyrille Pitchen <cyrille.pitchen@free-electrons.com>,
 Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
 Carlo Caione <carlo@caione.org>, linux-amlogic@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, Jerome Brunet <jbrunet@baylibre.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Dec 18, 2018 at 04:04:46PM +0800, Hanjie Lin wrote:
> From: Yue Wang <yue.wang@amlogic.com>
> 
> The Amlogic Meson PCIe host controller is based on the Synopsys DesignWare
> PCI core. This patch adds the driver support for Meson PCIe controller.

I don't have any comments on the code itself; just the trivial things
below.  No need to repost for these unless you're changing something
else.

I thought it looked very pretty overall, thanks for paying attention
to that!

> +static int meson_size_to_payload(struct meson_pcie *mp, int size)
> +{
> +	struct device *dev = mp->pci.dev;
> +
> +	/*
> +	 * dwc supports 2^(val+7) payload size, which val is 0~5 default to 1.
> +	 * So if input size is not 2^order alignment or less than 2^7 or bigger
> +	 * than 2^12, just set to default size 2^(1+7).
> +	 */
> +	if (!is_power_of_2(size) || size < 128 || size > 4096) {
> +		dev_warn(dev, "playload size %d, set to default 256\n", size);

s/playload/payload/

> +static void meson_set_max_payload(struct meson_pcie *mp, int size)
> +{
> +	u32 val = 0;

Unnecessary initialization.

> +	int max_payload_size = meson_size_to_payload(mp, size);
> +
> +	val = meson_elb_readl(mp, PCIE_DEV_CTRL_DEV_STUS);

> +static int meson_pcie_rd_own_conf(struct pcie_port *pp, int where, int size,
> +				  u32 *val)
> +{
> +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> +	int ret;
> +
> +	ret = dw_pcie_read(pci->dbi_base + where, size, val);
> +	if (ret != PCIBIOS_SUCCESSFUL)
> +		return ret;
> +
> +	/*
> +	 * There is a bug in the MESON AXG pcie controller whereby software
> +	 * cannot programme the PCI_CLASS_DEVICE register, so we must fabricate
> +	 * the return value in the config accessors.

s/pcie/PCIe/
s/programme/program/ (IIUC, "programme" is British and only used as a
noun, where here you need a verb)

> +static int meson_pcie_link_up(struct dw_pcie *pci)
> +{
> +	struct meson_pcie *mp = to_meson_pcie(pci);
> +	struct device *dev = pci->dev;
> +	u32 smlh_up = 0;
> +	u32 ltssm_up = 0;
> +	u32 rdlh_up = 0;

Unnecessary initialization of smlh_up, ltssm_up, and rdlh_up.

> +	u32 speed_okay = 0;
> +	u32 cnt = 0;
> +	u32 state12, state17;
> +
> +	do {
> +		state12 = meson_cfg_readl(mp, PCIE_CFG_STATUS12);
> +		state17 = meson_cfg_readl(mp, PCIE_CFG_STATUS17);
> +		smlh_up = IS_SMLH_LINK_UP(state12);
> +		rdlh_up = IS_RDLH_LINK_UP(state12);
> +		ltssm_up = IS_LTSSM_UP(state12);

> +	dev_err(dev, "Error: Wait linkup timeout.\n");

Message doesn't match others from driver (capitalization and trailing
period).

> +			dev_err(dev, "failed to get msi irq\n");

s/msi irq/MSI IRQ/

> +	ret = meson_add_pcie_port(mp, pdev);
> +	if (ret < 0) {
> +		dev_err(dev, "Add PCIE port failed, %d\n", ret);

s/PCIE/PCIe/

All the messages in this function are capitalized differently than
other messages in the driver.

Bjorn

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
