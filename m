Return-Path: <SRS0=sKCI=QH=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C81AC282C7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 07:27:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 588F7218AC
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 07:27:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gg9I7Gw/";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oyVleIXc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 588F7218AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=lE40gthYrmMCtAkMvvBaezIBE0hzUCg784ffIrSL+sU=; b=gg9I7Gw/zPPZmh
	KLND4xyULDUpwjDufruTGgIo1B8/R/v0sxW78WF8OFNdBTwIkcSO9SfyvAWlgllXdLk7d/0MsUrQ7
	hBYiYkG0ovZys+tXbyD2Bndp0ZqtHtYKqC4jdFWpFbc4YNvslQf9ZeXbvvJvGQV0ODvgJzVJAnVr4
	qeccAG7fj1JdNB3HRFsYnWkGZl3+95aR2aTbLdAtVZEgYZg5qeLmHl3VtTyXRPBUf+p7E3K5Mri2q
	NKNA5THkh9MnTuSCZK63gCyeuu6BHrpDXZZFiiXlZi2GrmAMkqNjuVHK0I5JR6S9l6bvdPrHPMpvD
	Rlr7OdJQ19qiSVME4DeA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gp6l1-0007BD-C0; Thu, 31 Jan 2019 07:27:31 +0000
Received: from mail-it1-x142.google.com ([2607:f8b0:4864:20::142])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gp6ky-0007Av-DN
 for linux-arm-kernel@lists.infradead.org; Thu, 31 Jan 2019 07:27:29 +0000
Received: by mail-it1-x142.google.com with SMTP id c9so2529044itj.1
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 30 Jan 2019 23:27:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=/eCYAkvyeadpqPRlU1R0w7M++z7FL/w1/uEMj/8FkFE=;
 b=oyVleIXcEVhJsz1SCvyKrbwpazPyieCcqWIM4J66mf8DPjuzYOCgk3PSL59N50ORej
 gUPTopV18FLtF1JHAY++ZEU8p6j3g4tX4hQEuX+G1CoPEw/pDxGfSccUm5tgHi27w5aS
 BPCXFoXJeijOakEqzSU+Qv78s/MAUjkDn+E4fsVInLvuoC7b/R+a1AcxNgXqEvsBfneo
 M673h5sZ5pHdSSdIxWmcHqgdOelCI39RfOM2kYsLAXjzq1GQobetwUTPZL6topeotkwW
 ak0X3keg70k4cgZrMg4ix2GeEQaPcQudnp73Ct5fxrhhszU+OgpQFSqsgVVYSOFFzu56
 iPpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=/eCYAkvyeadpqPRlU1R0w7M++z7FL/w1/uEMj/8FkFE=;
 b=tFDe4jl00eeCBGF47vnQpr7mgNcLGh5XCODX9y6XIiYxr6uu9rskCvnp4OuvTh/C4l
 Tu+idYrU11gQjmAUrddS84FsAh2n+Xe1yPGtws94vMBarus0Oa0kkb0hwGsTjQ535DPE
 3tFS/t5GR496S1K8WjvT97xwL0CHbh8hCqO9nIw2EpC3Z2V1/I8HcFrwIg3/bp96+Ul0
 qf7bQIoMXAAEwy+1TJY08VaaD3O3nt3uNO4owYfCSA/f40f7tTZuKk13WQZy64buT1JW
 Z1G3NnrQ+mSxgMuhfLHLSq1V7gaBygUV5c+XEc3Mdoo8n9HSg5vO0jEA0QEXOOMTANEL
 sBgw==
X-Gm-Message-State: AHQUAubOxvnlD3xKxWvdSMchM105nUwDv+pHh2CNpmWldjDaUSo080ys
 FVLPrt4BCu7pK37ORk8M8LYX3wRGEZnknjYotvk=
X-Google-Smtp-Source: AHgI3IYqEIxysIWWuLWpPnLi6EfEBbGyUppFOr77z5GO73Avwq5q9HOyHVDmMP8epfUbdagI6H3MAZANjNvC+YK4QsU=
X-Received: by 2002:a24:9b87:: with SMTP id o129mr3966987itd.128.1548919647379; 
 Wed, 30 Jan 2019 23:27:27 -0800 (PST)
MIME-Version: 1.0
References: <1548853196-11447-1-git-send-email-aisheng.dong@nxp.com>
 <1548853196-11447-4-git-send-email-aisheng.dong@nxp.com>
 <1548854523.6869.25.camel@pengutronix.de>
In-Reply-To: <1548854523.6869.25.camel@pengutronix.de>
From: Dong Aisheng <dongas86@gmail.com>
Date: Thu, 31 Jan 2019 15:27:16 +0800
Message-ID: <CAA+hA=RMjER6v3u4GzvCiOEJXJyBrpVed7KWUJPGQKhZvne0AQ@mail.gmail.com>
Subject: Re: [PATCH V2 3/4] irq: imx-irqsteer: change to use reg_num instead
 of irq_group
To: Lucas Stach <l.stach@pengutronix.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_232728_448144_39C7732A 
X-CRM114-Status: UNSURE (   9.31  )
X-CRM114-Notice: Please train this message.
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
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Marc Zyngier <marc.zyngier@arm.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>, dl-linux-imx <linux-imx@nxp.com>,
 "tglx@linutronix.de" <tglx@linutronix.de>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Jan 30, 2019 at 9:23 PM Lucas Stach <l.stach@pengutronix.de> wrote:
[...]
> > > +   /* one register bit map represents 32 input interrupts */
> > > +   data->reg_num /= 32;
> > +
> > >     if (IS_ENABLED(CONFIG_PM_SLEEP)) {
> > >             data->saved_reg = devm_kzalloc(&pdev->dev,
> > > -                                   sizeof(u32) * data->irq_groups * 2,
> > > +                                   sizeof(u32) * data->reg_num,
> >                                       GFP_KERNEL);
>
> Does this last parameter now fit on the line above?
>

No, 81 now. :)

Regards
Dong Aisheng

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
