Return-Path: <SRS0=3lKL=PX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E488C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 10:15:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF7BA20656
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 10:15:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="DJo+HFtn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF7BA20656
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=EXgRR9boUZile76iJnaogarZTqvaSrOUcvmDhtkM1ho=; b=DJo+HFtnkPDDB+
	hLNHfXzZaFqKh2C00X/uj/wSgLefJizAhPePwMbgZVuBelsEaX8A2KQDGsf3pw2whCLJJ7wAEC2de
	J684gtcIYA7uhCRUscweFYtskHXx3S92tpLB3J+NziJKrlRTolOF1NxVXJKXm34yJJM4Pc1es3Ycb
	7bDmwFu3Oh7M+UnCIVD7hQ3iYZRZtHPNSoB2/SIaf4U7Qo0RGSOEqBcddaXqfjMrOTbSSc3JBrVGX
	sqAISG+5hZjIrCBypVn8UiuiM2Cuv+O3yfOau6nwf7vHb6R/bjDe4bJu+M4PEj3bzQdeiHGZpN8CI
	L0SH0ytAeQmAWcS/tZxQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjLkM-00005E-GT; Tue, 15 Jan 2019 10:15:02 +0000
Received: from mail-qk1-f181.google.com ([209.85.222.181])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjLkJ-0008WD-62
 for linux-arm-kernel@lists.infradead.org; Tue, 15 Jan 2019 10:15:00 +0000
Received: by mail-qk1-f181.google.com with SMTP id a1so1214620qkc.5
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 15 Jan 2019 02:14:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=A4NVrf4YA37oM1xzFY1YY7mEAMOATlF1WBUkJyq13RM=;
 b=Hyw48bsR8riltWvz2mOmQuYeA9khB+s25Tu/QUNF3ZUc8lDh8q7VLtA5W8b5Zvs/Da
 Zw/M+GYOhF0jGaRUjPn/PhIuGu4Eu3m9JF/mFDTx429I+NzyCAyIwt6VPW6dD+1NKj7w
 pL/9o68NxBWdnUeL8Dz5niXg2DZrp1i71gcW14gxtIdc/vuCu+gCOhDCXMTOWcJYc5WU
 BvB04SdPbwIon+2jodRxIr4rnx3nAHun3FhimBnuf1Osk+CE4BtEr/FzruHj6Us+RyCA
 zIhNHHI6fsW0iVYd8XYnD9aFxSr/FpvkzMNwRn9UzuT/pBJl2J4BB9pHo4iHGKo5ImJz
 SDEQ==
X-Gm-Message-State: AJcUukecZnv/maBgD04xCu7JuUrc5q4G2qPTVeS93+Hn0rk2lCLAw/Qn
 mXzJ6MCO+AouzQvLecVTDLcFHze4qvCfxunBjQXe7A==
X-Google-Smtp-Source: ALg8bN7jXc/rAVviNf1GcVyqWKnJfiYhNdVehetneSIfyRG83xoWqttbtY7K9QUMnVJENw0H0qMD4X4kJ47nZCUONdw=
X-Received: by 2002:a37:bdc6:: with SMTP id n189mr2109300qkf.330.1547547297644; 
 Tue, 15 Jan 2019 02:14:57 -0800 (PST)
MIME-Version: 1.0
References: <CACRpkdb-zphMyZbGh5XYy2A6B1224BGFmTwr0Bm98G3oM0MeoQ@mail.gmail.com>
 <CAK8P3a08TV+sQhsCPjkXh6wOKEpLfGLqVo9+FHoXzDVXs_bY7A@mail.gmail.com>
 <CACRpkdZ7KSmgTYP8a_RUJAWKzuc652OZ420Lq4ZnzkCuESLZ2Q@mail.gmail.com>
 <b5e70ac4-4cf8-9abe-ec30-7d225089caf0@hilscher.com>
 <CACRpkdYnbCmfTVB_aFX-vhkbWma=60U0D6pKZ8bcKdxCdSXdyA@mail.gmail.com>
In-Reply-To: <CACRpkdYnbCmfTVB_aFX-vhkbWma=60U0D6pKZ8bcKdxCdSXdyA@mail.gmail.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 15 Jan 2019 11:14:41 +0100
Message-ID: <CAK8P3a2c+W7rZu1T2U1ryZZgaOAs6nqcp4h3m9fTQtZ4UR3+kQ@mail.gmail.com>
Subject: Re: Re: Hilscher NetX mach-netx refactorings
To: Linus Walleij <linus.walleij@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190115_021459_223902_5C2653F0 
X-CRM114-Status: GOOD (  11.27  )
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
Cc: Ladislav Michl <ladis@linux-mips.org>,
 Michael Trensch <MTrensch@hilscher.com>, nagasureshkumarrelli@gmail.com,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Olof Johansson <olof@lixom.net>, Robert Schwebel <r.schwebel@pengutronix.de>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Jan 14, 2019 at 3:22 PM Linus Walleij <linus.walleij@linaro.org> wrote:
> On Mon, Jan 14, 2019 at 12:26 PM Michael Trensch <MTrensch@hilscher.com> wrote:
> > The netX4000 platform is only built using a device tree. The device tree
> > files were sometime ago moved out of the kernel into our yocto layer to
> > reduce maintenance and have a single location. I know this conflicts
> > with mainlining.
>
> No big deal where you keep the files as long as they are merged
> when we implement the platform in the upstream kernel.

Agreed. It's usually best to have all reference boards working out of the
box using the dts files supplied with the kernel, but for customer specific
machines, we don't care much whether they are shipped with kernel
or some other way (e.g. bootloader, formware or distro).

      Arnd

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
