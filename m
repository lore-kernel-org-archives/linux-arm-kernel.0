Return-Path: <SRS0=sCCJ=QS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61E32C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 16:16:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 321FD21B1C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 16:16:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="MSmeAwN7";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fQ2AJskV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 321FD21B1C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ECPNM+72wzx4juQkjAIyRAy6Ip+BVKLqrjoa3CT6CCI=; b=MSmeAwN7lEXLIo
	2afxl0g0pzoEP3a5ABVodvzTx/2vOh5cVbSsVMIoVL1GWjqpInC7vyUEGrZj/Sauul+XibBSTy4Y0
	90n4a4lxnKnmQuvLwb9xanQqL3/mVuV2Y4CavmfaOX271X+E8o7hsikb1iRLY3Y1s1qhM9OnZ2qMy
	RmR5u+/eNaCzX6Qa8X6LuOBPd6Tzsz0Scx1rwTHoDjqcrhwoJ81D+GYIOAUcI9Zu3mHFF3Vs1oQlL
	+Fe9u3cwAZL62XFdzrUL/en+55x44weK+NfHxDkYCZwW8V7XqduaGdGWeJ/WciT9PmsY3ad9ewaqp
	9IBs83P4woGiBPFCDyfQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtEFO-00058T-09; Mon, 11 Feb 2019 16:15:54 +0000
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtEFK-000587-Al
 for linux-arm-kernel@lists.infradead.org; Mon, 11 Feb 2019 16:15:51 +0000
Received: by mail-wm1-x341.google.com with SMTP id a62so18345582wmh.4
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 11 Feb 2019 08:15:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=message-id:subject:from:to:cc:date:in-reply-to:references
 :user-agent:mime-version:content-transfer-encoding;
 bh=H7yfy1o+RpuXfDtk8j+KsO/uzl/JEpDRaJbGio8J5J4=;
 b=fQ2AJskVbNA2cLKHz6/NUMEaJ0cBTemdjhrIHpH/New/czeq8Obi+QGCMG0+7W7r1S
 AxyP2C1I36f7iGxc4rs4xfP/ojDsQEUru0C3w6X94s1mkFiwOUPDk2muxsr+8j3PAaMv
 BbloIx+LzorT44ok3V8vZvdT8ovBZzpASu1tMqT8bR0E00BfiTXmX7br0k6RutQBd5Ny
 Iiyhw61MNV59macj4O4Zydrf+qv91BLY9xs7Y4sidIaJz9I8QSmfLZ8KAtyIUBG1geC7
 rOJtoMWG38R2itMohtYRKl9OMyVE/eH3t7BdW8q3ZdonREIFKm7+jKFcVyfvns06/DMh
 dTFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
 :references:user-agent:mime-version:content-transfer-encoding;
 bh=H7yfy1o+RpuXfDtk8j+KsO/uzl/JEpDRaJbGio8J5J4=;
 b=aIGLIllFEubwDNSRUwxm4LvX99iU9VHCWbmYz5vdb1HWan1iRLSlLoKjJbQsQZynI5
 zWeQJSs98QPLvJ5mcXFG8ilvuKJAMf3F0sRruX2ZrFZe5vV7e42uqZtQ+Tyarz1hV1CT
 TH/4GW9+7YebCizjrgSmBg30oI9LWm1TYVjIM7i94wrfZ1uB5N4Zag+4ppZQZj4vOq2h
 xmwt+SgYulwU7LkPYPOMQUsiWYZvB5kqLaiQ0PeTuxf/VUB8qK9eqEhyoRkXUXe8ROrx
 jpaPUWmFPdvscY/SDh0ib8ChMMbvh0OIBHWt6M7ZksQ6/N2LzDhhx+eAMzrBZQDcc38R
 jjUg==
X-Gm-Message-State: AHQUAuZYegNsbcPSYL46Ac9Lkj3ZIR1hJttEixxRObKe9amFmX3FcQLT
 Y9GfRInjDmrTdzOl1EmHr4w=
