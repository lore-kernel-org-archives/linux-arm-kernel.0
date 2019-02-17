Return-Path: <SRS0=tnMb=QY=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C372C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 09:38:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B3BB2192D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 09:38:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gmjuuU4l";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lechnology.com header.i=@lechnology.com header.b="nJHNQ4BL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B3BB2192D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lechnology.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=wzO1QF9cHTdJyEA+a2YmHA3hL7u/+MeLx4SLbZ0tSUU=; b=gmjuuU4lMt72en8GVTqQYxlFY
	Ki7dbFcSnKfD8B91miEg1+lV5j+Y93+ROl3nXSEyNzBgYMqXnJoDYbK9k5VBiuu+WLHmpRww57wPQ
	JZ8iVLcOtgOt03OyM/+DF97qaA4w0BCt2j+JBQtVsMjZmKVqq9K5yKnneGEHhgUHj53SwKzok8MTb
	VQim7nXuSrSzGyLlNvVd22qNF2BG8Rfh98wFb2ltRQ+GMk9/xtZCdukTCtQLHJlaN6Hals51QwkH0
	787RZxnyBhNGT1Gdpu00rE9D8L2hnpb3MwUUuVmRbedQ/GjOl0Hjt0bD9v6V7/sGAyCOXrs9idZvd
	XERQzBdsQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvItr-0002fA-EE; Sun, 17 Feb 2019 09:38:15 +0000
Received: from vern.gendns.com ([98.142.107.122])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvIto-0002eB-2M
 for linux-arm-kernel@lists.infradead.org; Sun, 17 Feb 2019 09:38:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
 In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Tg7atT9isVHgD7z+wP3NGPc0yCfGa2DJ3Y8XHHBIgp8=; b=nJHNQ4BLAbiUA8p2edaGKfPlwY
 RQfWbv56BDbDV32rC1RNU8hQ+cCrFkUE7fD3WC+ZunaA86c7C2S50f1lRx/EUMZSX82GxFEUWVQgl
 2yUvADZRHgycjgGBek/Mk5F1KDfj7DqAad67IvmQ/Z132P7i8+mmVgMI/iO1xGo8ib3FRCsMXNuIV
 BvIDegQIhfaUfqQpmZbZEm6HL2hvyK9X+yNAl8CkoW9pu1ewDrlUSnh+PbW1LdTSlxwKU9OEeLW6+
 0W0EI+Z7ON1yJT5EZWzX76ghz3gwh5UVnFUJlvLomfTlevOIR75ojTbsY+IozQTVeIznNiYwlGAsV
 ezSCmOSw==;
Received: from [185.122.190.68] (port=40637 helo=gerda-5.local)
 by vern.gendns.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
 (Exim 4.91) (envelope-from <david@lechnology.com>)
 id 1gvItb-0005ih-BQ; Sun, 17 Feb 2019 04:37:59 -0500
Subject: Re: [PATCH v4 09/37] ARM: davinci: make irqs.h a local header
To: Bartosz Golaszewski <brgl@bgdev.pl>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Sekhar Nori <nsekhar@ti.com>,
 Kevin Hilman <khilman@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>
References: <20190214145231.8750-1-brgl@bgdev.pl>
 <20190214145231.8750-10-brgl@bgdev.pl>
From: David Lechner <david@lechnology.com>
Message-ID: <adf9b125-eb68-9e3c-ccf0-00bbba34d781@lechnology.com>
Date: Sun, 17 Feb 2019 10:38:06 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190214145231.8750-10-brgl@bgdev.pl>
Content-Language: en-US
X-AntiAbuse: This header was added to track abuse,
 please include it with any abuse report
X-AntiAbuse: Primary Hostname - vern.gendns.com
X-AntiAbuse: Original Domain - lists.infradead.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lechnology.com
X-Get-Message-Sender-Via: vern.gendns.com: authenticated_id:
 davidmain+lechnology.com/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: vern.gendns.com: davidmain@lechnology.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190217_013812_195277_716804CD 
X-CRM114-Status: GOOD (  12.11  )
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
Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 2/14/19 8:52 AM, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> The existence of irqs.h in mach-davinci/include/mach only makes sense
> without SPARSE_IRQ as it's then expected to define NR_IRQS and is
> included from asm/irq.h. As we now support SPARSE_IRQ, this header can
> be moved to mach-davinci and used as the source of HW interrupt numbers.
> 
> While updating the includes in various files - also rearrange the
> headers by directory (linux/asm/mach).
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---

Reviewed-by: David Lechner <david@lechnology.com>


> diff --git a/arch/arm/mach-davinci/board-dm646x-evm.c b/arch/arm/mach-davinci/board-dm646x-evm.c
> index 8d5be6dd2019..26c123f35350 100644
> --- a/arch/arm/mach-davinci/board-dm646x-evm.c
> +++ b/arch/arm/mach-davinci/board-dm646x-evm.c
> @@ -44,10 +44,11 @@
>   #include <asm/mach/arch.h>
>   
>   #include <mach/common.h>
> -#include <mach/irqs.h>
> +

We could leave out the blank line here.

>   #include <mach/serial.h>
>   
>   #include "davinci.h"
> +#include "irqs.h"
>   
>   #define NAND_BLOCK_SIZE		SZ_128K
>   

...

> diff --git a/arch/arm/mach-davinci/usb.c b/arch/arm/mach-davinci/usb.c
> index 9d4a58a3113a..1e14e964c34d 100644
> --- a/arch/arm/mach-davinci/usb.c
> +++ b/arch/arm/mach-davinci/usb.c
> @@ -5,13 +5,13 @@
>   #include <linux/init.h>
>   #include <linux/platform_device.h>
>   #include <linux/dma-mapping.h>

Could put dma-mapping.h before init.h here too.

> -
> +#include <linux/platform_data/usb-davinci.h>
>   #include <linux/usb/musb.h>
>   
>   #include <mach/common.h>
> -#include <mach/irqs.h>
>   #include <mach/cputype.h>
> -#include <linux/platform_data/usb-davinci.h>
> +
> +#include "irqs.h"
>   
>   #define DAVINCI_USB_OTG_BASE	0x01c64000
>   
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
