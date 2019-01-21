Return-Path: <SRS0=flTa=P5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67203C2F3BE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 13:35:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3223F2085A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 13:35:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="sAbdsRAO";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="i+93qtB5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3223F2085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=wC/g5QZQB7/febxDJZwgX/n5uVxvUaJbmxuqB4L5dS0=; b=sAbdsRAOdECW8d
	qlbKDIUU0fcuf3Sq2sSN/QSN/OEFlo6+ze9KTnmOgU22oAXRxZUyVxw+ySPQ98AIf1o6JBFSDzW9z
	QjyXjVktg8/L/YWnK+ErcByqFj91eIr1HXlUrCeK4YMQPQ+pFTRHpM43zTLNUQvGhJ/g/uTWHhavt
	zkHoEXs2XUW3v4Dgvcyu2JjYTfqE4x5FUKQ2iNsXMfXdZH7bKcxXbHDjJqqDR4oJrbKHvt+7xKEmq
	UW+f1RmCuaReTPfZCOdcDXU01+iB6BZpzwOVUA1y9/0CH4yC6fs+8z7t5Ucd+q9tiMr9Vb6ZP5mrc
	tMNvD9Fpi7MaVHp7TD3A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glZjy-00041C-KA; Mon, 21 Jan 2019 13:35:50 +0000
Received: from mail.skyhub.de ([5.9.137.197])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glZjv-00040e-Le
 for linux-arm-kernel@lists.infradead.org; Mon, 21 Jan 2019 13:35:49 +0000
Received: from zn.tnic (p200300EC2BC62500F05176FA1988078F.dip0.t-ipconnect.de
 [IPv6:2003:ec:2bc6:2500:f051:76fa:1988:78f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C23791EC035B;
 Mon, 21 Jan 2019 14:35:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
 t=1548077745;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
 bh=AAXruR8r7yhx/w1MyZPiyUNgdUVBL6mx5cFaqpVEzC4=;
 b=i+93qtB50YZHTjDnuVue1sgphHVDH0tUwReBc7xBLcg7HWUdJoajyUf1jjZ33/P3wC4PDf
 9Afxu2vXKT+E4Dip+Joe6ALs8oJNg6t9ASUo6LQwWN/ZGC48gu8QXTikKZgD3tQ4bE+eht
 ZreG8zr63Ap/eduzxlmap2m0TW42Txg=
Date: Mon, 21 Jan 2019 14:35:40 +0100
From: Borislav Petkov <bp@alien8.de>
To: James Morse <james.morse@arm.com>
Subject: Re: [PATCH v7 17/25] ACPI / APEI: Pass ghes and estatus separately
 to avoid a later copy
Message-ID: <20190121133539.GH29166@zn.tnic>
References: <20181203180613.228133-1-james.morse@arm.com>
 <20181203180613.228133-18-james.morse@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181203180613.228133-18-james.morse@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190121_053547_853144_9D68DD08 
X-CRM114-Status: GOOD (  12.26  )
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

On Mon, Dec 03, 2018 at 06:06:05PM +0000, James Morse wrote:
> The NMI-like notifications scribble over ghes->estatus, before
> copying it somewhere else. If this interrupts the ghes_probe() code
> calling ghes_proc() on each struct ghes, the data is corrupted.
> 
> All the NMI-like notifications should use a queued estatus entry
> from the beginning, instead of the ghes version, then copying it.
> To do this, break up any use of "ghes->estatus" so that all
> functions take the estatus as an argument.
> 
> This patch just moves these ghes->estatus dereferences into separate

s/This patch just moves/Move/

> arguments, no change in behaviour. struct ghes becomes unused in
> ghes_clear_estatus() as it only wanted ghes->estatus, which we now
> pass directly. This is removed.
> 
> Signed-off-by: James Morse <james.morse@arm.com>

...

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
