Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC8E0C07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 07:49:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 943FE2082F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 07:49:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ai6WMZDf";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="W8Ml4FTZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 943FE2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Cc:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=yv8Yh1PeqSqhCL6D1TrcFA+S2bnklbPMW8reEuFL1fw=; b=ai6WMZDfaDYquK
	XROmOdeI6Jh2zuEsRl6/YxMjS6Mahvs1vw9nIRGhk+ZlR7m8RlqfrXIpRpb4oMJhPtPfYDfs2mJZo
	uqP5zrovMQvDbe+Ssj2Is6d8MNRpWxsv06qQ1nprGTQi7kb3XGtAi2juhbP7RL9aZ4r7u+nB+0Mqs
	80LXEdFy6ZWIqdJvLNKPj39nQ2+/Kog0EgeqSaHb/WuYJnIopkGzxFtTN8qm5lZLsZ7ozDxImli15
	pBVzokDPl16P8pZDABcOoHUhlko5HoaoEramwi1zyFPqo1yFBZz4uOwtxYahp35G5e60fYPsjdXBa
	gQRxOWfOWSwPcJX5BBXw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWcms-0003L2-8G; Tue, 11 Dec 2018 07:49:02 +0000
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWcml-0003ID-H1
 for linux-arm-kernel@lists.infradead.org; Tue, 11 Dec 2018 07:48:58 +0000
Received: by mail-pg1-x543.google.com with SMTP id s198so6269177pgs.2
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 10 Dec 2018 23:48:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:subject:message-id:mail-followup-to:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=XipAuGThqb8NbwoNlzBfTaW9mP3dpkNB+nduQZICwtI=;
 b=W8Ml4FTZ9Vui4AWq2Lic8+GhkkdlGnkM/bXw2S9JU8g1O/JfnJPSakZ++3HDe6sg/J
 hlfS/759szunBDUSCyP87ly7bkHyp+/Y/vytKpqt7KTaOzE7RPGUl81VhM+VOmkSUTPH
 8lhy/8WxHOJjQklvIFHXN4ZC0kh67MccBUTgk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:subject:message-id:mail-followup-to
 :references:mime-version:content-disposition:in-reply-to:user-agent;
 bh=XipAuGThqb8NbwoNlzBfTaW9mP3dpkNB+nduQZICwtI=;
 b=sg+4eW/uBZBHUfV2d68//uLEWGqqYJbq9tZqSHRL38O0yGjK4v3blYW2fo/mdHsd/6
 rmbkrMZgAQW52/N4SFXYUPvUP3FSFoIOuR+DnzP/YHfcSf/GeKpiGFCxoA7ANVY7FWLN
 YCJHXQkatA+J21OE31ZprVLVFNIxqodkYE9CV6zjUyBSLyLrH96bsTxrQWqMEDd9AFSk
 9+37TghhDYFCgPqh1XSKMamXvMAd92Kazd6gCdiwdJiVSN7DIyUzmM50lFS/BT+0dNOq
 yuwSqqycM0NoM37sVybrAfaIdXfS0h5weyupxC4VRC5IgbcTL260EDFvP0J5ZgPRLV3R
 ERhA==
X-Gm-Message-State: AA+aEWbA4xL+Dde15jYbN3U5qiCGqsbQ/CbKfaOQDCGZ1ueehvwkB3n1
 XcvZQhPkan6pOTaq/+qP/nmP8Q==
X-Google-Smtp-Source: AFSGD/VX86b4Tg0CagAJIHZAwHm15gXhdAnszBGxA3VRZ8weipHkom7RxlrXj+La7mK+1a3ZnbwQwA==
X-Received: by 2002:a62:8893:: with SMTP id l141mr15211872pfd.1.1544514524834; 
 Mon, 10 Dec 2018 23:48:44 -0800 (PST)
Received: from linaro.org ([121.95.100.191])
 by smtp.googlemail.com with ESMTPSA id q25sm16485230pgb.2.2018.12.10.23.48.40
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 10 Dec 2018 23:48:44 -0800 (PST)
Date: Tue, 11 Dec 2018 16:51:57 +0900
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
To: Will Deacon <will.deacon@arm.com>, catalin.marinas@arm.com,
 dhowells@redhat.com, vgoyal@redhat.com, herbert@gondor.apana.org.au,
 davem@davemloft.net, dyoung@redhat.com, bhe@redhat.com,
 arnd@arndb.de, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
 prudo@linux.ibm.com, ard.biesheuvel@linaro.org, james.morse@arm.com,
 bhsharma@redhat.com, kexec@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v16 16/16] arm64: kexec_file: add kaslr support
Message-ID: <20181211075155.GG21466@linaro.org>
Mail-Followup-To: AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Will Deacon <will.deacon@arm.com>, catalin.marinas@arm.com,
 dhowells@redhat.com, vgoyal@redhat.com, herbert@gondor.apana.org.au,
 davem@davemloft.net, dyoung@redhat.com, bhe@redhat.com,
 arnd@arndb.de, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
 prudo@linux.ibm.com, ard.biesheuvel@linaro.org, james.morse@arm.com,
 bhsharma@redhat.com, kexec@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20181115055254.2812-1-takahiro.akashi@linaro.org>
 <20181115055254.2812-17-takahiro.akashi@linaro.org>
 <20181130131944.GA9000@arm.com> <20181211055001.GE21466@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181211055001.GE21466@linaro.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_234855_585002_8023513B 
