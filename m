Return-Path: <SRS0=Ql45=PY=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFAD9C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 23:57:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B8AC20578
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 23:57:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GmCiAbfP";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="UlX3O75o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B8AC20578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=eqT+MdpSarhrPAuQBJXSehUoCyyZYWEGopG1/BF7C1Q=; b=GmCiAbfPneqwbx
	gv6q+HOy1GOgOIGOH3gJ0R6C4F5qRKllCivg1JU/H7OsrQC32zgbQu0nqaEO4cZW5s5enbOU8b3on
	sArTVOYgkl8do54p1EcBDUjb7idUMr+mlsqo9nxB3XV6y0hLt6oroOrQVXQ6Y5nm08fzDYZxJGG9R
	Ad6EZIodJlNt/iESAyRZjTEU6gXqzySvwqG+9K5O44UE0LwuDOOQg6wJqKaPm0L2TlIlA/IXwNFUO
	7gu4EqKIQRLTCFrqjiy49sbIv0ZLfdBWSBOreRNKe3mOZzvwFhkLNGFRuzpLFtUq9FO97WdMQwAm6
	YGcC2lGinN3rn65a0pNw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjv49-0003wt-4f; Wed, 16 Jan 2019 23:57:49 +0000
Received: from mail-io1-xd43.google.com ([2607:f8b0:4864:20::d43])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjv45-0003wU-EV
 for linux-arm-kernel@lists.infradead.org; Wed, 16 Jan 2019 23:57:47 +0000
Received: by mail-io1-xd43.google.com with SMTP id c2so6342536iom.12
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 16 Jan 2019 15:57:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=JrGVINkH5orwlxo/ufq/0W/6iiXp3LMElGf41fqgd3k=;
 b=UlX3O75oT1xMKi9A0GmNflZTEZIvfpC/12qeVIAwoeKEZIwUjxNsE0Lb0QocbkdlE4
 rXJWqtUkcMn1vyTQ9MyIS6zvvQZNRUF5KSqTqKzcLj4dsgA0DZp2YEDD66x7jN/zeurz
 Lm2TzPt/MDNGbmY4Gv6CpS614UIYvE7SSP2E4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=JrGVINkH5orwlxo/ufq/0W/6iiXp3LMElGf41fqgd3k=;
 b=mFLbll+sRSK2iq8S4V+WLCD9nrPk2reafgSbIE0VCaTJ7m+rLfoISK4Fc4/6U1Vi99
 k5JvKMoCO9LzRdCb5HpLaH8R+R55RsZoeqcS9PL4GHD9UqMBgL+suUK7Miy7ZLN/AKIe
 UXdL4LdQDUjphDsie1EcsTZ7RF2Jvt7fMWDISokNDAuNJSY0jLqJIiPJp9LFddklvh1Q
 fnugHCO71Qc/r6DDLNMVO0wrlc6KELLqWboOqG6O0PbSFYvvtVltVt/60SJc7YbSuITy
 io14A2Imx/yUs63wDNhjM+Dl0aRvcQZOylFbQEKwLmKdk+3f59RfgK4cCb20QlBlImma
 QXlg==
X-Gm-Message-State: AJcUukdcPs4NBhoAN91FXxm9QJ6htx/08UPQCStHWlw02AXlcE1eP1sw
 izBAjr2/icYlThXp8OBMJmnVO/daxPfIRpowmOfJlg==
X-Google-Smtp-Source: ALg8bN6uzncOpFWe0vITjpK+HonH/DR3Lg/DZBmeIEQ9LOgjjHGeE84vBNop5YQ80nA9ZMnLCMJ8PsPA0tyGt1IUkJ0=
X-Received: by 2002:a5d:8491:: with SMTP id t17mr6342497iom.11.1547683063610; 
 Wed, 16 Jan 2019 15:57:43 -0800 (PST)
MIME-Version: 1.0
References: <20190115230742.13730-1-mathieu.poirier@linaro.org>
 <20190115230742.13730-4-mathieu.poirier@linaro.org>
 <b688e813-a3a3-011a-a0b1-0eeeffe8816d@arm.com>
In-Reply-To: <b688e813-a3a3-011a-a0b1-0eeeffe8816d@arm.com>
From: Mathieu Poirier <mathieu.poirier@linaro.org>
Date: Wed, 16 Jan 2019 16:57:32 -0700
Message-ID: <CANLsYkwgn0aEbAAyTvL8f=M4Y9=04Dsxs-VqaEh64Hc8UKY-pw@mail.gmail.com>
Subject: Re: [PATCH 3/7] coresight: Use event attributes for sink selection
To: Suzuki K Poulose <suzuki.poulose@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190116_155745_491514_50B7C3A2 
X-CRM114-Status: GOOD (  33.27  )
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

