Return-Path: <SRS0=3RVO=RB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F208C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 22:08:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2658206B8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 22:08:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="DDs8omy8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2658206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=NysWGl1mgq/FEc1gzayVvG4EqOnHXYgEMpUijYA1P5o=; b=DDs8omy8Z9pgAa
	cM1YXPxkFymVUhYH7CFjWR08YtpK+3OAOhRH2wCxMcyUReSkMTJMNuHEpnytdFOriN7SkbwsaDry9
	agSkzOtz0PWSV8IWATSJI3AqH1efDzt/gsWu2i53Wna40cpsrTh3XrYVGlszI21qsBQdEh96I0qVB
	CEBagEsAB/mQDT8cZWmzlg6LYOLe+5Dlg8lONLgHZBlPRFU27KTzm/ZGx546zRXz+rj7KVFzg/CzE
	BzfBzj0eNrVz1CdkbWS4wsMJG+ZfVjm1g0v3sxYWZQkre+h6SYFUMm7+qXU8HhOdvgHwUSAGQlEiz
	2qvxlYLzjt/SeRqFIcCA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gykuA-0001yO-VD; Tue, 26 Feb 2019 22:08:50 +0000
Received: from mail-ot1-f68.google.com ([209.85.210.68])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gyku8-0001xo-0m
 for linux-arm-kernel@lists.infradead.org; Tue, 26 Feb 2019 22:08:49 +0000
Received: by mail-ot1-f68.google.com with SMTP id e15so2973513otk.6
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 26 Feb 2019 14:08:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=XYz4Yvj2dgYXIVXzNSizY57kzLzBLSu1ofbljAMU7ZI=;
 b=CHhWHCQ8ku0QPYfAtaWDE7NhsKU3VegjUm3jsNf9kn5qYCTEK/pBbTf3at3jexHqRt
 zc19zFaVZWdZUT8OciL7HlbcYgKtk6SPPqLQNOKV9dCsthuqIGpCRalBovV+XafPtrOd
 6naLxY8HXo2SU+PdzcP5ge3aja0kM8ck7YNtNsrX/63hzi/CeE/jmCfgtl42kRs+ihaI
 d4hU43fbdqJDMCMidIilEbpC8jF4CKa0mRer0/wueOCqPgyk6EG8bxsH6y5W3xQN/C4A
 QK2rVXanLHrneNYsNz9xoKJzDcqVIotoPdLFEks9vSdLy3kEfyla3RcK1tc5PsKXm8q2
 uFww==
X-Gm-Message-State: AHQUAubzVXF++g0Xvp7/yYJl8s9Nas2iWYoVCp3iIuocRBBDADmBUrTl
 ZOKGUj82UKdBE9DSRsPUh2u5LpeCDAtbvBJ5Cz8=
X-Google-Smtp-Source: AHgI3IZEmzeStka0O4TpvO76n23BS1dRpDTF1Wcq7EyNtg7rTBAbNMXgJvSTC6sVqvNAehmF+gXS18Tv8CsQFGOwxTw=
X-Received: by 2002:a9d:4e08:: with SMTP id p8mr137025otf.124.1551218926888;
 Tue, 26 Feb 2019 14:08:46 -0800 (PST)
MIME-Version: 1.0
References: <20190226145415.19411-1-ulf.hansson@linaro.org>
 <20190226145415.19411-8-ulf.hansson@linaro.org>
In-Reply-To: <20190226145415.19411-8-ulf.hansson@linaro.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 26 Feb 2019 23:08:35 +0100
Message-ID: <CAJZ5v0j=ddMEwvr8rt=PxxPpxoAHary7cYLYgTBbcuBuiGbTZA@mail.gmail.com>
Subject: Re: [PATCH v11 7/8] cpuidle: Pre-store next timer/tick before
 selecting an idle state
To: Ulf Hansson <ulf.hansson@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190226_140848_069241_CFD1B8FB 
X-CRM114-Status: GOOD (  13.26  )
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
 Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Linux PM <linux-pm@vger.kernel.org>, Stephen Boyd <sboyd@kernel.org>,
 Frederic Weisbecker <fweisbec@gmail.com>,
 linux-arm-msm <linux-arm-msm@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 "Rafael J . Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>,
 Lina Iyer <ilina@codeaurora.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Tony Lindgren <tony@atomide.com>, Viresh Kumar <viresh.kumar@linaro.org>,
 Sudeep Holla <sudeep.holla@arm.com>, Thomas Gleixner <tglx@linutronix.de>,
 "Raju P . L . S . S . S . N" <rplsssn@codeaurora.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Feb 26, 2019 at 3:54 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> A common piece of data used by cpuidle governors, is the information about
> when the next timer/tick is going to fire. Rather than having each governor
> calling tick_nohz_get_next_timer|hrtimer() separately, let's consolidate
> the code by calling these functions before invoking the ->select() callback
> of the governor - and store the output data in the struct cpuidle_device.

That misses the point IMO.

You don't need to store two values in struct cpuidle_device, but just
one, and not before running ->select(), but before invoking the
driver's ->enter() callback.

At that point, the decision on whether or not to stop the scheduler
tick has been made already and it should be sufficient to store the
return value of tick_nohz_get_next_hrtimer() introduced by patch
[3/8], because that value represents the next timer regardless of what
has been decided with respect to the tick.

And you won't need the tick_nohz_get_next_timer() any more then.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
