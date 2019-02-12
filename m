Return-Path: <SRS0=CPNf=QT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C98C8C282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 09:42:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93F042077B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 09:42:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="l9NhZOet";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="oz4fqcyB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93F042077B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Yh0zXBiH30GMzT62zWg5jSCN6O7awBEFHGlcQb19hoA=; b=l9NhZOeteuKB2M
	haX335q6Mp8qCMK4bf8rCfzjV/QmEv82DE+dff/7QvtD5y7UIkmoDWQLtID0Nxitf28RtVeOTLwa+
	g+lKB+CP039M0HCGH+jXnJ1FB65zGz0baCtIsAvZjtl+FaPB5wQz1kWrzjyHXbBmqZCb3q9UW2VD0
	fzw1rrgBugXRsxTmsXfGHIAiXdN+ONbtG+1m/bplgBxnOwSEH8Is9x6SHvahAWVyT3TxTzpdF9gd/
	rLpDBVXhvRVMMXIj7+B8qME4RNOhQkl+KvWtRMGidkauk/9EioZ/qux1sBcAJ6BQ307AhKGFjMG4X
	zsCb0VYkocAzhzvN96Bw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtUZl-0001s6-3I; Tue, 12 Feb 2019 09:42:01 +0000
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtUZe-0001qy-9U
 for linux-arm-kernel@lists.infradead.org; Tue, 12 Feb 2019 09:41:59 +0000
Received: by mail-pl1-x641.google.com with SMTP id g9so1045768plo.3
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 12 Feb 2019 01:41:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=shutemov-name.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=ULKJGWPq0No+6GC/bcxSVWYWrbcjwzSVvmdDBR8FNpg=;
 b=oz4fqcyBSi9ismZ7bytPCCn4QB2ehAPOo+jJuLzFVX2NYQ2azlwSYNQBmERfG1ZuVw
 eGQZGM7lEK7RcBM76vfU85SEtWwdtfVlExo96dNE435NP4TRW+crgtzDnNLH2uiShe2D
 CwsP6ZtNLwtB1FlDIIQbLv9+FEtcXyO4hy+6FZNg87BGUV0zDhttBb5qxe4RGMjCgAuE
 lEQH00osnCynrZmPPIePFjLqDylh8H7cpz8tzII/yALTiUwRjYgKyvDa5VgsfPyedIw0
 IVDExWw/9JzIlSmvGEQ8UnoP8VqC513UTVg+F0p3R9/36fwKNNdRIFjXXWxuZfv3840I
 ulyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=ULKJGWPq0No+6GC/bcxSVWYWrbcjwzSVvmdDBR8FNpg=;
 b=UDry/FLHNLTuK/7SxKlJpP6j7U2thvHEdajvbnLcZrOEtbmBpasbsqpJRi/1UtV5W3
 2hCnqpcdb2gJsNbsFck5bnYQYU2nlAo/i6JpscQ/BVuZV9ABHz5EU/Yb7a0l/2xMnWip
 qDdbGGlOUyIxUnrmhiytyauNuCqg26bGruTwekOZef1R6FYUFZJOfdu62693++552Fxu
 BgtaAG7+eDw2K/9DZFwcSct49sUMpry6aMochsFNUow8QP1nWnGp4j4VOo3u3vatrtUg
 KgJRth9MWvjT8R1eityKnqcg1xQHGfckUtskc5f5MI9kpPzaFvrtjPwTItFjWTlkfY/b
 bXpA==
X-Gm-Message-State: AHQUAuYKalKUU9R0tv6WujeqdgUAZP8Ht+GcayB/BXgbojOX3AfmikGg
 UO79V67hxetjq0HNIXkWHVZYYg==
X-Google-Smtp-Source: AHgI3IZbSkcUnItYKRqYqpDbDeAVRnQeTmuDwZZXQAMV8eQDd3Fni7xJYWoe03xeFvKMmhVcwLOcvA==
X-Received: by 2002:a17:902:bd0b:: with SMTP id
 p11mr3085458pls.259.1549964512626; 
 Tue, 12 Feb 2019 01:41:52 -0800 (PST)
Received: from kshutemo-mobl1.localdomain ([192.55.54.44])
 by smtp.gmail.com with ESMTPSA id y21sm17816378pfi.150.2019.02.12.01.41.51
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 12 Feb 2019 01:41:52 -0800 (PST)
Received: by kshutemo-mobl1.localdomain (Postfix, from userid 1000)
 id 84BA1300100; Tue, 12 Feb 2019 12:41:48 +0300 (+03)
Date: Tue, 12 Feb 2019 12:41:48 +0300
From: "Kirill A. Shutemov" <kirill@shutemov.name>
To: Jann Horn <jannh@google.com>
Subject: Re: [PATCH] mmap.2: describe the 5level paging hack
Message-ID: <20190212094148.qpd6wudyry5vzw3v@kshutemo-mobl1>
References: <20190211163653.97742-1-jannh@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190211163653.97742-1-jannh@google.com>
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190212_014158_107181_CC1D29BC 
X-CRM114-Status: GOOD (  33.23  )
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

On Mon, Feb 11, 2019 at 05:36:53PM +0100, Jann Horn wrote:
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

Thanks for doing this.

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

It probably worth recommending (void *) -1 as such address.

>  .\" Before Linux 2.6.24, the address was rounded up to the next page
>  .\" boundary; since 2.6.24, it is rounded down!
>  The address of the new mapping is returned as the result of the call.
> -- 
> 2.20.1.791.gb4d0f1c61a-goog
> 

-- 
 Kirill A. Shutemov

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
