Return-Path: <SRS0=Ql45=PY=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91A72C43444
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 17:13:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54BCF20651
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 17:13:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="XV4jZz2Y";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="FSbRJWX0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54BCF20651
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=yAQj8fiTuAzHmU6hqjT/EmVPvax49Rpel1nzbgY4Mmg=; b=XV4jZz2YgvHk+V
	t4KvLXO0NOxxFm2l3sAq/t8Ch+fxoL3FZVBZ5YLvMPrZzojEoJ7NCFzRxC83gIVZR4Q01n6FQU5zD
	gVwcIelwWoaegaD03ctFXNexqUP9/FWPAOrZ+rWVjUgGuaSn78517qXZxV6f91fzgz+genXcVAKIK
	11jdmM4Ioy9sW9j4cAeB3Tcfm4MJ9XRYoQcmTRxaziT5UaBdnzhU53UtVkBPfIcL8OmaK4/qROXkl
	nD0TEWz1D2JF45oDkffH9NIZknYCXMoEsoKJOlxAgCSaYZrhNeZnATewSG/M50bW1bI4wQFN9oatO
	OvipP8KF6G2H7rUDOMew==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjokT-0001j1-1W; Wed, 16 Jan 2019 17:13:05 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjokP-0001iT-Mc
 for linux-arm-kernel@lists.infradead.org; Wed, 16 Jan 2019 17:13:03 +0000
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id AA9C320578;
 Wed, 16 Jan 2019 17:13:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1547658781;
 bh=ycXcpr8B/rmXmWanQ90lDcDN84nIRE5OWeilpw6eOpo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=FSbRJWX0MV9uiow1kq5Ybh1W4muIlLmyBC/ZUhotH+RPCJXtomhD4qySmdc5lZpyx
 0APpT6E86xFrSVl8WJj/QWsGa7eJAvaCQH9zDUbP/bv931D4RastxCotqbTqoGxgcU
 8CbhULUeT2efO0UiX1gAS1Abz25vFakVoUwltJ5U=
Date: Wed, 16 Jan 2019 18:12:59 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Mathieu Poirier <mathieu.poirier@linaro.org>
Subject: Re: [PATCH 2/7] coresight: perf: Add "sinks" group to PMU directory
Message-ID: <20190116171259.GB10164@kroah.com>
References: <20190115230742.13730-1-mathieu.poirier@linaro.org>
 <20190115230742.13730-3-mathieu.poirier@linaro.org>
 <20190116153948.GC871@kroah.com>
 <CANLsYkzfbJae6Nk7cHhnR09ZPSATa3g8sceGC=O3DfXYC2ruQQ@mail.gmail.com>
 <20190116163314.GB5446@kroah.com>
 <CANLsYkw_=_OC-95HRMxTZfpAe4UzAuidPJcZmL_T-LbkOwWCkQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CANLsYkw_=_OC-95HRMxTZfpAe4UzAuidPJcZmL_T-LbkOwWCkQ@mail.gmail.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190116_091301_787515_4C6636D2 
X-CRM114-Status: GOOD (  28.28  )
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

