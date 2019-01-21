Return-Path: <SRS0=flTa=P5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C379EC282F6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 08:55:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 952602084A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 08:55:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="XorrTqn1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 952602084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=CZeVzR9Qr4Gu3gQ7WAh+Izn0oGFOKi/CQbI207E6tc4=; b=XorrTqn1a1qBHe
	oqezg8kx5JT3mzc15IU6pyotP9xwkr3Wurrtux7oy2lQJB37AlZ6cWhYvvcHQPoo8tEYiT23hiyL/
	4o1INNpfYO5MrAcH73XXdNMFmf1kqCgO0YOsp1EUvjL35K5rX2o8V+oAqdjLyFBgj8LaiNmRtu47s
	jIPwLoqa4D2Afrk8yoIkJuFzlfQNNBzlvo11Y3jaXLg3AOChl3d5g88jbilNWFzNmI4z9F9HwBxw9
	glHn0J1KdgpDWmhE515cMMTZxHsDtMsL1Hn1TIeXpBkY7+9JYc8YBBWoAqe0MRshTzHKyzpybIV8a
	q6v5WkQ6WUiIlZeIk69Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glVN6-00045b-Ee; Mon, 21 Jan 2019 08:55:56 +0000
Received: from mail-vs1-f66.google.com ([209.85.217.66])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glVN2-00045A-Qr
 for linux-arm-kernel@lists.infradead.org; Mon, 21 Jan 2019 08:55:54 +0000
Received: by mail-vs1-f66.google.com with SMTP id u11so12136797vsp.11
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 21 Jan 2019 00:55:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=kVAtAGarxS4wypP/3eT2eCQTmORwhs++L36a9mWKR3U=;
 b=hkEKJ/peW8nzcwCNki/rR1pijfU+oknCD6Eqs+1O9t4H4Ul+BQOtruvW3jg9IafU0+
 VcQbwOTh2+Lc+zl6j6uE1FkijJIqhTnvxLlmUemT02D7Nc3j4nkvFvKdNyRZ1IC5npwx
 UCsyvJCN0vbHU9bASdLEzCH2JkEA2E0G7UEYlCi7jU1ghIxUNHseuVnHHW49bKqBv6t1
 trMBPEVEJMP4AY0imvQJPmataN6Bi8LIcgujijS0ya+IzmhU47vmKk4rKIz3jID7ucCY
 2ZH5AJb1vMEZukMbgmSUaIXDKQt8aSmojDow7mlz9ecCONHhBlXhK5Mk0KVrvn/U/aSE
 07cA==
X-Gm-Message-State: AJcUukdYAaP4oRXtf9CKTzSb/Uzs56SaKYoCo/aAKwUKNN++PVWg6FU3
 9OzpGiZNircyK3KsDnh1oS4QQ082s0F8MxcJ3Bk=
X-Google-Smtp-Source: ALg8bN5Be0knSu5403sgnyKm3buMMWtoe1G93e4U+oAPSmiCzzcvAtemg3VTW+OqtwtQMKyCtP28wB0QbzIKsvryMUI=
X-Received: by 2002:a67:b60d:: with SMTP id d13mr12198772vsm.152.1548060951904; 
 Mon, 21 Jan 2019 00:55:51 -0800 (PST)
MIME-Version: 1.0
References: <20190118161835.2259170-1-arnd@arndb.de>
 <20190118161835.2259170-9-arnd@arndb.de>
In-Reply-To: <20190118161835.2259170-9-arnd@arndb.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 21 Jan 2019 09:55:38 +0100
Message-ID: <CAMuHMdUH+vJ89O6-Qm1p9r6h30z2ZRred1aQd6=h0sk6xXULMQ@mail.gmail.com>
Subject: Re: [PATCH v2 08/29] m68k: assign syscall number for seccomp
To: Arnd Bergmann <arnd@arndb.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190121_005552_866968_AC95FF91 
X-CRM114-Status: GOOD (  13.02  )
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
Cc: Rich Felker <dalias@libc.org>,
 "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
 Linux-sh list <linux-sh@vger.kernel.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Heiko Carstens <heiko.carstens@de.ibm.com>, linux-mips@vger.kernel.org,
 Max Filippov <jcmvbkbc@gmail.com>, netdev <netdev@vger.kernel.org>,
 Deepa Dinamani <deepa.kernel@gmail.com>, "H. Peter Anvin" <hpa@zytor.com>,
 sparclinux <sparclinux@vger.kernel.org>,
 Linux-Arch <linux-arch@vger.kernel.org>,
 linux-s390 <linux-s390@vger.kernel.org>,
 y2038 Mailman List <y2038@lists.linaro.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Helge Deller <deller@gmx.de>,
 the arch/x86 maintainers <x86@kernel.org>,
 Russell King <linux@armlinux.org.uk>, Ingo Molnar <mingo@redhat.com>,
 Firoz Khan <firoz.khan@linaro.org>, Catalin Marinas <catalin.marinas@arm.com>,
 Matt Turner <mattst88@gmail.com>, Fenghua Yu <fenghua.yu@intel.com>,
 Will Deacon <will.deacon@arm.com>,
 Linux FS Devel <linux-fsdevel@vger.kernel.org>,
 linux-m68k <linux-m68k@lists.linux-m68k.org>,
 Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Michal Simek <monstr@monstr.eu>, Tony Luck <tony.luck@intel.com>,
 Parisc List <linux-parisc@vger.kernel.org>,
 Linux API <linux-api@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Paul Burton <paul.burton@mips.com>,
 "Eric W. Biederman" <ebiederm@xmission.com>,
 alpha <linux-alpha@vger.kernel.org>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "David S. Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Jan 18, 2019 at 5:20 PM Arnd Bergmann <arnd@arndb.de> wrote:
> Most architectures have assigned a numbers for the seccomp syscall
> even when they do not implement it.
>
> m68k is an exception here, so for consistency lets add the number.
> Unless CONFIG_SECCOMP is implemented, the system call just
> returns -ENOSYS.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
