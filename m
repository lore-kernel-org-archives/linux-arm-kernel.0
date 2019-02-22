Return-Path: <SRS0=2lwk=Q5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11393C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 12:26:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D315E206BB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 12:26:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="S+hDkeVS";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bmbKWgqo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D315E206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Trga0LV989+Q1Z3FkcFsJ3MGWY/g/noLeiiuujKTRok=; b=S+hDkeVSWlCbog
	DtCRTSwjWrBngXFdSbrGq9TVtIOQARykrIiGJbmFdiTDuUC0wVDJ2js6ZaCVeB0FI/epte5P2bV1n
	9LBx5COoBT9vpJtDTQdaOUZU9C84VXEkwqVbg7TN0ZcboI30GwnDqqxGNu1Pz+tlEVgOeOTgWOubW
	JQyEf8Wev3seXZy9vgXTmSoVkNTiBI/+cheOeLilpWqgTG2tBbA+HW8b7KYJ5vW5MajvfvZv6WZe/
	3AghReAsoJdMzvq62elqAHGmIHMFe/vGogXtxa1E2P0MjdE1iOxd133L2oiyxtjcd0wQKg5cHx8u5
	bT/dLC5Wb6hjCFzfZy4w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gx9uC-0000GT-G8; Fri, 22 Feb 2019 12:26:16 +0000
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gx9ti-0008BH-JN
 for linux-arm-kernel@lists.infradead.org; Fri, 22 Feb 2019 12:25:52 +0000
Received: by mail-ot1-x342.google.com with SMTP id i5so1665874oto.9
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 22 Feb 2019 04:25:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=9OQYCHLmItJjlfovT/0aeWPjmIyOTlBqjq9k4xMjZ08=;
 b=bmbKWgqowBTqBltF8JRMQBkd5CTPGBiiRLWUG7Hxa2TlDyjvAS4NCXqPxSG0S/b4xv
 rSuf4SRKJCFk3qs2qLRNIj8GELOXn8spmZrz5ZQDRcfV7qgOWoFcNXe/zmHnRYSxjxkJ
 VpVkz0W/ZYUF/Vepq9agafdXkogxlWLM0AtWfSIaS9cxAdY4jjYm8o5noc8Y5dnD6H3V
 BryeirtVrgZa6FPWPYtmR2AGB8kPx35XLLMS1Hx5s/qBlglr801tsTKTRLAsfXM2O6Rl
 WNqyHE12wsmfGzabf5xVU2A1bujM+kHPS5M/QF4GY/AOv9T9BLlPXDB3L2gJbFurmgzm
 KiHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=9OQYCHLmItJjlfovT/0aeWPjmIyOTlBqjq9k4xMjZ08=;
 b=dEIoM88GOhN0nP8zhjZkllBoT4D4R7qH25BhvN/Ank8y0yUBMMT9tnd9s7rtJ9xrjj
 z8BI0+aOmlcVQ7edVGDxtsG1BIM5oYWd8ZppcziioDXeUA+NG29C6csAJ/jg066NMFxM
 8hBKf88MPZjPIGi4VQK7zpwcWQgTGRSCMlOp1o5cyEO6cS8CovUg7hvE9BSP9RLprBtX
 HOoMVgYGnaDO82wC3AjBMb4rN8A+DQBJ0iSaGOt7m+mewX6VU2kKd6tK5MOFdA3qW7Sm
 7tjPI7qG8wOyYfXbv0irwDtL55Xi/Vp4ZHYZc9tQTJI4Tj2aAfp9ixDamLysn07CC2kj
 qzLw==
X-Gm-Message-State: AHQUAuZwfQ1C9Tk0C9DUbOxUUBSWrjuZNxlPP5UBQgZT91ASmu8iNXqX
 Qq9gkdXPgXh0jVZ41SP+QCOfsDX1WboH7MWg9fQ=
X-Google-Smtp-Source: AHgI3IapEH8CqnRZvmDvFk1xveh9ipONHnXuL7FpmrWLM+dOY+DFnpRWx5lab60tjgRSqx0btI6/MQRQIJu7Fu/7Jn4=
X-Received: by 2002:a9d:6d94:: with SMTP id x20mr2439094otp.78.1550838345380; 
 Fri, 22 Feb 2019 04:25:45 -0800 (PST)
MIME-Version: 1.0
References: <20190222.174953.431124434951497467.okuno.kohji@jp.panasonic.com>
 <fa4d10499733fe96361a0b61ff3e8ba0dd62c837.camel@pengutronix.de>
In-Reply-To: <fa4d10499733fe96361a0b61ff3e8ba0dd62c837.camel@pengutronix.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 22 Feb 2019 09:25:34 -0300
Message-ID: <CAOMZO5D1Q1ZJh0OYietbScjK01U7onea=o9QcDD_qtMkjS=5gQ@mail.gmail.com>
Subject: Re: [PATCH] ARM: imx6q: cpuidle: fix bug that CPU may not wake up
To: Lucas Stach <l.stach@pengutronix.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190222_042546_910752_64C4FCB8 
X-CRM114-Status: GOOD (  15.52  )
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
Cc: Sascha Hauer <s.hauer@pengutronix.de>,
 Kohji Okuno <okuno.kohji@jp.panasonic.com>, NXP Linux Team <linux-imx@nxp.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Kohji,

On Fri, Feb 22, 2019 at 6:14 AM Lucas Stach <l.stach@pengutronix.de> wrote:
>
> Hi,
>
> Am Freitag, den 22.02.2019, 17:49 +0900 schrieb Kohji Okuno:
> > Hi,
> > I found the bug in cpuidle-imx6q.c. Could you check my patch?
> >
> >  In the current cpuidle implementation for i.MX6q, the CPU that sets
> > "WAIT_UNCLOCKED" and the CPU that returns to "WAIT_CLOCKED" are
> > always
> > the same. While the CPU that sets "WAIT_UNCLOCKED" is in IDLE state
> > of
> > "WAIT", if the other CPU wakes up and enters IDLE state of "WFI"
> > istead of "WAIT", this CPU can not wake up at expired time.
> >  Because, in the case of "WFI", the CPU must be waked up by the local
> > timer interrupt. But, while "WAIT_UNCLOCKED" is set, the local timer
> > is stopped, when all CPUs execute "wfi" instruction. As a result, the
> > local timer interrupt is not fired.
> >  In this situation, this CPU will wake up by IRQ different from local
> > timer. (e.g. broacast tiemr)
> >
> > So, this fix changes CPU to return to "WAIT_CLOCKED".
>
> Please send patches inline, instead of attachments. That makes review a
> lot easier.

Yes, please re-send it with "git send-email" and also include your
Signed-off-by tag.

It looks like a good fix.

Thanks

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
