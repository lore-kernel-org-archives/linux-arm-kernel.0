Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A3BCC07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 10:19:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1AD1520811
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 10:19:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="PK/gSiMr";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="LEQFgAFn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AD1520811
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=XDXSfIr5E9S1vqiQtqgQl/gtWxVMTNd5Hz4thBWoqfI=; b=PK/gSiMrTpYgsL
	aMBewj/V2FkzzRPWBSAPDMWPF/RsMFjkDuKFMuvOn3De/KWe7l9wqQ7gG+aBImRJEJYmOthagFld9
	s9r27S/LKJuM8nSdqWba9rC8zlowC3IIaRx/xCtNSIgm2NfXdQPql8DzlZSP5IhwnQgEc6z9NG8EH
	X6VbBi1V4sb+v7RBPkqsN3IccuvCZQj5sMuf8kN4Bc+kIsuogAIp3MCfFBFZc25GUU7zqhkUlXEiF
	s/dLGmRZfqCAYhuQkRoC3ppIigbJcqytoZtAsUqI8sL2JF2IzKOw1qb1XJerArwIOUhYfU5Fp97u1
	jXAZMWq9j/XPrVOcznRQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWf8j-0001nF-A6; Tue, 11 Dec 2018 10:19:45 +0000
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWf8f-0001mO-Kc
 for linux-arm-kernel@lists.infradead.org; Tue, 11 Dec 2018 10:19:43 +0000
Received: by mail-wm1-x343.google.com with SMTP id y185so8639371wmd.1
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 11 Dec 2018 02:19:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=jkOS+QCEdJo7wV+YvHLMQGYbpemDbMOlvhOduaGxWt0=;
 b=LEQFgAFnPB50HlQkp+zY3vYzrcCp9bYzCRfWmdun/wI9KySg7HQD9D5FFkGNDHLV2k
 s0N4pIHhaphEvg7tzMHTz54cO2ggeMDNhnoF40Ht+k/RWwBTOmt1xK/HznqYf6NPRe2N
 OBwVojSj5ooPJRosqKegAOQNAePZcCvWc68L8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=jkOS+QCEdJo7wV+YvHLMQGYbpemDbMOlvhOduaGxWt0=;
 b=pnwqBKfw9MF1Vc1xDN1gGNeJISEZmnhLjmZMq8CNwoYXN/H9cogl4Wd+YmgD90JrwN
 eVAiLKR5/4wndRGoBf6FqzouwL6vdR2mwXAjPoXJSG8mw9jI5EMv55lRWtbvmmrip2D/
 cW3JiIN4YU4lTPdVNGDB8n+rCg9YMFTbzk3bnMDm/jFB2jsYWCVCtLdADX8t0za8tWYC
 f8QIfyxiMhk53Mw4iMcSUWAKXBwGAtsVryzLYkhqRu8TV/0hWDd645ZTYkxzo8+rnKvS
 3IW7K7dVn8TmXxUb0QFD1x3A/1tTuQI48vUfePEYXwOQlz0DT6kdMBxTe/RSQSxt4M6S
 KWEQ==
X-Gm-Message-State: AA+aEWaI3f1YpuvAoEiQ9PgXBoscjd3UJLFVKEL+A0KaspqvxueanNCO
 B0ZEDHSNZxPJDfWafL+ebnYSW4BF+J8r5Q==
X-Google-Smtp-Source: AFSGD/WgLSyIhvjCZlq0207RwtLa3sSxyS0hkKp9qdWEMb4bwByqPtznBtQZtPLnzC6MHsyaHN6fGA==
X-Received: by 2002:a1c:384:: with SMTP id 126mr1789953wmd.26.1544523569405;
 Tue, 11 Dec 2018 02:19:29 -0800 (PST)
