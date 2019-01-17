Return-Path: <SRS0=6Gta=PZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 966D0C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 15:48:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64D7E20855
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 15:48:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="sw192WlN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64D7E20855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=sfDXfRiWbgcvQjknkBbkLAAauSPkaOY9FB/Wk6XMtXA=; b=sw192WlNN3hgK5
	qb7+J+6NtWo7R97VlynZjUC2Hju5d+5gWXL2odgEJjdb+urioGuzysDcsTAzQUEx3mWqQlpB7WV+e
	yAN6veYnrB7ucMoSJAxZZyRTKHaGXkjqPTYl+gWkKhQZsDyw09+R1ZuLVPV4uN+JazUXTRe7g9C4n
	sNSY/YjeHXK77hvUAie6trwfy2XrMaPNd2JCOI3MGEn/N3d8G86j1o87VQoGNBiV1YLNNDh32LQog
	WTaKBipKe/DPt7jrQzibK20Il07mYQyuq0ryGJGCCBlWECR960YZ84jCH99i/iZt/OMWKXFXymE96
	0q7JwfDB1j2ohkjk2x0g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gk9uA-0002T9-SU; Thu, 17 Jan 2019 15:48:30 +0000
Received: from verein.lst.de ([213.95.11.211] helo=newverein.lst.de)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gk9u7-0002SN-Uy
 for linux-arm-kernel@lists.infradead.org; Thu, 17 Jan 2019 15:48:29 +0000
Received: by newverein.lst.de (Postfix, from userid 2005)
 id EAFF368CEB; Thu, 17 Jan 2019 16:48:21 +0100 (CET)
Date: Thu, 17 Jan 2019 16:48:21 +0100
From: Torsten Duwe <duwe@lst.de>
To: Julien Thierry <julien.thierry@arm.com>
Subject: Re: [PATCH v6] arm64: implement ftrace with regs
Message-ID: <20190117154821.GC9094@lst.de>
References: <20190104141053.360F768D93@newverein.lst.de>
 <8eb70db4-92a2-95a2-075c-f26690aab3ed@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <8eb70db4-92a2-95a2-075c-f26690aab3ed@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190117_074828_146494_7C4ADFB8 
X-CRM114-Status: GOOD (  10.41  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, Arnd Bergmann <arnd@arndb.de>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
 AKASHI Takahiro <takahiro.akashi@linaro.org>, Ingo Molnar <mingo@redhat.com>,
 Josh Poimboeuf <jpoimboe@redhat.com>,
 Amit Daniel Kachhap <amit.kachhap@arm.com>, live-patching@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Jan 16, 2019 at 09:57:39AM +0000, Julien Thierry wrote:
> 
> I wanted to test this patch (and try to benchmark having the "mov x9,
> x30" always present in function prelude vs having two nops), but I
> cannot get this patch to apply (despite having a version including both
> commits below).
> 
> Could you provide a git branch from which I could try to rebase the
> patch? (Or a new version of the series)

It also applies with just a single, harmless fuzz 1 onto 5.0-rc2.
Does that help?

I'm currently over v7, with Mark's requests included and the mov patching
done only once at bootup...

	Torsten


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
