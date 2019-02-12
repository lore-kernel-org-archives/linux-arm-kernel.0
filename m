Return-Path: <SRS0=CPNf=QT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 546CCC282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 12:11:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1FA8F20821
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 12:11:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WaxC74Oo";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mWNQRm+X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FA8F20821
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=6BM5Vm6bOXwIgpNsD2MpfDuzJVL4DL0IJ6tImInM248=; b=WaxC74OoIVfYNH
	fI6/s/EMsYs4anW4671NYlBOUa1q89b1Ide0LS+LkRL9x4MxXOYXYeBJsH66pFgNjhu3Y9aJ3erti
	CiCEZwLZzPzSJeWn8IGMjGEdLhVL0AzF9b/0fNZKDGu+njgCJrIBzF3yysGkdqylXnWFzsZ6yiqL1
	0PoqgJ2Z/pSmeKVBEy2bt8amVtwjD1gSDY5pPPfy/QScRSaowBgOrAbNK1afmhuoh6uhv9jXECXxy
	q9qt/z7L0n9ocn2xhtMng9KjYceBScjhncrb4XhZ+U/2C3wsXZIYsPj19xh/Cg79UJwItpisdVxmv
	9yX1L1bxbjxjFoJlUEhw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtWu8-0005ep-NQ; Tue, 12 Feb 2019 12:11:12 +0000
Received: from mail-it1-x144.google.com ([2607:f8b0:4864:20::144])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtWu4-0005e0-L6
 for linux-arm-kernel@lists.infradead.org; Tue, 12 Feb 2019 12:11:10 +0000
Received: by mail-it1-x144.google.com with SMTP id o131so3299357itc.5
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 12 Feb 2019 04:11:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=U3KPunqeQ9IBIfY3ju/dkpjS3sCKHwTw6046QncIMv0=;
 b=mWNQRm+XXgiEeMaShjb4OTpOMYjOaea/cyQVighth9JIA4LuQxR90c8/oiIgoMl9kM
 NTWdbksy2T5pJ4J2sIYLuVQAViNGQ6jmc9fPZaem0jQOqf363QLOgXCyb/IflAHQkNRT
 67oGumf0KwX6kXWsUpZOSiZ7uS/1pO6nn8JK5OpikKQD4iZucCPnUORtDdSsI4b9PWzK
 cRuqGv0gFnrw222pptp/jMgSyOpzsYt89qgTZ/DqVK5aQk1BBMUsHovbzU2iCVX0T4U1
 0Y2/aoK/huCs2P/Kr8hZ8ywhDl6fEvrYAM9Rau7ohqKrjn74C1JVXFmF/1zlqShNnjsv
 LKTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=U3KPunqeQ9IBIfY3ju/dkpjS3sCKHwTw6046QncIMv0=;
 b=oy+Tf1wvrhJkTIa99nD89jiqzrYrlp0vfIB18fnxEA+xFWxOYnU3hsBtaxUVQrP7ST
 nR6xkV7nYR2Od738IGjs1vfXkvFfqcKnE4GPPoJpX+C72VVSfg5MJQLenJpd+kpibNuc
 iQfDvQYwn0krC6Md0coZWkqcB4GQhr/dmq9a4yE6QHCm98omVePWq6tLaBv68QiH60kx
 m3NhTvfvqszBo7pJMzOcKGe0d8Qfn/DwqfzWN5Q//sTD9p5Uc10s4AhgiqrgbPEtiLrD
 RMSdyKm/Rivxks764Nweh195lpkGWwFfld8Un1rcUL4P8qGTVkwbXrMPQm83xBCaG2yF
 PqFw==
X-Gm-Message-State: AHQUAubTi+nfoW9zSw4g+25AMiRYuydfxoJuQPQM2d0ny0EZrv0a4lJm
 z+krTD0SF7czQblV2sN6saLM3UFJln1s2Wn7PPT+Kw==
X-Google-Smtp-Source: AHgI3IYmkF6GCGgaXM0+GEIW5AQwdHRRnKRzREKPwnAdv07tyEZwS7WLxIhM4GfYAQ7ZGiiDv4jvm192wh/LmCRHZYY=
X-Received: by 2002:a5e:9704:: with SMTP id w4mr2028689ioj.60.1549973466506;
 Tue, 12 Feb 2019 04:11:06 -0800 (PST)
MIME-Version: 1.0
References: <1548740978-28495-1-git-send-email-sumit.garg@linaro.org>
 <CAKv+Gu_RJHb_FwTz+R1bXNQQMsoi0xxcKzn54NF5ib3z2xnH0w@mail.gmail.com>
 <CAFA6WYMXSZPz2qi9+g=EW3+Lm_vuNAOE_M2zWQ_RkfwLfkwjyQ@mail.gmail.com>
