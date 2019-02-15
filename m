Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4264C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 15:16:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B23302177B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 15:16:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="tOSkVgxP";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="s9jAQbIc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B23302177B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=J26x21PQIT4UAUtlKk9lGCSZglVpyRBesNYjwZ44CJ4=; b=tOSkVgxP37YUNv
	fE5SlYIBmjqGAjUyyGlK7aDoS2oJFaX0eJ/qcricCQjlcIHb+njn8QYSDGTj0WZB3/5NevjqdAHe6
	HvQ+KTH8ujw9aWiw/nrLYjyWle2iSz0jiCGu9qVyCJiFH+dXR0CcHXSbsndumTFXRyNHXp5E5UiSa
	65Kx5fb02OsLdJdswgJ6NbX0eVuil6/1c/qxpq6YVdFBt+6xYtHFxC5tFlqWpFsDdDydegxlru4EJ
	QPXuXde5ct8l5ZwXCRugbUHeHoCHEPB+V9dj8CEG10m8+Xzy7YDxbTevhVvL8IiYEXuRbBtBj7pKV
	BaavTBXEOqi4u+JpIXPA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gufDh-0004Eq-Ud; Fri, 15 Feb 2019 15:16:05 +0000
Received: from lelv0142.ext.ti.com ([198.47.23.249])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gufDZ-0004Db-5c
 for linux-arm-kernel@lists.infradead.org; Fri, 15 Feb 2019 15:16:03 +0000
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x1FFEkwX031255;
 Fri, 15 Feb 2019 09:14:46 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1550243686;
 bh=kr/yj/ET7r+MTu59LeUQG+eCRdcH88hQiZBun5d/RDU=;
 h=Subject:To:CC:References:From:Date:In-Reply-To;
 b=s9jAQbIc4BvxFBIZuhqT4iyuxWR88VBhtiWxosS87aDcitHiCux0HSHV4eIJHzvnV
 eMflI+N8NzPUolahJcfoZtX9gqExBtwonCAqEpavd2ERlxHU7Ii/NzNNt3JTFyYCZw
 1vN49eXiysZhMN7CaENRobCq/qSUshqtDXi2dVdM=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x1FFEkPS055739
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 15 Feb 2019 09:14:46 -0600
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Fri, 15
 Feb 2019 09:14:46 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Fri, 15 Feb 2019 09:14:45 -0600
Received: from [172.24.190.172] (ileax41-snat.itg.ti.com [10.172.224.153])
 by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x1FFEgd4021428;
 Fri, 15 Feb 2019 09:14:43 -0600
Subject: Re: [PATCH v4 00/37] ARM: davinci: modernize the irq support
To: Bartosz Golaszewski <brgl@bgdev.pl>, Dmitry Torokhov
 <dmitry.torokhov@gmail.com>, Kevin Hilman <khilman@kernel.org>, Thomas
 Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc
 Zyngier <marc.zyngier@arm.com>, David Lechner <david@lechnology.com>
References: <20190214145231.8750-1-brgl@bgdev.pl>
From: Sekhar Nori <nsekhar@ti.com>
Message-ID: <afb69b1f-0c6b-7109-9e1d-edc49adf40f2@ti.com>
Date: Fri, 15 Feb 2019 20:44:42 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190214145231.8750-1-brgl@bgdev.pl>
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_071601_987751_A19770CF 
X-CRM114-Status: GOOD (  20.80  )
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
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Marc,

On 14/02/19 8:21 PM, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> This series ports the davinci platform to using SPARSE_IRQ, cleans up
> the irqchip drivers and moves them over to drivers/irqchip.
> 
> The series can be logically split into five parts. The first patch
> preemptively fixes a problem in an input driver that would have caused
> problems later. Patches (2-9) aim at introducing support for SPARSE_IRQ.
> They contain a couple changes required for that functionality and do some
> cleanup at the end.
> 
> Third part (10-22) makes the aintc driver suitable for drivers/irqchip
> and eventually moves it over there.
> 
> Part 4 (23-36) does the same for the cp-intc driver.
> 
> Last patch removes unnecessary code.
> 
> The series has been tested on da850-lcdk (for cp-intc) and
> dm365-evm (for aintc).

Do you have any further comments? If no, I would like to apply for v5.1
with your ack.

Thanks,
Sekhar

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
