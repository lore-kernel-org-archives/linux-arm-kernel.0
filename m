Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B271DC5CFFE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:01:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80728205C9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:01:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="BVkt2LTR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80728205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=T9/iOyfN4qMbOjYNIf6s2yNDQBtjIyV8i9JLE30jEWw=; b=BVkt2LTRqYlXPG
	r9LQF9QK33KyMPVW1XRLSY3kxvRQUI4sy5XLX123su20lKKKFF1nLD9XGm08y6/BxdQ23XQ9oSn5c
	BNSzQ44GVeC1JWCLw0Yt4AR5JkngZsq5GrBFlQyF8+j9hSa0fRystOqPQ0S8n5A2XMteCasBG5GI6
	n1wh0MhbaQ/YRL2e6NbyWDE5b6NwWGSUtMVdTMETqcFJ20mVNoa2CknLbxY2dKhk36EjFoWwQYqyK
	/87PnnJSWyxvuDCoMle2EQ7xULMBbRpPnu6lpy7H50QOst27Box+4F63xPGEIjmlq6jGrGaSs9LDD
	jw7pdBGoe9LGY2OrteSA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWkTW-0000jV-Bx; Tue, 11 Dec 2018 16:01:34 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWkS8-0007lG-Cr
 for linux-arm-kernel@lists.infradead.org; Tue, 11 Dec 2018 16:00:14 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 759BE1596;
 Tue, 11 Dec 2018 07:59:56 -0800 (PST)
Received: from edgewater-inn.cambridge.arm.com
 (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 438C33F575;
 Tue, 11 Dec 2018 07:59:56 -0800 (PST)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
 id 4F95A1AE0CFD; Tue, 11 Dec 2018 16:00:19 +0000 (GMT)
Date: Tue, 11 Dec 2018 16:00:19 +0000
From: Will Deacon <will.deacon@arm.com>
To: Andrey Konovalov <andreyknvl@google.com>, akpm@linux-foundation.org
Subject: Re: [PATCH v13 00/25] kasan: add software tag-based mode for arm64
Message-ID: <20181211160018.GA12597@edgewater-inn.cambridge.arm.com>
References: <cover.1544099024.git.andreyknvl@google.com>
 <20181211151829.GB11718@edgewater-inn.cambridge.arm.com>
 <CAAeHK+xxNsOfaUZhcErc+fjEEv0YZ-dbQ0fTXzQUO4dZbM-GgA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAAeHK+xxNsOfaUZhcErc+fjEEv0YZ-dbQ0fTXzQUO4dZbM-GgA@mail.gmail.com>
User-Agent: Mutt/1.11.1+30 (d10eec459b35) ()
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_080008_797391_F59801E4 
X-CRM114-Status: GOOD (  21.16  )
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
 Catalin Marinas <catalin.marinas@arm.com>,
 Paul Lawrence <paullawrence@google.com>,
 Linux Memory Management List <linux-mm@kvack.org>,
 Alexander Potapenko <glider@google.com>,
 Chintan Pandya <cpandya@codeaurora.org>, Christoph Lameter <cl@linux.com>,
 Ingo Molnar <mingo@kernel.org>, Jacob Bramley <Jacob.Bramley@arm.com>,
 Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>, Mark Brand <markbrand@google.com>,
 kasan-dev <kasan-dev@googlegroups.com>, linux-sparse@vger.kernel.org,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Andrey Ryabinin <aryabinin@virtuozzo.com>, Dave Martin <dave.martin@arm.com>,
 Evgenii Stepanov <eugenis@google.com>, Vishwath Mohan <vishwath@google.com>,
 Arnd Bergmann <arnd@arndb.de>,
 Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
 Marc Zyngier <marc.zyngier@arm.com>,
 Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
 Mike Rapoport <rppt@linux.vnet.ibm.com>, Dmitry Vyukov <dvyukov@google.com>,
 Kostya Serebryany <kcc@google.com>, Jann Horn <jannh@google.com>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Nick Desaulniers <ndesaulniers@google.com>,
 LKML <linux-kernel@vger.kernel.org>,
 "Eric W . Biederman" <ebiederm@xmission.com>, Lee Smith <Lee.Smith@arm.com>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

[moving akpm to To:]

On Tue, Dec 11, 2018 at 04:57:27PM +0100, Andrey Konovalov wrote:
> On Tue, Dec 11, 2018 at 4:18 PM Will Deacon <will.deacon@arm.com> wrote:
> > On Thu, Dec 06, 2018 at 01:24:18PM +0100, Andrey Konovalov wrote:
> > > This patchset adds a new software tag-based mode to KASAN [1].
> > > (Initially this mode was called KHWASAN, but it got renamed,
> > >  see the naming rationale at the end of this section).
> > >
> > > The plan is to implement HWASan [2] for the kernel with the incentive,
> > > that it's going to have comparable to KASAN performance, but in the same
> > > time consume much less memory, trading that off for somewhat imprecise
> > > bug detection and being supported only for arm64.
> >
> > For the arm64 parts:
> >
> > Acked-by: Will Deacon <will.deacon@arm.com>
> >
> > I assume that you plan to replace the current patches in -mm with this
> > series?
> >
> > Cheers,
> >
> > Will
> 
> Hi Will,
> 
> Yes, that was the intention of sending v13. Should have I sent a
> separate patch with v12->v13 fixes instead? I don't know what's the
> usual way to make changes to the patchset once it's in the mm tree.

No, I was just checking that the intention was for akpm to pick this up in
preference to the old stuff! That works for me, and the minor conflict with
arm64 in next was already resolved by Stephen.

Will

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
