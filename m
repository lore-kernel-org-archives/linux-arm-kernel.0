Return-Path: <SRS0=flTa=P5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A42B2C282F6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 09:10:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6700D2085A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 09:10:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Dv+8J7g3";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dTmW5/Is"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6700D2085A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=zpmtaRP+wrMqJJ0h0ZhLynJmdRVbpD890c5bAW9xjKU=; b=Dv+8J7g3gAiPpf
	tMWN+XVP28jVrn/jNV6w0t2/ZQFxmgQatYdoelQA698szUeAUmSA5cuJjVU+nsTGODhwpPfLNzClM
	s5npqKYaf6exhCVarJsJl7qX+a1uJ1Glaw3eJONBJIx9U1jl2hYVVciOLHGd9EgzM1mHmOjOl+Q4s
	5Yu2JFl0lk/Ux1JAYBS7oVYosNTXSYa/xYLREhtEF+6ApszUryTloQSTJpEC/H+iuq9YxWKXwebH6
	Ya6KB/SEh5EwDDI/G+J9G6wLYm+K8z0VI3GffdGIeowBkXjXXWXvY7ixFZsbfKZ+vCiHrgCh0qZqB
	2VJF1hsZUiZecaJOwQxA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glVbS-0003Uo-TS; Mon, 21 Jan 2019 09:10:46 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glVbR-0003Tm-0N
 for linux-arm-kernel@bombadil.infradead.org; Mon, 21 Jan 2019 09:10:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=Content-Type:Cc:To:Subject:Message-ID:
 Date:From:In-Reply-To:References:MIME-Version:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=qXLD08ZhNbo1NMvbOHKMcfHtw8oqcgdcNXRBleZ02HU=; b=dTmW5/Isc/7mHyfi1Yoa54nr6
 YSqRsng14QNirNulHILHqDQIuVERkd2w7+DHBeoMGveGLYyLbQCRgja4fU05M6/kg5brQT20Hsdph
 N5rDrHkdk1m+RHE9xzkdeiwgQUdZ8SBqnC13QbWsS5kL7l2lnU/xVJ4VbK/BTmUvjbonRqfzuUbEe
 xIb7CI+PhAsHzfU2JCdG9XqdqJHXNPHR7iHqxOt+UNNt5ciaccHT60zfOlBHtxtRR52xmiaBGb1Z5
 SS/erragVGgsm/DdKxBeVhSN9wOku8BJXXTXwVZsx8XVmucetlyZTQaBxZW8/RHQTZbD7W5DmSZ6A
 8A41uu0Yg==;
Received: from mail-vs1-f66.google.com ([209.85.217.66])
 by merlin.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glUc5-0008J7-I0
 for linux-arm-kernel@lists.infradead.org; Mon, 21 Jan 2019 08:07:22 +0000
Received: by mail-vs1-f66.google.com with SMTP id x64so12077704vsa.5
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 21 Jan 2019 00:07:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=qXLD08ZhNbo1NMvbOHKMcfHtw8oqcgdcNXRBleZ02HU=;
 b=XalfBmF77oX1xzrzHupEbMJucwIHvBg4PGmT1pP1rL7h27X2XiSAVgnU8sDy5leYt+
 pCRonkn3vRTwdjalUH2lLhLUuCwvSpIOadYUVsOP0HKCAsamwCcUlCAnyrP9IYGIv8GW
 1OWJ0CHUXX+p/sroOkCEuP6eJoRKwY09fCdWpPSHnBqwhOzqBozFjh6CDyCnR1vmGgqK
 BMfGn+OoyGZd0BIkJUIV8QNlMIPXhgdK6tr7p5z1UmVYZrfwUiLeF5rtvczkMtnX+wMK
 Z+u1eUkD6z9BHp36mrutqZu59cWCpXL8n6MUIpQc4jfmXiwU9GecqtwB/IDEaTCPyu6E
 DXag==
X-Gm-Message-State: AJcUukfluppxpWf3gCtTfVgIZVhMYHJpesYng7ViS40dTFJfFkNAd/Ow
 N+/pPl/ETzw4ToafNjiKkrr/hsx6TLrc5v4ndjU=
X-Google-Smtp-Source: ALg8bN7PAkoiEcltbZZ90okuIHKeh3Hd7zrjUBYlI94Ofq6l4zsWCDbU0HLun3Hy0/S9rRYk7ybtuk0MjXCtnpQGbIE=
X-Received: by 2002:a67:f43:: with SMTP id 64mr11912894vsp.166.1548058038054; 
 Mon, 21 Jan 2019 00:07:18 -0800 (PST)
MIME-Version: 1.0
References: <20190118161835.2259170-1-arnd@arndb.de>
 <20190118161835.2259170-27-arnd@arndb.de>
In-Reply-To: <20190118161835.2259170-27-arnd@arndb.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 21 Jan 2019 09:07:06 +0100
Message-ID: <CAMuHMdU1tNA74QRKhcuJ-LkRi4HBynZoQ0hd-MVZtY4+oh6OUA@mail.gmail.com>
Subject: Re: [PATCH v2 26/29] y2038: use time32 syscall names on 32-bit
To: Arnd Bergmann <arnd@arndb.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190121_030721_608128_3C810C5D 
X-CRM114-Status: GOOD (  16.39  )
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

Hi Arnd,

On Fri, Jan 18, 2019 at 5:21 PM Arnd Bergmann <arnd@arndb.de> wrote:
> This is the big flip, where all 32-bit architectures set COMPAT_32BIT_TIME
> abd use the _time32 system calls from the former compat layer instead

and

> of the system calls that take __kernel_timespec and similar arguments.

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
