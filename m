Return-Path: <SRS0=Odjb=PR=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C6A4C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 11:15:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2DE0E21783
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 11:15:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="uf5V8q5M";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hPeMbZpm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DE0E21783
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=zktcUFLUWSO1bcj0uf7tzEpQ8s/+TtDd7cVCPqgIBUs=; b=uf5V8q5MTFnt9U
	8uDike5+5wNklM+bJyObL0KfIZ5lH0BCfDB4min6+k5si41CrP+/heZ7PgQ2luoJ8oyrPWsKSA++x
	IqVG1YJAvIJy0ARQJi9ItyZYRi60qLe1cMOXVhsYWU+dOr9J/tY8VQ1RN22py6EJZzG1aBTmjaLWS
	6nvJFmMN08d1F/H8LWsUhVHnCVEFKmslyHEBwyKESz/wASnXNW6TOdfpNCzW4tjdXb4qmkUQ8zOrX
	bdexQZ50EoPytKJZ+Yom7K8Prvt1CZLPIuNvAOKrQCMaT1os/0DEtqJZDAvcByVNp5BtQ0Qu4JTSz
	FVjfy1wDm+ay2p/TamJA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghBpu-00012g-1i; Wed, 09 Jan 2019 11:15:50 +0000
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghBpq-00012B-QP
 for linux-arm-kernel@lists.infradead.org; Wed, 09 Jan 2019 11:15:48 +0000
Received: by mail-pg1-x544.google.com with SMTP id d72so3166946pga.9
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 09 Jan 2019 03:15:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=eacqgTZrpjzcqQzKQWY4B35kDdh5bBoqeUPPxbaU/l4=;
 b=hPeMbZpms10uyzfoVo1BusSjyvkih/jyrCP4qJRS/YC/X2dQetsPeArSVRt3eAeXMI
 uX4EQweYdm+VdBnVTKrzCjEPd2o81pTxhqf7bkmhr+RZSd4svATHWiTGM7CdU9NZBCUQ
 O+sB8GZfWUwVH2UcunB266bDGgosbY6OiqE1o1nKWNiIR2uzeEVxvxWv8WFOmxs89JCI
 AWr85cO6F5XXLj5VW96jvpi+dDSIwZ3pLx+F/s//X23AARy0vrI6NOHsybZmBJVXb/eq
 b4vxVK7gqt5dTyT3zk5s/DMZL/QqIaYR++opsmgFuKLo/TuPQJF1z4/+xXYc0JMJvbuN
 hIdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=eacqgTZrpjzcqQzKQWY4B35kDdh5bBoqeUPPxbaU/l4=;
 b=X6A2ues24t6Q7mq8G3dEOi1yR12r4bdwSzVleVT1QxKDuYF9iCCJ5WV6W/ijH/w17N
 0mjIVBVM2ZDBP2ZrLJgeHwTxQl1CDXui+SukqnM5PmDfT545u+u7tZf46Ug3Z1jMIr7c
 F9yhi3UGYuUjIMtf10RyhZbtQ9uh3U6L8jD4xVo79zol0Ka4MVVyrAS/Mjbv3l0FvVn8
 il6i56F0lQbx5oTr3iRwPdVwPXnEo8JuqPwJKoEKkTPAGvGGWMZyhV3R4NjhsyToRUCL
 f9SLae7L1bHp2Y/9t0MXPYzHFU6vDd7heJElYnurADDxyfG+P4RsJ13XymFTaLaLjWMF
 mU+g==
X-Gm-Message-State: AJcUukeJ0zUWX7D2VKZu0zjXL3CXelUaC7QlxMoVtpAxzJ5w9lW4yYAn
 JNykeGZx4XOb4QWdIE1SJKVb9tc3dKzvj9bu8ZQ=