Received: from leoy-ThinkPad-X240s ([209.250.228.18])
 by smtp.gmail.com with ESMTPSA id o64sm1848735wmo.47.2018.12.11.02.19.26
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 11 Dec 2018 02:19:28 -0800 (PST)
Date: Tue, 11 Dec 2018 18:19:21 +0800
From: leo.yan@linaro.org
To: Lei Wen <adrian.wenl@gmail.com>
Subject: Re: Coresight etmv4 enable over 32bit kernel
Message-ID: <20181211101921.GD3128@leoy-ThinkPad-X240s>
References: <CALZhoSRaR-eMyr7HKUTDi5oRiJfRZ7x1NRRM49v-nn6U7e9sJg@mail.gmail.com>
 <CANLsYkzTGnPQ3FUPWYc-DOigvzMuTFTGqbbVTqqtVuCQW3esSA@mail.gmail.com>
 <CALZhoSR6QXSUzEY5SuiC96jDAARE-+9=LxNXo4WoZkVcL8gM6Q@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CALZhoSR6QXSUzEY5SuiC96jDAARE-+9=LxNXo4WoZkVcL8gM6Q@mail.gmail.com>
User-Agent: Mutt/1.10+31 (9cdd884) (2018-06-19)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_021941_703940_6DC6E8B9 
X-CRM114-Status: GOOD (  25.38  )
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
Cc: linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, leiwen@outlook.com,
 linux-kernel@vger.kernel.org, mathieu.poirier@linaro.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Lei,

On Tue, Dec 11, 2018 at 05:11:02PM +0800, Lei Wen wrote:
> On Tue, Dec 11, 2018 at 2:02 AM Mathieu Poirier
> <mathieu.poirier@linaro.org> wrote:
> >
> > Good day Adrian,
> >
> > On Sat, 8 Dec 2018 at 05:05, Lei Wen <adrian.wenl@gmail.com> wrote:
> > >
> > > Hi Mathieu,
> > >
> > > I am enabling etmv4 coresight over one Cortex-A7 soc, using 32bit kernel.
> > > And I am following [1] to do experiment regarding the addr_range feature.
> >
> > That wiki is very old and after reading it again I seriously consider
> > removing it.  It is still accurate but there are better ways to do
> > things now, i.e perf.  The main openCSD documentation page [2]
> > contains everything you need to know about the integration with perf.
> >
> > [2]. https://github.com/Linaro/OpenCSD/blob/master/HOWTO.md
> >
> > > The default addr_range is set as _stext~_etext, and it works fine with
> > > etb as sink,
> > > and etm as source. I could see there are valid kernel addresses using OpenCSD.
> >
> > I'm really curious about how you use openCSD to validate your traces -
> > can you  expand more on that?
> 
> 
> I just manually replace the cstrace.bin in the
> decoder/tests/snapshots/juno-ret-stck/.
> And modify the register data according to my platform.
> Then produce the decode result by below command:
> ./decoder/tests/bin/builddir/trc_pkt_lister -ss_dir
> decoder/tests/snapshots/test -decode -logfilename 2.ppl

Just remind, you also could refer TC2 platform, I think it can be more
close to your platform with CA7 CPUs.  And except cpu_X.ini files, you
also need to modify snapshot.ini & trace.ini under the snapshot
folder [1].

[1] https://github.com/Linaro/OpenCSD/blob/master/decoder/docs/specs/ARM%20Trace%20and%20Debug%20Snapshot%20file%20format%200v2.pdf

> > I think the results are misleading you since the openCSD library can't
> > readily be used to decode sysfs trace sessions.  The wiki doesn't
> > mention using openCSD to decode traces either.  The only integrated
> > way to use openCSD to decode CoreSight traces is via perf.  Again, the
> > link above will give you all the information you need to do that.
> 
> >
> > >
> > > But while I try to store one small range of address pair, which contain only one
> > > kernel function. It doesn't behavior like what said in [1], the write
> > > pointer would
> > > grows rapidly with the read pointer. And I dump the etb buffer and parse it with
> > > openCSD, finding that there is no I_ASYNC packet in the dump and is fulled with
> > > I_NOT_SYNC.
> > >
> > > So my question is why ETB continue to grow when there is no trigger at all?
> > > Is it normal? I could provide more info if you need it.
> >
> > I am dubious about the validation process and as such can't comment on
> > this.  Please share your results using the perf integration and then
> > I'll be able to have a better idea of what is going on.
> 
> I see... I would try use perf to get more result and get back here.

I verified mainline kernel with perf tool, it can work well on Juno
board for address range filter.  Please ensure you are using a newer
kernel version (e.g 4.16 but not 4.14, 4.14 kernel doesn't contain
cs-etm decoder in perf tool).

[...]

Thanks,
Leo Yan

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
