Return-Path: <SRS0=B2vk=P6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E67AEC282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 10:52:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7A8920844
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 10:52:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WmLpb34b";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="sPWVUfrT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7A8920844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=07ckeniK57NpzAq1f6AtXLVITPXLwXgXFyG7gFYxv1A=; b=WmLpb34b7usXN2
	3D0WON87o1lnjURvyI4QcXL/46zkWcLwbA9x6yYwoT6Mtyap0TAuOuqXQ1LrglYyiwXBgQakbLNJq
	PJrqsO7WBZXnLXQ7emfYx/yMb+ffzg0HfrvDSbIn33+OAyUzhKuw/RHwseXt9iNUMgPmd/wsY8VqV
	BoV+OewTUygyHh5Hq1aQ/mNGtN4Z++XToIWrYxH/wgA7wcoy3naGUSS1vhocbfI+OzJgqfJ2GbIBd
	Q4ZHj+KX0hd6kQbYn2V4Tf04/lGP7NzDfhYunz7Fx5VFlaBB4ySy5DGmKEkPRYw8X8WeZUXIAEeEB
	RUefoBkBQdmtQA5Q/9UQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gltf8-0003MY-U9; Tue, 22 Jan 2019 10:52:10 +0000
Received: from mail.skyhub.de ([5.9.137.197])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gltey-0003Jc-2t
 for linux-arm-kernel@lists.infradead.org; Tue, 22 Jan 2019 10:52:09 +0000
Received: from zn.tnic (p200300EC2BCBD900FDF77747CEA11C98.dip0.t-ipconnect.de
 [IPv6:2003:ec:2bcb:d900:fdf7:7747:cea1:1c98])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 22F3C1EC0242;
 Tue, 22 Jan 2019 11:51:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
 t=1548154309;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
 bh=ifhk+jBj4VVtTflpCeZN9RdhVe3s+C/MJnKsdSHY/7U=;
 b=sPWVUfrTtS7MShFgwxDIpeXuSBqYVS9aKVKn/WvSfmTwkQePzZnbbODq9dffILrXHxNN9e
 LE5ftSQ6zNzlTW4SFK6mkUI79/Oanqi8fRBHwQn8p+XPcUqipQLAfkfvarsrUQJxVb5lzb
 /cPxBzGR9UtFJYO648I5u+Tz/VCo3VE=
Date: Tue, 22 Jan 2019 11:51:43 +0100
From: Borislav Petkov <bp@alien8.de>
To: James Morse <james.morse@arm.com>
Subject: Re: [PATCH v7 22/25] ACPI / APEI: Kick the memory_failure() queue
 for synchronous errors
Message-ID: <20190122105143.GB26587@zn.tnic>
References: <20181203180613.228133-1-james.morse@arm.com>
 <20181203180613.228133-23-james.morse@arm.com>
 <9d153a07-aa7a-6e0c-3bd3-994a66f9639a@huawei.com>
 <5c775aa9-ea57-dea7-6083-c1e3fc160b29@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <5c775aa9-ea57-dea7-6083-c1e3fc160b29@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190122_025200_303739_C7F94048 
X-CRM114-Status: GOOD (  11.99  )
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
 Fan Wu <wufan@codeaurora.org>, linux-acpi@vger.kernel.org,
 Marc Zyngier <marc.zyngier@arm.com>, Catalin Marinas <catalin.marinas@arm.com>,
 Xie XiuQi <xiexiuqi@huawei.com>, Will Deacon <will.deacon@arm.com>,
 Christoffer Dall <christoffer.dall@arm.com>,
 Dongjiu Geng <gengdongjiu@huawei.com>,
 Wang Xiongfeng <wangxiongfeng2@huawei.com>, linux-mm@kvack.org,
 Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org, Len Brown <lenb@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Dec 10, 2018 at 07:15:13PM +0000, James Morse wrote:
> What happens if we miss MF_ACTION_REQUIRED?

AFAICU, the logic is to force-send a signal to the user process, i.e.,
force_sig_info() which cannot be ignored. IOW, an "enlightened" process
would know how to do recovery action from a memory error.

VS the action optional thing which you can handle at your leisure.

So the question boils down to what kind of severity do the errors
reported through SEA have? I mean, if the hw would go the trouble to do
the synchronous reporting, then something important must've happened and
it wants us to know about it and handle it.

> Surely the page still gets unmapped as its PG_Poisoned, an AO signal
> may be pending, but if user-space touches the page it will get an AR
> signal. Is this just about removing an extra AO signal to user-space?
>
> If we do need this, I'd like to pick it up from the CPER records, as x86's
> NOTIFY_NMI looks like it covers both AO/AR cases. (as does NOTIFY_SDEI). The
> Master/Target abort or Invalid-address types in the memory-error-section CPER
> records look like the best bet.

Right, and we do all kinds of severity mapping there aka ghes_severity()
so that'll be a good start, methinks.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
