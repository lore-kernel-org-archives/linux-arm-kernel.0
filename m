Return-Path: <SRS0=iy7m=RA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CFECC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 14:55:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DEAA52087C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 14:55:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="G9Zoxs33";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kiMnI9cn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEAA52087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=PdfOFS/XPAg/KtAcsvkbefR2f1ldParcZieZM5xte+4=; b=G9Zoxs33ukEpj1
	Ig5q7Gm23lXFJvGlnIehP9EA5Db39TxKUudMR+C+I5p9FRn5T+gWfU6Mfk6pbluJe0tBe+nIyNTNU
	a2gr6ebSWtmPB3PxWzCBMk5rxlh+RcbLkuNE50wZCv9+CZd5yrfvMA8wyZWiRBuTRqjXECzNf94vb
	RtrsnRPeveIlYSdf2wW3Ear+4HixrrtzdLExAyXi2jyTqj8tQ0bXHaQtugCVq13stS3rwoLwHN7Vw
	NLuUZIwgMesdOm2AIlSkr0ZYGSg2TS1AbWeqCUg42zBS4E/QrwsTAluXzkW76fpa2pnTtK+J2+jPL
	u29JOZJrzD9xIv97hapQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gyHex-00073e-95; Mon, 25 Feb 2019 14:55:11 +0000
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gyHet-0006Qy-Vh
 for linux-arm-kernel@lists.infradead.org; Mon, 25 Feb 2019 14:55:09 +0000
Received: by mail-wr1-x444.google.com with SMTP id w2so10237623wrt.11
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 25 Feb 2019 06:55:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=cc:subject:to:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=FnueZ7IgA8rCLeU7Gwwu1v68InYcHlydtHfzBGaNhqg=;
 b=kiMnI9cnaFC+hPmjq5tlaHrWWeVu0An8EuJG3iO5RC3aOLJQcE22McBXepYR1KFlrX
 6FOpAh7X3wmrN/cwFhDZQQ3inp1WUMlfd91fTdoHet4VXKjt3zRswPbcvxdwB4VP9gPz
 aSFDv2zemKltI8/JIHnWqxkK5Q0e3NyRAfERuoc3gGxRwjiVjpAVG5FP8kP6I7OBpEtW
 FGuo06wjBQXuZppltnY1ysSh/aDxqrbiY9kElHt5ImM8LlrbvsA0z7weVCLa9M5izYId
 xuaOVyynNTRaGAFSzOvri3pyyhnROsW9lxcKGPFmMclAhhxqtcrkEcus3Vab4aravkhc
 W/Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:cc:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=FnueZ7IgA8rCLeU7Gwwu1v68InYcHlydtHfzBGaNhqg=;
 b=KNakCPBvT+xHUV/n0HsbyAFVleMKp4Gb5zcHvKiNsbEmHduU5HDSZYCJww3aLt4fEM
 UaOH49uIWlD7AWshO967nD8skgnyniEpjRiSiQzMnVsaR6JbxkcagNOyLXPuA/U1AvLo
 WpRVVuJ+CCl9KqLYsYkHm8e+404c14VrQvfFJPj1fXJutV0/tfICfwkLpr29wbdHRHIi
 HsaDtzc9lsuwtdUN4SFy5gF2vKcG+BiGHp3PFtAgHI+6s9PaNZzFRfcUs2o8RHQL0YFD
 531UVlwmMYWLT902LmuoRp1ZGRzrQz6WRa9jU+rWDhzq+9/Uwv5Xc7OM53j+7GbVYr0j
 JEFw==
X-Gm-Message-State: AHQUAuY2pAg3H4apuO7SpYgpCOo5NlwEJwtHLu25R8/fhLftK1YexXN6
 6y/6jRj+s2650iaro12FnTQ=
X-Google-Smtp-Source: AHgI3IZVbhN223HxIrmHpDYhC1vNbII4YQzzRx7nERZ/9nQW80Z5Szvsa9KpxSDk/BK6NkQEI3BAUQ==
X-Received: by 2002:a05:6000:10ce:: with SMTP id
 b14mr13691963wrx.221.1551106505650; 
 Mon, 25 Feb 2019 06:55:05 -0800 (PST)
