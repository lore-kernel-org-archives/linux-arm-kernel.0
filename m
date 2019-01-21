Return-Path: <SRS0=flTa=P5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B805CC3712F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 21:37:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 846ED21721
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 21:37:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rFjEM0Se";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="VafRxOSp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 846ED21721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=scaXW7YXb3Ei3DiqT7/qW373td/L9HqG0bpMEHwvDRs=; b=rFjEM0Se58XrCO
	2RaUHsE4hCuB8IIU614j4vmYnoUzRXOplFxXOyyhKp1plCK12VlKUmueE9xX1D3frT/mxPBcN7bV0
	gv4SSB6/64sF2+T7jDxDKPDnoWuma9ezXP33E/LGRCSz0h2n7XotiwRo50lhU5GmRRbSHdsDz0PvQ
	gAi9fdat1fQ4x3STUWKnDbpqoKCd0GN5DMPDqQrf2N1eV4Cg1nwzNay/ckrt8TM4/Uqvu1jGEm1M2
	tbpibInyGQtZJXw7yM38WmD413ubkSmCyCocTFi/kqstsR9cl5YshGb3TnRsLcoG4b544pJt1oONZ
	D++5n3pxlabW6UwUlBJw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glhGO-0001qZ-GH; Mon, 21 Jan 2019 21:37:48 +0000
Received: from mail-io1-xd43.google.com ([2607:f8b0:4864:20::d43])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glhGK-0001qD-MW
 for linux-arm-kernel@lists.infradead.org; Mon, 21 Jan 2019 21:37:46 +0000
Received: by mail-io1-xd43.google.com with SMTP id g8so17515228iok.4
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 21 Jan 2019 13:37:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=8hsPLb+YVxxq1iAPjhdrsVW0TYSbk8tR9OwWdd6vyzE=;
 b=VafRxOSpCYUSBK7FET5zdnwyCl/ozjapVhWrY2P+i1eQJchzbea9mwTb5G5WBTKBjz
 rrgKscDG8lEqO2hPOouoq777O/+ofIMzpm56Ot/peyyc0xR//f3+IZreLvNb9id6Wmuq
 7GW58hspu4k6od70xVdy35jTkoQlSdOJyF3lQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=8hsPLb+YVxxq1iAPjhdrsVW0TYSbk8tR9OwWdd6vyzE=;
 b=tjFA4OQOUf8vY+t2/DuQzhmSWLFG9r7Qt3V7pEDvx/qfNj5DUSqOuJh2fQ9dJhvqxr
 bKStSgV5HylNXecRXUnp13DzkWkMTprmDdj+WwzV6XHn23A0uT+Zi8k22IbyDak72YmC
 1+P5fTvvBMAOFyuAWBukqJq2D33V/NWFvsNSgFD36YCPabJmLPfUcSKnDOQJWOJqEFVE
 ae1BQZDJ8KUcLrYA1VdpBvvNurK+214ojywOVTQq8B2f1DIG6DkGcBO0IN7HoH9k3Xym
 sf7hH90Y5Haj/q5czoIhzUPNc0reHsfh31FaWAN71yw9l1/zsJQFTP/ND0bMXCgpyZp7
 7aQA==
X-Gm-Message-State: AJcUukfQ8qq+XzaxPvUVj2slb9RTivOXvMbBs5pgV3qQfJfiJM7kMWlw
 KXj0n2hkhancFp3LsuxBTeLKaQ4FRQvJOKnMBDd64A==
X-Google-Smtp-Source: ALg8bN4a5xfHBNLlF9UDwiMCQBHS8irpSBxYfKNdlG1HNBebRO4B3EVu2zVZmUXDe/kzQyizUkAfJXwChn0xSCtIhKA=
X-Received: by 2002:a5d:9459:: with SMTP id x25mr6434890ior.293.1548106663208; 
 Mon, 21 Jan 2019 13:37:43 -0800 (PST)
MIME-Version: 1.0
References: <cover.1547813804.git.saiprakash.ranjan@codeaurora.org>
 <d52546764f8570e8c07ac8e3e2841e087e66648c.1547813804.git.saiprakash.ranjan@codeaurora.org>
 <cc71cfa9-8a11-9356-ac41-e27564a9f7b4@codeaurora.org>
 <20190121184831.GB14049@xps15>
In-Reply-To: <20190121184831.GB14049@xps15>
From: Mathieu Poirier <mathieu.poirier@linaro.org>
Date: Mon, 21 Jan 2019 14:37:32 -0700
Message-ID: <CANLsYkw5h+-fWhiit+kNJHnGPF__Bz1MHc94sG=WOyfTPHi_NQ@mail.gmail.com>
Subject: Re: [PATCHv3 3/4] coresight: etm4x: Add support to enable ETMv4.2
To: Vivek Gautam <vivek.gautam@codeaurora.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190121_133744_745260_879E0AEC 
X-CRM114-Status: GOOD (  23.65  )
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
 Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
 Rajendra Nayak <rnayak@codeaurora.org>,
 Suzuki K Poulose <suzuki.poulose@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-arm-msm <linux-arm-msm@vger.kernel.org>,
 Doug Anderson <dianders@chromium.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 David Brown <david.brown@linaro.org>, Rob Herring <robh+dt@kernel.org>,
 Sibi Sankar <sibis@codeaurora.org>, Leo Yan <leo.yan@linaro.org>,
 Andy Gross <andy.gross@linaro.org>, Stephen Boyd <sboyd@kernel.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, 21 Jan 2019 at 11:48, Mathieu Poirier
