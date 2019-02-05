Return-Path: <SRS0=y9BX=QM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5DC2C282CB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 15:29:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D1B22083B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 15:29:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="HgMLRvCj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D1B22083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:In-Reply-To:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
	List-Owner; bh=jph9QGxPYH4874//p1m8VMGdH4QOqzpI62Ag5zGczmk=; b=HgMLRvCjbcl5ay
	EXVp+RNoGK3y7fhA56u62hpzepiqAx55B9bxdItL4U+FlCC36MrClCYdOtQQ1/gfyFIN3CXtj0T9V
	5T7PkQrYy3TWhyGEKaBWrdYhjCqqsVBZMDSSW749fPK1Qg2rbbWXiGLzELNwQ2ak5QhyH7cPz7M5i
	hpA3RRYgAJJmC+UVmsp/dlY5oMMrNYqVdGYY6jxEVhBVlW6ZTwn82NIVjOynH4OAiEKsx+DgahALI
	ebPD8wx1Ip2vi0hhQEzO2uBOjoiEzf3ZcrytbIdH5SepqLmBB97718jh72Rr01Ks+TZTZaZ72cTEL
	v3JlivfaT5O4QgEo9tOw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gr2f1-0005Jz-4J; Tue, 05 Feb 2019 15:29:19 +0000
Received: from iolanthe.rowland.org ([192.131.102.54])
 by bombadil.infradead.org with smtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gr2ew-0005Im-Kd
 for linux-arm-kernel@lists.infradead.org; Tue, 05 Feb 2019 15:29:17 +0000
Received: (qmail 2180 invoked by uid 2102); 5 Feb 2019 10:29:11 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
 by localhost with SMTP; 5 Feb 2019 10:29:11 -0500
Date: Tue, 5 Feb 2019 10:29:11 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: [PATCH 0/8] ARM: davinci: move the da8xx-ohci GPIO logic into
 the driver
In-Reply-To: <20190205102546.29457-1-brgl@bgdev.pl>
Message-ID: <Pine.LNX.4.44L0.1902051027360.1472-100000@iolanthe.rowland.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190205_072914_818501_B82A47DD 
X-CRM114-Status: GOOD (  10.21  )
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
Cc: Kevin Hilman <khilman@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Linus Walleij <linus.walleij@linaro.org>, linux-usb@vger.kernel.org,
 Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, 5 Feb 2019, Bartosz Golaszewski wrote:

> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> In order to drop the hard-coded GPIO base values from the davinci GPIO
> driver's platform data, we first need to get rid of all calls to the
> legacy GPIO functions.
> 
> This series moves the GPIO logic related to da8xx-ohci out of the board
> files and into the driver code.
> 
> First two patches are just coding style tweaks. Next two add the GPIO
> lookup entries to the board files. Patch 5 add the vbus and overcurrent
> GPIO logic to the davinci USB host driver. Last three remove code that's
> no longer used.
> 
> Bartosz Golaszewski (8):
>   usb: ohci-da8xx: add a new line after local variables
>   usb: ohci-da8xx: add a helper pointer to &pdev->dev
>   ARM: davinci: omapl138-hawk: use gpio lookup entries for usb gpios
>   ARM: davinci: da830-evm: use gpio lookup entries for usb gpios
>   usb: ohci-da8xx: add vbus and overcurrent gpios
>   ARM: davinci: omapl138-hawk: remove legacy usb helpers
>   ARM: davinci: da830-evm: remove legacy usb helpers
>   usb: ohci-da8xx: remove unused callbacks from platform data
> 
>  arch/arm/mach-davinci/board-da830-evm.c     |  73 ++----------
>  arch/arm/mach-davinci/board-omapl138-hawk.c |  81 ++------------
>  drivers/usb/host/ohci-da8xx.c               | 118 ++++++++++----------
>  include/linux/platform_data/usb-davinci.h   |  14 ---
>  4 files changed, 77 insertions(+), 209 deletions(-)

For patches 1, 2, 5, and 8:

Acked-by: Alan Stern <stern@rowland.harvard.edu>


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
