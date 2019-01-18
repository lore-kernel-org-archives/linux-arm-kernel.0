Return-Path: <SRS0=p0aQ=P2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F22DC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 13:32:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D998920883
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 13:32:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="YJZxs88y";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="f9IzUZWh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D998920883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=EQ2yEbpqQUnFaW1i8/lUHJ7rYrxvk9pN2BXew5wIdnU=; b=YJZxs88yMHU5sH
	3R33P35tZuzydZnjgmUJjGKoVHNd5ck7EshQUtn2tVmcsWpU/nekMmpSAQ5s+XsQE5ape2zLV1fRD
	tv0BredS/n/2x6z0MDlLmQ+zvi8/rbfJeOSLpCUnTsiZ9u3ULtnEibhJLEFm1OJ4aTfDCr5vxwSE6
	sauwDrsEsYVXqm0rGeNi8Ffl6lQHn4OCUGYKX2MggywDcipzljtrjuE5ALp3f4uuN4/1yKHil3ifs
	ADxyhX7ip++5EYMn9EGkmFOYFp1YT2RFwsGKLz5kcxjCydjzbcnSa3Kv0vYbH+akTk6u1Mdnqg/dt
	n2h7qRLUMSM0EQPnteMQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkUFn-0001EL-25; Fri, 18 Jan 2019 13:32:11 +0000
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkUFj-0001Dh-Nh
 for linux-arm-kernel@lists.infradead.org; Fri, 18 Jan 2019 13:32:09 +0000
Received: by mail-lj1-x243.google.com with SMTP id v1-v6so11669879ljd.0
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 18 Jan 2019 05:32:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=/mO+zplovGLvdBHr95yPUprqS4aeUd/JsEOAqo8TwYI=;
 b=f9IzUZWhRORgCJI3gwI4BlHy4vzTMcOim9xsd9FuK1f84DdAfW/W++KigA6a0ZH8OC
 WFPgkVoOW4jt6dGC/JLfAbcCO2ofHd94XLr3Df/QXCGkJ37xz0h32RdWYgMmfcGvZ0UY
 YZBzIRD3Mh9yOh2Ba4C1rqeJO0SK4lHgEST74=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=/mO+zplovGLvdBHr95yPUprqS4aeUd/JsEOAqo8TwYI=;
 b=FWrtp2jFFRCph6Lrk/yvH7I6X63QQn3TCD9jz1a+EpHu9LGnyxxCxJG3/u9dRyNJtN
 yNc9lV+B40xA/ZDRkOD3UQ2HxXaYgc60izKpk02rJ1iCFWvKuxbUPr7vKarG+O6vpjse
 dFOby4EUSsdtxeZ6jSAYNhuLPwaPEz14FnLIPXJ1dsVb1iUKPMUjxG/CfwWZ+CWGCodb
 9U7zciKA8zbqnKRbaYIfWbuOKrI2xLC5SGMfrziG3LYr5s6Sc05NhlQsOAUoqhy48k+7
 wgbwnUa08kttOWLWYD6diy4WRoK9xsEvYwrjXqQlU1XQdcQ7/UZTDdWNqyEf39HNFZVs
 e6PA==
X-Gm-Message-State: AJcUukdaWva5ynynvLqdPEyB7ViCqCvemESaSpA+6UN466CwFAsA7RRf
 sVoNYqMBCaretiAc/cZzcuem9fBhV2ITZTd7e+eBcw==
X-Google-Smtp-Source: ALg8bN54Q85NkadKPdON+4Q1cEUSgw1zitcp+DGaMmi+UYpGrocgGxJwXgVXb0ws5erFjx5UURUWi+hxB7QecovJncU=
X-Received: by 2002:a2e:710a:: with SMTP id
 m10-v6mr12061693ljc.66.1547818325591; 
 Fri, 18 Jan 2019 05:32:05 -0800 (PST)
MIME-Version: 1.0
References: <20190110100922.20280-1-dietmar.eggemann@arm.com>
In-Reply-To: <20190110100922.20280-1-dietmar.eggemann@arm.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 18 Jan 2019 14:31:53 +0100
Message-ID: <CACRpkda2r3owKH7cCf-E=G2baeQ8JVRseEeLqeJwjziNDzMF5g@mail.gmail.com>
Subject: Re: [PATCH] arm: fix a migrating irq bug when hotplug cpu
To: Dietmar Eggemann <dietmar.eggemann@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190118_053207_777113_E0CEF75D 
X-CRM114-Status: GOOD (  12.15  )
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
Cc: Marc Zyngier <Marc.Zyngier@arm.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Sudeep Holla <sudeep.holla@arm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Jan 10, 2019 at 11:09 AM Dietmar Eggemann
<dietmar.eggemann@arm.com> wrote:
>
> Arm TC2 fails cpu hotplug stress test.
>
> This issue was tracked down to a missing copy of the new affinity
> cpumask for the vexpress-spc interrupt into struct
> irq_common_data.affinity when the interrupt is migrated in
> migrate_one_irq().
>
> Fix it by replacing the arm specific hotplug cpu migration with the
> generic irq code.
>
> This is the counterpart implementation to commit 217d453d473c ("arm64:
> fix a migrating irq bug when hotplug cpu").
>
> Tested with cpu hotplug stress test on Arm TC2 (multi_v7_defconfig plus
> CONFIG_ARM_BIG_LITTLE_CPUFREQ=y and CONFIG_ARM_VEXPRESS_SPC_CPUFREQ=y).
> The vexpress-spc interrupt (irq=22) on this board is affine to CPU0.
> Its affinity cpumask now changes correctly e.g. from 0 to 1-4 when
> CPU0 is hotplugged out.
>
> Suggested-by: Marc Zyngier <marc.zyngier@arm.com>
> Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>

Looks solid to me(TM)

I would proceed to put it into Russell's patch tracker along with Marc's
ACK so Russell can process it, see:
http://www.arm.linux.org.uk/developer/patches/

Yours,
Linus Walleij

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