In-Reply-To: <CAFA6WYMXSZPz2qi9+g=EW3+Lm_vuNAOE_M2zWQ_RkfwLfkwjyQ@mail.gmail.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Tue, 12 Feb 2019 13:10:55 +0100
Message-ID: <CAKv+Gu-aHENw3xO8E4UrxWONL+xccTt=no0o8xVWfCO0k35p0w@mail.gmail.com>
Subject: Re: [PATCH v6 0/4] Introduce TEE bus driver framework
To: Sumit Garg <sumit.garg@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190212_041108_733687_BA18E9BA 
X-CRM114-Status: GOOD (  23.23  )
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
 Daniel Thompson <daniel.thompson@linaro.org>,
 Michal Marek <michal.lkml@markovi.net>,
 Herbert Xu <herbert@gondor.apana.org.au>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Bhupesh Sharma <bhsharma@redhat.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 tee-dev@lists.linaro.org, Masahiro Yamada <yamada.masahiro@socionext.com>,
 Rob Herring <robh+dt@kernel.org>,
 "open list:HARDWARE RANDOM NUMBER GENERATOR CORE"
 <linux-crypto@vger.kernel.org>, Matt Mackall <mpm@selenic.com>,
 Jens Wiklander <jens.wiklander@linaro.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, 12 Feb 2019 at 13:09, Sumit Garg <sumit.garg@linaro.org> wrote:
>
> On Tue, 12 Feb 2019 at 16:35, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> >
> > On Tue, 29 Jan 2019 at 06:50, Sumit Garg <sumit.garg@linaro.org> wrote:
> > >
> > > This series introduces a generic TEE bus driver concept for TEE based
> > > kernel drivers which would like to communicate with TEE based devices/
> > > services.
> > >
> > > Patch #1 adds TEE bus concept where devices/services are identified via
> > > Universally Unique Identifier (UUID) and drivers register a table of
> > > device UUIDs which they can support. This concept also allows for device
> > > enumeration to be specific to corresponding TEE implementation like
> > > OP-TEE etc.
> > >
> > > Patch #2 adds supp_nowait flag for non-blocking requests arising via
> > > TEE internal client interface.
> > >
> > > Patch #3 adds TEE bus device enumeration support for OP-TEE. OP-TEE
> > > provides a pseudo TA to enumerate TAs which can act as devices/services
> > > for TEE bus.
> > >
> > > Patch #4 adds OP-TEE based hwrng driver which act as TEE bus driver.
> > > On ARM SoC's with TrustZone enabled, peripherals like entropy sources
> > > might not be accessible to normal world (linux in this case) and rather
> > > accessible to secure world (OP-TEE in this case) only. So this driver
> > > aims to provides a generic interface to OP-TEE based random number
> > > generator service.
> > >
> > > Example case is Developerbox based on Socionext's Synquacer SoC [1]
> > > which provides 7 thermal sensors accessible from secure world only which
> > > could be used as entropy sources (thermal/measurement noise).
> > >
> > > [1] https://www.96boards.org/product/developerbox/
> > >
> > > Changes in v6:
> > >
> > > 1. Incorporate some nitpicks in patch #1 and #3.
> > > 2. Bundle all statics in a data structure in patch #4 and use dev_*
> > >    instead of pr_*.
> > > 3. Add reviewed-by tags for patch #1, #2 and #3.
> > >
> > > Changes in v5:
> > >
> > > 1. Add support in module device table for TEE bus devices.
> > > 2. Correct license for optee-rng module.
> > >
> > > Changes in v4:
> > >
> > > 1. Use typedef instead of single member tee_client_device_id struct.
> > > 2. Incorporate TEE bus nitpicks.
> > >
> > > Changes in v3:
> > >
> > > 1. Fixed bus error path in Patch #1.
> > > 2. Reversed order of Patch #2 and #3.
> > > 3. Fixed miscellaneous syntax comments and memory leak.
> > > 4. Added comments in Patch #2 for supp_nowait flag.
> > >
> > > Changes in v2:
> > >
> > > Based on review comments, the scope of this series has increased as
> > > follows:
> > >
> > > 1. Added TEE bus driver framework.
> > > 2. Added OP-TEE based device enumeration.
> > > 3. Register optee-rng driver as TEE bus driver.
> > > 4. Removed DT dependency for optee-rng device UUID.
> > > 5. Added supp_nowait flag.
> > >
> > > Sumit Garg (4):
> > >   tee: add bus driver framework for TEE based devices
> > >   tee: add supp_nowait flag in tee_context struct
> > >   tee: optee: add TEE bus device enumeration support
> > >   hwrng: add OP-TEE based rng driver
> > >
> >
> > For this series
> >
> > Tested-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> >
>
> Thanks. BTW, Jens has created a GIT PULL[1] to incorporate this patch-set.
>
> > although I had to load optee.ko manually in order for the udev
> > autoload of optee_rng to trigger.
>
> Did you built OP-TEE module as out-of-tree? OP-TEE by-default is
> built-in kernel module as per following configs in default defconfig:
>
> CONFIG_TEE=y
> CONFIG_OPTEE=y
>

Yes, but the distros will carry it as a module.

> > Not sure where the discussion went
> > last time, but could we please add "linaro,optee-tz" as a DT modalias
> > to the optee.ko module in any case?
> >
>
> This change is already part of your RFC patch [2] and I agree to make
> OP-TEE as platform driver.
>
> [1] https://lkml.org/lkml/2019/2/4/104
> [2] https://lkml.org/lkml/2018/12/27/196
>

Indeed, but iirc there was a question from Jens and I wasn't sure it
had been answered in the mean time.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
