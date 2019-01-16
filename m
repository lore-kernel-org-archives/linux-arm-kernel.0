Return-Path: <SRS0=Ql45=PY=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 590E1C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 16:14:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15F3420675
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 16:14:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="eGWnYfbF";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="XUI5mNrH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15F3420675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=498NYta03txmITu3h+O+N2EwzVaYMonu+UjDRdwHeAQ=; b=eGWnYfbFXzWKXU
	tlNWjsM0fN5xpTNuIKaCyWPE/0ADHa+3GpJtk+L9uiDtaQpnOMOOrAtWQhySDpFuvHEIz54cBFzon
	3xcbawCV+JVND/8MUIziTeCBWBMfdd1SQox1XefXxvi9cMirh8PxINwrnpBdWKOzOq3Q+FvZvrVpc
	TFetVZ3lFnyPMImEpJnclbYRUbn56am9hnD9Eme5T3CkePkE5OypOHT/tpiJPyxMaErXmC+8AABtp
	E59apkA1Xnj7SrUILWGjDFk0cpAQTFBdUCrLQPw2yJehcPnWBU+OkBqFPCZg3NvCB0GIpV6oK5bAn
	HNTZ9IxOzixgyyk5LInQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjnq8-0000jK-2Y; Wed, 16 Jan 2019 16:14:52 +0000
Received: from mail-it1-x141.google.com ([2607:f8b0:4864:20::141])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjnq4-0000im-BN
 for linux-arm-kernel@lists.infradead.org; Wed, 16 Jan 2019 16:14:49 +0000
Received: by mail-it1-x141.google.com with SMTP id m8so1387650itk.0
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 16 Jan 2019 08:14:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=KEi5tILKPLZ/2R3NAZK8W85biZ8ITep+crOK/DgNkq4=;
 b=XUI5mNrHEYJjIRjf0UtvI42TLm3d3yWkDLxiO0AB35yNFFeADBZE7l/mvF4owHBPTd
 v7TYgNOrNVMBpzq1amGnP6N2906rhRMbyoRzw8TubDk2Kh4MOP7k9vw2uzOhk/Zx+31X
 5LNIX8amy+Txdp+Q9Et87ZgaG7KngWG/KSj1o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=KEi5tILKPLZ/2R3NAZK8W85biZ8ITep+crOK/DgNkq4=;
 b=QaD786v+vjheoqHUMtCfVK7jcCdEOWS8QRUCGYX95rvujmiz7gDrUQ1IAj5l0TFojL
 Tiq4MIH9lDAQydaC5bDpVmBAs1X5p4I4kWW+Ed4pWjFwhKnSR6M/XRpg5fbQalS+Y1jW
 yVuf0PjFe6Wfj7J4VpZhFd715Vnf3JFTUaC8pT/DaVgDRyak7G6qc6j3eBioGmWTIeuW
 +q/tXD8vkALDy/a1KfczNuPbRfy9PFmaSFpaaCZpLnF3rX8QO0Jr4VdIsHaYu86WJgUU
 +RnbbcnNyQ8pHLmjasHxpeT0w0YhY86FIi1iK2duaHL+DAgTqRF3hmyHvyanYo/H+A3h
 +qNA==
X-Gm-Message-State: AJcUukf1Nb32UUXDXQJxUTPLehq8ZwLZ+LXywWIYvg9l86GHJ5iG8hz9
 mLNOFhmUAxY6VwzDRX9GiHdUGETWMe42pE1toSvuWw==
X-Google-Smtp-Source: ALg8bN6nkaEOFt0VS2q1o5mQBPcPAAcTfIGHTXqgZ57Vn9ebDdfKVBQA0a/469fsdK+RVUJHEBXMPsHv567BgYhUZoo=
X-Received: by 2002:a24:db02:: with SMTP id c2mr6297220itg.137.1547655283699; 
 Wed, 16 Jan 2019 08:14:43 -0800 (PST)
MIME-Version: 1.0
References: <20190115230742.13730-1-mathieu.poirier@linaro.org>
 <20190115230742.13730-3-mathieu.poirier@linaro.org>
 <20190116153948.GC871@kroah.com>
