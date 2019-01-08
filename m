Return-Path: <SRS0=tBLO=PQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58770C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 18:35:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A1DF20827
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 18:35:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hO8rvY19";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WhSJlIcX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A1DF20827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:Message-ID:References:From:
	In-Reply-To:To:Subject:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=9puyndl2w+hRIUhPCcJAncpE+EjNAYC1y1PyXcDYGtU=; b=hO8rvY19NdCuvg
	2ZnvGlPNgl5SOgnG2BxGOcZjemIxidXXGhtjmyscS5mKx5+8oxMyp1bpTIfxd++0OjhHDj5kB5tdt
	HwQIR/+OXDgIRO4ubWDaj9YWan+TCtkwu0RLnxAOHoIh15nS4EKzajU6Mlrub7Cf9eI4LLIdEjb6M
	NpBp1J6m3fUiAbNTQe9ytBEBaxrFRqhjP/ncC9DEdm62QXCdMx1oVT38v0seMBZrJtOKTDYvVMKr6
	x3Dm49rU7piIWUjjm6O8dHO06nG/tCJw7F7RuyMWPYOozItT8EszBxd733H5RucKikUclWxOgE2Id
	lhyuNMa+HbN3sORu66EA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ggwDk-0003AD-2H; Tue, 08 Jan 2019 18:35:24 +0000
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ggwDg-00039I-Sl
 for linux-arm-kernel@lists.infradead.org; Tue, 08 Jan 2019 18:35:22 +0000
Received: by mail-pl1-x643.google.com with SMTP id t13so2271064ply.13
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 08 Jan 2019 10:35:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:content-transfer-encoding:subject:cc:to:in-reply-to
 :from:user-agent:references:message-id:date;
 bh=gu2/38Y7g7xPtSOrpl8BprJ/DF01j+H/9kbu3B2uWyQ=;
 b=WhSJlIcXDKvke6McMFz4ZIAD1Bn/Vo5XqAdWJn0YE1eSuOUvIIdIHoakUZLvz4BmmZ
 na2IbNy6jychDu0iyiz6MPNRSHjmgPbGW8cTr/jVFIC/Jx9hJ4P9uxx/I4kLQSxfJQei
 YNHFHssPVdSIeQDspGJfUFsStuQjyTqMEnBss=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:content-transfer-encoding:subject
 :cc:to:in-reply-to:from:user-agent:references:message-id:date;
 bh=gu2/38Y7g7xPtSOrpl8BprJ/DF01j+H/9kbu3B2uWyQ=;
 b=aq+lJRNXS0ddKYgb5OxkhR303TGzKOd9QD6zdldC929rmVwcLlujKzDVkMTG14dymL
 uQGWbvbLgBg3gvmiAMLqzNxYEEZtHvo97NcIPbv4FANdw6xsWIFvMVs+Jasjo9Fwi3kF
 +/D9BfdQU7qzJydYRwyJmHx1LVMaAxUcFkDFU2mCch6vq4LKCtfyeAvKlEHM9+iqfLQx
 jQ6BmZF2Eer1/0u+T6is15evLg80rYLHh/uweu3eY4KKRefLH1fIUY4gwvHsKhGMb6mG
 wX+LNttiU+pi1qFYZEMTatoupU5EpALDdOahEQ5VxY3152ibG5bcCnJMNmYBNpmTwdg6
 oszw==
X-Gm-Message-State: AJcUukdaHxeNgR1BkP9jMEaN6y1VYblxqrG2FMxGwTxJI0I+TJDSbGDF
 2eNIXx4NxsJVKO9Peo0mCKV+Ag==
X-Google-Smtp-Source: ALg8bN5vz6jNZR/kxZa3knzApWrzY93PIloV7HvL7f10xilFetDjSYJXq/gD5eMoON0rBY6vrV4Ygg==
X-Received: by 2002:a17:902:96a:: with SMTP id 97mr2783324plm.45.1546972519670; 
 Tue, 08 Jan 2019 10:35:19 -0800 (PST)
Received: from localhost ([2620:15c:202:1:fa53:7765:582b:82b9])
 by smtp.gmail.com with ESMTPSA id j21sm99414958pfn.175.2019.01.08.10.35.18
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 08 Jan 2019 10:35:19 -0800 (PST)
MIME-Version: 1.0
Subject: Re: [PATCH] soc: qcom: rpmh: Avoid accessing freed memory from batch
 API
To: Evan Green <evgreen@chromium.org>, Lina Iyer <ilina@codeaurora.org>
In-Reply-To: <20190107212321.GK14960@codeaurora.org>
From: Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.8
References: <20190103174657.251968-1-swboyd@chromium.org>
 <CAE=gft6M7aaPjS0KRg7dyfLOGtgXdU1qaT7oNeRHeNFQpRouWA@mail.gmail.com>
 <20190107212321.GK14960@codeaurora.org>
Message-ID: <154697251815.15366.10888159477746216145@swboyd.mtv.corp.google.com>
Date: Tue, 08 Jan 2019 10:35:18 -0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190108_103520_926340_3C94E9CA 
X-CRM114-Status: GOOD (  13.64  )
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
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Matthias Kaehlcke <mka@chromium.org>, Andy Gross <andy.gross@linaro.org>,
 "Raju P.L.S.S.S.N" <rplsssn@codeaurora.org>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Quoting Lina Iyer (2019-01-07 13:23:21)
> On Fri, Jan 04 2019 at 14:02 -0700, Evan Green wrote:
> >On Thu, Jan 3, 2019 at 9:47 AM Stephen Boyd <swboyd@chromium.org> wrote:
> >>
> >> @@ -380,7 +386,10 @@ int rpmh_write_batch(const struct device *dev, enum rpmh_state state,
> >>         }
> >>
> >>         for (i = 0; i < count; i++) {
> >> -               rpm_msgs[i].completion = &compl;
> >> +               struct completion *compl = &compls[i];
> >> +
> >> +               init_completion(compl);
> >> +               rpm_msgs[i].completion = compl;
> >>                 ret = rpmh_rsc_send_data(ctrlr_to_drv(ctrlr), &rpm_msgs[i].msg);
> >>                 if (ret) {
> >>                         pr_err("Error(%d) sending RPMH message addr=%#x\n",
> >
> >It's a little weird that we call rpmh_tx_done on a bunch of transfers
> >we never submitted, just so the completion will get signaled so we can
> >wait on it in the next loop. We could just do count = i; break; here
> >instead.
> >
> It seems like it was carried over from my earlier submissions, where I
> was reference counting the number of completions for a batch. I beleive,
> with what we are doing here, we don't need to call tx_done with this
> approach.

Ok. So we can remove this whole chunk of code that forces out
completions and unwind more properly?


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
