Return-Path: <SRS0=p0aQ=P2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E06CDC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 11:20:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25E042086D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 11:20:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qjkaHq4G";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D9GmmFAg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25E042086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=EtIy3bBbS4UbjdIA+h151C8rPVm77J7wpcErLRlpIpc=; b=qjkaHq4GQL/kuE
	ftnnpb7yChoB1H/OfTFJlMZnz+cX0KAZAa1yCZ4SALpFBGsyE9UtJ0SPTbrWq6I4ICMVVf+oc8+Wv
	RuhjrGEl5FZpjelC/nbe6DJyERxgrU1RhXx3Fa1L9/MJScvr4wiqRtw9sgah/cJq7ejdQ+hPS5M39
	e1I/+iBt56CAp1YVDjdPVDbZRw9S6KaOhHR86pSGLFmAMZBfBYh8E3q4IvYzn/QGYp/jXQgmCyKKc
	+6bL04i/JQpuqz1YV+ozz5fJaozbBENxDAF6ihi7MOp7abgd1UNKGtvMQ5jMJY10zhveFqHMUAhd5
	zCQe1TJUBIOYWHPVq+2w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkSCI-0000Rg-Lu; Fri, 18 Jan 2019 11:20:26 +0000
Received: from mail-ua1-x92b.google.com ([2607:f8b0:4864:20::92b])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkSCF-0000R8-88
 for linux-arm-kernel@lists.infradead.org; Fri, 18 Jan 2019 11:20:24 +0000
Received: by mail-ua1-x92b.google.com with SMTP id v24so4537963uap.13
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 18 Jan 2019 03:20:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=XqF0zZgFayTmTO/6SUH1t+WrRUcv72SweIyRMBjv87g=;
 b=D9GmmFAgjv+5fMxCXp5xCcl/ZSn3HHWyfLbIKnqEUoQGUzpEQtnK872HuAFMporWy8
 FtB1I6hgNbsI6BGQyRFD66Jk28nEWyr1cJ54576q1P1tfwswQYlPZtG2LDSNwAGI5c2c
 vsmRxZ4VggCqcAce4ZGUjJzE0t3BtOo6o6NUmcmENogt0PgUndm2XUv92fNkLoN8XdiF
 eMhKQ5bgmb3zns4sBO+V0DVEjyLzAeeJ/i1ymIl+iLgWy3i+SBuuwKlGZezyWUgbN7ay
 NygDllUwwt1jhMga1NQiwO733GITXacZUEs+U3vjLk9yAcGaK99uJ+qO07OWCDuVJ+r7
 ksnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=XqF0zZgFayTmTO/6SUH1t+WrRUcv72SweIyRMBjv87g=;
 b=P97rGsWEr0ixOtPfJVS+3nymUqSrJ1hCTBJce80v4YeMYDvweDfZIAacMd8i7n51vf
 pjiyAFLmR5ynRqBOg6bkj0timdjDE4+NcMchfgyjcs5bHb9EukeN12E1UFYP7T8s08BP
 I3F9SgDWZuKFaN0IWFslXM5RhHb+ckr4+GC5oSMJFTSwtv4ltUqh7OFUh+1mcBzGJuFr
 PRISXQ5sSegr/QkWI/WnzM103tar+i+NHQVk3HkuasGqae+k9PMU2ky8jjH1Spd+3VMi
 xwRrkxGDwnPW6K9WRR1zq0E49NuNLwqM7yoHQAVsMpb6Z6bNTf75GxakYQAnOVed9ijl
 l4Ww==
X-Gm-Message-State: AJcUukfFXK8yzqRK4w1HpoUhvkhWKkwtyQrXnixrVajHOl76b4MKkdL/
 NLC6J1vjaoeANruc3LfIp9Rfd7rcYbg137JjAks=
X-Google-Smtp-Source: ALg8bN6mxLE2fuUGoFKjllqfM6KcxqbBeCmty7KewOuDUIEDxWLGW1kJw0dz41+rI27UPKQCj1yKvjE6TfH21SValXE=
X-Received: by 2002:ab0:8d9:: with SMTP id o25mr7383232uaf.127.1547810421480; 
 Fri, 18 Jan 2019 03:20:21 -0800 (PST)
MIME-Version: 1.0
References: <CAOuPNLj4QzNDt0npZn2LhZTFgDNJ1CsWPw3=wvUuxnGtQW308g@mail.gmail.com>
 <bceb32be-d508-c2a4-fa81-ab8b90323d3f@codeaurora.org>
 <CAOuPNLiNtPFksCuZF_vL6+YuLG0i0umzQhMCyEN69h9tySn2Vw@mail.gmail.com>
 <57ff3437-47b5-fe92-d576-084ce26aa5d8@codeaurora.org>
In-Reply-To: <57ff3437-47b5-fe92-d576-084ce26aa5d8@codeaurora.org>
From: Pintu Agarwal <pintu.ping@gmail.com>
Date: Fri, 18 Jan 2019 16:50:10 +0530
Message-ID: <CAOuPNLjjd67FnjaHbJj_auD-EWnbc+6sc+hcT_HE6fjeKhEQrw@mail.gmail.com>
Subject: Re: Need help: how to locate failure from irq_chip subsystem
To: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190118_032023_402376_4A3D3581 
X-CRM114-Status: GOOD (  11.52  )
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
Cc: linux-pm@vger.kernel.org, kernelnewbies@kernelnewbies.org,
 open list <linux-kernel@vger.kernel.org>,
 Russell King - ARM Linux <linux@armlinux.org.uk>, linux-mm@kvack.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

> >> Could you please tell which QCOM SoC this board is based on?
> >>
> >
> > Snapdragon 845 with kernel 4.9.x
> > I want to know from which subsystem it is triggered:drivers/soc/qcom/
> >
>
> Irqchip driver is "drivers/irqchip/irq-gic-v3.c". The kernel you are
> using is msm-4.9 I suppose or some other kernel?
>
Yes, I am using customized version of msm-4.9 kernel based on Android.
And yes the irqchip driver is: irq-gic-v3, which I can see from config.

But, what I wanted to know is, how to find out which driver module
(hopefully under: /drivers/soc/qcom/) that register with this
irq_chip, is getting triggered at the time of crash ?
So, that I can implement irq_hold function for it, which is the cause of crash.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
