Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8272EC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 16:33:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 529972190B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 16:33:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="P2WuI0KX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 529972190B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=P6glTFAcVx+xqpr9cFQFF6P8nOI8RqFtkPQSdy7Kgco=; b=P2WuI0KXUjYY+z
	49/7IoEa/OGv9FKf53A2wCOw+7gwrliDqm3igIR1gcRImjvVAcG1dvJPr1W0QkBALntiKVkUdmQ7K
	JHDOl3mQQ/rHM+HXwqUVTrApZRJehroX4baCUfqcbJ3wujFXzgXVAtxkqLbrwivw+pnFwIZIjGWwD
	V+aDub4MdaRSxT30refH7dEIFmuzqoyVB0R3THxcyapzelBgSR+1VH/9LbKwMtjnHDJqFUxjyuWbL
	lUVjMJUPdrMTuXSirWtSi+vYBQ8inxirRYjoxG3dBO4slu+dlR8Vl7RrGjAVCu7Jnojin5kkoPyS+
	+7fRo7q8rINgep1hMUiw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gugQI-0003t4-Jl; Fri, 15 Feb 2019 16:33:10 +0000
Received: from mail-qk1-f194.google.com ([209.85.222.194])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gugQF-0003sl-Kx
 for linux-arm-kernel@lists.infradead.org; Fri, 15 Feb 2019 16:33:08 +0000
Received: by mail-qk1-f194.google.com with SMTP id f196so6009406qke.10
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 15 Feb 2019 08:33:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=VUlDYYODRGR8Xxqz4ETkRC77aezmR5kmciVOYqvTkSM=;
 b=sl48BM2OA2ciJXetxJfEZ9RA1dKE4IBGEJn/l9xNwb9EqPk4HXnS8Z2T77nTEC3rsf
 AMpRK1Qy+xkTD0E0zJ77G7HMWo2vZvefvEyI9DEdykb0U47AOUDiMCoBG1c9qnCKh8Xi
 iVdhRFXnds21LP5mmL2b9rNevg5x3sH+o0sIvBhp8m8Md9bzrmEwrLwtxFFp+AYxCNkW
 +bwRtl0+5Nzn+FvMSQHc9wgcZH9x6qI7rlqea55SY9gPV5yU1rm2x+gAVxIXvokkzW00
 TE+5jrYg7PeoR1Uc3x3/bVYA7x0UhTj69zMiZVILBJMdK0CbZsxuBpBu1f038vxhlGLP
 up4g==
X-Gm-Message-State: AHQUAubhAaSepFFYD6RrRYzWIOnd3nfv/snX8f2OL1WWzWyZKSA76jXq
 sKNhkKW66GzFpg1Z3m/zBLzaxwBYOVSocKYdAsw=
X-Google-Smtp-Source: AHgI3IZwlRef9k3WxhbNU8ix9Zdx1j6plXsJwE+XWNrlDYSMp6dwaYibXOOCSvYfEwVT2FIC6auCqOrE/euRCLiQNZg=
X-Received: by 2002:a05:620a:12a5:: with SMTP id
 x5mr7691909qki.291.1550248386797; 
 Fri, 15 Feb 2019 08:33:06 -0800 (PST)
MIME-Version: 1.0
References: <d047bba8-3d2c-7937-78f9-ef5feb0a33be@hisilicon.com>
In-Reply-To: <d047bba8-3d2c-7937-78f9-ef5feb0a33be@hisilicon.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 15 Feb 2019 17:32:50 +0100
Message-ID: <CAK8P3a1a0tOTjGCRJVytK44-bmPOOCppuhe9+UNXuuUbgSbNCw@mail.gmail.com>
Subject: Re: [GIT PULL] arm64: hisi: SoC driver updates for v5.1
To: Wei Xu <xuwei5@hisilicon.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_083307_687294_872CC20B 
X-CRM114-Status: UNSURE (   7.44  )
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
Cc: Salil Mehta <salil.mehta@huawei.com>, jinying@hisilicon.com,
 Tangkunshan <tangkunshan@huawei.com>, John Garry <john.garry@huawei.com>,
 Linuxarm <linuxarm@huawei.com>,
 Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
 yezengruan@huawei.com, arm-soc <arm@kernel.org>,
 huangdaode <huangdaode@hisilicon.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Olof Johansson <olof@lixom.net>,
 "Liguozhu \(Kenneth\)" <liguozhu@hisilicon.com>,
 Zhangyi ac <zhangyi.ac@huawei.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 Shiju Jose <shiju.jose@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Feb 8, 2019 at 11:14 AM Wei Xu <xuwei5@hisilicon.com> wrote:
> ARM64: hisi: SoC driver updates for 5.1
>
> - Add compatibility support for different FWs in the hisi LPC bus driver
>


Pulled into arm/drivers, thanks!

     Arnd

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
