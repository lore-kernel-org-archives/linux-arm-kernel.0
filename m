Return-Path: <SRS0=tmGn=OI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 504D2C43441
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 16:37:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 232CE20989
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 16:37:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="eDMQCf+M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 232CE20989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=05PrJL//x7Ab4+s+9vTxdaDcJIm/4x+l31kbB/M0qSk=; b=eDMQCf+MGoJHOj
	0VAwRYe+RzeaCzh2PqVzEjSdBeC8G5kNYTFXkCkcwYbF0fnBeh5hwtS+/ldhNZd5ubBvH+wAzUZgi
	y+WQCMujzEpvaydi0a5WECaqBMFfUO7B0sgf4dz0q2WOvp9DCmeBNxeAqg5zRjnlO6E3daypv+wE1
	rQpG7+w3r7GN52YVufBPToZDpnOsHUlHAJ9WiH03OhSztPMXcspvJJhPwnbIyNjMZq7yFz/q3+O35
	dTAdIzwGS2jReeQsdMrtvK301ZqfYzl7JFPXtbkofJWCTAc5gj9qu//uSWfyFq4GBdSKEfzJ2nMOT
	1zPf0/vSsD8BZ4kPy7Dw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSPJQ-0002qy-18; Thu, 29 Nov 2018 16:37:12 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSPJN-0002qG-51
 for linux-arm-kernel@lists.infradead.org; Thu, 29 Nov 2018 16:37:10 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A47F1A78;
 Thu, 29 Nov 2018 08:36:58 -0800 (PST)
Received: from edgewater-inn.cambridge.arm.com
 (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 734CD3F59C;
 Thu, 29 Nov 2018 08:36:58 -0800 (PST)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
 id D6B831AE0FD4; Thu, 29 Nov 2018 16:37:16 +0000 (GMT)
Date: Thu, 29 Nov 2018 16:37:16 +0000
From: Will Deacon <will.deacon@arm.com>
To: Nathan Chancellor <natechancellor@gmail.com>
Subject: Re: [PATCH] arm64: io: specify asm operand width for __iormb()
Message-ID: <20181129163716.GA21475@arm.com>
References: <20181129041912.5918-1-nick.desaulniers@gmail.com>
 <fe3cba43-935b-448c-46e9-90ea75593e5b@arm.com>
 <20181129104902.GA2377@arm.com> <20181129161039.GA17063@flashbox>
 <20181129161337.GA21349@arm.com> <20181129161738.GA9805@flashbox>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181129161738.GA9805@flashbox>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181129_083709_197507_600143F5 
X-CRM114-Status: GOOD (  15.42  )
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
Cc: Jens Axboe <axboe@kernel.dk>, Julien Thierry <Julien.Thierry@arm.com>,
 Catalin Marinas <Catalin.Marinas@arm.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Nick Desaulniers <nick.desaulniers@gmail.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Nov 29, 2018 at 09:17:38AM -0700, Nathan Chancellor wrote:
> On Thu, Nov 29, 2018 at 04:13:37PM +0000, Will Deacon wrote:
> > On Thu, Nov 29, 2018 at 09:10:39AM -0700, Nathan Chancellor wrote:
> > > This doesn't appear to work, I get this error:
> > > 
> > > In file included from arch/arm64/kernel/asm-offsets.c:24:
> > > In file included from ./include/linux/dma-mapping.h:11:
> > > In file included from ./include/linux/scatterlist.h:9:
> > > In file included from ./arch/arm64/include/asm/io.h:209:
> > > ./include/asm-generic/io.h:695:9: error: expected expression
> > >         return readb(addr);
> > >                ^
> > > ./arch/arm64/include/asm/io.h:147:50: note: expanded from macro 'readb'
> > > #define readb(c)                ({ u8  __v = readb_relaxed(c); __iormb(__v); __v; })
> > >                                                                ^
> > > ./arch/arm64/include/asm/io.h:120:28: note: expanded from macro '__iormb'
> > >                      : "=r" (tmp) : "r" (unsigned long)(v) : "memory"); \
> > >                                          ^
> > 
> > Can you try throwing another set of brackets around it, please?
> > 
> > 	((unsigned long)(v))
> > 
> Thanks, that fixes the warning as well.

Great, I'll push this out tomorrow with your reported-by on it.

Will

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
