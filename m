Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F31BC282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 13:15:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DAAF2184D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 13:15:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="DIO5ipmu";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZLtu5x/S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DAAF2184D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=BLw/6NYpPknNOv3e1tO3H0AWJg5LLXFFy610oIf24Fc=; b=DIO5ipmuVg78B3
	b2mNpwjl6a9JhocjJ1Uts4PLmUt61gAtPKwsZG2KVI02vj5EMFkJOfY4br3L1Mbl8NdcEh2B4o69i
	9Fb4x9zfajo5C7fc99psucKW9ln0Kfti8syTlF9VYXiced8OvdyejyaPWHOV43SvkyQag9kM+B9ob
	CzQvxZVUNQT95iJdxvhhRmsfGSKgAgOG0Sl6fk4jB75uo2H+Jr6FpKqCRar3+5GFWNUoLvEn5jlt1
	KRGtUUH2agxbzxqHBxqRCN3v1tYoIeMMpEQL3hx3TNLJkMe5mUeUvhUZgj6uiSXQfif1aXkn94ECR
	N7B5XDlu+sXC8C4hZarA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gopho-00016i-HJ; Wed, 30 Jan 2019 13:15:04 +0000
Received: from mail-it1-x144.google.com ([2607:f8b0:4864:20::144])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gophk-0000vX-RK
 for linux-arm-kernel@lists.infradead.org; Wed, 30 Jan 2019 13:15:02 +0000
Received: by mail-it1-x144.google.com with SMTP id i145so10148903ita.4
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 30 Jan 2019 05:15:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=BgzAwcx6EQsoHlyeUDoxuVDHqlcmqfsXDDq/w/zZLcY=;
 b=ZLtu5x/S8WrKKVcmvOZoyW5QDvWRhk8cKMcPn1DgZ1CVJgv3iharZny+Y0iXjogF4R
 XMibHYjaYAqBYrwfR72H53U8MxRS5oksiC0tt0A+L1M+1yZm8GxZbuIF4tj8ppgX2OVL
 xEq/mdnkNxGy9T0pVc9E+kQKD8zqj3AisG5WhNbkJ6WXdddlD7F4T+pLB1MztGSsz1Cd
 M0jMQGTl1/0AAYAp83WUJo8wsPqmg/FHrBenUOn6J12Y22e1ZGAcjMvf0/t2BVxCuj8t
 v3hV7q4xoRP+daYVi8OYbbAH0YYHAuWal31YqjcW3SgJhFpbAiQ3raz/m4MMx/SYr1jZ
 SRHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=BgzAwcx6EQsoHlyeUDoxuVDHqlcmqfsXDDq/w/zZLcY=;
 b=tUHgSoQ5L2xoBTbViJmopF3kpD13aGcvZKsdSRPSOuTHNboF20Ez3y0gcdRuRPVhyl
 s7yiYexeFWeAQyVZcpd6l7hQ34gGrucMU7P3z0o9CzqX3xnX7JTSbhY4fo96w4gWLjG8
 6SVbrIQUISdB7dM3m6NvkEU+Gojenb+qRokX/I/4l5inky232vVeIFN8ExjoIG9hq1bS
 IiuS80UibDCAU26/PZols3h8oEJzfZvRWYuGCNhb8zfHzKOuziqy62OqYK+zZVpQwA7G
 dbzSPgmPOEiiuVibtd64QFw0NQSypave808BqBwmqe2TY6Bw57rx74Kp2lRw/57ZPlJh
 8gLA==
X-Gm-Message-State: AJcUukfl6FjCA0zp4z8fUILR8SBSLvDQoosm3g/KKxp6ktVl0QAKPxqM
 NNdmHOqDKo1r/shOS/YFmLZrckkX0y3MHfNsbuU=
X-Google-Smtp-Source: ALg8bN76qLfDM0655iUIMslnzVmQhQaUEi+YVujV9iv6ygUA8/4Ky+4ZmKXQpds0CaNv3jk42dXfV3AWLVSJWSl0s7Y=
X-Received: by 2002:a24:65c8:: with SMTP id u191mr16186348itb.7.1548854099929; 
 Wed, 30 Jan 2019 05:14:59 -0800 (PST)
