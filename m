Return-Path: <SRS0=0Bxu=Q3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0E75C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 11:09:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF2952086C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 11:09:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jF0Fi+Eg";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="QY+lw8S7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF2952086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:References:To:From:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=peu900mcjZG4Z0irdpVPqKuz7dzscDU6gJKGrDm4CzM=; b=jF0Fi+EgKmE7C1
	gNNm0i87RmLdN7HjzwujFyCygvOyGUs3ENnNpKVefPieHYfJQ97ZineFdDwMLKfs3qvdbEAnq17B/
	I33cJUugIr/nMwBzA3tjC2IB7V3iLMCoU2im/ifs4APXB40+/MB5G+SqUJE/ciB+3spXCDnlfLYjQ
	v+sKVAPoLRV6AEFyu5RONfN90QMD8NVikA/5rMxT2CSHOH8Hfhs8PeYcIBvGPmIcU2BPtFXwL7ZRH
	6anU1XwEDkEp8XX5h83bYGtbyx4HCbvGri5HOv7kWEk2DeWo4juvz6KszLTrvygvCCs5RojKZa4+b
	2U1an+V5K1tfQ/cKx+VQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwPkH-0004qK-Df; Wed, 20 Feb 2019 11:08:57 +0000
Received: from fllv0015.ext.ti.com ([198.47.19.141])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwPkE-0004ps-DP
 for linux-arm-kernel@lists.infradead.org; Wed, 20 Feb 2019 11:08:55 +0000
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x1KB8oDk029927;
 Wed, 20 Feb 2019 05:08:50 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1550660930;
 bh=mVlporjq4skMvfcCfdL4D63EdEVV6/7AxnqS/qkvAyg=;
 h=Subject:From:To:CC:References:Date:In-Reply-To;
 b=QY+lw8S74B+6x4nD7xdrkdkJIxGAcRIqkTC9K/Z8JkpsfAZcwy3NkWF4CGUZcW+1j
 IZg51cx6uzwAqDGi+teMAqlAyuo+Bv7nGXLBlzRXMHlt1nIRrjIGpcq5S9+lVkbGdR
 l6NPDpC8074KqNR1aK6ZoCEFpNDeLmzFgasoqwko=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x1KB8o0l033769
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 20 Feb 2019 05:08:50 -0600
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Wed, 20
 Feb 2019 05:08:49 -0600
Received: from dlep33.itg.ti.com (157.170.170.75) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Wed, 20 Feb 2019 05:08:49 -0600
Received: from [172.24.190.172] (ileax41-snat.itg.ti.com [10.172.224.153])
 by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x1KB8lp8020174;
 Wed, 20 Feb 2019 05:08:48 -0600
Subject: Re: [GIT PULL] DaVinci SoC updates for v5.1 (part 3)
From: Sekhar Nori <nsekhar@ti.com>
To: ARM-SoC Maintainers <arm@kernel.org>
References: <26892a0a-c6c4-6409-44cf-1f407ac21482@ti.com>
Message-ID: <455ad8de-ad81-c716-679f-1e71e24ca642@ti.com>
Date: Wed, 20 Feb 2019 16:38:46 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <26892a0a-c6c4-6409-44cf-1f407ac21482@ti.com>
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190220_030854_490270_438D5F46 
X-CRM114-Status: GOOD (  15.57  )
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
Cc: Marc Zyngier <marc.zyngier@arm.com>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>,
 Kevin Hilman <khilman@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 19/02/19 9:05 PM, Sekhar Nori wrote:
> Hi Arnd, Olof,
> 
> This is a late request to pull some further SoC updates for DaVinci.
> The patches have been in the works for a while, but we received the
> final maintainer acks only yesterday.
> 
> I hope we can merge this for v5.1. We have further clean-ups for
> mach-davinci planned, and it will be good to get this out of the
> way.
> 
> I have run randconfig builds with a previous version of this series.
> I am running afresh with this branch too. The branch merges without

This is done and no new randconfig issues were found with this series
(10 random + 1 allnoconfig builds)

Thanks,
Sekhar

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
