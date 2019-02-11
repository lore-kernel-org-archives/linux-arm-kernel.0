Return-Path: <SRS0=sCCJ=QS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF5B5C282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:30:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D7EF214DA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:30:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="o98Lo8ZS";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jvaxXP1h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D7EF214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=1dvQtGDdr7uLsXFESGckP0wS+RbycI1ZhUOycIwVeCA=; b=o98Lo8ZSbY56km
	8H5TmqtT3DLEjJzGaKRKx+mzIyq1YVFEv52+/hjEKeB/PPpB8FI5+r/ggf/2Jo2JeRQUB/ZzC6Uxe
	pBkYwCmyYcshANZKgL919u5lqCYicK/JZ1GhtS9orqrfjpncK/pYyfhRqzWouVJao+4j8fNcFVesO
	TyXb6tmbbJTN9qLZIElXCNR3i0VzA+B8H48DlMbLmbY+SLgAlNMZwqkH1zJQty4ghKaAsCmB+Scl6
	NYzshtQkl7Tt+O3oAYrZfpCadY7FyrYe00emHunMrxJpW0zuJ+QxslwTELK72QcvWfIQDBHczikFN
	nQEe6+wG8q7qBRmokd+Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtCat-0004h8-Ic; Mon, 11 Feb 2019 14:29:59 +0000
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtCap-0004gR-LV
 for linux-arm-kernel@lists.infradead.org; Mon, 11 Feb 2019 14:29:57 +0000
Received: by mail-wr1-x443.google.com with SMTP id f14so590091wrg.1
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 11 Feb 2019 06:29:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=message-id:subject:from:to:cc:date:in-reply-to:references
 :user-agent:mime-version:content-transfer-encoding;
 bh=WNiKGJjUidWR3l0CVZ7Opnq01zwCNqD0tZu9JXLyfwY=;
 b=jvaxXP1hhM2kEJsZelFy7NY/9CT78XpF68Wh7b9eo7yo/SzJaTFLxguEjLMo9/eIaA
 88dTzyrbjEiM44Hqbv+sBkLqdL8VqTgq2vd6MR5orfZ/nWMSZ2h6hP7SC/TMRG0OGzfp
 BJVBnS87OSwn7Y1IaczK1cmOEDPzm1ZrC6QAt6XfZLtsdOqXhkt8r9TJA/GwBNPLpba+
 o22ujVAg7cES2GPLZF54TKkTdejnOnDhP2g9OuWy0JpwlanWdynTOPUESLixU5M019HN
 6+h6whAGSTzLsCgWLhWI/0cA5MsiqQ7vRV/fYndc0q6rHFdnjAgGp/vivsShP3ovKFUq
 xW9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
 :references:user-agent:mime-version:content-transfer-encoding;
 bh=WNiKGJjUidWR3l0CVZ7Opnq01zwCNqD0tZu9JXLyfwY=;
 b=ujV2TkkgG+KGoo12JTcI3HQNuY4KqoTa5lZh/POmyJz16kJRIyF2goyioiizTie90+
 Anu0qyGvmueyMJMsPnNUqRZPMqKeXz3iOwRpODGxqhkX2W1xc1W753xJe0/L/BP+DADC
 F6pVMqcvElr/REuUBG1nabaInQUiN3diHQkyEYr77ebT/NCoxRboIcif6fioyI6SqCZX
 0YOqXfGrlEWsKlNX2+fARjIGVGTgv0fpxui3N+ypbzh0SJAfoeE5mc5piw8MMztea+1n
 Xg8b3K5cKPUD0ex1G7A7uhGkkXjV3YXdkc8Ijf21YNfqGuwPWWvXj6wL+roLrKOwntmm
 n5ww==
X-Gm-Message-State: AHQUAuYoE11VUf/dcUZkMg1k+4SyrjKopN757OgIl59RlwbrAyBwucOB
 NV2/kuRSokCW4qiQE/U8pXc=
X-Google-Smtp-Source: AHgI3IZW1d6ZRxPm47GDke+9ycRLhMM+qJ49ksXvar0oyncr/SOhgMwpul5KfnPHi/tzF3Pn713AfQ==
X-Received: by 2002:a5d:5101:: with SMTP id s1mr27617369wrt.89.1549895393315; 
 Mon, 11 Feb 2019 06:29:53 -0800 (PST)
