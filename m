Return-Path: <SRS0=sCCJ=QS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3351EC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 13:40:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E453C21B24
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 13:40:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="beNVAij/";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dWlBTld9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E453C21B24
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ZOQGfTF7sBHZec+THrlhgXDGCw/yssVqcPna4idYzoQ=; b=beNVAij/zC3IiC
	15EGjR4DurewYY+XaGngtQ/bYYTfLSdwQ5ZHPNhKrb0RcZKJrrolDiXoI9gWrFauW9ORhmsIafSIX
	sl6+rDc/MpYrxc0WQi3eKmJWEqpS7eHN+LIujOX3SnznQj0XG3BFKScZqqC7JRdqD3l0BY1UZ1Fid
	wSqgC8LLJdgs8XR+3KDCsJjooeg+C175MOKLeSwsECI6E1D9+mavtKf34LObS4iwbcETqNpfCNAUG
	m4LjoRCzVWVzBWoYn0Aog1cl0wXeLIORl2QpjvzXf9rD77tD6/DZx9yBAnAJJ7QJidB+0hG/eNq9k
	2oBztV4dakvDwv8UOiYw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtBok-0004EA-Ey; Mon, 11 Feb 2019 13:40:14 +0000
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtBlX-0000rN-Id
 for linux-arm-kernel@lists.infradead.org; Mon, 11 Feb 2019 13:37:23 +0000
Received: by mail-wm1-x342.google.com with SMTP id j125so2320685wmj.1
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 11 Feb 2019 05:36:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=oqBNnbIu4ogAFHQv0IkubaNotkX2xJx7RZvZ6dahxA0=;
 b=dWlBTld9j8T52lCHFf1Ji9Oq9JA3yqNuZYTfA0CidfToNWajVNFt+SqVtGK8FZGIGS
 dA7Zc26RNnFiDFZbMKadqPTEJvebkib38hlO0bTffDmt2zKmpj8YPtRVy3GyVWBSXRmn
 5EknEw6wOsqXbSwRGAZURYB9Mh0VIxwYIRa+ViTmqxTOFxZGTu1rm8Fm5Vu1TFX3QNDO
 32t/nYBTJiweu0/hYuvVvTWbnIxtk/BoZ+3jxcZ8RBGdqFeQKHEJB/llZQVJuknf6wHw
 bevQJtKjc1OKoCQ/wUNTU8UnPP1AMyOFmO9rBW7v5YbTFqAmdhz5tixs407i2QbTEXl0
 JDkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=oqBNnbIu4ogAFHQv0IkubaNotkX2xJx7RZvZ6dahxA0=;
 b=ea4CdFGNs8+DRE/Tc6qxXNpyrXUQA7hAGA/F1hjaCthyPjppSG6pBYq7V6nmoTps26
 LGzCtHbyeLfe6wwrk7OgmoMNr8yp0jb3lGmjYhxm7I1n0A7Oy7CzdPeh2/v9xbEnGghs
 37OF3kWQ9G8kBXWc/LmCiioFB5bca2+FkvspohAOXAhlG5RPv7JOQnFAed1aKZN4lWvk
 Q9fXDiPgUnjOBzxskYSd1nizm9H/vFiHweip1Ziup6uNJpiylPHvFquenbGyJ0rW45lM
 0qREYbxnxIms8L69x2Yo5w5NJ58CLXwNExeGnXuGTngj/3I3OJseFjdVjNaszRNBzxUQ
 a/Mg==
X-Gm-Message-State: AHQUAuburbDZGS/bm6eCxXDZWUe92vKoVmVCcfRD9Z3EtVKUjryo6MES
 coGMmVw1v6FlWh8qfBPPWrOn51wC5xbwnIzTdRo=
X-Google-Smtp-Source: AHgI3IZepcynd+Hv6C7k9ZWYerJsqdBdRwCbYM4kp8mARDKItdDCOe9hcRBOaK0i7Z7lpyAruqQFHGPkWDC3gLSxo/A=
X-Received: by 2002:a05:600c:211a:: with SMTP id
 u26mr9215345wml.142.1549892213289; 
 Mon, 11 Feb 2019 05:36:53 -0800 (PST)
MIME-Version: 1.0
References: <20190208104046.21817-1-thomas.petazzoni@bootlin.com>
In-Reply-To: <20190208104046.21817-1-thomas.petazzoni@bootlin.com>
From: Shubhrajyoti Datta <shubhrajyoti.datta@gmail.com>
Date: Mon, 11 Feb 2019 19:06:42 +0530
Message-ID: <CAKfKVtFu0V7GVrZJ_THHAm-gAddp37iKv=JQQaWt_C+xZJEEWw@mail.gmail.com>
Subject: Re: [PATCH] gpio: zynq: properly support runtime PM for GPIO used as
 interrupts
To: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190211_053656_328762_AF7FBED4 
X-CRM114-Status: GOOD (  13.55  )
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
Cc: linux-gpio@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>,
 linux-kernel@vger.kernel.org, Michal Simek <michal.simek@xilinx.com>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Thomas,

Thanks for the patch.

On Fri, Feb 8, 2019 at 4:13 PM Thomas Petazzoni
<thomas.petazzoni@bootlin.com> wrote:
>
> The Zynq GPIO driver currently implements runtime PM by:
>
>  - Enabling runtime PM support in ->probe() and letting the runtime PM
>    reference counter drop to zero at the end of ->probe().
>
>  - Increasing the runtime PM reference counter in ->request() and
>    decreasing it in ->free().
>
> However, the latter is not sufficient: when a GPIO is used as an
> interrupt, ->request() and ->free() are not called. Due to this, the
> runtime PM counter remains to zero when the only GPIOs in use are used
> as interrupts, causing them to simply not work.
>
> To address this problem, this commit implement the
> ->irq_request_resources() and ->irq_release_resources() hooks,
> ensuring that the runtime PM counter is properly
> incremented/decremented. Since we override the default hooks, we keep
> the existing behavior by making sure they call gpiochip_reqres_irq() /
> gpiochip_relres_irq() respectively.
>
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
> ---
Reviewed-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
