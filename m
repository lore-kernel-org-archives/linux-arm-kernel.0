Return-Path: <SRS0=vaNk=PS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9184C43444
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 17:12:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A77B20874
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 17:12:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="eTbvUY17"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A77B20874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=L/xkEIJym/g7uIAtcGDcIKCc/0TeAmZnQRZF5airOvM=; b=eTbvUY17TZWjpw
	yYeqsMOxr8+IHkZPYeCrXTkCblPG5FJ+ympP/0F5VD7YZ4o+oHkCkpwcXf0hAPoosC5997BmIg6am
	jJO9/WJMtJtzaWsn9DVielEZrjQR33A1ns9wqeb8xHO5gfSAioBLflsm6ohzzWE8yQ5BY26x1TBUg
	1/OFwulKZjFXSVcE+U6nQ0+FPIzQfJVlrUeRfSnwxZD4KUFHZMQ6zwfz3Bx3LnkcjrIkABW09bKMH
	UdjBjjioOSCV9MayXx+YLfACJ5IiZvCsnGbYWn5TUG9yEWtd57mNud9XGNQlcFK+nIRSc4R8TaY3e
	S+slARV9lE8AUNbyZrhQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghdsC-0003Fp-63; Thu, 10 Jan 2019 17:12:04 +0000
Received: from mail-qt1-f196.google.com ([209.85.160.196])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghds9-0003F5-7h
 for linux-arm-kernel@lists.infradead.org; Thu, 10 Jan 2019 17:12:02 +0000
Received: by mail-qt1-f196.google.com with SMTP id l11so14062861qtp.0
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 10 Jan 2019 09:12:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=h9Ub2IW9cySGL3QZFJM+qSZvbyYHJpNB32B/Hx6OxIg=;
 b=jqoUhYJcRRg5t066h8eIy/ZsBsQPg1FgGkP6OXMxlMdkx8s19mwTo291eifD+N7BuV
 E81wN2S3NriEasKjXkanIOZowEm67CV3rHvUJgjvDCxs+NO/n7CivcS9LpLL/Lw8Sxky
 +Gr7bZ+64haicLHTQH0h217rK2DoVPEoHJoTEmsPBtVs46Ah3rJ7LhEt0RUGtv7SQAM5
 704plnA2kX47eQr+KFQZCcfpIuBZutZX4kj+xrrDUHksD7f89SRPERPoNQACQjX+sPva
 Qfe+1aKlD01K8oWoUna/KrcmKvktQjCruTdhGnezHJXsTr+WMvZEEnn7eTYPJ9/wHMl4
 rnTg==
X-Gm-Message-State: AJcUukeeQ+vU1L4kDlSNEwROAyhy3JfTaVwR+GSSF5OZ2eagnjj9RhEa
 d2T8X0GL+pN2ty3XLvUxMVQwAPDver8UWQ/BDnc=
X-Google-Smtp-Source: ALg8bN4Gur1wD3h0ELBSl0ybGvD7wc1qcQeOBkYMXly/Z0pb/J89D40WVoT3xz1IidS9G8IG/oXogEOscyYpZb29+TE=
X-Received: by 2002:a0c:d992:: with SMTP id y18mr10912612qvj.161.1547140320327; 
 Thu, 10 Jan 2019 09:12:00 -0800 (PST)
MIME-Version: 1.0
References: <20190110162435.309262-1-arnd@arndb.de>
 <20190110162435.309262-7-arnd@arndb.de>
 <20190110163220.GB31683@fuggles.cambridge.arm.com>
In-Reply-To: <20190110163220.GB31683@fuggles.cambridge.arm.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 10 Jan 2019 18:11:44 +0100
Message-ID: <CAK8P3a0TyDTTG7Eoz9dZF1J0SH-=OYQvQ6=YVThTkDfX-mnfWg@mail.gmail.com>
Subject: Re: [PATCH 06/15] ARM: add migrate_pages() system call
To: Will Deacon <will.deacon@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190110_091201_300848_875D6D18 
X-CRM114-Status: GOOD (  12.16  )
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
 Catalin Marinas <catalin.marinas@arm.com>,
 Heiko Carstens <heiko.carstens@de.ibm.com>,
 Dominik Brodowski <linux@dominikbrodowski.net>, linux-mips@vger.kernel.org,
 Max Filippov <jcmvbkbc@gmail.com>, Deepa Dinamani <deepa.kernel@gmail.com>,
 "H. Peter Anvin" <hpa@zytor.com>, sparclinux <sparclinux@vger.kernel.org>,
 linux-s390 <linux-s390@vger.kernel.org>, Davidlohr Bueso <dave@stgolabs.net>,
 y2038 Mailman List <y2038@lists.linaro.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Helge Deller <deller@gmx.de>,
 the arch/x86 maintainers <x86@kernel.org>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Ingo Molnar <mingo@redhat.com>, Geert Uytterhoeven <geert@linux-m68k.org>,
 Firoz Khan <firoz.khan@linaro.org>, Matt Turner <mattst88@gmail.com>,
 Fenghua Yu <fenghua.yu@intel.com>,
 linux-m68k <linux-m68k@lists.linux-m68k.org>,
 Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Andy Lutomirski <luto@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Michal Simek <monstr@monstr.eu>, Tony Luck <tony.luck@intel.com>,
 Parisc List <linux-parisc@vger.kernel.org>,
 Linux API <linux-api@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Paul Burton <paul.burton@mips.com>,
 "Eric W . Biederman" <ebiederm@xmission.com>,
 alpha <linux-alpha@vger.kernel.org>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 David Miller <davem@davemloft.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Jan 10, 2019 at 5:32 PM Will Deacon <will.deacon@arm.com> wrote:

> > diff --git a/arch/arm64/include/asm/unistd32.h b/arch/arm64/include/asm/unistd32.h
> > index 04ee190b90fe..355fe2bc035b 100644
> > --- a/arch/arm64/include/asm/unistd32.h
> > +++ b/arch/arm64/include/asm/unistd32.h
> > @@ -821,6 +821,8 @@ __SYSCALL(__NR_statx, sys_statx)
> >  __SYSCALL(__NR_rseq, sys_rseq)
> >  #define __NR_io_pgetevents 399
> >  __SYSCALL(__NR_io_pgetevents, compat_sys_io_pgetevents)
> > +#define __NR_migrate_pages 400
> > +__SYSCALL(__NR_migrate_pages, sys_migrate_pages)
>
> Should be compat_sys_migrate_pages instead?

Yes, good catch! Fixed now.

Thanks,

        Arnd

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
