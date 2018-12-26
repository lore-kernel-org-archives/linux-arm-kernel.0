Return-Path: <SRS0=N/t3=PD=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34989C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 15:31:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06B09214C6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 15:31:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="aaUdJUiH";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="dscSSnUP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06B09214C6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=YATRHyONSCQNDnhhoLDQr5MpOBlVwACMKpQJHWj8cuU=; b=aaUdJUiHogbuxo
	Xtw7wmBPu6Py0YVA9P+BbTYt84QspHn/j3P4LuCcMtvoKJ2MBk08zYGukO8odqHzdS6Pu7tF6IskC
	mAKOUzBGbXdPcyCFNq31zzz+QcjEVgTsNPBHbVAkohuEz0N95p/d9pdml8AQQlQ9c1Ax+0iZ0nihd
	NjkYiYGza5Ia9WWIq5+oA2V0Ij+TFr+hz0pPO+slptRccmWXN2giKx7BRWwcl4TPJ97umXHxsDBbJ
	ExSlxu3/e+zhz/l57SNMOo8mBmuDD8Ld2KyhibFr2bzToA8Vl4xWGWrSRyM7kXfGpFm1spcufKT/2
	3Ko/fkL6p/pSTj2M2Kmg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gcB9Q-0004g1-RP; Wed, 26 Dec 2018 15:31:16 +0000
Received: from smtprelay.synopsys.com ([198.182.47.9])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gcB9N-0004fP-09
 for linux-arm-kernel@lists.infradead.org; Wed, 26 Dec 2018 15:31:14 +0000
Received: from mailhost.synopsys.com (mailhost1.synopsys.com [10.12.238.239])
 by smtprelay.synopsys.com (Postfix) with ESMTP id 153FB24E25B5;
 Wed, 26 Dec 2018 07:31:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
 t=1545838262; bh=Te//KRYuxaqva0xlJVkZ+PV9LWlrJf8OLOsnwHq3sO8=;
 h=Subject:To:CC:References:From:Date:In-Reply-To:From;
 b=dscSSnUPhoDAP92rIMGL5ig/0glyo7OgdwBJbNiQH704pUhmpBe+u6pK67BQyQ8cL
 7gxF718YxtdTl97fTsR7uMMarX9UOm3wxS3cBqeqewyDkMOv06gw5z+kfB2a7N0F4E
 Um98ZH8rkwT45t+prDGgnPwTl7QlXlr3rXGD0Go0Ku+l78DoCCQ5b2drktMnR6jgcT
 imOupR+yFm0UjbSgMhgGgOOhKi2H7OUhVFwToWxlJPJmQMZ+KvqhnyY20iIGKesq9z
 M1vyL9feYcj4jvc7EN3LPRw6eHqHYmhEF7034ktkTQPbSy6/cyU4BuMu+zEhXD0fQU
 d2oRoUHawhemg==
Received: from US01WXQAHTC1.internal.synopsys.com
 (us01wxqahtc1.internal.synopsys.com [10.12.238.230])
 by mailhost.synopsys.com (Postfix) with ESMTP id E44525F8E;
 Wed, 26 Dec 2018 07:31:01 -0800 (PST)
Received: from DE02WEHTCB.internal.synopsys.com (10.225.19.94) by
 US01WXQAHTC1.internal.synopsys.com (10.12.238.230) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 26 Dec 2018 07:31:01 -0800
Received: from DE02WEHTCA.internal.synopsys.com (10.225.19.92) by
 DE02WEHTCB.internal.synopsys.com (10.225.19.94) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 26 Dec 2018 16:30:59 +0100
Received: from [10.225.2.19] (10.225.2.19) by DE02WEHTCA.internal.synopsys.com
 (10.225.19.80) with Microsoft SMTP Server (TLS) id 14.3.408.0;
 Wed, 26 Dec 2018 16:30:59 +0100
Subject: Re: [PATCH 00/21] i.MX6, DesignWare PCI improvements
To: Andrey Smirnov <andrew.smirnov@gmail.com>, "linux-pci@vger.kernel.org"
 <linux-pci@vger.kernel.org>
References: <20181221072716.29017-1-andrew.smirnov@gmail.com>
From: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Message-ID: <3b3a232c-4991-cdb4-59f3-29fba93dfefc@synopsys.com>
Date: Wed, 26 Dec 2018 15:26:29 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <20181221072716.29017-1-andrew.smirnov@gmail.com>
Content-Language: en-US
X-Originating-IP: [10.225.2.19]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181226_073113_050137_3960B97B 
X-CRM114-Status: GOOD (  14.74  )
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
Cc: "A.s. Dong" <aisheng.dong@nxp.com>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Richard Zhu <hongxing.zhu@nxp.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Fabio Estevam <fabio.estevam@nxp.com>, "linux-imx@nxp.com" <linux-imx@nxp.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Leonard Crestez <leonard.crestez@nxp.com>,
 Chris Healy <cphealy@gmail.com>, Lucas Stach <l.stach@pengutronix.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi,

On 21/12/2018 07:26, Andrey Smirnov wrote:
> Everyone:
> 
> This is the series containing various small improvements that I made
> while reading the code and researching commit history of pci-imx6.c
> and pcie-designware*.c files. All changes are optional, so commits
> that don't seem like an improvement can be easily dropped. Hopefully
> each patch is self-explanatory.
> 
> I tested this series on i.MX6Q, i.MX7D and i.MX8MQ.
> 
> Feedback is welcome!
> 
> Thanks,
> Andrey Smirnov
> 
> Andrey Smirnov (21):
>   PCI: imx6: Simplify imx7d_pcie_wait_for_phy_pll_lock()
>   PCI: imx6: Remove redundant debug tracing
>   PCI: imx6: Return -ETIMEOUT from imx6_pcie_wait_for_speed_change()
>   PCI: imx6: Remove duplicate macro definitions
>   PCI: imx6: Remove PCIE_PL_PFLR_* constants
>   PCI: imx6: Remove PCIE_PHY_RX_ASIC_OUT* constants
>   PCI: designware: Make use of IS_ALIGNED()
>   PCI: designware: Share code for dw_pcie_rd/wr_other_conf()
>   PCI: imx6: Drop imx6_pcie_link_up()
>   PCI: designware: imx6: Share PHY debug register definitions
>   PCI: designware: Make use of BIT() in constant definitions
>   PCI: imx6: Make use of BIT() in constant definitions
>   PCI: imx6: Simplify bit operations in PHY functions
>   PCI: imx6: Simplify pcie_phy_poll_ack()
>   PCI: imx6: Restrict PHY register data to 16-bit
>   PCI: imx6: Pass data to dw_pcie_writel_dbi() directly
>   PCI: imx6: Use common mask in imx6_pcie_reset_phy()
>   PCI: imx6: Simplify bit operations in imx6_setup_phy_mpll()
>   PCI: imx6: Remove magic numbers from imx6_pcie_establish_link()
>   PCI: designware: Make use of GENMASK/FIELD_PREP
>   PCI: designware: Remove superfluous shifting in definitions


s/DesignWare/dwc in all patches, please.

Regards,

Gustavo

> 
>  drivers/pci/controller/dwc/pci-imx6.c         | 151 +++++++-----------
>  .../pci/controller/dwc/pcie-designware-host.c |  61 +++----
>  drivers/pci/controller/dwc/pcie-designware.c  |  18 +--
>  drivers/pci/controller/dwc/pcie-designware.h  |  60 +++----
>  4 files changed, 116 insertions(+), 174 deletions(-)
> 


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
