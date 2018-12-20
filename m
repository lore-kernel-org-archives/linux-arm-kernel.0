Return-Path: <SRS0=AHqO=O5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E4C3C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 15:39:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F21E22186A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 15:39:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="X8Wm0Zce"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F21E22186A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=MJHr+PyoO9cRGseJigQymY1I5EuFu7Fsnhbur2W/wD4=; b=X8Wm0ZceoQPjOs
	taGsLHoPGtJuV+5UaWnMSwpvx1WyzAmT1EZ7uN6rV+DYAPXkqk3c0DnS4t44l42/EpySJ8A8hzzmK
	fbxTsC7bqpUOXRg+QXOR8KrwlM/GtaO/Y5jMrVmWJlSSnLYL61AuuuFF+1TRsx3c0uMH7GSM0p8Yo
	P9JZ5q2nI7FBmR3Iu9i3tML89gU6Xcb0/G6m6040x7Q5eJxASlnnBLBXmmhFMqNmy0AZqcYVNjesr
	x4JQALHPSXqhC8wkApkJwkSjXs0Yh4+lfJJaDU/HtNK9XCYHWGyy1x/yIncrMXmEsXz/8VY+QibW/
	bQyz95Hn4nw4OobxREZg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ga0QI-0000gn-A0; Thu, 20 Dec 2018 15:39:42 +0000
Received: from mail-qk1-f193.google.com ([209.85.222.193])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ga0QE-0000gG-Mo
 for linux-arm-kernel@lists.infradead.org; Thu, 20 Dec 2018 15:39:39 +0000
Received: by mail-qk1-f193.google.com with SMTP id q1so1211307qkf.13
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 20 Dec 2018 07:39:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=DltyON9h2jnpHlRdBniN25DHkMyM0JtulrMK+JeVibs=;
 b=g2FbnHBMZ40BuuMqNtBeSULQ7SQhtffh7xEr+yHWyeOpW5R7dAE/PvwTSMjH/XvFua
 iAjbhxC8U94VIbxbB424/eT8L18LkZadI61EWBToaV8+A0a1PoyssxXkHPJO8ZZ/Adfl
 UiH9wUtCf4Rhaz83LjKWlPmwDIzyyAYzt0UfhJ3RRXgYKphgj9teOD5SrdgpusPnzPtz
 OkW4o/8Mk5PE+18tPbxO/iHNP8wZYn/HnmEGbcwC2lT4qrTYczWuuTghkKdVAMIcJTrZ
 H3tD84kTjK0vUqRobGOp+jolAdfQXPkj+LaKxP8DQKbqbEIw/TlE5mibTyOfE/PW8T4V
 TbWg==
X-Gm-Message-State: AA+aEWYmFpwojbmhJXWnLGjuvxLb/XbwwIQ17fzInyorM+XceG+ZUPrc
 fiOYAMtYbp2fG4qY5TdSptQL0YmoWgVmDIACCH4=
X-Google-Smtp-Source: AFSGD/UNlERav4axTnIkrXBaKmRIAzlfI8LtgyUrr8c0XpPKEvW/0zYrrBuu9Zx6C3w1PPwrhM1XZNoZllD2zEJONw4=
X-Received: by 2002:a37:bdc6:: with SMTP id n189mr8580655qkf.330.1545320367741; 
 Thu, 20 Dec 2018 07:39:27 -0800 (PST)
MIME-Version: 1.0
References: <e4ac6f8c-66f4-08bb-65f8-5c1123264837@ti.com>
In-Reply-To: <e4ac6f8c-66f4-08bb-65f8-5c1123264837@ti.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 20 Dec 2018 16:39:10 +0100
Message-ID: <CAK8P3a1LL68X5nHKkj6j1a5-6o0Zrka0azLpiFM6DWVWLqCx1A@mail.gmail.com>
Subject: Re: [GIT PULL] arm64: dts: TI AM65x changes for v4.21
To: Tero Kristo <t-kristo@ti.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181220_073938_743361_FAD7B8C8 
X-CRM114-Status: UNSURE (   8.17  )
X-CRM114-Notice: Please train this message.
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
Cc: Nishanth Menon <nm@ti.com>, Tony Lindgren <tony@atomide.com>,
 arm-soc <arm@kernel.org>, vigneshr@ti.com,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Dec 14, 2018 at 10:30 AM Tero Kristo <t-kristo@ti.com> wrote:
>
> Hello arm-soc maintainers,
>
> Please pull these DT changes for Texas Instruments AM65x SoC for v4.21
> merge window. These are based on top of my earlier pull-request against
> 4.20-rc1, just to avoid any conflicts.

Yes, that's a good way to do it. Pulled into next/dt, thanks!

      Arnd

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
