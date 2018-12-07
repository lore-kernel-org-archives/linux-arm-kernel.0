Return-Path: <SRS0=cUnb=OQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E38FEC07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 17:41:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A72DC20838
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 17:41:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="CsoGJ26J";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="0gwvVapH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A72DC20838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=bnnTf7p2/fBJTCaTFV+Vn/eO8SXpQ7ezwJQoxTlPpNs=; b=CsoGJ26JeU4d17MqkiHRY663h
	0vNk/R1xzVAYQGcKKNuIy+hgxbu//P9vHISkLg76r3c/7h4rW0FesynqIoMxUGHLrji6qCVlk39mG
	m+xkbgy6t7y60JiJ2OczFsI5KrrpnTEdJl3HBSgivWCPpEZTd4rH9bvU7XPPsC4qjLRrIU/LPBQ+B
	t9Tj8td6LMNbx/wP3utyyTlQ/5gFg0ttB3sbpUhytwEPHkVpodVkNrMQY7RkHV76r74op12Q7DGrT
	sgRwFuLULf3D4OfJ4GNUV0L8Khh3erXZy2RXBZ8djBPqxLGQ6hpf60KDUcP/VUX1gTsyA6eYAcdik
	SESRyU7LQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVK8T-0006B1-Sy; Fri, 07 Dec 2018 17:41:57 +0000
Received: from userp2130.oracle.com ([156.151.31.86])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVK8R-0006AB-CY
 for linux-arm-kernel@lists.infradead.org; Fri, 07 Dec 2018 17:41:56 +0000
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wB7HfSK8099602;
 Fri, 7 Dec 2018 17:41:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=5fSNcgys0GzzY2RZr/5rBQHEZ8nlxIeCbjH+XnCR7iQ=;
 b=0gwvVapHUmNjex3411ycDc1BERjCrJeGHrFTEEIMeiYn1hzCB6ldqZTblZbXDPx7dexq
 dUmtnbAgQKtOL8qSj5n5zpdZ6PUliloJ+qm3DEKsxhrqBy8zYrpoKAMX2RifKRhQbQXT
 YCrhVQtAw1ZejKfWUaAOPkUZSfg992KUyuCwygwLRUw5LBA1FuDvZsmpLSp7XOdaQMvf
 0jFI4+UrWdeNpkryAjhijsNdLTPVaXsRmi6ZfgSCRk2+TWBfrXns/hVmdItloF9hus2d
 pyb1abemwmHT37Iw34SIKOqeb60dRcFQu1+WDFNt6N9Jt98rAeFMzNZFHfzqMFcWVftQ tA== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
 by userp2130.oracle.com with ESMTP id 2p3hquf5ye-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 07 Dec 2018 17:41:28 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id wB7HfRmT008032
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 7 Dec 2018 17:41:28 GMT
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id wB7HfQsx032336;
 Fri, 7 Dec 2018 17:41:26 GMT
Received: from [10.209.243.127] (/10.209.243.127)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Fri, 07 Dec 2018 09:41:26 -0800
Subject: Re: [PATCH] Fix OMAP4430 SDP Ethernet startup
To: Russell King - ARM Linux <linux@armlinux.org.uk>,
 Tony Lindgren <tony@atomide.com>, linux-arm-kernel@lists.infradead.org,
 linux-omap@vger.kernel.org, Santosh Shilimkar <santosh.shilimkar@ti.com>
References: <20181207125224.GW6920@n2100.armlinux.org.uk>
From: Santosh Shilimkar <santosh.shilimkar@oracle.com>
Organization: Oracle Corporation
Message-ID: <b53a6a9a-f053-ae43-987a-dca3352e51f4@oracle.com>
Date: Fri, 7 Dec 2018 09:41:16 -0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181207125224.GW6920@n2100.armlinux.org.uk>
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9099
 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1812070141
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181207_094155_561108_20A0D3C2 
X-CRM114-Status: GOOD (  24.57  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 12/7/2018 4:52 AM, Russell King - ARM Linux wrote:
> It was noticed that unbinding and rebinding the KSZ8851 ethernet
> resulted in the driver reporting "failed to read device ID" at probe.
> Probing the reset line with a 'scope while repeatedly attempting to
> bind the driver in a shell loop revealed that the KSZ8851 RSTN pin is
> constantly held at zero, meaning the device is held in reset, and
> does not respond on the SPI bus.
> 
> Experimentation with the startup delay on the regulator set to 50ms
> shows that the reset is positively released after 20ms.
> 
> Schematics for this board are not available, and the traces are buried
> in the inner layers of the board which makes tracing where the RSTN pin
> extremely difficult.  We can only guess that the RSTN pin is wired to a
> reset generator chip driven off the ethernet supply, which fits the
> observed behaviour.
> 
> Include this delay in the regulator startup delay - effectively
> treating the reset as a "supply stable" indicator.
> 
> This can not be modelled as a delay in the KSZ8851 driver since the
> reset generation is board specific - if the RSTN pin had been wired to
> a GPIO, reset could be released earlier via the already provided support
> in the KSZ8851 driver.
> 
> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
> ---
Sure. We can add this. Thanks for patch.

Regards,
Santosh

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