In-Reply-To: <20190116153948.GC871@kroah.com>
From: Mathieu Poirier <mathieu.poirier@linaro.org>
Date: Wed, 16 Jan 2019 09:14:33 -0700
Message-ID: <CANLsYkzfbJae6Nk7cHhnR09ZPSATa3g8sceGC=O3DfXYC2ruQQ@mail.gmail.com>
Subject: Re: [PATCH 2/7] coresight: perf: Add "sinks" group to PMU directory
To: Greg KH <gregkh@linuxfoundation.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190116_081448_385672_BAA935F9 
X-CRM114-Status: GOOD (  23.59  )
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

On Wed, 16 Jan 2019 at 08:39, Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Tue, Jan 15, 2019 at 04:07:37PM -0700, Mathieu Poirier wrote:
> > Add a "sinks" directory entry so that users can see all the sinks
> > available in the system in a single place.  Individual sink are added
> > as they are registered with the coresight bus.
> >
> > Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> > ---
> >  .../hwtracing/coresight/coresight-etm-perf.c  | 43 +++++++++++++++++++
> >  .../hwtracing/coresight/coresight-etm-perf.h  |  1 +
> >  drivers/hwtracing/coresight/coresight.c       | 17 ++++++++
> >  3 files changed, 61 insertions(+)
> >
> > diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
> > index f21eb28b6782..292bd409a68c 100644
> > --- a/drivers/hwtracing/coresight/coresight-etm-perf.c
> > +++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
> > @@ -14,6 +14,7 @@
> >  #include <linux/perf_event.h>
> >  #include <linux/percpu-defs.h>
> >  #include <linux/slab.h>
> > +#include <linux/stringhash.h>
> >  #include <linux/types.h>
> >  #include <linux/workqueue.h>
> >
> > @@ -43,8 +44,18 @@ static const struct attribute_group etm_pmu_format_group = {
> >       .attrs  = etm_config_formats_attr,
> >  };
> >
> > +static struct attribute *etm_config_sinks_attr[] = {
> > +     NULL,
> > +};
> > +
> > +static const struct attribute_group etm_pmu_sinks_group = {
> > +     .name   = "sinks",
> > +     .attrs  = etm_config_sinks_attr,
> > +};
> > +
> >  static const struct attribute_group *etm_pmu_attr_groups[] = {
> >       &etm_pmu_format_group,
> > +     &etm_pmu_sinks_group,
> >       NULL,
> >  };
> >
> > @@ -479,6 +490,38 @@ int etm_perf_symlink(struct coresight_device *csdev, bool link)
> >       return 0;
> >  }
> >
> > +static ssize_t etm_perf_sink_name_show(struct device *dev,
> > +                                    struct device_attribute *dattr,
> > +                                    char *buf)
> > +{
> > +     /* See function coresight_sink_by_id() to know where this is used */
> > +     u32 hash = hashlen_hash(hashlen_string(NULL, dattr->attr.name));
> > +
> > +     return scnprintf(buf, PAGE_SIZE, "%x\n", hash);
> > +}
> > +
> > +int etm_perf_symlink_sink(struct coresight_device *csdev)
> > +{
> > +     struct device *pmu_dev = etm_pmu.dev;
> > +     struct device *pdev = csdev->dev.parent;
> > +     struct device_attribute *dev_attr;
> > +
> > +     if (csdev->type != CORESIGHT_DEV_TYPE_SINK &&
> > +         csdev->type != CORESIGHT_DEV_TYPE_LINKSINK)
> > +             return -EINVAL;
> > +
> > +     if (!etm_perf_up)
> > +             return -EPROBE_DEFER;
> > +
> > +     dev_attr = kzalloc(sizeof(*dev_attr), GFP_KERNEL);
> > +     dev_attr->attr.name = kstrdup(dev_name(pdev), GFP_KERNEL);
> > +     dev_attr->attr.mode = 0444;
> > +     dev_attr->show = etm_perf_sink_name_show;
> > +
> > +     return sysfs_add_file_to_group(&pmu_dev->kobj,
> > +                                    &dev_attr->attr, "sinks");
>
> What is so odd about this call that you needed me to review this?

As far as I can tell nobody is feeding a dynamic struct attribute to
the function and I wasn't sure if it was because they were told not to
or simply because it wasn't needed, hence asking for a second opinion.

>
> And what happens if this call fails, do you leak memory?
>
> thanks,
>
> greg k-h

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
