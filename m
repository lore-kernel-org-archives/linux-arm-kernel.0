Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42907C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 11:14:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13154217F5
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 11:14:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="VvkHPAdA";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="HU0x6Atc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13154217F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=FfeVG87JnYyP7qKj6d/RmGtaVhkC7PbsdZ21Oit8hvY=; b=VvkHPAdAhrWOuz
	U2ll7NCVTQ6opDjBHmXUevrC5G7eGv1HXekfEm9Qk5oxWRbnULmTQHmZoRElrF4eX3Vi4DukOMhMy
	u3OCYrH7r2GYSEz09lmn/6zgpopc8OBG32godrT4QkvqKpZC+3cmqT1KM1L3AkWkCRQsQphF2zb8l
	nI4fAQlMuNnshAAlLQQcqaWi/g78lKI7vX26c/iO4kSXKj9RqxTG7NBK4KTh1Op9mhb1Wt3FcAy84
	cemNRr2Xv9yVgfotVF2w7ALtSEoU2zmkWRbIvTPcKpPY7/m4JrQ9X7jRgXTBJFdbVAQI5yGlR6feD
	09J+8JvmXLtcCA8UExvw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvgst-0002ZQ-2Y; Mon, 18 Feb 2019 11:14:51 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvgsp-0002Tx-Hn
 for linux-arm-kernel@lists.infradead.org; Mon, 18 Feb 2019 11:14:48 +0000
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com
 [209.85.167.53])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id E1FBB217F9
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 18 Feb 2019 11:14:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1550488483;
 bh=l8/9w6Kg/HHsnA8sN8sMtyT/9DJbnt7UQ+0dwdA0srs=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=HU0x6AtcWVoOlImdWayNlRcexgbQ0gIOtgEh5oUqYbP2vKp8OiBrstluSYsZS1aPY
 oOALT4iY1810zG3xNYsZL4ysJByrbor7U50TEXsJrqL3rzTycv5oI7xAexDoAT1n82
 vMK5jCmM2UYI2jVK+C++8oe0zKEtnk3H8l8ZAHR8=
Received: by mail-lf1-f53.google.com with SMTP id u21so12019513lfu.1
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 18 Feb 2019 03:14:42 -0800 (PST)
X-Gm-Message-State: AHQUAuYbqLx8uKoTsyzzj89qfG+DZ9vnZm0xglGOnkVlx8rkOtSHk0+U
 bzfdStO+9VvNN4ygEva4MXvTpORIhhUKveuUkXg=
X-Google-Smtp-Source: AHgI3IYGbp2ThDqPrK0+LuwjhtPDUOImmT3j8Qojj2Dqt4lNUi8vf64u/CyDAOCL7Ui3jFkbOlffZuvWvxNpYWQAbes=
X-Received: by 2002:a19:4948:: with SMTP id l8mr14548354lfj.156.1550488481012; 
 Mon, 18 Feb 2019 03:14:41 -0800 (PST)
MIME-Version: 1.0
References: <1550484960-2392-1-git-send-email-krzk@kernel.org>
 <CAMuHMdWXy_0zL8FZWapPj4+cXRd0wHy9buLhf0D0txpAHPkK7Q@mail.gmail.com>
In-Reply-To: <CAMuHMdWXy_0zL8FZWapPj4+cXRd0wHy9buLhf0D0txpAHPkK7Q@mail.gmail.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Mon, 18 Feb 2019 12:14:29 +0100
X-Gmail-Original-Message-ID: <CAJKOXPe1CW4k4ivbh4QhKEbuVc3RRNmzUwQcL0BsrAn=hCdjZg@mail.gmail.com>
Message-ID: <CAJKOXPe1CW4k4ivbh4QhKEbuVc3RRNmzUwQcL0BsrAn=hCdjZg@mail.gmail.com>
Subject: Re: [RFC 0/4] clk/driver: platform: Fix kfree() of const memory on
 setting driver_override
To: Geert Uytterhoeven <geert@linux-m68k.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_031447_629379_9F62D2C1 
X-CRM114-Status: GOOD (  17.81  )
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
 "Rafael J. Wysocki" <rafael@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
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

On Mon, 18 Feb 2019 at 11:40, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Krzysztof,
>
> On Mon, Feb 18, 2019 at 11:27 AM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> > The problem
> > ===========
> > Several device types (platform, amba, spi etc.) provide a driver_override
> > field.  On sysfs store or during device removal, they kfree() the
> > existing value.
> >
> > However the users are unaware of this and set the driver_override like:
> >
> >         pdev->driver_override = "exynos5-subcmu";
> >
> > which obviously leads to error.
>
> IMHO driver_override is not meant to be set by a driver, only from userspace,
> for binding the device to vfio (is there another use case?).
>
> >   clk: samsung: exynos5: Fix kfree() of const memory on setting
> >     driver_override
> >   slimbus: ngd: Fix kfree() of const memory on setting driver_override
>
> I see all users set override immediately after allocating a platform device.
> Can't they just allocate a platform device using the override name instead?
> What am I missing?

For the clk-exynos5-subcmu.c case, driver registers several
sub-devices. Each sub-devices is a clock controller associated with
power domain. I guess the author wanted to have meaningful names of
these sub-devices (DISP, CAM etc. like names of power domains),
instead of just exynos5-subcmu.1, exynos5-subcmu.2 ...

If driver_override should not be used for such case, then I could
replace it with what you said.

For the other uses of driver_override (drivers/rpmsg/rpmsg_internal.h
and drivers/slimbus/qcom-ngd-ctrl.c) I don't know.

Best regards,
Krzysztof

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
