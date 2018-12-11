Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DF1AC07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:48:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E87BD20855
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:48:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ERKquNcw";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="MsMtz/um"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E87BD20855
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=zaBz+0xP0F7BCi0xK6BenKmMoN3f6sKzc4HaKumAqME=; b=ERKquNcwTbIZbS
	VWftjrJwhjGt8AkboySeGbXhkGe7I4k8JUj7IwIV6IKGswDZenFkWOvXD3OOQCrCX6POmIPmln+26
	Vj8G6SsnUMRB5C3DBZT0frhGskbBIrMGJyacSlJcTuU/l1NfIj7gmJxTOsQ3DvZ/jOvWNSoXi7Tru
	cej6PPRTb8ZgMn4cEVRS1BE/7gvdZUU4U/4y2DD0EsoztlK/uKd4zQ583+yDL91HQhP1+iR0xaWhS
	QgwlhT9uolm50vHxiSWpCeswaPNHVWOQMA1JVSn8m29TRA8+u9XptIvtEm8jQH4jE9CCki4QsC3pi
	zfvI+TFi/H4y4nUfkz+Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWlCx-0006We-K6; Tue, 11 Dec 2018 16:48:31 +0000
Received: from mail.skyhub.de ([5.9.137.197])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWlCt-0006Ua-7s
 for linux-arm-kernel@lists.infradead.org; Tue, 11 Dec 2018 16:48:28 +0000
Received: from zn.tnic (p200300EC2BCD2B00C8FE208D32917CBC.dip0.t-ipconnect.de
 [IPv6:2003:ec:2bcd:2b00:c8fe:208d:3291:7cbc])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 02D681EC0432;
 Tue, 11 Dec 2018 17:48:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
 t=1544546891;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
 bh=Zn+otd2k+RLzQPxUljdIejS25F6zRTQkh82EntBGCCM=;
 b=MsMtz/um1issjK9ZzeD1VHXPm53Rin6WXI7retk4knby2hDHLQkIgW0BKtDH+CApDHRBX0
 QTc6TwuWZev/QXP1LU+OPbN8a+Lum+VgQjE6Uo9Jiyk25yRDZiiymT+FakM41W26vBVygl
 veoGOeTYGXCdRXGulBz/N3uB5vBArvg=
Date: Tue, 11 Dec 2018 17:48:02 +0100
From: Borislav Petkov <bp@alien8.de>
To: James Morse <james.morse@arm.com>
Subject: Re: [PATCH v7 04/25] ACPI / APEI: Make hest.c manage the estatus
 memory pool
Message-ID: <20181211164802.GI27375@zn.tnic>
References: <20181203180613.228133-1-james.morse@arm.com>
 <20181203180613.228133-5-james.morse@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181203180613.228133-5-james.morse@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_084827_431908_1CA7A252 
X-CRM114-Status: GOOD (  22.03  )
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
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Tony Luck <tony.luck@intel.com>,
 Fan Wu <wufan@codeaurora.org>, linux-mm@kvack.org,
 Marc Zyngier <marc.zyngier@arm.com>, Catalin Marinas <catalin.marinas@arm.com>,
 Xie XiuQi <xiexiuqi@huawei.com>, Will Deacon <will.deacon@arm.com>,
 Christoffer Dall <christoffer.dall@arm.com>,
 Dongjiu Geng <gengdongjiu@huawei.com>, linux-acpi@vger.kernel.org,
 Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org, Len Brown <lenb@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Dec 03, 2018 at 06:05:52PM +0000, James Morse wrote:
> ghes.c has a memory pool it uses for the estatus cache and the estatus
> queue. The cache is initialised when registering the platform driver.
> For the queue, an NMI-like notification has to grow/shrink the pool
> as it is registered and unregistered.
> 
> This is all pretty noisy when adding new NMI-like notifications, it
> would be better to replace this with a static pool size based on the
> number of users.
> 
> As a precursor, move the call that creates the pool from ghes_init(),
> into hest.c. Later this will take the number of ghes entries and
> consolidate the queue allocations.
> Remove ghes_estatus_pool_exit() as hest.c doesn't have anywhere to put
> this.
> 
> The pool is now initialised as part of ACPI's subsys_initcall():
> (acpi_init(), acpi_scan_init(), acpi_pci_root_init(), acpi_hest_init())
> Before this patch it happened later as a GHES specific device_initcall().
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
>  drivers/acpi/apei/ghes.c | 33 ++++++---------------------------
>  drivers/acpi/apei/hest.c |  5 +++++
>  include/acpi/ghes.h      |  2 ++
>  3 files changed, 13 insertions(+), 27 deletions(-)

...

> diff --git a/drivers/acpi/apei/hest.c b/drivers/acpi/apei/hest.c
> index b1e9f81ebeea..da5fabaeb48f 100644
> --- a/drivers/acpi/apei/hest.c
> +++ b/drivers/acpi/apei/hest.c
> @@ -32,6 +32,7 @@
>  #include <linux/io.h>
>  #include <linux/platform_device.h>
>  #include <acpi/apei.h>
> +#include <acpi/ghes.h>
>  
>  #include "apei-internal.h"
>  
> @@ -200,6 +201,10 @@ static int __init hest_ghes_dev_register(unsigned int ghes_count)
>  	if (!ghes_arr.ghes_devs)
>  		return -ENOMEM;
>  
> +	rc = ghes_estatus_pool_init();
> +	if (rc)
> +		goto out;

Right, this happens before...

> +
>  	rc = apei_hest_parse(hest_parse_ghes, &ghes_arr);

... this but do we even want to do any memory allocations if we don't
have any HEST tables or we've been disabled by hest_disable?

IOW, we should swap those two calls, methinks.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
