Return-Path: <SRS0=Ql45=PY=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BA07C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 23:44:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6831420840
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 23:44:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="q6ZUXM8a";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="TURSJ7/5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6831420840
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=VxXHD1sZAA341ubI2JqqMx+5ln3IFH7hO6KTxm4RraU=; b=q6ZUXM8aRozcHY
	7VsbdaCTXuhZs/MfGL4QmqZbF0WfVOlKOmb3vLYHtjROIPT9qGuWAMxWn+joNm8LcdNsJN6SenySS
	KRqtycr9tRumGDAVYzlcHB+sfz2tiGrTqIUwC5myLwflDoHjfJiOYfr6RZKoEoNt6J3Dkf0YYMHmT
	K7Bxq+ivnTCFMPl5M5GeIn9qCkJu4ju3CeXvWAlc4fOH2/bjBp9Us48+wxe2SNQidJbwQLIEcO4KG
	bhxk3Pg25MnLre0g0SqF3spboarIW5Mz+vefwwlD+HJAJx81kBt4uI6YQFO7zpKAWC8ePHLcLURBH
	iaXVmlB5BnyO8tcb1rqg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjuqv-0007JC-Oj; Wed, 16 Jan 2019 23:44:09 +0000
Received: from mail-it1-x143.google.com ([2607:f8b0:4864:20::143])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjuqs-0007IB-Cg
 for linux-arm-kernel@lists.infradead.org; Wed, 16 Jan 2019 23:44:08 +0000
Received: by mail-it1-x143.google.com with SMTP id h193so5298377ita.5
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 16 Jan 2019 15:44:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=3LeQfLR0aZ0V3aKibD+ER/7h/1zMywFsIvcaHPMOuRs=;
 b=TURSJ7/5T30A77hz76EL1Fphs6ExfDko2dgvRQWUgOorFlBlnv9cz0rzVXuiDH92m4
 iokcpO9oWflK54XrOOZQkMX4XpQ9WMvmUVUiXhI80p36dN81mcYuAUxmQua5l8fSKf1B
 BV0oA311nif01ztQkvFMQBvSFxAaiutXeEIok=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=3LeQfLR0aZ0V3aKibD+ER/7h/1zMywFsIvcaHPMOuRs=;
 b=QeitvR/NNpNhTmxMrm2Pq5gwbg2k7h1Bn8UIGeHKLbAinpauJwGTucN0d5d2OTc9rq
 5zwNSrmHj2Vfn1K1jd2QjUqqtXSaj+fJ9nrKjsi1JghQsnMqArBjd0V6z1VOR4Oj0lcU
 CmbbuI/KAzlRZMQ8UK9vhLAk97Upqb7l9ob/uU0zbtT+s1g2NWOeyI2djUQGrAou5pDw
 U1A4xAXItz0UOlNBX7iragCB+IgFVpQzwPMbc52qy9ihay4J9GBYmDezxFrPigbAfgCa
 w9wbaiKb3iLAawQmQd649GCic6pc0oMnJFN6O1FTDe76N3U90T4WPWYYpwuRKbWMWRJ3
 2kdA==
X-Gm-Message-State: AJcUukd/mZGtl5FXLlWeyN8Ter9iTKuYWGL+4N6cCtl0C9ZGZZtQzbBM
 OMJIfmbeudASvYFAvYWbb2tzLrsqAyX8G2aEbtvRTw==
X-Google-Smtp-Source: ALg8bN4RDVyPfuuoGUidOG1Su0+Pfc7Ap3/6Oi70P4x3d4+8EOj9JSO2qx60u/voN5GbthFTZVxoaIW0BIgB4eau1x4=
X-Received: by 2002:a05:660c:34f:: with SMTP id
 b15mr7405335itl.146.1547682242833; 
 Wed, 16 Jan 2019 15:44:02 -0800 (PST)
MIME-Version: 1.0
References: <20190115230742.13730-1-mathieu.poirier@linaro.org>
 <20190115230742.13730-3-mathieu.poirier@linaro.org>
 <9819f0ad-d735-6c50-ffca-90f08153aad2@arm.com>
In-Reply-To: <9819f0ad-d735-6c50-ffca-90f08153aad2@arm.com>
From: Mathieu Poirier <mathieu.poirier@linaro.org>
Date: Wed, 16 Jan 2019 16:43:51 -0700
Message-ID: <CANLsYky_1QxfNRnGi=3sONMrS6JCdjcwtdQBJqi9FtpQMvF_Zg@mail.gmail.com>
Subject: Re: [PATCH 2/7] coresight: perf: Add "sinks" group to PMU directory
To: Suzuki K Poulose <suzuki.poulose@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190116_154406_503807_C0002089 
X-CRM114-Status: GOOD (  27.45  )
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
 Peter Zijlstra <peterz@infradead.org>, Greg KH <gregkh@linuxfoundation.org>,
 heiko.carstens@de.ibm.com, Adrian Hunter <adrian.hunter@intel.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, ast@kernel.org,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>,
 "H. Peter Anvin" <hpa@zytor.com>, schwidefsky@de.ibm.com,
 Namhyung Kim <namhyung@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Jiri Olsa <jolsa@redhat.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Good evening Suzuki,

On Wed, 16 Jan 2019 at 03:29, Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
>
>
>
> On 15/01/2019 23:07, Mathieu Poirier wrote:
> > Add a "sinks" directory entry so that users can see all the sinks
> > available in the system in a single place.  Individual sink are added
> > as they are registered with the coresight bus.
> >
> > Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> > ---
> >   .../hwtracing/coresight/coresight-etm-perf.c  | 43 +++++++++++++++++++
> >   .../hwtracing/coresight/coresight-etm-perf.h  |  1 +
> >   drivers/hwtracing/coresight/coresight.c       | 17 ++++++++
> >   3 files changed, 61 insertions(+)
> >
> > diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
> > index f21eb28b6782..292bd409a68c 100644
> > --- a/drivers/hwtracing/coresight/coresight-etm-perf.c
> > +++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
> > @@ -14,6 +14,7 @@
> >   #include <linux/perf_event.h>
> >   #include <linux/percpu-defs.h>
> >   #include <linux/slab.h>
> > +#include <linux/stringhash.h>
> >   #include <linux/types.h>
> >   #include <linux/workqueue.h>
> >
> > @@ -43,8 +44,18 @@ static const struct attribute_group etm_pmu_format_group = {
> >       .attrs  = etm_config_formats_attr,
> >   };
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
> >   static const struct attribute_group *etm_pmu_attr_groups[] = {
> >       &etm_pmu_format_group,
> > +     &etm_pmu_sinks_group,
> >       NULL,
> >   };
> >
> > @@ -479,6 +490,38 @@ int etm_perf_symlink(struct coresight_device *csdev, bool link)
> >       return 0;
> >   }
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
>
> I would have  added the attribute to the csdev (say, sink_attr),
> and add that to the group, so that it is easier to remove the
> attribute when the sink device is removed from the system (when
> we get there). It would be good to have something in place to remove the
> attribute.

My hope was to avoid introducing a new field in the already bloated
coresight_device structure, and on top of things a component specific
field.  I think it would be worth it if we'd envision making the
coresight drivers removable in a not so distant future.  But doing
something like that is quite tricky (as Kim quickly found out) and
skirts the bottom of the list of priorities, if on it at all.

I'll change it if you're really keen on it but it would be code that
is never used.

Mathieu

>
> Otherwise, the overall approach looks fine to me.
>
> Suzuki

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