X-Google-Smtp-Source: ALg8bN6oovhhl339ABpM7OHWhdMHFk5MLvzh+EMmhdyuSeCossigT+8tGqoXGbXsV0ki3/ziUM/2neg7t+JUf1uN9Ms=
X-Received: by 2002:a63:f615:: with SMTP id m21mr5103263pgh.428.1547032546312; 
 Wed, 09 Jan 2019 03:15:46 -0800 (PST)
MIME-Version: 1.0
References: <20190108175818.705110-1-lkundrak@v3.sk>
In-Reply-To: <20190108175818.705110-1-lkundrak@v3.sk>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 9 Jan 2019 13:15:35 +0200
Message-ID: <CAHp75VcDXmARXAyE1tPouj0cLqg1Ohs5hq+LZ7dsoGY8pJWO2g@mail.gmail.com>
Subject: Re: [PATCH v4 00/15] Add support for OLPC XO 1.75 Embedded Controller
To: Lubomir Rintel <lkundrak@v3.sk>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190109_031546_860947_CA4AADFF 
X-CRM114-Status: GOOD (  19.92  )
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
 devicetree <devicetree@vger.kernel.org>, James Cameron <quozl@laptop.org>,
 Linux PM <linux-pm@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "maintainer:X86 ARCHITECTURE \(32-BIT AND 64-BIT\)" <x86@kernel.org>,
 Russell King <linux@armlinux.org.uk>,
 Platform Driver <platform-driver-x86@vger.kernel.org>,
 Rob Herring <robh+dt@kernel.org>,
 linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
 Pavel Machek <pavel@ucw.cz>, Sebastian Reichel <sre@kernel.org>,
 Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Jan 8, 2019 at 7:58 PM Lubomir Rintel <lkundrak@v3.sk> wrote:
>
> Hello!
>
> This is a fourth spin of the patch set that adds support for the
> Embedded Controller on an OLPC XO 1.75 machine.
>
> It hopefully incorporated all feedback received previously and also
> fixes the kbuild test bot failures. The failed builds were generally
> caused by configurations where the EC driver was built as module.
>
> It turned out that the patch that turned the OLPC EC common code into
> a module was not the brightest idea. I now dropped it and modified the
> 04/15 to not require it.
>
> Also, the 01/15 patch has been added to allow the module to provide a
> reboot handler. Patch 15/15 depends on it.

Isn't it a quite big distance between provider and consumer?
Especially taking into consideration concerns about patch 1 which
blocks the series.
Perhaps you may drop it as a patch 1 and do something on top of patch
15 as feature extension?


>
> Tested to work on an OLPC XO 1.75 and also tested not to break x86
> support with an OLPC XO 1 machine. I don't have a XO 1.5, but it's
> unlikely this breaks it when XO 1 works.
>
> [01/15] ARM: export arm_pm_restart()
> [02/15] dt-bindings: olpc,xo1.75-ec: Add OLPC XO-1.75 EC bindings
> [03/15] Platform: OLPC: Remove an unused include
> [04/15] Platform: OLPC: Add XO-1.75 EC driver
> [05/15] Platform: OLPC: Avoid a warning if the EC didn't register yet
> [06/15] Platform: OLPC: Move EC-specific functionality out from x86
> [07/15] Platform: OLPC: Use BIT() and GENMASK() for event masks
> [08/15] Platform: OLPC: add a regulator for the DCON
> [09/15] dt-bindings: olpc_battery: Add XO-1.5 battery
> [10/15] x86, olpc: Use a correct version when making up a battery node
> [11/15] power: supply: olpc_battery: Use DT to get battery version
> [12/15] power: supply: olpc_battery: Move priv data to a struct
> [13/15] power: supply: olpc_battery: Use devm_power_supply_register()
> [14/15] power: supply: olpc_battery: Avoid using platform_info
> [15/15] power: supply: olpc_battery: Add OLPC XO 1.75 support
>
> Lubo
>
>


-- 
With Best Regards,
Andy Shevchenko

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
