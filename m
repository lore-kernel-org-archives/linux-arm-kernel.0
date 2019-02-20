Return-Path: <SRS0=0Bxu=Q3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64DDAC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 22:02:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 319732086C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 22:02:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="RERetljl";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="vnFq9iOx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 319732086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:To:In-Reply-To:From:References:
	Message-ID:Subject:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=4I14XhK2fURK6v0NjnwZG4XMc+89FJO4CX0XCoECHk4=; b=RERetljlatoN7E
	aUMuiaGueAXjeRbn2wK5BdRUyhqIK01lEBH/jMCawrhcQ+a47ArQX6AICsDmT3YoViLk6F6vQENHG
	bURyAoJ8KLf8XnmA6EZuzIMu6b5PjmXwJrFX/9+OLrG4/9OqL5oBNGF4lGyHlQ9cB9Yw/Kdf3OPwg
	JNbrz7vNXKucX18uvaUgI03BbOdhMcNlgXUqszEavUt5FTULKRpVwE8jC3KXSKnb1eqLY0csxb+PU
	Iuxc4OLs5u4DTshP8e896dY6DzjXdj8mu3Qw8bqtNmuaCDnF4bOZRgSWC6uudhR8DV+a79SQZ0YAx
	QRR5XSuqzKkViRixURtA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwZw4-0007qN-Tw; Wed, 20 Feb 2019 22:01:48 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwZw0-0007ps-Ra
 for linux-arm-kernel@lists.infradead.org; Wed, 20 Feb 2019 22:01:46 +0000
Received: from localhost (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id D74FE2086C;
 Wed, 20 Feb 2019 22:01:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1550700103;
 bh=b1V4X8VwoeogINSDrQvu6rQo79wgvQir/lEC/Oqv/ys=;
 h=Subject:References:From:In-Reply-To:To:Cc:Date:From;
 b=vnFq9iOxmiCkVYTOsgqNCTLHSQu2AiCJIHfYaPkmJUl1mP6IGrndGai/jIUvXsjYx
 TH5XFVxz2zErxThADQf6TsCK/IjYan0QNoo9ketF8be69Kt4+2u4RVJ5P5nH3Ag9be
 8UaJMIOD9OBcnPijkDp6BxjhOs6B2w7Eohxmzi1Y=
MIME-Version: 1.0
Subject: Re: [RFC 0/4] clk/driver: platform: Fix kfree() of const memory on
 setting driver_override
Message-ID: <155070010208.77512.17397936280518534534@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
References: <1550484960-2392-1-git-send-email-krzk@kernel.org>
 <CAMuHMdWXy_0zL8FZWapPj4+cXRd0wHy9buLhf0D0txpAHPkK7Q@mail.gmail.com>
 <CAJKOXPe1CW4k4ivbh4QhKEbuVc3RRNmzUwQcL0BsrAn=hCdjZg@mail.gmail.com>
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <CAJKOXPe1CW4k4ivbh4QhKEbuVc3RRNmzUwQcL0BsrAn=hCdjZg@mail.gmail.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>,
 Krzysztof Kozlowski <krzk@kernel.org>
Date: Wed, 20 Feb 2019 14:01:42 -0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190220_140144_930827_7CF088B3 
X-CRM114-Status: GOOD (  17.75  )
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
Cc: David Brown <david.brown@linaro.org>,
 ALSA Development Mailing List <alsa-devel@alsa-project.org>,
 "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Michael Turquette <mturquette@baylibre.com>,
 Russell King <linux@armlinux.org.uk>, linux-spi <linux-spi@vger.kernel.org>,
 Chanwoo Choi <cw00.choi@samsung.com>, Mark Brown <broonie@kernel.org>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Kukjin Kim <kgene@kernel.org>, Sylwester Nawrocki <s.nawrocki@samsung.com>,
 linux-arm-msm@vger.kernel.org, Andy Gross <andy.gross@linaro.org>,
 Tomasz Figa <tomasz.figa@gmail.com>, linux-clk <linux-clk@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Quoting Krzysztof Kozlowski (2019-02-18 03:14:29)
> On Mon, 18 Feb 2019 at 11:40, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> >
> > Hi Krzysztof,
> >
> > On Mon, Feb 18, 2019 at 11:27 AM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> > > The problem
> > > ===========
> > > Several device types (platform, amba, spi etc.) provide a driver_override
> > > field.  On sysfs store or during device removal, they kfree() the
> > > existing value.
> > >
> > > However the users are unaware of this and set the driver_override like:
> > >
> > >         pdev->driver_override = "exynos5-subcmu";
> > >
> > > which obviously leads to error.
> >
> > IMHO driver_override is not meant to be set by a driver, only from userspace,
> > for binding the device to vfio (is there another use case?).
> >
> > >   clk: samsung: exynos5: Fix kfree() of const memory on setting
> > >     driver_override
> > >   slimbus: ngd: Fix kfree() of const memory on setting driver_override
> >
> > I see all users set override immediately after allocating a platform device.
> > Can't they just allocate a platform device using the override name instead?
> > What am I missing?
> 
> For the clk-exynos5-subcmu.c case, driver registers several
> sub-devices. Each sub-devices is a clock controller associated with
> power domain. I guess the author wanted to have meaningful names of
> these sub-devices (DISP, CAM etc. like names of power domains),
> instead of just exynos5-subcmu.1, exynos5-subcmu.2 ...
> 
> If driver_override should not be used for such case, then I could
> replace it with what you said.

Looking at the introduction of the code into the platform bus makes it
sound like it was all for vfio devices. If the clk driver doesn't need
it for that purpose and can get by with more generic names then it seems
best to avoid using it entirely. So can you do that and resend the first
patch in this series too? Effectively splitting the clk parts from the
larger issue of kfree()ing of const memory.


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