X-CRM114-Status: GOOD (  27.25  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Dec 11, 2018 at 02:50:02PM +0900, AKASHI Takahiro wrote:
> On Fri, Nov 30, 2018 at 01:19:44PM +0000, Will Deacon wrote:
> > On Thu, Nov 15, 2018 at 02:52:55PM +0900, AKASHI Takahiro wrote:
> > > Adding "kaslr-seed" to dtb enables triggering kaslr, or kernel virtual
> > > address randomization, at secondary kernel boot. We always do this as
> > > it will have no harm on kaslr-incapable kernel.
> > > 
> > > We don't have any "switch" to turn off this feature directly, but still
> > > can suppress it by passing "nokaslr" as a kernel boot argument.
> > > 
> > > Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > > Cc: Will Deacon <will.deacon@arm.com>
> > > ---
> > >  arch/arm64/kernel/machine_kexec_file.c | 46 +++++++++++++++++++++++++-
> > >  1 file changed, 45 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/arch/arm64/kernel/machine_kexec_file.c b/arch/arm64/kernel/machine_kexec_file.c
> > > index ab296b98d633..a0a730bd9be6 100644
> > > --- a/arch/arm64/kernel/machine_kexec_file.c
> > > +++ b/arch/arm64/kernel/machine_kexec_file.c
> > > @@ -16,6 +16,7 @@
> > >  #include <linux/libfdt.h>
> > >  #include <linux/memblock.h>
> > >  #include <linux/of_fdt.h>
> > > +#include <linux/random.h>
> > >  #include <linux/slab.h>
> > >  #include <linux/string.h>
> > >  #include <linux/types.h>
> > > @@ -28,6 +29,7 @@
> > >  #define FDT_PSTR_INITRD_STA	"linux,initrd-start"
> > >  #define FDT_PSTR_INITRD_END	"linux,initrd-end"
> > >  #define FDT_PSTR_BOOTARGS	"bootargs"
> > > +#define FDT_PSTR_KASLR_SEED	"kaslr-seed"
> > >  
> > >  const struct kexec_file_ops * const kexec_file_loaders[] = {
> > >  	&kexec_image_ops,
> > > @@ -46,11 +48,38 @@ int arch_kimage_file_post_load_cleanup(struct kimage *image)
> > >  	return kexec_image_post_load_cleanup_default(image);
> > >  }
> > >  
> > > +/* crng needs to have been initialized for providing kaslr-seed */
> > > +static int random_ready;
> > > +
> > > +static void random_ready_notified(struct random_ready_callback *unused)
> > > +{
> > > +	random_ready = 1;
> > > +}
> > > +
> > > +static struct random_ready_callback random_ready_cb = {
> > > +	.func = random_ready_notified,
> > > +};
> > > +
> > > +static __init int init_random_ready_cb(void)
> > > +{
> > > +	int ret;
> > > +
> > > +	ret = add_random_ready_callback(&random_ready_cb);
> > > +	if (ret == -EALREADY)
> > > +		random_ready = 1;
> > > +	else if (ret)
> > > +		pr_warn("failed to add a callback for random_ready\n");
> > > +
> > > +	return 0;
> > > +}
> > > +late_initcall(init_random_ready_cb)
> > 
> > Why can't we just call crng_ready()?
> 
> because crng_ready() is locally defined in drivers/char/random.c.
> Instead, I'd like to use
>         wait_for_random_bytes();
>         value = get_random_u64();

Correction:
After several tests, I now don't think that calling wait_for_random_bytes()
is a good idea since it can make kexec_file_load() syscall stalled.
So, I would go for
        if (rng_is_initialized())
                value = get_random_u64();

-Takahiro Akashi

> > > +
> > >  static int setup_dtb(struct kimage *image,
> > >  		     unsigned long initrd_load_addr, unsigned long initrd_len,
> > >  		     char *cmdline, void *dtb)
> > >  {
> > >  	int nodeoffset;
> > > +	u64 value;
> > >  	int ret;
> > >  
> > >  	nodeoffset = fdt_path_offset(dtb, "/chosen");
> > > @@ -106,12 +135,27 @@ static int setup_dtb(struct kimage *image,
> > >  			return -EINVAL;
> > >  	}
> > >  
> > > +	/* add kaslr-seed */
> > > +	ret = fdt_delprop(dtb, nodeoffset, FDT_PSTR_KASLR_SEED);
> > > +	if (ret && (ret != -FDT_ERR_NOTFOUND))
> > > +		return -EINVAL;
> > > +
> > > +	if (random_ready) {
> > > +		get_random_bytes(&value, sizeof(value));
> > 
> > get_random_u64() ?
> 
> OK.
> 
> > > +		ret = fdt_setprop_u64(dtb, nodeoffset, FDT_PSTR_KASLR_SEED,
> > > +							value);
> > > +		if (ret)
> > > +			return (ret == -FDT_ERR_NOSPACE ? -ENOMEM : -EINVAL);
> > > +	} else {
> > 
> > Wouldn't we be better off preserving the previous seed here, if it was
> > present?
> 
> While there's no guarantee that dtb won't be (partially) broken
> on failure, I will let this function return successfully
> by deleting succeeding fdt_delprop().
> 
> 
> > > +		pr_notice("kaslr-seed won't be fed\n");
> > 
> > "fed" is probably not the right word here.
> 
> => won't be *provided* on kexec?
> 
> -Takahiro Akashi
> 
> > Will

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
