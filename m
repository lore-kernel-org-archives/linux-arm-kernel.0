Return-Path: <SRS0=x1Tr=QU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEA79C282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 03:16:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF86321934
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 03:16:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="AT7Qvegv";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NdjRV2Ak"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF86321934
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=NMxv9RjHl47aLipY/U/td9csnPmmYpIUiS42ObzFINs=; b=AT7QvegvImp70n
	Pbu64At8vX9NT1P6AlpKtf6bg8Y3Ywzz5Yq/xTYQifuwkr/IOs67YUzOuKCkIoRJB8/ZxcFnloP6t
	MNefL0uLYsYpsxbOhTkrtc60jWT7ZMNuqR7i5h3a9hwpntx96MEGO0Y4l/Ww642d4OBNVHSYQ9ysT
	jIIibgk2yXNFeWJB22SFuTkiW7wKKXAWB72ug47/NtFBX8G1WwytXKjlnOcjteoFHVPRf3ijLa1Kr
	Wlj4yQWBzfbDn+HPSGSDlcVXyn7oaTxv0Yf9KaoVvK1wOmvofoiLRFeGysnUzeEiBu9DkNuUzkarc
	Fbi2HWwZOYpvcKHBtqUQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtl27-0000fG-9U; Wed, 13 Feb 2019 03:16:23 +0000
Received: from mail-ed1-x544.google.com ([2a00:1450:4864:20::544])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtl24-0000eW-Br
 for linux-arm-kernel@lists.infradead.org; Wed, 13 Feb 2019 03:16:21 +0000
Received: by mail-ed1-x544.google.com with SMTP id b20so651294edw.11
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 12 Feb 2019 19:16:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=xGLmxX5ZZsqNrzRqmlY+znpV0Tv4SjK3drY64f4I7RQ=;
 b=NdjRV2AkBoCYs4CMtMmZD1P7f5lG91kzbO5Lpi23lRhde68jxHuElkaSkE5xJpRTou
 zD/pFfZAkm07OoViak8OAXUqPabC5YldpllHiV1sEqSD0YAY3uxpWwcjpYKqmCJ57j8a
 ObxWXA8lpCxg0x5Qmu+6dBRFnTK/btn/sannI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=xGLmxX5ZZsqNrzRqmlY+znpV0Tv4SjK3drY64f4I7RQ=;
 b=P2PIKEmg//m5YuYRsaUh5VPtdhzmxMJCGFvgaDmW/5Dz/8y0pfFsb9nCPUcCbjmSmF
 nc3xvyRe+fzp9KrzoGRjbdt4S8YVl6Wjl+rZWU5sbWgfibQfBi2fgNVFT6riCgWPB5fD
 NuNDUM4QTfJTX3KMAN/H5vZRFtCACbbPJ2KLiAXbUAvH1km+0sT0P1xpBdfOrGwSPRtv
 T37aX3aPXtpT38PafbYTrwHP9mWWdeLscn5CRDSsPGbTc/aROaDe7SDl/8C2JJ79hJev
 4D7c+w79CXgTrpV46gwfhs8D1vQnIVswpg99dkSifj4pvPkKXL/qT2qMQCrzCFV+PWy5
 Q6HQ==
X-Gm-Message-State: AHQUAub4cxzU4ekDlM90BrMHnoLgjdgIHdd+8sNsPIRM609z0yPJudJU
 NlTp4KYQnxWQ4ef/JywX7hNd3KgXzpjZ85O87D8e1g==
X-Google-Smtp-Source: AHgI3Iagdzfvaw1AKF2EX1ODY4PiP1tZf1Oy9WDHWF5NA3gs+48hPwOAjiM0GPckew/0120f9vY0o58S4jtdcXGEOFg=
X-Received: by 2002:a17:906:5501:: with SMTP id
 r1mr4927214ejp.167.1550027777901; 
 Tue, 12 Feb 2019 19:16:17 -0800 (PST)
MIME-Version: 1.0
References: <20190131093131.245531-1-pihsun@chromium.org>
 <20190131093131.245531-3-pihsun@chromium.org>
 <20190202001749.GT81583@google.com>
 <cc1407f1-c236-f0af-a6c1-366aeac259f4@gmail.com>
