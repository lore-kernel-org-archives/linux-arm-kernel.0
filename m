Return-Path: <SRS0=jr7z=PG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 112A3C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 01:30:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF1AF21903
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 01:30:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gXYMMe3N";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="r9ZoOIp2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF1AF21903
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:In-Reply-To:From:Subject:
	References:Message-ID:To:MIME-Version:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=2ZySWSAVFUZCwnEqVpokZUBA31oWmc0jgzF8NFv/QkU=; b=gXYMMe3Nl1ZkQN
	hDK3vD2dCLScTzGQaHS0EcjLJTA/yup9eFQvGwjqzg/tsuyi3jZmySDWE7cJMe9zMOsRLlu1JoCHG
	ONIjdwODrNgCbU/8RLTE8d6G9P6Rxq81Ra2Z1wiDc2MJh7S/LLw6RkQW/IDGYWkVvhsfuZL+XJIwz
	gD0FQC4C+gzvTRow/EYSjrfrqdfz4JE8M9hlOi0kv/+NTVrIMyhtSMOdei0p4wGAt48HIPbwNxL2E
	7SJ37ep9x/6Fz6GvR9oQszFAPk3YGBcTLDN/kZvWDrMuhWGD39XrYREAm+vAwhiuGx3SI9ipoznvQ
	wcl7Dg/WrBp3G1sL7Mdg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gd3Rv-0003U1-KJ; Sat, 29 Dec 2018 01:29:59 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gd3Rr-0003QA-4t
 for linux-arm-kernel@lists.infradead.org; Sat, 29 Dec 2018 01:29:56 +0000
Received: from localhost (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 071BC21901;
 Sat, 29 Dec 2018 01:29:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1546046983;
 bh=+cPveaJ/AE03we/2OX+v+Rhq/LzM03/V1rCFaFoZak4=;
 h=To:References:Subject:Cc:From:In-Reply-To:Date:From;
 b=r9ZoOIp2jbQeayHlDtEbMviHKrQu+WaTUOMFsTin6mgFrhuC+M2h8HMRx9grtahtE
 PY/6A7gVuzU6Ha67uk+QrXQzeMQrl1UwvlCLY/7PJIsxsjkB3jC3uOcNfW9eo7nd1t
 tw/SRnAnGgHNTTSjdo3ronLzIZJ8Vjfb+3UgsKcA=
MIME-Version: 1.0
To: Doug Anderson <dianders@chromium.org>,
 Rajendra Nayak <rnayak@codeaurora.org>, Rob Herring <robh@kernel.org>
Message-ID: <154604698217.179992.9966831118584978893@swboyd.mtv.corp.google.com>
References: <20181212211848.26768-1-jcrouse@codeaurora.org>
 <154515840025.238328.5075439774176447808@swboyd.mtv.corp.google.com>
 <CAD=FV=XeFYmOJx9Wxy7hLQwSq1GoF84eQ93Y4KgrO1JM-g9ZiA@mail.gmail.com>
 <20181219044901.x76bd5vdsznhhrmz@vireshk-i7>
 <CAL_JsqLs69=nr=2J_48N3VtD0qNRnxAgDU8uMRwY_Qqp6Dzs_Q@mail.gmail.com>
 <CAD=FV=VMMYKoW4RU_TTjLdyrNcWZU-Gyou9b6qynKFX9wDn5Mw@mail.gmail.com>
 <CAD=FV=Utko6B6OycYpef3OQAF1v-rthcdgAKMm0GLxRM4=ummg@mail.gmail.com>
 <CAL_Jsq+U8Vj4+w6jA+B3_CyG8N==ABbw31nm+LE=6pwXEopApw@mail.gmail.com>
 <154534136449.79149.14097954220921296509@swboyd.mtv.corp.google.com>
 <7e310416-78d3-b7e5-5013-0bcc8bfd0351@codeaurora.org>
Subject: Re: [PATCH v6 2/2] arm64: dts: sdm845: Add gpu and gmu device nodes
From: Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.8
In-Reply-To: <7e310416-78d3-b7e5-5013-0bcc8bfd0351@codeaurora.org>
Date: Fri, 28 Dec 2018 17:29:42 -0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181228_172955_225934_E3C3FAB2 
X-CRM114-Status: GOOD (  22.19  )
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

Quoting Rajendra Nayak (2018-12-20 20:52:34)
> 
> On 12/21/2018 2:59 AM, Stephen Boyd wrote:
> > Quoting Rob Herring (2018-12-19 15:47:25)
> >> On Wed, Dec 19, 2018 at 4:40 PM Doug Anderson <dianders@chromium.org> wrote:
> >>> On Wed, Dec 19, 2018 at 12:40 PM Doug Anderson <dianders@chromium.org> wrote:
> >>>> On Wed, Dec 19, 2018 at 12:09 PM Rob Herring <robh@kernel.org> wrote:
> >>>> ...but it does have a frequency, doesn't it?
> >>>>
> >>>> +   compatible = "operating-points-v2-qcom-level";
> >>>> +
> >>>> +   opp-710000000 {
> >>>> +     opp-hz = /bits/ 64 <710000000>;
> >>>> +     qcom,level = <RPMH_REGULATOR_LEVEL_TURBO_L1>;
> >>>> +   };
> >>>
> >>> Ah, I perhaps see the confusion.  So Rajendra's usage of
> >>> "operating-points-v2-qcom-level" [1] doesn't have a frequency but
> >>> Jordan's do.  So I guess it makes sense that Jordan's have the
> >>> fallback compatible but Rajendra's don't?
> >>
> >> Is having it useful to s/w that doesn't understand
> >> "operating-points-v2-qcom-level"? If so, then add
> >> "operating-points-v2". If not, then don't.
> > 
> > The only benefit I see in having "operating-points-v2" is that we don't
> > need to update the of_skipped_node_table[] in drivers/platform/of.c to
> > have all the variants of operating-points-v2-* when they decide to not
> > use anything from the "base" binding.
> > 
> > If that fails to work because opp-hz is required for the
> > "operating-points-v2" binding but sometimes
> > operating-points-v2-qcom-level doesn't require it I guess we need to
> > update the skip table or make some generic property like
> > 'this-is-not-a-device' that these various data tables in DT can be
> > marked with so we don't make platform devices for them.
> > 
> > Regardless of the above, we should update the binding for
> > operating-points-v2-qcom-level to say that opp-hz isn't always required
> > when the qcom-level compatible is present. It looks like it just says
> > that it builds on top of the opp binding so that's not obvious.
> 
> Sure, I can respin with those details added in.

Ok.

> So I am guessing the conclusion is to use a fallback "operating-points-v2"
> compatible *only* when we do have opp-hz along with qcom,level (as in the
> case with gpu) and not have a fallback compatible in cases when we don't
> have opp-hz (as in the case of rpm power domains)?
> That seems a little inconsistent, and given Rob said either way is fine,
> just do one way or the other and not both, I am inclined to think we should
> just have a "operating-points-v2-qcom-level" and no fallback compatible.
> Does that make sense?
> 

Are you going to update the skip table to not create platform devices?
Or introduce some generic property to indicate that this is just data
and not a device node?


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
