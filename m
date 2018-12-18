Return-Path: <SRS0=e5Gl=O3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FB51C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 11:54:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3EF5520874
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 11:54:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="js/BGwt0";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="NRHOJ4YZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EF5520874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=b2DhaIltWYc1bMms2rKB68WvG0wLX8iEucvLQCc27g0=; b=js/BGwt0zA535E
	xW1V/1V/9OszEgO7ncbakOw7xA6nmE4WZt/Z2XPJPi3ESUZF2sfnSweyUEYw9o6tb+wwgfDZE7GX8
	ewGbOe+FG39PGpuP+u264oYnHfdi6+0nMN4LQ6ln6n5XLy+ovHv8jh2o1aSm5cWC8yeJvHBFTgJI3
	fkkgDqwodt2skauNNV+hpm6xONxbHjxA41c22/yaXHsQo+7TUDoskRGdyJL/Tke/mSl6E40hGNB9/
	Fp9lyLcE3DsuvJujxrDjNzZ33Lbp4eCjR3y8OeQtROREW6u391sYfYM4D3YOR+N6wJlX6UGu9QYAV
	U2K0BymqvyCcJMimfH4w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZDx5-0002ix-5v; Tue, 18 Dec 2018 11:54:19 +0000
Received: from mail-ua1-x941.google.com ([2607:f8b0:4864:20::941])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZDx2-0002h4-38
 for linux-arm-kernel@lists.infradead.org; Tue, 18 Dec 2018 11:54:17 +0000
Received: by mail-ua1-x941.google.com with SMTP id z24so5601207ual.8
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 18 Dec 2018 03:54:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=mU4UBYgCjkb6XraI/BZfL8VEXjzHaubB0pTaEcFYDu0=;
 b=NRHOJ4YZzaOVZTO6CTq1b2fkn9TAyEN50NB/vSGGY4dRpyJp5CpxZpi4PAcsDsT7pg
 85Ok1IecZVIWGINIh2RkLD/XVZ4b86rEXFoBjcfW4z5v6Rc2nTW7QryzXH6iPDPaspTF
 Jj4pj4WUnBKw3RorIKw99hhVPQW1NRSDbxxno=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=mU4UBYgCjkb6XraI/BZfL8VEXjzHaubB0pTaEcFYDu0=;
 b=l9+6cVXaLxlzeV3UGkY1tS+8gOy3DjTXzUd1kD0QM9Tipanbmxk9A18qwuP/5ov2gY
 mdTDuhl7dhcriuDn/LfhzE9/zOe/aBy4RDwhdGz/ecxIg8VrwoTIedJi9Iow1Us2Zov+
 J7L+w3k0/c/fxFejXBtCc2TrEhuNOdFh91QfCloY7WxNqbKnshFcPMIvwlPKX46VDu05
 AD4Dx3ORxn0e85/VcIw6u6fu7THhPiRRlOCXTukriGJQ6lIJVzayWbpF9TSElnee9PsT
 t3gmSuRQocakqbenJQmJtj32pZ9DTF0zQIYPNzh5CJ99TFBiF1Z0pl5x8mrhzyBYAgJS
 Jd0w==
X-Gm-Message-State: AA+aEWbYkWrwhsPCNRv/DRkY9mD0dRtvLZHSTc0FsctAmA9KGurYIQ6f
 AozecU0dIvSWJdvzUdek4bGXj+ekWfHyWoV4C7fb2g==
X-Google-Smtp-Source: AFSGD/X7j38drFRxjVdpqBW0nnKHiOIH3OjOFRCq6I7YazR3Lc7TpR7DC/nElWE5MtUQIGG8HD7rd4Eyi/zsbwZEnYQ=
X-Received: by 2002:ab0:526:: with SMTP id 35mr8012867uax.25.1545134044074;
 Tue, 18 Dec 2018 03:54:04 -0800 (PST)
MIME-Version: 1.0
References: <20181129174700.16585-1-ulf.hansson@linaro.org>
 <20181129174700.16585-2-ulf.hansson@linaro.org>
 <81caa4b6-d0ac-f351-2ecf-47fb0f7dcc74@linaro.org>
