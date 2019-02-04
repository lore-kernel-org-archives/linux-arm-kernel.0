Return-Path: <SRS0=7SeU=QL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80F61C282CB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:03:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 519E02081B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:03:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="YVSBg514";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="j+fVd93c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 519E02081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=8d3BLDXeRStCuy2DlPAEXc1pbKYKzAcwEzmwMB7Sq5k=; b=YVSBg514Kx+8Jd
	9mGpdRXmCOxlFBeCHrCXmfHwiLXeUXMM3JRDaGjXl12sOT+/GSdk1cRdq/ekyR2Bll5uh9wKhWifK
	fLAdPbw2ST2v+ncxbZ2N4OXm6PGmOKlU7Zk137eofNGjTo/FFDYETNpunwCKFQ4GrCaFwbwZ6HMJE
	Yk9uHpBHGy0evDtU9CrDXQTG/7eak80O6fa79qKOIAzc3DAqb/WnqoOqp2n7/Bx4M1ZAGOUGhBcOk
	6H2vcYkjUKoNDyb36BI2ghS/NIYUs8so7ABbPh7R86JY6u9yRBLioMY4gcqc7rNtjJBaihzlBpDnA
	EYCjrpfu5riD2zzqySNQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqb6X-0003Hw-Hw; Mon, 04 Feb 2019 10:03:53 +0000
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqb6T-0003H7-Ao
 for linux-arm-kernel@lists.infradead.org; Mon, 04 Feb 2019 10:03:51 +0000
Received: by mail-lj1-x242.google.com with SMTP id v1-v6so11062640ljd.0
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 04 Feb 2019 02:03:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=QzrWxQmO4UQ5Aqm7IR3I9DrPxmlHOZ3c/1JaT+pgdfc=;
 b=j+fVd93c8AEVBkxCU6cLFzmanFCL2DuRcbDpTwGpzeaE8UlvC25a9UqrY2H6iKrRFn
 HplyDKNkogA4POpAUya6SgpDn+VS6awCK6a+rw6zZZBEpej+v5Krt96ZSYCPC5ZfzLF0
 mP1En3B5B8ziIoECJYjaXe/xKLHZPa4m6q0E0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=QzrWxQmO4UQ5Aqm7IR3I9DrPxmlHOZ3c/1JaT+pgdfc=;
 b=NlDZcGJ1m5xv1ZYiUjNqxfPnI4dPwCChpDU+hsC52IkcfcxtgckNewAbyp+YUjxKev
 9pi84Y40HitYVE4Hciqfw+CWtUb7E7w9qr9WJFQG2JI3X8xerW51i7V2ySpxzxyzkVJ0
 CQad/vt5TgB+K2jOk1wggc0wds/7xx0oLb7bFUkuPtxjsnjOJ56bpnDRPsmUHoGDgb5S
 nTZckHy0n2lwph30457CWoeT5s9xmCAn4Mwt9REAuxJN6J6TEnTomgoRaELlmJIwBYrZ
 OBNuOprTYWynLsWLX4icYqUPYoyNTqq7OhF4TDBwTbElL7UkKkjiWQfBh/uLrfGiTNvi
 RDDA==
X-Gm-Message-State: AJcUukefVzF/X8YimBzYkgakr0WcxzCM33IzW++yogk6wzYqUWG9u9GS
 E+BTDiEFCY8cqevWefnJQ99Ko9qVIIDstQekKJDJiQI/
X-Google-Smtp-Source: ALg8bN737d8LObdfcmd4pqjHv+mj76WX5F8pLRDxH+XKpkZu1KCShwdHTAF5Nvm7IqMv+vXSeExDH/kPUmHi4PFqNQk=
X-Received: by 2002:a2e:9356:: with SMTP id
 m22-v6mr39018995ljh.135.1549274627159; 
 Mon, 04 Feb 2019 02:03:47 -0800 (PST)
MIME-Version: 1.0
References: <20190204095853.12212-1-masneyb@onstation.org>
In-Reply-To: <20190204095853.12212-1-masneyb@onstation.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 4 Feb 2019 11:03:35 +0100
Message-ID: <CACRpkdaLx7BtkaYAD+d+hRNhnpu2ByeC1KqGA9yYjJjGdyMcDQ@mail.gmail.com>
Subject: Re: [PATCH v2 -next 1/2] genirq: export irq_chip_set_wake_parent
 symbol
To: Brian Masney <masneyb@onstation.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190204_020349_392178_CC55AA99 
X-CRM114-Status: GOOD (  10.90  )
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
Cc: linaro-kernel <linaro-kernel@lists.linaro.org>,
 Kernel Build Reports Mailman List <kernel-build-reports@lists.linaro.org>,
 Marc Zyngier <marc.zyngier@arm.com>, linux-arm-msm@vger.kernel.org,
 "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>, Stephen Boyd <sboyd@kernel.org>,
 Linux-Next Mailing List <linux-next@vger.kernel.org>,
 Mark Brown <broonie@kernel.org>, Andy Gross <andy.gross@linaro.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Feb 4, 2019 at 10:58 AM Brian Masney <masneyb@onstation.org> wrote:

> Export the irq_chip_set_wake_parent symbol so that drivers with
> hierarchical IRQ chips can be built as a module.
>
> Signed-off-by: Brian Masney <masneyb@onstation.org>
> Reported-by: Mark Brown <broonie@kernel.org>
> Acked-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
> This fixes a build failure in linux-next's spmi-gpio when using
> allmodconfig. See https://www.spinics.net/lists/linux-next/msg46362.html
> for Mark's message.
>
> Changes since v1:
> - Moved message about build failure out of the commit message and into
>   the notes field.

Patch applied to the GPIO tree. Thanks for the quick fixes!

Yours,
Linus Walleij

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
