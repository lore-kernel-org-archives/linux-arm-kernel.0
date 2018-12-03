Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EAC7C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 20:55:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD0B220864
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 20:55:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Mrw6qn9V";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="JQz7oFR4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD0B220864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=tkVN/FLb4G2zNvWPLBQ7UasgJjcCipiS5NLfWeWYyNA=; b=Mrw6qn9VYlOgvm
	M2ouVSsmaLzWE8XabGvnbjgxA8QUttLOtJ76Ww6DsDjb6+pptb9Zbmi+7wgweaku7WVB8wODBEtSf
	Pg53y+d9qOSUFqiBzWDXdVxsbuWUbqk11jJsgBHQKtqQomzj0FvBTnublBeHND7GcM3hOsyLZA9CC
	laxzSFIpu8S4MqRuzdBEdTBGGn8v40EQiE4cc0KK1o/yZQqK+0qqg3FIXfx/IE5y4mIrm7d5N/aQS
	n8ueRuBlsda7WFHQLQqNRedatd7v6MwsBTFLr+zYIsuC51FJSQng3KNWB9lbfFtZpc7YtrB1sqSc8
	1E4eHTsq1wwmr3qqI9dw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTvFX-0002On-FQ; Mon, 03 Dec 2018 20:55:27 +0000
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTv8r-0006Gc-0e
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 20:48:37 +0000
Received: by mail-lj1-x243.google.com with SMTP id u6-v6so12747894ljd.1
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 03 Dec 2018 12:48:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lixom-net.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=7fqI4qtZaSILDNeE2ryuu9AEhVlXWVvdWKX+QGjCY7k=;
 b=JQz7oFR47VXlTlYct4DUSKWsWJ62GFGGMF1pVd6qswUzFOkoI7G6G70Wg28y2WaIQQ
 /bg28uoFax2nIYpH+Hijf1xHI0zBLQJsLhk182vhCbDBIyEkfNWlXCThvDDbRWP/Hp9U
 Pyw6SwTk+li8YWjkiStlY+zXKfoky6uwHQBdONmYcxNJeyKqaUv/MiFzDJVk40uzcnnL
 7mOsTrgPqrOvNJY2krEl6vBGTskEY0NCBTMvFtufagC3qOy4EYU9GFA8B5+3BkvzOdYd
 5SptFePBG4k9hVq2B/u8azVGTaYBwEj/af/Ui3dk6KwaLy0lW/qyETA2el52GYCmRitv
 XFmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=7fqI4qtZaSILDNeE2ryuu9AEhVlXWVvdWKX+QGjCY7k=;
 b=G6mdGbqeKcEntyEWKYU3j0QMElmGm7IR65DFFy7Knzn4DaT19D6Mna59HJSDkUteGe
 qMBNxCcWT41BTrtBD+zwQN+i52yjYBLR5AGiE0gYN/0tQ1YmBER8HXkBBiyPz9faT3qw
 la8aAdAVNA341VEtZJVZU3flY/90xH/aU7Mr6YVZLqKeO/v7ZuoxLWPoqnM/TOXECa27
 YjoBDKme/FkQOjeDu6mNnO3zc+s/ppuw37R/A6z0m+6SKAwi2yvo2vjY8ghSY0xR0tl8
 1EWCVNdlttPjxMEBtPYx5pghT+w0lXmjEIN+jr0ZjRmsaVck/LLlr/xdpOGeIkErpKj6
 P9kg==
X-Gm-Message-State: AA+aEWZXSxuGiVXMHtacGX8/jTV02qIeNrPJRwyK0QDpkAJrAmP+BGaO
 s+kIyzWEafSRoWPffv8XscmM5TqV8qQ=
X-Google-Smtp-Source: AFSGD/UiqOabnvQ8foIS7eN61/LS6KR+/mqq0Lx0H9oIInCPsHBPrN+R+dAcQOXJZqwafHFEaTMcmg==
X-Received: by 2002:a2e:1603:: with SMTP id
 w3-v6mr11004552ljd.33.1543870100956; 
 Mon, 03 Dec 2018 12:48:20 -0800 (PST)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
 by smtp.gmail.com with ESMTPSA id u21-v6sm2707473lju.46.2018.12.03.12.48.19
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 03 Dec 2018 12:48:19 -0800 (PST)
Date: Mon, 3 Dec 2018 12:39:41 -0800
From: Olof Johansson <olof@lixom.net>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] ARM: mmp/mmp2: fix cpu_is_mmp2() on mmp2-dt
Message-ID: <20181203203941.5xwlklfirraf7svm@localhost>
References: <20181202111224.1450-1-lkundrak@v3.sk>
 <CAK8P3a3rEuccqhAgpNR6tP1g826m8o-mWtM1vNmGMb_-H8YMoA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAK8P3a3rEuccqhAgpNR6tP1g826m8o-mWtM1vNmGMb_-H8YMoA@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_124833_314980_34C8CC2E 
X-CRM114-Status: GOOD (  18.17  )
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
Cc: Eric Miao <eric.y.miao@gmail.com>, quozl@laptop.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Haojian Zhuang <haojian.zhuang@gmail.com>, Lubomir Rintel <lkundrak@v3.sk>,
 arm-soc <arm@kernel.org>, Pavel Machek <pavel@ucw.cz>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Sun, Dec 02, 2018 at 04:53:07PM +0100, Arnd Bergmann wrote:
> On Sun, Dec 2, 2018 at 12:12 PM Lubomir Rintel <lkundrak@v3.sk> wrote:
> >
> > cpu_is_mmp2() was equivalent to cpu_is_pj4(), wouldn't be correct for
> > multiplatform kernels. Fix it by also considering mmp_chip_id, as is
> > done for cpu_is_pxa168() and cpu_is_pxa910() above.
> >
> > Moreover, it is only available with CONFIG_CPU_MMP2 and thus doesn't work
> > on DT-based MMP2 machines. Enable it on CONFIG_MACH_MMP2_DT too.
> >
> > Note: CONFIG_CPU_MMP2 is only used for machines that use board files
> > instead of DT. It should perhaps be renamed. I'm not doing it now, because
> > I don't have a better idea.
> >
> > Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> 
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> 
> I'd suggest adding
> 
> Cc: stable@vger.kernel.org
> 
> since this fixes bugs on other platforms when CONFIG_MMP2 is enabled
> in a multiplatform kernel.

Applied to fixes with those tags. Thanks!


-Olof

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
