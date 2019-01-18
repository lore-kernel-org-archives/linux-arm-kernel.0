Return-Path: <SRS0=p0aQ=P2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 638F2C07EBF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 17:22:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2DCEF20823
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 17:22:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="TNJJ5pEg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DCEF20823
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=iram.es
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=nqvyRVV15Ia3iDBEz3AiZkv+wz71BzAcDgVUpblxL3c=; b=TNJJ5pEgp+RVAz
	3PMXNj0dYAbGI25L58xo0jB9yFvE+leKkhjR2lIje3BClyhVeWIZXTJC4OaFiNuZrHHpmg7EaINSI
	r9qO5flhqwTX2rpFe+fdl/3OXfeLAlcKC6+Ig3xsbJXpEv43Ag3QNiUruniptqsMEIjbpinzjZX0v
	s8DiOeN+QDe6XduZ7Ywfq2pNrn7SfFyuJ1IMD/Io30Vy5TrZwSVBug30znMw6RSO7xe657HGXIsdP
	Dqo+O6vLR228/vMA74/qn3s/cJBG+Acc9yWrYDHfWQxghZpSU6vtsn4yekcrf8ZlQj0F17bF4hsL7
	hxLNgyAyD0fNyjp0uneQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkXq9-0003NZ-S6; Fri, 18 Jan 2019 17:21:57 +0000
Received: from outbound4mad.lav.puc.rediris.es ([192.187.24.1]
 helo=mx01.puc.rediris.es)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkXq6-0003Jo-9u
 for linux-arm-kernel@lists.infradead.org; Fri, 18 Jan 2019 17:21:56 +0000
Received: from sim.rediris.es (mta-out04.sim.rediris.es [130.206.24.46])
 (user=smtp-out_iram mech=LOGIN bits=0)
 by mx01.puc.rediris.es  with ESMTP id x0IHIvZD032248-x0IHIvZF032248
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Fri, 18 Jan 2019 18:18:57 +0100
Received: from sim.rediris.es (localhost.localdomain [127.0.0.1])
 by sim.rediris.es (Postfix) with ESMTPS id 2AC0A3957F;
 Fri, 18 Jan 2019 18:18:50 +0100 (CET)
Received: from sim.rediris.es (localhost.localdomain [127.0.0.1])
 by sim.rediris.es (Postfix) with ESMTPS id 0AF0F39581;
 Fri, 18 Jan 2019 18:18:46 +0100 (CET)
Received: from lt-gp.iram.es (46.246.223.87.dynamic.jazztel.es [87.223.246.46])
 by sim.rediris.es (Postfix) with ESMTPA id 7728C3957F;
 Fri, 18 Jan 2019 18:18:37 +0100 (CET)
Date: Fri, 18 Jan 2019 18:18:30 +0100
From: Gabriel Paubert <paubert@iram.es>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 13/29] arch: add split IPC system calls where needed
Message-ID: <20190118171830.quvvwdgbuhq2nqrh@lt-gp.iram.es>
References: <20190118161835.2259170-1-arnd@arndb.de>
 <20190118161835.2259170-14-arnd@arndb.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190118161835.2259170-14-arnd@arndb.de>
User-Agent: NeoMutt/20170113 (1.7.2)
X-FEAS-AUTH-USER: smtp-out_iram
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190118_092154_652753_05283A31 
X-CRM114-Status: GOOD (  11.65  )
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
Cc: dalias@libc.org, linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org,
 catalin.marinas@arm.com, will.deacon@arm.com, linux-mips@vger.kernel.org,
 jcmvbkbc@gmail.com, deepa.kernel@gmail.com, hpa@zytor.com,
 sparclinux@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-s390@vger.kernel.org, y2038@lists.linaro.org, deller@gmx.de,
 x86@kernel.org, linux@armlinux.org.uk, mingo@redhat.com, geert@linux-m68k.org,
 firoz.khan@linaro.org, mattst88@gmail.com, fenghua.yu@intel.com,
 heiko.carstens@de.ibm.com, linux-alpha@vger.kernel.org, schwidefsky@de.ibm.com,
 linux-m68k@lists.linux-m68k.org, luto@kernel.org, tglx@linutronix.de,
 linux-arm-kernel@lists.infradead.org, monstr@monstr.eu, tony.luck@intel.com,
 linux-parisc@vger.kernel.org, linux-api@vger.kernel.org,
 linux-kernel@vger.kernel.org, paul.burton@mips.com, ebiederm@xmission.com,
 netdev@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org, davem@davemloft.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Jan 18, 2019 at 05:18:19PM +0100, Arnd Bergmann wrote:
> The IPC system call handling is highly inconsistent across architectures,
> some use sys_ipc, some use separate calls, and some use both.  We also
> have some architectures that require passing IPC_64 in the flags, and
> others that set it implicitly.
> 
> For the additon of a y2083 safe semtimedop() system call, I chose to only

It's not critical, but there are two typos in that line: 
additon -> addition
2083 -> 2038

	Gabriel

> support the separate entry points, but that requires first supporting
> the regular ones with their own syscall numbers.
> 
> The IPC_64 is now implied by the new semctl/shmctl/msgctl system
> calls even on the architectures that require passing it with the ipc()
> multiplexer.
> 
> I'm not adding the new semtimedop() or semop() on 32-bit architectures,
> those will get implemented using the new semtimedop_time64() version
> that gets added along with the other time64 calls.
> Three 64-bit architectures (powerpc, s390 and sparc) get semtimedop().
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
