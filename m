Return-Path: <SRS0=p0aQ=P2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EE7FC07EBF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 19:33:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C83320657
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 19:33:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="oSMA33Oc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C83320657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=az3q71Gh9Pi6YB09ME4z/NcQ/IS7o7SCA0l0+f9dIJM=; b=oSMA33OcjlMieP
	331P1UGvynCnuSV5WRkkdvoYgn5PGKxOyiO2jPjfLtwIpIJwIImGZn/4OioCiEnRxRSyfhrugj5Av
	Gm/QW10QSv4eNvhewGgHumNACov0lX5P2rncoLAlbrXDWvO12LLyVu/MxrN8btu0Qg/ZjwZaoADB+
	5dhZlv7ZFuBSmURvTuZ9M8aR1FxnRMwmf6KZ9vZZs/qLpL+rwaP1p5iK4uvJs1E0e9kkZzIKcIfx6
	66hVugBjxhqNcAM1G4uptAkllo7Lwe95s3k9NmDpRQCxsMsgtoQ0GEk2vm7k8AizTgOIH7YvXn+6S
	CrK+m+m1T9vmDpJuIsBA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkZtj-0004VO-5L; Fri, 18 Jan 2019 19:33:47 +0000
Received: from mail-qt1-f195.google.com ([209.85.160.195])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkZtf-0004UP-3U
 for linux-arm-kernel@lists.infradead.org; Fri, 18 Jan 2019 19:33:44 +0000
Received: by mail-qt1-f195.google.com with SMTP id l11so16566047qtp.0
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 18 Jan 2019 11:33:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ErLXt+4MLir6MBRid1biQgec4eSYhQQBJKNsrW9q3Fs=;
 b=A6MKywX24McNg/wWTP3n+HDlXlQiSgknQ74XhLNHebn+8HTTyEcA4CMk6KhtiDyGu3
 fEbMpk1yfwxH23WT676xIdOhsxarzJxNJC70HHBMiqYT7qVq7XGvmSonfklAPGRhol+m
 FZS+9Wj4IcOSHG1uD7GOXMHXnfFxVrTF6F6+PVARATR0y/WOBQaI9rTDPf6gAexlgPQ6
 kOy93vv/EbfO8u5pNJfAWB5XP+ew00lxSgWDvlh7BUv7n3GG1CzfoYc35E/Mjcsv63D9
 2CaN/N/TfmfIJHcMUTqyoUgUPGIRZBZVabU1Hb1cTgr0FV2utCAfdnmMBsfZGoOH+v/3
 zyoA==
X-Gm-Message-State: AJcUukfiVek0ZM3pZLzk1IjzC2rSOKjM7ekRg0TW1Z1WrxxSS3iKXOfU
 yL2YjvUe3xnv0oacbxcVFrPuu/WO1IzOK5PgokY=
X-Google-Smtp-Source: ALg8bN51ZSz8S/UEkmKkQ76yrnTrRmtVHEOrjwWqzHKH/uRWMtRP1y/XgFacGAOrjnX1tIv/Wxgb87NR61MktkAeKK4=
X-Received: by 2002:a0c:f50c:: with SMTP id j12mr16647911qvm.149.1547840021534; 
 Fri, 18 Jan 2019 11:33:41 -0800 (PST)
MIME-Version: 1.0
References: <20190118161835.2259170-1-arnd@arndb.de>
 <20190118161835.2259170-30-arnd@arndb.de>
 <CALCETrXqM5mhvwreN5y-9K99h1j9rs9MAVK-cNLC54s1fdHA6w@mail.gmail.com>
In-Reply-To: <CALCETrXqM5mhvwreN5y-9K99h1j9rs9MAVK-cNLC54s1fdHA6w@mail.gmail.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 18 Jan 2019 20:33:25 +0100
Message-ID: <CAK8P3a0V+xboaGAF2nqrYtpjXXA7y0LcvCKi4ngLTus1D_XZBA@mail.gmail.com>
Subject: Re: [PATCH v2 29/29] y2038: add 64-bit time_t syscalls to all 32-bit
 architectures
To: Andy Lutomirski <luto@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190118_113343_181703_DFB783FE 
X-CRM114-Status: GOOD (  14.48  )
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
Cc: Rich Felker <dalias@libc.org>, linux-ia64@vger.kernel.org,
 Linux-sh list <linux-sh@vger.kernel.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Heiko Carstens <heiko.carstens@de.ibm.com>, linux-mips@vger.kernel.org,
 Max Filippov <jcmvbkbc@gmail.com>,
 Network Development <netdev@vger.kernel.org>,
 Deepa Dinamani <deepa.kernel@gmail.com>, "H. Peter Anvin" <hpa@zytor.com>,
 sparclinux <sparclinux@vger.kernel.org>,
 linux-arch <linux-arch@vger.kernel.org>,
 linux-s390 <linux-s390@vger.kernel.org>,
 y2038 Mailman List <y2038@lists.linaro.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Helge Deller <deller@gmx.de>,
 X86 ML <x86@kernel.org>, Russell King <linux@armlinux.org.uk>,
 Ingo Molnar <mingo@redhat.com>, Geert Uytterhoeven <geert@linux-m68k.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Firoz Khan <firoz.khan@linaro.org>,
 Matt Turner <mattst88@gmail.com>, Fenghua Yu <fenghua.yu@intel.com>,
 Will Deacon <will.deacon@arm.com>,
 Linux FS Devel <linux-fsdevel@vger.kernel.org>,
 linux-m68k <linux-m68k@lists.linux-m68k.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 Michal Simek <monstr@monstr.eu>, Tony Luck <tony.luck@intel.com>,
 Parisc List <linux-parisc@vger.kernel.org>,
 Linux API <linux-api@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
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

On Fri, Jan 18, 2019 at 7:50 PM Andy Lutomirski <luto@kernel.org> wrote:
> On Fri, Jan 18, 2019 at 8:25 AM Arnd Bergmann <arnd@arndb.de> wrote:
> > - Once we get to 512, we clash with the x32 numbers (unless
> >   we remove x32 support first), and probably have to skip
> >   a few more. I also considered using the 512..547 space
> >   for 32-bit-only calls (which never clash with x32), but
> >   that also seems to add a bit of complexity.
>
> I have a patch that I'll send soon to make x32 use its own table.  As
> far as I'm concerned, 547 is *it*.  548 is just a normal number and is
> not special.  But let's please not reuse 512..547 for other purposes
> on x86 variants -- that way lies even more confusion, IMO.

Fair enough, the space for those numbers is cheap enough here.
I take it you mean we also should not reuse that number space if
we were to decide to remove x32 soon, but you are not worried
about clashing with arch/alpha when everything else uses consistent
numbers?

       Arnd

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