On Wed, Jan 16, 2019 at 09:38:09AM -0700, Mathieu Poirier wrote:
> On Wed, 16 Jan 2019 at 09:33, Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Wed, Jan 16, 2019 at 09:14:33AM -0700, Mathieu Poirier wrote:
> > > On Wed, 16 Jan 2019 at 08:39, Greg KH <gregkh@linuxfoundation.org> wrote:
> > > >
> > > > On Tue, Jan 15, 2019 at 04:07:37PM -0700, Mathieu Poirier wrote:
> > > > > Add a "sinks" directory entry so that users can see all the sinks
> > > > > available in the system in a single place.  Individual sink are added
> > > > > as they are registered with the coresight bus.
> > > > >
> > > > > Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> > > > > ---
> > > > >  .../hwtracing/coresight/coresight-etm-perf.c  | 43 +++++++++++++++++++
> > > > >  .../hwtracing/coresight/coresight-etm-perf.h  |  1 +
> > > > >  drivers/hwtracing/coresight/coresight.c       | 17 ++++++++
> > > > >  3 files changed, 61 insertions(+)
> > > > >
> > > > > diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
> > > > > index f21eb28b6782..292bd409a68c 100644
> > > > > --- a/drivers/hwtracing/coresight/coresight-etm-perf.c
> > > > > +++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
> > > > > @@ -14,6 +14,7 @@
> > > > >  #include <linux/perf_event.h>
> > > > >  #include <linux/percpu-defs.h>
> > > > >  #include <linux/slab.h>
> > > > > +#include <linux/stringhash.h>
> > > > >  #include <linux/types.h>
> > > > >  #include <linux/workqueue.h>
> > > > >
> > > > > @@ -43,8 +44,18 @@ static const struct attribute_group etm_pmu_format_group = {
> > > > >       .attrs  = etm_config_formats_attr,
> > > > >  };
> > > > >
> > > > > +static struct attribute *etm_config_sinks_attr[] = {
> > > > > +     NULL,
> > > > > +};
> > > > > +
> > > > > +static const struct attribute_group etm_pmu_sinks_group = {
> > > > > +     .name   = "sinks",
> > > > > +     .attrs  = etm_config_sinks_attr,
> > > > > +};
> > > > > +
> > > > >  static const struct attribute_group *etm_pmu_attr_groups[] = {
> > > > >       &etm_pmu_format_group,
> > > > > +     &etm_pmu_sinks_group,
> > > > >       NULL,
> > > > >  };
> > > > >
> > > > > @@ -479,6 +490,38 @@ int etm_perf_symlink(struct coresight_device *csdev, bool link)
> > > > >       return 0;
> > > > >  }
> > > > >
> > > > > +static ssize_t etm_perf_sink_name_show(struct device *dev,
> > > > > +                                    struct device_attribute *dattr,
> > > > > +                                    char *buf)
> > > > > +{
> > > > > +     /* See function coresight_sink_by_id() to know where this is used */
> > > > > +     u32 hash = hashlen_hash(hashlen_string(NULL, dattr->attr.name));
> > > > > +
> > > > > +     return scnprintf(buf, PAGE_SIZE, "%x\n", hash);
> > > > > +}
> > > > > +
> > > > > +int etm_perf_symlink_sink(struct coresight_device *csdev)
> > > > > +{
> > > > > +     struct device *pmu_dev = etm_pmu.dev;
> > > > > +     struct device *pdev = csdev->dev.parent;
> > > > > +     struct device_attribute *dev_attr;
> > > > > +
> > > > > +     if (csdev->type != CORESIGHT_DEV_TYPE_SINK &&
> > > > > +         csdev->type != CORESIGHT_DEV_TYPE_LINKSINK)
> > > > > +             return -EINVAL;
> > > > > +
> > > > > +     if (!etm_perf_up)
> > > > > +             return -EPROBE_DEFER;
> > > > > +
> > > > > +     dev_attr = kzalloc(sizeof(*dev_attr), GFP_KERNEL);
> > > > > +     dev_attr->attr.name = kstrdup(dev_name(pdev), GFP_KERNEL);
> > > > > +     dev_attr->attr.mode = 0444;
> > > > > +     dev_attr->show = etm_perf_sink_name_show;
> > > > > +
> > > > > +     return sysfs_add_file_to_group(&pmu_dev->kobj,
> > > > > +                                    &dev_attr->attr, "sinks");
> > > >
> > > > What is so odd about this call that you needed me to review this?
> > >
> > > As far as I can tell nobody is feeding a dynamic struct attribute to
> > > the function and I wasn't sure if it was because they were told not to
> > > or simply because it wasn't needed, hence asking for a second opinion.
> >
> > Ah.  Well, again, this is a good question to answer:
> >
> > > > And what happens if this call fails, do you leak memory?
> 
> That's something I will fix in the next revision.
> 
> >
> > And also, what happens when you unload the device, who frees the
> > attribute's memory?
> 
> If configured, coresight devices aren't removable.

But is the driver able to be unloaded?  Unbound from the device manually
through sysfs?  There's lots of ways devices are "removed" that don't
involved physical removal :)

thanks,

greg k-h

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
