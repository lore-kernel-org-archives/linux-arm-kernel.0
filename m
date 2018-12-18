Return-Path: <SRS0=e5Gl=O3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50D4BC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 13:32:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2045521872
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 13:32:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Iakbax/e";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="sPlCvfML"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2045521872
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=D/++ZT1kwxQ0NF1y4rPwXsfQwMckKmneUsaXlDTHxZs=; b=Iakbax/eONMGJd
	xH8s0LMSsBQZ02ISDIzT3gZ9OZlYCajBostZFMMq+rbbPo47w6aWmqHgx1Q3hUHZhWmKh/J9X6WjA
	w2M3UqI+h8gH7wjE8Znwcx08Bkx37HMLq427NfpMgYbnqlDBqhvqCMyQ9RJztsFmdbt8ASeNrPxeQ
	eL1r/eQUjIz1qdKWCGidavO+KUcjUaWbQ+l/CzV7fww/vSD7fWl254mTHFUdOKCGnuZsr0awmLj3r
	sa9QJ06VnHHFVjB6bfZ5Oe28FzSMPcLDN1ckgowhOaJUOksEPQBDanGSFC0N6VF2sMbbGHODsuxfM
	yBT0yFPPmkWdVWkJPhvQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZFTd-0000bs-V3; Tue, 18 Dec 2018 13:32:01 +0000
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZFTb-0000ZQ-7g
 for linux-arm-kernel@lists.infradead.org; Tue, 18 Dec 2018 13:32:00 +0000
Received: by mail-pf1-x443.google.com with SMTP id y126so8153490pfb.4
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 18 Dec 2018 05:31:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=h86N0lQF/Ig6ovkqWBcT1Ptx1emyXtcvgQtnEfD7pfE=;
 b=sPlCvfMLVbvOGvRmjIW74DD0y2VL1C2eFWGnGubSq9KW1xkb/nWs6ncO7SEGWLRap9
 HeJj6vu+f3NESKHkonRKNkVwk7/a2vwQLSqUOyuy/7JewrG8QLMA4g7L7eboTJ5MOjuw
 uQ0scx3+jzQ/NJZNAuEC2eQjpQcsy8iTW4+6jukLsfbIuc3B5Wdf6rewdeY8mDdiddg0
 MGGKMpxC2NzZwf0R4z2j5bXRASxaU/uxCP8PWGn6G2nWHtXNdKUit5vcUgEMDFEqWm90
 swsmcyTvqwnx1VlFw0xpNBhfE4KpZBaCgAYy6r8lf1IFdsBBo+xas2+uwSjZy+5L7pST
 GQqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=h86N0lQF/Ig6ovkqWBcT1Ptx1emyXtcvgQtnEfD7pfE=;
 b=VotbgaOLNb5+V7iPol1TJ6P4sLVo90bi6ueUCw+cU9eeR7AH9wdn8aoZ1hz3cnhuE1
 bC8pEecjWvJokmnYAruUNMYhHnX6iwuS02+X9MzyXluOLuyIPs3NHeimaBgJTV61IJEG
 iOMYaRWQv4tETv7PN9nyiAzc7giQafj/i7peYVKy80oTLcLaFT1t9j8QRvPTwRipVV5j
 oLyNvHsw+wjDI2AROOaQznRlc73F0CFfkhMyfU1ut9PjmRYtU5cX3rfJ5is6X9jkNRNe
 zRwlY7MBNp2wdlFqBWe+SzW727nCFqsDtYmqM74H0tmvzEXdhZggcoQujQmAz2CdoP7y
 X8Wg==
X-Gm-Message-State: AA+aEWaw+x4bXDSccRO+HxM0jyL3y4ItSgq+GHtQ6WCUHWeNhhhS9Uq5
 JLL978U9yi3qIyG71wJujpruDHyrOR0W2mMIYIcC7A==
X-Google-Smtp-Source: AFSGD/V1y6RmJq++xX3WVMmh9McpQSeGS8sVPblnd2Z0tV/Kjgr0Yw2uYDMO66qXbrbv2zeRDPz0TU7hojM4U8P6vj4=
X-Received: by 2002:a62:1c86:: with SMTP id c128mr1807442pfc.54.1545139908555; 
 Tue, 18 Dec 2018 05:31:48 -0800 (PST)