Received: from [192.168.1.100] ([93.51.16.173])
 by smtp.gmail.com with ESMTPSA id a144sm18332930wmd.30.2019.02.11.06.29.52
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 11 Feb 2019 06:29:52 -0800 (PST)
Message-ID: <874c702b8af760aa8fae38d478c79e3ecba00515.camel@gmail.com>
Subject: Re: [PATCH] arm64/io: Don't use WZR in writel
From: AngeloGioacchino Del Regno <kholk11@gmail.com>
To: Marc Zyngier <marc.zyngier@arm.com>, Will Deacon <will.deacon@arm.com>
Date: Mon, 11 Feb 2019 15:29:51 +0100
In-Reply-To: <38d8965a-cd41-17cf-1b95-8dd58c079be4@arm.com>
References: <68b71c15f32341468a868f6418e4fcb375bc49ba.camel@gmail.com>
 <20190211105755.GB30880@fuggles.cambridge.arm.com>
 <38d8965a-cd41-17cf-1b95-8dd58c079be4@arm.com>
User-Agent: Evolution 3.30.2 
Mime-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190211_062955_726767_FD2D2F41 
X-CRM114-Status: GOOD (  29.56  )
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
Cc: Jens Axboe <axboe@kernel.dk>, Catalin Marinas <catalin.marinas@arm.com>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Il giorno lun, 11/02/2019 alle 11.52 +0000, Marc Zyngier ha scritto:
> On 11/02/2019 10:57, Will Deacon wrote:
> > On Sat, Feb 09, 2019 at 07:34:53PM +0100, AngeloGioacchino Del
> > Regno wrote:
> > > From 33fb6d036de273bb71ac1c67d7a91b7a5148e659 Mon Sep 17 00:00:00
> > > 2001
> > > From: "Angelo G. Del Regno" <kholk11@gmail.com>
> > > Date: Sat, 9 Feb 2019 18:56:46 +0100
> > > Subject: [PATCH] arm64/io: Don't use WZR in writel
> > > 
> > > This is a partial revert of commit ee5e41b5f21a
> > > ("arm64/io: Allow I/O writes to use {W,X}ZR")
> > > 
> > > When we try to use the zero register directly on some SoCs,
> > > their security will make them freeze due to a firmware bug.>>
> > > This behavior is seen with the arm-smmu driver freezing on
> > > TLBI and TLBSYNC on MSM8996, MSM8998, SDM630, SDM660.
> 
> This looks similar to the issue these SoCs have with GICv3, worked
> around in 9c8114c20d18.
> 

Well, yes that's a firmware quirk, of course, due to the "security"
stuff that they have inside...

> > Hmm, this sounds very fragile. I hope they're not trapping and
> > emulating
> > MMIO accesses and treating the zero register as the stack
> > pointer...
> 
> I bet this is the case. The same bug was there in both KVM and Xen.
> The
> only difference is that we fixed it back in December 2015 (at least
> for
> KVM), while some of these SoCs were announced in 2017, and are still
> shipping. Great stuff.

Totally agree, they must be using it as stack pointer.
Poor decision.

> 
> > Wouldn't this also be triggerable from userspace by mmap()ing
> > either
> > /dev/mem or e.g. a PCI bar via sysfs?
> > 
> > > Allocating a temporary register to store the zero for the
> > > write actually solves the issue on these SoCs.
> > 
> > I don't think this catches all MMIO accesses, so I think we need to
> > understand more about the actual issue here. For example, is it
> > only the
> > SMMU that causes this problem? Also, any workaround should be
> > specific to
> > the broken SoCs.
> 
> Also, nothing would prevent a compiler from generating these
> accesses.
> 
> 	M.
> 
> Jazz is not dead. It just smells funny...

While I agree that nothing would prevent a compiler from generating
these accesses, please take in mind that everything worked on
downstream kernels before this change was introduced (which is first
seen downstream on msm-4.9).
So I've discovered it on msm-4.9 while porting the 8996-98, 630-660
to that and I've had a whole lot of head scratching: the arm-smmu
code was apparently right, then I've seen that surprise......
By the way, I can tell you for sure that this bug is not present on
at least SDM845, since that one worked fine even before this fix,
and I imagine that also SDM670 and newest may not be affected.
Also Family-B SoCs are not affected by this bug (MSM8916-36-37-56-76).

Unfortunately, I couldn't think of any other solution on these
Family-A SoCs, also because I'm not totally sure that the only
driver that produces this issue is arm-smmu. When I've fixed it
on the downstream kernel, I've also had some other random freezes
that weren't related to the SMMU: usually qseecom stuff was also
acting funny sometimes.

Also, just one more thing: yes this thing is going ARM64-wide and
- from my findings - it's targeting certain Qualcomm SoCs, but...
I'm not sure that only QC is affected by that, others may as well
have the same stupid bug.


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
