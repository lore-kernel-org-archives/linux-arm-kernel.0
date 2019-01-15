Return-Path: <SRS0=3lKL=PX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04287C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 00:40:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C63F120657
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 00:40:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="XAJRKh74";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rFzq3jSW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C63F120657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=la3KB49Oe9oTZ1IzOPu7Eyr0AU+uI53TLqinDfEcjRQ=; b=XAJRKh74bBFkL4
	G1XHadSoqtRfB5qRiQzCof4hxjsUaGG9j5K8dIr5lxm1PjujLDMBAjAGrTBHyOF1Ouwe5XUxcKKxY
	XcSdIhLHcQja4W7ZO3E4KnXF46DCYe622PVfEraJnV2WIUD9Dq+wURucFh9HD4IchMWw/bC18guNw
	Nqm8Re+x2X7x4RLtCgAwQNFuwUGEUmegt8e9b4qFw8RNiDLX5dpbmXiYR+pMyFlN1/vzoK4ck47pc
	L1uiWyWMv6qlaBBR2d/8U1UrE89RqwgUvM/ssJmfbAEVAxKokdUzNFZSdYkPZO88LbzBkZdOhcXIh
	bOEeHNPzUwYGamrnsUdQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjCm7-0001iu-6a; Tue, 15 Jan 2019 00:40:15 +0000
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjCm3-0001iU-OD
 for linux-arm-kernel@lists.infradead.org; Tue, 15 Jan 2019 00:40:13 +0000
Received: by mail-pf1-x442.google.com with SMTP id i12so421748pfo.7
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 14 Jan 2019 16:40:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=KYdEe7mCbCLkq6/hMQNg7hfiL2DeDnOSEiu87HS7RTE=;
 b=rFzq3jSWMUUh19/zwgJFGyUS+zuCcqgv7uRUyqaAvh7G3T9rysLqbxg+0Wj1e/6lhK
 JVDYdXv1K6asf9OQlRagqAHhIcT53GDxtYclhZeXmYtE0fixpqXQQqcP4GrCbS1TOgxR
 97hf+Ov33hIixs2PlTP0Yq7zUpxlyX69JdnaaUf1ShvngsZ5rspfaDVhTwPSs5VmcLIh
 ntcxvDKxTRGxkeoa5vW+UDt3y/jU6DBkWm9D1ch8l3nJfWWNQWaAlbvfhrvQxR+F8ttQ
 86bMwP2gOU2fQGfgan8WCOBQFXUXo9PYrssqXboE98cPwoeTVBMp+NB1IoyDrpCfCpNG
 CRwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=KYdEe7mCbCLkq6/hMQNg7hfiL2DeDnOSEiu87HS7RTE=;
 b=Myolu9JPSG0LXAfYJwLl5wd6yoZMWSfMq40LZMaIICLXRRcer2/BYiWrmH6AzLIij9
 46bHoRiv0jTJ1xsInyQ6JSrehb/SRZXKgBFKUJ73vIEgNkI31YXqoiiR1TjgXjWlFpzb
 5t4BDM3NODQDFoFyZgCKz+V8C38pxf6OUZln4ihDF8duqpnPnx6G3fpI29syO6DeQDkB
 ZYBkkppk22b5j1mSYzb7XnMh7nkPit62zWsAAknHWFM2DUjjodivWI4yzw5zRC4qFWpw
 2D8lRAXqrP8x8ZjqVdxqgsNC7FOi7m9psT07Eby3meDXcM1ZRWuG0dSoy+Zq7nxjwfKF
 4M/Q==
X-Gm-Message-State: AJcUukdHTeQ/xPQost+CkeMc58G2PZh7kIuhjPDB/+cl8Db2NMMX2WUh
 VrlzxGk/OGANuiJsYJHIUCY=
X-Google-Smtp-Source: ALg8bN6ItbUo+xZlAQ5lQzc/bCN/gsW4B/u0qepCmTUquTg7JDHPUspxYxjq0dzN90Hr+Gu8Dpzsvg==
X-Received: by 2002:a63:5455:: with SMTP id e21mr1209256pgm.316.1547512810746; 
 Mon, 14 Jan 2019 16:40:10 -0800 (PST)
Received: from mail.google.com ([207.246.99.41])
 by smtp.gmail.com with ESMTPSA id w23sm1794966pgc.72.2019.01.14.16.40.06
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 14 Jan 2019 16:40:10 -0800 (PST)
Date: Tue, 15 Jan 2019 08:40:02 +0800
From: Changbin Du <changbin.du@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] fgraph: record function return value
Message-ID: <20190115004001.hm4arwq5oxhr6up5@mail.google.com>
References: <20190112065701.30841-1-changbin.du@gmail.com>
 <20190114112115.1cbf21c0@gandalf.local.home>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190114112115.1cbf21c0@gandalf.local.home>
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190114_164011_820945_5F1EE0ED 
X-CRM114-Status: GOOD (  22.93  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, linux-doc@vger.kernel.org,
 x86@kernel.org, linux-kernel@vger.kernel.org,
 Matthew Wilcox <willy@infradead.org>, linux@armlinux.org.uk,
 linux-arm-kernel@lists.infradead.org, Changbin Du <changbin.du@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Steven,
On Mon, Jan 14, 2019 at 11:21:15AM -0500, Steven Rostedt wrote:
> On Sat, 12 Jan 2019 14:57:01 +0800
> Changbin Du <changbin.du@gmail.com> wrote:
> 
> > This patch adds a new trace option 'funcgraph-retval' and is disabled by
> > default. When this option is enabled, fgraph tracer will show the return
> > value of each function. This is useful to find/analyze a original error
> > source in a call graph.
> > 
> > One limitation is that kernel doesn't know the prototype of functions. So
> > fgraph assumes all functions have a retvalue of type int. You must ignore
> > the value of *void* function. And if the retvalue looks like an error code
> > then both hexadecimal and decimal number are displayed.
> > 
> > In this patch, only x86 and ARM platforms are supported.
> > 
> > Here is example showing the error is caused by vmx_create_vcpu() and the
> > error code is -5 (-EIO).
> > 
> > with echo 1 > /sys/kernel/debug/tracing/options/funcgraph-retval
> > 
> >  3)               |  kvm_vm_ioctl() {
> >  3)               |    mutex_lock() {
> >  3)               |      _cond_resched() {
> >  3)   0.234 us    |        rcu_all_qs(); /* ret=0x80000000 */
> >  3)   0.704 us    |      } /* ret=0x0 */
> >  3)   1.226 us    |    } /* ret=0x0 */
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
> > 
> > Signed-off-by: Changbin Du <changbin.du@gmail.com>
> > ---
> >
> 
> Hi Changbin,
> 
> I'm rewriting a lot of the function graph tracer code to have
> kretprobes be able to work on top of it. It's still a work in progress.
> It would be easier to add something to that work when its done than to
> do it now.
> 
I cann't wait to see it! I can rebase my cheanges after your work. Thanks!

> Thanks!
> 
> -- Steve

-- 
Cheers,
Changbin Du

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