On Wed, 16 Jan 2019 at 03:36, Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
>
> Hi Mathieu,
>
> On 15/01/2019 23:07, Mathieu Poirier wrote:
> > This patch uses the information conveyed by perf_event::attr::config2
> > to select a sink to use for the session.  That way a sink can easily be
> > selected to be used by more than one source, something that isn't currently
> > possible with the sysfs implementation.
> >
> > Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> > ---
> >   .../hwtracing/coresight/coresight-etm-perf.c  | 16 ++------
> >   drivers/hwtracing/coresight/coresight-priv.h  |  1 +
> >   drivers/hwtracing/coresight/coresight.c       | 39 +++++++++++++++++++
> >   3 files changed, 44 insertions(+), 12 deletions(-)
> >
> > diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
> > index 292bd409a68c..685d16001d0b 100644
> > --- a/drivers/hwtracing/coresight/coresight-etm-perf.c
> > +++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
> > @@ -201,18 +201,10 @@ static void *etm_setup_aux(struct perf_event *event, void **pages,
> >               return NULL;
> >       INIT_WORK(&event_data->work, free_event_data);
> >
> > -     /*
> > -      * In theory nothing prevent tracers in a trace session from being
> > -      * associated with different sinks, nor having a sink per tracer.  But
> > -      * until we have HW with this kind of topology we need to assume tracers
> > -      * in a trace session are using the same sink.  Therefore go through
> > -      * the coresight bus and pick the first enabled sink.
> > -      *
> > -      * When operated from sysFS users are responsible to enable the sink
> > -      * while from perf, the perf tools will do it based on the choice made
> > -      * on the cmd line.  As such the "enable_sink" flag in sysFS is reset.
> > -      */
> > -     sink = coresight_get_enabled_sink(true);
> > +     /* First get the selected sink from user space. */
> > +     sink = coresight_get_sink_by_id(event->attr.config2);
>
> Please could we also expose this information under "format", so that the
> userspace knows where to fill in the sink id ? The other advantage is, we
> could always change the size of the sink_id with the above, if we decide
> to do something different with the sinks.

Humm...  From my point of view we don't want user space to do anything
with the sink ID other than read it.  In what  scenario do envison
user space filling the sink ID?

>
> And also, I think this should be :
>
>         if (event->attr.config2) {
>                 sink = coresight_get_sink_by_id(event->attr.config2)
>                 if (!sink)
>                         return -ENODEV;
>         } else {
>                 sink = coresight_get_enabled_sink(true);
>         }
> So that we don't fallback to an enabled sink when a sink id is explicitly
> specified ?

The code in user space refuses to go forward if an invalid sink has
been specified but enforcing the same in kernel space is a good idea.
I'll heed your advice.

>
> > +     if (!sink)
> > +             sink = coresight_get_enabled_sink(true);
> >       if (!sink || !sink_ops(sink)->alloc_buffer)
> >               goto err;
> >
> > diff --git a/drivers/hwtracing/coresight/coresight-priv.h b/drivers/hwtracing/coresight/coresight-priv.h
> > index 579f34943bf1..071bb98d358f 100644
> > --- a/drivers/hwtracing/coresight/coresight-priv.h
> > +++ b/drivers/hwtracing/coresight/coresight-priv.h
> > @@ -147,6 +147,7 @@ void coresight_disable_path(struct list_head *path);
> >   int coresight_enable_path(struct list_head *path, u32 mode, void *sink_data);
> >   struct coresight_device *coresight_get_sink(struct list_head *path);
> >   struct coresight_device *coresight_get_enabled_sink(bool reset);
> > +struct coresight_device *coresight_get_sink_by_id(u64 id);
> >   struct list_head *coresight_build_path(struct coresight_device *csdev,
> >                                      struct coresight_device *sink);
> >   void coresight_release_path(struct list_head *path);
> > diff --git a/drivers/hwtracing/coresight/coresight.c b/drivers/hwtracing/coresight/coresight.c
> > index 526f122a38ee..7e2ce0beb2a0 100644
> > --- a/drivers/hwtracing/coresight/coresight.c
> > +++ b/drivers/hwtracing/coresight/coresight.c
> > @@ -11,6 +11,7 @@
> >   #include <linux/err.h>
> >   #include <linux/export.h>
> >   #include <linux/slab.h>
> > +#include <linux/stringhash.h>
> >   #include <linux/mutex.h>
> >   #include <linux/clk.h>
> >   #include <linux/coresight.h>
> > @@ -541,6 +542,44 @@ struct coresight_device *coresight_get_enabled_sink(bool deactivate)
> >       return dev ? to_coresight_device(dev) : NULL;
> >   }
> >
> > +static int coresight_sink_by_id(struct device *dev, void *data)
> > +{
> > +     struct coresight_device *csdev = to_coresight_device(dev);
> > +     unsigned long hash;
> > +
> > +     if (csdev->type == CORESIGHT_DEV_TYPE_SINK ||
> > +          csdev->type == CORESIGHT_DEV_TYPE_LINKSINK) {
> > +             /*
> > +              * See function etm_perf_sink_name_show() to know where this
> > +              * comes from.
> > +              */
> > +             hash = hashlen_hash(hashlen_string(NULL, dev_name(dev)));
> > +
> > +             if (hash == (*(unsigned long *)data))
> > +                     return 1;
>
> nit: is it worth storing the sink_id of a sink in the csdev ? May be if we add
> attribute field to the csdev (as mentioned in the previous patch), we could
> simply use it here to compare.

That depends on what we end up doing in the previous patch (see my
comment).  Since we are not even close to modularize coresight drivers
(unless you're already spending your weekends working on that,
something I doubt very much :o) ) I don't think we need to go this
way.  Again, let me know if you really want me to change this.

Thank you for your time,
Mathieu

>
> Rest looks fine to me.
>
> Cheers
> Suzuki

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
