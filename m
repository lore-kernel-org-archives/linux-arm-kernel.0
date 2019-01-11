Return-Path: <SRS0=KsRD=PT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 326C8C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 08:55:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 058C820874
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 08:55:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="FO6crg7a";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="gqtPIG4r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 058C820874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=aJMX1TaTP3qwjNkZExGXe0yjMiWZJRe2YkAzmoBD1tI=; b=FO6crg7aoPcvZi
	eRWOu/ZQ1kkghEVCJlVb91EfOtS7ChV14T8BtcLCDGTx74WxoGkskGsiIwMK5KZ4YzRJhKp9Gk/1+
	B2u5Qhq/eQPHfjJ3bMOOKkkrl+wa/VmM2li2nLCiEp2a5nBwfNa5NCkeiSdatPDE9tmDfPOrvu2sN
	F2kHrHoWG8sToYm7FAnJL8UztwTWBcVFtgFVHw9BFetcBxh/dEhQSi1frMOwc3won92S4xx6X3TzL
	3NIhEMp85hLUjyEjyrWNtYmmJnl4wNVQn2oVHMWDpzmeZBPansLU9aD3uPp7WSoINlP5SJ9GQX91t
	WVaXroVI3dlCYuaiZKTg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghsax-0000L0-GC; Fri, 11 Jan 2019 08:55:15 +0000
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghsaj-00083w-FN
 for linux-arm-kernel@lists.infradead.org; Fri, 11 Jan 2019 08:55:03 +0000
Received: by mail-lj1-x242.google.com with SMTP id q2-v6so12211050lji.10
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 11 Jan 2019 00:55:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=JZnwS0UuAawby2xTYVAS4ESIHWQAdYQ5XXXYonUNREA=;
 b=gqtPIG4r0RBPfFa2sTmSIB5c/MyMrQkRqTamIESgg92BqpNdDDzIZyrG44i9mLsZhF
 ENffpyM4t82ohFfRBXU87F7VkQxF9amHyA2Qz/ysYdXd6bMIx+J1b/aFl768II0p26fI
 cB5Ajl+L/HMsHFezgYtNXbs5lwBgVsY0nMsDY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=JZnwS0UuAawby2xTYVAS4ESIHWQAdYQ5XXXYonUNREA=;
 b=VNEKCkJh2XdPslC0G0M/q5FOIbHooH7gy//+samXkF5UcsxscmhBKqrSTUugeEmcv4
 C8eU+j16FF651EXEclziqYzdVlM1lufjSx51E6pr0l8+b8kxv0tNaPu79hWPvUTuCwMy
 L73FyABaiovhIKDs9TIBfGZQve1m3KyE3pS9IcQB4KXfYB/YqAyGcYjfK9laGeBPQIZ3
 b8QAwN6MsHIQs0s6se07O7/4Xhs0jY8jbRHjBgYs3w7CkIXVnpW5ovgr+S65Rl5PuxL4
 RfYh9Xhb9QITnFTlt694qhY0ssDUdRpPNgny9P6BWnI7IwCpI6Saxj2leT/OeyWhFJvb
 Xpkw==
X-Gm-Message-State: AJcUukeXiMcQv58VVvXrXLXoy8l2rEqdBDLK3jQzrSduZ0eaquSlEkTp
 GrEWKsH9EGowLWrqvn6p0VUYnzvCzr4leHpGx7Xxmg==
X-Google-Smtp-Source: ALg8bN78YAkfv9ZwqXO+lDtEo+CCYFX9gLiVY9lAo21GPQ/x3WxwEKGO7/SbTwoEml6LnqpCcjUgl+grueS2ztsUI8A=
X-Received: by 2002:a2e:9107:: with SMTP id m7-v6mr7992150ljg.23.1547196899051; 
 Fri, 11 Jan 2019 00:54:59 -0800 (PST)
MIME-Version: 1.0
References: <20181221173259.8372-1-gregory.clement@bootlin.com>
In-Reply-To: <20181221173259.8372-1-gregory.clement@bootlin.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 11 Jan 2019 09:54:47 +0100
Message-ID: <CACRpkdZbano_a1CgF8mzUULZwgUL5rP3bnHPhvm+yB_G=wohbg@mail.gmail.com>
Subject: Re: [PATCH 0/3] Few fix for pins configuration on Armada 37xx
To: Gregory CLEMENT <gregory.clement@bootlin.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190111_005501_582259_6545F638 
X-CRM114-Status: UNSURE (   9.44  )
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
Cc: Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>,
 Antoine Tenart <antoine.tenart@bootlin.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Nadav Haklai <nadavh@marvell.com>,
 "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 =?UTF-8?Q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>,
 Marcin Wojtas <mw@semihalf.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Dec 21, 2018 at 6:33 PM Gregory CLEMENT
<gregory.clement@bootlin.com> wrote:

> this small series fixes wrong pins configuration we currently have on
> Armada 37xx.
>
> For now it is especially annoying it we want to enable suspend to
> RAM for PCie.

All three patches applied for next (v5.1) with Miquel's
test tag.

Yours,
Linus Walleij

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
