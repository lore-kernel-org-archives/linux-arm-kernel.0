Return-Path: <SRS0=E6Hv=PM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6155DC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 20:59:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E64921871
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 20:59:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="OrDyP3IA";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="LqMTssJm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E64921871
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:Message-ID:References:From:
	In-Reply-To:To:Subject:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=0U6GHojtmRdiTFmwjjvaWXi1wg8bEwmQEy5I6kSJg/8=; b=OrDyP3IAvup3D/
	kE2CZ4LOFaH6MUPRy/3WB5e/5jagTwA6/UgAdaWWvUMZRRrFHB8TZizzoIIoSG5juX96iSF1XwR3h
	C4nnQibd+QtalKhU85etH+55opbFOJhSgajxl7I/IpgAy8sedFW9bsHIlnDAxEXKtSie+Ta9ANzHI
	sG03Mla/xE9Xx7Av4PSo1/d7dzGxUcEydyRfD05msfHsXPj9SuMOCxVw6Hzj7BAlVPQXZKHrY0b/R
	H2zXmQWevsSUydo25z8gxVWppBxVXObk6irqB77AzwMHtHBAwdgDNRIUjnyg2OOF0jSosksCZhEqg
	Sy7OWMHfFaLbiAfrqDoA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gfWYe-0008Fi-A8; Fri, 04 Jan 2019 20:59:08 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gfWYa-0008FG-8P
 for linux-arm-kernel@lists.infradead.org; Fri, 04 Jan 2019 20:59:05 +0000
Received: from localhost (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id C2EC721871;
 Fri,  4 Jan 2019 20:59:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1546635543;
 bh=tj2D7BDN2BjaUyI4mPAQOqmCU0AcW4hOhI5d60nLdeo=;
 h=Subject:Cc:To:In-Reply-To:From:References:Date:From;
 b=LqMTssJmVSzZJ4Yi+N1ZulxJsQWn1LWF/UmSBKHCc4gDS0T2Bc2VTpG+F+9Cj0XGH
 qymDRv3Z8ks+hg+x8WFidWoF5OABDj1tk/sJEQUtHZWDrNknx6pPHzE3qA/ha9HIrh
 6vId4ejtMXZZ55MlwGkPfyAv70Kv3RyML5ZIPOKM=
MIME-Version: 1.0
Subject: Re: [PATCH v6 2/2] arm64: dts: sdm845: Add gpu and gmu device nodes
To: Doug Anderson <dianders@chromium.org>,
 Rajendra Nayak <rnayak@codeaurora.org>, Rob Herring <robh@kernel.org>
In-Reply-To: <dcb3e046-d0bd-af68-e42d-1db0db3bf2df@codeaurora.org>
From: Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.8
References: <20181212211848.26768-1-jcrouse@codeaurora.org>
 <20181219044901.x76bd5vdsznhhrmz@vireshk-i7>
 <CAL_JsqLs69=nr=2J_48N3VtD0qNRnxAgDU8uMRwY_Qqp6Dzs_Q@mail.gmail.com>
 <CAD=FV=VMMYKoW4RU_TTjLdyrNcWZU-Gyou9b6qynKFX9wDn5Mw@mail.gmail.com>
 <CAD=FV=Utko6B6OycYpef3OQAF1v-rthcdgAKMm0GLxRM4=ummg@mail.gmail.com>
 <CAL_Jsq+U8Vj4+w6jA+B3_CyG8N==ABbw31nm+LE=6pwXEopApw@mail.gmail.com>
 <154534136449.79149.14097954220921296509@swboyd.mtv.corp.google.com>
 <7e310416-78d3-b7e5-5013-0bcc8bfd0351@codeaurora.org>
 <154604698217.179992.9966831118584978893@swboyd.mtv.corp.google.com>
 <dcb3e046-d0bd-af68-e42d-1db0db3bf2df@codeaurora.org>
Message-ID: <154663554289.15366.16011609839106849298@swboyd.mtv.corp.google.com>
Date: Fri, 04 Jan 2019 12:59:02 -0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190104_125904_320955_F4C42412 
X-CRM114-Status: GOOD (  13.13  )
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
 "open list:THERMAL" <linux-pm@vger.kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 Jordan Crouse <jcrouse@codeaurora.org>,
 linux-arm-msm <linux-arm-msm@vger.kernel.org>,
 freedreno <freedreno@lists.freedesktop.org>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>, Viresh Kumar <vireshk@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Quoting Rajendra Nayak (2019-01-03 00:45:53)
> 
> On 12/29/2018 6:59 AM, Stephen Boyd wrote:
> >> So I am guessing the conclusion is to use a fallback "operating-points-v2"
> >> compatible*only*  when we do have opp-hz along with qcom,level (as in the
> >> case with gpu) and not have a fallback compatible in cases when we don't
> >> have opp-hz (as in the case of rpm power domains)?
> >> That seems a little inconsistent, and given Rob said either way is fine,
> >> just do one way or the other and not both, I am inclined to think we should
> >> just have a "operating-points-v2-qcom-level" and no fallback compatible.
> >> Does that make sense?
> >>
> > Are you going to update the skip table to not create platform devices?
> > Or introduce some generic property to indicate that this is just data
> > and not a device node?
> 
> Is any of it really needed, given the bindings specify that the OPP table
> should actually be a child node of the device/power domain supporting
> it? I don't see who would end up creating platform devices for them.
> 

Good point. If it's a child node then almost all the time we won't be
trying to populate the OPP node as another platform device so this isn't
really important to handle until that happens, which is probably never.


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
