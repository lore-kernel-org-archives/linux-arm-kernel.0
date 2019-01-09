Return-Path: <SRS0=Odjb=PR=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 051F0C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 01:42:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB83420883
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 01:42:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Tck6el4/";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Sk7aKVYM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB83420883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=hgutU2uTbjkObitcNF4UJamQh+PVm4wOO6DkFu/TnMs=; b=Tck6el4/i2LNPh
	DhQBgIllyWa9BGU2sbCj6zLcUCfk23HeRR/CBu3vTgMslWEaYcAdO6fIYXP2QHfLcJ5zkAY1id6fD
	GktRbK9kofkFEPswrINgd53isJM2Elxp3yHDnb96SGoc90Nr7I63qkYZA07IoExtMWiAKPAcCRzKO
	o9l84tgyRwinx825PwUJlF0n54nRslgX4AHjOh38Uo625+ms8uezrGrnlx1ZtoV9juSdnGo6BJdAK
	6JxJ+vxRgvpX//kvyCVzoYBKsFDbxolM85Ksor5z7qixXvskvsa49pdMCaKPWEdVDhUiPyLTsG/9I
	xGHPhBJIuWqdj5VLaS2g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gh2t2-0006ec-Ah; Wed, 09 Jan 2019 01:42:28 +0000
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gh2sy-0006dk-Rw
 for linux-arm-kernel@lists.infradead.org; Wed, 09 Jan 2019 01:42:26 +0000
Received: by mail-wr1-x442.google.com with SMTP id x10so6004908wrs.8
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 08 Jan 2019 17:42:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to
 :user-agent; bh=b/HJvCgn5Z6ktlShmUJqvAiBoympcmpPOmkEoT0hzHc=;
 b=Sk7aKVYMj7EOy8H9fRgOY7SyUoYBkUiHa9t7rsxy4dLzC1VfBlNl6SY/Kr2TfgaIqV
 fBrt6z/zam8TRrYygQEfOJYYR3TLOcmMu6tETI+0P5B4kUOTV80SPRY1lH7vjlbADCzH
 udIqu6ZIU5P/yf+QBVG3z6mzbsn7m722l/50w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=b/HJvCgn5Z6ktlShmUJqvAiBoympcmpPOmkEoT0hzHc=;
 b=dY3bYvNwLvSTIO0njZDuNQUYsvOdNL3YH6pVZYJAqmq7M3TpAcNniZmRvjB1/kAzLK
 OCJo8loF1w7acZTCG2LQQyMioLtTdCiUpubsdhPXVwhotMMNM5Q2XkihuFvh1fKpOO1D
 siNVepUZnKD+dXOAIRIlNGj9DDRTV2HSDBFF474NQPqLRWFxL1I5Go986KJGMIfWOajG
 7MJe26l5ZcbBsxq4IDIOJkQqFpKgNrI7PtFexMiJCv0EeBdM6GqlTSr2C4jb51BmL8OY
 62Ypnv5scEp2mHpru6gB9YWSDA54g2HqDDoBbk+3whIYcBL7vbZcH9TAnTudj7d7X12a
 gm/w==
X-Gm-Message-State: AJcUukfDbCVRLeWjZjW69HCsL36ofl+bdi/2as345O6sY98vJs02shoC
 I6S7yfPTiY/EFKuuuN7VSU5VvA==
X-Google-Smtp-Source: ALg8bN68p7cOe+vxysUeacG+9RLxll6UW+RojJnTZhd+9ifwoJfa9dseDZUZD5Zyand7EbWegT8sAw==
X-Received: by 2002:adf:81c4:: with SMTP id 62mr2941156wra.266.1546998140673; 
 Tue, 08 Jan 2019 17:42:20 -0800 (PST)
Received: from linaro.org ([2a01:e0a:f:6020:99e2:bc56:9ad9:69c5])
 by smtp.gmail.com with ESMTPSA id c14sm10756601wme.13.2019.01.08.17.42.19
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 08 Jan 2019 17:42:19 -0800 (PST)
Date: Wed, 9 Jan 2019 02:42:18 +0100
From: Vincent Guittot <vincent.guittot@linaro.org>
To: Tony Lindgren <tony@atomide.com>
Subject: Re: Regression in v5.0-rc1 with autosuspend hrtimers
Message-ID: <20190109014218.GA8363@linaro.org>
References: <20190107233833.GI5544@atomide.com>
 <CAKfTPtDBEmcsLotp-6K1KU1wM9Ba1EpMp3niXScRxYgzjs0nog@mail.gmail.com>
 <20190108155354.GL5544@atomide.com>
 <CAKfTPtCoOK-cYLXJ--sOfpVa9RVmzOAEN1+zB2qHMCzkJN0qaQ@mail.gmail.com>
 <20190108213743.GN5544@atomide.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190108213743.GN5544@atomide.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190108_174224_911651_54F9BF67 
X-CRM114-Status: GOOD (  18.39  )
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
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
 "open list:THERMAL" <linux-pm@vger.kernel.org>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 linux-kernel <linux-kernel@vger.kernel.org>, linux-omap@vger.kernel.org,
 LAK <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Le Tuesday 08 Jan 2019 =E0 13:37:43 (-0800), Tony Lindgren a =E9crit :
> * Vincent Guittot <vincent.guittot@linaro.org> [190108 16:42]:
> > On Tue, 8 Jan 2019 at 16:53, Tony Lindgren <tony@atomide.com> wrote:
> > > Hmm so could it be that we now rely on timers that that may
> > > not be capable of waking up the system from idle states with
> > > hrtimer?
> > =

> > With nohz and hrtimer enabled,  timer relies on hrtimer to generate
> > the tick so you should use the same interrupt.
> =

> OK yeah looks like that part is working just fine.
> =

> Adding some printks and debugging over ssh, looks like
> omap8250_runtime_resume() gets called just fine based on a wakeirq,
> but then omap8250_runtime_suspend() runs immediately instead of
> waiting for the three second timeout.
> =

> Lowering the autosuspend_delay_ms to 2100 ms makes things work again.
> Anything higher than 2200 ms seems to somehow time out immediately
> now :)

This is quite close to the max ns of an int on arm 32bits

Could you try the patch below ?

---
 drivers/base/power/runtime.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index 7062469..44c5c76 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -141,7 +141,7 @@ u64 pm_runtime_autosuspend_expiration(struct device *de=
v)
 =

 	last_busy =3D READ_ONCE(dev->power.last_busy);
 =

-	expires =3D last_busy + autosuspend_delay * NSEC_PER_MSEC;
+	expires =3D last_busy + (u64)(autosuspend_delay) * NSEC_PER_MSEC;
 	if (expires <=3D now)
 		expires =3D 0;	/* Already expired. */
 =

-- =

2.7.4


> =

> Regards,
> =

> Tony

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