In-Reply-To: <81caa4b6-d0ac-f351-2ecf-47fb0f7dcc74@linaro.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 18 Dec 2018 12:53:28 +0100
Message-ID: <CAPDyKFp=z0TS5oDD7muRCSuqqJ5sj-vOUyTf9tUJfXgWyE64Mg@mail.gmail.com>
Subject: Re: [PATCH v10 01/27] PM / Domains: Add generic data pointer to
 genpd_power_state struct
To: Daniel Lezcano <daniel.lezcano@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181218_035416_136888_5D97CE94 
X-CRM114-Status: GOOD (  25.42  )
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
 Viresh Kumar <viresh.kumar@linaro.org>,
 linux-arm-msm <linux-arm-msm@vger.kernel.org>,
 Kevin Hilman <khilman@kernel.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Lina Iyer <ilina@codeaurora.org>, Tony Lindgren <tony@atomide.com>,
 Sudeep Holla <sudeep.holla@arm.com>,
 "Raju P . L . S . S . S . N" <rplsssn@codeaurora.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, 18 Dec 2018 at 11:39, Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>
> On 29/11/2018 18:46, Ulf Hansson wrote:
> > Let's add a data pointer to the genpd_power_state struct, to allow a genpd
> > backend driver to store per state specific data. In order to introduce the
> > pointer, we also need to adopt how genpd frees the allocated data for the
> > default genpd_power_state struct, that it may allocate at pm_genpd_init().
> >
> > More precisely, let's use an internal genpd flag to understand when the
> > states needs to be freed by genpd. When freeing the states data in
> > genpd_remove(), let's also clear the corresponding genpd->states pointer
> > and reset the genpd->state_count. In this way, a genpd backend driver
> > becomes aware of when there is state specific data for it to free.
> >
> > Cc: Lina Iyer <ilina@codeaurora.org>
> > Co-developed-by: Lina Iyer <lina.iyer@linaro.org>
> > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > ---
> >
> > Changes in v10:
> >       - Update the patch allow backend drivers to free the states specific
> >         data during genpd removal. Due to this added complexity, I decided to
> >         keep the patch separate, rather than fold it into the patch that makes
> >         use of the new void pointer, which was suggested by Rafael.
> >       - Claim authorship of the patch as lots of changes has been done since
> >         the original pick up from Lina Iyer.
> >
> > ---
> >  drivers/base/power/domain.c | 8 ++++++--
> >  include/linux/pm_domain.h   | 3 ++-
> >  2 files changed, 8 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> > index 7f38a92b444a..e27b91d36a2a 100644
> > --- a/drivers/base/power/domain.c
> > +++ b/drivers/base/power/domain.c
> > @@ -1620,7 +1620,7 @@ static int genpd_set_default_power_state(struct generic_pm_domain *genpd)
> >
> >       genpd->states = state;
> >       genpd->state_count = 1;
> > -     genpd->free = state;
> > +     genpd->free_state = true;
> >
> >       return 0;
> >  }
> > @@ -1736,7 +1736,11 @@ static int genpd_remove(struct generic_pm_domain *genpd)
> >       list_del(&genpd->gpd_list_node);
> >       genpd_unlock(genpd);
> >       cancel_work_sync(&genpd->power_off_work);
> > -     kfree(genpd->free);
> > +     if (genpd->free_state) {
> > +             kfree(genpd->states);
> > +             genpd->states = NULL;
> > +             genpd->state_count = 0;
>
> Why these two initializations? After genpd_remove, this structure
> shouldn't be used anymore, no ?

Correct.

>
> > +     }
>
> Instead of a flag, replacing the 'free' pointer to a 'free' callback
> will allow to keep the free path self-encapsulated in domain.c
>
> genpd->free(genpd->states);

Right, I get your idea and it makes sense. Let me convert to that.

>
> Patch 18/27 can fill this field with its specific free pointer.

Yep!

[...]

Thanks for reviewing!

Kind regards
Uffe

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
