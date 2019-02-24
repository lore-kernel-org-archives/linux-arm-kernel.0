Return-Path: <SRS0=QUhG=Q7=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 965CDC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 19:11:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5EF9D20663
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 19:11:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="aQawizy7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EF9D20663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i2se.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Subject:References:
	In-Reply-To:Message-ID:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=CnSkiwwSifN7JxNqBGxfasA904Ot339MLUtBIk1DkMw=; b=aQawizy7tQH0WY
	1gXwuWAUEexNkdxtHHLtOq+IN/bk7CrEYoiDzoA9CVEr5IST3tpDrzGYy3UZMEPtKWHNgURXj3+fc
	wV+OD1Wr6HDfZn13UvdUdmUKPuwdkwl5wT5Hnyo52r3sSTXjdv/XHt4W04yP5Kg4c+AIjY7CB/4Xo
	41dhf9Epmaz3+Pqew/ko4wuQ06tUx3ls3CA6dxtsldrxONqvrUDDJF991xKSLcObQizEOKQ3cAvDE
	X+5KEWkertROnLijRKKV6I7IJUY32swJuIFVEEY8oZuld7F26rEw6oKyICe+bLnSqzWRyVOaI76rf
	O7EC17170qa9DRXdn0cg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gxzAm-0005TS-QJ; Sun, 24 Feb 2019 19:10:48 +0000
Received: from mout.kundenserver.de ([212.227.17.24])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gxzAi-0005ST-9u; Sun, 24 Feb 2019 19:10:46 +0000
Received: from oxbaltgw01.schlund.de ([172.19.246.7]) by
 mrelayeu.kundenserver.de (mreue106 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1N33ZD-1hA6l90qCr-013NyN; Sun, 24 Feb 2019 20:10:38 +0100
Date: Sun, 24 Feb 2019 20:10:37 +0100 (CET)
From: Stefan Wahren <stefan.wahren@i2se.com>
To: kernel@martin.sperl.org
Message-ID: <146076124.93355.1551035437078@email.ionos.de>
In-Reply-To: <20190224162311.23899-3-kernel@martin.sperl.org>
References: <20190224162311.23899-1-kernel@martin.sperl.org>
 <20190224162311.23899-3-kernel@martin.sperl.org>
Subject: Re: [PATCH 3/3] spi: bcm2835: add module parameter to configure
 minimum length for dma
MIME-Version: 1.0
X-Priority: 3
Importance: Medium
X-Mailer: Open-Xchange Mailer v7.8.4-Rev51
X-Originating-Client: open-xchange-appsuite
X-Provags-ID: V03:K1:n2oYlDJCCjJVoNt0z7XlcMW0M+QEa9JRiJ3bOZJDYEU9UemOFJe
 fnbm8Fr3vnpuo4IvS1ENrFXWJ0kpwnzk0MtEMtSfH1oWp7AuWDLgtkFAnDW2goG2xDBY7Uq
 yOFTIAsESWRTUnR5X1buxjRlHDrqDGDeTR8sRCb8yGxrP3FD+cGmC/8tgdf5D1OjNADy+xv
 mhZ0zrCK58nrEUuxiN+sw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:m2+/QjzZEiA=:6zwp2pCxbJIQhVkyKcY0Rv
 r9S3DJdCCAKyaFdV/5ZmCt8/v97h+Pe8HyaRmNu1IQ+U3uiimZVpbpj6fuNxFh/A3ByMwV/46
 5r8FbUcuKPaJRx+5sx9EW6ECIEOVZwBCImVXc9tCq0yVpvgJucLThrd2+7cBgssvLfyjOlV4M
 SJFwNJtaF1CB+24cEm7Haq+W/9MUDy3rtxtwXY7i9mvWszQEhUMhYSLKqGOY855GbxjJvMiOV
 KH3gSh3nKDhZASvoPryHSrLW1UAZfTB7r8BDfy+PEqtE0gC+xtsjE7ihbBpumBT73uFz8iASo
 sIyMAdYZ8jCPV2dvb+bfuMg7LqLIHBtxLdM0j6xw88oMqXgGTKGJ+9D24tAzENW+Kp4l31ObV
 piFHwE8h66R0My2kS3pOtLkHfNIu10iw6M85Qe6KQqIknnhSf+d9OhusuT2t+BksOv70SETNz
 eNJIyUGwXux/5DhSyQxr2yJrcF6xQtgO2aWUa+mYkB2BeFT0jT/1P0Tbe8N2ht6Pjb4HTRP7o
 BqYDumcPCwU2KjrVoN76vnwED+IHFigL60UFqWuUy6wQerdF6KKhy4XdfLDYC+GNtktBAm37k
 iaS8T1gx+tf/3/Ad50gsghRf5Av/4M+3MDsT1Y9OlZwVK4OgEq/0JtAJDMV7gUpP2d2FYaKxe
 3PpW8WDUJxB8WpYiwAkVckUb2OCfY9wVOYqdC3TLR7OI7md6BDtDvwE9J1s4k5ZduAmVXfvHn
 3q+Eb/VxNWxnB/Ce5nhLIgEzdbCcY5NN1l5WlxuN0uv+bDM412GTny/IGxY=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190224_111044_929658_D1E495B8 
X-CRM114-Status: UNSURE (   9.84  )
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
Cc: Eric Anholt <eric@anholt.net>, Mark Brown <broonie@kernel.org>,
 linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-spi@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Martin,

> kernel@martin.sperl.org hat am 24. Februar 2019 um 17:23 geschrieben:
> 
> 
> From: Martin Sperl <kernel@martin.sperl.org>
> 
> Allow setting the length of the transfer at which dma is used by
> setting a module parameter.

please provide the motivation of this change.

Regards
Stefan

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
