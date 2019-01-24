Return-Path: <SRS0=pdKw=QA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC143C282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 16:08:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB533217D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 16:08:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="SwniIiO2";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="CdeKsz+x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB533217D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=fM2uYhN5LDjN8Ya2JmogNVaig3VCm1uwyuKbrtg2ua4=; b=SwniIiO2ObOI9V
	Q5CArkHD4ZgIgYDT0iZqbM247hX6vxCeoi1VFQuzJcpKE3HJIFp+KRHOTlFY2MEaILX1p3cZz1nDG
	ttzQqQshdTgMNVrygORJwkY+AuA9rlWXMhYBXvGPnr0WkeprEGfBWZdeg3xxBvmJOeMU1378zWZRm
	4q32df9U2feXRvWDzWGn4eBMcqlOnli8AskSvbvVkkuNWpgQb/Xs+sqJQcCnyiMnDgrGc8F7eg7PU
	chBJuAap6sHkN/7zzKedQRP8vfMot5TwJBKGbx7/0I0a+6BJWRCAEhDWPSNAFoHP2pEU5PPmnbCpA
	ZhEYswkyfKdogAqswbsw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmhXu-0001Ov-82; Thu, 24 Jan 2019 16:08:02 +0000
Received: from mail-it1-x12b.google.com ([2607:f8b0:4864:20::12b])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmhXp-0001OR-Mk
 for linux-arm-kernel@lists.infradead.org; Thu, 24 Jan 2019 16:07:59 +0000
Received: by mail-it1-x12b.google.com with SMTP id i145so5742545ita.4
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 24 Jan 2019 08:07:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=CfqMya8cNE2lFI8ualNel3eZy5zxA/o3sGRDDR7Bixg=;
 b=CdeKsz+xhObP4Ls4Ub84++InJ+0tchvRa9SOGe6dBGpCbgdSbZD2P0u7Zyv7PO3cro
 QD8GQg3C6w9+WvpASpxkhCuYGOW9g1rcVFwMU3wUAytGzIVHIHvJFXkmWf2BVID/efWy
 +Jj7ccDW/+Yq/CGMSmuVsFBof0z5+k7uKQ1CE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=CfqMya8cNE2lFI8ualNel3eZy5zxA/o3sGRDDR7Bixg=;
 b=IC7VKqT2LqgQvFwOFo5Q4moq0kXbVAvJzp91QftQGVAXWPtanGKzFtuQ2j2t1op1py
 L8P4CJqMzwmsZKRFzeVapmTj8LvMN3qkgUO8YAClMJY0yyibC2FCfACmr77d5m2I4b//
 nAuuLdcQWvJlo03FvHEP9Hy33IaqD5qxIq13ETuOCTDlEhPqLq971898uVVK/kqNmBTK
 QwiN8T0idBIjZTfENOrxY3EpATHzOYyEas9h/pop+nOA/nVcLdiCnBY5coPK9tF8qHO6
 dzMMvrdTUGoj5IWQy6Yl3PbC80E6qHXxgnyuxtw8WmmerMQXPL0idS9KFoAYrZIT+CJt
 nhSA==
X-Gm-Message-State: AJcUukc5PnCzHIbpiPIxwIAOTO4zFFetYa03MbLRSXlgIojgQJ5xqZN7
 bL+dsWvdPOn/qfy59DLH/g5T9UKCYtKsnD78aOCrWQ==
X-Google-Smtp-Source: ALg8bN7q1K5kyGBzTvc5rOLxv0VqB+DG9pIwbNEBUeVYIK8ZPQp3Pqd65OSagxVyXYY7Nopq2Cxw7ibHulEDn4oB91w=
X-Received: by 2002:a24:fa04:: with SMTP id v4mr1570164ith.175.1548346076458; 
 Thu, 24 Jan 2019 08:07:56 -0800 (PST)
MIME-Version: 1.0
References: <cover.1548133311.git.saiprakash.ranjan@codeaurora.org>
 <ad16cfb9b6f5efb85149458d5f5a1abf43fa027c.1548133311.git.saiprakash.ranjan@codeaurora.org>
 <1bd39862-0725-70ce-6535-fdb59569f683@arm.com>
 <75ed74af-6946-b86d-092e-42dc16e55308@codeaurora.org>
 <91a90daa-9e14-2d2e-e633-2ddfdc0955bf@arm.com>
 <3906faf1-abbd-9c28-ad55-ed3800f06352@codeaurora.org>
 <c03b63bf-aca8-ea46-70ad-ee4558f0319e@arm.com>
 <5b54c6e0-7d22-ecee-486f-31333f49f84a@codeaurora.org>
 <CANLsYkxLJS-N0V4eOHM5rfe8MXMZHQApZFsDQns+DAS7xhGCoQ@mail.gmail.com>
 <71ae9f41-50ff-742b-3e12-ca2ce84e0d3c@codeaurora.org>
