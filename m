Return-Path: <SRS0=Pwbl=PU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE66EC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 14:21:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1A362084E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 14:21:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="P4RXZV4Z";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GimcIYZK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1A362084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Mb+7l2wKtJT55rBhdrhLWc7jQWZoc0AZbasSzGJaRI4=; b=P4RXZV4ZA86F2R
	GRYJETGOmaM2eIxhoxnpkHegyL2iXFIolAOINdNIfMBjV8PVVh+U691TkV049e3nbbT5PxxEZ66J0
	KF4LRKQABwhTWg8Kw31IjWc6JioPrltiefBu7DxWF3xkRYlGXr8A1GLKi1R4ZtmRcKMs1fDnnJaTK
	Ls0H/zWxsoFx6wEEv8KFCyIhTWbFUax3gud8niOWcta3zRdhqHlJHxaY56uOpnVis40T3rYSlgCGn
	Kf0UQNnDvuptyUAJgMe967bVJE9oMxbbJ5GpUp5xIam121I7y7OBFfW3LYpzIFOEt83mYHgLEuk4t
	fajFLSSuQRrpiqvKj1ow==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1giKA3-00085s-Kc; Sat, 12 Jan 2019 14:21:19 +0000
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1giK9y-000856-4p
 for linux-arm-kernel@lists.infradead.org; Sat, 12 Jan 2019 14:21:15 +0000
Received: by mail-pl1-x642.google.com with SMTP id 101so8088804pld.6
 for <linux-arm-kernel@lists.infradead.org>;
 Sat, 12 Jan 2019 06:21:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=AgztArJgeyI5akkyciYTqOnUwbkH9r4FP5+/k10NYlQ=;
 b=GimcIYZKXTRu9g1J9k8L0qcyKVYBysJpjcAGwKF1FQ5PS+5A213ABMU3N4S60RJGjq
 AYWlgFQpTN6dWDaz9zTgd15Hkin1sfazkfJIgaVQPA06xP02f6M7XJLDMcrstcXiCxhH
 x5qdu8A9LyKyDxeTg0QzBbh/1eAuRnjgapXIrKV8FH5ifgS0tX4mDCI+qZKSAACtxsWm
 UREh7KwBEpVh8jDG6bTAjt+v0CVyLr07jaDcV5wUtVrZDhN14AHu+Wkh4rpe798n+pLv
 2gNLoXBbKmC/fxElnVHgD716ayuAjpv688SdllVuIma9V01oOVXu9VQrkT/yGC1uwzo/
 DBSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=AgztArJgeyI5akkyciYTqOnUwbkH9r4FP5+/k10NYlQ=;
 b=H3Oo8wOOd8lCS82IFsEtZOgdzBybzDov43I5IPXE5LWweGhQjX89v8XAxaLcx0PiK/
 VbzgaEiAw+mYAMVuIQiSUlWmX9bROXBmvXDPYymJjIPlCnEwF4ILntKiMS7zlt0n3tYQ
 RCPvA2GUzDJ3vUEvQ+h804PLKyGcWi750HaNh8Fma1gLNriCzawiEWVEj08Umwh8uK80
 gy2l14c9vle9S70D4hOcRspgVQhbGpdwM44jlztLNRODizfpuvGGcLTe+L++TBUsvpGu
 dvb7Ix8UBTrfY3ZS/fL++IC+3yG5XBitkRDO4mbaP2kUxHtzRMjR2xsqktUDzQzHfamh
 cNiQ==
X-Gm-Message-State: AJcUukfMuxD7CxbABQsxG7Ogzsp5UTtlCtBMZXkxO/XrubUbNp6whjhh
 V7SnVVjJamsUwJ97n6RZKhCGWKh3z9s=
X-Google-Smtp-Source: ALg8bN4u0a09j0SanHRTuHYZDh38d4cZ9d5mkCKGk53kYwNpFybtGRJj6Z3KYuyRp2SrYrrFmRErIw==
X-Received: by 2002:a17:902:d01:: with SMTP id
 1mr19042800plu.127.1547302870972; 
 Sat, 12 Jan 2019 06:21:10 -0800 (PST)