MIME-Version: 1.0
References: <cover.1544099024.git.andreyknvl@google.com>
 <bda78069e3b8422039794050ddcb2d53d053ed41.1544099024.git.andreyknvl@google.com>
 <2bf7415e-2724-b3c3-9571-20c8b6d43b92@arm.com>
 <CAAeHK+xc6R_p26-tu--9W1L1PvUAFb70J23ByiEukKz3uVC3EQ@mail.gmail.com>
 <b99b331d-22ca-b9db-8677-4896c427ef10@arm.com>
 <CAAeHK+w2jppKbb26bBk6uP9ydZeHrtNc6b2CVv4xbvt6ecVooA@mail.gmail.com>
 <20181217123847.492b9ae4934bd0d95b0bbbdc@linux-foundation.org>
In-Reply-To: <20181217123847.492b9ae4934bd0d95b0bbbdc@linux-foundation.org>
From: Andrey Konovalov <andreyknvl@google.com>
Date: Tue, 18 Dec 2018 14:31:37 +0100
Message-ID: <CAAeHK+yiGcu4u7rvugfY7wGUiHug7C1wvSuygXN6L5-wWMHtyw@mail.gmail.com>
Subject: Re: [PATCH v13 19/25] kasan: add hooks implementation for tag-based
 mode
To: Andrew Morton <akpm@linux-foundation.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181218_053159_278182_AE3DAFD9 
X-CRM114-Status: GOOD (  17.17  )
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 Kate Stewart <kstewart@linuxfoundation.org>,
 "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 Paul Lawrence <paullawrence@google.com>,
 Linux Memory Management List <linux-mm@kvack.org>,
 Alexander Potapenko <glider@google.com>,
 Chintan Pandya <cpandya@codeaurora.org>, Christoph Lameter <cl@linux.com>,
 Vincenzo Frascino <vincenzo.frascino@arm.com>, Ingo Molnar <mingo@kernel.org>,
 Jacob Bramley <Jacob.Bramley@arm.com>, Jann Horn <jannh@google.com>,
 Mark Brand <markbrand@google.com>, kasan-dev <kasan-dev@googlegroups.com>,
 linux-sparse@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Andrey Ryabinin <aryabinin@virtuozzo.com>, Dave Martin <dave.martin@arm.com>,
 Evgenii Stepanov <eugenis@google.com>, Vishwath Mohan <vishwath@google.com>,
 Arnd Bergmann <arnd@arndb.de>,
 Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
 Marc Zyngier <marc.zyngier@arm.com>,
 Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
 Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
 Mike Rapoport <rppt@linux.vnet.ibm.com>, Dmitry Vyukov <dvyukov@google.com>,
 Kostya Serebryany <kcc@google.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Nick Desaulniers <ndesaulniers@google.com>,
 LKML <linux-kernel@vger.kernel.org>,
 "Eric W . Biederman" <ebiederm@xmission.com>, Lee Smith <Lee.Smith@arm.com>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Dec 17, 2018 at 9:38 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Mon, 17 Dec 2018 20:33:42 +0100 Andrey Konovalov <andreyknvl@google.com> wrote:
>
> > > Curiosity, did you try your patches with SLUB red zoning enabled?
> > > Since the area used for the Redzone is just after the payload, aligning the
> > > object_size independently from the allocator could have side effects, at least
> > > if I understand well how the mechanism works.
> > >
> > > Setting ARCH_SLAB_MINALIGN should avoid this as well.
> > >
> > > What do you think?
> >
> > Sounds good to me.
> >
> > Andrew, how should proceed with this? Send another fixup patch or
> > resend the whole series?
>
> It depends on how extensive the changes are.  I prefer a fixup, but at
> some point it's time to drop it all and start again.

The fixup in only a few lines, so I just sent it as a separate patch
named "[PATCH mm] kasan, arm64: use ARCH_SLAB_MINALIGN instead of
manual aligning".

Thanks!

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
