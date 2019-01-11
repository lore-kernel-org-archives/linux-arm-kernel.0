Return-Path: <SRS0=KsRD=PT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1243DC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 10:53:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D806A20872
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 10:53:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bm5h2yPW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D806A20872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=GMRDs2f4XvjBd3sodxh/+y02+ZGktlnrEFaDPExOLPw=; b=bm5h2yPW8zk1KF
	SqdLMi45wAt5qAGsudULlPBe3H5ILFcSslKnSyJpDPh57kdlgYT0MLFFL1rt1MiUh0JebyUMUQ5Hr
	C6T15HFhPPVNdQ8Alf2dZs7ciWRAtUecsziwGxEsHgYDShcurp3o+zYZHH0Yhe5U37NLzWQGyOA2s
	4uJ+wOZKhmUU+w+3nCQ17CFmSHQtVwkds5ZpHn+5kRYLx8Z0YB3RCs8EO0YAnvQvyXF94pA4zNmyt
	kIGcqIMqQ9eZ6/GWMm0UfRglfxPtMKZyrK1Nf42q8LZ/And+B4z7hUTJXkW7HNzlJlgbqWe6mrlxy
	xRrXgDfFDR1+If2Q9y5A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghuRc-0001d6-9l; Fri, 11 Jan 2019 10:53:44 +0000
Received: from cloudserver094114.home.pl ([79.96.170.134])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghuRZ-0001ch-7g
 for linux-arm-kernel@lists.infradead.org; Fri, 11 Jan 2019 10:53:42 +0000
Received: from 79.184.254.168.ipv4.supernova.orange.pl (79.184.254.168) (HELO
 aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.183)
 id 0b5c9bc25c66d993; Fri, 11 Jan 2019 11:53:39 +0100
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v10 01/27] PM / Domains: Add generic data pointer to
 genpd_power_state struct
Date: Fri, 11 Jan 2019 11:52:52 +0100
Message-ID: <5682777.oKQsr9mDaT@aspire.rjw.lan>
In-Reply-To: <CAPDyKFp=z0TS5oDD7muRCSuqqJ5sj-vOUyTf9tUJfXgWyE64Mg@mail.gmail.com>
References: <20181129174700.16585-1-ulf.hansson@linaro.org>
 <81caa4b6-d0ac-f351-2ecf-47fb0f7dcc74@linaro.org>
 <CAPDyKFp=z0TS5oDD7muRCSuqqJ5sj-vOUyTf9tUJfXgWyE64Mg@mail.gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190111_025341_434671_5A4807EB 
X-CRM114-Status: GOOD (  23.87  )
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
 Daniel Lezcano <daniel.lezcano@linaro.org>, Kevin Hilman <khilman@kernel.org>,
 Lina Iyer <ilina@codeaurora.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Tony Lindgren <tony@atomide.com>, Sudeep Holla <sudeep.holla@arm.com>,
 "Raju P . L . S . S . S . N" <rplsssn@codeaurora.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tuesday, December 18, 2018 12:53:28 PM CET Ulf Hansson wrote:
> On Tue, 18 Dec 2018 at 11:39, Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
> >
> > On 29/11/2018 18:46, Ulf Hansson wrote:
> > > Let's add a data pointer to the genpd_power_state struct, to allow a genpd
> > > backend driver to store per state specific data. In order to introduce the
> > > pointer, we also need to adopt how genpd frees the allocated data for the
> > > default genpd_power_state struct, that it may allocate at pm_genpd_init().
> > >
> > > More precisely, let's use an internal genpd flag to understand when the
> > > states needs to be freed by genpd. When freeing the states data in
> > > genpd_remove(), let's also clear the corresponding genpd->states pointer
> > > and reset the genpd->state_count. In this way, a genpd backend driver
> > > becomes aware of when there is state specific data for it to free.
> > >
> > > Cc: Lina Iyer <ilina@codeaurora.org>
> > > Co-developed-by: Lina Iyer <lina.iyer@linaro.org>
> > > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > > ---
> > >
> > > Changes in v10:
> > >       - Update the patch allow backend drivers to free the states specific
> > >         data during genpd removal. Due to this added complexity, I decided to
> > >         keep the patch separate, rather than fold it into the patch that makes
> > >         use of the new void pointer, which was suggested by Rafael.
> > >       - Claim authorship of the patch as lots of changes has been done since
> > >         the original pick up from Lina Iyer.
> > >
> > > ---
> > >  drivers/base/power/domain.c | 8 ++++++--
> > >  include/linux/pm_domain.h   | 3 ++-
> > >  2 files changed, 8 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> > > index 7f38a92b444a..e27b91d36a2a 100644
> > > --- a/drivers/base/power/domain.c
> > > +++ b/drivers/base/power/domain.c
> > > @@ -1620,7 +1620,7 @@ static int genpd_set_default_power_state(struct generic_pm_domain *genpd)
> > >
> > >       genpd->states = state;
> > >       genpd->state_count = 1;
> > > -     genpd->free = state;
> > > +     genpd->free_state = true;
> > >
> > >       return 0;
> > >  }
> > > @@ -1736,7 +1736,11 @@ static int genpd_remove(struct generic_pm_domain *genpd)
> > >       list_del(&genpd->gpd_list_node);
> > >       genpd_unlock(genpd);
> > >       cancel_work_sync(&genpd->power_off_work);
> > > -     kfree(genpd->free);
> > > +     if (genpd->free_state) {
> > > +             kfree(genpd->states);
> > > +             genpd->states = NULL;
> > > +             genpd->state_count = 0;
> >
> > Why these two initializations? After genpd_remove, this structure
> > shouldn't be used anymore, no ?
> 
> Correct.
> 
> >
> > > +     }
> >
> > Instead of a flag, replacing the 'free' pointer to a 'free' callback
> > will allow to keep the free path self-encapsulated in domain.c
> >
> > genpd->free(genpd->states);
> 
> Right, I get your idea and it makes sense. Let me convert to that.

OK, so I'm expecting an update here.


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
