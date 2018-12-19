Return-Path: <SRS0=AchV=O4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36232C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 20:09:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0BC820811
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 20:09:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hQVVOdwG";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="nn3JDO8g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0BC820811
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=BHXtPZnALkog3fantdBGruEhNcrc3YwjxYUuYrRplyw=; b=hQVVOdwGVyiR3t
	DDaBnDvQmAOABTOlQ2V3ivW60ue+d5HgNOtdwvH7TLTrAqdFvshQyiewDXGuBHoB49XB0aaXmquBB
	n27yXp5q13M26nj694+rZ1qiZl1r+O/6mktXViW7fOQH5z96K+vxJRZk9fojQh/oUf61z1ng6XCYj
	C1n+j+9q7OCB2r+rpq15Qn9effzfucZXVUv8yn8wAa4sod4nixcIy+jMmHW1r/4FAMbS9pnwTAdeH
	FQ8AnkMXnGv4fRaoP+QRj/eNUvZqlxEg7FndCIasguD5VdHgr3SJ46PUc6hrdrxQYfVppHG9gNv4r
	9trEoZUBaX5pTrKJisOg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZi9h-0007z2-KM; Wed, 19 Dec 2018 20:09:21 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZi9d-0007xf-Ue
 for linux-arm-kernel@lists.infradead.org; Wed, 19 Dec 2018 20:09:19 +0000
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com
 [209.85.160.177])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 8E21520874
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 19 Dec 2018 20:09:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1545250145;
 bh=0YmhRJarbuk7qpMnwEiGsovV7/dg5x1RXgopNvj2bno=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=nn3JDO8gPLIwBzTzlPs2qaXnJpiAkaOsUiZD1WXiJUHOaBoxrpAp4hTJ94WF1hJYJ
 JCKIED6PU/o8kOnny03deG2S8vg+v2dT4xU39pvpd4vOsifB/Lv2WfHiiDxW8f4Huz
 EZdrnNg3DP7+k9t57lNZtwUwzJUOHbYc71GZ5FDw=
Received: by mail-qt1-f177.google.com with SMTP id d19so23656268qtq.9
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 19 Dec 2018 12:09:05 -0800 (PST)
X-Gm-Message-State: AA+aEWbE1/XOXtkQNX+rxrEzPC0MgeUVhA3RYUl+ogOc8KTfelwj0bWj
 TqSMEvGf+yZAYKn+AZ0XdVkqClI4TIlJjvVNcA==
X-Google-Smtp-Source: AFSGD/WiPL27Zt3YGZOND3Nk+CvOUUkeROJfbkScjh7LhpnH2E6dUUi7N19uVg1k6wiZfYAcUsOhBPUG52zJTSTeIDg=
X-Received: by 2002:ac8:6b18:: with SMTP id w24mr23615949qts.144.1545250144745; 
 Wed, 19 Dec 2018 12:09:04 -0800 (PST)
MIME-Version: 1.0
References: <20181212211848.26768-1-jcrouse@codeaurora.org>
 <20181212211848.26768-3-jcrouse@codeaurora.org>
 <20181214044057.wybv6wqg75qdnmic@vireshk-i7>
 <CAD=FV=VQEtQtnPJyo6vLm7ndPjowZ35FY-cibJyN_imZMoVU3w@mail.gmail.com>
 <20181217070647.xtvfgsixggua5yod@vireshk-i7>
 <CAD=FV=WKfKyZe6sc4drfa9kLQVbG1b9nCe6qbPmUPQGNEKAh=Q@mail.gmail.com>
 <154515840025.238328.5075439774176447808@swboyd.mtv.corp.google.com>
 <CAD=FV=XeFYmOJx9Wxy7hLQwSq1GoF84eQ93Y4KgrO1JM-g9ZiA@mail.gmail.com>
 <20181219044901.x76bd5vdsznhhrmz@vireshk-i7>
In-Reply-To: <20181219044901.x76bd5vdsznhhrmz@vireshk-i7>
From: Rob Herring <robh@kernel.org>
Date: Wed, 19 Dec 2018 14:08:52 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLs69=nr=2J_48N3VtD0qNRnxAgDU8uMRwY_Qqp6Dzs_Q@mail.gmail.com>
Message-ID: <CAL_JsqLs69=nr=2J_48N3VtD0qNRnxAgDU8uMRwY_Qqp6Dzs_Q@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] arm64: dts: sdm845: Add gpu and gmu device nodes
To: Viresh Kumar <viresh.kumar@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181219_120918_001803_77742D4E 
X-CRM114-Status: GOOD (  14.95  )
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
Cc: Nishanth Menon <nm@ti.com>, devicetree@vger.kernel.org,
 Rajendra Nayak <rnayak@codeaurora.org>,
 "open list:THERMAL" <linux-pm@vger.kernel.org>,
 Stephen Boyd <sboyd@kernel.org>, linux-arm-msm <linux-arm-msm@vger.kernel.org>,
 Doug Anderson <dianders@chromium.org>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 Jordan Crouse <jcrouse@codeaurora.org>, Viresh Kumar <vireshk@kernel.org>,
 freedreno <freedreno@lists.freedesktop.org>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Dec 18, 2018 at 10:49 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 18-12-18, 11:05, Doug Anderson wrote:
> > OK, it's fine with me to have the fallback, but if we do we should be
> > consistent about it and make sure it's in all the bindings and device
> > tree files...
>
> Sure.
>
> I am not sure what's the right way to do it is, i.e. should we keep the
> "operating-points-v2" string or not.

Does having it buy you anything? Given the QCom one doesn't have any
frequency or voltage, I don't see how it would be useful to have it.

Rob

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
