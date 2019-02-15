Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98E6FC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 00:59:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 696AA21934
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 00:59:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="CO4sTnn4";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RroLO87p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 696AA21934
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Wq/YgkXUV/yy3WRZhRLzvnWysaFs3I0+gZw6T9XTh6E=; b=CO4sTnn4X7fYfp
	ESOrKSlLuXZl8ujoEzW5sx8PLSsJMHTHFUCptnmohA12rwhwpZL0bDFpZ2aVCmo8Z0hJFUB99t+SL
	x9kfPPkiWsZWRHZjA8DjSN0MC3mM6Dg/ylNYBVp3nm8fv6Iu84Q1ReBS3Hhb125TLsff4ntQJ1fKO
	XNMQ9ajUzxMGltMojtnfrmvJ32mD99jPTAWgRQBJQ63/X3QtibKUTysr0TLFvZoIGk6CU3BtijbfQ
	kJNSrl1SN0Mg0uns9nRBMq6wa02k0n02Ls/ZqbrmKX7bKrEouFgiU1TNd0pvrvAUGg8TV+3N+dfv6
	1mZ8oAvlJlMtKeYGzf+w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guRqZ-0002SS-Fm; Fri, 15 Feb 2019 00:59:19 +0000
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guRqX-0002S6-8E
 for linux-arm-kernel@lists.infradead.org; Fri, 15 Feb 2019 00:59:18 +0000
Received: by mail-wm1-x343.google.com with SMTP id j125so7980840wmj.1
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 14 Feb 2019 16:59:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=uyivuSNS3T//EPBbYRrQNiWfYaC7QsAANNMOOd/BlNE=;
 b=RroLO87ps+DHsOWieR/cw9j6QcIu7KgHdnwbqby3Hk8A6RbcfrJmZwVgKb/FHjWwer
 8fpHQ87kEf8OtNKwyQKFYgJMrbMFbhE4cJC60PuHehlC+8qrQidy+lOc8e4i/9IB0aSn
 SfRsu2QuND/YTFn6htfRRiBZn5tV5GroHBvArjXRcvkImgHxL7fkRrr9il/TbDQbv5i4
 9TfhZAi6xrFHBh37eho7sAKs6w9Nmy89ikFQOjFAfzj7k2alhN1XV1jn7HTGLcgBHTTZ
 tNEKofi5zc71u03cM5XE5D5UrKIAtYQWNhVLjnzGju0eBUWolx0ebsvGZg8W9XUm+Ufv
 K7cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=uyivuSNS3T//EPBbYRrQNiWfYaC7QsAANNMOOd/BlNE=;
 b=j6QI/lt9SdYt0F09DBJBmCi9NOe5yTDt/fhs9wTwT0H4AP2cBnfrMGrPv1IYF/xfe/
 7fr+ttBTV6ogcImslremKB6aTpLQH9dXDreOWf6Da6H/KmkKtgekK/juX9bTw8r8OXj+
 53DUOLpL9jgALZUeJ6nkNDU5SQKn6UTg9hGHLYjbzAUgCHK8FVX5Wz1XDByNKIqbx8Lp
 n8Aowutqvw3w0DGFDmJbPYWPPquljzKLoh1vFxb3kIfgJ6HuBcUlzFNz/FVw6R8peVBE
 lL2K326NS0i8f/f/ehHcB1wxF0YU0MqTSKcuZhO0YYMqJwRJySO+1czt9AfTR2S9AlDi
 AhlA==
X-Gm-Message-State: AHQUAuZfqdfdQqZdWCHF6riGBXNsC4OtgL77Iw2m4Kd4wwUDJc/qQMAU
 W+WjXWhE8xM5mwrMO2UlXYYan2GR9Boz2mhuxd8=
X-Google-Smtp-Source: AHgI3IYMrWs8hS6iDxd3ygyPPWsKldXVFK1KERDyMi6a+7yHvSzJLbOPh8cM/ufWJ9be5DEwlaPKvgawTY3tOjOFso4=
X-Received: by 2002:a05:600c:220b:: with SMTP id
 z11mr4382465wml.37.1550192355474; 
 Thu, 14 Feb 2019 16:59:15 -0800 (PST)
MIME-Version: 1.0
References: <20190104174925.17153-1-andrew.smirnov@gmail.com>
 <20190201162729.GA22030@e107981-ln.cambridge.arm.com>
In-Reply-To: <20190201162729.GA22030@e107981-ln.cambridge.arm.com>
From: Andrey Smirnov <andrew.smirnov@gmail.com>
Date: Thu, 14 Feb 2019 16:59:04 -0800
Message-ID: <CAHQ1cqENSb0ORrcN0Qh93DGx1C7AVxSqAKhcfJH2qZ8+WuVH+g@mail.gmail.com>
Subject: Re: [PATCH v2 00/20] i.MX6, DesignWare PCI improvements
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190214_165917_314913_D0E7BB6E 
X-CRM114-Status: GOOD (  15.92  )
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
Cc: "A.s. Dong" <aisheng.dong@nxp.com>, Richard Zhu <hongxing.zhu@nxp.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 linux-pci@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>,
 Fabio Estevam <fabio.estevam@nxp.com>, dl-linux-imx <linux-imx@nxp.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Leonard Crestez <leonard.crestez@nxp.com>,
 Chris Healy <cphealy@gmail.com>, Lucas Stach <l.stach@pengutronix.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Feb 1, 2019 at 8:27 AM Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
>
> On Fri, Jan 04, 2019 at 09:49:05AM -0800, Andrey Smirnov wrote:
> > Everyone:
> >
> > This is the series containing various small improvements that I made
> > while reading the code and researching commit history of pci-imx6.c
> > and pcie-designware*.c files. All changes are optional, so commits
> > that don't seem like an improvement can be easily dropped. Hopefully
> > each patch is self-explanatory.
>
> Side note: You should trim the CC list, eg I do not think CC LKML is
> needed at all for this series.
>

I add it because it's always recommended by scripts/get_maintainer.pl
and it really simplifies creating lore references to previous versions
of the patches I sent, that is I don't have to remember which
tree-specific list that series went to.

> @Lucas: May I ask you to consider please which patches you deem
> worth for inclusion ? I will have a look too but I would be grateful
> if the driver maintainers can chime in to help.
>

Lorenzo, can you apply the dwc specific patches that are already
reviewed by Gustavo Pimentel from this series, to keep things moving
while we are waiting on Lucas? I can also spin them out into a
separate series if that's perferable.

Thanks,
Andrey Smirnov

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