In-Reply-To: <71ae9f41-50ff-742b-3e12-ca2ce84e0d3c@codeaurora.org>
From: Mathieu Poirier <mathieu.poirier@linaro.org>
Date: Thu, 24 Jan 2019 09:07:45 -0700
Message-ID: <CANLsYkyeG4mZTJbFPnAsTNpt_2OBy5JYP6g80rbmZv-F8KTrUA@mail.gmail.com>
Subject: Re: [PATCHv4 1/4] arm64: dts: qcom: sdm845: Add Coresight support
To: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190124_080757_748343_FC2C5FC7 
X-CRM114-Status: GOOD (  25.41  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 Rajendra Nayak <rnayak@codeaurora.org>,
 Suzuki K Poulose <suzuki.poulose@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-arm-msm <linux-arm-msm@vger.kernel.org>,
 John Horley <john.horley@arm.com>, Doug Anderson <dianders@chromium.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 David Brown <david.brown@linaro.org>, Rob Herring <robh+dt@kernel.org>,
 Sibi Sankar <sibis@codeaurora.org>, Vivek Gautam <vivek.gautam@codeaurora.org>,
 Leo Yan <leo.yan@linaro.org>, Andy Gross <andy.gross@linaro.org>,
 Stephen Boyd <sboyd@kernel.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Good day Sai,

On Wed, 23 Jan 2019 at 13:18, Sai Prakash Ranjan
<saiprakash.ranjan@codeaurora.org> wrote:
>
> Hi Mathieu,
>
> On 1/24/2019 12:44 AM, Mathieu Poirier wrote:
> > On Wed, 23 Jan 2019 at 05:12, Sai Prakash Ranjan
> > <saiprakash.ranjan@codeaurora.org> wrote:
> >
> > That depends on whether the ETMs have been modified at all, something
> > Suzuki has asked to be clarified.  If ETMs have been modified then we
> > need to understand how they differ from the driver's implementation.
>
> We had asked hardware team for clarification regarding this. Let me
> poke them again. As for the driver, downstream implementation also
> uses the same driver, so I am not sure what do you mean by differing
> from the driver's implementation.

The driver has been implemented in accordance to ARM's coresight
technical reference manual and expects the HW to behave in accordance
to that specification.  Here we want to make sure the IP on your board
is conformant to the same specification.  If not then the driver needs
to be made flexible to handle both kind IPs.

>
> > If the implementations are the same:
> >
> >>
> >> @@ -1079,6 +1079,10 @@ static const struct amba_id etm4_ids[] = {
> >>           ETM4x_AMBA_ID(0x000bb95a),              /* Cortex-A72 */
> >>           ETM4x_AMBA_ID(0x000bb959),              /* Cortex-A73 */
> >>           ETM4x_AMBA_ID(0x000bb9da),              /* Cortex-A35 */
> >> +       ETM4x_AMBA_ID(0x000f0211),              /* Qualcomm Kryo */
> >> +       ETM4x_AMBA_ID(0x000f0205),              /* Qualcomm Kryo */
> >
> > What version of the Kryo CPU?  And the above will need to be in a
> > separate patch with the modifications to address the problem you
> > mentionned below.
> >
>
> There is no Kryo version for MSM8996 (its only given as Kryo), MSM8998
> onwards we have Kryo versions like Kryo 280 and so on. Hence I skipped
> for this one and added the version for SDM845.

Very well.

Mathieu

>
> >> +       ETM4x_AMBA_ID(0x000bb803),              /* Qualcomm Kryo 385
> >> Cortex-A75 */
> >> +       ETM4x_AMBA_ID(0x000bb802),              /* Qualcomm Kryo 385
> >> Cortex-A55 */
> >
> > Please add them in chronological order.
> >
>
> Sure, will do it.
>
> >>           {},
> >>    };
> >>
> >> For msm8996, cpu debug module pid returned is same as ETM
> >> which is causing the probe failure for cpu debug coresight module
> >> as shown in below logs.
> >> For this case, I tried adding these ids to cpu debug driver, but it
> >> splits some errors (coresight-cpu-debug: probe of 3840000.etm failed
> >> with error -16) since the ids are same. Can we override for this case
> >> or there is something else we can do here?
> >
> > That is another problem.  See this patchset [1] from Mike Leach for a
> > description of the problem and how to fix it.
> >
> > [1]. https://lkml.org/lkml/2018/12/7/784
> >
>
> Thanks a lot for this link. I will check this out.
>
> - Sai
>
> --
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
> of Code Aurora Forum, hosted by The Linux Foundation

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
