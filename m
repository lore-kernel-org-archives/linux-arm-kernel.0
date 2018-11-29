Return-Path: <SRS0=tmGn=OI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFC3DC04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 22:41:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E42C2145D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 22:41:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ifCB/MXe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E42C2145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:
	In-Reply-To:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Iqo9UUNRZO6qnD59CriF+4CyGhsdXn2iuww+B7N73oM=; b=ifCB/MXeWf9MHn
	ko64b/bKDhm21ncI8x2eXhZxOxJWy+o2Xjbgkf+RZLUuiAqVTJWMzf27h3fjp+Nkt1TQOf+hC9u0R
	MiAYuXTArfLCRV9lQ0kTZpWnMS/XSC/2KWc2+t2KxrE3I11nd8laVeIrRtARiLnrhdCBoheGjDs95
	V4Z3jOEfVd76qYruXEdLM1CtWu1+AeLz6pzp/s/BMgM8gkO2ZE8rJ8WUj+7Ng5Z4G3ZvmkcQD8kH6
	+jhHxt3f2Bw1SQ568tcJCNKAdkgQnQdgKsE+mf9jkgqKA14PdP5A3qa7DBfHgHzvxVr3AJc0E+TNg
	3809F7F49GQIHFmhX88Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSUzn-0005wn-U8; Thu, 29 Nov 2018 22:41:19 +0000
Received: from galois.linutronix.de ([2a01:7a0:2:106d:700::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSUzk-0005wJ-HI
 for linux-arm-kernel@lists.infradead.org; Thu, 29 Nov 2018 22:41:17 +0000
Received: from p4fea46ac.dip0.t-ipconnect.de ([79.234.70.172] helo=nanos)
 by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
 (Exim 4.80) (envelope-from <tglx@linutronix.de>)
 id 1gSUzY-0001sU-8k; Thu, 29 Nov 2018 23:41:04 +0100
Date: Thu, 29 Nov 2018 23:41:03 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Vincenzo Frascino <vincenzo.frascino@arm.com>
Subject: Re: [PATCH v2 04/28] kernel: Add masks support for Raw and NTP
 time
In-Reply-To: <20181129170530.37789-5-vincenzo.frascino@arm.com>
Message-ID: <alpine.DEB.2.21.1811292339240.1657@nanos.tec.linutronix.de>
References: <20181129170530.37789-1-vincenzo.frascino@arm.com>
 <20181129170530.37789-5-vincenzo.frascino@arm.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required, ALL_TRUSTED=-1,
 SHORTCIRCUIT=-0.0001
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181129_144116_716468_83611191 
X-CRM114-Status: GOOD (  17.95  )
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

On Thu, 29 Nov 2018, Vincenzo Frascino wrote:

> Depending on the clocksource selected there can be supported a
> different resolution hence we require a mask to be applied to the
> time calculation.
> 
> This patch exposes the mask in the datapage for Raw and NTP adjusted
> clock.
> 
> Cc: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> ---
>  include/vdso/datapage.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/include/vdso/datapage.h b/include/vdso/datapage.h
> index d50a108afaed..0a7bdccf5773 100644
> --- a/include/vdso/datapage.h
> +++ b/include/vdso/datapage.h
> @@ -34,6 +34,8 @@ struct vdso_data {
>  	__u64 wtm_clock_nsec;
>  	__u64 btm_nsec;		/* Monotonic to boot time */
>  	__u64 tai_sec;		/* International Atomic Time */
> +	__u64 cs_mono_mask;	/* NTP-adjusted clocksource mask */
> +	__u64 cs_raw_mask;	/* Raw clocksource mask */

And why would they be different? The core timekeeper has them duplicated
purely for access pattern optimization and simplicity.

Thanks,

	tglx

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
