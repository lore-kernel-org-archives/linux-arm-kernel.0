Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65CFFC282D9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 15:06:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 342EB20989
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 15:06:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ZKIToKgY";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="yXKB+Pgb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 342EB20989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=0AyxZasUlTZ1L6lee39A+y5aLUC7kDGjIKnw9Ss7TOs=; b=ZKIToKgYZFuVoP
	qRwECXQwHO1HOJRHfDIkjn5NDrnKo7R8akcRZlzA/rEoNQD42BH0F+KrXpBkecHZMdRt5oAB7zU1A
	RWza09LoG3QEwLq/ywvwUrUUgKrrf2FPridxRL3aR27oW3zfxnxbOreEhl8KESKgV4fxriPlbM0e/
	xw9vJ2PzJm23eZVHtg9YSrpI1ji/FdxPZ4Ie7H5ApZY4MaFGg4YK/+kruAw7l/crO8REcE0YMNkeb
	2g2nhjJLYYe/uhhhDurS8EuteJ1cDkJZIjk9vgGLnziE1eE3eEL0QeAs+6KQh2qRh6kvlvHqmOFta
	OypfPow5fz/iTmu9owVg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gorRU-0006DD-Bw; Wed, 30 Jan 2019 15:06:20 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gorRS-0006Cw-0D
 for linux-arm-kernel@lists.infradead.org; Wed, 30 Jan 2019 15:06:19 +0000
Received: from localhost (unknown [69.71.4.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 2BAA320989;
 Wed, 30 Jan 2019 15:06:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1548860777;
 bh=91akihFMRrpe92l8fZfX0HpMGtuRJLFm6w4kozyFT+o=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=yXKB+PgbsRlZT5qKMU0kzrB4s++v2Q0IV1KgiXJnwMDQ+qLZzVGgAKWtUOltYniMX
 aK8PIecB8TH5fqOUXyztBsTK3DlfLtdAZSuY4N9uogcbf6TymsFIE5o0Wqy8AKphCU
 sax+m47zvcxyoW4UlApEP/wWrnJf+JVMDMYSq5tw=
Date: Wed, 30 Jan 2019 09:06:15 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Aleksey Makarov <aleksey.makarov@cavium.com>
Subject: Re: [PATCH net-next v6 1/2] net: add support for Cavium PTP
 coprocessor
Message-ID: <20190130150614.GA229773@google.com>
References: <20180115124500.14872-1-aleksey.makarov@cavium.com>
 <20180115124500.14872-2-aleksey.makarov@cavium.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180115124500.14872-2-aleksey.makarov@cavium.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_070618_063965_8315793A 
X-CRM114-Status: UNSURE (   9.45  )
X-CRM114-Notice: Please train this message.
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
> +++ b/drivers/net/ethernet/cavium/common/cavium_ptp.c
> @@ -0,0 +1,353 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* cavium_ptp.c - PTP 1588 clock on Cavium hardware
> + * Copyright (c) 2003-2015, 2017 Cavium, Inc.
> + */
> +
> +#include <linux/device.h>
> +#include <linux/module.h>
> +#include <linux/timecounter.h>
> +#include <linux/pci.h>
> +
> +#include "cavium_ptp.h"
> +
> +#define DRV_NAME	"Cavium PTP Driver"

This is also unconventional and looks funny, e.g., here:

  $ ls /sys/bus/pci/drivers/
   8250_mid/             exar_serial/         mei_me/       snd_hda_intel/
   agpgart-intel/        i801_smbus/          parport_pc/   snd_soc_skl/
   agpgart-sis/          i915/                pcieport/     xen-platform-pci/
   agpgart-via/          intel_ish_ipc/       rtsx_pci/     xhci_hcd/
   ahci/                 intel_pch_thermal/   serial/
  'Cavium PTP Driver'/   iosf_mbi_pci/        shpchp/
   e1000e/               iwlwifi/             skl_uncore/

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
