Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75D4FC282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 21:53:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDBB420989
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 21:53:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="kQjqVl9Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDBB420989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=WVmc5+JwhEHfBTYD4FTI9sfGHA9OAjFltyDhVgws3pc=; b=kQjqVl9ZJLFS+Y
	Ecb/h71Tn7mAaErCj/sUST8BfAbi9cMVRr59qL/wFli9MTjb9GhypclHTOdE+ClLeFluNXmiXFZys
	eA5OJtTgoV+SMA2i7s/LL/bl1B591m0cssYHqUVFMKdFjJNlf1vEBrRSrb6Ny4wM855e1Xj3n2WNB
	AEEeMovmBNlRWrL24i3gdnf1izPLzGtLTqdmTLMWa1FBoOCKc3p4yuI+8BERDAauhXpp+dOa5xhWY
	pI14fRGXoRIEDOlZfk31k3FTmCqn7EprU0KtYMhhSQG7TCBDkb6DJ6xvHvDbL+FIa3Oa+j8EnmAOA
	3xktHjEy144CEDuprsoA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goxnI-0003Z2-G6; Wed, 30 Jan 2019 21:53:16 +0000
Received: from mail-ot1-f65.google.com ([209.85.210.65])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goxnF-0003YZ-C0
 for linux-arm-kernel@lists.infradead.org; Wed, 30 Jan 2019 21:53:14 +0000
Received: by mail-ot1-f65.google.com with SMTP id s5so1013619oth.7
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 30 Jan 2019 13:53:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=YuA330KElE94ag75CUZF0JfLlQgGpCicSadKqqJDO2M=;
 b=dHzJ140MkuPwdUk26WCnNsqSig7BfoXnJXBvGATrbEZ+/iKfO3EcBM9D5LMM8RtMKR
 TEqfDalB7O8Y4r9edP7WpWCm7+78QA+xip3440yZYuSeG5E92M11fPDUkE/et11tUJm6
 nBuFe9+jjS+/HMk/Yw9UWGsShAxmyjv83IfpXvYKGlBRPRjj0B6mu/EcFUXRWF33/r55
 KKDa7v7xrwGJhdjOE5jfDzvA9z0vgtJ4jfDLX4CfCi1NL2/4KrnTFm5/Cn/6aG/+22oK
 poWh9dicXN+bu28Wn1Cd9/m/K/0Us33AaQMgoQJpMp8XnE/S+zgIovZ5E5KDc7il/wxl
 yvyQ==
X-Gm-Message-State: AJcUukdOXn3tduzb1c4iinZWpYU+Ve5aoWm4+Bsz5V8l4u7tS685uIs5
 bBucui5zZMHpRwb3R7emvt8CUH3WS2D7LpFIvoY=
X-Google-Smtp-Source: ALg8bN5WmlZghK92UzFWWO/bpgaQE+0vzBzrN5Lq8REMLjdrp+ANVFp49w+PVDNz/myAVI16mzVYyEsNcw/EoGNppFM=
X-Received: by 2002:a9d:588c:: with SMTP id x12mr24659825otg.139.1548885192162; 
 Wed, 30 Jan 2019 13:53:12 -0800 (PST)
MIME-Version: 1.0
References: <CAJZ5v0gunbCHp_9mDTmtwW1i-_GcXPcjTP48NdV2zv-B6UrD4g@mail.gmail.com>
 <1548869162-6223-1-git-send-email-vincent.guittot@linaro.org>
In-Reply-To: <1548869162-6223-1-git-send-email-vincent.guittot@linaro.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 30 Jan 2019 22:53:00 +0100
Message-ID: <CAJZ5v0gnJ5DKvOO9OcJoMrGYpHfeQBt2Ec0pMW6=2q5aMoFpww@mail.gmail.com>
Subject: Re: [PATCH v3] PM-runtime: fix deadlock with ktime
To: Vincent Guittot <vincent.guittot@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_135313_406378_3C3020C2 
X-CRM114-Status: GOOD (  13.67  )
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
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Linux PM <linux-pm@vger.kernel.org>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Biju Das <biju.das@bp.renesas.com>,
 Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 Linux OMAP Mailing List <linux-omap@vger.kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Jan 30, 2019 at 6:26 PM Vincent Guittot
<vincent.guittot@linaro.org> wrote:
>
> A deadlock has been seen when swicthing clocksources which use PM runtime.
> The call path is:
> change_clocksource
>     ...
>     write_seqcount_begin
>     ...
>     timekeeping_update
>         ...
>         sh_cmt_clocksource_enable
>             ...
>             rpm_resume
>                 pm_runtime_mark_last_busy
>                     ktime_get
>                         do
>                             read_seqcount_begin
>                         while read_seqcount_retry
>     ....
>     write_seqcount_end
>
> Although we should be safe because we haven't yet changed the clocksource
> at that time, we can't because of seqcount protection.
>
> Use ktime_get_mono_fast_ns() instead which is lock safe for such case
>
> With ktime_get_mono_fast_ns, the timestamp is not guaranteed to be
> monotonic across an update and as a result can goes backward. According to
> update_fast_timekeeper() description: "In the worst case, this can
> result is a slightly wrong timestamp (a few nanoseconds)". For
> PM runtime autosuspend, this means only that the suspend decision can
> be slightly sub optimal.
>
> Fixes: 8234f6734c5d ("PM-runtime: Switch autosuspend over to using hrtimers")
> Reported-by: Biju Das <biju.das@bp.renesas.com>
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---
>
> Hi Rafael,
>
> Sorry, I sent the version with the typo mistake that generated the compilation error
> reported by kbuild-test-robot
>
> This version doesn't have the typo.

OK, I've applied this one, thanks!

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