Received: from [10.0.21.20] ([95.157.63.22])
 by smtp.gmail.com with ESMTPSA id e7sm11403783wrw.35.2019.02.25.06.55.04
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Mon, 25 Feb 2019 06:55:04 -0800 (PST)
Subject: Re: [PATCH] mmap.2: describe the 5level paging hack
To: Jann Horn <jannh@google.com>
References: <20190211163653.97742-1-jannh@google.com>
From: "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Message-ID: <f89de711-d73b-96be-75b6-0e9054022708@gmail.com>
Date: Mon, 25 Feb 2019 15:55:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190211163653.97742-1-jannh@google.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190225_065508_028183_D13F2199 
X-CRM114-Status: GOOD (  34.95  )
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
Cc: linux-arch@vger.kernel.org, linux-man@vger.kernel.org,
 Catalin Marinas <catalin.marinas@arm.com>, Dave Hansen <dave.hansen@intel.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Will Deacon <will.deacon@arm.com>, linuxppc-dev@lists.ozlabs.org,
 Andy Lutomirski <luto@amacapital.net>, linux-mm@kvack.org,
 Paul Mackerras <paulus@samba.org>, mtk.manpages@gmail.com,
 Michael Ellerman <mpe@ellerman.id.au>,
 Andrew Morton <akpm@linux-foundation.org>, linux-api@vger.kernel.org,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 2/11/19 5:36 PM, Jann Horn wrote:
> The manpage is missing information about the compatibility hack for
> 5-level paging that went in in 4.14, around commit ee00f4a32a76 ("x86/mm:
> Allow userspace have mappings above 47-bit"). Add some information about
> that.
> 
> While I don't think any hardware supporting this is shipping yet (?), I
> think it's useful to try to write a manpage for this API, partly to
> figure out how usable that API actually is, and partly because when this
> hardware does ship, it'd be nice if distro manpages had information about
> how to use it.
> 
> Signed-off-by: Jann Horn <jannh@google.com>
> ---
> This patch goes on top of the patch "[PATCH] mmap.2: fix description of
> treatment of the hint" that I just sent, but I'm not sending them in a
> series because I want the first one to go in, and I think this one might
> be a bit more controversial.
> 
> It would be nice if the architecture maintainers and mm folks could have
> a look at this and check that what I wrote is right - I only looked at
> the source for this, I haven't tried it.
> 
>  man2/mmap.2 | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/man2/mmap.2 b/man2/mmap.2
> index 8556bbfeb..977782fa8 100644
> --- a/man2/mmap.2
> +++ b/man2/mmap.2
> @@ -67,6 +67,8 @@ is NULL,
>  then the kernel chooses the (page-aligned) address
>  at which to create the mapping;
>  this is the most portable method of creating a new mapping.
> +On Linux, in this case, the kernel may limit the maximum address that can be
> +used for allocations to a legacy limit for compatibility reasons.
>  If
>  .I addr
>  is not NULL,
> @@ -77,6 +79,19 @@ or equal to the value specified by
>  and attempt to create the mapping there.
>  If another mapping already exists there, the kernel picks a new
>  address, independent of the hint.
> +However, if a hint above the architecture's legacy address limit is provided
> +(on x86-64: above 0x7ffffffff000, on arm64: above 0x1000000000000, on ppc64 with
> +book3s: above 0x7fffffffffff or 0x3fffffffffff, depending on page size), the
> +kernel is permitted to allocate mappings beyond the architecture's legacy
> +address limit. The availability of such addresses is hardware-dependent.
> +Therefore, if you want to be able to use the full virtual address space of
> +hardware that supports addresses beyond the legacy range, you need to specify an
> +address above that limit; however, for security reasons, you should avoid
> +specifying a fixed valid address outside the compatibility range,
> +since that would reduce the value of userspace address space layout
> +randomization. Therefore, it is recommended to specify an address
> +.I beyond
> +the end of the userspace address space.
>  .\" Before Linux 2.6.24, the address was rounded up to the next page
>  .\" boundary; since 2.6.24, it is rounded down!
>  The address of the new mapping is returned as the result of the call.
>

Hi Jann,

A few comments came in on this patch. Is there anything from
those comments that should be rolled into the text?

Thanks,

Michael



-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
