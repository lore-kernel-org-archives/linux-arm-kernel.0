Return-Path: <SRS0=AHqO=O5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 945FDC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:03:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61EE02176F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:03:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ScW5ZfWP";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="D9Q9GkTp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61EE02176F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=xeqs+IpsS/brDvDPNEo1T4uqFfcb5iYOcnV4yimceas=; b=ScW5ZfWPn5CtPL
	uK9ldR9RyNAZSf8Afz7rZqtc5C/uOTopYcBsLrJNmShOMPT76eZN8ONb9Lz8X/XCGTP/9uWQbJqj3
	nYR1crfWOpgwudRKrPgecZ6l/Qp0mpi12snPJqQ9l/ROQX6javONehd/1359I1LFUDQrXULEHGDT4
	UZZgX0bnG0uccKkfaqRKaWFcAahv2R5+kF0LcUQvS3m+LoAPVem+xplvk7DHvuDgxAEGc3p4rX9Cg
	wXUD4Z7o5CdBn+cvtxtlDxkQUOOxoXPZbVLMW3BjWdNouEKsIOm2/ANMm+2NjXR8ahxCd8IVbM1Aj
	8hLjYoZvymmh1bzurfQQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZuEx-00073s-Bg; Thu, 20 Dec 2018 09:03:35 +0000
Received: from lelv0143.ext.ti.com ([198.47.23.248])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZuEp-00072p-Vm
 for linux-arm-kernel@lists.infradead.org; Thu, 20 Dec 2018 09:03:33 +0000
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id wBK931PR046797;
 Thu, 20 Dec 2018 03:03:01 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1545296581;
 bh=je64GQv5fkJQoxiJSkHiUO/szatxLAvDbpDZvhS7foU=;
 h=Subject:To:CC:References:From:Date:In-Reply-To;
 b=D9Q9GkTpcvHaTnr5n4jzu3X+uz0yZksXlwz7RTWYhqyZt7K9BSAlE9YyXex/ZsMX6
 1034KDRQgSVTEBrglYomn3DhhgnFsABARVeH4JutndofESAzGWz6a7yDdxIC9jcmCH
 6fqW4HF6TEYTXinqMFi7Em7CIxO07IfztEIkruqU=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wBK93189026475
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 20 Dec 2018 03:03:01 -0600
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Thu, 20
 Dec 2018 03:03:00 -0600
Received: from dlep33.itg.ti.com (157.170.170.75) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Thu, 20 Dec 2018 03:03:00 -0600
Received: from [172.24.190.172] (ileax41-snat.itg.ti.com [10.172.224.153])
 by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id wBK92vPn030184;
 Thu, 20 Dec 2018 03:02:57 -0600
Subject: Re: [PATCH 0/9] ASoC/ARM: Merge the davinci and omap audio directories
To: Peter Ujfalusi <peter.ujfalusi@ti.com>, Mark Brown <broonie@kernel.org>,
 Liam Girdwood <lgirdwood@gmail.com>, <jarkko.nikula@bitmer.com>,
 <tony@atomide.com>
References: <20181217122142.6652-1-peter.ujfalusi@ti.com>
From: Sekhar Nori <nsekhar@ti.com>
Message-ID: <4c9085db-3c55-49ee-30d3-46dca84e28ca@ti.com>
Date: Thu, 20 Dec 2018 14:32:56 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181217122142.6652-1-peter.ujfalusi@ti.com>
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181220_010328_103560_1F61FBEB 
X-CRM114-Status: GOOD (  11.00  )
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
Cc: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, jsarha@ti.com,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 17/12/18 5:51 PM, Peter Ujfalusi wrote:
> Mark, Tony, Sekhar: This series - as I mentioned - is based on next-20181210.
> Not sure what tag, branch, commit  I should base this, but I can resend v2 if
> needed.

For the series:

Acked-by: Sekhar Nori <nsekhar@ti.com>

Looks like Mark has already applied it, but just for the record.

Thanks,
Sekhar

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
