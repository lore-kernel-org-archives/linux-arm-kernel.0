Return-Path: <SRS0=fRgi=OV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A66C4C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 12:03:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 736FB20849
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 12:03:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hXUfN33u";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="B0lORjlt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 736FB20849
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=lf4yr69+J3XpMpTOVKVGjFEwA9ePeu4RJT/wgll3vyk=; b=hXUfN33uK/RHBm
	YQUBYJJSB+rM4xp9uJW7PSRI9WmkedtCuIHw1HWhA8e3EfgOTtPM8lS5CSRJ0bvWIrwK1ULhl9K2I
	22sNV2SgiZWMq1JjZbYr6iwJyCu82OtDm9AYiQWzlnTqu1wrZC51nlU6hIDV63bnYCYty3CE5O4MQ
	+X7aE2ftuayOKk7Efok1qjEpjCdLDnh3ten1bK5A4yhuXWaUh6JvMLdJ4CMpqqlVCzOrkNySNDLq2
	F010GjA5Lxlb6RrPzb5kH1WsIZdGX+qqTo++jIuDwn/1efphS1x5DMAoebvgC8Z9krETlYagHxXYs
	AVunGjRVfA1x10sd+viQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gX3Ex-0005N7-KV; Wed, 12 Dec 2018 12:03:47 +0000
Received: from mail-lf1-x143.google.com ([2a00:1450:4864:20::143])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gX3Eu-0005LQ-23
 for linux-arm-kernel@lists.infradead.org; Wed, 12 Dec 2018 12:03:45 +0000
Received: by mail-lf1-x143.google.com with SMTP id a16so13335000lfg.3
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 12 Dec 2018 04:03:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=iAj07EaWJAx9qCFS8RwXhzSoprTQdRkm0RG7VitREB8=;
 b=B0lORjltdUia8KOYvS/sfbv1hvg1BJiOIEN7LFQtPL+NEEc17da/jSbOG3aGphCzUw
 lYlexH9TBloD91jxWNhooBvf79OUTPpRlEsgoZ1I+5h09L2WzVNjqFIVF/+EoIEmFx6i
 DRg1nuWYCNzJ9XiOxxPppTxya2r1uikyzSWpQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=iAj07EaWJAx9qCFS8RwXhzSoprTQdRkm0RG7VitREB8=;
 b=qsP/X4fa7Y8Oog+BbCPude1sKRk/qryn72zvwErJwJjzjLrE0aRY3MUDOKME2MH9Li
 HknuXuiTwC+eiX0FGUyTIkb2lL7kK03uz8rP08BuUe4BLoX9yx2I/lyNsMpK8IE9U2nu
 TrLueFoXbOSGV6R3bEmqfBdfDx+6iM1NM8eiMJa6sBWyUfjD4mOHOw2K3FxWjvaYaoq3
 YdB+nd2HcDA8It6wTXD7HB1JIvLkgV3+qZIwyK+NTH1ayasmQFFbLvphrlQo/HO35TkK
 k0aCZ9h5kBZAtVQxo6g+uk8vm5vEzuTfoaK2Cl7zz6ER7bL/wwfCY1AIQAO9AipNlDbn
 YCJQ==
X-Gm-Message-State: AA+aEWYanviBypTkiiVoUtjRMD28hY37uiDHMNyR4fzO1icQUnsH8pEq
 xNafLg7J4Rduzz/uLA9rWhIHyeMejZdCUgq+xt5qMw==
X-Google-Smtp-Source: AFSGD/XgSSX48RVjTstRoY7Va8vB5xphFf8cl2DCYrNX7LFiLwcgiWb30fcMLzPyygZtFkvHAjOe4bGongItvWmST9I=
X-Received: by 2002:a19:8d01:: with SMTP id p1mr10877094lfd.149.1544616211909; 
 Wed, 12 Dec 2018 04:03:31 -0800 (PST)
MIME-Version: 1.0
References: <20181211080759.3150-1-linus.walleij@linaro.org>
 <20181211080759.3150-5-linus.walleij@linaro.org>
 <20181212113025.GL30658@n2100.armlinux.org.uk>
In-Reply-To: <20181212113025.GL30658@n2100.armlinux.org.uk>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 12 Dec 2018 13:03:19 +0100
Message-ID: <CACRpkdYz9Fgvvt1kVN5AjrwDmsM6V0tYNRtoUQkBXNGOCSjS5g@mail.gmail.com>
Subject: Re: [PATCH 5/5] RFT: ARM: actions: Simplify secondary boot
To: Russell King <linux@armlinux.org.uk>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181212_040344_104902_C90B7007 
X-CRM114-Status: UNSURE (   8.75  )
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
Cc: =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Dec 12, 2018 at 12:30 PM Russell King - ARM Linux
<linux@armlinux.org.uk> wrote:

> Also, be sure to exercise the hotplug paths during testing, not
> simply "does it still boot".

Indeed. If the platform support suspend-to-ram then
echo mem > /sys/power/state
and then bring the system up again, as a specific
test that offlines all CPUs and then brings them back
online.

Yiyrs,
Linus Walleij

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
