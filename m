Return-Path: <SRS0=uP4V=P7=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AB87C282C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 09:42:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59D0A20861
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 09:42:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="P1zOiQHh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59D0A20861
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=emaro60XaUgmxgfsU/AyFhZev3cGKantY3HqZjME1g4=; b=P1zOiQHhSaS5Ikp/ml+Lb87EJ
	tTj1YZDKmqAohGOAfjKz2GbUhr8T+vGBbCzEWXDK+E+Rwvj4jPwfznc6bQbNa3JNlkeekr0++e3DI
	/JMVfmPaaW2pGvNY8fOSgJ73gfF6HoXsE2YfGtIO2OBFhTRZ8VdIH4xZ4+XIssIJd5quCvBgIOByH
	wBrJFpN8H9MgZK1hir84O8BIjE3VAg4HYLrzQHelq9zgHp2E86g4+lxeNv1NA7v3Qg5aNogf3QvFU
	uWPYqwxds9QtoLgFCuNzVMjAn7IEZpWruC4HT4Bsb/Kd5qs2eV3oHHUoxtGSQcAAzuu9M/0fO/jhe
	EgWOkFLMA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmF36-0005Zz-9X; Wed, 23 Jan 2019 09:42:20 +0000
Received: from mail-wr1-f68.google.com ([209.85.221.68])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmF32-0005Z9-Kh
 for linux-arm-kernel@lists.infradead.org; Wed, 23 Jan 2019 09:42:19 +0000
Received: by mail-wr1-f68.google.com with SMTP id x10so1574782wrs.8
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 23 Jan 2019 01:42:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=LwAAqvJT9N3NStH/aQvsXyjV9S5c+31FqNJh677rm8w=;
 b=sthzT8jH+/x5lmw33mkGrbgpIYIX/m7ZYmNjncaMAgaYIT2AkmmoigQPUHrFjYmKM+
 gTBV5caKDn2FqmEEg1tU5l2yPPBynQoLXmJ6g6EczRePZ43Sy/rW0kqXQ1MYt9gNkcnK
 cJvWE7orqZPpExYKZsaWYYQnE7OH2yWMRi3OUY7rnf7K2zeiHxKdEs62GVfHSjw7DZJn
 APZkQGAK/r4ck6Vh70E4rqB/9S8HNiCnR5mHRAwkA8+l9ugy2vb8Pc6svqPtXlBIy+Ke
 gCRahgyjhda0SfC5A41V7At7XsOPtF1kk47xqIJ85uHJswTRw2ZxQuGq4XR4uoS2+Qu/
 aOig==
X-Gm-Message-State: AJcUukdujGip0Rx91N/Q4Bk5Fo6rWX7VJd+PCGlGxlMy4OMtSWWWuM5y
 tdoHmWEjURCa7yuIG4tWeVXx4g==
X-Google-Smtp-Source: ALg8bN6Z8xYEd94pbnVQW2xw+r9i6sbB1rON1vRhzANgRjLt+xlHjWidTs1ed1fitLjVoOCRInrJJQ==
X-Received: by 2002:a5d:5182:: with SMTP id k2mr1843831wrv.121.1548236534444; 
 Wed, 23 Jan 2019 01:42:14 -0800 (PST)
Received: from [10.200.139.106] (ovpn-brq.redhat.com. [213.175.37.11])
 by smtp.gmail.com with ESMTPSA id w18sm95376173wru.54.2019.01.23.01.42.12
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 23 Jan 2019 01:42:13 -0800 (PST)
Subject: Re: [PATCH 2/4] arm: dump: no need to check return value of
 debugfs_create functions
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Kevin Hilman
 <khilman@kernel.org>, Russell King <linux@armlinux.org.uk>,
 Will Deacon <will.deacon@arm.com>
References: <20190122144114.9816-1-gregkh@linuxfoundation.org>
 <20190122144114.9816-3-gregkh@linuxfoundation.org>
