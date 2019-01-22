Return-Path: <SRS0=B2vk=P6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84494C282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 16:03:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4ED4821726
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 16:03:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="EUDpYZzp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4ED4821726
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=fpnVGTmyWVRk30VA8S4dL3c+yD3xlLOD49ZfGlzyH+8=; b=EUDpYZzpX7Lp8IFqTZvQCpX05
	K9Wk2qWTdOHsP3Rhb+EgfGPQNMu8B1+IlV4qj2ol/WytMpRhwOt0cuwXN/h+njnuQJP7IQUu0Hmq1
	my9UuAk2vNVoePeJWs9jmVQzWAWwM0xOYQntUaReo9Eb+C/XPd6jges1a2RP8wSm9tNpXaLyvT3L4
	MtSpNS3Q/DGDxBYWnipOP6wJ1d9yzbB479Xt1+dtcdfcycSzB6omFpgCwx55LJyng4o3dOuJ9/9mt
	hiCP7ytab+F/QdPt9rGn1eQ+52jnvML5Nmxdms08rZFmUgMUngvVjNUZPLTTra+gd3/tf6pMNiArf
	LL6JkobTQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glyWj-0000Rw-LQ; Tue, 22 Jan 2019 16:03:49 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glyWc-0000RT-3B
 for linux-arm-kernel@lists.infradead.org; Tue, 22 Jan 2019 16:03:47 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 29003A78;
 Tue, 22 Jan 2019 08:03:39 -0800 (PST)
Received: from [10.37.12.103] (unknown [10.37.12.103])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 465E73F589;
 Tue, 22 Jan 2019 08:03:37 -0800 (PST)
Subject: Re: [RFC PATCH 1/8] arm64/fpsimd: Update documentation of do_sve_acc
To: Mark Rutland <mark.rutland@arm.com>
References: <20190118164610.8123-1-julien.grall@arm.com>
 <20190118164610.8123-2-julien.grall@arm.com>
 <20190121121337.GA47506@lakrids.cambridge.arm.com>
From: Julien Grall <julien.grall@arm.com>
Message-ID: <eeaeeafe-3a7d-7f90-14fa-72561b102eb5@arm.com>
Date: Tue, 22 Jan 2019 16:03:35 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190121121337.GA47506@lakrids.cambridge.arm.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190122_080342_141364_2D1119B0 
X-CRM114-Status: GOOD (  13.77  )
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
Cc: tokamoto@jp.fujitsu.com, Anton.Kirilov@arm.com, catalin.marinas@arm.com,
 will.deacon@arm.com, oleg@redhat.com, alex.bennee@linaro.org,
 Dave.Martin@arm.com, linux-arm-kernel@lists.infradead.org, Daniel.Kiss@arm.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Mark,

On 1/21/19 12:13 PM, Mark Rutland wrote:
> On Fri, Jan 18, 2019 at 04:46:03PM +0000, Julien Grall wrote:
>> TIF_SVE is cleared by fpsimd_restore_current_state() not
>> task_fpsimd_load(). Update the documentatio of do_sve_acc to reflect
>> this behavior.
> 
> AFAICT (in v5.0-rc2), fpsimd_restore_current_state() clears
> TIF_FOREIGN_FPSTATE, not TIF_SVE.
> 
> I think you mean that fpsimd_restore_current_state() enabled/disables
> the trap (via fpsimd_bind_task_to_cpu()), based on TIF_SVE. Is that
> right?

That's correct. I will reword the commit message and the documentation 
below.

Cheers,

-- 
Julien Grall

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
