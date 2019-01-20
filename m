Return-Path: <SRS0=lfWu=P4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F39BBC26640
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 18:00:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C609C20861
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 18:00:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Jg2QpHcb";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PLHrbY42"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C609C20861
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=nBXORVIRfciT1SQ9/WOL9n4JAuj3Z7RLecBs/4kzBJI=; b=Jg2QpHcbDHGoKA
	GNIuw9Imk9U7BPCTUxyX6Zqb8QVoWwVmX6dJ6Yb3B/ogPa7AOi0n95qyIITSfhpRzhL6A7PDRIyiu
	DnG0e8Sbk92WAtOgBxlP3sfMnPyTa9sYK2A25AZYH1g70AudCAWSBKHTiLWEskEo2NAd5r/e+QQvB
	6lKWqZ38ElgTs1QKzS8CZwocOy8tsGp8DQGPeRhGk7qL5CKPSapky8fV1q5eGVXxrCv37San7UjoC
	NxEir4tKIOCTEwQVmZF/JOpkgJQ8tEgsjF1DZco99tUX7SNjWV4alNx4UVb+qfJox5K/HnxpWF3JM
	VFAQER5f6KtAq2LyK8BA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glHOr-0000YO-Np; Sun, 20 Jan 2019 18:00:49 +0000
Received: from mail-ed1-x543.google.com ([2a00:1450:4864:20::543])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glHOl-0000X5-SF
 for linux-arm-kernel@lists.infradead.org; Sun, 20 Jan 2019 18:00:48 +0000
Received: by mail-ed1-x543.google.com with SMTP id y20so14853109edw.9
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 20 Jan 2019 10:00:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ZRhRxCRvJbRYxqEYTBLN/3841c+efnZUM2Kebudt8RI=;
 b=PLHrbY42s+ajY40pba6eO0lD1hISGTkGCUTOjg7hmLuajQJjOE6vdguLKFHkBrQ5Tm
 p11GpNToBimbhbOvhzgjFWqliFh/V5bqYyDy+0KgRzZURUeFMLwptscXNc8KfgZEDHS7
 c43hgoGl4hcJfYnzll5nInJjiNb9/OLc3W4lSGAyL+w+TfZCTpmQ3yWTCGmzKSkgToiw
 dvQ0hWosDgPpRqnr7bhIERhhnqzdjPBnq1jrL3A6Vie4fyIrZfkOyTF6yb6LiYL7dxcJ
 F+9luDEJXWc7+GrdeCt888uPhufLhrKn3tRq6ymtYH2XlHg0UmwNMzf58Cr1IaZWNIQJ
 /UKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ZRhRxCRvJbRYxqEYTBLN/3841c+efnZUM2Kebudt8RI=;
 b=hvRG1R+WvtpYI3ZST9xLvN0M6d2MwlWKX10rLpot1IlH+s5HUqPdPdIMoNQDT9ycjP
 BtTFqRb3kN1RT1wLtQzMphmN4YDNQfK355kaVYYldS7yoYXI5/foCW4AmYQ7yIhYKE2D
 m2CJzzgCSadJsaq81z+UcBOb6rDSuZVY1prjag/hTyxHxJc/YbWifJOANt0PXCr8LOIr
 Z1bPz5huaK8JVHvKOGxgTadH2I3aCIFMwuAoupTDbSt8Mv3A1PBp43qRBL2GQYw4ROt8
 qZuH5z6Q8iZsrgO7ploO4y3J3VCooE79i532SIbSWTcCEjbVAYzS62z6gVFAgeVsxY2p
 7uYQ==
X-Gm-Message-State: AJcUukfuOr5tYWXF4xE6VzBtX4H9oLswuw+OGUexwZl8KT01fNDDnYLR
 VXu/GIetEwPnYWjBoj/Zy6VWU7nmSr33yCCN7xA=
X-Google-Smtp-Source: ALg8bN7ZJoSJqCM5987xtMS9mA4Fjmt+MUeDyNThWj6N/bNPuZHCTSu3sfoGwQZhFVJviEvDPsTchXxaEuC7opd+5HE=
X-Received: by 2002:a50:9106:: with SMTP id e6mr22957020eda.148.1548007241826; 
 Sun, 20 Jan 2019 10:00:41 -0800 (PST)
MIME-Version: 1.0
References: <20190120023150.17138-1-angus@akkea.ca>
 <20190120023150.17138-3-angus@akkea.ca>
 <CAEnQRZBLLKotGy2t-f3rURnoUCjkxfuwrtYkirv6+kdAzidaFg@mail.gmail.com>
 <6cbbac1e98b74702fc5a9b915b7630f7@www.akkea.ca>
In-Reply-To: <6cbbac1e98b74702fc5a9b915b7630f7@www.akkea.ca>
From: Daniel Baluta <daniel.baluta@gmail.com>
Date: Sun, 20 Jan 2019 20:00:29 +0200
Message-ID: <CAEnQRZCwtbbJmTPT+J1q=5UvxjwZvkcoJxY3AJgBgXiPz0L2wA@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] dma: imx-sdma: add clock ratio 1:1 check
To: Angus Ainslie <angus@akkea.ca>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190120_100043_939598_10E72DD2 
X-CRM114-Status: GOOD (  16.22  )
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
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Vinod Koul <vkoul@kernel.org>, NXP Linux Team <linux-imx@nxp.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>, dmaengine@vger.kernel.org,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Sun, Jan 20, 2019 at 4:38 PM Angus Ainslie <angus@akkea.ca> wrote:
>
> Hi Daniel,
>
> On 2019-01-20 02:58, Daniel Baluta wrote:
> > On Sun, Jan 20, 2019 at 4:32 AM Angus Ainslie (Purism) <angus@akkea.ca>
> > wrote:
> >>
> >> On i.mx8 mscale B0 chip, AHB/SDMA clock ratio 2:1 can't be supportted,
> >> since SDMA clock ratio has to be increased to 250Mhz, AHB can't reach
> >> to 500Mhz, so use 1:1 instead.
> >>
> >> based on NXP commit MLK-16841-1
> >
> > Hi Angus,
> >
> > Thanks for doing this!
> >
> > I'm not sure specifying the MLK here helps. I think it would be better
> > to somehow add the original Signed-off-by and mention that the commit
> > was pulled from NXP linux-imx tree.
>
> If it was exactly the same patch I would have but as I added the lines
> in
> sdma_run_channel0 I didn't think it would be right to put signed off by
> "Robin Gong <yibin.gong@nxp.com>" as the code isn't what he signed off
> on.

I see your point. I often encounter this scenario when sending patches.
I think the best solution would be to mention in the commit message
the author of the initial patch which you based your work on.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
