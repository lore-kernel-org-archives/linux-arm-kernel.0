Return-Path: <SRS0=tmGn=OI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 335ADC43441
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 18:23:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0CBCF21104
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 18:23:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="M/1WccYP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CBCF21104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=qb4B9T9e0Tawdpe6qN1511iCNk9Wrm3EHSxk6pKYGV0=; b=M/1WccYP10WpGm
	asMG9ITjxIPMLerxM0lNo/AIMx4eb2zQ043b4I/4DzohsLtRvC19VpMEOuayMjTQHLq8JHXrfeADD
	e8eWNzGewpf+r5maoMKspltHWkndSUWDUR9a0k19wbv1If/I8OoppmMsTNJX9FUdG708xajta00Bd
	uLABRzbleeaGpYheR7wrlGmxjPWZoCEAsWIwm+N8GO/L0JPJfepClyjYRqfg+7w0RsZC5y7uP/Ha8
	aMl3UcrPq/peeM11H8dHlpNyHznfDxUHHc9bRiIk1NAssADN4Ovz3abdKqfYXC8vq5IQ4VljuQA7I
	gyUfW8kikG+8O4102dgQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSQyW-0007rl-PG; Thu, 29 Nov 2018 18:23:44 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSQyT-0007qL-Ek
 for linux-arm-kernel@lists.infradead.org; Thu, 29 Nov 2018 18:23:42 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 09C9780D;
 Thu, 29 Nov 2018 10:23:31 -0800 (PST)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.113])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id
 E2C933F575; Thu, 29 Nov 2018 10:23:26 -0800 (PST)
Date: Thu, 29 Nov 2018 18:23:24 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Andrey Konovalov <andreyknvl@google.com>
Subject: Re: [PATCH v8 2/8] uaccess: add untagged_addr definition for other
 arches
Message-ID: <20181129182323.GI22027@arrakis.emea.arm.com>
References: <cover.1541687720.git.andreyknvl@google.com>
 <c9028422854fb5bfb79d798397b30d4701207062.1541687720.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <c9028422854fb5bfb79d798397b30d4701207062.1541687720.git.andreyknvl@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181129_102341_494519_FB6295A0 
X-CRM114-Status: GOOD (  11.24  )
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 Kate Stewart <kstewart@linuxfoundation.org>, linux-doc@vger.kernel.org,
 Will Deacon <will.deacon@arm.com>, Kostya Serebryany <kcc@google.com>,
 linux-kselftest@vger.kernel.org, Chintan Pandya <cpandya@codeaurora.org>,
 Shuah Khan <shuah@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 linux-arch@vger.kernel.org, Jacob Bramley <Jacob.Bramley@arm.com>,
 Dmitry Vyukov <dvyukov@google.com>, Evgeniy Stepanov <eugenis@google.com>,
 Kees Cook <keescook@chromium.org>, Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
 Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
 linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
 Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
 Lee Smith <Lee.Smith@arm.com>, Andrew Morton <akpm@linux-foundation.org>,
 Robin Murphy <robin.murphy@arm.com>,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Nov 08, 2018 at 03:36:09PM +0100, Andrey Konovalov wrote:
> diff --git a/include/linux/uaccess.h b/include/linux/uaccess.h
> index efe79c1cdd47..c045b4eff95e 100644
> --- a/include/linux/uaccess.h
> +++ b/include/linux/uaccess.h
> @@ -13,6 +13,10 @@
>  
>  #include <asm/uaccess.h>
>  
> +#ifndef untagged_addr
> +#define untagged_addr(addr) addr
> +#endif

Nitpick: add braces around (addr). Otherwise:

Acked-by: Catalin Marinas <catalin.marinas@arm.com>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