In-Reply-To: <cc1407f1-c236-f0af-a6c1-366aeac259f4@gmail.com>
From: Pi-Hsun Shih <pihsun@chromium.org>
Date: Wed, 13 Feb 2019 11:16:07 +0800
Message-ID: <CANdKZ0dMOsj_8oa1z8Uhs_UGotVkBpcqVP=uBM7n2XbHUvBWwQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/6] remoteproc/mediatek: add SCP support for mt8183
To: Matthias Brugger <matthias.bgg@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190212_191620_431830_275C938D 
X-CRM114-Status: GOOD (  22.69  )
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
Cc: Ohad Ben-Cohen <ohad@wizery.com>, Nicolas Boichat <drinkcat@chromium.org>,
 Erin Lo <erin.lo@mediatek.com>,
 "open list:REMOTE PROCESSOR \(REMOTEPROC\) SUBSYSTEM"
 <linux-remoteproc@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 Matthias Kaehlcke <mka@chromium.org>,
 "moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>,
 "moderated list:ARM/Mediatek SoC support"
 <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Feb 5, 2019 at 2:02 AM Matthias Brugger <matthias.bgg@gmail.com> wrote:
>
>
>
> On 02/02/2019 01:17, Matthias Kaehlcke wrote:
> > Hi Pi-Hsun,
> >
> > a few comments inline.
> >
> > It's the first time I dabble into remoteproc, I don't claim to have a
> > complete understanding of the driver at this point ;-)
> >
> > On Thu, Jan 31, 2019 at 05:31:27PM +0800, Pi-Hsun Shih wrote:
> >> From: Erin Lo <erin.lo@mediatek.com>
> >>
> >> Provide a basic driver to control Cortex M4 co-processor
> >>
> >> Signed-off-by: Erin Lo <erin.lo@mediatek.com>
> >> Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
> >> ---
> >> Changes from v3:
> >>  - Fix some issue found by checkpatch.
> >>  - Make writes aligned in scp_ipi_send.
> >>
> >> Changes from v2:
> >>  - Squash patch 3 from v2 (separate the ipi interface) into this patch.
> >>  - Remove unused name argument from scp_ipi_register.
> >>  - Add scp_ipi_unregister for proper cleanup.
> >>  - Move IPI ids in sync with firmware.
> >>  - Add mb() in proper place, and correctly clear the run->signaled.
> >>
> >> Changes from v1:
> >>  - Extract functions and rename variables in mtk_scp.c.
> >> ---
> >>  drivers/remoteproc/Kconfig            |   9 +
> >>  drivers/remoteproc/Makefile           |   1 +
> >>  drivers/remoteproc/mtk_common.h       |  73 +++++
> >>  drivers/remoteproc/mtk_scp.c          | 441 ++++++++++++++++++++++++++
> >>  drivers/remoteproc/mtk_scp_ipi.c      | 157 +++++++++
> >>  include/linux/platform_data/mtk_scp.h | 135 ++++++++
> >>  6 files changed, 816 insertions(+)
> >>  create mode 100644 drivers/remoteproc/mtk_common.h
> >>  create mode 100644 drivers/remoteproc/mtk_scp.c
> >>  create mode 100644 drivers/remoteproc/mtk_scp_ipi.c
> >>  create mode 100644 include/linux/platform_data/mtk_scp.h
> >>
> >> diff --git a/drivers/remoteproc/Kconfig b/drivers/remoteproc/Kconfig
> >> index f0abd260804473..ee0bda23768938 100644
> >> --- a/drivers/remoteproc/Kconfig
> >> +++ b/drivers/remoteproc/Kconfig
> >> @@ -22,6 +22,15 @@ config IMX_REMOTEPROC
> >>
> >>        It's safe to say N here.
> >>
> >> +config MTK_SCP
> >> +        tristate "Mediatek SCP support"
> >> +        depends on ARCH_MEDIATEK
> >> +        help
> >> +          Say y here to support Mediatek's SCP (Cortex M4
> >> +          on MT8183) via the remote processor framework.
> >
> > It would be good to spell out SCP somewhere, e.g.
> >
> > "... support Mediatek's system control processor (SCP) via ..."
> >
> > the example is less important IMO, though it's prefectly fine if you
> > can still squeeze it in ;-)
> >
>
> In which way is this different from
> drivers/soc/mediatek/mtk-scpsys.c ?
>
> Regards,
> Matthias (the other one ;)

drivers/remoteprocs/mtk_scp.c is for SCP (System Companion Processor)
on MTK's platform, and drivers/soc/mediatek/mtk-scpsys.c is for SCPSYS
(System Control Processor System). Despite the similar name, they're
not relevant.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