MIME-Version: 1.0
References: <20190130095749.8952-1-daniel.baluta@nxp.com>
 <CAA+hA=Tz0p8Ea9f8wuqUZFkmuDrqMHj8_4sLvT8wi6qrTnaVKQ@mail.gmail.com>
 <fc0ef2f1709cb678f29cd37d618e28a7ed606791.camel@nxp.com>
In-Reply-To: <fc0ef2f1709cb678f29cd37d618e28a7ed606791.camel@nxp.com>
From: Dong Aisheng <dongas86@gmail.com>
Date: Wed, 30 Jan 2019 21:14:48 +0800
Message-ID: <CAA+hA=Ra8aV3FQrxrM68hx99X-fqw5+GH1Qv-AtaSzCX-hng7w@mail.gmail.com>
Subject: Re: [PATCH v2] firmware: imx: Add support to start/stop a CPU
To: Daniel Baluta <daniel.baluta@nxp.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_051500_903380_891F0C41 
X-CRM114-Status: GOOD (  13.50  )
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
Cc: Aisheng Dong <aisheng.dong@nxp.com>,
 "daniel.baluta@gmail.com" <daniel.baluta@gmail.com>,
 "festevam@gmail.com" <festevam@gmail.com>, "S.j. Wang" <shengjiu.wang@nxp.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 dl-linux-imx <linux-imx@nxp.com>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Jan 30, 2019 at 9:12 PM Daniel Baluta <daniel.baluta@nxp.com> wrote:
>
> Thanks Aisheng for the comments!
>
> <snip>
>
> +int imx_sc_pm_cpu_start(struct imx_sc_ipc *ipc, u32 resource,
> > > +                       bool enable, u64 address)
> > > +{
> > > +       struct imx_sc_msg_req_cpu_start msg;
> > > +       struct imx_sc_rpc_msg *hdr = &msg.hdr;
> > > +
> > > +       hdr->ver = IMX_SC_RPC_VERSION;
> > > +       hdr->svc = (uint8_t)IMX_SC_RPC_SVC_PM;
> > > +       hdr->func = (uint8_t)IMX_SC_PM_FUNC_CPU_START;
> >
> > pls drop the unneccesary unit8_t
>
> Ok, I can do that. I had borrowed it from the already existing
> functions imx_sc_misc_get_control / imx_sc_misc_set_control
>

Yes, i know, we need remove them later to avoid confusing.

Regards
Dong Aisheng

> >
> > > +       hdr->size = 4;
> > > +
> > > +       msg.address_hi = address >> 32;
> > > +       msg.address_lo = address;
> > > +       msg.resource = resource;
> > > +       msg.enable = enable;
> > > +
> > > +       return imx_scu_call_rpc(ipc, &msg, false);
> >
> > s/false/true
>
> Nice catch!
>
> Inded, the old API had a different semantic for this parameter.
> >
> > > +}
> > > +EXPORT_SYMBOL(imx_sc_pm_cpu_start);
> > > diff --git a/include/linux/firmware/imx/svc/misc.h
> > > b/include/linux/firmware/imx/svc/misc.h
> > > index e21c49aba92f..c03bf2a23add 100644
> > > --- a/include/linux/firmware/imx/svc/misc.h
> > > +++ b/include/linux/firmware/imx/svc/misc.h
> > > @@ -52,4 +52,7 @@ int imx_sc_misc_set_control(struct imx_sc_ipc
> > > *ipc, u32 resource,
> > >  int imx_sc_misc_get_control(struct imx_sc_ipc *ipc, u32 resource,
> > >                             u8 ctrl, u32 *val);
> > >
> > > +int imx_sc_pm_cpu_start(struct imx_sc_ipc *ipc, u32 resource,
> > > +                       bool enable, u64 address);
> >
> > Nitpick: phy_addr
>
> Ok, will fix.
>
>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
