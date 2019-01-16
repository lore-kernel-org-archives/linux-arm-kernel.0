Return-Path: <SRS0=Ql45=PY=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA80EC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 17:30:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 885F4206C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 17:30:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="tRDZi7QZ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Myq5jeuQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 885F4206C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=9DpOXs8PgFLdrpJB3eCoaOkfqOKAQQ+bHlD1uF7qR6E=; b=tRDZi7QZjERYIB
	nygmN699ZUenK4t9f4vMhaVUO+uxLwc+oqgc/guR2C6pK8EvSJl1Zi3MevxJ6YzwWXSmbrTwh/b6r
	zqIuT6MzxUEJhIezCUBxSqSrqPTvUoNtrozVPf6mYOzLVPjRjci0yl9hZ0Dzfr7PeBYChMXWca2Xw
	vuOzFOnlZaCXODKnidMH+9IJEi4r22QtwSmUI44mbhlY6ZHC9z9I6HqcfGY2TzWlfvL1N84w35wrY
	CWszwqGNxUPwTgOyQnNZBeqGk5JrdEHUcPf+R3ZKZtovktiBi7Re2iQfvMuARLUpKRbCTugVYMlsC
	x4eXV7ihA/IweIPQpMLg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjp1K-00014a-PN; Wed, 16 Jan 2019 17:30:30 +0000
Received: from mail-it1-x143.google.com ([2607:f8b0:4864:20::143])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjp1I-00013x-4U
 for linux-arm-kernel@lists.infradead.org; Wed, 16 Jan 2019 17:30:29 +0000
Received: by mail-it1-x143.google.com with SMTP id m62so4258958ith.5
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 16 Jan 2019 09:30:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Ljv1GR361GBRKYIkB7jsE2in05byxJjM9Of4H3Lyf7A=;
 b=Myq5jeuQiJRYN2ReKgBqC+F4WGXNyGRFDymPLmULSfQs2QRfD5K5Ahb63Z4mhTyh17
 MpMjhQcqZG6hctg9oIL/rLUg29Xp1ba+aUzYzHmQv1/+g7orOEOrG19xW6nYHMEgpPEm
 J9EtBEv+x9wwEmBh8HQLRPHDaOeuSgyXrNhJs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Ljv1GR361GBRKYIkB7jsE2in05byxJjM9Of4H3Lyf7A=;
 b=ezv+6RiJqa21IfknThdxZdizNAsXsSZK5/bGGznTDltjyeZS5OeAghYguOUlt6jMaq
 0m5sTea+hRBsA0M9uwMuZcEHapbBQy/cti7/pdxwE1rxch5bby3o7P4HEJOpvyf7bx9V
 dfr1LUt1fMNNaXmonLVHcGue/yuo2hF5/c0nOKwPO3alwfRIT3MWlwjHTZ5XtCB+Cxy0
 HR9U9Bhnw01a00ZHgpCChEBiJAlsSu4xUvqdxwYsGtF9NayM5buLtXK8TUg7PF2o6FZG
 /9SRxPOKXW1S5ggSZTraGpUgvSGHL4VCnokvS+AmmOM3oek8BrcgcpGbGqBpZanLVu67
 +vSg==
X-Gm-Message-State: AJcUukc2DXevL2sGcjZXuGc9mjQuQT+XLBkicw3XdJxxz+RToIqM8bvR
 6XQQs/4JYuroPYB/Hf1lMQ4XNZYcVX5bltXASPMxEQ==
X-Google-Smtp-Source: ALg8bN5ovBywmS2CY3P6+MGnjtlKbf7GdYn/0jnI7YCqLKMeYq51k91Eh0XXDHFIbC9usy4KjWsgWtsp6K1xpI+fWbM=
X-Received: by 2002:a02:1b1d:: with SMTP id l29mr5818176jad.98.1547659826972; 
 Wed, 16 Jan 2019 09:30:26 -0800 (PST)
MIME-Version: 1.0
References: <20190115230742.13730-1-mathieu.poirier@linaro.org>
 <20190115230742.13730-3-mathieu.poirier@linaro.org>
 <20190116153948.GC871@kroah.com>
 <CANLsYkzfbJae6Nk7cHhnR09ZPSATa3g8sceGC=O3DfXYC2ruQQ@mail.gmail.com>
 <20190116163314.GB5446@kroah.com>
 <CANLsYkw_=_OC-95HRMxTZfpAe4UzAuidPJcZmL_T-LbkOwWCkQ@mail.gmail.com>
 <20190116171259.GB10164@kroah.com>
