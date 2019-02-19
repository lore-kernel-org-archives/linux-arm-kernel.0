Return-Path: <SRS0=g9E6=Q2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ADEBC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 15:39:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3AAB921736
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 15:39:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ks/3vzVm";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="qVwk40yt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AAB921736
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=f9QYfZwG7ahsoAzxYLo8cc2k7NSKkLqUa2eK7MXojM8=; b=ks/3vzVmafv9em
	VtAgROB+xWNbv+iNSbtj/cE79Nv3UkxrZBTQ85RGkkR9sxY4AHDqhe/7MbKNTI5E1oKP8z6yM9l/y
	iwXrVM3x32sgFPU5XqcXc1hi4/h+OYScAnesA+KR3fpkdNQb0hz3263jmjw7F6UFpDgVa4dRfI4Cc
	YDw2QHlPDqQeOJ41KnvXe26h3qpocHs9DfVu7yIKiQIPTxWYJf/mxTGTqaoSRaYz2+Qe4PVZB1VxT
	WGTW7etuLyHiJ4jsm2JXL+YNc7J1c1vNeUlclzWrJKPGB6VZL//Afdv56XulPzjwktWDeUi2WrvRJ
	obWcqieNQ/3PZ8yLGRsw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gw7UC-0001QO-AW; Tue, 19 Feb 2019 15:39:08 +0000
Received: from fllv0015.ext.ti.com ([198.47.19.141])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gw7U9-0001PT-2Y
 for linux-arm-kernel@lists.infradead.org; Tue, 19 Feb 2019 15:39:06 +0000
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x1JFbpMu060338;
 Tue, 19 Feb 2019 09:37:51 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1550590671;
 bh=hnvZJtegWLECBhjPNzRPr6bR5VltYK+jPOgwcvEjvyw=;
 h=Subject:To:CC:References:From:Date:In-Reply-To;
 b=qVwk40ytihrxepnF0EJIx8doVX16TALQ9yf6SMb8ttuuH1jW+SL1NBFQ0jwEXL15B
 c4/jzL5IL8xd3+Myvcjf6+XkoWvcETYLz8FSACmaxjY9n13BpbSYd8NFHtNPeibR3X
 icvKWYjB4MAlN2ZFU50dKWHSiurfkZc+Q5KmN/Dk=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x1JFbpa6026871
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 19 Feb 2019 09:37:51 -0600
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Tue, 19
 Feb 2019 09:37:51 -0600
Received: from dlep33.itg.ti.com (157.170.170.75) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Tue, 19 Feb 2019 09:37:51 -0600
Received: from [172.24.190.172] (ileax41-snat.itg.ti.com [10.172.224.153])
 by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x1JFbm0D024238;
 Tue, 19 Feb 2019 09:37:48 -0600
Subject: Re: [PATCH v4 00/37] ARM: davinci: modernize the irq support
To: Marc Zyngier <marc.zyngier@arm.com>, Bartosz Golaszewski <brgl@bgdev.pl>
References: <20190214145231.8750-1-brgl@bgdev.pl>
 <20190218141820.78bfaef5@why.wild-wind.fr.eu.org>
From: Sekhar Nori <nsekhar@ti.com>
Message-ID: <051aa5f0-7f13-1b07-f843-b8652a85e0b0@ti.com>
Date: Tue, 19 Feb 2019 21:07:47 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190218141820.78bfaef5@why.wild-wind.fr.eu.org>
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190219_073905_155884_F69B8991 
X-CRM114-Status: GOOD (  14.75  )
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
Cc: David Lechner <david@lechnology.com>, Kevin Hilman <khilman@kernel.org>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-kernel@vger.kernel.org,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org,
 Jason Cooper <jason@lakedaemon.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 18/02/19 7:49 PM, Marc Zyngier wrote:
> On Thu, 14 Feb 2019 15:51:54 +0100
> Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> 
>> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>>
>> This series ports the davinci platform to using SPARSE_IRQ, cleans up
>> the irqchip drivers and moves them over to drivers/irqchip.
> 
> [...]
> 
> For the irqchip parts:
> 
> Acked-by: Marc Zyngier <marc.zyngier@arm.com>
> 
> Please route this via the appropriate tree.

Thanks all of the reviews and testing. I have added acked-by and
reviewed-by. Also made some changes pointed to by David locally.

Pull request sent to ARM SoC maintainers.

Thanks,
Sekhar

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
