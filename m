Return-Path: <SRS0=fpAU=QP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0ABFC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 19:38:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CC4A2083B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 19:38:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="PgsGPCLi";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EeEofIpN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CC4A2083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=/VDx/l3l2fqfv43wlACNT7ehdH6zwrsxVWQWo0LMAE4=; b=PgsGPCLiD11NXX
	jl227fNyObtM1ZJIAUOIqfUodu1n3HZfonhReOZgcUlzZyBG/dABfRUaX5hbyNmTzLvTenDf+X9JU
	8GwRMgQh1P2ZZ76bJg6wmYpLZBhYwKAU/01TZ9Z+oVOv5M1wEjNHmNT7T07lJmEGmZ3UMHFwKNs7a
	QCZJhvqo+XFt7MdJ813OK5EzUq2sTZqRazhISH166JicXEpJTHPsnyJOjifdtoRf9pmicif/tpnX7
	t3Nshrx2RJX9ec15M0BsR40HsE3HPx6uwBledj5KQmZxpmXx3d4tDIJWgAJg+g5T8y1cI4hjZ9X0z
	I1TkX0YJGQwlXeKrhqSA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gsByL-0000gT-AU; Fri, 08 Feb 2019 19:38:01 +0000
Received: from mail-lf1-x144.google.com ([2a00:1450:4864:20::144])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gsByH-0000fz-NK
 for linux-arm-kernel@lists.infradead.org; Fri, 08 Feb 2019 19:37:59 +0000
Received: by mail-lf1-x144.google.com with SMTP id e27so3387074lfj.8
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 08 Feb 2019 11:37:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=wgluad+kqnzW0/Ah9H2GTCPn7LgHsbHv7SubqzRoglA=;
 b=EeEofIpNXKIxE6HvCHuqNiIWtkF/yMWVNEohIPB/HZlufLNp04HkdvMlIDvCepeqAD
 /Hhgo72fm0SYq8ZYn9ch5dXWb1GqBmcNqGtE94z7OmoJ19FLRS6K8dD0GxY42k9zZV9y
 1X/m9s64xAdXsfhL5/OueSb2rFE5w8eFbPskM/syJivd0zSNGjyMZmDjUpnxAQu5zrEM
 GqclKbY2noFBMjgm26Va09r3o0kL78HQNkUvfpR+WuFiqAl1+zFSTcB3Y6ndIDJC/hDq
 30SRIZPfCkMgyCPOzJJavF/u9zL0fpuCYRIPapjM38sFG00KtCyRMo8KTWnCNDfSmqVV
 C6fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=wgluad+kqnzW0/Ah9H2GTCPn7LgHsbHv7SubqzRoglA=;
 b=rIiDQuwaucsCKRqQupzG3OdPTHJKbR7BgLOAZkcLF1ISNRPEAEOQb/UAfT+q9wRUVd
 qmjDTW5dRnOXfRCT23rCZW+MVO2mdtpPAmEZZKS2i2ZF/h6yhAJRkm/zn5mfH+6GIOEu
 8bXjOod0dSKZgT0kLWpU4rXOBJkkZHTU9vr1Lzq4lLGyMF2XJP4YmT7NCGbAMRhAmQ3X
 EV6953aA6x6ZmF5eGyUIDNnDxJtpRHYRobWDsUWkH76y4T3132hEwTz8Dr9RKcD0WYgt
 BU+0lqQ9i6+m0yRygGFaxNlgguXGfSKxyHborMivstt2Pvkxl09vHFYEX+sjp712er0w
 3s3w==
X-Gm-Message-State: AHQUAuZYAVJEjBAQ92b0PkUMnkx8Pn8REKfGazfjkzZYgDFfjWWJf8BR
 KNvwKAaX7J702cMXORH4Z+Ca3ztTO2Fj/Ek+3qzvHNo+
X-Google-Smtp-Source: AHgI3IYbMjLdbl1iJMWOaDlJM2y2I5AwgciIaNGpPtbQ5qf3c3OC5hHVvJcZJl3XMx4j8xb5ZVcAFbaZZqY8vNIbw7E=
X-Received: by 2002:a19:9a08:: with SMTP id c8mr14398129lfe.8.1549654675286;
 Fri, 08 Feb 2019 11:37:55 -0800 (PST)
MIME-Version: 1.0
References: <20190203214205.13594-1-linus.walleij@linaro.org>
 <20190203214205.13594-16-linus.walleij@linaro.org>
 <CAL_JsqKEWtDN0VYwZaJqajcvomptbML_rQeBavh_kCYeVFZSPQ@mail.gmail.com>
In-Reply-To: <CAL_JsqKEWtDN0VYwZaJqajcvomptbML_rQeBavh_kCYeVFZSPQ@mail.gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 8 Feb 2019 20:37:43 +0100
Message-ID: <CACRpkdb1oBuVueAi=kYd4Rn05H54m7OcisSFxACAzYeYtYefbg@mail.gmail.com>
Subject: Re: [PATCH 15/17 v1] ARM: ixp4xx: Add DT bindings
To: Rob Herring <robh@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190208_113757_828968_33EAB856 
X-CRM114-Status: GOOD (  14.44  )
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
Cc: "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Tim Harvey <tharvey@gateworks.com>, Krzysztof Halasa <khalasa@piap.pl>,
 Olof Johansson <olof@lixom.net>, Imre Kaloz <kaloz@openwrt.org>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Feb 4, 2019 at 4:16 PM Rob Herring <robh@kernel.org> wrote:
> On Sun, Feb 3, 2019 at 3:42 PM Linus Walleij <linus.walleij@linaro.org> wrote:
> >
> > This adds initial device tree bindings for the IXP4xx machines.
> > This time I tried something wild and crazy and try to make proper
> > JSON-style YAML bindings for the top level.
> >
> > Cc: devicetree@vger.kernel.org
> > Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> > ---
> > I have no clear idea on how to auto-test this schema for validity,
> > since it is a bit of a new thing I hope to figure it out as
> > we go.
>
> Is Documentation/devicetree/writing-schema.md missing something on how to?

Yay! Now I finally got around to testing this, and it really works smooth!

I already had it help me find issues with my device trees and all.
This is really paying off from day one, a bit of threshold but it
delivers.

Yours,
Linus Walleij

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
