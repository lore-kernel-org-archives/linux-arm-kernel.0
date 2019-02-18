Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8835CC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 17:10:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 589F92146F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 17:10:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hjNs66j0";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="P/3QVMRF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 589F92146F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=bRYu5vXXb/BEysOK71Bt/eo1LZe8B2Osi3fW2A0fV1w=; b=hjNs66j0zudFOa
	mdIRGnptQJAWFmr5jy10ot4PC13fCGV7X0VzTke1NXsZgk0o3TXUErTKxad3uCrwtZCeY4nTeFBIh
	5eaSbIK9pO3EAZKOwH+81UzFP/DeeKMnlcEFhOGxkhOGn2dOGAzucPQAXCmaeIRMEgshtl2RNH2QT
	frI7YElFnTdsJbElrlYxhxP26n/eMytqK6yQK33bNa/9vokmWLkQd+OX4o+5C4G9Pmzb5BPkhb1GJ
	wikOkkz/kXd0a3aaNdJ1NNIVLsCZs6oo2tORlWpj/QMY9yFYX970XFT5rACIf3FUd+tRGvR6c1NwV
	3ka1ky6FdWd8DW/jY6rA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvmR6-0001lr-H3; Mon, 18 Feb 2019 17:10:32 +0000
Received: from mail-it1-x142.google.com ([2607:f8b0:4864:20::142])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvmR3-0001lW-7Z
 for linux-arm-kernel@lists.infradead.org; Mon, 18 Feb 2019 17:10:30 +0000
Received: by mail-it1-x142.google.com with SMTP id r11so42864363itc.2
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 18 Feb 2019 09:10:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=DyTk1+oYY8BU8LSV6w0sdrXFLLeS5Pl2fw5zG8Afpp4=;
 b=P/3QVMRFvgsMTama3oot2Yfjy3xx+FYwbTDqAVuPSPgu2OhTcpcsc1PplYSF6DihyU
 Pu3sBnuYQD2i6Z2skjK7qOKZaIICJhXXrOchGQ+gLVk/RXAoKi5Cpil2KXF/pklMkBNc
 PYBSYKC+0eRKurS4eCLIy4iwklRhQJgnGOuWPL+otlId0bhMAYe65WYWQd1A4hrTysiD
 IFgshzs9BdRa2W33w/q2aJgqvSpN8j3IjGu2GnIM4/0FiIt0/6TZg36/MlJmt4xGU/3I
 Mjk09EiPLmbrOI1Nes/HvOtpL0/3zgaEheU7pKLKrWBOzRCvAwjCp3zLTwKLUCGeOXGz
 Q68g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=DyTk1+oYY8BU8LSV6w0sdrXFLLeS5Pl2fw5zG8Afpp4=;
 b=MgqckzvDOGveGEO7ywiJWaKXsmfVtRy39PCGLQO0nuKxazJm/9JX+H9yAuycmkCJkI
 ODlATKWqyFeOB8/Ljyj+NFVzca+5Uhyxdn2zmo+EeAeZorfcU1BcrNBi1yQVl0pwboRf
 ekdcVbkyBqjZOIYi2Au5hr+ZUheAL0CvgO+C72guThXQQ1t4A0Dm91Nd9wGfp67xm/G2
 C8M9Ec/eOOuO42ZSjebPB8cJFsuv+MoIAfEt1b3YNW6zD4CrOkktH8naQB2xDr1O75ju
 yQVR7p0bLh0uI1Q6MG9IaKzLX5VY8Kc6uGCD5MjqpzY5LZRhvV5H+MKsLYgGeYyWHOQB
 YcOA==
X-Gm-Message-State: AHQUAuakvgy4UllCc69vcL915zVTlN8YU+AXKJQDyDNWz/6g6sPcgpHu
 vpdmC5K6I0kvm2aeAosrNViONC2X/Ku/WDT8WRF6bA==
X-Google-Smtp-Source: AHgI3Ibejlzq+TLs+b6LzY+89X/qGsocCPaBqJlm+fEPx8OUhdDoSdQHui4zxryHx/SmlpoFrMD8qZ7Wz0EGh8ycsmA=
X-Received: by 2002:a24:67c6:: with SMTP id
 u189mr12152882itc.106.1550509825832; 
 Mon, 18 Feb 2019 09:10:25 -0800 (PST)
MIME-Version: 1.0
References: <E1gukSa-0003kX-JD@optimist> <20190218113217.GA10794@sirena.org.uk>
 <20190218120921.GA11524@kroah.com> <20190218150853.GA21119@ulmo>
In-Reply-To: <20190218150853.GA21119@ulmo>
From: Jassi Brar <jaswinder.singh@linaro.org>
Date: Mon, 18 Feb 2019 11:10:14 -0600
Message-ID: <CAJe_ZheryjH8EPy+gmBnnXzYWZZO+gXXCYnR7ysQexa9i4rBcQ@mail.gmail.com>
Subject: Re: next-20190215 build: 2 failures 19 warnings (next-20190215)
To: Thierry Reding <treding@nvidia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_091029_276850_E7BB3F3F 
X-CRM114-Status: GOOD (  17.09  )
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
Cc: linaro-kernel@lists.linaro.org, kernel-build-reports@lists.linaro.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Mark Brown <broonie@kernel.org>,
 Linux-Next Mailing List <linux-next@vger.kernel.org>,
 linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, 18 Feb 2019 at 09:08, Thierry Reding <treding@nvidia.com> wrote:
>
> On Mon, Feb 18, 2019 at 01:09:21PM +0100, Greg Kroah-Hartman wrote:
> > On Mon, Feb 18, 2019 at 11:32:17AM +0000, Mark Brown wrote:
> > > On Fri, Feb 15, 2019 at 08:51:48PM +0000, Build bot for Mark Brown wrote:
> > >
> > > The build failure with mbox_fush() in the tegra-tcu driver that was
> > > initially reported two weeks ago is still present in -next (this report
> > > is from Friday but it's also present today):
> > >
> > > >   arm64-allmodconfig
> > > > ERROR: "mbox_flush" [drivers/tty/serial/tegra-tcu.ko] undefined!
> > > >
> > > >   arm-allmodconfig
> > > > ERROR: "mbox_flush" [drivers/tty/serial/tegra-tcu.ko] undefined!
> > >
> > > Is there any progress on getting a fix merged?
> >
> > I can take the fix in my tty tree if I get an ack from the mbox
> > maintainer...
>
Not sure if I was on the CC. Honestly I only look into emails that
pass my very lenient filter. I will add 'mbox' too to it.

> Maybe we can do the below until Jassi picks up the proper fix. There is
> no hardware currently where we'd want to build the TCU driver as a
> loadable module, so that would be fine for now.
>
> It's a bit of churn because I'd want to revert that later on, but it's
> not too bad and would get linux-next back on track.
>
Maybe it should be indeed bool or rather directly selected by your
ARCH because iirc you wanted to send critical debugging messages over
tcu ;)

Anyway, I have sent a pull request with this fix in.

Cheers!

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
