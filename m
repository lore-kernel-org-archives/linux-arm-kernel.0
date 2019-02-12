Return-Path: <SRS0=CPNf=QT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9067BC282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 15:28:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5EE1320863
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 15:28:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="eFo2pH5w";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="e+rXngJF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EE1320863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Message-Id:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=iSCF62oeNsPldo0OtNYYpD9E0ZdMt9KbemD3cZT21pQ=; b=eFo2pH5wtw4eqM
	0AEffK1NtRgn0kEXGoWARAKWNnWYZsp0OyO5YkyodfSMaWSxsjb33pQ658ZouaVQ4DyRXlEICTRbN
	ggwu1LPJp4KeJK/KUjY6tk0fuZpNoC+oEmqrWp1W582XxUQFSxdVzoodeTMuC7s72JRYmz8n3B9ba
	PK/Fm9dLYHWR/+ad8R+UQ+E4SS21WVev2YRPtWnMXjshewWybhyKPQfqi9P4qiFjbV0TzLbMMs74z
	euRZrLHVy/HT2QIXgzVEKZealbUHJGO4qGFMeHJd91u+XquXbTotVvEO7SKfBU0TrZGtC/LsIyjDy
	WeCidcmL1Id7Tnn9zZcg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtZyu-0006Gu-9S; Tue, 12 Feb 2019 15:28:20 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtZyq-0006GX-8k
 for linux-arm-kernel@lists.infradead.org; Tue, 12 Feb 2019 15:28:17 +0000
Received: from devbox (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id F21E42084E;
 Tue, 12 Feb 2019 15:28:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1549985295;
 bh=s6/a0bPet2ex/8bTsaFozGz2TXCrghouCP9rpUuEGCw=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=e+rXngJFkKNT1anz/+MSTnbgC3Dh3SIgxAZ7P0ivef3UFARlmJYcyMZ5h1GZR+kZX
 oX9JQyya7YwgI7kw9MxHhSFLJ1ln5n90KqUfBgEdXi03wxZjw9OLsAEj/D6gpeq8uL
 WAN2xbzooof6IBXMD6s+MO3i7RLbcOAXqC2WvtYg=
Date: Wed, 13 Feb 2019 00:28:11 +0900
From: Masami Hiramatsu <mhiramat@kernel.org>
To: Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: [PATCH v2 4/4] arm64: kprobes: Use
 arch_populate_kprobe_blacklist()
Message-Id: <20190213002811.37186ba204f5eec7b9a30445@kernel.org>
In-Reply-To: <659f8c4f-c5ef-ade7-4fb3-aacff5779d73@arm.com>
References: <154753341900.31541.8135985235882849464.stgit@devbox>
 <154753353370.31541.14485875717131836689.stgit@devbox>
 <7f840cc8-4e62-e1d7-9035-4361204fc134@arm.com>
 <20190121222558.1ef0abc89a704597d6c3de7f@kernel.org>
 <20190208091519.GB6972@fuggles.cambridge.arm.com>
 <20190211221023.0bb43554647f99afce8dd060@kernel.org>
 <20190211155836.GA2692@fuggles.cambridge.arm.com>
 <659f8c4f-c5ef-ade7-4fb3-aacff5779d73@arm.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190212_072816_363949_0917ADF9 
X-CRM114-Status: GOOD (  16.12  )
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
Cc: Pratyush Anand <panand@redhat.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 linux-kernel <linux-kernel@vger.kernel.org>, James Morse <james.morse@arm.com>,
 "David A . Long" <dave.long@linaro.org>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, 11 Feb 2019 16:05:17 +0000
Marc Zyngier <marc.zyngier@arm.com> wrote:

> On 11/02/2019 15:58, Will Deacon wrote:
> > [+Marc]
> > 
> > On Mon, Feb 11, 2019 at 10:10:23PM +0900, Masami Hiramatsu wrote:
> >> On Fri, 8 Feb 2019 09:15:19 +0000
> >> Will Deacon <will.deacon@arm.com> wrote:
> >>> Did you send a new version of this series? I can't seem to spot it in my
> >>> inbox.
> >>
> >> Ah, OK. I just waited for James' patch series,
> >>
> >> https://patchwork.kernel.org/cover/10779489/
> >>
> >> Are those merged? I'd like to move this series on that.
> > 
> > Patches 2-4 are in mainline:
> > 
> > f7daa9c8fd19 arm64: hibernate: Clean the __hyp_text to PoC after resume
> > 8fac5cbdfe0f arm64: hyp-stub: Forbid kprobing of the hyp-stub
> > f2b3d8566d81 arm64: kprobe: Always blacklist the KVM world-switch code
> > 
> > Patch 1 is queued via kvm-arm (also for 5.0) but it doesn't seem to have
> > landed yet.
> 
> It was part of the pull request sent on Thursday[1], but Paolo hasn't
> pulled it yet.
> 
> Hopefully soon...

OK, then I'll send updated series since Patch1 is independent from
this series.

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
