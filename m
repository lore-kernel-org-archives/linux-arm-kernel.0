Return-Path: <SRS0=p0aQ=P2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E869EC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 16:29:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BAD3D20850
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 16:29:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="r2lMaoHb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAD3D20850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=UkqqB4OotQAxI3YTeP/kmURSoF0GxQuk09tXdN0i2y8=; b=r2lMaoHb+0DXqi
	nkkvcKMezuJismJDz8Wg8cWUYLsTQ5jDvB8g+LI0+6WsA7356sU9HKibCmkUe3Y3Odq0LstfnVRbl
	Ud3pL2bCMbypjKE1XDdPEqIyfm2hvWRmTLIBH078S0h8yldA+mQ0JAXUveT6r5pcUGCw+zWj5NJy0
	AWkKnNlW2QXlnzRPQQiEM52HHCwZzgzPVJ5c0tUL78rKq/wCK3pCI4kuExPm1BGwadgJK2wS/Sxsb
	YPN56rmr2wrEMmcmKWeuxDP1MrfOQ62BZQoKe/gdQ+jm1hnyanDq4fU39RouRUPhUSQeTayYjJYoD
	5thLLkTPDmUpuXjEJ55A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkX1S-0001Kq-Kp; Fri, 18 Jan 2019 16:29:34 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkX1P-0001KU-Cw
 for linux-arm-kernel@lists.infradead.org; Fri, 18 Jan 2019 16:29:32 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E93351596;
 Fri, 18 Jan 2019 08:29:30 -0800 (PST)
Received: from [10.1.196.69] (e112269-lin.cambridge.arm.com [10.1.196.69])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F2C8A3F557;
 Fri, 18 Jan 2019 08:29:28 -0800 (PST)
Subject: Re: [PATCH 2/3] cpufreq: update headers to use STUB_UNLESS macro
To: Andrew Murray <andrew.murray@arm.com>,
 Masahiro Yamada <yamada.masahiro@socionext.com>,
 Arnd Bergmann <arnd@arndb.de>, Kees Cook <keescook@chromium.org>,
 Andrew Morton <akpm@linux-foundation.org>
References: <1547827230-55132-1-git-send-email-andrew.murray@arm.com>
 <1547827230-55132-3-git-send-email-andrew.murray@arm.com>
From: Steven Price <steven.price@arm.com>
Message-ID: <47ed4a94-9221-00b1-b35e-a1f17b421a28@arm.com>
Date: Fri, 18 Jan 2019 16:29:27 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1547827230-55132-3-git-send-email-andrew.murray@arm.com>
Content-Language: en-GB
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190118_082931_441504_07A73FB0 
X-CRM114-Status: GOOD (  16.56  )
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
Cc: Catalin Marinas <catalin.marinas@arm.com>, rjw@rjwysocki.net,
 linux-kernel@vger.kernel.org, Will Deacon <will.deacon@arm.com>,
 Grant Likely <Grant.Likely@arm.com>, Dave P Martin <Dave.Martin@arm.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 18/01/2019 16:00, Andrew Murray wrote:
> Use the STUB_UNLESS macro to simplify function declaration.
> 
> Signed-off-by: Andrew Murray <andrew.murray@arm.com>

Reviewed-by: Steven Price <steven.price@arm.com>

> ---
>  include/linux/cpufreq.h | 21 ++++++---------------
>  1 file changed, 6 insertions(+), 15 deletions(-)
> 
> diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
> index c86d6d8..2c53cae 100644
> --- a/include/linux/cpufreq.h
> +++ b/include/linux/cpufreq.h
> @@ -159,21 +159,12 @@ struct cpufreq_policy {
>  #define CPUFREQ_SHARED_TYPE_ALL	 (2) /* All dependent CPUs should set freq */
>  #define CPUFREQ_SHARED_TYPE_ANY	 (3) /* Freq can be set from any dependent CPU*/
>  
> -#ifdef CONFIG_CPU_FREQ
> -struct cpufreq_policy *cpufreq_cpu_get_raw(unsigned int cpu);
> -struct cpufreq_policy *cpufreq_cpu_get(unsigned int cpu);
> -void cpufreq_cpu_put(struct cpufreq_policy *policy);
> -#else
> -static inline struct cpufreq_policy *cpufreq_cpu_get_raw(unsigned int cpu)
> -{
> -	return NULL;
> -}
> -static inline struct cpufreq_policy *cpufreq_cpu_get(unsigned int cpu)
> -{
> -	return NULL;
> -}
> -static inline void cpufreq_cpu_put(struct cpufreq_policy *policy) { }
> -#endif
> +STUB_UNLESS(CONFIG_CPU_FREQ, return NULL,
> +struct cpufreq_policy *cpufreq_cpu_get_raw(unsigned int cpu));
> +STUB_UNLESS(CONFIG_CPU_FREQ, return NULL,
> +struct cpufreq_policy *cpufreq_cpu_get(unsigned int cpu));
> +STUB_UNLESS(CONFIG_CPU_FREQ,
> +void cpufreq_cpu_put(struct cpufreq_policy *policy));
>  
>  static inline bool policy_is_shared(struct cpufreq_policy *policy)
>  {
> 


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
