Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A041C4360F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 15:06:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B04621A4C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 15:06:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="VqQ+jEKJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B04621A4C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Mbqdaf6FvskmbetVskr9jROorCKdFcuuZogbRm3/220=; b=VqQ+jEKJx+J53G
	sOHSUjTkRhWW/WWLYoNMs5vBPIQovlEY4yJXolXvFnC4ywYgG5Emdqf5ravOB+UakfYzcvmZRZm4v
	C0w8i8vtaJjzV7AtFIB/sG0VtjVB8d3TDeGSwApAVnxhAfK4cDjsCnf2GewV/V2YOlx2NtOIffr5H
	54aSS9A1niDZKcaPJ72MrLvNphs1jxxD/V2wbfBoeIxW3gaP7biGYTozZRylsWQ8uSnwbNSyMmNT8
	Z2krMjd3LzcaPe8kKegXwUVjcwYrLT8nNlg5cYr/4LTIBFqDnJ5FcrLeHuE91tesrR9SgBPbEXMJz
	mAPdTVhbyZSaHHf3jjdQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guf3z-00073s-J8; Fri, 15 Feb 2019 15:06:03 +0000
Received: from mail-qk1-f172.google.com ([209.85.222.172])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guf3o-0006x8-DF; Fri, 15 Feb 2019 15:05:53 +0000
Received: by mail-qk1-f172.google.com with SMTP id o125so5863614qkf.3;
 Fri, 15 Feb 2019 07:05:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=5M8kYyUElO3AOgp67Iqrzxp4r1ZBZsVkylVVr0ChlVA=;
 b=exAhx+BrFy2B0IGB2/T68VWQh9gPOCqiK1nkS8nVj8Kqq6fLtrsgl1TS/eqoeHBe4t
 AducjDBcbx37AoepW66hqIehKAV2uUcDoG3meoXC6i8+G8eoCRPNeZtIb8RTWQ6ydNKb
 zUiRxN79auTPw5VMn+JtCia+VIyStgDvviDsdsNBFDMJcv6ot3I5eCkN1RUhmY/tG848
 rzRE+yMhU7+mgSc+AlicBhMPvNcq4c/HLPoJJELoW2Ydu6ARmYvQcKRmxrOCxN7E+dXA
 BgCRij26c8WzEgtFnghUq0UnbJDkNe6ddhIUPZaUmPfDeJX8AZl/LLUZceaznzUniyUT
 tATg==
X-Gm-Message-State: AHQUAuan66ekuGEg35kZWnqb2u8E9vXFM+fTAYrlGRlUODU6+fmzC61C
 kbUhZy+LIp79Auqt7qs8nUP1A4lIA7UQk3btCGY1/Q==
X-Google-Smtp-Source: AHgI3IbOb/t+rDays1Cf737ZNf6T7Tkc8N8p+7Ceyye0noXcKH4iW95oC5G38dUt8N2EyA+f6gRHFkWIHUUP72YfRb8=
X-Received: by 2002:ae9:d8c2:: with SMTP id u185mr6995078qkf.107.1550243151016; 
 Fri, 15 Feb 2019 07:05:51 -0800 (PST)
MIME-Version: 1.0
References: <7h36oudozx.fsf@baylibre.com>
In-Reply-To: <7h36oudozx.fsf@baylibre.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 15 Feb 2019 16:05:34 +0100
Message-ID: <CAK8P3a2YP3mZrN7-0Ap+ptYE9yn1SPqjXe-hsZV_pS861MZF+w@mail.gmail.com>
Subject: Re: [GIT PULL] ARM: dts: Amlogic updates for v5.1
To: Kevin Hilman <khilman@baylibre.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_070552_479869_73C5BA9C 
X-CRM114-Status: UNSURE (   6.69  )
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
Cc: "open list:ARM/Amlogic Meson SoC support"
 <linux-amlogic@lists.infradead.org>, arm-soc <arm@kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Feb 11, 2019 at 9:55 PM Kevin Hilman <khilman@baylibre.com> wrote:
> ----------------------------------------------------------------
> ARM: dts: Amlogic updates for v5.1
> - more features for Endless EC100 board
> - chip temperature sensor support
> - fix ethernet pins
> - add Mali-450 GPU

Pulled into arm/dt, thanks!

      Arnd

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
