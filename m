Return-Path: <SRS0=P47x=QF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D3A7C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 10:09:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7F0620881
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 10:09:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="japhrN2+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7F0620881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=wuHTRU5JD0BUjj9t8HicWLD7AfER4KvrpntCZ4Eh0bE=; b=japhrN2+EK9/PuYKNy28rw9+R
	Qmll+uEXumfwWgXju8vzRLQd4X397kwbFk+GLT5i4dSudMZAQvRIciytHPLx76lE9nHcuWoLM7wGY
	iF0iAUZRLqNt34qaMjfQzsC68xTQSfo+JWjyjj8lFikRvxhK1DyevTEZ2on5mQ8z9t27nxR8rf5Cs
	QO/xLgxrSW5G13kBZOfUNrrIiDWkFma1eB2KzqLnkS3Z3kwUgPjGgOBoS2nWOOm8pXoz40MjnWyKO
	uakFbgBufRAbN+TRcPulwH+MWB8BOWEW/2JNHyz4/lwo8aLew7dF5xhqfLXgV1PSOFu9UZd6ARnHb
	lxToGq2GA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goQKr-0001sz-Cv; Tue, 29 Jan 2019 10:09:41 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goQKn-0001rW-E3; Tue, 29 Jan 2019 10:09:38 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A4A2D80D;
 Tue, 29 Jan 2019 02:09:34 -0800 (PST)
Received: from [10.1.196.93] (en101.cambridge.arm.com [10.1.196.93])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1C6903F59C;
 Tue, 29 Jan 2019 02:09:32 -0800 (PST)
Subject: Re: [PATCH 1/2] arm64: Expose address bits (physical/virtual) via
 cpuinfo
To: bhsharma@redhat.com, linux-arm-kernel@lists.infradead.org
References: <1548709076-22317-1-git-send-email-bhsharma@redhat.com>
 <1548709076-22317-2-git-send-email-bhsharma@redhat.com>
From: Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <afa2417a-10d0-21f6-007f-e8eb7055f3d7@arm.com>
Date: Tue, 29 Jan 2019 10:09:31 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1548709076-22317-2-git-send-email-bhsharma@redhat.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190129_020937_477689_7176049D 
X-CRM114-Status: GOOD (  11.26  )
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
Cc: mark.rutland@arm.com, Steve.Capper@arm.com, catalin.marinas@arm.com,
 ard.biesheuvel@linaro.org, will.deacon@arm.com, bhupesh.linux@gmail.com,
 kexec@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Bupesh

On 28/01/2019 20:57, Bhupesh Sharma wrote:
> With ARMv8.2-LVA and LPA architecture extensions, arm64 hardware which
> supports these extensions can support upto 52-bit virtual and 52-bit
> physical addresses respectively.
> 
> Since at the moment we enable the support of these extensions via CONFIG
> flags, e.g.
>   - LPA via CONFIG_ARM64_PA_BITS_52, and
>   - LVA via CONFIG_ARM64_FORCE_52BIT
> 
> The easiest way a user can determine the physical/virtual
> addresses supported on the hardware, is via the '/proc/cpuinfo'
> interface.

Why do we need this information ?

Btw, this keeps coming up all the time and the answer to this approach is
always no. We cannot break the "unwritten" ABI of /proc/cpuinfo, again.
See :

https://patchwork.kernel.org/patch/8669301/


Suzuki

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
