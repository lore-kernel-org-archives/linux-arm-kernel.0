Return-Path: <SRS0=cUnb=OQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D0B7C07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 15:27:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 432B420672
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 15:27:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ccinWOXL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 432B420672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=UOtE1WbtqMzYbfyKWk7p5PTBRhC7IVQ9jIc7ysHRmOs=; b=ccinWOXLh1oPHh
	Rkii5Ysz/LgEjE5LlQ2DYsxf/WcdiOcce7qULxidn4Pd9E+AfUf0PtLdq+1V4O4KLz2HHoXI6MoUK
	Ymdo4wRRU7stCMBcSJ0hWJenaWfQi1VAg9xNK1C9/1p0033q4USOgIzmG6SgHMb/mh9IBMExKJsbw
	AeEcZO69U2aPbcdXgZ2sZ+mURuclxCIfiL07NyROLD9I8wGh7wxL2ATDCd8PAX5CdsZZSTbK+R9Yl
	dpV17dSu2QMn+gCDbNVDvoMuYgjVxW8RXfIM5YMS4UBpH3uEIVZuQO351ngXnPd8rdhR+x7p9Nxtd
	wfITdEoDrWor2iuHENSg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVI2V-0004KL-Em; Fri, 07 Dec 2018 15:27:39 +0000
Received: from mail-lj1-f194.google.com ([209.85.208.194])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVI2A-0004IK-Pd
 for linux-arm-kernel@lists.infradead.org; Fri, 07 Dec 2018 15:27:21 +0000
Received: by mail-lj1-f194.google.com with SMTP id n18-v6so3886489lji.7
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 07 Dec 2018 07:27:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=LWzi5N9ErnaoM0xtxI+fsrH2tP7+GEG9Yks3l1TlQ9c=;
 b=nDpvd1WjGGskxQl6I3t+jtpx7ZMFawH67jaEFuLqLw8Lzxtwgu0/4+2xcb0iYuMKC6
 gEyhdRlMS9PV8IEICoB1KnIDRYzXGZ05GRx7x2mZ8dhd+6Kt4F0jDCobKgRu6r9v6CR0
 AnLV+qzlfaesc/JdME9p+6Pu6aICP559Vv9NHRvCNkLMAPhP3wg28VSAhl5LTQ3wdkrf
 4cpEWSu8GyeyT/fHMO7OBxW1UOcQgSJ66pOEYUNxMPV56JW5Rw1awni3Ab/GuvYOXjq9
 AAyB9pvZbxzcupQWnsWeuR717S8ewbedSfG3bnC91INrmiL+m+pYUcQCWHk0Xf9Xi049
 N6sw==
X-Gm-Message-State: AA+aEWatJRcTCf7krl6ICUdOfwTBWaU2r1MkEMOmd5sAk04Rx3h3cu2t
 chNSzLLNS2/J1at/hypK4bNBpAtHiUVsOatZN3ItYA==
X-Google-Smtp-Source: AFSGD/WTd/GmJolkIKObTs+ltMJuaDgq9GIkgtG35aCg3hkojYRO9GQVVks9H09pqEe4/k1S2cqSx907M7vYAZaI4WA=
X-Received: by 2002:a2e:96c6:: with SMTP id d6-v6mr1768292ljj.35.1544196426315; 
 Fri, 07 Dec 2018 07:27:06 -0800 (PST)
MIME-Version: 1.0
References: <20181207101439.190918-1-james.morse@arm.com>
In-Reply-To: <20181207101439.190918-1-james.morse@arm.com>
From: Bhupesh Sharma <bhsharma@redhat.com>
Date: Fri, 7 Dec 2018 20:56:53 +0530
Message-ID: <CACi5LpM9_bQnx+YqBcFqFbMWAmZoYtDwopuSq+NpOaX8tjak=g@mail.gmail.com>
Subject: Re: [PATCH arm64/kexec] arm64: kexec_file: forbid kdump via
 kexec_file_load()
To: James Morse <james.morse@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181207_072718_834225_1A5EE406 
X-CRM114-Status: GOOD (  19.28  )
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
Cc: devicetree@vger.kernel.org, herbert@gondor.apana.org.au,
 Baoquan He <bhe@redhat.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 kexec mailing list <kexec@lists.infradead.org>, frowand.list@gmail.com,
 Will Deacon <will.deacon@arm.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 heiko.carstens@de.ibm.com, dhowells@redhat.com,
 AKASHI Takahiro <takahiro.akashi@linaro.org>, robh+dt@kernel.org,
 arnd@arndb.de, Vivek Goyal <vgoyal@redhat.com>,
 Catalin Marinas <catalin.marinas@arm.com>, schwidefsky@de.ibm.com,
 prudo@linux.ibm.com, Dave Young <dyoung@redhat.com>, davem@davemloft.net,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi James,

On Fri, Dec 7, 2018 at 3:44 PM James Morse <james.morse@arm.com> wrote:
>
> Now that kexec_walk_memblock() can do the crash-kernel placement itself
> architectures that don't support kdump via kexe_file_load() need to
> explicitly forbid it.
>
> We don't support this on arm64 until the kernel can add the elfcorehdr
> and usable-memory-range fields to the DT. Without these the crash-kernel
> overwrites the previous kernel's memory during startup.
>
> Add a check to refuse crash image loading.
>
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
>
> Context: http://lore.kernel.org/r/20181206155424.GA4422@arm.com
>
>  arch/arm64/kernel/kexec_image.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/arch/arm64/kernel/kexec_image.c b/arch/arm64/kernel/kexec_image.c
> index 1ad1d5f8f024..07bf740bea91 100644
> --- a/arch/arm64/kernel/kexec_image.c
> +++ b/arch/arm64/kernel/kexec_image.c
> @@ -47,6 +47,10 @@ static void *image_load(struct kimage *image,
>         struct kexec_segment *kernel_segment;
>         int ret;
>
> +       /* We don't support crash kernels yet. */
> +       if (image->type == KEXEC_TYPE_CRASH)
> +               return ERR_PTR(-EOPNOTSUPP);
> +
>         /*
>          * We require a kernel with an unambiguous Image header. Per
>          * Documentation/booting.txt, this is the case when image_size
> --
> 2.19.2
>

TBH, I would have loved the complete 'kexec_file_load' support to have
made way upstream for arm64 as well, but I understand that it is stuck
till we have an agreement on the DT side of things. So, refusing a
crash image loading in such a case makes sense for now.

So, please feel free to add:
Reviewed-by: Bhupesh Sharma <bhsharma@redhat.com>

Thanks,
Bhupesh

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
