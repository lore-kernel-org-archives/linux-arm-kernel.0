Return-Path: <SRS0=FFYW=O2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D94EC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 11:11:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B9FD206A2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 11:11:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nMJZyutW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B9FD206A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=4XmLw0STXqTfdJDtWVwO4K5LG9FSPB7AF9MTzAK7bls=; b=nMJZyutWeqbFiG
	h1saadBslAo0fj9Ej2Q8UzJNHCmmy3XQWyZ20y35ABOPRl20YFIoZjaF1W9Qfw3nVFKp8AHtfnkUi
	YZ6ybBg8e33cDLGKSlTfjwcfs00fqkfCuJfbmzMaGerTfk3VWMIRdwFi4Im/06JKLjNXX0klVE72U
	anYSoy/sRhWMdY90Dbj3/TrEKXZGW6olxBCtQGjoVqiwbi83uqS9XUht0GbUZArmqiZ8qVOeQsCMS
	FZkpmepywdE4FxS0tPK2raoFPO3CkgxZd2hlo6eYQYSFk7YS4YrXDQP9bAG9AmifWpJgZ5GSrB8KE
	HhWOBdI2Pp4hWrCKRrxg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gYqoS-0007KY-RG; Mon, 17 Dec 2018 11:11:52 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gYqoP-0007Jl-U0
 for linux-arm-kernel@lists.infradead.org; Mon, 17 Dec 2018 11:11:51 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B7A2CEBD;
 Mon, 17 Dec 2018 03:11:38 -0800 (PST)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.cambridge.arm.com
 [10.1.197.40])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 158723F6A8;
 Mon, 17 Dec 2018 03:11:35 -0800 (PST)
Date: Mon, 17 Dec 2018 11:11:33 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH v2 0/3] PCIE support for i.MX8MQ
Message-ID: <20181217111133.GB14261@e107981-ln.cambridge.arm.com>
References: <20181206073545.10967-1-andrew.smirnov@gmail.com>
 <20181206121550.GA2725@e107981-ln.cambridge.arm.com>
 <20181214203828.GD20725@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181214203828.GD20725@google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181217_031149_975142_CF4635E7 
X-CRM114-Status: GOOD (  21.89  )
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
Cc: "A.s. Dong" <aisheng.dong@nxp.com>, Mark Rutland <mark.rutland@arm.com>,
 Trent Piepho <tpiepho@impinj.com>, Richard Zhu <hongxing.zhu@nxp.com>,
 Rob Herring <robh@kernel.org>, Andrey Smirnov <andrew.smirnov@gmail.com>,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-imx@nxp.com,
 Fabio Estevam <fabio.estevam@nxp.com>,
 Leonard Crestez <leonard.crestez@nxp.com>, cphealy@gmail.com,
 linux-arm-kernel@lists.infradead.org, l.stach@pengutronix.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Dec 14, 2018 at 02:38:29PM -0600, Bjorn Helgaas wrote:
> [+cc Trent]
> 
> On Thu, Dec 06, 2018 at 12:15:50PM +0000, Lorenzo Pieralisi wrote:
> > On Wed, Dec 05, 2018 at 11:35:42PM -0800, Andrey Smirnov wrote:
> > > Everyone:
> > > 
> > > This series contains changes I made in order to enable support of PCIE
> > > IP block on i.MX8MQ SoCs (full tree can be found at [github-v2]).
> > > 
> > > NOTE: The last patch have a Kconfig symbol depenency on [imx8mq-kconfig].
> > > 
> > > Changes since [v1]:
> > > 
> > >  - Driver changed to use single "fsl,controller-id" property to
> > >    distinguish between two intances of PCIE IP block
> > > 
> > >  - All code pertaining to L1SS was dropped to simplify the patch
> > > 
> > >  - Documented additions to DT bindings
> > > 
> > > Feedback is welcome!
> > > 
> > > Thanks,
> > > Andrey Smirnov
> > 
> > Andrey,
> > 
> > I have applied the patches, ...
> 
> When I merged your pci/dwc branch, I noticed what looks like a merge
> conflict between these commits:
> 
>   d123765b58ee ("PCI: dwc: Adjust Kconfig to allow IMX6 PCIe host on IMX7")
>   1a059d994189 ("PCI: imx: Add support for i.MX8MQ")
> 
> d123765b58ee added SOC_IMX7D:
> 
>   -       depends on SOC_IMX6Q || (ARM && COMPILE_TEST)
>   +       depends on SOC_IMX6Q || SOC_IMX7D || (ARM && COMPILE_TEST)
> 
> and 1a059d994189 added SOC_IMX8MQ but dropped SOC_IMX7D again, which looks
> like a mistake:
> 
>   -       depends on SOC_IMX6Q || SOC_IMX7D || (ARM && COMPILE_TEST)
>   +       depends on SOC_IMX8MQ || SOC_IMX6Q || (ARM && COMPILE_TEST)
> 
> So my "next" branch[1] (current head 7053eeb009e0) is:
> 
>   config PCI_IMX6
>         bool "Freescale i.MX6/7 PCIe controller"
>         depends on SOC_IMX8MQ || SOC_IMX6Q || (ARM && COMPILE_TEST)
>         depends on PCI_MSI_IRQ_DOMAIN
>         select PCIE_DW_HOST
> 
> which I think is wrong.  Lorenzo, if you update your pci/dwc branch,
> I'll rebuild my "next" branch.

Sorry about that, I missed it.

I dropped Andrey's patches from pci/dwc waiting for him/Lucas to agree
on a way forward.

Thanks,
Lorenzo

> If you want to tweak the switch statements and/or IMX8 checks, you
> could do that at the same time.
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git/log/?h=next

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
