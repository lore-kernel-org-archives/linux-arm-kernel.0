Return-Path: <SRS0=B2vk=P6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 638CDC282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 17:12:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3282D2085A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 17:12:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WssOUBiU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3282D2085A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=public-files.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:References:In-Reply-To:Date:Subject:To:
	From:Message-ID:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=EN+ftgAJSDkeaDtZjnsvSBkl2XE/zJDUkHgGg9aXPEo=; b=WssOUBiUI7nAbf
	uiM5f0jnqhp+m9w7hYUMYrP0YHqibSRHzx1eh8XZrT7WD+qlg52Ogre8cfZ6ki7XNr/Ekl2wSrmX+
	3rrcbxxPn035BzLWIVS4Fluva3ZioFlCD4uxHus6aS6aGpW2lMoYroj8rEiPgNDsMMosJcKJ+R9Fg
	YbR1Cxia5l1GWElZqn/ZIfDFTIii1tBt2sg5CjoyYYhiwv9vHOmQn6pl6vTQZ3TCV7ynN//WLTZXX
	edD7Ij9RRbj/7ROpmtxnYF+v/x4sVrVfsL2ImAJvnd6KE1j7A37lDoVJZroklunVAn7Dn6C6N5s2Q
	BnyJYbaZVOcbEQrQ8VDw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glzap-00011e-D3; Tue, 22 Jan 2019 17:12:07 +0000
Received: from mout.gmx.net ([212.227.15.15])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glzal-0000vj-DE; Tue, 22 Jan 2019 17:12:05 +0000
Received: from [91.14.89.174] ([91.14.89.174]) by web-mail.gmx.net
 (3c-app-gmx-bs21.server.lan [172.19.170.73]) (via HTTP); Tue, 22 Jan 2019
 18:11:53 +0100
MIME-Version: 1.0
Message-ID: <trinity-72bd264f-d4e0-444d-ac33-b708a0fc6503-1548177113835@3c-app-gmx-bs21>
From: "Frank Wunderlich" <frank-w@public-files.de>
To: "Joerg Roedel" <joro@8bytes.org>
Subject: Aw: Re: [BUG] "access dev->iommu_fwspec" cause crash on BPI-R2
Date: Tue, 22 Jan 2019 18:11:53 +0100
Importance: normal
Sensitivity: Normal
In-Reply-To: <20190122164916.r343pqa2dtopzrxo@8bytes.org>
References: <trinity-76e7f2ce-27ce-4f3b-809f-7da9a35e5210-1548173349245@3c-app-gmx-bs21>
 <20190122164916.r343pqa2dtopzrxo@8bytes.org>
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:J8WEYEdymEMW3hMNqeHsxUdQvQOrZ1PrHBqxFaRB6xGSetdSgLugzWKIAXdedqaMGZ5dm
 nEwrP/76eI+NIviE3FBf6JZeK4HW2J0FjlrroTrVxXohBIzAC11L1q5kGTTzA1HE9eTs4HT5udxC
 H7+KKFLwnCKRQGEVsOuY/Y8aUdqYKJgBZaq1+MwG5vFdJrVQAswWHGOF/QZ7cg62JI/x9phvZM0J
 hgFqrBqtFJiY/T9xtDe+8tN9LUYHD8RXbNPcIt5FdiiKYl/0fdLXCsUwJ/f/jCjw6a62dSzo+fRp
 2g=
X-UI-Out-Filterresults: notjunk:1;V03:K0:Y3hlLel7LSc=:7oXWQfPdYu5gvfgtMkCnIc
 AATP0fcV8p/QqBUIx77fj1IEA8Pw5j9IIXx4NHhauaOUJRUXVcKco0/jP0tSutoYsamUN9Unq
 8EVexWeejdQ468mr7g+xdSJHCnHaYB0Qbq/Qv4Pg+s02p9rwuA8b3rsUDzZhyd8rbA1cPGv/0
 kAPa78NNZJua7MJBZ7nJ6VBGEQomjlv3xGQBJ6tPLvyOllVV7DOktYiHd0HlbmbiB8WgmIrDK
 IbVvMA0ww1LPkPCFfrwFvOeN+dnqDNQII27IPYpSOlmTTcaMLvH0TMOUci1HqCQXeOTy11/6+
 SanZ6J0C2XLFOS0jrearCHvs5GYGkmZvh6iTOgM3aXmU5bIKga1dKNxZQ0hLcLqy6FyXf4sFD
 ZoYOWcRPTs9WMfhqyMUB0GvEQXGEh3APaJDaJQoHxPASGA7zL2J8ZiHwWrQVHHybqJgc6MY7J
 Ruqlw+O5nDeyTcGITR/yf5aG3ZOOwu5RZkzmyGMEoIrAi0ST3MbxjW6DkIazNnSj9joxi4WB9
 o/ZjdIre++ijjItMe3QCyZPoiXtSi+z/DgieMhLwQoxC1W0IH5otaS6+frQSysk76B0MyWJ69
 dRI3nR0mEWcjE=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190122_091203_745223_CFE8FD75 
X-CRM114-Status: GOOD (  14.31  )
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
Cc: Ryder Lee <ryder.lee@mediatek.com>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, linux-mediatek@lists.infradead.org,
 Matthias Brugger <matthias.bgg@gmail.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi,

thanks for quick reply, this seems to fix it

no crash, xserver works, like revert of the commit...pushed the fix to below github-repo

regards Frank


> Gesendet: Dienstag, 22. Januar 2019 um 17:49 Uhr
> Von: "Joerg Roedel" <joro@8bytes.org>
> An: "Frank Wunderlich" <frank-w@public-files.de>
> Cc: "Matthias Brugger" <matthias.bgg@gmail.com>, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, "Ryder Lee" <ryder.lee@mediatek.com>
> Betreff: Re: [BUG] "access dev->iommu_fwspec" cause crash on BPI-R2
>
> Hi Frank,
> 
> thanks for the report!
> 
> On Tue, Jan 22, 2019 at 05:09:09PM +0100, Frank Wunderlich wrote:
> > Hi,
> > 
> > the following Patch breaks hdmi (at least) on Bananapi R2 (mt7623):
> > 
> > a9bf2eec5a6fc01a0a5250eaf0bf61dfd382a78a "iommu/mediatek: Use helper functions to access dev->iommu_fwspec"
> 
> Does the attached diff fix the issue for you?
> 
> Thanks,
> 
> 	Joerg
> 
> diff --git a/drivers/iommu/mtk_iommu_v1.c b/drivers/iommu/mtk_iommu_v1.c
> index 6ede4286b835..f60bdb85c4c0 100644
> --- a/drivers/iommu/mtk_iommu_v1.c
> +++ b/drivers/iommu/mtk_iommu_v1.c
> @@ -442,6 +442,10 @@ static int mtk_iommu_add_device(struct device *dev)
>  		iommu_spec.args_count = count;
>  
>  		mtk_iommu_create_mapping(dev, &iommu_spec);
> +
> +		/* dev->iommu_fwspec might have changed */
> +		fwspec = dev_iommu_fwspec_get(dev);
> +
>  		of_node_put(iommu_spec.np);
>  	}
>  
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
