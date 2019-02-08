Return-Path: <SRS0=fpAU=QP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9614C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 15:24:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 980E020855
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 15:24:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="OD14HnAD";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pkubCBL0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 980E020855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Dyc+viXmyHngSDtXSHxXdgu8pdq1n2NhxBTasmKDD+E=; b=OD14HnADRdn993
	f8IqFDilNWNvhaPvZomv35XLwpV5+T4q4y4TBzdnPIKOTP9Oo/ujhwzibxB48nfa9hBFlvHxsU58b
	omwmOcNYLxigkR7+tfBsJLbFKIoaXJcnw6JzWAImgsn5ohu2dp8Kp9FS1M1o8/6BH0VV7GbXeYC2s
	UyL8Y521BTsLh0jDK47RJNPQGyJgii8aeKg3fHjDAQi48pFh1EXcLJOe11Y+MwCqLquvZUyOWf6r3
	ri/cn2tsNHRY/22raROMtnq1wKqESkzGA+ANf2lETujsoKOavG2gyrrADBtE0EXCSQ/Kpxp3XFooG
	8Gd9Gd23pZa2/CM4GciA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gs80x-0001S5-4Y; Fri, 08 Feb 2019 15:24:27 +0000
Received: from mail-ed1-x543.google.com ([2a00:1450:4864:20::543])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gs80h-0001F6-EY
 for linux-arm-kernel@lists.infradead.org; Fri, 08 Feb 2019 15:24:22 +0000
Received: by mail-ed1-x543.google.com with SMTP id t6so3035278edw.12
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 08 Feb 2019 07:24:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=H1JeMi9goUOWk1cPbNp0BwRo24rWCAy7JYVk6n1DDBU=;
 b=pkubCBL0F4F19BzBF3cApbSFn3K6MOm53mryqqO/5gECJ/0Y+p7X7fRTq/xZGMzWPV
 O1r81YOEA8Dh7b+iJa8pYifjpglgl69QYQS3CdXp125Gk3q1HjLGijygjq0iT7R//Kv8
 53I0+ap/RcmxSIwdKI+tbR2GIUzlUDxa/oIGUakqpXzh4z8igLRqSEqH5CIyFd4LTyNX
 sfUEBEceEWTbYZxzLsSEFGuZqmxWyJ881myHLK1TqjE/xYWFJkjzm+rpTH9AH9ixjdC2
 lwak1kfRtDvBX1zM6V0wXrb75IbYYlMVQpLndl1I5gbXyQVl3dCcrAASZ2slT18K5CBw
 1wig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=H1JeMi9goUOWk1cPbNp0BwRo24rWCAy7JYVk6n1DDBU=;
 b=pIlgZOVzMC8ilRjuRzfCr0fKatgr4n2qtLh/jQO5osW2b9Svp671F0flAw0amUThiN
 z57wiEK+lvp1aoQMSJy2wnlVlXBMXyxMeeO2uh57qW1hmJeUxc0YM323xcl/nb3b0PQo
 AU2FvuKa2ctsFOrWxduZ0epkBfBuReh42JW0iy3L2m/flDITogRTYNGhpl79jZOwQYPZ
 8Kfhq5v0vogLit52vPGrg+01QaDMZRCu0yvob+4+cVMHOSJzsNb2p9K7ttBOP5EyA3TA
 +lK3v8KeKZKzDHh8AsPzO25p5fwGqDItARYp1UySqFxR9xbVn4NN37SGrgusqaQivxqb
 38wQ==
X-Gm-Message-State: AHQUAub1C989KoONdvofPvxCh4/FOl4wvmO0dO+L1f+XkAQz4rarchVJ
 R8wKRwpnd/0cMJGqnM+FN1Fi+K1hlmGAmRXCQXU=
X-Google-Smtp-Source: AHgI3IY7lGN+7g9tJ2P0Kgesj+g6eiXc5rMudUIDOfXI5pfukYc1je+GJHyI+T3ZLQ9xK9DfMptcSNogWqBu77Tp7wQ=
X-Received: by 2002:a17:906:a44:: with SMTP id
 x4-v6mr16249970ejf.177.1549639449455; 
 Fri, 08 Feb 2019 07:24:09 -0800 (PST)
MIME-Version: 1.0
References: <20190208045305.8759-1-coles.david@gmail.com>
 <20190208135650.GD26594@lunn.ch>
In-Reply-To: <20190208135650.GD26594@lunn.ch>
From: David Coles <coles.david@gmail.com>
Date: Fri, 8 Feb 2019 07:23:55 -0800
Message-ID: <CAO82AsgwwmxMPAeU7TimFA-nZosqEgCRZV8A+36rq1hcWM5QzQ@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: add description of Netgear RN NV+v2 LCD
To: Andrew Lunn <andrew@lunn.ch>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190208_072412_035349_C4A08D96 
X-CRM114-Status: UNSURE (   8.63  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 Jason Cooper <jason@lakedaemon.net>,
 Gregory Clement <gregory.clement@bootlin.com>, linux-kernel@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>, linux-arm-kernel@lists.infradead.org,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Feb 8, 2019 at 5:56 AM Andrew Lunn <andrew@lunn.ch> wrote:
> Kirkwood! It has been a while since we had a kirkwood patch. Some NAS
> boxes seem to never die. Nice to see somebody still hacking on them.

Netgear firmware only supported SMBv1, Windows 10 does not. Luckily
Arnaud Ebalard had done most of the heavy lifting years ago. Getting
the LCD working with the new HD44780 driver was icing on the cake.

Thanks,
David

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
