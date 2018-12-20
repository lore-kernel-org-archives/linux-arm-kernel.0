Return-Path: <SRS0=AHqO=O5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FROM,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93CC8C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 14:02:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5AC62217D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 14:02:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="k1ezlleS";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BWoJ9Buz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AC62217D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:References:
	To:From:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=zHTenWBU2jzPw23VT2llbj5AusWo65EFJJyabDklJ7U=; b=k1ezlleScE+cbQsdA8QBUNbkG
	bWOLZMonfu2ruwALCEr0tIsbnmkEb5oKCODO0LQzp7wGScXmKijP17TeGV9ZlR0+qJiKrl53Widkw
	EnkBReekjsSTMBOXtNonth94BGKrWSKroYW+QUfbiAv+MPBZiZyCnyEqTBgIJRo0mYQM6hyb+Lbvv
	oJ2csMyHFH/P5z4NStil0PxeaQKTID6OCLO6d1AkzU1u69oR2rMVHL/97D3X5BgUwLL1t08gT8b2k
	up8yGbDs54xLTW3osXIHVfJsOg61GG4g89v3xxKEdSliUf7RZDRDMv01p+ejthAdN/i+ZtfVSOYFv
	3mLIuSYRw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZyuF-00048t-6d; Thu, 20 Dec 2018 14:02:31 +0000
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZyuC-000482-HZ
 for linux-arm-kernel@lists.infradead.org; Thu, 20 Dec 2018 14:02:30 +0000
Received: by mail-lj1-x243.google.com with SMTP id c19-v6so1666681lja.5
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 20 Dec 2018 06:02:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:from:to:cc:references:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=/8NfFjm2Bd3Lnd1twIypc/J5FieGSPrl3wqBm078CRU=;
 b=BWoJ9BuzPu3y6R9v8LHX/36sMw9CxkywuZsAyLMcVkVt7AOs7pobK27psVL+Ev6vGT
 /H1BoDPEHRHB+3M/FvGGqduTqwWgOYpnDvo+O46caGEtdRnRUkgYKgN7gBsB/ijLpLp3
 yWCxi9GmjZ3fwkeHUSGM4+zsjlrBvVCl43IjkmeTSzosHhtwx36ZEUsmgMEIyoGbpXSH
 xG3eI84ekbpbRUbcciTkSv+dVstk+toYfCgwv/iqMlxKFakqn1ZgQJkXLLBJnOGEl7ja
 gcvfqGk18xfJ23Slp34r7H/NB/tc0Vn2jMflrlVwM46JSrLCghRMvBXjRUkepDJObPQo
 KEEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=/8NfFjm2Bd3Lnd1twIypc/J5FieGSPrl3wqBm078CRU=;
 b=VNAFBS6e4uOTUL+crkfpy+ZVx+/NXDQmhPRb88ZQlCZvusw3I8IG5JZOzk7Az37SdQ
 ktPgepVJPhSsnQNKdO+vB+MJM50lh0YDgITum9t8ACt75OcK8VauZlD21JhwppAk5ERR
 tkghcF1X35wBlpXArC3zv5IbNYHfny+Mv2UZXdv5OTBihWSnqrHE6TazptqQzPeMA7zc
 7GbFOzdhA85ekvfNKnC+ATnsQfoPAYbxK70O01DmTIwzkqMRQU8eOR9MvkTfYF1+6DfK
 dR4HxTNyyB0NI1NFF30QutZ50InRtI3tv1lF3gHIQtyFdTFrZUADGR/YWy/YzqbFcC+6
 K8FQ==
X-Gm-Message-State: AA+aEWbuOTsLKR8fQVQ+k8RmAQAWME/ZXmXzk6M2deauC3v1tIjexvbp
 Qw6IEplqJEfcLqrW3lbvTi7ofn+X
X-Google-Smtp-Source: AFSGD/W+laRUlKNetDLVmWT9QJBBS73Ke3Di+d3u2Dqm7KYzTb3xlDvt9LMawtL/G8YD4CQZbZICrQ==
X-Received: by 2002:a2e:9556:: with SMTP id
 t22-v6mr16739705ljh.36.1545314536060; 
 Thu, 20 Dec 2018 06:02:16 -0800 (PST)
