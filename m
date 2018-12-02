Return-Path: <SRS0=zgA4=OL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3357C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 19:07:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74FEA20834
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 19:07:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="KD5J8iuE";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="y+kXdlDN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74FEA20834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=c3iDRBVZsk6/uq8M5LRVqyCOdw5TxA8SvQx3PnMCrJk=; b=KD5J8iuEer+EEr
	+I6amNfqB09i1bIPFtfSNYqUFuV/yD5G/SH6bW0v0jNen9crz1YJ5+srC0Mg71P6nTz2EUIrrBIZP
	+b0l1JRO5gg0yhtFxeZ8nANtP+CwZBoYwWeDjiAtw8Ynm/73RptUfvCxSVRSVLFR6NptpeuEoZxqC
	nnG5SIZ3NpFML3ljfDaJ0ZMnpBQzQ6OR5ZL8xomX07JQXkXZZnYd724ZItt1BoDUhVBfPxJZFwV8I
	gvQAL3zSAZS6mFG/9Qn5R97FYNz1T8B2HHHe1n1klmxjsjLaAcKeQO9jQ2vgHELFpip76zTrOo93m
	XAF0pL4kMDpBheukImEg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTX5i-0006rk-Hg; Sun, 02 Dec 2018 19:07:42 +0000
Received: from mail-it1-x141.google.com ([2607:f8b0:4864:20::141])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTX5d-0006r9-Sf
 for linux-arm-kernel@lists.infradead.org; Sun, 02 Dec 2018 19:07:39 +0000
Received: by mail-it1-x141.google.com with SMTP id m8so6525817itk.0
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 02 Dec 2018 11:07:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lixom-net.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=eCXOD3Q6bZZ7YgdVWFVLKxYAwxM+uYb/UnG6cIzFbD8=;
 b=y+kXdlDNDzR5xK+OYHPEEerfXhAyr+q/zMTHT816T+UIUGaoc03PQTgmPLoCIhdoNo
 4oAoW3zr8RSIU5OLlblMwUSB2KOQfgMKnZTmFtpebtSzomtuYoZN6vIcekqc/0dtAi4B
 7e4kQz/TtX62/wzeqYFH7dAmbPbgljHLBUJUhpYP5QNgtLKklyzlhA4E4AyjqSIe37hA
 UksRiVI4eJ8zWRjdaUilalLNT86RAClIH5obUZl3opl3wPKOuZEy6bMimL342jShiiGJ
 0C0m9ETQtMxkgyOWmPTN/V8x2Wn/wIoolkZmkSNesrIfvLlPBC0FtlE3OO5UmCcCAm7+
 sN1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=eCXOD3Q6bZZ7YgdVWFVLKxYAwxM+uYb/UnG6cIzFbD8=;
 b=lYsYqOYufRf6taNWURFhDNahBkT4kWa2BCBOK+WNI/sOaxY4ATtGskkrK5tkf+nEwW
 hYCj2QsIwcXQK660PAh970mivNwzOzUJVketGB5H+hSa9oQ3YsO0NJQN0ArMKcIJ8NcJ
 vKXnfk0z0cWGUf77guMuMwU1m26a2CCDiCNogkBOy8VNTuJmnqAgI6fngef/1nmJqtIh
 NVJOHksnG2yUt7eXEK/SjLK86g+5ijRZPrdgmmVl08lIupfGxzASkVk+xRz902WHdgBa
 rQiVGdef9OLqdJ2l0OVbQLkOu28+76j6TtC0laG5IiObKzT1DBCYvNRe5CgRoCLvgGtR
 uGNw==
X-Gm-Message-State: AA+aEWbuDe10WdIZBx11HvdswhPqsJ6MqOUoNboaEvDz0txy/HWmwRVJ
 f58XMpmyor2fAmuJnstsxQUusLtZtXpe4M7yEMvc6g==
X-Google-Smtp-Source: AFSGD/Ww9DR6/k/f3XYFdjVhPdUFermxxASJoig1tHqVLng0FoTc1EAASsONOacQWzlGb1HFuNOnTIheimwS1Ouj0f8=
X-Received: by 2002:a02:88cf:: with SMTP id b15mr12554776jak.10.1543777644781; 
 Sun, 02 Dec 2018 11:07:24 -0800 (PST)
MIME-Version: 1.0
References: <20181128175324.163202-1-lkundrak@v3.sk>
 <20181128175324.163202-20-lkundrak@v3.sk>
 <20181130234205.nejqtrsvwtocpq2t@localhost> <20181201131036.GB31631@amd>
In-Reply-To: <20181201131036.GB31631@amd>
From: Olof Johansson <olof@lixom.net>
Date: Sun, 2 Dec 2018 11:07:13 -0800
Message-ID: <CAOesGMhX0VdqjsAFRZmG2Y7ExRwzdLG61wcYKm7EdM9E7ZRxkg@mail.gmail.com>
Subject: Re: [PATCH v4 19/20] USB: phy-mv-usb: use phy-pxa-usb
To: Pavel Machek <pavel@ucw.cz>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181202_110737_989570_1412CBE1 
X-CRM114-Status: GOOD (  12.27  )
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
Cc: balbi@kernel.org, Eric Miao <eric.y.miao@gmail.com>,
 James Cameron <quozl@laptop.org>, Arnd Bergmann <arnd@arndb.de>,
 Russell King <linux@armlinux.org.uk>,
 Haojian Zhuang <haojian.zhuang@gmail.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Lubomir Rintel <lkundrak@v3.sk>, ARM-SoC Maintainers <arm@kernel.org>,
 Robert Jarzmik <robert.jarzmik@free.fr>,
 Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Sat, Dec 1, 2018 at 5:10 AM Pavel Machek <pavel@ucw.cz> wrote:
>
> On Fri 2018-11-30 15:42:05, Olof Johansson wrote:
> > On Wed, Nov 28, 2018 at 06:53:23PM +0100, Lubomir Rintel wrote:
> > > Use a proper PHY driver, instead of hooks to a board support package.
> > >
> > > Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> > > Tested-by: Pavel Machek <pavel@ucw.cz>
> >
> > These should have an ack from the USB PHY maintainer before we apply them.
> > I don't see him cc:d on these patches though (Felipe)?
>
> I put him into cc now.
>
> USB PHY LAYER
> M:      Felipe Balbi <balbi@kernel.org>
> L:      linux-usb@vger.kernel.org
> T:      git
> git://git.kernel.org/pub/scm/linux/kernel/git/balbi/usb.git
> S:      Maintained
> F:      drivers/usb/phy/
>
> I guess linux-usb list should be cc-ed, too...

Yeah, and depending on how his mail subscriptions work, he might just
get the above email and not the patch.

Lubo, I suggest resending the remaining patches and making sure that
the maintainers are on cc (and the corresponding lists). If you ask
for their ack instead of to pick up the patch, we can merge it through
our tree.


-Olof

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
