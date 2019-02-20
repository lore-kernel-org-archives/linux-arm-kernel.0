Return-Path: <SRS0=0Bxu=Q3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AEFDC10F01
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 12:28:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C3462086C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 12:28:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="H+B5VuN4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C3462086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=z/zN7gsKsG2SiAMfoLL+vmYFVCTYDf/ARd7NmuORlE4=; b=H+B5VuN4pllalI
	5Z/lsLrt31CDvbVjHDHnPle3JbVvL6zQh02PUCfCtct5OscYY5wG5vg4raetZaMmRE1QE5b/priKE
	kQzOpX8UQv5v5Sm/VRSlXWTYTuRLI2pT5YPnHx+yBP8ujmZEs2ADJym1d1E5cxfuw+nIgHBMaBsDt
	CJamPfM1997Rzuot9Nf9xC6no1fGWOtwkiJPACDbf2KxzJSoosqn3PVJD8x8mDUC3PNFQsiK8abJK
	pmjBvQ8Q6k5aHRv4piQQ0cT+4GxgjAnIKB3lhyWrlNWQ7AsYn8NEgXIZnIiPe5lsQKMD0DcpNwKrX
	VJHCBEZFwnW0jmZKAykQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwQyw-0006a3-FY; Wed, 20 Feb 2019 12:28:10 +0000
Received: from mail-qt1-f194.google.com ([209.85.160.194])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwQyt-0006ZQ-F3
 for linux-arm-kernel@lists.infradead.org; Wed, 20 Feb 2019 12:28:09 +0000
Received: by mail-qt1-f194.google.com with SMTP id d18so16840673qtg.12
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 20 Feb 2019 04:28:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=qpVtmXWnUR6+AzKQ5x7/2Jxa2crHJLHdoYgYHT/Hz/k=;
 b=dr0OTsxkJnUZZ99B23Xn5zPfy9vj3ExEEsTRWtV8rAYvepfcNJNgwoHa2jydV28j+l
 s2LV8td2ugiVvGz4inzbHeG0CbvU8B1Fu8DFdav5Elncfdw3kw009aCRan5JBzxj+eYC
 GSxjA10URxfhNy6PuV9DVxJBOlRTEY7D9h3ogT08DMr0c35WNSExHtS6IQiTa9TkTR9k
 eOyzTH1N0a09s69yGNUXdnicr1IsIFLf0ZyTASe0fnoDM7vXLPzpt8tcPLzgFZNt8Y6t
 jTEz6+aLXC/7WgEkbPbQaib47z5Bm9Cqyw5WcsfjS2EZ7vkWtnBEYJkJpLc9xVAovKnr
 A2IQ==
X-Gm-Message-State: AHQUAubpVyhFlKF73KrqdR25MstMBCAbeEAPYEv4glHgbmvO8Pc2BM2o
 plFl3Pht/D8q/O2fE3+pfSrA5BYZjutJGIfACbI=
X-Google-Smtp-Source: AHgI3IYs016lvGTbEhlkEfyu7S9JKmMCX/KgexhWw8eFmTxdMR7VJK63GYBzSVpKga9havmq9Q6/17Tflzj/lvlekcw=
X-Received: by 2002:ac8:33f1:: with SMTP id d46mr26370180qtb.319.1550665686080; 
 Wed, 20 Feb 2019 04:28:06 -0800 (PST)
MIME-Version: 1.0
References: <1550648704-11545-1-git-send-email-sugaya.taichi@socionext.com>
 <CAK8P3a0rwi=uDFYiF50e5HkYoDQUA6_VSWDMiAVeTMaRzeE6oQ@mail.gmail.com>
 <dbe814ed-3cf2-f72e-b7fa-23cf41e9e42b@socionext.com>
In-Reply-To: <dbe814ed-3cf2-f72e-b7fa-23cf41e9e42b@socionext.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 20 Feb 2019 13:27:48 +0100
Message-ID: <CAK8P3a38qgw8LeX=Y_nG53HzjnXjHESekgnJ6jtW_xvd7Zvq-Q@mail.gmail.com>
Subject: Re: [PATCH v3 9/9] ARM: configs: Add Milbeaut M10V defconfig
To: "Sugaya, Taichi" <sugaya.taichi@socionext.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190220_042807_514185_514EC151 
X-CRM114-Status: GOOD (  26.43  )
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
Cc: Shinji Kanematsu <kanematsu.shinji@socionext.com>,
 Masami Hiramatsu <masami.hiramatsu@linaro.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Jassi Brar <jaswinder.singh@linaro.org>, soc@kernel.org,
 Takao Orito <orito.takao@socionext.com>,
 Kazuhiro Kasai <kasai.kazuhiro@socionext.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Feb 20, 2019 at 12:27 PM Sugaya, Taichi
<sugaya.taichi@socionext.com> wrote:
>
> Hi
>
> On 2019/02/20 18:28, Arnd Bergmann wrote:
> > On Wed, Feb 20, 2019 at 8:44 AM Sugaya Taichi
> > <sugaya.taichi@socionext.com> wrote:
> >
> >> diff --git a/arch/arm/configs/milbeaut_m10v_defconfig b/arch/arm/configs/milbeaut_m10v_defconfig
> >> new file mode 100644
> >> index 0000000..a263211
> >> --- /dev/null
> >> +++ b/arch/arm/configs/milbeaut_m10v_defconfig
> >> @@ -0,0 +1,175 @@
> >
> > I no longer see anything here that should be turned off, but you
> > might want to run 'make savedefconfig' and use the output of that,
> > to make it easier to keep it up to date.
> >
>
> I got it, I use the output of 'make savedefconfig'.
> One question, is that OK to add some options on it?
>   -Because "CONFIG_ARCH_MILBEAUT" was not listed.

What I'd do here is to apply all the patches you want to get merged in
the next few releases before running 'savedefconfig' and use the output
of that.

If you already know that you will need the options, including
them now means you don't have to update the defconfig file
as much in the future.

> >> diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
> >> index 5bee34a..6753805 100644
> >> --- a/arch/arm/configs/multi_v7_defconfig
> >> +++ b/arch/arm/configs/multi_v7_defconfig
> >> @@ -54,6 +54,8 @@ CONFIG_SOC_VF610=y
> >>   CONFIG_ARCH_KEYSTONE=y
> >>   CONFIG_ARCH_MEDIATEK=y
> >>   CONFIG_ARCH_MESON=y
> >> +CONFIG_ARCH_MILBEAUT=y
> >> +CONFIG_ARCH_MILBEAUT_M10V=y
> >>   CONFIG_ARCH_MVEBU=y
> >>   CONFIG_MACH_ARMADA_370=y
> >>   CONFIG_MACH_ARMADA_375=y
> >
> > I'm surprised that you don't need to enable any drivers. Does this actually
> > boot on your hardware?
> >
>
> Yes, but not exactly.
> The series has not serial driver, so I add the driver temporarily and
> confirm the boot log through earlycon.
> The timer driver is selected by "CONFIG_ARCH_MILBEAUT_M10V", no need to
> add the the"CONFIG_MILBEAUT_TIMER".
>
> Here one more question.
> Is this OK to submit a core support patch without any serial drivers?

Yes, we are fairly flexible here. Greg also mentioned in the past that he's
fine with having us merge the serial driver through the arm-soc tree after
it has been reviewed, to keep it together with the platform support, same
thing for the clk, pinctrl, clocksource and irqchip drivers.

However, once the platform support is merged, we prefer that you do
any other driver changes (including newly added drivers) through the
subsystem trees.

      Arnd

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
