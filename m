Return-Path: <SRS0=7dGx=OX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8F27C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 16:15:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35EEF206E0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 16:15:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="MhaG1l/I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35EEF206E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=InZo9MWnJI9t8JsbzeGkTVXjrXtlqW61ipqA1cZRmWQ=; b=MhaG1l/Incst4N
	sXNUFJUMj/I1a95cQaNb1iKmSwZKEFC27t3/qZBj1ap3EJ3GVUKb9o0P+ENVHLAPb0O+m9S67SU5u
	AAAMbkindbfnJVxWR9tzsiX2MaoJnd7Q8HHSabH8fcY0P+ZdEArp01Hcp3u8m5GAn2VPFEGBH5mW2
	MWSGsnCa/Roz50ha7nqGl27c0cSo5LS9nYx6itiqhjA/H7tckIXybvpJoMpEsCN5XcSiAyxY1zLGu
	ifuQyh1mqD2sGfEsTLVZJMtvwIxmk3gT9Em02pTHPT25bNDojJgw6SVMnO22VmlskgeQG0syxpDMM
	2I7fyj7HfArNBbhwCfzA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXq7d-0004XY-BP; Fri, 14 Dec 2018 16:15:29 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXq7a-0004UW-EE
 for linux-arm-kernel@lists.infradead.org; Fri, 14 Dec 2018 16:15:27 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F12AB1688
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 14 Dec 2018 08:15:15 -0800 (PST)
Received: from mail-it1-f173.google.com (usa-sjc-mx-foss1.foss.arm.com
 [217.140.101.70])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DAE213F71A
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 14 Dec 2018 08:15:15 -0800 (PST)
Received: by mail-it1-f173.google.com with SMTP id g76so9596891itg.2
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 14 Dec 2018 08:15:15 -0800 (PST)
X-Gm-Message-State: AA+aEWZO3Yyo8iYsR22OMzdRY5lHEnWkdTrrQ/fsgRub6yJ1KWCTPf0X
 WFH+e/2MBwrpt09oThRb1++rRbv+MKrnDbyRz40=
X-Google-Smtp-Source: AFSGD/W1U8WKPpzXkNKjzyJ5vjP5WDuoq5P5vTP0WMl2qSI/rxc14jl4TicOIGmW0nVNpzbQOC/772TOccjClWd71wc=
X-Received: by 2002:a24:3555:: with SMTP id k82mr3746465ita.84.1544804114998; 
 Fri, 14 Dec 2018 08:15:14 -0800 (PST)
MIME-Version: 1.0
References: <20181130162015.83FE767357@newverein.lst.de>
 <CADGdYn46uQWfoDmRjk1OFj9fYXYbC669Ar=oVtnx141HcMFr8w@mail.gmail.com>
 <20181214094714.GA30043@lst.de>
In-Reply-To: <20181214094714.GA30043@lst.de>
From: Amit Daniel Kachhap <amit.kachhap@arm.com>
Date: Fri, 14 Dec 2018 21:45:03 +0530
X-Gmail-Original-Message-ID: <CADGdYn69reXed-DBMTCezNyNEgKn-h0NA-D6dnoRrJx2_bE71Q@mail.gmail.com>
Message-ID: <CADGdYn69reXed-DBMTCezNyNEgKn-h0NA-D6dnoRrJx2_bE71Q@mail.gmail.com>
Subject: Re: [PATCH v5] arm64: implement ftrace with regs
To: duwe@lst.de
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181214_081526_481851_1ED0E002 
X-CRM114-Status: GOOD (  20.94  )
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

Hi,
On Fri, Dec 14, 2018 at 3:18 PM Torsten Duwe <duwe@lst.de> wrote:
>
> On Thu, Dec 13, 2018 at 11:01:38PM +0530, Amit Daniel Kachhap wrote:
> > On Fri, Nov 30, 2018 at 9:53 PM Torsten Duwe <duwe@lst.de> wrote:
> >
> > Hi Torsten,
> >
> > I was testing your patch and it seems to work fine for function trace. However
> > function graph trace seems broken. Is it work in progress ? or I am
> > missing something.
>
> What did you base your tests on, you didn't specify?
> OTOH neither did I ;-) I precluded all addressees had the full picture.
>
> Precisely, I basically start with 4.19, but 4.20-rc shouldn't make a
> difference. BUT...
>
> > > [Changes from v4]
> > >
> > > * include Ard's feedback and pending changes:
> > >   - ADR/ADRP veneers
> > >   - ftrace_trampolines[2]
> > >   - add a .req for fp, just in case
> " [PATCH 1/2] arm64/insn: add support for emitting ADR/ADRP instructions "
> <20181122084646.3247-2-ard.biesheuvel@linaro.org> et.al, esp:
> Git-commit: bdb85cd1d20669dfae813555dddb745ad09323ba
>
> > >   - comment on the pt_regs.stackframe[2] mapping
> > > * include Mark's ftrace cleanup
> > >   - GLOBAL()
> > >   - prepare_ftrace_return(pc, &lr, fp)
> > >
> " [PATCH 1/6] linkage: add generic GLOBAL() macro "
> <20181115224203.24847-2-mark.rutland@arm.com> et.al., esp:
> Git-commit: 7dc48bf96aa0fc8aa5b38cc3e5c36ac03171e680
>
> change the API this patch set relies on. AFAIU they are on their way into
> mainline so I updated v5 accordingly. If you don't have these, just use v4;
> the other changes are only for compatibility and cosmetics.

Sorry I didn't mention my environment. I am using 4.20-rc3 and it has
all the above 8 extra patches
mentioned by you.
I read your change description in v3 patchset. You had mentioned there
that graph caller
is broken.

//Amit
>
> HTH,
>         Torsten
>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
