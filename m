Return-Path: <SRS0=flTa=P5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10B6AC2F3A6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 13:01:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D177D20855
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 13:01:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="FsPSL8vb";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="f96Bghvx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D177D20855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=OLM1awIQCplq7XUPZEEFwKd4WHONYLZMayTNBXnfXco=; b=FsPSL8vbdy3eay
	drRI2Scnzevw3lN6CByDMBsPDR6QjGs3xf1ABJIQM3nGDqGTJXdJwZavMg1kKZUJQJVPLIm9T08E8
	vHaz+sw/gsXdx1FrAPD0TKkVS193NQTXtpPGJnMEvt64z9xNC7EJIsnMMAXoc7rkzIWJ7oQGf+9pw
	8bDIIHdRgfBRdpWtAwpinUgogva7MSdsTdUV/5Sl73weeIlyWazFvPxFamIM68exofOaNrVbzbyCC
	PxGWhsojkUeYXqaAW5Agu5PBjMzJ0+yGs74JIO3jBjedhN80mNhNqiPgPwL3oc2Yi6ChpnA6ZDPHb
	sp8nWhyTFlCznoP3jV3Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glZCj-0005hz-6z; Mon, 21 Jan 2019 13:01:29 +0000
Received: from mail.skyhub.de ([2a01:4f8:190:11c2::b:1457])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glZCe-0005h3-QK
 for linux-arm-kernel@lists.infradead.org; Mon, 21 Jan 2019 13:01:27 +0000
Received: from zn.tnic (p200300EC2BC62500F05176FA1988078F.dip0.t-ipconnect.de
 [IPv6:2003:ec:2bc6:2500:f051:76fa:1988:78f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5A5881EC035B;
 Mon, 21 Jan 2019 14:01:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
 t=1548075678;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
 bh=1KhfegT6BuPv+XdjRnoxT5UvJ0xWff7XoXCL1102FMA=;
 b=f96BghvxApniTOAx2J6a1D2FVfgETXBjjA4Q9VwE2Vk1Ys9nx6/3LX0bFPG2Z4Fg59FP8T
 qGrl4X9giy4DHoBJYeBOUqx2q69LYB5gklg7SbKQKVOwOQXeZkHgb7e/pegawFjd7/ZUyf
 gsPOObFEE5/YWoc3dSoGsajpbjvhdaM=
Date: Mon, 21 Jan 2019 14:01:11 +0100
From: Borislav Petkov <bp@alien8.de>
To: James Morse <james.morse@arm.com>
Subject: Re: [PATCH v7 11/25] ACPI / APEI: Move NOTIFY_SEA between the
 estatus-queue and NOTIFY_NMI
Message-ID: <20190121130111.GG29166@zn.tnic>
References: <20181203180613.228133-1-james.morse@arm.com>
 <20181203180613.228133-12-james.morse@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181203180613.228133-12-james.morse@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190121_050125_000990_3649F4FE 
X-CRM114-Status: GOOD (  13.33  )
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
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Tony Luck <tony.luck@intel.com>,
 Fan Wu <wufan@codeaurora.org>, linux-mm@kvack.org,
 Marc Zyngier <marc.zyngier@arm.com>, Catalin Marinas <catalin.marinas@arm.com>,
 Xie XiuQi <xiexiuqi@huawei.com>, Will Deacon <will.deacon@arm.com>,
 Christoffer Dall <christoffer.dall@arm.com>,
 Dongjiu Geng <gengdongjiu@huawei.com>, linux-acpi@vger.kernel.org,
 Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org, Len Brown <lenb@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Dec 03, 2018 at 06:05:59PM +0000, James Morse wrote:
> The estatus-queue code is currently hidden by the NOTIFY_NMI #ifdefs.
> Once NOTIFY_SEA starts using the estatus-queue we can stop hiding
> it as each architecture has a user that can't be turned off.
> 
> Split the existing CONFIG_HAVE_ACPI_APEI_NMI block in two, and move
> the SEA code into the gap.
> 
> This patch moves code around ... and changes the stale comment

s/This patch moves/Move the/

> describing why the status queue is necessary: printk() is no
> longer the issue, its the helpers like memory_failure_queue() that
> aren't nmi safe.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
>  drivers/acpi/apei/ghes.c | 113 ++++++++++++++++++++-------------------
>  1 file changed, 59 insertions(+), 54 deletions(-)

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
