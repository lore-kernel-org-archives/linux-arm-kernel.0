Return-Path: <SRS0=AWyS=OJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75B8EC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 13:12:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46C0720868
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 13:12:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="KBtaIaQ8";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="P/m0Au2U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46C0720868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=V8zDFi1ka84j6mLFFgOm4Nm3LjfJsOk4baGnvKDHCEQ=; b=KBtaIaQ8WW7c1a
	5MuYPC2XcmTLyIdXkjY9sWQ8/y2NsJixy9e/jxR6Hef0ZuFydYw+jipqnYr76bGCjK7RWkjGQcHCX
	4DbxZXtNHxgxOwTNPJkeY1QMkYcJxq1XKk1lqVDD7BW8HozkwWy2IrcYl/gHUbuYjCw8LIcuNGbhl
	aZQgACJYHo9XQigHk84dhoVzi11H0BvNg1+66pZpWGprB8ypTzv2oSxme/NZFRzCEMB01lYtV+r2E
	z0ymBaDzAElc7yFK/x2RdXyAJ3itNYWYDe7M9KDErD/1GJDUd59m8mt0dNyQKYxcpgyh3S+YNoV3n
	yBXkltrA0f0rwR8IB8/w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSibH-0006yU-VC; Fri, 30 Nov 2018 13:12:55 +0000
Received: from mail-it1-x133.google.com ([2607:f8b0:4864:20::133])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSibC-0006qt-6A
 for linux-arm-kernel@lists.infradead.org; Fri, 30 Nov 2018 13:12:53 +0000
Received: by mail-it1-x133.google.com with SMTP id m8so1958317itk.0
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 30 Nov 2018 05:12:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=uED1KU+93t1/Uh3onsbUcwoiR/eFTSkAJp8dwBJduSo=;
 b=P/m0Au2UKFpo9NoXRC6PoRv16eoK0sukLX8o0UqPIGQ14RUEjO6eQuZySiCXo2XkA4
 PrcuvVJQVth1RLbz/EqwrNXg7N2XYz/WMERUE4ODuNmHOTu1qlce+5uXxy5MD4R4fthX
 28TeZ8xrnaEBYiRbiCw9Xf5FgKLLefSRfGahI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=uED1KU+93t1/Uh3onsbUcwoiR/eFTSkAJp8dwBJduSo=;
 b=eZU06NchRT/0erZ3xxX4yNH1koA+RCBrIoHcd2wfqyYx/bbe+VUvMkri/I9vxD2a/u
 F2GbMWblQOosF8ZiSs+rbbI+uOg/L3m7ViPpZ09eLhn+j4LApKWaCHnOsJr6xkSuTNSA
 WKYrM8o30YfZID41YTWQK526bblpdimjabgaElFDIoVb527ivVzttAoH8nEJA7bNp1V8
 cDlhV49/okOcZJhdI7vBn0WocXAGRABtDJe4xZne/5T/r1cAlk359pgDvM20bFqlHxty
 I7bxV1baMV7uBpaP0LKgI/y0nfizus+3IcMdr2+O1/X//O4Mv8WUIIVHNt3QG4GI4jDx
 Yctg==
X-Gm-Message-State: AA+aEWbNX0HTKErsa8Xqq4xkgLM+S5zzmjfUuecgwAsdQ9iLdw3R7853
 YAtHe4nGtSZ2YzncvR9JY/Yy4WsgJOWJjjO172HDGA==
X-Google-Smtp-Source: AFSGD/XVzPZXppYtEmQF1Qk4vnhiL38fH2ATjVd+GxxBFE8GRcE4GLzAa5Ft/Upcxo5ezkMsssiJst3GDMp2/fdPKjw=
X-Received: by 2002:a24:710:: with SMTP id f16mr4530228itf.121.1543583558440; 
 Fri, 30 Nov 2018 05:12:38 -0800 (PST)
MIME-Version: 1.0
References: <e2130285-6e51-f1c9-7b91-6b0467a15de6@free.fr>
In-Reply-To: <e2130285-6e51-f1c9-7b91-6b0467a15de6@free.fr>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Fri, 30 Nov 2018 14:12:22 +0100
Message-ID: <CAKv+Gu-cms32Vun16bdM+n_OkH7w7knf45S3eGhVjbG3VdFgbA@mail.gmail.com>
Subject: Re: Unexpected variation in SYS_ID_AA64MMFR0_EL1
To: marc.w.gonzalez@free.fr
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181130_051250_282491_8C3CF086 
X-CRM114-Status: GOOD (  12.38  )
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
 "Suzuki K. Poulose" <suzuki.poulose@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 Dave Martin <Dave.Martin@arm.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, 30 Nov 2018 at 13:15, Marc Gonzalez <marc.w.gonzalez@free.fr> wrote:
>
> Hello,
>
> On an APQ8098-based system, for cores 4-7 (little cores?), the kernel prints:
>
> [    0.179055] CPU features: SANITY CHECK: Unexpected variation in SYS_ID_AA64MMFR0_EL1.
> Boot CPU: 0x00000000001122, CPU4: 0x00000000101122
>
> TGran16, [23:20]
>     Support for 16KB memory translation granule size:
>         0x1     Indicates that the 16KB granule is supported.
>
> Since this is a pr_warn, I get the feeling something is not quite right.
> Is there something to fix? Is it a problem that the big and little cores
> don't support exactly the same granule sizes?
>

That looks like a false positive to me. We should only care about the
page size we are running with.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
