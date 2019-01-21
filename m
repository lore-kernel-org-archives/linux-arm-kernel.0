Return-Path: <SRS0=flTa=P5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4778C31D63
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 06:11:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F039217F9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 06:11:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="JCo6CkRU";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qdW6yClj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F039217F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=iOws+yzJyZHNv1lke+yu8MQt5OdxEkqWFfGWTDmTB2s=; b=JCo6CkRUK91Rpz
	nKR1ZpKZ5W2OgHfh4Jp2XtEd+8UqiXKGMlry+ZtgMWeAt3Vu/c/Dou74dJ+0E91jtywqi1LiD0j+i
	C+j5RbObwL2HZr9zDC5T117xML3tMSQfIum8rk4PYF7RCntOhqNMTP2YgIm7OK1uM3Gmsu1BGn9tm
	bwhAwOXo/n/caxDMtbQ3jFfu+C6LiOmZE36IJwSCvTzbxc5Uc7AT2O0UIU84BD0royy9elACcpNuy
	qzaskTVeP3iKG8+ePkz94pHi6ywYw4nE1RwBpqrKT8c7KmVS1qYLgDjGY0XsGKVC+uI/DE/JFEfar
	QlIG6tn8hKhlUklZ7f0w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glSns-0000Xw-MK; Mon, 21 Jan 2019 06:11:24 +0000
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glSnp-0000XZ-8L
 for linux-arm-kernel@lists.infradead.org; Mon, 21 Jan 2019 06:11:22 +0000
Received: by mail-wm1-x342.google.com with SMTP id n190so9598802wmd.0
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 20 Jan 2019 22:11:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=mjucR6CjAKB/oZPowyqDWMqmkQFXb/O28LP7fy8eQto=;
 b=qdW6yClj17Y2yLEVt6gROToTyccasjHt2D3dLjNr2R8RGnXusFOMUO7fbZWl/hcrOy
 lenBIsKbsPGJ1osbfkfXGrxJm/8IRzrBwjxEo2ivqCHbOOF0z3/3t4eZ1H7EAgACGmOV
 5GVqrRVTYLa/6qbZrUXryRmcohB09que06AShydcUOlu4xkOOJLjzCXtfIDNyjBLgi66
 GPNqpEVe4RC52f/SvH0JYMZUk/83dgWFDBpLSqRj8Rr3nugVddoutpaluwj7vH6YeWsD
 XQm6kgHYJUsG+XEwBwI3eVCBhi2lYCNNwVxanwN/TgFJlUEtrHFGWZ+gj966lTY+jDHR
 k3Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=mjucR6CjAKB/oZPowyqDWMqmkQFXb/O28LP7fy8eQto=;
 b=MOmBzx48709gM9dTrVVX04k1ODXuOYdyr/yY+5QclSbqGdNv4MYu5v6Ld6CqswCK4h
 jvbT8el20wQ8cwtspiVRioi5Akv4SIxMYLG/qoOhMuVKmqoaXKzgPoCa5o3R+qNKAKiT
 fKWT09khJQvmVfmgK2ywI4GRrJZe9uQO+V3qguJGQvksV+AWuOSvuMgNQOp4R4Q5y9hZ
 5EeDm1/fYiAPF7S84J5eMCZsYKfhbCMsKu4LJFL22zh/x07PWBX3EoJrJsrTjP3MBQeo
 5j5/twM2ZRkX8zlLqzgRREc4mLeyY/Yt5YfPcEKgwVxcyHbJmwSBhFAI8IxRBHwNVF0/
 AkyQ==
X-Gm-Message-State: AJcUukf5kY49hY0XZhOaYbuVvjVIZrS5g5RZp4TZI7GmMUJz819oDQs8
 jjaSBcXq/fLdJfmX3yJ5V3u+UtL1JHMQmO91oJg=
X-Google-Smtp-Source: ALg8bN7BP7+s3xdf8diWvoxK2GWFipb2aadX2E4QPZ99KIkA4uyCVlSiwjU3ZN4xjbH3fCk4Y42zEMQtYYsbHdasI5A=
X-Received: by 2002:a1c:bb04:: with SMTP id l4mr23437754wmf.142.1548051078579; 
 Sun, 20 Jan 2019 22:11:18 -0800 (PST)
MIME-Version: 1.0
References: <cover.1502103715.git.michal.simek@xilinx.com>
 <72d3cd83bed792a23ab60cf9b6d51b618f5aa084.1502103715.git.michal.simek@xilinx.com>
 <CACRpkdZE-Edr7fWZY5VQM1_65iw7MYGP-iDa2ExZsPxpM0rurQ@mail.gmail.com>
 <6da5fd79-fbc8-b613-954f-dcbe2ef8d6c5@xilinx.com>
 <20190107164210.3ecf37e8@windsurf>
 <CACRpkdafBpC14TxBNVN2AemkBz-yKkXkKfNpdgkYKQX3qFemag@mail.gmail.com>
 <20190111135413.73dad0b2@windsurf>
 <CACRpkdZVfH_LYQov5mkMvp6BWjkVsisawWuE1PMp0b8dW5Qc=g@mail.gmail.com>
In-Reply-To: <CACRpkdZVfH_LYQov5mkMvp6BWjkVsisawWuE1PMp0b8dW5Qc=g@mail.gmail.com>
From: Shubhrajyoti Datta <shubhrajyoti.datta@gmail.com>
Date: Mon, 21 Jan 2019 11:41:07 +0530
Message-ID: <CAKfKVtHrh8r7kp=2br6OCKgWgsNmd5sVG2C96QnhYSFDj7B_+Q@mail.gmail.com>
Subject: Re: [PATCH 2/8] gpio: zynq: Wakeup gpio controller when it is used as
 IRQ controller
To: Linus Walleij <linus.walleij@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190120_221121_318854_8B077698 
X-CRM114-Status: GOOD (  13.84  )
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
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Steffen Trumtrar <s.trumtrar@pengutronix.de>,
 Shubhrajyoti Datta <shubhraj@xilinx.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Jan 11, 2019 at 8:26 PM Linus Walleij <linus.walleij@linaro.org> wrote:
>
> On Fri, Jan 11, 2019 at 1:54 PM Thomas Petazzoni
> <thomas.petazzoni@bootlin.com> wrote:
> > On Fri, 11 Jan 2019 10:54:20 +0100, Linus Walleij wrote:
> >
> > > My stance is that the driver is responsible of enabling and managing
> > > runtime PM for its hardware block(s).
> > >
> > > Runtime PM in the core should only be added if the core needs to
> > > be aware about it, such as is the case when e.g. a block device
> > > needs to drain its write buffer before going to runtime sleep.
> > >
> > > I fail so see why the GPIO core need to be aware about this.
> >
> > In this very same thread at
> > https://www.spinics.net/lists/arm-kernel/msg600515.html,  you kind of

I was not abloe to open the link could you please let me  know if I am
missing something?

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
