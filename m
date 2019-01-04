Return-Path: <SRS0=E6Hv=PM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 574E7C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 08:15:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2435F2184B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 08:15:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="AN4trYuZ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="OYXvvAWw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2435F2184B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=/s3tte4OZb5OubOEIau8pnI3ZVL6zeLf7ToGbkwAldE=; b=AN4trYuZVEgmY+
	8g908ZzZlxYyboJMhP+B0Cf+ap1HN7vlDcabkhPhIBCH3TYtCZ0MK9lGSm7QfJVak94ULC9F0q3C3
	ZeGbIqbXqM2kl8OtOAT42rCudbOtsZ5IxBoJRgumxJiQVBmmP9DxnXYefuvT8gdSi1r7kWupV5yjQ
	5276O75Ws20vY2vd9XZM8z7huYlf3M2eeQ1TBr9kUyLI1gD+gSoFholvFNTGTj3iOjVjUEhZQc4BO
	yM2ksojMnpqnKCLv+wVqlkCCYGsGsBnbEWjlGaKEabNNc7m3haqtJugTO39Fqan+ydYfRb7JEZnh9
	YmBw6ofab8PYcRMviOkg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gfKdo-0001tU-Ph; Fri, 04 Jan 2019 08:15:40 +0000
Received: from lelv0143.ext.ti.com ([198.47.23.248])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gfKdm-0001sz-7a
 for linux-arm-kernel@lists.infradead.org; Fri, 04 Jan 2019 08:15:39 +0000
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x048FPVx038962;
 Fri, 4 Jan 2019 02:15:25 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1546589725;
 bh=vbvrVJNwKIKhkHxnypRDchy5NV72bmiqD460jYFEfgI=;
 h=Subject:To:CC:References:From:Date:In-Reply-To;
 b=OYXvvAWwi7XZLftbds86PBb2TUstTxD6l/O85mmwUlM+A/kqJ0K/hktZsHCqyqeqn
 zWLhpa+9GTkODmz/RiNVdBe7CCqjQIWesFCmSIm0bCKqvU7GHOubGOc9ZYL3uPap1f
 O/0/5cQwSofUH2mNGOFwCTE27dp1wQcSTcx8vSOE=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x048FPtA062821
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 4 Jan 2019 02:15:25 -0600
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Fri, 4
 Jan 2019 02:15:25 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Fri, 4 Jan 2019 02:15:25 -0600
Received: from [172.24.190.172] (ileax41-snat.itg.ti.com [10.172.224.153])
 by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x048FMNr004915;
 Fri, 4 Jan 2019 02:15:23 -0600
Subject: Re: [PATCH 0/5] ARM: davinci: fix label names in GPIO lookup entries
To: Bartosz Golaszewski <brgl@bgdev.pl>, Kevin Hilman <khilman@kernel.org>
References: <20190103151104.11839-1-brgl@bgdev.pl>
From: Sekhar Nori <nsekhar@ti.com>
Message-ID: <a404f59d-6abd-2711-1f4e-0824489a27ad@ti.com>
Date: Fri, 4 Jan 2019 13:45:22 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190103151104.11839-1-brgl@bgdev.pl>
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190104_001538_356841_BDEC44E3 
X-CRM114-Status: GOOD (  14.00  )
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
Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 Linus Walleij <linus.walleij@linaro.org>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, "Andrew F . Davis" <afd@ti.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Bartosz,

On 03/01/19 8:40 PM, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> Hi Sekhar,
> 
> I noticed some more breakage resulting from commit 587f7a694f01 ("gpio:
> davinci: Use dev name for label and automatic base selection"). This
> series fixes GPIO lookups in legacy mode for DaVinci.

Thanks for the fixes, look good to me. Will send them once v4.21-rc1
comes out.

Thanks,
Sekhar

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
