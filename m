Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76356C282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 14:09:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 472D6218AC
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 14:09:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bQfyrinr";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="E4itVRdw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 472D6218AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=F8WnHrpHT7jpMzUUsirlGXGmYpk/J70g7piZNOJY9nk=; b=bQfyrinr+WRk5T
	RQIQaxj39GirqRGA6NxJuZVLhnEhasDzEht3f4q73otsUvkix6hNLOFSNl9sIiamaDZEfdSkARIyX
	0UBCNhXZ2C1AVWQAOOaBz2bQ3+MEeHxDGV2FC42QfC3WkkarR/w5N5nzYHjsFeBwhIOvp56gPdhp1
	7bEZffkzOPBjSBclF7N+OPyVwrZNLTdq4NtUGNiVQcz+1aTbzKnk5ydDmpJ+NqnNoORNgjd61LMFj
	x/K4D7sB53JKRg/qROiDoeZIq6EmNdQHjSHZ0Z3v2DGEXWYY6jzmZIrUd416GlIP7BW7zCjtGoqS1
	3Ou0szwJSqw2Jy7D9kWg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goqYZ-0007LG-G1; Wed, 30 Jan 2019 14:09:35 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goqYW-0007Kv-Th
 for linux-arm-kernel@lists.infradead.org; Wed, 30 Jan 2019 14:09:34 +0000
Received: from localhost (unknown [69.71.4.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id EF0CE218A4;
 Wed, 30 Jan 2019 14:09:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1548857372;
 bh=0Km+iSKyaMuzF9hZrxprPh3mJUVRfgED3Q3IXmmmmNQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=E4itVRdwP9Q0okhcv+1BDS+Xuy4KlQsSlP+XSQpv6tJK3e7p6ADTEaqw/vyWK5pd9
 bdKnW6x+MWBmcc5DwVwoxfHI6GjxIRfB3WX5iaOlMbFg1p2eNoeoZqoaten+S59ucR
 Wd9iw9RZQcAJlt752qv2/jDXaZKUfVf1NFKPeuU0=
Date: Wed, 30 Jan 2019 08:09:29 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Aleksey Makarov <aleksey.makarov@cavium.com>
Subject: Re: [PATCH net-next v6 1/2] net: add support for Cavium PTP
 coprocessor
Message-ID: <20190130140929.GA227269@google.com>
References: <20180115124500.14872-1-aleksey.makarov@cavium.com>
 <20180115124500.14872-2-aleksey.makarov@cavium.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180115124500.14872-2-aleksey.makarov@cavium.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_060932_975691_32417469 
X-CRM114-Status: GOOD (  18.70  )
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
Cc: Robert Richter <rric@kernel.org>, "Goutham,
 Sunil" <Sunil.Goutham@cavium.com>, netdev@vger.kernel.org,
 Richard Cochran <richardcochran@gmail.com>,
 Radoslaw Biernacki <rad@semihalf.com>, linux-kernel@vger.kernel.org,
 David Daney <ddaney@caviumnetworks.com>,
 Philippe Ombredanne <pombredanne@nexb.com>, Joe Perches <joe@perches.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Jan 15, 2018 at 06:44:56PM +0600, Aleksey Makarov wrote:
> From: Radoslaw Biernacki <rad@semihalf.com>
> 
> This patch adds support for the Precision Time Protocol
> Clocks and Timestamping hardware found on Cavium ThunderX
> processors.
> 
> Signed-off-by: Radoslaw Biernacki <rad@semihalf.com>
> Signed-off-by: Aleksey Makarov <aleksey.makarov@cavium.com>
> Acked-by: Philippe Ombredanne <pombredanne@nexb.com>
> ---
>  drivers/net/ethernet/cavium/Kconfig             |  12 +
>  drivers/net/ethernet/cavium/Makefile            |   1 +
>  drivers/net/ethernet/cavium/common/Makefile     |   1 +
>  drivers/net/ethernet/cavium/common/cavium_ptp.c | 353 ++++++++++++++++++++++++
>  drivers/net/ethernet/cavium/common/cavium_ptp.h |  70 +++++
>  5 files changed, 437 insertions(+)
>  create mode 100644 drivers/net/ethernet/cavium/common/Makefile
>  create mode 100644 drivers/net/ethernet/cavium/common/cavium_ptp.c
>  create mode 100644 drivers/net/ethernet/cavium/common/cavium_ptp.h
> 
> diff --git a/drivers/net/ethernet/cavium/Kconfig b/drivers/net/ethernet/cavium/Kconfig
> index 63be75eb34d2..96586c0b4490 100644
> --- a/drivers/net/ethernet/cavium/Kconfig
> +++ b/drivers/net/ethernet/cavium/Kconfig
> @@ -50,6 +50,18 @@ config	THUNDER_NIC_RGX
>  	  This driver supports configuring XCV block of RGX interface
>  	  present on CN81XX chip.
>  
> +config CAVIUM_PTP
> +	tristate "Cavium PTP coprocessor as PTP clock"
> +	depends on 64BIT
> +	imply PTP_1588_CLOCK
> +	default y

Why is this "default y"?

It looks like this is a PCI driver and probably should be loaded only
when the PCI device is present.

> +	---help---
> +	  This driver adds support for the Precision Time Protocol Clocks and
> +	  Timestamping coprocessor (PTP) found on Cavium processors.
> +	  PTP provides timestamping mechanism that is suitable for use in IEEE 1588
> +	  Precision Time Protocol or other purposes.  Timestamps can be used in
> +	  BGX, TNS, GTI, and NIC blocks.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