<mathieu.poirier@linaro.org> wrote:
>
> On Mon, Jan 21, 2019 at 04:18:36PM +0530, Vivek Gautam wrote:
> >
> > On 1/18/2019 5:52 PM, Sai Prakash Ranjan wrote:
> > > SDM845 has ETMv4.2 and can use the existing etm4x driver.
> > > But the current etm driver checks only for ETMv4.0 and
> > > errors out for other etm4x versions. This patch adds this
> > > missing support to enable SoC's with ETMv4x to use same
> > > driver by checking only the ETM architecture major version
> > > number.
> > >
> > > Without this change, we get below error during etm probe:
> > >
> > > / # dmesg | grep etm
> > > [    6.660093] coresight-etm4x: probe of 7040000.etm failed with error -22
> > > [    6.666902] coresight-etm4x: probe of 7140000.etm failed with error -22
> > > [    6.673708] coresight-etm4x: probe of 7240000.etm failed with error -22
> > > [    6.680511] coresight-etm4x: probe of 7340000.etm failed with error -22
> > > [    6.687313] coresight-etm4x: probe of 7440000.etm failed with error -22
> > > [    6.694113] coresight-etm4x: probe of 7540000.etm failed with error -22
> > > [    6.700914] coresight-etm4x: probe of 7640000.etm failed with error -22
> > > [    6.707717] coresight-etm4x: probe of 7740000.etm failed with error -22
> > >
> > > With this change, etm probe is successful:
> > >
> > > / # dmesg | grep coresight
> > > [    6.659198] coresight-etm4x 7040000.etm: CPU0: ETM v4.2 initialized
> > > [    6.665848] coresight-etm4x 7140000.etm: CPU1: ETM v4.2 initialized
> > > [    6.672493] coresight-etm4x 7240000.etm: CPU2: ETM v4.2 initialized
> > > [    6.679129] coresight-etm4x 7340000.etm: CPU3: ETM v4.2 initialized
> > > [    6.685770] coresight-etm4x 7440000.etm: CPU4: ETM v4.2 initialized
> > > [    6.692403] coresight-etm4x 7540000.etm: CPU5: ETM v4.2 initialized
> > > [    6.699024] coresight-etm4x 7640000.etm: CPU6: ETM v4.2 initialized
> > > [    6.705646] coresight-etm4x 7740000.etm: CPU7: ETM v4.2 initialized
> > >
> > > Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
> > > ---
> > >   drivers/hwtracing/coresight/coresight-etm4x.c | 2 +-
> > >   drivers/hwtracing/coresight/coresight-etm4x.h | 2 +-
> > >   2 files changed, 2 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/hwtracing/coresight/coresight-etm4x.c b/drivers/hwtracing/coresight/coresight-etm4x.c
> > > index 53e2fb6e86f6..93d5f1f3145e 100644
> > > --- a/drivers/hwtracing/coresight/coresight-etm4x.c
> > > +++ b/drivers/hwtracing/coresight/coresight-etm4x.c
> > > @@ -55,7 +55,7 @@ static void etm4_os_unlock(struct etmv4_drvdata *drvdata)
> > >   static bool etm4_arch_supported(u8 arch)
> > >   {
> > > -   switch (arch) {
> > > +   switch (arch >> 4) {
> >
> >
> > While this looks good, from what it looks like arch is a combination of
> > major version
> > minor version. So, will it be better to masks, and shifts macros instead of
> > a magic
> > number shift.
> > But, frankly it's upto Mathieu to decide the readability of this. So, I
> > leave it to him.
>
> The layout of the architecture is already well defined in etm4_init_arch_data()
> [1].  As such just doing the following would be fine with me:
>
>         /* Mask out the minor version nuber */
>         switch (arch & 0xf) {

s/0xf/0xf0

Apologies for the confusion.

>
> Of course by proceeding this way we don't need to modify the define in
> coresight-etm4x.h.
>
> Regards,
> Mathieu
>
> [1]. https://elixir.bootlin.com/linux/latest/source/drivers/hwtracing/coresight/coresight-etm4x.c#L508
>
> >
> > Thanks
> > Vivek
> >
> > >     case ETM_ARCH_V4:
> > >             break;
> > >     default:
> > > diff --git a/drivers/hwtracing/coresight/coresight-etm4x.h b/drivers/hwtracing/coresight/coresight-etm4x.h
> > > index 52786e9d8926..05d4bd330881 100644
> > > --- a/drivers/hwtracing/coresight/coresight-etm4x.h
> > > +++ b/drivers/hwtracing/coresight/coresight-etm4x.h
> > > @@ -136,7 +136,7 @@
> > >   #define ETM_MAX_RES_SEL                   16
> > >   #define ETM_MAX_SS_CMP                    8
> > > -#define ETM_ARCH_V4                        0x40
> > > +#define ETM_ARCH_V4                        0x4
> > >   #define ETMv4_SYNC_MASK                   0x1F
> > >   #define ETM_CYC_THRESHOLD_MASK            0xFFF
> > >   #define ETM_CYC_THRESHOLD_DEFAULT       0x100

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
