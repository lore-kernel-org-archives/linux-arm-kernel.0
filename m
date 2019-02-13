Return-Path: <SRS0=x1Tr=QU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76350C282CA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 07:45:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4616D222BA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 07:45:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="czimo0k3";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n0Uu+1sp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4616D222BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=T6WMPTmkYqI38rGSUgcPQQW4V12VGNJVsmZ2c4du2Ck=; b=czimo0k3gyXY/y
	76ML/UXO6DuPDzUcFbb6Z0UvUPg0ykIGCd59615nwLZIgdQhgJ7z9AAHBs7g50bNRlR01HgYGn3sb
	UF+WGgQOBa7gDlvHXI3BT20TQ6PSGVm8cHY0bZRT49+MRTSmi/2R1jgwIItpQ7PlBz4P0P9Rexnp2
	tkvHJTIVL0nePGIXD0ygzsCAf2f2J7BQTDFI7ZGLaQTvcIGstD3PiqwfdoglYBcwEzByhqHwIBGnP
	XaDlLcHiT32l/T7INu94rwMzY9sZMtXqnA35+VjQeSKP/YfREr9BapsVv+DRl6D7iQA/blBWFtn+R
	4joKyvCBWxUP7tWvZdSA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtpEv-00022X-6X; Wed, 13 Feb 2019 07:45:53 +0000
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtpEr-000227-QZ
 for linux-arm-kernel@lists.infradead.org; Wed, 13 Feb 2019 07:45:51 +0000
Received: by mail-wm1-x343.google.com with SMTP id r17so1277284wmh.5
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 12 Feb 2019 23:45:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=WSLNpQeKH85LdvlZ78tn7b/TaWGoRsly3MpPfDxVU28=;
 b=n0Uu+1spwh6BP8F080TtY1cvdPiS5MomeYgaSXLX0ODIFfwbvTDCFCySsQcLxVKGmM
 dw/96VmrPhtvCuR7/3aha/Y+YTXZYmokABimDEcEnAeR0hD3UDlcQCUCKdmikIZpJm7D
 V81pl3f8hRpJxAFdazAHEXOg7tIHMAM9CYE2zVy7dMTLwKTYDzwRNPhxrhdAIO52PsDj
 w/7l9Pu0cYzoafONIE5xszt/iaFRaoZh+SEBV/1dLccfZHIgA35DSaB0okBf0jyDgwDz
 kUXx6/grQqC0RNDfrI1CRbMCF2x8FbFq5HpRq/FEdLVE5s+21PZZUKFE+EKOUMwCUXXD
 hTkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
 :references:mime-version:content-disposition:in-reply-to:user-agent;
 bh=WSLNpQeKH85LdvlZ78tn7b/TaWGoRsly3MpPfDxVU28=;
 b=nxIzldlADF8zYUBf+P69glRF1kE39ny0/r9127jbjePi3jlnGD74oLc7DOJyEL2Fkr
 ri6VW7X2E+X/tN3J0d+3oVxXx5rs8V4czDrGY8PLNAZqSpn2mAT9g6OxGH0JMNmsZOrh
 bkcTRS4bDwtUWKmJzoYAg4Izb9KGxVWhvZjbMzP9aNHP3ySln8bhKPLItFWbo8VwXMV6
 q0vYjfHIhogo1SHMySJyx7wZBOa09vKdFl0WN7hJtFwfQzoRK1UwpLLo8Z1tTYNBqZJS
 sae9OKJVaylkZGfxY8AeajLHXScHG6AyW55fybK8hOkTNoCoDjXafUs2wWzG2w54rY0V
 CN4Q==
X-Gm-Message-State: AHQUAuYKSu1Q4c0cvJooI8itIqRt1h5E0CgtSMBSplLfDunwOXGLUMxa
 kr3sirFlcPodEok0yilPAyg=
X-Google-Smtp-Source: AHgI3IZUCQNNdjmNfZR03XpdWC0K36paSAMR5JYQTu6XL1rM9r4b6zd01sh6EsJm+bWZZlyeBZ+N7A==
X-Received: by 2002:a1c:f605:: with SMTP id w5mr2238898wmc.116.1550043947629; 
 Tue, 12 Feb 2019 23:45:47 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
 by smtp.gmail.com with ESMTPSA id m4sm5399647wmi.3.2019.02.12.23.45.45
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 12 Feb 2019 23:45:46 -0800 (PST)
Date: Wed, 13 Feb 2019 08:45:44 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Waiman Long <longman@redhat.com>
Subject: Re: [PATCH v2 2/2] locking/rwsem: Optimize down_read_trylock()
Message-ID: <20190213074544.GB62549@gmail.com>
References: <1549913486-16799-1-git-send-email-longman@redhat.com>
 <1549913486-16799-3-git-send-email-longman@redhat.com>
 <CAHk-=wjTmSg6zX=xKFSPZor7FWi3s4D0dy-hz_M=yeF_6478QA@mail.gmail.com>
 <ef66f262-d68e-58ea-34f6-15b88803cf71@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ef66f262-d68e-58ea-34f6-15b88803cf71@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190212_234549_888869_6672D28C 
X-CRM114-Status: GOOD (  16.05  )
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
Cc: linux-ia64@vger.kernel.org, Linux-sh list <linux-sh@vger.kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Will Deacon <will.deacon@arm.com>,
 "H. Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org,
 linux-arch <linux-arch@vger.kernel.org>, Davidlohr Bueso <dave@stgolabs.net>,
 linux-hexagon@vger.kernel.org, the arch/x86 maintainers <x86@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@redhat.com>,
 linux-xtensa@linux-xtensa.org, Arnd Bergmann <arnd@arndb.de>,
 Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>,
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
 linux-alpha@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 Tim Chen <tim.c.chen@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


* Waiman Long <longman@redhat.com> wrote:

> I looked at the assembly code in arch/x86/include/asm/rwsem.h. For both
> trylocks (read & write), the count is read first before attempting to
> lock it. We did the same for all trylock functions in other locks.
> Depending on how the trylock is used and how contended the lock is, it
> may help or hurt performance. Changing down_read_trylock to do an
> unconditional cmpxchg will change the performance profile of existing
> code. So I would prefer keeping the current code.
> 
> I do notice now that the generic down_write_trylock() code is doing an
> unconditional compxchg. So I wonder if we should change it to read the
> lock first like other trylocks or just leave it as it is.

No, I think we should instead move the other trylocks to the 
try-for-ownership model as well, like Linus suggested.

That's the general assumption we make in locking primitives, that we 
optimize for the common, expected case - which would be that the trylock 
succeeds, and I don't see why trylock primitives should be different.

In fact I can see more ways for read-for-sharing to perform suboptimally 
on larger systems.

Thanks,

	Ingo

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
