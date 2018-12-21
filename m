Return-Path: <SRS0=7qzz=O6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8401BC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 09:55:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51CDA2176F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 09:55:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Dbh4mzZf";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ep1iuFX8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51CDA2176F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=96BL2Xcf3SlilJTWByNaAzwi47N8vkupuX+UiSBzjzw=; b=Dbh4mzZf49yHzP
	ZwtpxvQVEmbapD1psuFd+wBkntRWAW+8HwRQlDs9Kp7xPoUXl55TEYCRGHZbQJllVk3flSgkBSZsm
	iMBIPYF8MRLYVzi7VLF3bcJqBHtt+nu8nhUBDtQgkcOFdIcOc6Gnr5crvUu2TicE0aUJeFExyBSPC
	Xk1oKA4MxTogFj+VW2gPR1f/wic5FA0KDvr9qdBO0lAtO0mdbUybd6fsrsWABwlTVGNASBf7BrKP/
	/m7FOANcKJ351JudaTyHLPY1fm5Uk66bPrJmBmEGPbS9wFZKLADtIBNk9oLuP89l90C0KBFGtkZ4P
	TmvYVecRKNS6J5HjpJIw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gaHWs-0004oa-AG; Fri, 21 Dec 2018 09:55:38 +0000
Received: from mail-lf1-x141.google.com ([2a00:1450:4864:20::141])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gaHWo-0004nk-EP
 for linux-arm-kernel@lists.infradead.org; Fri, 21 Dec 2018 09:55:35 +0000
Received: by mail-lf1-x141.google.com with SMTP id e26so3488766lfc.2
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 21 Dec 2018 01:55:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=VXYovhbry/kbeUtzDEBwEgohu7ga0irY9/zilVzuPDE=;
 b=ep1iuFX8bGn5G99fZUw53PK2hjRUlffOIPJanVR/pEF4/I9Ur4Vkozkb1H4ieKphGz
 8rqPGCpKV5qxFQ/+9I0NsTaRkKDtG7X3MMWi67F2pSsGVaiTJ8d9nFsgbfMMd95EfLWp
 ls0+xL0hhYrD1xiVK/pRQb9v4P+f9mbuathjA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=VXYovhbry/kbeUtzDEBwEgohu7ga0irY9/zilVzuPDE=;
 b=R3VKBQS13kNck5q2foyq8NDRVTtFcrJ1rFkWMKyGdjZOGcW/yJ64tARxS5bO+TYzao
 vJva8c7Dmn4Np6SG9mTEgO3/TE71XdNfUlcu+qU9JHA1gj/f66QmwUbEasq2mSgdU82s
 pHaOlrydTJVdgSk79OVGsj5eG+7ycFAyXsrvMxIM+s369CpNzp7hSKvl+qfYXTiMQ78J
 JbceZUN3ZtUKRkQX9Y2et3dPJ8fz1lEus+COkP4IilgXtRXMZzOzKAKPVua1U7TrixCK
 7bJGeQbLILbiMZVQLWXCJ//4GklZ1nI0bFIfqdwXCeniw9kiikOV/eLdaeBv9cywJS9o
 1EiA==
X-Gm-Message-State: AA+aEWaDT+lCI2XtKSuTF0smrR7p8kbgRxcBx0Wpk1HMyV6/lQkiUsVZ
 TO2QzSysAfv0ihFOzKCRjA7j+4SgwdjGMKxw2zf2fg==
X-Google-Smtp-Source: AFSGD/UFuzJTEEh9o8EA0tilG8FoAtJ6IVKV18qZthUnNmFo04uRLtTuWpxciJdlXsfJgq1NCzXKUfSdO5MtQdF9hJs=
X-Received: by 2002:a19:8d01:: with SMTP id p1mr926538lfd.149.1545386121686;
 Fri, 21 Dec 2018 01:55:21 -0800 (PST)
MIME-Version: 1.0
References: <1544615784-29331-1-git-send-email-andrei.stefanescu@microchip.com>
 <1544615784-29331-2-git-send-email-andrei.stefanescu@microchip.com>
In-Reply-To: <1544615784-29331-2-git-send-email-andrei.stefanescu@microchip.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 21 Dec 2018 10:55:09 +0100
Message-ID: <CACRpkdY+u0jiPNwbFR6pnaFm4VyXmw3q6JTBS+HNUniDuWaOXA@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] dt-bindings: arm: atmel: describe SECUMOD usage as
 a GPIO controller
To: Andrei.Stefanescu@microchip.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181221_015534_488883_A6CB32E6 
X-CRM114-Status: UNSURE (   8.86  )
X-CRM114-Notice: Please train this message.
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
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, Greg KH <gregkh@linuxfoundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 Ludovic Desroches <Ludovic.Desroches@microchip.com>,
 Rob Herring <robh+dt@kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Cristian.Birsan@microchip.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Dec 12, 2018 at 12:57 PM <Andrei.Stefanescu@microchip.com> wrote:

> This patch describes the Security Module's usage as a GPIO
> controller for its PIOBU pins. These pins have the special
> property of maintaining their voltage during suspend-to-mem.
>
> Signed-off-by: Andrei Stefanescu <andrei.stefanescu@microchip.com>

Patch applied with Rob's ACK.

Yours,
Linus Walleij

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
