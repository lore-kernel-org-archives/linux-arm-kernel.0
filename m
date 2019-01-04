Return-Path: <SRS0=E6Hv=PM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1725C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 18:02:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B657D218D3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 18:02:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="tu7YtcPq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B657D218D3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=R3IYxo9Qk0czCFyoGD0zKvuqRH8zc6qEP9h0AZxDaMo=; b=tu7YtcPq1bpx/I
	kIWWYTkSp20rYWmex98wF1ea1q9EpqktRUars7Kyd57HLkn7U14zyvfVwy8xVuebPeKkSw6/sG9FJ
	PtKc6qVESHWQS/gnZtowXpOxYVjFqdTMiwBkgSmAhyEnL/AyzOJHS015MrBR3ng3eLMxZYxLuQv8l
	ddljXVh/Ydoq1+ZN5QNoDpY0HmqcPKsK9oV/f1AJOkEJDv+HY4BVfrBkiIDuQIlj65Lm+K+CuR/Bn
	QfXvXjW1i1NZBDTj/eCQPJjrPLVtJorIun9gF5T5bMqaIlX4BAvbqxOGBneEV8A2aH99swRC2Vi06
	u1mIuNbp0XjmMlGfbWlA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gfTng-0007G0-09; Fri, 04 Jan 2019 18:02:28 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gfTnc-0006vo-40
 for linux-arm-kernel@lists.infradead.org; Fri, 04 Jan 2019 18:02:25 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D4CCDEBD;
 Fri,  4 Jan 2019 10:02:21 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 955E83F5D4;
 Fri,  4 Jan 2019 10:02:18 -0800 (PST)
Date: Fri, 4 Jan 2019 18:02:16 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v6 07/13] arm64: add basic pointer authentication support
Message-ID: <20190104180215.GB7157@lakrids.cambridge.arm.com>
References: <20181207183931.4285-1-kristina.martsenko@arm.com>
 <20181207183931.4285-8-kristina.martsenko@arm.com>
 <20190103202901.GA21564@amd>
 <681a2835-1a70-f3c3-3534-7b4cf6139cac@arm.com>
 <20190104093340.GA28150@amd>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190104093340.GA28150@amd>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190104_100224_227095_D50D947B 
X-CRM114-Status: GOOD (  18.34  )
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
Cc: Andrew Jones <drjones@redhat.com>, linux-kernel@vger.kernel.org,
 Jacob Bramley <jacob.bramley@arm.com>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Marc Zyngier <marc.zyngier@arm.com>, Catalin Marinas <catalin.marinas@arm.com>,
 Adam Wallis <awallis@codeaurora.org>,
 Suzuki K Poulose <suzuki.poulose@arm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Christoffer Dall <christoffer.dall@arm.com>,
 Kristina Martsenko <kristina.martsenko@arm.com>, kvmarm@lists.cs.columbia.edu,
 Cyrill Gorcunov <gorcunov@gmail.com>, Will Deacon <will.deacon@arm.com>,
 Ramana Radhakrishnan <ramana.radhakrishnan@arm.com>,
 Amit Kachhap <amit.kachhap@arm.com>, Dave P Martin <dave.martin@arm.com>,
 linux-arm-kernel@lists.infradead.org, Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Jan 04, 2019 at 10:33:40AM +0100, Pavel Machek wrote:
> On Fri 2019-01-04 09:21:30, Marc Zyngier wrote:
> > On 03/01/2019 20:29, Pavel Machek wrote:
> > > On Fri 2018-12-07 18:39:25, Kristina Martsenko wrote:
> > >> From: Mark Rutland <mark.rutland@arm.com>
> > >> 
> > >> This patch adds basic support for pointer authentication,
> > >> allowing userspace to make use of APIAKey, APIBKey, APDAKey,
> > >> APDBKey, and APGAKey. The kernel maintains key values for each
> > >> process (shared by all threads within), which are initialised to
> > >> random values at exec()
> > > time.
> > > 
> > > ...
> > > 
> > >> +/* + * We give each process its own keys, which are shared by
> > >> all threads. The keys + * are inherited upon fork(), and
> > >> reinitialised upon exec*(). + */ +struct ptrauth_keys { +	struct
> > >> ptrauth_key apia; +	struct ptrauth_key apib; +	struct ptrauth_key
> > >> apda; +	struct ptrauth_key apdb; +	struct ptrauth_key apga; +};
> > > 
> > > intstruction_a, data_a, generic_a? Should be easier to understand
> > > than "apdb" ...
> > 
> > ... until you realize that these names do match the documentation,
> > which makes it even easier to understand how the code uses the
> > architecture.
> 
> See how not even the commit log matches the documentation then?

The commit message exactly matches the documentation, as it refers to:

	APIAKey, APIBKey, APDAKey, APDBKey, and APGAKey

... which are the architected names for those registers, in all the
documentation.

Searching "apga" in the ARM ARM finds all of the relevant information on
APGAKey_EL1. Searching "generic_a" finds precisely nothing, as it's a
term which you invented, that no-one else has previously used.

Likewise for the other key names.

> Naming something "apdb" is just bad... Just because the documentation
> is evil does not mean it should be followed...

It is in no way evil to use the documented names for things.

It is unhelpful to make up terminology that no-one else uses.

Mark.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
