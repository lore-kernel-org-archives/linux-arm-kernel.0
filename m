Return-Path: <SRS0=CPNf=QT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3894C282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 08:25:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D0CB2070D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 08:25:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ABzxs9QW";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="lwO80HSm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D0CB2070D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=wdoSPaCaUgnTn4EzzGTyg/n2JRJ0QfjRmff0QA5z02Y=; b=ABzxs9QWvzojLl
	eqodLto4pizPTlrHsp0zNVwAXB9POoztayjw1twO0tkh7Pf8htzQPifb6RVm/9f3bySN8w4nA77ii
	pHNJrJ4jMvabPFWMgUy2enNslGikAnV5AlhexXIBxK8fWFWoMkPJISQ6mQwh1l1KuuYqLCuSmLBO8
	Ul60NizT670I5lttsSi+TC3Frf0Dx5rQvqtivSCPJn6KjDrAK3V6/C6ei2KCPimunopGt1HVNg3MY
	bK2K3lWYrK0YrmgksCT+rT410PqgHf9kWKsz58N5EzfPOZvgQXeAzhT34+fLpSyBJdnhGjTykZ0xu
	AISjLYLHQXvI+5Hw23GA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtTNp-0000pV-8w; Tue, 12 Feb 2019 08:25:37 +0000
Received: from lelv0143.ext.ti.com ([198.47.23.248])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtTNa-0000kd-TP
 for linux-arm-kernel@lists.infradead.org; Tue, 12 Feb 2019 08:25:28 +0000
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x1C8OBYx029956;
 Tue, 12 Feb 2019 02:24:11 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1549959851;
 bh=IpuQ1fod8zBY4+LMvrI8N0OYgFve4HTqRq42722JrOI=;
 h=Subject:To:CC:References:From:Date:In-Reply-To;
 b=lwO80HSmU/vXCdCjF7xU2878vndsM48q1UbUsTaKcgH7SIf3XbyAy+5YdHYs3JJfB
 W3twLDM6FbM8rYfrvjAG03Lh1ZC+ieVC0B9xH/F/mYTyVt9XhXRAZzKGXAAB0Q/IIN
 gkCZnPKcNiMLcLhQliS4A59nRi1jaRWUED5hezeE=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x1C8OBpe106760
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 12 Feb 2019 02:24:11 -0600
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Tue, 12
 Feb 2019 02:24:10 -0600
Received: from dlep33.itg.ti.com (157.170.170.75) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Tue, 12 Feb 2019 02:24:10 -0600
Received: from [172.24.190.172] (ileax41-snat.itg.ti.com [10.172.224.153])
 by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x1C8O67P020205;
 Tue, 12 Feb 2019 02:24:07 -0600
Subject: Re: [RESEND PATCH v2 00/33] ARM: davinci: modernize the irq support
To: Bartosz Golaszewski <brgl@bgdev.pl>, Kevin Hilman <khilman@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>,
 Marc Zyngier <marc.zyngier@arm.com>, David Lechner <david@lechnology.com>
References: <20190211122606.8662-1-brgl@bgdev.pl>
From: Sekhar Nori <nsekhar@ti.com>
Message-ID: <a333fac0-955e-d04a-6076-42a5b6edda34@ti.com>
Date: Tue, 12 Feb 2019 13:54:06 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190211122606.8662-1-brgl@bgdev.pl>
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190212_002523_070147_9FD28F65 
X-CRM114-Status: GOOD (  17.10  )
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

On 11/02/19 5:55 PM, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> NOTE: resending due to missing irqchip maintainers in Cc
> 
> This series ports the davinci platform to using SPARSE_IRQ, cleans up
> the irqchip drivers and moves them over to drivers/irqchip.
> 
> The series can be logically split into four parts. The first (1-8) aims
> at introducing support for SPARSE_IRQ. It contains a couple changes
> required for that functionality and the final patch actually selecting
> it.
> 
> Second part (9-19) makes the aintc driver suitable for drivers/irqchip
> and eventually moves it over there.
> 
> Part 3 (20-32) does the same for the cp-intc driver.
> 
> Last patch removes unnecessary code.
> 
> The series has been tested on da850-lcdk (for cp-intc) and
> dm365-evm (for aintc).

There is build breakage in drivers/input/keyboard/davinci_keyscan.c
after this series due to <mach/irqs.h> removal.

Thanks,
Sekhar

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