X-Google-Smtp-Source: AHgI3IY/wTj3QxusPROn9DEgTX2RMn5pjTh+MPKP3XyJHcH69xe2xUmaOzvGLSuEAgtlH/jUauQgPg==
X-Received: by 2002:a1c:99c3:: with SMTP id b186mr175186wme.79.1549901746609; 
 Mon, 11 Feb 2019 08:15:46 -0800 (PST)
Received: from [192.168.1.100] ([93.51.16.173])
 by smtp.gmail.com with ESMTPSA id k2sm1665050wmj.45.2019.02.11.08.15.45
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 11 Feb 2019 08:15:45 -0800 (PST)
Message-ID: <b45065a61ac79add6dfa9d63131faf6f3761cb6b.camel@gmail.com>
Subject: Re: [PATCH] arm64/io: Don't use WZR in writel
From: AngeloGioacchino Del Regno <kholk11@gmail.com>
To: Marc Zyngier <marc.zyngier@arm.com>, Will Deacon <will.deacon@arm.com>
Date: Mon, 11 Feb 2019 17:15:45 +0100
In-Reply-To: <235d20ef-3054-69d9-975d-25aebf32aad3@arm.com>
References: <68b71c15f32341468a868f6418e4fcb375bc49ba.camel@gmail.com>
 <20190211105755.GB30880@fuggles.cambridge.arm.com>
 <38d8965a-cd41-17cf-1b95-8dd58c079be4@arm.com>
 <874c702b8af760aa8fae38d478c79e3ecba00515.camel@gmail.com>
 <235d20ef-3054-69d9-975d-25aebf32aad3@arm.com>
User-Agent: Evolution 3.30.2 
Mime-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190211_081550_404022_EF7CE30C 
X-CRM114-Status: GOOD (  19.75  )
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

Il giorno lun, 11/02/2019 alle 14.59 +0000, Marc Zyngier ha scritto:
> On 11/02/2019 14:29, AngeloGioacchino Del Regno wrote:
> 
> [...]
> 
> > Also, just one more thing: yes this thing is going ARM64-wide and
> > - from my findings - it's targeting certain Qualcomm SoCs, but...
> > I'm not sure that only QC is affected by that, others may as well
> > have the same stupid bug.
> > 
> 
> At the moment, only QC SoCs seem to be affected, probably because
> everyone else has debugged their hypervisor (or most likely doesn't
> bother with shipping one).
> 

Between all the ARM SoCs, as far as I know, the only (?) ones using
actual "smartphones", so actually provisioned SoCs, for upstream
development are using Qualcomm SoCs.. of which, some development
boards are not entirely security enabled, or have got newer firmwares
which can't be used on production phones etc, so.. that's why I said
that I'm not sure that only QC is affected.
It's just relative to what we currently know, but looking at, for
example, MediaTek, I'm not sure that the only bugged hypervisor is on
QC (because MTK is very similar on certain aspects).
I mean, it's highly possible that some other is affected and we don't
know (and we possibly don't care...).

> In all honesty, we need some information from QC here: which SoCs are
> affected, what is the exact nature of the bug, can it be triggered
> from

It'd be wonderful if Qualcomm gives us some information about that.
Would really be helpful and nice from them.

> EL0. Randomly papering over symptoms is not something I really like
> doing, and is likely to generate problems on unaffected systems.
> 
> Thanks,
> 
> 	M.

I also don't like "randomly papering over symptoms", I totally agree
with you on that... but this change potentially generating problems on
unaffected systems is something I don't really agree on: this is a
partial revert of a commit that was done purely to introduce some
vmlinux (relatively small) size saving on ARM64 and no other reason
(as far as I can read on the original commit), so I really don't think
that my partial revert could ever harm anything.
Though, this is a personal opinion, I can be right, but I can obviously
be totally wrong on that.

Though I have to make this clear: if there's another (better/cleaner)
solution to this issue, I'd be totally happy (and, of course, curious
too) to see it!


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
