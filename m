Return-Path: <SRS0=iy7m=RA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0969C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 08:55:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B461A2087C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 08:55:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ofZiPh0T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B461A2087C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Message-ID:From:To:Subject:MIME-Version
	:References:In-Reply-To:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=5GTVL/1H7OsaD5fiZf7QJrHWTUGnWAfRFKdYAwuf2fs=; b=ofZiPh0TA8aEH2
	NbDGwVDwICBPex8yO9+4C/lXWlRreCHd2ycY58eUpLjcZTm+S1/xyYogjq4NhzQjUnkXRMEDHWc9/
	QXvgz0xmBgknN3W+CryT6RqCgfRcMyDDL9YfQr23lnSO62ODALluIAoOKYRM4GN2YY60CBn+5ZIXM
	aG58VpvAg1IOVJvl+L5+nczUd8xHoTlYk5WaPuA/dUYbpxXr6D+b1DuAfHRg4DIjNXZV0nFDOyXtj
	a3bldZB8scAR9haNQdoCej9/5YlDKFjHKse6SNZwQmXx5biU1aTA3vOJzwrCXooYnhC/yuxHG5LTN
	D5fRlaJnC2VGe/1TlZ8g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gyC2D-0003Y4-56; Mon, 25 Feb 2019 08:54:49 +0000
Received: from terminus.zytor.com ([198.137.202.136] helo=mail.zytor.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gyC2A-0003Xi-7Z
 for linux-arm-kernel@lists.infradead.org; Mon, 25 Feb 2019 08:54:47 +0000
Received: from [IPv6:2601:646:8680:2bb1:a106:e287:aa34:4a8c]
 ([IPv6:2601:646:8680:2bb1:a106:e287:aa34:4a8c])
 (authenticated bits=0)
 by mail.zytor.com (8.15.2/8.15.2) with ESMTPSA id x1P8nWCF1623805
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
 Mon, 25 Feb 2019 00:49:33 -0800
Date: Mon, 25 Feb 2019 00:49:24 -0800
User-Agent: K-9 Mail for Android
In-Reply-To: <20190223083942.GF32477@hirez.programming.kicks-ass.net>
References: <9e037d68-75e7-1beb-0c9c-33a7ffeced1b@zytor.com>
 <20190219090409.GW32494@hirez.programming.kicks-ass.net>
 <20190219124808.GG8501@fuggles.cambridge.arm.com>
 <f8e99706-4e3b-68ec-7a3e-6e6dd876ad2f@zytor.com>
 <cb221e71-243d-fdbd-1d18-b175bc88979b@arm.com>
 <alpine.DEB.2.21.1902212231490.1612@nanos.tec.linutronix.de>
 <CAHk-=wh1B9eRG=gj7wsFVC5XNEedk8Edive-2cQok6T2dNq2aQ@mail.gmail.com>
 <alpine.DEB.2.21.1902221853330.1666@nanos.tec.linutronix.de>
 <20190222222635.GK14054@worktop.programming.kicks-ass.net>
 <CE650687-ECB3-4A7C-96BA-A061D54AEF40@zytor.com>
 <20190223083942.GF32477@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Subject: Re: [RFC][PATCH] objtool: STAC/CLAC validation
To: Peter Zijlstra <peterz@infradead.org>
From: hpa@zytor.com
Message-ID: <0086D776-AD23-4C1F-A0D8-37BE8D6D9BEC@zytor.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190225_005446_268142_880384AA 
X-CRM114-Status: UNSURE (   6.39  )
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
Cc: Denys Vlasenko <dvlasenk@redhat.com>, Josh Poimboeuf <jpoimboe@redhat.com>,
 Julien Thierry <julien.thierry@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, valentin.schneider@arm.com,
 Will Deacon <will.deacon@arm.com>,
 Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
 Andy Lutomirski <luto@amacapital.net>, Ingo Molnar <mingo@redhat.com>,
 James Morse <james.morse@arm.com>, Andrew Lutomirski <luto@kernel.org>,
 Brian Gerst <brgerst@gmail.com>, Borislav Petkov <bp@alien8.de>,
 Thomas Gleixner <tglx@linutronix.de>,
 Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>,
 "linux-alpha@vger.kernel.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On February 23, 2019 12:39:42 AM PST, Peter Zijlstra <peterz@infradead.org> wrote:
>On Fri, Feb 22, 2019 at 03:39:48PM -0800, hpa@zytor.com wrote:
>> Objtool could also detect CLAC-STAC or STAC-CLAC sequences without
>> memory operations and remove them; don't know how often that happens,
>> but I know it *does* happen.
>
>Objtool doesn't know about memops; that'd be a lot of work. Also,
>objtool doesn't actually rewrite the text, at best it could warn about
>such occurences.

It doesn't even have to change the text per se, just nullify the altinstr.
-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