Received: from mail.google.com ([207.246.99.41])
 by smtp.gmail.com with ESMTPSA id w184sm92667189pgd.34.2019.01.12.06.21.04
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sat, 12 Jan 2019 06:21:10 -0800 (PST)
Date: Sat, 12 Jan 2019 22:20:58 +0800
From: Changbin Du <changbin.du@gmail.com>
To: Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH] fgraph: record function return value
Message-ID: <20190112142056.6imezyzfw64qzg2x@mail.google.com>
References: <20190112065701.30841-1-changbin.du@gmail.com>
 <20190112122113.GR6310@bombadil.infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190112122113.GR6310@bombadil.infradead.org>
User-Agent: NeoMutt/20171215
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190112_062114_381965_3E49CAC6 
X-CRM114-Status: GOOD (  19.93  )
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
Cc: linux-doc@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org,
 rostedt@goodmis.org, linux@armlinux.org.uk,
 linux-arm-kernel@lists.infradead.org, Changbin Du <changbin.du@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


Hi Matthew,
On Sat, Jan 12, 2019 at 04:21:13AM -0800, Matthew Wilcox wrote:
> On Sat, Jan 12, 2019 at 02:57:01PM +0800, Changbin Du wrote:
> > This patch adds a new trace option 'funcgraph-retval' and is disabled by
> > default. When this option is enabled, fgraph tracer will show the return
> > value of each function. This is useful to find/analyze a original error
> > source in a call graph.
> > 
> > One limitation is that kernel doesn't know the prototype of functions. So
> > fgraph assumes all functions have a retvalue of type int. You must ignore
> > the value of *void* function. And if the retvalue looks like an error code
> > then both hexadecimal and decimal number are displayed.
> 
> I don't think we can do this.  You're leaking a _lot_ of kernel addresses
> this way, and we've been trying very hard to avoid doing that because
> it gives a lot of information to attackers.
> 
> Something more clever that prints out only errors (ie IS_ERR_VALUE())
> might be acceptable.  I would think printing return values that are
> between 0 and 4095 should also be OK since they can't be real pointers.
> We'd leak whether a function called kmalloc(0, x) since that returns
> 16, but that seems like a not-very-useful information leak.
> 
Regarding to security concern, I don't think this is a problem. Because using
ftrace requires *root* permission. And if the attack has got root previlege,
he/her can obtain nearly all kernel inner information through variant tools.
For example, we can write an eBPF program to probe kernel functions and we
just need root previlege to load our program. We also can use the *crash*
tool to retreive kernel data.

> >  3)   0.247 us    |    mutex_unlock(); /* ret=0xffff8880738ed040 */
> >  3)               |    kvm_arch_vcpu_create() {
> >  3)               |      vmx_create_vcpu() {
> >  3) + 17.969 us   |        kmem_cache_alloc(); /* ret=0xffff88813a980040 */
> >  3) + 15.948 us   |        kmem_cache_alloc(); /* ret=0xffff88813aa99200 */
> >  3)   0.653 us    |        allocate_vpid.part.88(); /* ret=0x1 */
> >  3)   6.964 us    |        kvm_vcpu_init(); /* ret=0xfffffffb */
> >  3)   0.323 us    |        free_vpid.part.89(); /* ret=0x1 */
> >  3)   9.985 us    |        kmem_cache_free(); /* ret=0x80000000 */
> >  3)   9.491 us    |        kmem_cache_free(); /* ret=0x80000000 */
> >  3) + 69.858 us   |      } /* ret=0xfffffffffffffffb/-5 */
> >  3) + 70.631 us   |    } /* ret=0xfffffffffffffffb/-5 */
> >  3)               |    mutex_lock() {
> >  3)               |      _cond_resched() {
> >  3)   0.199 us    |        rcu_all_qs(); /* ret=0x80000000 */
> >  3)   0.594 us    |      } /* ret=0x0 */
> >  3)   1.067 us    |    } /* ret=0x0 */
> >  3)   0.337 us    |    mutex_unlock(); /* ret=0xffff8880738ed040 */
> >  3) + 92.730 us   |  } /* ret=0xfffffffffffffffb/-5 */

-- 
Cheers,
Changbin Du

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
