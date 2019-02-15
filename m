Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E29FC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 13:36:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59FEF21925
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 13:36:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="DTNVdCQ7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59FEF21925
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=kxFu+n9FaQgvzgac030gnNEGYU01KdY2U8yhP+cbOPI=; b=DTNVdCQ725y5Zp
	MdtpJpGJKonFHRsSagqZSVNT0rVMVscg0t9KKfPwcFTuvb4tFJ+iA5yUuCXsg9HqCWlfOORSsEGV1
	SVmDrad6746fyyzMI7usHZ4FsJt7OB6NwfD6NYeP25udy+oER+UZqr9zIBBSpRIp/t+bqRB85BZrp
	stCYzqW7h8nAtxPp+yR/Y/lwB4dAwDANDMPBlq+2FUdPBj1Sx7JF9xW75O/QmQAVkAESEPKplmjJq
	jYAMX1wl7tIu6/2LX/BWEHsD8unce9RR26fKGZzq/2GrY9XMuVeWau8io+vx+QhL6eETf1blUXaEF
	dswGEYo5RB7vo2iBd8yQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gudfU-0007Ov-8m; Fri, 15 Feb 2019 13:36:40 +0000
Received: from mail-qt1-f180.google.com ([209.85.160.180])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gudfR-0007OE-NE; Fri, 15 Feb 2019 13:36:39 +0000
Received: by mail-qt1-f180.google.com with SMTP id 2so10849062qtb.5;
 Fri, 15 Feb 2019 05:36:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=wT1jpqAWT+Rmt++ieU6DSeu1daaN/0VT0Br7FIRfRPY=;
 b=ro4WfuTWYseUtK8Gh7YgMsYQp4/cJS59GBkYx19u5poFgX+u5pcRa/Kiyy4/ic6J2X
 uOlsYPAboE05UnDIIXz0T7xqEfkiYWO6l1NPKecUGfDB2d1T2jJXIfBwBUwCfNunSrde
 esEhrbMbO+3cI8eYQlEqQQGYrDoN9LxhWEZR7r6pgBRLOb6JNQwuTatUiJGzWd+HjLC9
 0usQ94FYW2hKrsVWVsavYhIH79dcLtm7DMwSvXLSBEjLtq99qW9isOJY7ccTbRoQNmew
 r9/GwCU5DyOE6YzXCeSZPiltxPgnQNdl6JnbgIfegcs7Y/yoT92cCUXqVIJkwWOZSx3i
 7dOA==
X-Gm-Message-State: AHQUAuafv/E+qfNz1+IOY+ulnJMc1VdmCVfEHxdtCmfsfWgnBMbNym2T
 eHchJE/ljMqP574NPHOXzMVuXYHT/L97GK5Z68w=
X-Google-Smtp-Source: AHgI3IZ8PmcdUy3r0yT3BC4yQOReN9BwaUDYhaiiZTRgALYd9D2709DJM2TjpVpQS07RWm4i147EGa+xfjHaBdEi7og=
X-Received: by 2002:a0c:c60f:: with SMTP id v15mr7160323qvi.40.1550237796274; 
 Fri, 15 Feb 2019 05:36:36 -0800 (PST)
MIME-Version: 1.0
References: <2570520.8EeqtpO5V7@phil>
In-Reply-To: <2570520.8EeqtpO5V7@phil>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 15 Feb 2019 14:36:18 +0100
Message-ID: <CAK8P3a37LmyvaOH21uHiVrB8YQ6R2LtOGONky2hqCK+9AUZuqw@mail.gmail.com>
Subject: Re: [GIT PULL 1/2] Rockchip dts32 updates for 5.1
To: Heiko Stuebner <heiko@sntech.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_053637_764596_BAFA4D84 
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
Cc: "open list:ARM/Rockchip SoC support" <linux-rockchip@lists.infradead.org>,
 arm-soc <arm@kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Feb 1, 2019 at 12:23 PM Heiko Stuebner <heiko@sntech.de> wrote:
>
> ----------------------------------------------------------------
> New board the Elgin-R1 based on the rv1108 soc and a number of small
> improvements for rv1108 as well. RK3066 got support for the core
> display components and the Edison tablet got its touchscreen added.
> Apart from that a wider fix to drop display-wp usage from places where
> it shouldn't be used, a pin fix for Edison and a cleanup to prevent
> rk3036 board from defining sound-dai-cells for core components in
> each board separately.


Pulled into arm/dt, thanks!

      Arnd

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