From: Laura Abbott <labbott@redhat.com>
Message-ID: <7022c531-e3df-73e9-824f-11a623252045@redhat.com>
Date: Wed, 23 Jan 2019 10:42:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190122144114.9816-3-gregkh@linuxfoundation.org>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190123_014216_678173_B2C0818B 
X-CRM114-Status: GOOD (  20.65  )
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
Cc: Jinbum Park <jinb.park7@gmail.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Kees Cook <keescook@chromium.org>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 1/22/19 6:41 AM, Greg Kroah-Hartman wrote:
> When calling debugfs functions, there is no need to ever check the
> return value.  The function can work or not, but the code logic should
> never do something different based on this.
> 
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Jinbum Park <jinb.park7@gmail.com>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Laura Abbott <labbott@redhat.com>

Acked-by: Laura Abbott <labbott@redhat.com>

> Cc: linux-arm-kernel@lists.infradead.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>   arch/arm/include/asm/ptdump.h | 9 +++------
>   arch/arm/mm/dump.c            | 4 ++--
>   arch/arm/mm/ptdump_debugfs.c  | 8 ++------
>   3 files changed, 7 insertions(+), 14 deletions(-)
> 
> diff --git a/arch/arm/include/asm/ptdump.h b/arch/arm/include/asm/ptdump.h
> index 3ebf9718288d..0c2d3d0d4cc6 100644
> --- a/arch/arm/include/asm/ptdump.h
> +++ b/arch/arm/include/asm/ptdump.h
> @@ -21,13 +21,10 @@ struct ptdump_info {
>   
>   void ptdump_walk_pgd(struct seq_file *s, struct ptdump_info *info);
>   #ifdef CONFIG_ARM_PTDUMP_DEBUGFS
> -int ptdump_debugfs_register(struct ptdump_info *info, const char *name);
> +void ptdump_debugfs_register(struct ptdump_info *info, const char *name);
>   #else
> -static inline int ptdump_debugfs_register(struct ptdump_info *info,
> -					const char *name)
> -{
> -	return 0;
> -}
> +static inline void ptdump_debugfs_register(struct ptdump_info *info,
> +					   const char *name) { }
>   #endif /* CONFIG_ARM_PTDUMP_DEBUGFS */
>   
>   void ptdump_check_wx(void);
> diff --git a/arch/arm/mm/dump.c b/arch/arm/mm/dump.c
> index 084779c5c893..eb385a500ed0 100644
> --- a/arch/arm/mm/dump.c
> +++ b/arch/arm/mm/dump.c
> @@ -450,7 +450,7 @@ void ptdump_check_wx(void)
>   static int ptdump_init(void)
>   {
>   	ptdump_initialize();
> -	return ptdump_debugfs_register(&kernel_ptdump_info,
> -					"kernel_page_tables");
> +	ptdump_debugfs_register(&kernel_ptdump_info, "kernel_page_tables");
> +	return 0;
>   }
>   __initcall(ptdump_init);
> diff --git a/arch/arm/mm/ptdump_debugfs.c b/arch/arm/mm/ptdump_debugfs.c
> index be8d87be4b93..598b636615a2 100644
> --- a/arch/arm/mm/ptdump_debugfs.c
> +++ b/arch/arm/mm/ptdump_debugfs.c
> @@ -24,11 +24,7 @@ static const struct file_operations ptdump_fops = {
>   	.release	= single_release,
>   };
>   
> -int ptdump_debugfs_register(struct ptdump_info *info, const char *name)
> +void ptdump_debugfs_register(struct ptdump_info *info, const char *name)
>   {
> -	struct dentry *pe;
> -
> -	pe = debugfs_create_file(name, 0400, NULL, info, &ptdump_fops);
> -	return pe ? 0 : -ENOMEM;
> -
> +	debugfs_create_file(name, 0400, NULL, info, &ptdump_fops);
>   }
> 


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
