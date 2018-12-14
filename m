Return-Path: <SRS0=7dGx=OX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 851E9C67839
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 09:47:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5539A20866
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 09:47:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Kgk/2rPB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5539A20866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=CjBYbGwIQgji7bYfsNuMB+rOJz3gHf1bl/ImQxUW1fM=; b=Kgk/2rPBWJ65eg
	ELEGd16K+VZXJa3r2W4oc/yGdGq4JEBsMyjLSFpdFSew9wtiuZcWNGLijkQcz6djp3v3Vt8IQBxNK
	i/KKGY0Ji1LQuDC6waZURbNYnpF9yhuEs31N7s6rLc3Sc6q1ZReuRcexpaP3DXRs1fOJK/nXhEH1c
	2NnPfX2yFXLFGfuezr7lwDSv92H+72UrWit8QyIvfZgY9c540fXO+Egjremqv29M/Zj9Smt4UP8Ti
	boEPATiUGvjpK9gPuluN5HWzP9auhsZ3Tac9RaPb9kizhv4/vjsuxQ2CSIRQJkc7wypggTtRV71re
	5emfMAi15+stApqPN7Lw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXk4G-0007Sc-LM; Fri, 14 Dec 2018 09:47:36 +0000
Received: from verein.lst.de ([213.95.11.211] helo=newverein.lst.de)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXk4C-0007RN-Jb
 for linux-arm-kernel@lists.infradead.org; Fri, 14 Dec 2018 09:47:34 +0000
Received: by newverein.lst.de (Postfix, from userid 2005)
 id 192B468DDD; Fri, 14 Dec 2018 10:47:14 +0100 (CET)
Date: Fri, 14 Dec 2018 10:47:14 +0100
From: Torsten Duwe <duwe@lst.de>
To: Amit Daniel Kachhap <amit.kachhap@arm.com>
Subject: Re: [PATCH v5] arm64: implement ftrace with regs
Message-ID: <20181214094714.GA30043@lst.de>
References: <20181130162015.83FE767357@newverein.lst.de>
 <CADGdYn46uQWfoDmRjk1OFj9fYXYbC669Ar=oVtnx141HcMFr8w@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CADGdYn46uQWfoDmRjk1OFj9fYXYbC669Ar=oVtnx141HcMFr8w@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181214_014732_793949_47E09A5C 
X-CRM114-Status: GOOD (  14.83  )
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
Cc: Arnd Bergmann <arnd@arndb.de>, julien.thierry@arm.com,
 Catalin Marinas <catalin.marinas@arm.com>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>, Will Deacon <will.deacon@arm.com>,
 linux-kernel@vger.kernel.org, rostedt@goodmis.org, takahiro.akashi@linaro.org,
 mingo@redhat.com, jpoimboe@redhat.com, live-patching@vger.kernel.org,
 LAK <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Dec 13, 2018 at 11:01:38PM +0530, Amit Daniel Kachhap wrote:
> On Fri, Nov 30, 2018 at 9:53 PM Torsten Duwe <duwe@lst.de> wrote:
> 
> Hi Torsten,
> 
> I was testing your patch and it seems to work fine for function trace. However
> function graph trace seems broken. Is it work in progress ? or I am
> missing something.

What did you base your tests on, you didn't specify?
OTOH neither did I ;-) I precluded all addressees had the full picture.

Precisely, I basically start with 4.19, but 4.20-rc shouldn't make a
difference. BUT...

> > [Changes from v4]
> >
> > * include Ard's feedback and pending changes:
> >   - ADR/ADRP veneers
> >   - ftrace_trampolines[2]
> >   - add a .req for fp, just in case
" [PATCH 1/2] arm64/insn: add support for emitting ADR/ADRP instructions "
<20181122084646.3247-2-ard.biesheuvel@linaro.org> et.al, esp:
Git-commit: bdb85cd1d20669dfae813555dddb745ad09323ba

> >   - comment on the pt_regs.stackframe[2] mapping
> > * include Mark's ftrace cleanup
> >   - GLOBAL()
> >   - prepare_ftrace_return(pc, &lr, fp)
> >
" [PATCH 1/6] linkage: add generic GLOBAL() macro "
<20181115224203.24847-2-mark.rutland@arm.com> et.al., esp:
Git-commit: 7dc48bf96aa0fc8aa5b38cc3e5c36ac03171e680

change the API this patch set relies on. AFAIU they are on their way into
mainline so I updated v5 accordingly. If you don't have these, just use v4;
the other changes are only for compatibility and cosmetics.

HTH,
	Torsten


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
