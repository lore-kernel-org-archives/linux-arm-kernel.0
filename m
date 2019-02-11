Return-Path: <SRS0=sCCJ=QS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C755C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 11:35:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B0F9214DA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 11:35:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="OZgwM5UC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B0F9214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=e6hOP/YsFzqs1kSZUh35gwOaUszwu8YqfgwEXfQB3fk=; b=OZgwM5UCLErXpn
	cHjAEcLpddLT2xT/wiURV1IzjSNabMEoRvKh9od4lL8NR4a6XZ/4EbAIH7b8sQtcPOvCAIohU0afh
	gE1E3x7P0hXcxlds2xDiR5V0Z81suCvSDccKNSoNx+tmVKnTPpNDr9xcPx4O6hP9os1uzKl5mYROF
	ETGAylW1BBpm0Z696mYDzGIK47yapcMb2+o9X+UmFi8JZuc4QoWXqD50ZE2O8wMu/5a+cLX5wvVE3
	gmPs7Dd1a6Qz/pGjr/vC4uY2ioqRgdKrPQ4Oz28m5eaq3niwRvqxX9md61szJ0Y9Bw2F3O1M/sMI2
	6/CDJ4dfh5GdKe1oMUYg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gt9rS-0007NF-Bn; Mon, 11 Feb 2019 11:34:54 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gt9rO-0007Mt-U0
 for linux-arm-kernel@lists.infradead.org; Mon, 11 Feb 2019 11:34:52 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6A25080D;
 Mon, 11 Feb 2019 03:34:50 -0800 (PST)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BFAC33F557;
 Mon, 11 Feb 2019 03:34:48 -0800 (PST)
Date: Mon, 11 Feb 2019 11:34:46 +0000
From: Will Deacon <will.deacon@arm.com>
To: "kassey@126.com" <kassey@126.com>
Subject: Re: Re: arm64: copy_from_user access the last page of ddr has
 problem on 4.14 kernel
Message-ID: <20190211113446.GB32385@fuggles.cambridge.arm.com>
References: <CAKwPUowmzZ2BNi-RmJm3=ENrZ5sxPf1SeT+b9A9iHHSCUQQAUw@mail.gmail.com>
 <20190116164817.GG1910@brain-police>
 <CAKwPUoyWy64-o2NgB5iPXNs4UR7bmYjmKk3Ub0X6DND40fCtPA@mail.gmail.com>
 <20190120020829.GA28576@brain-police>
 <201902011746430858184@126.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <201902011746430858184@126.com>
User-Agent: Mutt/1.11.1+86 (6f28e57d73f2) ()
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190211_033450_967361_4B534E00 
X-CRM114-Status: GOOD (  13.14  )
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
Cc: "mark.rutland" <mark.rutland@arm.com>,
 "ard.biesheuvel" <ard.biesheuvel@linaro.org>,
 "catalin.marinas" <catalin.marinas@arm.com>,
 linux-kernel <linux-kernel@vger.kernel.org>, willy <willy@infradead.org>,
 "kassey1216@gmail.com" <kassey1216@gmail.com>,
 "robin.murphy" <robin.murphy@arm.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Feb 01, 2019 at 05:46:44PM +0800, kassey@126.com wrote:
> =A0 =A0 =A0sorry for late response.=A0
> =A0 =A0 =A0we did have process in userspace doing mmap.=A0
> =A0 =A0 =A0mult device can reprocued this issue, so we do not suspect the=
 ddr
> not stable.=A0

Multiple devices of the same SoC?

> =A0 =A0 =A0can you help review =A0below patch to against with such issue,=
 because
> we find if enable kasan , issue not seen.

Unfortunately, I'm not sure what more we can do with this unless we have a
reliable way to reproduce the problem. What is the output that you're
expecting to see in the page? You said that you're seeing the problem in
sel_write_load(), but afaict that /is/ dealing with binary policy data for
SELinux, which may well look like the corruption you describe.

Did you run memtest as I suggested?

Will
=A0
> The corruption you have is reasonably regular:
> =A0
> > 0079c00 6d6d 7061 0000 0000 0848 fd8f 0001 0000
> > 0079c10 0048 fd8f 0001 0000 0001 0000 0003 0000
> > 0079c20 2000 fd83 0001 0000 1fff fd86 0001 0000
> > 0079c30 0000 0000 0000 0000 700f 0000 0000 0000
> =A0
> Here's "mmap" again, but the record is twice as long:
> =A0
> > 0079c40 6d6d 7061 0000 0000 f448 ffff 0001 0000
> > 0079c50 f748 ffff 0001 0000 0001 0000 0004 0000
> > 0079c60 3000 fd8c 0001 0000 2fff fd8e 0001 0000
> > 0079c70 0000 0000 0000 0000 700f 0000 0000 0000
> > 0079c80 c103 0606 0100 be00 1009 3b00 3b07 0607
> > 0079c90 0100 5700 1006 e800 8c03 3103 0100 0a00
> > 0079ca0 0000 cf00 bf08 0a00 0100 5700 1006 3700
> > 0079cb0 3906 0606 0100 1600 0004 4700 9902 0207
> =A0
> And then the whole structure repeats:
> =A0
> > 0079cc0 6d6d 7061 0000 0000 f808 ffff 0001 0000
> > 0079cd0 f1c8 ffff 0001 0000 0001 0000 0005 0000
> > 0079ce0 d000 fff8 0001 0000 efff fffa 0001 0000
> > 0079cf0 0000 0000 0000 0000 700f 0000 0000 0000
> =A0
> > 0079d00 6d6d 7061 0000 0000 f1c8 ffff 0001 0000
> > 0079d10 f388 ffff 0001 0000 0001 0000 0003 0000
> > 0079d20 c000 ffdf 0001 0000 6fff fff8 0001 0000
> > 0079d30 0000 0000 0000 0000 700f 0000 0000 0000
> > 0079d40 9407 0901 0100 5300 0204 b400 d503 0a04
> > 0079d50 0100 0000 0001 0200 7309 0202 0100 0200
> > 0079d60 5000 0200 7309 0202 0400 ff00 f7ff 94ff
> > 0079d70 b400 0208 0100 dc00 0000 b400 5803 0607
> > 0079d80 6d6d 7061 0000 0000 f7c8 ffff 0001 0000

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
