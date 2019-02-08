Return-Path: <SRS0=fpAU=QP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB914C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 12:08:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79E642177B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 12:08:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="kKXeh7Ft";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OpE43GoU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79E642177B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=aD7B4L+44Bd6DV3vNZa7XbWMOcCZyJi7PEwu7fgmktM=; b=kKXeh7FtqXYkFE
	JNcadAaMLzoNdI3ZXl6Lmgum9LZTcd6e61CavOG3N1YM9EZFaaK8LZAgo3K0FjbMPs+UNVIIEKPmS
	5Zz1dTL5enINdCib7xsTGUl1/7uJY9QNdmLMPf/3g8RBvYopXIs29l/uly4w+hWSG5K7Yr/QB5KNb
	EyZ7rhl2c/JZyV3q0dC+vNyLXx5UOoobLakLHA3/SsU+sjyXMrbZrwzuo+ZeqWMAozLmnVc+pjKSi
	Ik7SF7UGVFkErN7r/OxhXVxOXkbDla1iNZ5yGMk2xG/b1Oe3CBG7Ti18IXhbKS5HTTLyA/JVruU2C
	hZqO4a398WSA+briPQAg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gs4x3-0006KD-Bc; Fri, 08 Feb 2019 12:08:13 +0000
Received: from mail-lf1-x142.google.com ([2a00:1450:4864:20::142])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gs4x0-0006Jl-La
 for linux-arm-kernel@lists.infradead.org; Fri, 08 Feb 2019 12:08:12 +0000
Received: by mail-lf1-x142.google.com with SMTP id m11so2348487lfc.6
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 08 Feb 2019 04:08:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=/MZVCPmiFoZOeY6Zi2sALAnt/UkJv5RFzHY10fRT4mI=;
 b=OpE43GoUJYMqV2jgCBvlmhI2KoIScG4kI9bUBTnc01KvDFy+ZgiH8UtfjavtxkYzR6
 mXcvxjONbF+enJ24VKebl2DbbZo5wA3dRBK/oWxpJMm7kvAsgzBNPLOL3JdGUv892MBg
 u7so9XNQ9ZMpwps4OAbefgxVnZOCOD0r4XuL0e8r6nfY7H6EyA2ViNOlikmgane+Hx9O
 pzkiucyCRnYfc9yxzMknbPy6OeQhVby2j7SNmhyxT+LW0sL9262lxa96gGON0+9ZBMa0
 kL4kk5rxHc66RTtSQsbi9mObG4Am2NTjM+Jt4qhm3scPA35mLx62/frTl8X5fvV/MtSK
 YmuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=/MZVCPmiFoZOeY6Zi2sALAnt/UkJv5RFzHY10fRT4mI=;
 b=ave0GcyxcaDy22gUhuzxD1omg2XVHLJCEv9WuITaLqoPyaGXNAXvZlt7Z2REq/9ga/
 A6cKR3gi9HyVW2yPq4f1CESgUbA3Qc2xOaqo07gf0no5dOnZYPuOaMvEh80nhvYtYrps
 scbzOkJsPUjAZNLxCm6DsgrNZdBzuXf2Jl6m1S+GD0bda09sLYUsMUUEtkjNZ76O1npV
 okltYZBPPzUpXJxXJpfrbmWuKNZlz9AWMa4ESbcFCUPqSsMU0ZtSIAwl+A1Zbg1nEjGW
 OTy/7mQuVIsr0xYNRckuhBpbEoGEcPpQJlLbEn4tiVKTIpacy3PQwUlNij927LLMq1UE
 EyAQ==
X-Gm-Message-State: AHQUAubnPmgsqglGwEcuZEho7Lsd3f8QolEVqu/3En2giOUJLeKHZd43
 t+1C+muf/RuUyoccBK1BZgRZ/9e+ekH78gI+eVpYgg==
X-Google-Smtp-Source: AHgI3IaPPJmXbMUXRxatMm83Ibuspywjjx9pmn4aBEeEXTgtFqQqNYb4fqm7fvevB4/5Kcs/FH9N86RwxeERxtmbpIQ=
X-Received: by 2002:a19:7dc2:: with SMTP id y185mr13882950lfc.27.1549627687819; 
 Fri, 08 Feb 2019 04:08:07 -0800 (PST)
MIME-Version: 1.0
References: <1549531468-1676-1-git-send-email-claudiu.beznea@microchip.com>
In-Reply-To: <1549531468-1676-1-git-send-email-claudiu.beznea@microchip.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 8 Feb 2019 13:07:56 +0100
Message-ID: <CACRpkdasSzX8gxW1dDjkeTyT6RAYFhrwSPGdwmrKEaabEFgG4Q@mail.gmail.com>
Subject: Re: [PATCH v3 0/7] add support for SAM9X60 pin controller
To: Claudiu.Beznea@microchip.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190208_040810_776159_898034DC 
X-CRM114-Status: GOOD (  10.74  )
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
 <devicetree@vger.kernel.org>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 Ludovic Desroches <Ludovic.Desroches@microchip.com>,
 Rob Herring <robh+dt@kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Feb 7, 2019 at 10:24 AM <Claudiu.Beznea@microchip.com> wrote:

> From: Claudiu Beznea <claudiu.beznea@microchip.com>
>
> This series adds drive strenght and slew rate support for SAMX60's pin
> controller. For drive strenght we could have 2 values: low, high.
> For slew rate we could have 2 values: enable, disabled.
>
> Besides this I took the chance and adapt the documentation for at91 pinctrl
> driver.
>
> Changes in v3:
> - fix checkpatch.pl warning on DBG_SHOW_FLAG_MASKED() macro in patch 1/7
> - add Ack-by tag

All 7 patches applied for kernel v5.1.

Yours,
Linus Walleij

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
