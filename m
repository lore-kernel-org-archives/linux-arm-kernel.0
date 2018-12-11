Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BB98C07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 05:39:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B3E82054F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 05:39:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="HSuGQ91u";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="WcVfm3tC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B3E82054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=qjFNcDqWT2C0EDenbbTwlUYz6YvkrBF6azaqjp8bb+Q=; b=HSuGQ91uWDkRnd
	ChxUBlFn+91zF05nHB6UBTU+MoNjl2yFd44/4VVzQy88rwtbP0+IDURePXeP/TkWaloZDXvVMBXTn
	VwAJC3nFOVxPiPaW2st8skARWUWCn325YYgUknjPAAY8Dg/LDssLtxxXdrtxQRuOdgf3ogn2sgLt4
	wXK5YJACQvcUrD9hy8cpfZ5xjXjtL0TwiK39Y751LNhyEc88zJ3mCRElEXruM7Fl86QXOC//akHdX
	BawEKzhhlerwCn2CkMCp6fNfzoUlX1tdZyWiMS+uVZvUPwHZnO3B0LUN86MnyokhxKU9NbAGQREiX
	87cojDoz+LRMs0UxioyA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWalg-0000PA-6K; Tue, 11 Dec 2018 05:39:40 +0000
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWalY-0000Hc-7Z
 for linux-arm-kernel@lists.infradead.org; Tue, 11 Dec 2018 05:39:37 +0000
Received: by mail-pg1-x543.google.com with SMTP id z10so6116710pgp.7
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 10 Dec 2018 21:39:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:mail-followup-to:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=stmSX3PXcRyVdMNVm5vUdxgGBOXh3Sb8rfzgIO0InSY=;
 b=WcVfm3tCW+gsL+H1w5KxyvEXeTSrBd1C9jxV6ngKiejSuW5C3zZJlKsgQ9TR+jfb4C
 /8wAu+Fq5Eo+kIHVuvnxVg/AtMrALY1AuP9M5sOcLGUk9VjtqTmo+ml+GEs7oKrtFjbt
 BiCRxVmsdlKbEEAvOMcQr3jnoY/GZPzimKoag=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id
 :mail-followup-to:references:mime-version:content-disposition
 :in-reply-to:user-agent;
 bh=stmSX3PXcRyVdMNVm5vUdxgGBOXh3Sb8rfzgIO0InSY=;
 b=erVSmDaHjtLlrKaHV9Cvl2skFq4F9m+WBEhkmpmoxWoZAiTV8Qzowv+TKq/xRjN86i
 36r71nZQ95qhTgc9TJGTw/We/4zPO2A7ZQeLR72kBFwGlDv2h6m3sir75y8+vH44rNqf
 C7zzm9FbjbDBdh1lkAlXhygGUUsogGGOATdugUP/TZBGnAC2od6IcAeZzMhAUyDfNSHh
 xksuuHrEUdwbiMUqdlT6DuANyzshHfCORqrZgS/ys/vVXoDpe4Gj7Xj/QVNyKSCCMbIO
 dWBZ4rhWDYLjCaAYZg23RN4MOfZGlrlnxoKFuaK5Cow16fRN2q4tjhgD9W3QSE/Ni/W2
 K/Hg==
X-Gm-Message-State: AA+aEWZl33ZAsYutgpgf/2GlHmFDKT4Y3DX5w6hKNlPadT/VJ3LCN1ck
 TecMhckA4iHrycdZheKCtXz+eQ==
X-Google-Smtp-Source: AFSGD/VCCVgXATy2JvAF53fkbdjvY8UCEbi/uUeiU2X8vftbNTZKnbuRV32qJAWawEjijqTs7eldAg==
X-Received: by 2002:a63:82c6:: with SMTP id
 w189mr13623171pgd.344.1544506761012; 
 Mon, 10 Dec 2018 21:39:21 -0800 (PST)
Received: from linaro.org ([121.95.100.191])
 by smtp.googlemail.com with ESMTPSA id l19sm28311461pfi.71.2018.12.10.21.39.16
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 10 Dec 2018 21:39:20 -0800 (PST)
Date: Tue, 11 Dec 2018 14:42:33 +0900
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
To: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH v16 15/16] arm64: kexec_file: add kernel signature
 verification support
