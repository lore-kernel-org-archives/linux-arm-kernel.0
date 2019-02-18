Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6FECC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 08:53:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82DD021479
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 08:53:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Bd5Mq9DG";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="0juxhV7c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82DD021479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Wp1/Idhsx/YJ8HhHgHz5nSQiR9flHUt+aOTK/QwjBd0=; b=Bd5Mq9DG91NQTd
	JcclfW821myQhM/fyVx/EQ6qeAS16UfnyrA+yxlCvfEifhPN/SnWNyzbVAdZ3aUH9Qu9ygzH7ckuE
	IbNl/fDMsfumgfCe2Nl13ZfzNg0768hPhTXY9OvS0AtWBybQmIiNwrpNPlNfX6LYSeetERk+qgV6Y
	4xuZrICHW/8Gx6glTD7FyxTUt0+ubeRf0Ife5WOpyLkdgK84juBRqhNgnU20JQPDzPZCzOLoZVup9
	mpqUj5RXaKflevuGikoFAtW+gMcJ2V0l4AdvmmzuSuMjBlOGy0DLSMQTj8CJtlBAnSHqn8xatNpKi
	FasYE4f72nT0cEPD0G5A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gveg5-0001T9-Hz; Mon, 18 Feb 2019 08:53:29 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gveg2-0001SR-AQ
 for linux-arm-kernel@lists.infradead.org; Mon, 18 Feb 2019 08:53:27 +0000
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com
 [209.85.167.45])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 1AA6D2089F
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 18 Feb 2019 08:53:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1550480005;
 bh=qcP7uny3Sl+kggljBWRj9/8/O46TfliDOf0ZHCjw2Bk=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=0juxhV7cf7nNPPpqn3e3izmWWedPbVsk4ZLelEZVC3beS6hM8ext6GFCPZytkUlY1
 QQwXcUNtjmhdAa/R0wnB6QBGqsnYjygMubZ+R8rb5IVtgzx9kt4n//S++BSEclMMhv
 g9l8lkscIN0xfVjgHE8i7cgipzMU47285ivhpo6Y=
Received: by mail-lf1-f45.google.com with SMTP id h10so11446672lfc.12
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 18 Feb 2019 00:53:25 -0800 (PST)
X-Gm-Message-State: AHQUAuYfphO2+hbfQMQIKuN9i6AKi7sOzCFRISIn5oBWkRbwqQQGuoxq
 Wk4J7CW7bocOtXlcygbTFriFTIiAJ3JXYwUCcy4=
X-Google-Smtp-Source: AHgI3IYT5rLVvibZrxedg6YKlV60+2Wh5ttsiyEYVTLGgPHDosavvEoC8iQWBeLGBQw3ph83Aqt1miZX2RLLebsjW6I=
X-Received: by 2002:a19:4948:: with SMTP id l8mr14133929lfj.156.1550480003243; 
 Mon, 18 Feb 2019 00:53:23 -0800 (PST)
MIME-Version: 1.0
References: <20190215125229.30180-1-m.szyprowski@samsung.com>
 <CGME20190215125239eucas1p2d9167af42f2d04e462c56a070c3371c2@eucas1p2.samsung.com>
 <20190215125229.30180-4-m.szyprowski@samsung.com>
 <01569ba7-2e3e-5811-81e1-ca51cacbcb95@linaro.org>
In-Reply-To: <01569ba7-2e3e-5811-81e1-ca51cacbcb95@linaro.org>
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Mon, 18 Feb 2019 09:53:12 +0100
X-Gmail-Original-Message-ID: <CAJKOXPfs6i08OqXPZeJ19-tyoj7zY60tjq=fEScjm5wdRR6fXw@mail.gmail.com>
Message-ID: <CAJKOXPfs6i08OqXPZeJ19-tyoj7zY60tjq=fEScjm5wdRR6fXw@mail.gmail.com>
Subject: Re: [PATCH 3/5] clocksource: exynos_mct: Increase priority over ARM
 arch timer
To: Daniel Lezcano <daniel.lezcano@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_005326_377630_C3FE90F5 
X-CRM114-Status: GOOD (  13.05  )
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
Cc: "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 Chanwoo Choi <cw00.choi@samsung.com>, Thomas Gleixner <tglx@linutronix.de>,
 linux-arm-kernel@lists.infradead.org,
 Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, 15 Feb 2019 at 17:35, Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>
> On 15/02/2019 13:52, Marek Szyprowski wrote:
> > Exynos Multi-Core Timer driver (exynos_mct) must be started before ARM
> > Architected Timers (arch_timer), because they both share some common
> > hardware blocks (global system counter) and turning on MCT is needed
> > to get ARM Architected Timer working properly. Increase MCT timer rating
> > and hotplug priority over ARM Archictected timer driver to achieve that.
>
> This is a hack.
>
> There are mechanisms to handle this kind of dependency.
>
> eg. https://www.kernel.org/doc/html/v4.15/driver-api/device_link.html

Hi Daniel,

Are you sure you have proper devices at this point so you can order
dependencies with device links?

Best regards,
Krzysztof

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
