Return-Path: <SRS0=fpAU=QP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E826AC282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 02:32:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B380F20869
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 02:32:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="a2lsC5HD";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="Kf8CebBE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B380F20869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Fdvu06y2S5Dpmnhu5OMoUxdieA7XsGBSsg7SklIyhxc=; b=a2lsC5HD7D6S7u
	ajzLsLABIcQSoXWXovMRdBEl5i7y/cuLnkfGruA9FLYhO5/NH/y61bCM7P42eWCUcBW6sk3IHdo6q
	LK0TQju9MMV5M8IJ+xuLLffa7kqO+kJa9aSoJfuuK+iV1kqoedc1x4A9wUeZHkQ4srnp3oQIagq3F
	eOagvoCCXX+NtHdpqnbpyDtkVj1cpS+DrfBljgloMyIU5FljukjAqDCOWkjuOoflPi0STZXiCff6w
	IuYW1Hee0BLhzx93kY1LpxNs25Fd0iZsRyYpQPaCeQ8obZp5IjktArAaxiS/f2leJpby3cBuA05Hy
	TFibDs/5z71nsBCTQiZw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grvy1-0006X0-Uw; Fri, 08 Feb 2019 02:32:37 +0000
Received: from conssluserg-05.nifty.com ([210.131.2.90])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grvxy-0006WL-LG
 for linux-arm-kernel@lists.infradead.org; Fri, 08 Feb 2019 02:32:36 +0000
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com
 [209.85.222.43]) (authenticated)
 by conssluserg-05.nifty.com with ESMTP id x182W6EG015230
 for <linux-arm-kernel@lists.infradead.org>; Fri, 8 Feb 2019 11:32:07 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com x182W6EG015230
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
 s=dec2015msa; t=1549593127;
 bh=xtWcVX77MfZiWDRjN2wLTfoqFktVANKwHfXtMYJt5LA=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=Kf8CebBE6fU10pqF+Xn92P+eiZUo1oAeqiv+g3ddeXyrtIHj4QZOlDB8BSgptg4+W
 I2b0FlJiNp9HMbnTocWeA0LnhZtk1RTBy9BkNgnegamYhqek88xNZNgmddSevw2GoD
 GmJ2k3YWOA8srWTGIatjjmOppqMSlQFy7LKTOcgxfvJiAZNKFsuwknAhtH5dJTYi+Q
 xnF+KO94C21Q7WMrGdXq74by+NgWajTt2uwfQ9o3CPz6zCIQK7pdfaXhbzOELFppw5
 PhayWGiyFdSAE3cwH95DWyJ/eoFeVMAh92/WoEH/Yn1C8DlYFRBSmH/bK5Q+rYmTEi
 +lnBk13/kYYsg==
X-Nifty-SrcIP: [209.85.222.43]
Received: by mail-ua1-f43.google.com with SMTP id d2so673971ual.2
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 07 Feb 2019 18:32:07 -0800 (PST)
X-Gm-Message-State: AHQUAuZa4/MoXHoExqGSZ8s9AbjSCi5qwnB/Z0dC6shQL0+Gzghl7uVO
 VeSL+VlgAM840GlxtvEQI/ywN39JJuRRhruW/Sw=
X-Google-Smtp-Source: AHgI3IafKUGdgurz2xw3TovwLQ9wrRhCN2PgHDXEkKvACVhZCZA8sC8SttgcQZb7wH8A6Ix1KGRxWEE4HzENId6eD7c=
X-Received: by 2002:ab0:3402:: with SMTP id z2mr7388707uap.6.1549593126154;
 Thu, 07 Feb 2019 18:32:06 -0800 (PST)
MIME-Version: 1.0
References: <1549592723-18494-1-git-send-email-hayashi.kunihiko@socionext.com>
In-Reply-To: <1549592723-18494-1-git-send-email-hayashi.kunihiko@socionext.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Fri, 8 Feb 2019 11:31:30 +0900
X-Gmail-Original-Message-ID: <CAK7LNATMCT74HKroyR-Sx2pm7vVWzuNb2fRbDtCSQvKViszo=g@mail.gmail.com>
Message-ID: <CAK7LNATMCT74HKroyR-Sx2pm7vVWzuNb2fRbDtCSQvKViszo=g@mail.gmail.com>
Subject: Re: [PATCH] clk: uniphier: Fix update register for CPU-gear
To: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190207_183234_913236_E45F660B 
X-CRM114-Status: UNSURE (   9.38  )
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
Cc: linux-stable@vger.kernel.org,
 Masami Hiramatsu <masami.hiramatsu@linaro.org>,
 Stephen Boyd <sboyd@kernel.org>, Michael Turquette <mturquette@baylibre.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-clk <linux-clk@vger.kernel.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Feb 8, 2019 at 11:25 AM Kunihiko Hayashi
<hayashi.kunihiko@socionext.com> wrote:
>
> Need to set the update bit in UNIPHIER_CLK_CPUGEAR_UPD to update
> the CPU-gear value.
>
> Fixes: d08f1f0d596c ("clk: uniphier: add CPU-gear change (cpufreq) support")
> Cc: linux-stable@vger.kernel.org
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> ---


Acked-by: Masahiro Yamada <yamada.masahiro@socionext.com>


-- 
Best Regards
Masahiro Yamada

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
