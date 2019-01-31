Return-Path: <SRS0=sKCI=QH=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41E7DC282D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 03:37:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15F82218AC
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 03:37:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="n5/dKwyc";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="jYoakLSX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15F82218AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=hsbaTxeanu+I+vfGRJK0fH0LDmomdTsaUe8cNXAQZkI=; b=n5/dKwycAA28hH
	SwbddZuBxs1namYXKCnouuWZqUp5mVQF1ZNLDHJz+U12cAGsvrl1LhCMIc+qduK1oxbP0To6bjaPG
	ksXfK+hM26wRPpMXoKqNCLSmJ12tSyjaa9k1DXn/j9VEv8HSWgXZj3I4SfUn5UZlOsFYo1pwBwdMy
	czWCAw2pa42oVVMHgmgiINEC+RKDky8OpvghIYrpxZF1oznvEWUTvgdl8Be9BC3oyqnrj8s9UgELU
	NAcgy+tXWpq/4Q1KYMrUcyeAowK2Zqedg5bxMBZFbzfBIQe3BuERtBMQEKlHFNP3Lx3vVIZmjVBtm
	6uCsDkdv80qt3U88pEfw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gp3Ao-0001KO-2E; Thu, 31 Jan 2019 03:37:54 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gp3Ak-0001K1-Fa
 for linux-arm-kernel@lists.infradead.org; Thu, 31 Jan 2019 03:37:51 +0000
Received: from sol.localdomain (c-107-3-167-184.hsd1.ca.comcast.net
 [107.3.167.184])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id D27132070C;
 Thu, 31 Jan 2019 03:37:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1548905869;
 bh=Dmgi66vQgQ7yUKTRSzSzUpl7LyI7r0hsGU61xwmThtg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=jYoakLSXh2XdF7gcVPFlLwzorJAedNTa5K6UdzVj1sKjm6Xajs+Ar2apkKG1TyHeE
 +oygArFD1RBHEMtucuQsJNCqTz6y+i13phrEkgeVRAeNL+Snq8P0/RrXgFSVd2q3vu
 pZU7NxuSDnDQG4b40OIFfczBF9pBCkMrqhtOKDMo=
Date: Wed, 30 Jan 2019 19:37:47 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: Re: [PATCH v3 0/3] crypto: crct10dif assembly cleanup and
 optimizations
Message-ID: <20190131033746.GA661@sol.localdomain>
References: <20190130031444.28935-1-ebiggers@kernel.org>
 <CAKv+Gu95j-ZJC7vbUzJKqNczht1cjgx09sBiSRcwg+qn-HtXew@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAKv+Gu95j-ZJC7vbUzJKqNczht1cjgx09sBiSRcwg+qn-HtXew@mail.gmail.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_193750_554921_F2C8C9E3 
X-CRM114-Status: GOOD (  26.90  )
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
Cc: Tim Chen <tim.c.chen@linux.intel.com>,
 "open list:HARDWARE RANDOM NUMBER GENERATOR CORE"
 <linux-crypto@vger.kernel.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 Herbert Xu <herbert@gondor.apana.org.au>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Jan 30, 2019 at 09:33:57AM +0100, Ard Biesheuvel wrote:
> On Wed, 30 Jan 2019 at 04:15, Eric Biggers <ebiggers@kernel.org> wrote:
> >
> > The x86, arm, and arm64 asm implementations of crct10dif are very
> > difficult to understand partly because many of the comments, labels, and
> > macros are named incorrectly: the lengths mentioned are usually off by a
> > factor of two from the actual code.  Many other things are unnecessarily
> > convoluted as well, e.g. there are many more fold constants than
> > actually needed and some aren't fully reduced.
> >
> > This series therefore cleans up all these implementations to be much
> > more maintainable.  I also made some small optimizations where I saw
> > opportunities, resulting in slightly better performance.
> >
> > This is based on top of the pending patches from Ard Biesheuvel.
> >
> > These all pass the new extra self-tests.
> >
> 
> Hi Eric,
> 
> As a FYI, the issue that broke ARM and arm64 with your updated
> selftests was the 1 byte length special case that you also have
> special handling for in the x86 version (but while fixing that, I
> noticed my version was reading beyond the end of the input). I think
> it hardly matters, though, given the way T10-DIF appears to be used in
> practice (disk blocks), although it is hard to be sure from reading
> the code, and the algo should be correct in any case.

Yes, on second thought I'm thinking the len < 16 support in the x86 assembly
isn't worthwhile.  Actually it's much slower than the generic table-based code
on those lengths due to the overhead of kernel_fpu_begin().  And even if
kernel_fpu_begin() were free, the generic code is faster until about len=11.

There's a theoretical niceness to using pclmul for all lengths so that no table
is needed.  But we still need the table for the !irq_fpu_usable() case anyway.

So I'll drop the len < 16 case.

> 
> So what remains is the way these implementations are encapsulated by
> the crct10dif() library function, which is raster nasty, making
> CRC-T10DIF an excellent use case to discuss whether we can make any
> improvements to address some of the concerns that were also raised in
> the zinc discussion. I threw some code together a while ago [0] (and
> posted it as well, IIRC). In the mean time, a 'static call'
> infrastructure is being proposed that could be used in a similar way
> to avoid function pointers. I'm also interested in hearing opinions on
> whether the indirect call overhead is actually significant in use
> cases such as this one.
> 

I agree that lib/crc-t10dif.c is very ugly, and we need to find a better way to
provide simple crypto library functions.  But I'm not sure how to make everyone
happy.  I actually think the Zinc approach of centrally dispatching to all the
software implementations of each algorithm (with one module per algorithm rather
than one per implementation) is fine for the vast majority of users.  So maybe
we should just go with that along with per-implementation knobs so that users
can still disable unwanted implementations at build or boot time if they want.

E.g., CONFIG_ZINC_CHACHA would be a module that has all the software ChaCha
implementations for the architecture.  But people building the kernel who do not
want or need, say, the NEON implementation could unset the bool
CONFIG_ZINC_CHACHA_NEON to exclude it from the zinc_chacha module at build time.
Alternatively, users with a precompiled kernel who don't want to use the NEON
implementation despite their CPU supporting it could set zinc_chacha.neon=0 on
the kernel command line (when CONFIG_ZINC_CHACHA=y) or when loading the
zinc_chacha module (when CONFIG_ZINC_CHACHA=m).

- Eric

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