Received: from [10.17.182.20] (ll-22.209.223.85.sovam.net.ua. [85.223.209.22])
 by smtp.gmail.com with ESMTPSA id
 e14-v6sm4002521ljb.31.2018.12.20.06.02.15
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 20 Dec 2018 06:02:15 -0800 (PST)
Subject: Re: drm_gem_get_pages and proper flushing/coherency
From: Oleksandr Andrushchenko <andr2000@gmail.com>
To: linux-arm-kernel@lists.infradead.org
References: <c14e8d3a-43bf-30ac-3662-07c0edb923bb@gmail.com>
Message-ID: <bf081205-8d7d-2636-8a9c-a69d47147d5c@gmail.com>
Date: Thu, 20 Dec 2018 16:02:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <c14e8d3a-43bf-30ac-3662-07c0edb923bb@gmail.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181220_060228_606138_FB7DEE26 
X-CRM114-Status: GOOD (  24.14  )
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
Cc: xen-devel <xen-devel@lists.xenproject.org>,
 =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>,
 Gerd Hoffmann <kraxel@redhat.com>, dri-devel@lists.freedesktop.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

+ARM mailing list for help and suggestions

Dear ARM community!

Xen hypervizor para-virtualized DRM frontend driver [1] uses shmem
backed pages for display buffers and shares those with the host
driver. Everything works just fine, but in some scenarios I see
artifacts on the screen which are because those shmem pages of the
buffer are not flushed (please see the mail below for more
details from DRM point of view).
For x86 the flushing of the pages can be done with DRM helper [2]
and seem to help. But clflushopt, which is used there, is not defined
for ARM. I had a suggestion to use set_pages_array_*(),
but again it is only defined for x86, not ARM [3].

The implementation/workaround that I have [4] is based on the DMA
approach, e.g. I map shmem pages and it seem to help, but the whole
DMA approach here seems to be an overkill for that.

Now to the question: could anyone on ARM community help understand the
right way to flush those pages, so I don't need to use DMA for that?

Thank you,
Oleksandr

On 11/26/18 2:15 PM, Oleksandr Andrushchenko wrote:
> Hello, all!
>
> My driver (Xen para-virtualized frontend) in some scenarios uses
> drm_gem_get_pages for allocating backing storage for dumb buffers.
> There are use-cases which showed some artifacts on the screen
> (modetest, other) which were worked around by flushing pages of the
> buffer on page flip with drm_clflush_pages. But, the problem here
> is that drm_clflush_pages is not available on ARM platforms (it is a NOP)
> and doing flushes on every page flip seems to be non-optimal.
>
> Other drivers that use drm_gem_get_pages seem to use DMA map/unmap
> on the shmem backed buffer (this is from where drm_gem_get_pages
> allocates the pages) and this is an obvious approach as the buffer needs
> to be shared with real HW for DMA - please correct me if my understanding
> here is wrong.
>
> This is the part I missed in my implementation as I don't really have a
> HW device which needs DMA, but a backend running in a different Xen 
> domain.
>
> Thus, as the buffer is backed with cachable pages the backend may see
>
> artifacts on its side.
>
>
> I am looking for some advices on what would be the best option to
> make sure dumb buffers are not flushed every page flip and still
> the memory remains coherent to the backend. I have implemented a
> DMA map/unmap of the shmem pages on GEM object creation/destruction
> and this does solve the problem, but as the backend is not really
> a DMA device this is a bit misleading.
>
> Is there any other (more?) suitable/preferable way(s) to achieve the 
> same?
>
> Thank you,
> Oleksandr
>
[1] https://elixir.bootlin.com/linux/v4.20-rc7/source/drivers/gpu/drm/xen
[2] 
https://elixir.bootlin.com/linux/v4.20-rc7/source/drivers/gpu/drm/drm_cache.c#L45
[3] 
https://elixir.bootlin.com/linux/v4.20-rc7/source/arch/x86/include/asm/set_memory.h
[4] https://patchwork.kernel.org/patch/10700089/

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
