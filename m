Return-Path: <SRS0=uP4V=P7=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 797B2C282C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 19:14:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D95921872
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 19:14:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="av3CXJ5a";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="gK7e2Hdo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D95921872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=vGDbW1b/2yCR+GHrcGQ7Cl0D9EwMxA7p4bo6rlIS4ro=; b=av3CXJ5aYCo2dR
	FJ7DlQD8mcgnQIoVuMmIKrbb5q9UE4LlRqsnUnZX9fbA3bETy9bPe65jKCq0O6nlHxPuQZB505Bqi
	jmxV7BM8xR7Sfc+6OLLiEBlwuyiT77HX0XYKbEMaQNucGCI7Zb5BBSkSzxSrBhrDM0HEvvZ3TPwaP
	fSwEsj1BeQy6kmgglAv718IRGSP0r21nsaEosztrfB3c/yRQ5RW7JN174x7qlXaF1xDIxc09P9hAm
	5VXW6MJ15OysQ1CKh8IWjmTIcHmZ7Zi5LMTR5W7qq4AuNHliJ4jj3/BkvJzoS87M2qlQDeo2+mU0i
	0vV0VS6hbaC/rRIPjjJQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmNzB-0000Dt-NG; Wed, 23 Jan 2019 19:14:53 +0000
Received: from mail-it1-x136.google.com ([2607:f8b0:4864:20::136])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmNz7-00009j-8j
 for linux-arm-kernel@lists.infradead.org; Wed, 23 Jan 2019 19:14:51 +0000
Received: by mail-it1-x136.google.com with SMTP id h193so753756ita.5
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 23 Jan 2019 11:14:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=u7p8/NPM4EuC6yoRUQ/OS305vumWSzl0Ko+ELPgkusU=;
 b=gK7e2HdoKNCFbDQR572R67Uil//vu7Ls8qCu8PPDIR7SqxTw0V/0kxxFYEWHuU+g13
 I0UmI3c8lTGZcsbRoHk2uVzhofrZ5n0N7nupRMIu1LDxJZr4hdOPsasbxtPHUESLyPli
 kqJFgv+nKbH7FH7caG4vMalt9vT61WwBIWE3o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=u7p8/NPM4EuC6yoRUQ/OS305vumWSzl0Ko+ELPgkusU=;
 b=dLtbPhftv7gu0G5Ws+BCSmsTitvo3SccEkDTGzQPSc5EqPNtmr7+M7DZnKFHK2a3Pc
 RzSAt1Sm+NAeAvqubXpUrTcnexSZbJ8ngp1P/eG4aZNheXr2sFYyFBvLh+BkHYUN7Low
 c5qxSE7mWrOsCIZLtYZ2ChqHUrbcRpYkIfjeRZ90a81plsUsVDxw96OatX4xsq5hMOaC
 L18Vjm28vW3Q9A88vjF0tleLgbru22ZHhLz1VC9WJyDC0sexl4eFO6c6wpseeJ4w4LMV
 Om0KuG/PtiDhV6xTzYHGOxBUfsRhVHPFuNzXEa7eqzqZVv7GhBoElrOzNemQych3lHES
 Tpnw==
X-Gm-Message-State: AHQUAuaC8UFvUBcr/OtARFXfo0gBzHDm65TpE36v14bKqKR0BO5AkgyZ
 xCRaJoziivkbLOeZEEktEMbgZ/H5kY7AiCcnOBVciw==
X-Google-Smtp-Source: AHgI3IYZ0Uw2ywycGLzyuhZ/J6y2ZSlpNy/JSBq3YyKTupxGZeDHD4fcUdXlJ1lkhTDqBB9+kCC5taWYoX5w6lyG7Vo=
X-Received: by 2002:a05:660c:34f:: with SMTP id
 b15mr2534695itl.146.1548270886986; 
 Wed, 23 Jan 2019 11:14:46 -0800 (PST)
MIME-Version: 1.0
References: <cover.1548133311.git.saiprakash.ranjan@codeaurora.org>
 <ad16cfb9b6f5efb85149458d5f5a1abf43fa027c.1548133311.git.saiprakash.ranjan@codeaurora.org>
 <1bd39862-0725-70ce-6535-fdb59569f683@arm.com>
 <75ed74af-6946-b86d-092e-42dc16e55308@codeaurora.org>
 <91a90daa-9e14-2d2e-e633-2ddfdc0955bf@arm.com>
 <3906faf1-abbd-9c28-ad55-ed3800f06352@codeaurora.org>
 <c03b63bf-aca8-ea46-70ad-ee4558f0319e@arm.com>
 <5b54c6e0-7d22-ecee-486f-31333f49f84a@codeaurora.org>
In-Reply-To: <5b54c6e0-7d22-ecee-486f-31333f49f84a@codeaurora.org>
From: Mathieu Poirier <mathieu.poirier@linaro.org>
Date: Wed, 23 Jan 2019 12:14:35 -0700
Message-ID: <CANLsYkxLJS-N0V4eOHM5rfe8MXMZHQApZFsDQns+DAS7xhGCoQ@mail.gmail.com>
Subject: Re: [PATCHv4 1/4] arm64: dts: qcom: sdm845: Add Coresight support
To: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190123_111449_318097_11DA7CE8 
X-CRM114-Status: GOOD (  24.91  )
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

