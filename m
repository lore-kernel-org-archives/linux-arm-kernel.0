Return-Path: <SRS0=x1Tr=QU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90244C282CE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 13:19:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F45A222B1
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 13:19:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hDV8LqpU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F45A222B1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=zimLMn6f7I4e2VSrkmh+xg0oGxZAD43SGKU/hm9fHEA=; b=hDV8LqpUx4Tehx
	ivzbTP/BQt9H0CjhSMuIrNqoD6jKvPnkQ0loOryuexgmKOF0OYfDob1MSvHHBjlEwaxk/wwEeN9r0
	O5yzLb/hfUhLunLCQO7VBsVAZwoWI4AkAvqWnu/gTepGfjiYbF+wFN9rrD51ARyqRdT10SwUG+C48
	Frn4f5GUXdgefcAvzuhtEz0kem2ORX+RgkGTNu1Sj4MJVVWFcNvxf96uXUxgfaUNzG2j/iECjbmAR
	NuNuuqPQdTZN6hYOJaOPC3+XcoNb/qQQCYve0FaxpAVtYzylNN0mtfVwHFwdH/M+qy/BLWhgktu8K
	uGo3ckqCRLJohL/bcikA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtuRY-0006Lb-C1; Wed, 13 Feb 2019 13:19:16 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtuRU-0006KL-6n
 for linux-arm-kernel@lists.infradead.org; Wed, 13 Feb 2019 13:19:14 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A24F680D;
 Wed, 13 Feb 2019 05:19:11 -0800 (PST)
Received: from brain-police (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EEE393F557;
 Wed, 13 Feb 2019 05:19:09 -0800 (PST)
Date: Wed, 13 Feb 2019 13:19:06 +0000
From: Will Deacon <will.deacon@arm.com>
To: "Zhang, Lei" <zhang.lei@jp.fujitsu.com>
Subject: Re: [PATCH v3 0/1] arm64: Add workaround for Fujitsu A64FX erratum
 010001
Message-ID: <20190213131906.GB5875@brain-police>
References: <8898674D84E3B24BA3A2D289B872026A6A2C04E6@G01JPEXMBKW03>
 <cb7544e2-bd85-df4c-1f48-0afeedefc962@arm.com>
 <8898674D84E3B24BA3A2D289B872026A6A3090AC@G01JPEXMBKW03>
 <20190201105144.GA27140@fuggles.cambridge.arm.com>
 <8898674D84E3B24BA3A2D289B872026A6A30C3CB@G01JPEXMBKW03>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <8898674D84E3B24BA3A2D289B872026A6A30C3CB@G01JPEXMBKW03>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190213_051913_715740_33FC8476 
X-CRM114-Status: GOOD (  15.90  )
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
Cc: 'Mark Rutland' <mark.rutland@arm.com>,
 'Catalin Marinas' <catalin.marinas@arm.com>,
 'James Morse' <james.morse@arm.com>,
 "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
 "'linux-arm-kernel@lists.infradead.org'"
 <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Feb 05, 2019 at 01:32:07PM +0000, Zhang, Lei wrote:
> > -----Original Message-----
> > From: linux-arm-kernel
> > [mailto:linux-arm-kernel-bounces@lists.infradead.org] On Behalf Of
> > Will Deacon
> > Sent: Friday, February 01, 2019 7:52 PM
> > To: Zhang, Lei 
> > Cc: 'Mark Rutland'; 'Catalin Marinas'; 'James Morse';
> > 'linux-kernel@vger.kernel.org';
> > 'linux-arm-kernel@lists.infradead.org'
> > Subject: Re: [PATCH v3 0/1] arm64: Add workaround for Fujitsu A64FX
> > erratum 010001
> 
> > So I guess we should boot with NFD1 clear, and then set it only when we
> > realise we're not on an A64FX?
> 
> In my patch, I do similar things at __cpu_setup which we 
> set NFD1=1 on all processors except A64FX.
> 
> Do you mean we would better to change the place where we 
> set/clear NFD1?

Yes, I think we should keep the code as simple as we can:

  - Don't set NFDx=1 in proc.S for any CPU
  - Later, in C code, we can set the bit for any CPU that is not an affected
    A64FX (this can be a simple MIDR check).

Does that work?

Will

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
