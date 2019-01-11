Return-Path: <SRS0=KsRD=PT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88B82C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 09:55:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E90A2177B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 09:55:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="A7bmtWIO";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="WMLcjg+X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E90A2177B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=JLpwSRbT+Js47VuKlJfoUsuvCULW0vgr0R4RZhQTg70=; b=A7bmtWIOQY+t8g
	mAdAuI96wlkLhEbyBZuvB1JSkptnmRjzOlyH1OLMabpKS6IuWjSn5Sm8MvlkCKpAjcs4v9tMQYn1D
	fm+cxVEH9viiLOdlXjBNmQwpIRzm3bV9waSNzMuwzPW8Fw1P65+vO8L/rqDSK7C36hpffGT8NxS2A
	eVSOqYcpVG3DZHMQLuWLGDvu4U7qJC/qwYcBWV4HroCe26PkQZGGrzRl+hzpGloTOlCKb3A1qAKm4
	V3Ti1t4tNwQnc/72mXzTuMp9tL5AdvjurqQx86y+0/duyzdYYHEnbigj+WYAF5D9H2ReSIKMKVfM9
	2Z6gIPk+uv43jljLok4A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghtWn-0001Vn-Gw; Fri, 11 Jan 2019 09:55:01 +0000
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghtWL-0001Bg-9W
 for linux-arm-kernel@lists.infradead.org; Fri, 11 Jan 2019 09:54:44 +0000
Received: by mail-lj1-x241.google.com with SMTP id q2-v6so12364345lji.10
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 11 Jan 2019 01:54:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=lDK1FAgxhgi3jXoNAQKdEfAbhO19e8mPHK/hUEQFr7I=;
 b=WMLcjg+XD2sK/PkoIlRemJuRAMSvYdo+TPNeYthUtIN3L3VTbGLv/4nyi3pJgRXPim
 JCH6y179utuToP1Y9VDNa4Puv2WJRNu3Zp5U8is9gH3JL/Fxh2DDXIj4hol6dsO58VMz
 twEZgWSZwE6cD/ndgYA+UxT4XsV9YjZucb95g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=lDK1FAgxhgi3jXoNAQKdEfAbhO19e8mPHK/hUEQFr7I=;
 b=pieBYSyi32D+R+yhifgoDC0lmMoy56b/Zumc6o9YMkVKQ2H0+T7IatcBQbSxUgu+VD
 peBNI/RnWgcbVqA4y3CMkCMsJk2dcjXNalSastd15dCekihCSK6g6Q2ZFHm9+X1M0Rd/
 4ZV7fluV/QGCbG6GlpCwYPX4hmVXRyqMHIv2BmH9OpGrHwAB7x+OY3pnlMJJyN7iIk2A
 RP4sJI9sSooOFyZXsc9BrWaRgdk2WXVEB5Yt/CH9Q7jLQZ9R0QLziSEHk1X+HYjgYNB1
 taRvr7myGP2DJaR6u8zZJJOl3xgCEqbYgAStU+NVRr2fSJZ08yci45xjZbcOUjXcqgvg
 rr4Q==
X-Gm-Message-State: AJcUukcqM7WHWSiRySlP7VpeS7Jj0n8nzXUseHxTFNFzFXcNCM2kyTZM
 WIEiccU9qJbe9kxLVd93XaDkxRgo1iVkuEV0c1ht5CKR
X-Google-Smtp-Source: ALg8bN7nRDxyuo1cVbZfGLGHtnNshIBA79qFEezoOXTXDQHk2/Om7qYQ8hbQyi4L7SJW3JvQ42LB9FVV2eGmCJv6Aqw=
X-Received: by 2002:a2e:9e16:: with SMTP id e22-v6mr8099680ljk.4.1547200471478; 
 Fri, 11 Jan 2019 01:54:31 -0800 (PST)
MIME-Version: 1.0
References: <cover.1502103715.git.michal.simek@xilinx.com>
 <72d3cd83bed792a23ab60cf9b6d51b618f5aa084.1502103715.git.michal.simek@xilinx.com>
 <CACRpkdZE-Edr7fWZY5VQM1_65iw7MYGP-iDa2ExZsPxpM0rurQ@mail.gmail.com>
 <6da5fd79-fbc8-b613-954f-dcbe2ef8d6c5@xilinx.com>
 <20190107164210.3ecf37e8@windsurf>
In-Reply-To: <20190107164210.3ecf37e8@windsurf>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 11 Jan 2019 10:54:20 +0100
Message-ID: <CACRpkdafBpC14TxBNVN2AemkBz-yKkXkKfNpdgkYKQX3qFemag@mail.gmail.com>
Subject: Re: [PATCH 2/8] gpio: zynq: Wakeup gpio controller when it is used as
 IRQ controller
To: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190111_015433_601125_39936CAC 
X-CRM114-Status: GOOD (  14.88  )
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
Cc: Josh Cartwright <josh.cartwright@ni.com>,
 Peter Crosthwaite <peter.crosthwaite@xilinx.com>,
 Nava kishore Manne <navam@xilinx.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "monstr@monstr.eu" <monstr@monstr.eu>, Borsodi Petr <Petr.Borsodi@i.cz>,
 Michal Simek <michal.simek@xilinx.com>,
 "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
 Rob Herring <robherring2@gmail.com>,
 =?UTF-8?Q?S=C3=B6ren_Brinkmann?= <soren.brinkmann@xilinx.com>,
 Steffen Trumtrar <s.trumtrar@pengutronix.de>,
 Shubhrajyoti Datta <shubhraj@xilinx.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Jan 7, 2019 at 4:42 PM Thomas Petazzoni
<thomas.petazzoni@bootlin.com> wrote:

> This patch almost solves the problem. It doesn't work as-is, because it
> assumes that runtime PM is used by all GPIO controllers, which is not
> the case. When runtime PM is not enabled, pm_runtime_get_sync() fails
> with -EACCES, and the whole gpiochip_irq_reqres() function aborts.
(...)
> However, I must say that from a design perspective, I am not a big fan
> of this solution. Indeed for the normal GPIO ->request() and ->free()
> hooks, it is currently the GPIO driver itself that is responsible for
> runtime PM get/put, so it would be weird to have the runtime PM get/put
> for the IRQ request/free be done by the GPIO core.
>
> I believe that either the GPIO core should be in charge of the entire
> runtime PM interaction, or it should entirely be the responsibility of
> each GPIO controller driver. Having a mixed solution seems very
> confusing.

My stance is that the driver is responsible of enabling and managing
runtime PM for its hardware block(s).

Runtime PM in the core should only be added if the core needs to
be aware about it, such as is the case when e.g. a block device
needs to drain its write buffer before going to runtime sleep.

I fail so see why the GPIO core need to be aware about this.

Yours,
Linus Walleij

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
