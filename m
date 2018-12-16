Return-Path: <SRS0=d92h=OZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F93BC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 00:10:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14D782086D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 00:10:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="XjjlYj/q";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="bdR1dqGU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14D782086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=+zefi4o6LHKrv0S6OeZVqAd6M3l9LUQNxgQZ6CZooWI=; b=XjjlYj/qDVBlHS
	9NRFbquNbFU3kF5RHj6qBHzc2zZhTzZGnbKznQljeBNo4Sswq/05i7lQdi6WuAOikI31XynDpCMkd
	BdTctPIFNokKZsQ1PkrrnR5/TKeFywN1vXTDpRCsfx2mTjrjXMA7v1/nanpbkQ22dFoUYpcLcoetI
	2A80Y7j3XYEqXGtjPPgjkk1IVE4UIftG3DepJcuXP57Kage9e91XtpUdNl+t5w4AnHnJgQAcVanuO
	uY7nturFe+brTN+WNRG7rZs6Hb5ATZwn0HmQzLMoTJU+8nbCrJdDrT2cpO7C2XCLiCp7XCmB5GvKt
	+c8eg5dtPK5Wt8mSduHQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gYK15-0005cz-2z; Sun, 16 Dec 2018 00:10:43 +0000
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gYK11-0005av-ET
 for linux-arm-kernel@lists.infradead.org; Sun, 16 Dec 2018 00:10:41 +0000
Received: by mail-lj1-x244.google.com with SMTP id k19-v6so7946022lji.11
 for <linux-arm-kernel@lists.infradead.org>;
 Sat, 15 Dec 2018 16:10:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=8BUtw88WByAwfH4XPztkf1GLzzPwhOxN37p8lz3v8UE=;
 b=bdR1dqGUyxeDBShgijyulf8L0DRanJBD0eRcH0/kIaDB6l3t6NToc9HEJq8Z66oa/+
 3AHKslBx2OzJEbU+x6UXtLbtcDzeVLcKTqIP92XekfMR1bIZKRhL3thmZpQas15dyq/H
 0KmrA8ilQhZqQnkeHLUfFQMdLwJs7e/5qYGpQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=8BUtw88WByAwfH4XPztkf1GLzzPwhOxN37p8lz3v8UE=;
 b=uK4wwpZmDuIxfeBUCai21cDJMPs3Fk4rw0Qcv5FzeY/HJEpFc+oNd3YRYBr7A9ICGN
 ghSomQ7Ay0LxYtIqJMD5XWy7Py/F32BR4TV21gtd+4sErvYbrhVDlcqReMJrjnbKuGrl
 aqKYVkthkHMwsX+HMia3/CwPYJg1xbbJLsL/lk4hgjk9zwnOxB6vi1tXrKGyBPb8BJ7J
 2AeBkdEfW8by+FfRBzvqoazEjA5j8yS5NjfDKdWdSWnXRqsAyo7Tbaj1J9LA5JmHvY56
 /p43SKcsL136O/LNhsqDtGkT84oUWiPB5C7HlIgkBiAGEVFdmsVIKc5ZVqVi20q5v5ho
 kZLg==
X-Gm-Message-State: AA+aEWaqGBPUgncFRMQmhItl/pFGtQJ/MPr7n6BPGCdV64TzGHe6W1E8
 pdblviUQ/BtD/XOPfs2EH8CxMVwU8UAVrP6e2BkEbQ==
X-Google-Smtp-Source: AFSGD/WrWbt3Os9g8tvic0pPyS/+3BnxO4Ne9uVcW7qv0RMIfC6TSZ9q2f4unIC0cGALn/MeYL1Aa+0OqBhp3RHaJTA=
X-Received: by 2002:a2e:29d7:: with SMTP id
 p84-v6mr4542675ljp.12.1544919023694; 
 Sat, 15 Dec 2018 16:10:23 -0800 (PST)
MIME-Version: 1.0
References: <20181207190829.57864-1-tony@atomide.com>
In-Reply-To: <20181207190829.57864-1-tony@atomide.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Sun, 16 Dec 2018 01:10:11 +0100
Message-ID: <CACRpkdZU768jeD0MS1kqX29W2gfmaQ5Oigt1LDWrJjwrNoV0Pg@mail.gmail.com>
Subject: Re: [PATCH] gpio: gpio-omap: Revert deferred wakeup quirk handling
 for regressions
To: Tony Lindgren <tony@atomide.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181215_161039_502033_E7FA0DBC 
X-CRM114-Status: GOOD (  12.34  )
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
Cc: Alexandre Courbot <gnurou@gmail.com>,
 Grygorii Strashko <grygorii.strashko@ti.com>,
 Aaro Koskinen <aaro.koskinen@iki.fi>, Keerthy <j-keerthy@ti.com>,
 Tero Kristo <t-kristo@ti.com>,
 "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 Russell King <rmk+kernel@armlinux.org.uk>,
 Ladislav Michl <ladis@linux-mips.org>, Linux-OMAP <linux-omap@vger.kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Dec 7, 2018 at 8:08 PM Tony Lindgren <tony@atomide.com> wrote:

> Commit ec0daae685b2 ("gpio: omap: Add level wakeup handling for omap4
> based SoCs") attempted to fix omap4 GPIO wakeup handling as it was
> blocking deeper SoC idle states. However this caused a regression for
> GPIOs during runtime having over second long latencies for Ethernet
> GPIO interrupt as reportedy by Russell King <rmk+kernel@armlinux.org.uk>.
>
> Let's fix this issue by doing a partial revert of the breaking commit.
> We still want to keep the quirk handling around as it is also used for
> OMAP_GPIO_QUIRK_IDLE_REMOVE_TRIGGER.
>
> The real fix for omap4 GPIO wakeup handling involves fixes for
> omap_set_gpio_trigger() and omap_gpio_unmask_irq() and will be posted
> separately. And we must keep the wakeup bit enabled during runtime
> because of module doing clock autogating with autoidle configured.
>
> Reported-by: Russell King <rmk+kernel@armlinux.org.uk>
> Fixes: ec0daae685b2 ("gpio: omap: Add level wakeup handling for omap4
> based SoCs")
> Cc: Aaro Koskinen <aaro.koskinen@iki.fi>
> Cc: Grygorii Strashko <grygorii.strashko@ti.com>
> Cc: Keerthy <j-keerthy@ti.com>
> Cc: Ladislav Michl <ladis@linux-mips.org>
> Cc: Russell King <rmk+kernel@armlinux.org.uk>
> Cc: Tero Kristo <t-kristo@ti.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>

Patch applied for fixes.

Yours,
Linus Walleij

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
