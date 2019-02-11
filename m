Return-Path: <SRS0=sCCJ=QS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 524D3C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 08:45:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18D9021736
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 08:45:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ofKATLQl";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lt8y2bnm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18D9021736
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=AyYto2HEU6nOPyKzouq3elHhCnvt2soD58lte3MIkXc=; b=ofKATLQl4q5wgn
	FQhT70G8jMDne4piXV0lTz4EVhYCOWajfi/c3SAqUAGeF2dTVM/8QJ/oerGBNQ7/pSvpjrP2HHt68
	Bf9Kje7zzmwU/2TdZ7C+FQO5awrGi1M6QmYUXgVj7CrJmEd4xFRKsddO1DtCOCIcrqP1AVKMG0EHv
	v2qw0LDYpPchJbF/qUecGy1kru36m10+fiyiXPtLT5y1ksDu0jUDz3NEdgJjsYnab1ohEuVRXG8wp
	2LUiCGU1uEjDnvusJTmhFaF0oRiOL3NK2+whsVV0aP7ylzNwbJSG3fXWYgxxwRIMcuMUebxhZjUxm
	m81qVp5Yhd9TwoG1L9Ng==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gt7Dq-0002jw-4X; Mon, 11 Feb 2019 08:45:50 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gt7Dl-0002jD-Rm
 for linux-arm-kernel@lists.infradead.org; Mon, 11 Feb 2019 08:45:48 +0000
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com
 [209.85.208.173])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 9B7152176F
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 11 Feb 2019 08:45:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1549874744;
 bh=aNjOHNDg94ZkKvA1xr9xCksj4QuuBPIf/hPN1+P9Vu4=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=Lt8y2bnmqI+8Px1Nw6Wk9vC5j4asaD4QJYuNedGmNWvFlXaUBWA/JrKj8IwmHP+HD
 uD/EbB3LJqv4o9zCyHVRiZlofwG8wT0+Cqx4+iJjEstZ0gghWd/SlfOuZZK1yJQFga
 haDqVi1VJzENoWO6mhecjWHlsZ5MqKcND8i0C+VA=
Received: by mail-lj1-f173.google.com with SMTP id v12-v6so3299889ljc.6
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 11 Feb 2019 00:45:43 -0800 (PST)
X-Gm-Message-State: AHQUAuaCIOkvZov8K2u8HYGLZCvncrfWjezrQXG+RelMq33C+vOd7C0Q
 8iC8qWpxN0oOhb+I9SXkhQisPDlzqDiClZ4BnAo=
X-Google-Smtp-Source: AHgI3IbzeKeYkKpuAfCg0dy/z/dT38QKh18bso1sBal8m+g0p0o2lxo+lLo4eccrdIB8UXtjJABSI3/qlbQRij3PWoQ=
X-Received: by 2002:a2e:81da:: with SMTP id
 s26-v6mr21000889ljg.183.1549874741764; 
 Mon, 11 Feb 2019 00:45:41 -0800 (PST)
MIME-Version: 1.0
References: <20190210225114.20110-1-stuart.menefy@mathembedded.com>
In-Reply-To: <20190210225114.20110-1-stuart.menefy@mathembedded.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Mon, 11 Feb 2019 09:45:30 +0100
X-Gmail-Original-Message-ID: <CAJKOXPe+G_gPNLQcaE5kvXFLFzhXo538w8-34k3gcK7yNL8txA@mail.gmail.com>
Message-ID: <CAJKOXPe+G_gPNLQcaE5kvXFLFzhXo538w8-34k3gcK7yNL8txA@mail.gmail.com>
Subject: Re: [PATCH 0/2] Subject: [PATCH 0/2] clocksource: exynos_mct: Clear
 timer interrupt when shutting down
To: Stuart Menefy <stuart.menefy@mathembedded.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190211_004545_923096_784E1922 
X-CRM114-Status: GOOD (  15.43  )
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
Cc: "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, linux-kernel@vger.kernel.org,
 Kukjin Kim <kgene@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Sun, 10 Feb 2019 at 23:51, Stuart Menefy
<stuart.menefy@mathembedded.com> wrote:
>
> When debugging suspend problems on Exynos 5260, I had a large number
> of debugging prints going to the serial port after interrupts
> had been disabled but before the timer interrupt was shutdown. This
> was long enough for a timer tick to occur, but as interrupts were
> disabled the ISR didn't run, and so the interrupt wasn't cleared.
> Later when the timer was shutdown the interrupt was left asserted and
> so the wfi at the heart of the suspend code didn't wait, causing
> the suspend to fail.
>
> Currently the code which stops the timer when it is on one-shot mode
> and the interrupt occurs is in exynos4_mct_tick_clear(), meaning if we
> called this from the shutdown code exynos4_mct_tick_stop() could be
> called twice. So first restructure the existing code, so the check for
> one-shot mode and stopping the timer is moved to the ISR, leaving
> exynos4_mct_tick_clear() just clearing the interrupt flag.
>
> Once this has been done simply call exynos4_mct_tick_clear() from
> set_state_shutdown().

For sending the corrected version. This is second revision of the
patchset so please remember to add v2 to the title and changelog in
cover letter. v2 can be easily added with format-patch (-v2).

Best regards,
Krzysztof

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
