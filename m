Return-Path: <SRS0=s0b7=Q6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76901C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 10:45:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40C98206B6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 10:45:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lsWTPCOh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40C98206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:
	In-Reply-To:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=0/Ph/VTivlBDAuV5aBkwjJGk2gtuWao7BCxF5556e00=; b=lsWTPCOhMZnMDx
	560/fcdzIIEjKZRaK78b6hkdrDnYx4GwLjBHSNsQAuPS7SewaVoH8l0P3FD4LZKymd3vFuG4bvKL3
	fQfpth/O6nfbycKVZHHD/JBDC+Ecu6aDkXpZ2Sk49d6wS/PNDr93aBs11RvEOGTXVVm6of0Clg9Xq
	YxaTvsKym42Uai0nHBZsAfORcqM1mBO68WEXUnO+FezAdXdrxS8Wavl5EyykJkTnELxr8vCVHlV8Q
	yEglgQAhFyNFQxkZk7OcCz9JgnXtZ5369KncuVeEcUjqVZ3da4lhWdhnM1Hev2f5kOKyXYEMUY6FL
	hsVP04leLWuwnyb5l1Cg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gxUo5-0005Ai-Qi; Sat, 23 Feb 2019 10:45:21 +0000
Received: from galois.linutronix.de ([2a01:7a0:2:106d:700::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gxUo2-0005A2-Up
 for linux-arm-kernel@lists.infradead.org; Sat, 23 Feb 2019 10:45:20 +0000
Received: from p5492e0d8.dip0.t-ipconnect.de ([84.146.224.216] helo=nanos)
 by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
 (Exim 4.80) (envelope-from <tglx@linutronix.de>)
 id 1gxUo0-0007JT-EF; Sat, 23 Feb 2019 11:45:16 +0100
Date: Sat, 23 Feb 2019 11:45:15 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Vincenzo Frascino <vincenzo.frascino@arm.com>
Subject: Re: [PATCH v5 22/23] x86: Add support for generic vDSO
In-Reply-To: <20190222122430.21180-23-vincenzo.frascino@arm.com>
Message-ID: <alpine.DEB.2.21.1902231138130.1666@nanos.tec.linutronix.de>
References: <20190222122430.21180-1-vincenzo.frascino@arm.com>
 <20190222122430.21180-23-vincenzo.frascino@arm.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required, ALL_TRUSTED=-1,
 SHORTCIRCUIT=-0.0001
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190223_024519_137411_DB616C3E 
X-CRM114-Status: GOOD (  12.95  )
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
Cc: linux-arch@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
 Arnd Bergmann <arnd@arndb.de>, Catalin Marinas <catalin.marinas@arm.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Will Deacon <will.deacon@arm.com>,
 Russell King <linux@armlinux.org.uk>, Ralf Baechle <ralf@linux-mips.org>,
 Mark Salyzyn <salyzyn@android.com>, Paul Burton <paul.burton@mips.com>,
 Dmitry Safonov <0x7f454c46@gmail.com>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Peter Collingbourne <pcc@google.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, 22 Feb 2019, Vincenzo Frascino wrote:
>  void update_vsyscall_tz(void)
>  {
> -	vsyscall_gtod_data.tz_minuteswest = sys_tz.tz_minuteswest;
> -	vsyscall_gtod_data.tz_dsttime = sys_tz.tz_dsttime;
> +	vdso_data.tz_minuteswest = sys_tz.tz_minuteswest;
> +	vdso_data.tz_dsttime = sys_tz.tz_dsttime;
>  }
>  
>  void update_vsyscall(struct timekeeper *tk)
>  {
>  	int vclock_mode = tk->tkr_mono.clock->archdata.vclock_mode;
> -	struct vsyscall_gtod_data *vdata = &vsyscall_gtod_data;
> -	struct vgtod_ts *base;
> +	struct vdso_data *vdata = &vdso_data;
> +	struct vdso_timestamp *vdso_ts;
>  	u64 nsec;
>  
>  	/* Mark the new vclock used. */
>  	BUILD_BUG_ON(VCLOCK_MAX >= 32);
>  	WRITE_ONCE(vclocks_used, READ_ONCE(vclocks_used) | (1 << vclock_mode));
>  
> -	gtod_write_begin(vdata);
> +	vdso_write_begin(vdata);

This begs the question why this update code is still architecture
specific. The vdso data is now generic, so the whole update can be generic
as well. The only x86 specific thing is this perhaps:

  	int vclock_mode = tk->tkr_mono.clock->archdata.vclock_mode;

	vdata->clock_mode	= vclock_mode;

But either than can be made generic and mandatory or easily resolved with a
trivial arch_update_vsyscall() inline.

Thanks,

	tglx

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
