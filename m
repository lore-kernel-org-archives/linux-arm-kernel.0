Return-Path: <SRS0=3lKL=PX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4039C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 15:47:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 905E620868
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 15:47:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="uGcSfG2u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 905E620868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Vyqkcom+JHF49mxXToFjDta1ZNaf89baTbIpam9r7rA=; b=uGcSfG2uvvkn8x
	XelZwHj6Bq4jiw6cXKuR1F+eh8L1wgJ2hTxwhKP20IMdgFljyp+TaaZKc+bFeLCJJBG9x3+ajjG0s
	A7YSJIvom92j5/ZTet0tsA/HUo4KJikOE1TyL3RYiCsm0sFAjDRv+9YzKnkqqhUh8Ws8UB/9u4X+5
	utAXK1r3hweA/LPKxcoq8N5UxlrubXK/E/pZwkR3WutlU8t0Cnhy2D7mscXkGiv/v/KLTwtdScxlt
	36GZl+Wt8GXMKYqhMBMhn87McEHqA1kF+VGTL1BmcqUV/vl7bYXHDhJM5pE7EfjHtIt1fi8ATwrDA
	94o6csh/vmH1gYM5jkHA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjQve-0001DO-Ej; Tue, 15 Jan 2019 15:47:02 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjQvb-0001D1-R4
 for linux-arm-kernel@lists.infradead.org; Tue, 15 Jan 2019 15:47:01 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 57A8580D;
 Tue, 15 Jan 2019 07:46:57 -0800 (PST)
Received: from [10.1.196.72] (e119884-lin.cambridge.arm.com [10.1.196.72])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6629B3F5BD;
 Tue, 15 Jan 2019 07:46:55 -0800 (PST)
Subject: Re: [PATCH v4 00/24] Unify vDSOs across more architectures
To: Thomas Gleixner <tglx@linutronix.de>
References: <20190115135539.24762-1-vincenzo.frascino@arm.com>
 <alpine.DEB.2.21.1901151630120.1561@nanos.tec.linutronix.de>
From: Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <efae0a15-9560-7bc3-e008-1ffa0f9b9297@arm.com>
Date: Tue, 15 Jan 2019 15:46:53 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1901151630120.1561@nanos.tec.linutronix.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190115_074659_878653_331846DF 
X-CRM114-Status: GOOD (  14.41  )
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
Cc: linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Will Deacon <will.deacon@arm.com>,
 Russell King <linux@armlinux.org.uk>, Ralf Baechle <ralf@linux-mips.org>,
 Mark Salyzyn <salyzyn@android.com>, Paul Burton <paul.burton@mips.com>,
 Peter Collingbourne <pcc@google.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 15/01/2019 15:31, Thomas Gleixner wrote:
> On Tue, 15 Jan 2019, Vincenzo Frascino wrote:
>>
>> This implementation contains the portings to the common library for: arm64,
>> compat mode for arm64, arm and mips.
> 
> And as you already copied most of the implementation from x86, then why is
> there no port of the x86 vdso ?
>

Did not think of doing that, but it is certainly something that can be done. I
will add it to v5.

> Thanks,
> 
> 	tglx
> 

-- 
Regards,
Vincenzo

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
