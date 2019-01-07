Return-Path: <SRS0=txfi=PP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DF47C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 19:42:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4BD342064C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 19:42:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jD3TQYTP";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="njmpcKyZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BD342064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=LSrInD3FoeCW7zixh0zJ34HwzexrEO32cbfuDRqYO1I=; b=jD3TQYTPVotTSN
	hsl1OByflqBrgaFcoF+SZZvWNnCvHcDyXZU9yUl0Dk0iolOV5vmq8kzjuK36jWeMWZJC9LmxofzFV
	PGweztz+f/j73NvSjA1sw/KeHigVDOl7JE+XHw4MrCqWVsbnQbAp3YF1QWaChIBPGSftG2j5E6aM9
	/UkPV0HQSwR4Z/r/zZ4YlFv095om/0sfSt6eofSAqUj802ALlBGtjnt6ZxOCtijGD68xReLOcsHgy
	dmMfhOneX3PDdZELIUIsFN0L0XkhX7nntPzet9yO2ei3eFJQFnNvCyWQeYrvbvaT8HbeHYJrUJeyd
	altdNLNZxwyBLv8sO5DA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gganU-0004Uu-Oo; Mon, 07 Jan 2019 19:42:52 +0000
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gganR-0004UR-2L
 for linux-arm-kernel@lists.infradead.org; Mon, 07 Jan 2019 19:42:50 +0000
Received: by mail-pg1-x541.google.com with SMTP id t13so569292pgr.11
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 07 Jan 2019 11:42:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=CQnOEASg1G9SHRxqD6ig+kcQJmVRl7JrNnFY/K4/2b4=;
 b=njmpcKyZ7mzw6ok1+1DVLRtDjp7JBoPK9rQ1cYsPLwdQQrP9OCeNF11CJXfIFmbT+x
 gAOuJ31JMe8/7OgK0+eZoYQszed5TfeukZUt6BzNZzeRrEE7l6tYkako9a00pt2nHblL
 8CoBALMZN5eEHi5Miq9YuKNQXK41KQDWrTmiV4WZS0yQL/EyWNh1VYo73OFRSix61rwa
 KE+0w8MaTvWBwvjngLTIgbVcvcL5XaECwGJuljn7kbyvy/VO0yPMqb3rlUM15cNcWg5p
 N86fA7haTUbGMPa7wqV5MIEbCYgB8YwYZ5EA1PYE16VvZntzB5fIch+AvAaCeA6AxLpi
 8NSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=CQnOEASg1G9SHRxqD6ig+kcQJmVRl7JrNnFY/K4/2b4=;
 b=K7byPeWMCbYvC+o5p0fJPAFgFcv5RBgybsfTyljizIkYyevdImb/b+papbEZdUoNtp
 MiRvhP/O0k7QSkT+fdq29U2SQ8VXp/M1BsWJZ0Zai+4dbIJ/UNIZ7dtLSK4m1igfF6ub
 IJo05LWobsK1nsqaEH2zSAb4tHFeXSp/bFbAaAgSlSF3Ye6BXkzr+qvpiubRbToOeRNh
 oIxM2yeIE1wDOVgYh3UTlYxR3n/LCltk0/NG2ggRnst/EVyOXaeyHKO+RL3ynXF2FRV1
 O9S68cwFqKGuMw5oCDozSKaiBPmd5QaRd79jVswWM85QlYkeVqgWD5YSBbkJQ3IkfZs6
 Mkqg==
X-Gm-Message-State: AJcUukfVpJp1NdqZFmoH77k2RN8Xv50n9CrERxC8PVxPqXjdMiV0/YJB
 6DXhFgodYHMaBtD82oHhtBuBuM51F4/HmhDCPWlC0w==
X-Google-Smtp-Source: ALg8bN7JDwIy9oh11W1Mc1WZPHJ5YJqJSxWCPpMdFqpF86J/9zEsTim/1nXAlaMqxNeN8V+VzjqV1e8uX0Jr4VvtI9Y=
X-Received: by 2002:a63:42c1:: with SMTP id
 p184mr11973123pga.202.1546890167491; 
 Mon, 07 Jan 2019 11:42:47 -0800 (PST)
MIME-Version: 1.0
References: <20181205014213.943-1-natechancellor@gmail.com>
 <20181205014213.943-2-natechancellor@gmail.com>
 <CAKv+Gu-N9j5X4WoFDbQrzeOCfBaNm6ujXe_fAruusE_kWdj8iQ@mail.gmail.com>
 <20181205080645.GA11936@flashbox>
 <CAKv+Gu9Nq51Fj_14MYS6MEm0VPHOJB1CBFkCHmyC8Wt0=NWpRg@mail.gmail.com>
 <20181205183606.GA7274@flashbox>
 <CAKv+Gu-2JAiAJqWu9VaaEJ3uFr_B--J7s=iHAN9ze90HD=pXEQ@mail.gmail.com>
 <20181205194519.GA9197@flashbox> <9f43145527aa4220ecde4c3b263241e6@agner.ch>
In-Reply-To: <9f43145527aa4220ecde4c3b263241e6@agner.ch>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Mon, 7 Jan 2019 11:42:36 -0800
Message-ID: <CAKwvOdk-YkXtOKs0SFc3=pEyoe5FaeNqW-JhJii6u34HUvdDNA@mail.gmail.com>
Subject: Re: [PATCH 2/2] ARM: Wrap '--pic-veneer' with ld-option
To: Stefan Agner <stefan@agner.ch>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190107_114249_137423_4719C275 
X-CRM114-Status: GOOD (  14.53  )
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
Cc: Nicolas Pitre <nicolas.pitre@linaro.org>, Arnd Bergmann <arnd@arndb.de>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Russell King <linux@armlinux.org.uk>,
 Nathan Chancellor <natechancellor@gmail.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Sat, Dec 29, 2018 at 4:27 AM Stefan Agner <stefan@agner.ch> wrote:
>
> On 05.12.2018 20:45, Nathan Chancellor wrote:
> > On Wed, Dec 05, 2018 at 07:39:55PM +0100, Ard Biesheuvel wrote:
> >> On Wed, 5 Dec 2018 at 19:36, Nathan Chancellor <natechancellor@gmail.com> wrote:
> >> >
> >> > On Wed, Dec 05, 2018 at 09:09:56AM +0100, Ard Biesheuvel wrote:
> >> > > (+ Arnd)
> >> > >
> >> > > On Wed, 5 Dec 2018 at 09:06, Nathan Chancellor <natechancellor@gmail.com> wrote:
> >> > > >
> >> > > > On Wed, Dec 05, 2018 at 08:37:05AM +0100, Ard Biesheuvel wrote:
> >> > > > > On Wed, 5 Dec 2018 at 02:42, Nathan Chancellor <natechancellor@gmail.com> wrote:
> >> > > > > >
> >> > > > > > This flag is not supported by lld:
> >> > > > > >
> >> > > > > >     ld.lld: error: unknown argument: --pic-veneer
> >> > > > > >
> >> > > > > > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> >> > > > >
> >> > > > > Hi Nate,
> >> > > > >
> >> > > > > Does this mean ld.lld is guaranteed to produce position independent
> >> > > > > veneers if you build kernels that are bigger than the typical range of
> >> > > > > a relative branch?

Just for the list, 2 patches to lld:
https://github.com/ClangBuiltLinux/linux/issues/286#issuecomment-452027802


-- 
Thanks,
~Nick Desaulniers

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