On Wed, 23 Jan 2019 at 05:12, Sai Prakash Ranjan
<saiprakash.ranjan@codeaurora.org> wrote:
>
> Hi Suzuki,
>
> On 1/23/2019 1:42 AM, Suzuki K Poulose wrote:
> > Hi Sai,
> >
> > On 01/22/2019 04:48 PM, Sai Prakash Ranjan wrote:
> >> Hi Suzuki,
> >>
> [..]
> >>
> >> SDM845 has 4 Kryo 385 Gold (ARM A75) + 4 Kryo 385 Silver (ARM A55),
> >> so the PID values should be same for 4 ETMs atleast. But here one
> >> pid value(001bb803) is same for 6 ETMs and other one for 2
> >> ETMs(001bb802) which seems odd and hence the doubt if these pids
> >> are even valid ones.
> >
> > Have you checked other SoCs with A55 for the ETM PID ? The drivers
> > usually only care about PID0[7-0], PID1[7-0], PID2[3-0] and ignores
> > the other fields that may change over revisions of the core. So, in your
> > case the ETM ID could be treated as 0xbb802 and 0xbb803.
> >
>
> Very sorry to have mislead you here. I checked again today on SDM845 and
> as you said 4 ETMs based on A75 has 0xbb803 and other 4 ETMs based on
> A55 has 0Xbb803. I wrongly mentioned it as 6 and 2.
>
> [    6.688809] resname=etm@7040000 pid = 0x1bb803
> [    6.694957]
> [    6.694957] resname=etm@7140000 pid = 0x1bb803
> [    6.701135]
> [    6.701135] resname=etm@7240000 pid = 0x1bb803
> [    6.707256]
> [    6.707256] resname=etm@7340000 pid = 0x1bb803
> [    6.713454]
> [    6.713454] resname=etm@7440000 pid = 0x1bb802
> [    6.719621]
> [    6.719621] resname=etm@7540000 pid = 0x1bb802
> [    6.725814]
> [    6.725814] resname=etm@7640000 pid = 0x1bb802
> [    6.731971]
> [    6.731971] resname=etm@7740000 pid = 0x1bb802
>

Ok, so that makes sense.

> So is it ok to add these to table as below in etm4x driver with the
> following comment since these do not exactly match A75 and A55 PIDs
> which you provided? Or any other way you prefer?

That depends on whether the ETMs have been modified at all, something
Suzuki has asked to be clarified.  If ETMs have been modified then we
need to understand how they differ from the driver's implementation.
If the implementations are the same:

>
> @@ -1079,6 +1079,10 @@ static const struct amba_id etm4_ids[] = {
>          ETM4x_AMBA_ID(0x000bb95a),              /* Cortex-A72 */
>          ETM4x_AMBA_ID(0x000bb959),              /* Cortex-A73 */
>          ETM4x_AMBA_ID(0x000bb9da),              /* Cortex-A35 */
> +       ETM4x_AMBA_ID(0x000f0211),              /* Qualcomm Kryo */
> +       ETM4x_AMBA_ID(0x000f0205),              /* Qualcomm Kryo */

What version of the Kryo CPU?  And the above will need to be in a
separate patch with the modifications to address the problem you
mentionned below.

> +       ETM4x_AMBA_ID(0x000bb803),              /* Qualcomm Kryo 385
> Cortex-A75 */
> +       ETM4x_AMBA_ID(0x000bb802),              /* Qualcomm Kryo 385
> Cortex-A55 */

Please add them in chronological order.

>          {},
>   };
>
> For msm8996, cpu debug module pid returned is same as ETM
> which is causing the probe failure for cpu debug coresight module
> as shown in below logs.
> For this case, I tried adding these ids to cpu debug driver, but it
> splits some errors (coresight-cpu-debug: probe of 3840000.etm failed
> with error -16) since the ids are same. Can we override for this case
> or there is something else we can do here?

That is another problem.  See this patchset [1] from Mike Leach for a
description of the problem and how to fix it.

[1]. https://lkml.org/lkml/2018/12/7/784


>
> [    5.480629] resname=debug@3810000 pid = 0x102f0211
> [    5.480920] OF: graph: no port node found in /soc/debug@3810000
> [    5.513214] coresight-etm4x: probe of 3810000.debug failed with error -22
> [    5.524362]
> [    5.524362] resname=debug@3910000 pid = 0x102f0211
> [    5.524888] OF: graph: no port node found in /soc/debug@3910000
> [    5.537586] coresight-etm4x: probe of 3910000.debug failed with error -22
> [    5.541481]
> [    5.549643] resname=debug@3a10000 pid = 0x102f0205
> [    5.580990] OF: graph: no port node found in /soc/debug@3a10000
> [    5.586817] coresight-etm4x: probe of 3a10000.debug failed with error -22
> [    5.592082]
> [    5.592629] resname=debug@3b10000 pid = 0x102f0205
> [    5.604922] OF: graph: no port node found in /soc/debug@3b10000
> [    5.611234] coresight-etm4x: probe of 3b10000.debug failed with error -22
>
>
> Thanks,
> Sai
>
> --
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
> of Code Aurora Forum, hosted by The Linux Foundation

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
