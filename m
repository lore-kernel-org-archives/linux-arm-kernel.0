Return-Path: <SRS0=sCCJ=QS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ACF8C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 12:16:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCBBB218D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 12:16:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="V+HUgv/i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCBBB218D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=tHZ71FaLaCfZWkxZWHMlz34P+kQrvC2IU7J0h2chR8I=; b=V+HUgv/ibo9rFJ
	3mcXB9iD3QAIdBvml99zYR8XPQ8qVvTmUka0xP8aMFQMWP3e3HHDNeL9z9ue8GPmQffugV0K956Oa
	0/ddAdzC//nPvT/xnhvM3v3A0FnjqS3bOIN38adXMMPVwrdIw32fXxcohz56ET0GLylVKnpRAkN8u
	yceS50jLMQtlaQv46KX+adVRqaDqIk8zEz3th3i4vR8tSGeILZjrtdDENeH8DgluBHk1eJDk9bSuJ
	0rZKQWTrcKUL6G6mDUCZFXm6ZRWCrjkM45ist/2JWdky5z3OHq74rCjFLkVh4hSG8IldQv5ExQmTM
	cyISgy1GOf2PZjyWVHXQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtAVI-0003BW-Cu; Mon, 11 Feb 2019 12:16:04 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtAVF-0003BB-0S
 for linux-arm-kernel@lists.infradead.org; Mon, 11 Feb 2019 12:16:02 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 49AA980D;
 Mon, 11 Feb 2019 04:16:00 -0800 (PST)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.78])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id
 C41B23F557; Mon, 11 Feb 2019 04:15:58 -0800 (PST)
Date: Mon, 11 Feb 2019 12:15:56 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Andrey Konovalov <andreyknvl@google.com>
Subject: Re: CONFIG_KASAN_SW_TAGS=y not play well with kmemleak
Message-ID: <20190211121554.GB165128@arrakis.emea.arm.com>
References: <b1d210ae-3fc9-c77a-4010-40fb74a61727@lca.pw>
 <CAAeHK+yzHbLbFe7mtruEG-br9V-LZRC-n6dkq5+mmvLux0gSbg@mail.gmail.com>
 <89b343eb-16ff-1020-2efc-55ca58fafae7@lca.pw>
 <CAAeHK+zxxk8K3WjGYutmPZr_mX=u7KUcCUYXHi+OgRYMfcvLTg@mail.gmail.com>
 <d8cdc634-0f7d-446e-805a-c5d54e84323a@lca.pw>
 <59db8d6b-4224-2ec9-09de-909c4338b67a@lca.pw>
 <CAAeHK+wsULxYXnGJnQXx9HjZMiU-5jb5ZKC+TuGQihc9L386Xg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAAeHK+wsULxYXnGJnQXx9HjZMiU-5jb5ZKC+TuGQihc9L386Xg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190211_041601_058834_D768DC21 
X-CRM114-Status: UNSURE (   9.45  )
X-CRM114-Notice: Please train this message.
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
Cc: Qian Cai <cai@lca.pw>, kasan-dev <kasan-dev@googlegroups.com>,
 Linux-MM <linux-mm@kvack.org>, Alexander Potapenko <glider@google.com>,
 Dmitry Vyukov <dvyukov@google.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Feb 08, 2019 at 06:15:02PM +0100, Andrey Konovalov wrote:
> On Fri, Feb 8, 2019 at 5:16 AM Qian Cai <cai@lca.pw> wrote:
> > Kmemleak is totally busted with CONFIG_KASAN_SW_TAGS=y because most of tracking
> > object pointers passed to create_object() have the upper bits set by KASAN.
> 
> Yeah, the issue is that kmemleak performs a bunch of pointer
> comparisons that break when pointers are tagged.

Does it mean that the kmemleak API receives pointer aliases (i.e. same
object tagged with different values or tagged/untagged)?

-- 
Catalin

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
