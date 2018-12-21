Return-Path: <SRS0=7qzz=O6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 356B6C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 04:52:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F002B21903
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 04:52:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="U+HL7VIm";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="fXLKibka";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="c703VULh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F002B21903
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=QZt4PEdwpkH1jPMof6w81V5ASL2QoOJSMxtBmar+Dsg=; b=U+HL7VIm17zH4mk/DxzbbNwzE
	9QiunpNxwCIaUrzgxPgucQJhcUrO+7a7t28712SWBnM/8f0mYed5h2m1drX9pc18lwZmM5cvKhsni
	R2ihhCv3k89TLCHH34lqsT+E1ESuQ26YOx0yf8lLIFWd9lVuINpNyfeMRHCnx5v2pnXKx3wli/fgM
	XT5l91Gcs846WQEuJ2NqQ6D9h0emEIr2wQ5qF+O5T4Hh9O84zVocCyUsvV/KEHbNeB0wIegM6mDBz
	IQsHhM89OvVWV7D0NkkYTop4aozEdQEMfniFILYeRNR1lf3VqhxeQ28NFd7nLqMqEwLGb5vseyzk9
	JWaviqNGw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gaCnu-0002Ie-HB; Fri, 21 Dec 2018 04:52:54 +0000
Received: from smtp.codeaurora.org ([198.145.29.96])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gaCnr-0002Hx-CY
 for linux-arm-kernel@lists.infradead.org; Fri, 21 Dec 2018 04:52:52 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
 id 778DB608CB; Fri, 21 Dec 2018 04:52:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1545367960;
 bh=sNMo1QafWHCFO/BSuU1MVIVlWEyuFPAYuHp6pRtfTRE=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=fXLKibkaRsNPnBLWRrqFivxfV4cEZ6yHBrpZpvpoHIRNNBO2Rg0wBfLLiAxMwTr3k
 NOIRxRBVoLyEAU74v2i9Ctz4NFi7MksUM/AWidciWjK+aiaO1/0GKWY0/f4wzlB3D5
 4l+UrV4n7xbXpUtYF2aRDYRIMF50L+xvQ/0C7BEk=
Received: from [10.79.128.147]
 (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: rnayak@smtp.codeaurora.org)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id 5172C60588;
 Fri, 21 Dec 2018 04:52:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1545367959;
 bh=sNMo1QafWHCFO/BSuU1MVIVlWEyuFPAYuHp6pRtfTRE=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=c703VULhi+mug9XjJsap0g/CJIkVfgt8oLrAHlEAfkSFp3x8EXTv5D2QbrzayztQB
 Srwxy0GehV7098Iad9hpLDi3zL0Ip8E4cD7pDis6EmZ6zTUOPplFmLzO8qO3nD6xon
 SeL2GPYbvKKye6u2bj9QSqwPYNBG/CSouV2czWF4=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5172C60588
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
 spf=none smtp.mailfrom=rnayak@codeaurora.org
Subject: Re: [PATCH v6 2/2] arm64: dts: sdm845: Add gpu and gmu device nodes
To: Stephen Boyd <sboyd@kernel.org>, Doug Anderson <dianders@chromium.org>,
 Rob Herring <robh@kernel.org>
References: <20181212211848.26768-1-jcrouse@codeaurora.org>
 <20181217070647.xtvfgsixggua5yod@vireshk-i7>
 <CAD=FV=WKfKyZe6sc4drfa9kLQVbG1b9nCe6qbPmUPQGNEKAh=Q@mail.gmail.com>
 <154515840025.238328.5075439774176447808@swboyd.mtv.corp.google.com>
 <CAD=FV=XeFYmOJx9Wxy7hLQwSq1GoF84eQ93Y4KgrO1JM-g9ZiA@mail.gmail.com>
 <20181219044901.x76bd5vdsznhhrmz@vireshk-i7>
 <CAL_JsqLs69=nr=2J_48N3VtD0qNRnxAgDU8uMRwY_Qqp6Dzs_Q@mail.gmail.com>
 <CAD=FV=VMMYKoW4RU_TTjLdyrNcWZU-Gyou9b6qynKFX9wDn5Mw@mail.gmail.com>
 <CAD=FV=Utko6B6OycYpef3OQAF1v-rthcdgAKMm0GLxRM4=ummg@mail.gmail.com>
 <CAL_Jsq+U8Vj4+w6jA+B3_CyG8N==ABbw31nm+LE=6pwXEopApw@mail.gmail.com>
 <154534136449.79149.14097954220921296509@swboyd.mtv.corp.google.com>
From: Rajendra Nayak <rnayak@codeaurora.org>
Message-ID: <7e310416-78d3-b7e5-5013-0bcc8bfd0351@codeaurora.org>
Date: Fri, 21 Dec 2018 10:22:34 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <154534136449.79149.14097954220921296509@swboyd.mtv.corp.google.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181220_205251_464259_9A560BFE 
X-CRM114-Status: GOOD (  21.77  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


On 12/21/2018 2:59 AM, Stephen Boyd wrote:
> Quoting Rob Herring (2018-12-19 15:47:25)
>> On Wed, Dec 19, 2018 at 4:40 PM Doug Anderson <dianders@chromium.org> wrote:
>>> On Wed, Dec 19, 2018 at 12:40 PM Doug Anderson <dianders@chromium.org> wrote:
>>>> On Wed, Dec 19, 2018 at 12:09 PM Rob Herring <robh@kernel.org> wrote:
>>>> ...but it does have a frequency, doesn't it?
>>>>
>>>> +   compatible = "operating-points-v2-qcom-level";
>>>> +
>>>> +   opp-710000000 {
>>>> +     opp-hz = /bits/ 64 <710000000>;
>>>> +     qcom,level = <RPMH_REGULATOR_LEVEL_TURBO_L1>;
>>>> +   };
>>>
>>> Ah, I perhaps see the confusion.  So Rajendra's usage of
>>> "operating-points-v2-qcom-level" [1] doesn't have a frequency but
>>> Jordan's do.  So I guess it makes sense that Jordan's have the
>>> fallback compatible but Rajendra's don't?
>>
>> Is having it useful to s/w that doesn't understand
>> "operating-points-v2-qcom-level"? If so, then add
>> "operating-points-v2". If not, then don't.
> 
> The only benefit I see in having "operating-points-v2" is that we don't
> need to update the of_skipped_node_table[] in drivers/platform/of.c to
> have all the variants of operating-points-v2-* when they decide to not
> use anything from the "base" binding.
> 
> If that fails to work because opp-hz is required for the
> "operating-points-v2" binding but sometimes
> operating-points-v2-qcom-level doesn't require it I guess we need to
> update the skip table or make some generic property like
> 'this-is-not-a-device' that these various data tables in DT can be
> marked with so we don't make platform devices for them.
> 
> Regardless of the above, we should update the binding for
> operating-points-v2-qcom-level to say that opp-hz isn't always required
> when the qcom-level compatible is present. It looks like it just says
> that it builds on top of the opp binding so that's not obvious.

Sure, I can respin with those details added in.
So I am guessing the conclusion is to use a fallback "operating-points-v2"
compatible *only* when we do have opp-hz along with qcom,level (as in the
case with gpu) and not have a fallback compatible in cases when we don't
have opp-hz (as in the case of rpm power domains)?
That seems a little inconsistent, and given Rob said either way is fine,
just do one way or the other and not both, I am inclined to think we should
just have a "operating-points-v2-qcom-level" and no fallback compatible.
Does that make sense?

> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
