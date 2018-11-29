Return-Path: <SRS0=tmGn=OI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CE24C43610
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 18:22:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 248D921104
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 18:22:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="akf0/6dF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 248D921104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=KuJlS1UGmAKxvILlE5J+LZax9fP6lrtqHHsHSLnfcQ8=; b=akf0/6dFRByPeU
	rPNbYCOGXjTs2rDWMaBmxIlqw6Wy45kMlmKG/OKM0GWK5Iy8yohWC5rNjyrJxCvdQlMlkS28l4mDc
	ymAARPv+NVWU6ntu+9GpXe+0bjvT/tRCI9amh01zuiwjX4qtRU7RXDe0Q2oltjOo/p+mMVkRO6nsj
	mX0m6Bs5hWpCHBfldRmpN2kDlSCMW7Plm+lZY8SkHceqj3IlSzClpBiodajubn/fnzu+cqIHT0al0
	JOVPm/vLQk1YfNZbkzNRR6d+LSQ5f5QT5vnEhkTDAMlnupYYNzdgWIKPMK52WYjxmXQO6EPMNrrcv
	oxL3gmKbh51/OIXrVGVw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSQxS-0007Xs-Pt; Thu, 29 Nov 2018 18:22:38 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSQxP-0007Wg-Oe
 for linux-arm-kernel@lists.infradead.org; Thu, 29 Nov 2018 18:22:37 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3B03480D;
 Thu, 29 Nov 2018 10:22:25 -0800 (PST)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.113])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id
 213993F575; Thu, 29 Nov 2018 10:22:20 -0800 (PST)
Date: Thu, 29 Nov 2018 18:22:18 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Andrey Konovalov <andreyknvl@google.com>
Subject: Re: [PATCH v8 1/8] arm64: add type casts to untagged_addr macro
Message-ID: <20181129182218.GH22027@arrakis.emea.arm.com>
References: <cover.1541687720.git.andreyknvl@google.com>
 <4a4063a3e074608b99cf22ab447fecc36d056251.1541687720.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4a4063a3e074608b99cf22ab447fecc36d056251.1541687720.git.andreyknvl@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181129_102235_892869_D7CA828D 
X-CRM114-Status: GOOD (  18.69  )
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

On Thu, Nov 08, 2018 at 03:36:08PM +0100, Andrey Konovalov wrote:
> This patch makes the untagged_addr macro accept all kinds of address types
> (void *, unsigned long, etc.) and allows not to specify type casts in each
> place where it is used. This is done by using __typeof__.
> 
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> ---
>  arch/arm64/include/asm/uaccess.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/include/asm/uaccess.h b/arch/arm64/include/asm/uaccess.h
> index 07c34087bd5e..c1325271e368 100644
> --- a/arch/arm64/include/asm/uaccess.h
> +++ b/arch/arm64/include/asm/uaccess.h
> @@ -101,7 +101,8 @@ static inline unsigned long __range_ok(const void __user *addr, unsigned long si
>   * up with a tagged userland pointer. Clear the tag to get a sane pointer to
>   * pass on to access_ok(), for instance.
>   */
> -#define untagged_addr(addr)		sign_extend64(addr, 55)
> +#define untagged_addr(addr)		\
> +	((__typeof__(addr))sign_extend64((__u64)(addr), 55))

Nitpick: same comment as here (use u64):

http://lkml.kernel.org/r/20181123173739.osgvnnhmptdgtlnl@lakrids.cambridge.arm.com

Acked-by: Catalin Marinas <catalin.marinas@arm.com>

(not acking the whole series just yet, only specific patches to remember
what I reviewed)

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
