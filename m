Return-Path: <SRS0=AWyS=OJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4504BC65BAE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 13:20:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0691F20867
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 13:20:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="avdrnAJs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0691F20867
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=grFqoE+gRyj/lFzQTqNEMI8yK8+7SZuzIC30kwszLaY=; b=avdrnAJsS6W/tx
	8SC45/zEndm6MKzBw1h2AUQ5pSyN911qTrHY8bnZfn0NhTybJJ9DdIR1sPYQRAxamQwLNZGmWuzpM
	rY/IW9gWstyGuT4sBIM90F3NM9uz0IajopiyVwjgFAOruLj8yVC7kZJANg6viSJUTe6PM8jpjFMZQ
	ymJPS9/VRkivZL8P+tpl5lbbAVtglpeU1WeiWrLe6mpGWfaI8LC5NztgVOiYLn9pdFRu0F6Axn0JP
	P7a8cSnSkgkdK/NcFOs97TqvM8psSV+m+JqQP6LkbvZ41A7DXEMdyN0SryZ8AjIaF+ZuDB2pjbqXR
	yHrcKOHsoLsflXXDL1wg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSii8-00015H-3h; Fri, 30 Nov 2018 13:20:00 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSihn-00012s-8o; Fri, 30 Nov 2018 13:19:40 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DDA47A78;
 Fri, 30 Nov 2018 05:19:25 -0800 (PST)
Received: from edgewater-inn.cambridge.arm.com
 (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A92EC3F5A0;
 Fri, 30 Nov 2018 05:19:25 -0800 (PST)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
 id 737A11AE12D3; Fri, 30 Nov 2018 13:19:44 +0000 (GMT)
Date: Fri, 30 Nov 2018 13:19:44 +0000
From: Will Deacon <will.deacon@arm.com>
To: AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: Re: [PATCH v16 16/16] arm64: kexec_file: add kaslr support
Message-ID: <20181130131944.GA9000@arm.com>
References: <20181115055254.2812-1-takahiro.akashi@linaro.org>
 <20181115055254.2812-17-takahiro.akashi@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181115055254.2812-17-takahiro.akashi@linaro.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181130_051939_314734_1ADCC636 
X-CRM114-Status: GOOD (  22.00  )
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
Cc: prudo@linux.ibm.com, herbert@gondor.apana.org.au, bhe@redhat.com,
 ard.biesheuvel@linaro.org, catalin.marinas@arm.com, bhsharma@redhat.com,
 heiko.carstens@de.ibm.com, linux-kernel@vger.kernel.org, dhowells@redhat.com,
 arnd@arndb.de, linux-arm-kernel@lists.infradead.org, kexec@lists.infradead.org,
 schwidefsky@de.ibm.com, james.morse@arm.com, dyoung@redhat.com,
 davem@davemloft.net, vgoyal@redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Nov 15, 2018 at 02:52:55PM +0900, AKASHI Takahiro wrote:
> Adding "kaslr-seed" to dtb enables triggering kaslr, or kernel virtual
> address randomization, at secondary kernel boot. We always do this as
> it will have no harm on kaslr-incapable kernel.
> 
> We don't have any "switch" to turn off this feature directly, but still
> can suppress it by passing "nokaslr" as a kernel boot argument.
> 
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> ---
>  arch/arm64/kernel/machine_kexec_file.c | 46 +++++++++++++++++++++++++-
>  1 file changed, 45 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kernel/machine_kexec_file.c b/arch/arm64/kernel/machine_kexec_file.c
> index ab296b98d633..a0a730bd9be6 100644
> --- a/arch/arm64/kernel/machine_kexec_file.c
> +++ b/arch/arm64/kernel/machine_kexec_file.c
> @@ -16,6 +16,7 @@
>  #include <linux/libfdt.h>
>  #include <linux/memblock.h>
>  #include <linux/of_fdt.h>
> +#include <linux/random.h>
>  #include <linux/slab.h>
>  #include <linux/string.h>
>  #include <linux/types.h>
> @@ -28,6 +29,7 @@
>  #define FDT_PSTR_INITRD_STA	"linux,initrd-start"
>  #define FDT_PSTR_INITRD_END	"linux,initrd-end"
>  #define FDT_PSTR_BOOTARGS	"bootargs"
> +#define FDT_PSTR_KASLR_SEED	"kaslr-seed"
>  
>  const struct kexec_file_ops * const kexec_file_loaders[] = {
>  	&kexec_image_ops,
> @@ -46,11 +48,38 @@ int arch_kimage_file_post_load_cleanup(struct kimage *image)
>  	return kexec_image_post_load_cleanup_default(image);
>  }
>  
> +/* crng needs to have been initialized for providing kaslr-seed */
> +static int random_ready;
> +
> +static void random_ready_notified(struct random_ready_callback *unused)
> +{
> +	random_ready = 1;
> +}
> +
> +static struct random_ready_callback random_ready_cb = {
> +	.func = random_ready_notified,
> +};
> +
> +static __init int init_random_ready_cb(void)
> +{
> +	int ret;
> +
> +	ret = add_random_ready_callback(&random_ready_cb);
> +	if (ret == -EALREADY)
> +		random_ready = 1;
> +	else if (ret)
> +		pr_warn("failed to add a callback for random_ready\n");
> +
> +	return 0;
> +}
> +late_initcall(init_random_ready_cb)

Why can't we just call crng_ready()?

> +
>  static int setup_dtb(struct kimage *image,
>  		     unsigned long initrd_load_addr, unsigned long initrd_len,
>  		     char *cmdline, void *dtb)
>  {
>  	int nodeoffset;
> +	u64 value;
>  	int ret;
>  
>  	nodeoffset = fdt_path_offset(dtb, "/chosen");
> @@ -106,12 +135,27 @@ static int setup_dtb(struct kimage *image,
>  			return -EINVAL;
>  	}
>  
> +	/* add kaslr-seed */
> +	ret = fdt_delprop(dtb, nodeoffset, FDT_PSTR_KASLR_SEED);
> +	if (ret && (ret != -FDT_ERR_NOTFOUND))
> +		return -EINVAL;
> +
> +	if (random_ready) {
> +		get_random_bytes(&value, sizeof(value));

get_random_u64() ?

> +		ret = fdt_setprop_u64(dtb, nodeoffset, FDT_PSTR_KASLR_SEED,
> +							value);
> +		if (ret)
> +			return (ret == -FDT_ERR_NOSPACE ? -ENOMEM : -EINVAL);
> +	} else {

Wouldn't we be better off preserving the previous seed here, if it was
present?

> +		pr_notice("kaslr-seed won't be fed\n");

"fed" is probably not the right word here.

Will

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