In-Reply-To: <20190116171259.GB10164@kroah.com>
From: Mathieu Poirier <mathieu.poirier@linaro.org>
Date: Wed, 16 Jan 2019 10:30:16 -0700
Message-ID: <CANLsYkyFJx9gSfkMNmxT=bdas=sKFpZ0Cad42gm6nHoyq8FfnA@mail.gmail.com>
Subject: Re: [PATCH 2/7] coresight: perf: Add "sinks" group to PMU directory
To: Greg KH <gregkh@linuxfoundation.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190116_093028_182910_D1039C27 
X-CRM114-Status: GOOD (  28.35  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, linux-s390@vger.kernel.org,
 "Suzuki K. Poulose" <suzuki.poulose@arm.com>,
 Peter Zijlstra <peterz@infradead.org>, Will Deacon <will.deacon@arm.com>,
 heiko.carstens@de.ibm.com, Adrian Hunter <adrian.hunter@intel.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, ast@kernel.org,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Ingo Molnar <mingo@redhat.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 "H. Peter Anvin" <hpa@zytor.com>, schwidefsky@de.ibm.com,
 Namhyung Kim <namhyung@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Jiri Olsa <jolsa@redhat.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, 16 Jan 2019 at 10:13, Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Wed, Jan 16, 2019 at 09:38:09AM -0700, Mathieu Poirier wrote:
> > On Wed, 16 Jan 2019 at 09:33, Greg KH <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Wed, Jan 16, 2019 at 09:14:33AM -0700, Mathieu Poirier wrote:
> > > > On Wed, 16 Jan 2019 at 08:39, Greg KH <gregkh@linuxfoundation.org> wrote:
> > > > >
> > > > > On Tue, Jan 15, 2019 at 04:07:37PM -0700, Mathieu Poirier wrote:
> > > > > > Add a "sinks" directory entry so that users can see all the sinks
> > > > > > available in the system in a single place.  Individual sink are added
> > > > > > as they are registered with the coresight bus.
> > > > > >
> > > > > > Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> > > > > > ---
> > > > > >  .../hwtracing/coresight/coresight-etm-perf.c  | 43 +++++++++++++++++++
> > > > > >  .../hwtracing/coresight/coresight-etm-perf.h  |  1 +
> > > > > >  drivers/hwtracing/coresight/coresight.c       | 17 ++++++++
> > > > > >  3 files changed, 61 insertions(+)
> > > > > >
> > > > > > diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
> > > > > > index f21eb28b6782..292bd409a68c 100644
> > > > > > --- a/drivers/hwtracing/coresight/coresight-etm-perf.c
> > > > > > +++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
> > > > > > @@ -14,6 +14,7 @@
> > > > > >  #include <linux/perf_event.h>
> > > > > >  #include <linux/percpu-defs.h>
> > > > > >  #include <linux/slab.h>
> > > > > > +#include <linux/stringhash.h>
> > > > > >  #include <linux/types.h>
> > > > > >  #include <linux/workqueue.h>
> > > > > >
> > > > > > @@ -43,8 +44,18 @@ static const struct attribute_group etm_pmu_format_group = {
> > > > > >       .attrs  = etm_config_formats_attr,
> > > > > >  };
> > > > > >
> > > > > > +static struct attribute *etm_config_sinks_attr[] = {
> > > > > > +     NULL,
> > > > > > +};
> > > > > > +
> > > > > > +static const struct attribute_group etm_pmu_sinks_group = {
> > > > > > +     .name   = "sinks",
> > > > > > +     .attrs  = etm_config_sinks_attr,
> > > > > > +};
> > > > > > +
> > > > > >  static const struct attribute_group *etm_pmu_attr_groups[] = {
> > > > > >       &etm_pmu_format_group,
> > > > > > +     &etm_pmu_sinks_group,
> > > > > >       NULL,
> > > > > >  };
> > > > > >
> > > > > > @@ -479,6 +490,38 @@ int etm_perf_symlink(struct coresight_device *csdev, bool link)
> > > > > >       return 0;
> > > > > >  }
> > > > > >
> > > > > > +static ssize_t etm_perf_sink_name_show(struct device *dev,
> > > > > > +                                    struct device_attribute *dattr,
> > > > > > +                                    char *buf)
> > > > > > +{
> > > > > > +     /* See function coresight_sink_by_id() to know where this is used */
> > > > > > +     u32 hash = hashlen_hash(hashlen_string(NULL, dattr->attr.name));
> > > > > > +
> > > > > > +     return scnprintf(buf, PAGE_SIZE, "%x\n", hash);
> > > > > > +}
> > > > > > +
> > > > > > +int etm_perf_symlink_sink(struct coresight_device *csdev)
> > > > > > +{
> > > > > > +     struct device *pmu_dev = etm_pmu.dev;
> > > > > > +     struct device *pdev = csdev->dev.parent;
> > > > > > +     struct device_attribute *dev_attr;
> > > > > > +
> > > > > > +     if (csdev->type != CORESIGHT_DEV_TYPE_SINK &&
> > > > > > +         csdev->type != CORESIGHT_DEV_TYPE_LINKSINK)
> > > > > > +             return -EINVAL;
> > > > > > +
> > > > > > +     if (!etm_perf_up)
> > > > > > +             return -EPROBE_DEFER;
> > > > > > +
> > > > > > +     dev_attr = kzalloc(sizeof(*dev_attr), GFP_KERNEL);
> > > > > > +     dev_attr->attr.name = kstrdup(dev_name(pdev), GFP_KERNEL);
> > > > > > +     dev_attr->attr.mode = 0444;
> > > > > > +     dev_attr->show = etm_perf_sink_name_show;
> > > > > > +
> > > > > > +     return sysfs_add_file_to_group(&pmu_dev->kobj,
> > > > > > +                                    &dev_attr->attr, "sinks");
> > > > >
> > > > > What is so odd about this call that you needed me to review this?
> > > >
> > > > As far as I can tell nobody is feeding a dynamic struct attribute to
> > > > the function and I wasn't sure if it was because they were told not to
> > > > or simply because it wasn't needed, hence asking for a second opinion.
> > >
> > > Ah.  Well, again, this is a good question to answer:
> > >
> > > > > And what happens if this call fails, do you leak memory?
> >
> > That's something I will fix in the next revision.
> >
> > >
> > > And also, what happens when you unload the device, who frees the
> > > attribute's memory?
> >
> > If configured, coresight devices aren't removable.
>
> But is the driver able to be unloaded?  Unbound from the device manually
> through sysfs?  There's lots of ways devices are "removed" that don't
> involved physical removal :)

All drivers are built-in and thus preventing them from being unloaded.
They also have their ".suppress_bin_attrs" field set to take care of
unbinding through sysfs.

>
> thanks,
>
> greg k-h

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