Message-ID: <20181211054231.GD21466@linaro.org>
Mail-Followup-To: AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Will Deacon <will.deacon@arm.com>, catalin.marinas@arm.com,
 dhowells@redhat.com, vgoyal@redhat.com, herbert@gondor.apana.org.au,
 davem@davemloft.net, dyoung@redhat.com, bhe@redhat.com,
 arnd@arndb.de, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
 prudo@linux.ibm.com, ard.biesheuvel@linaro.org, james.morse@arm.com,
 bhsharma@redhat.com, kexec@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20181115055254.2812-1-takahiro.akashi@linaro.org>
 <20181115055254.2812-16-takahiro.akashi@linaro.org>
 <20181130132113.GE9000@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181130132113.GE9000@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_213932_422279_91F13F84 
X-CRM114-Status: GOOD (  26.42  )
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

On Fri, Nov 30, 2018 at 01:21:14PM +0000, Will Deacon wrote:
> On Thu, Nov 15, 2018 at 02:52:54PM +0900, AKASHI Takahiro wrote:
> > With this patch, kernel verification can be done without IMA security
> > subsystem enabled. Turn on CONFIG_KEXEC_VERIFY_SIG instead.
> > 
> > On x86, a signature is embedded into a PE file (Microsoft's format) header
> > of binary. Since arm64's "Image" can also be seen as a PE file as far as
> > CONFIG_EFI is enabled, we adopt this format for kernel signing.
> > 
> > You can create a signed kernel image with:
> >     $ sbsign --key ${KEY} --cert ${CERT} Image
> > 
> > Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Will Deacon <will.deacon@arm.com>
> > Reviewed-by: James Morse <james.morse@arm.com>
> > ---
> >  arch/arm64/Kconfig              | 24 ++++++++++++++++++++++++
> >  arch/arm64/kernel/kexec_image.c | 17 +++++++++++++++++
> >  2 files changed, 41 insertions(+)
> > 
> > diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> > index 93dc4d36d6db..11f3e1a00588 100644
> > --- a/arch/arm64/Kconfig
> > +++ b/arch/arm64/Kconfig
> > @@ -867,6 +867,30 @@ config KEXEC_FILE
> >  	  for kernel and initramfs as opposed to list of segments as
> >  	  accepted by previous system call.
> >  
> > +config KEXEC_VERIFY_SIG
> > +	bool "Verify kernel signature during kexec_file_load() syscall"
> > +	depends on KEXEC_FILE
> > +	help
> > +	  Select this option to verify a signature with loaded kernel
> > +	  image. If configured, any attempt of loading a image without
> > +	  valid signature will fail.
> > +
> > +	  In addition to that option, you need to enable signature
> > +	  verification for the corresponding kernel image type being
> > +	  loaded in order for this to work.
> > +
> > +config KEXEC_IMAGE_VERIFY_SIG
> > +	bool "Enable Image signature verification support"
> > +	default y
> > +	depends on KEXEC_VERIFY_SIG
> > +	depends on EFI && SIGNED_PE_FILE_VERIFICATION
> > +	help
> > +	  Enable Image signature verification support.
> > +
> > +comment "Support for PE file signature verification disabled"
> > +	depends on KEXEC_VERIFY_SIG
> > +	depends on !EFI || !SIGNED_PE_FILE_VERIFICATION
> > +
> >  config CRASH_DUMP
> >  	bool "Build kdump crash kernel"
> >  	help
> > diff --git a/arch/arm64/kernel/kexec_image.c b/arch/arm64/kernel/kexec_image.c
> > index 9f0d8b5d62d3..d1c6c54c22e3 100644
> > --- a/arch/arm64/kernel/kexec_image.c
> > +++ b/arch/arm64/kernel/kexec_image.c
> > @@ -12,7 +12,9 @@
> >  #include <linux/errno.h>
> >  #include <linux/kernel.h>
> >  #include <linux/kexec.h>
> > +#include <linux/pe.h>
> >  #include <linux/string.h>
> > +#include <linux/verification.h>
> >  #include <asm/byteorder.h>
> >  #include <asm/cpufeature.h>
> >  #include <asm/image.h>
> > @@ -29,6 +31,10 @@ static int image_probe(const char *kernel_buf, unsigned long kernel_len)
> >  				sizeof(h->magic)))
> >  		return -EINVAL;
> >  
> > +	pr_debug("PE format: %s\n",
> > +			memcmp(&((struct mz_hdr *)h)->magic, "MZ", 2) ?
> > +							"no" : "yes");
> > 
> 
> Is this hunk really necessary? I'd prefer not to commit pr_debug()
> invocations.

This line comes from kexec-tools' code, but I don't mind removing it.
(as lots of lines diverge now from kexec-tools.)

-Takahiro Akashi


> Will

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
