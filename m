Return-Path: <SRS0=g9E6=Q2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD56AC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 07:45:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F65E21848
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 07:45:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ouX1eKss";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bBK16VA8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F65E21848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=TPcFrfbEaLv47+Oi5pvhrprbZCQSBCxLtYehKnxTO70=; b=ouX1eKssUFAwaq
	7/1Ka4VaekiZCL92LsA4HoRkAQjhvwWVnqQrUg/SlyuixSN+gaRVC7SAN0mq60puv8EQbGpjyGwFf
	Znwbp9pYvz8AMeoFfn5KYG+KeNS/vwt36nTcroaaF9JSDQsO7ruB6uKlYxBJbNG3PSuJ+OHgc2k1n
	iDfUdYK1b2Y7pGdNNCyl4LlpTQwGowxrEUE3FmcHIt6VpLKuh2e3wroYteqOt8l0Gc6LGhIL9ty5G
	I4pAsE2Klm2bKIoW5/Q0U0kqFDtaH1Aba+WEpWFDFr3yuGOwPhIPwqB/bB84ioc4mzlZZoLNKXNpI
	NGHBwL0y9rSndtBcsXKQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gw05p-00067F-8c; Tue, 19 Feb 2019 07:45:29 +0000
Received: from mail-qt1-x843.google.com ([2607:f8b0:4864:20::843])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gw05i-00064o-KD
 for linux-arm-kernel@lists.infradead.org; Tue, 19 Feb 2019 07:45:26 +0000
Received: by mail-qt1-x843.google.com with SMTP id p48so22133447qtk.2
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 18 Feb 2019 23:45:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=83zkhls34LKhR/sV0XpJZp242lbQBv8At8MLdvC6g/w=;
 b=bBK16VA8uXAkhSMPxH9SnCW8evQPg5MYe40Ma66W5zMfPKJECSf+RxLQZ/f87io6Sz
 dS8GW5IydsnSvEQwLsBGkYYx9z1t4gpxeBV35ypI2oW5jqJzXOpxLCXp9mOawGeOsfQZ
 /rVEvd4TJm+dKieHi4PtW8G0TMnFOXZtQAG0g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=83zkhls34LKhR/sV0XpJZp242lbQBv8At8MLdvC6g/w=;
 b=AlyXuGX1PImt3BzodrcZtH1NpqbX1KaXScnd/Z2OoM+/uwr8Ih9xCJoI+whHxahuRJ
 UU2JgmWKjWobt6mlz3VCoypL/x0RIB1KMJnd3ptuxaXuYZu+FiqJl0Oyvcg589AlSfw/
 PzuBJ/omP4HxkUjyuy13dGF7wmRsnXREEYAeXWkXDN4JY0GNwo8svjbBVs9kHph5Mw8l
 deWNLUBtF/x5UCUCcWhzV+m5g/1oGxJ3A6890WIdqAWey48IUClsWOKqk5w7fttWu+w2
 S8DDGn6Fx4QT5TY45Z/g2CGDbz2k+LL3VbkfCmLpVc0/f930aFm3Z2Esz5ish/QAznB/
 Drnw==
X-Gm-Message-State: AHQUAubgOqsCmti1ezRqHISHo58lBgCTCw9vYsOU05V07v24cKtY8nYP
 4p8O35lCg5S65aCRJVe5qo3wefNUCtqalWet9bRgAQ==
X-Google-Smtp-Source: AHgI3IbhUkIE8jXOrnZJ8mXE8sF1ZTqJVqX5B6Vuv+mWKrJAj3MptxcPJYSJ4N/ttW2X/E3N+TX+X3ySdEKiRdbIIxQ=
X-Received: by 2002:aed:253a:: with SMTP id v55mr22027441qtc.339.1550562321007; 
 Mon, 18 Feb 2019 23:45:21 -0800 (PST)
MIME-Version: 1.0
References: <1550210558-30516-1-git-send-email-erin.lo@mediatek.com>
 <1550210558-30516-6-git-send-email-erin.lo@mediatek.com>
In-Reply-To: <1550210558-30516-6-git-send-email-erin.lo@mediatek.com>
From: Nicolas Boichat <drinkcat@chromium.org>
Date: Tue, 19 Feb 2019 15:45:10 +0800
Message-ID: <CANMq1KDzYSJSKXZJd=xuwP+uFrDY-jGO1Yt2koH7uD5hpJmjJw@mail.gmail.com>
Subject: Re: [PATCH v7 5/6] arm64: dts: mt8183: add pintcrl file
To: Erin Lo <erin.lo@mediatek.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_234522_678392_9BCC1B53 
X-CRM114-Status: GOOD (  10.91  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 Jason Cooper <jason@lakedaemon.net>,
 srv_heupstream <srv_heupstream@mediatek.com>,
 Marc Zyngier <marc.zyngier@arm.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Linus Walleij <linus.walleij@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>,
 lkml <linux-kernel@vger.kernel.org>, Zhiyong Tao <zhiyong.tao@mediatek.com>,
 Rob Herring <robh+dt@kernel.org>,
 "moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>,
 linux-serial@vger.kernel.org, Cheng Mars <mars.cheng@mediatek.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Yingjoe Chen <yingjoe.chen@mediatek.com>, Thomas Gleixner <tglx@linutronix.de>,
 Eddie Huang <eddie.huang@mediatek.com>, linux-clk@vger.kernel.org,
 linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Feb 15, 2019 at 2:07 PM Erin Lo <erin.lo@mediatek.com> wrote:
> Subject: [PATCH v7 5/6] arm64: dts: mt8183: add pintcrl file

minor spelling mistake in the commit title: pinctrl

>
> This patch adds pinctrl file for mt8183.
>
> Signed-off-by: Zhiyong Tao <zhiyong.tao@mediatek.com>
> Signed-off-by: Erin Lo <erin.lo@mediatek.com>
> ---

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
