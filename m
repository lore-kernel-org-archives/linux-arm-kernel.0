Return-Path: <SRS0=e5Gl=O3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1070C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 11:03:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D0302184C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 11:03:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="eMx0vj9S";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="k1/3UXpw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D0302184C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=AV7catEnnMIHsKkeJvL1TfkG2bh9roT6Dhs2ExM/csQ=; b=eMx0vj9SCwtP5P
	uUOSwb8HA8fm2SDvcOO5fXMohMb0b+e6Y4q0kxNgMyqfXRAlLkpAh0iFhUpw2BWduvipLjAWgpNyb
	ZnFZuUbnB9BZIs+qGt5g5zvAFXv0hFggYUEY/79C1LMbUCsFMqGic9Cqs+SnAqCA+kuuio/uMqVcA
	byr+1jbimG5GcX1SBprk7N9wyTWDjMsgo58znY8pJ455ZkbOYB5AIndSQVN13IJdfe0SbPN29lBc+
	uMlhw3yTaVYAh5X03TPMqivuvtAE3fTLVfK37PwEZMJvlKelwodIabZkczxiPDggeQVFxYaG+kWv4
	NRY18VJvisgCknHera8A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZD9v-0002yD-1U; Tue, 18 Dec 2018 11:03:31 +0000
Received: from userp2130.oracle.com ([156.151.31.86])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZD9m-0002kF-OJ
 for linux-arm-kernel@lists.infradead.org; Tue, 18 Dec 2018 11:03:28 +0000
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wBIAnlop032860;
 Tue, 18 Dec 2018 11:03:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=iuKgje2izKWVKyE6dQp0OCoIPTIieF5lfaeJkZPbkuw=;
 b=k1/3UXpwC6vsYUEc8bzG6uKF6jlL0KM6WvqVGteUk15DUJjJWxU7ZSfp7H7ks/WHczWf
 /L9FbSCCjh92/6JAzqfOGpjY92/qG+2Mi6WYGOGN/YDbxm354naukAGf/Y1nc+nVOQHp
 8zq7uxsbvEP6SimPS8dLtHU5xrWWaMcmSECr/b5r/wnJlkiLDpMlxfDWGA2z2XFH5ufG
 72rD4e5toyf/KNFhNfZc1o8Eo1/tdzcSjsUAoX/+kvWp05UMuQ0YM177ApK9qi9gHf+J
 xXY8vwn1v/Glivazo2grKH4iJ52fJHLMwzCTOIu9mlANScK69St+YAyM//KGQFr+/nLG Kg== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
 by userp2130.oracle.com with ESMTP id 2pcs1tjn4k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 18 Dec 2018 11:03:04 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id wBIB3308024713
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 18 Dec 2018 11:03:03 GMT
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id wBIB32Su011331;
 Tue, 18 Dec 2018 11:03:02 GMT
Received: from kadam (/10.175.34.47) by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Tue, 18 Dec 2018 03:03:02 -0800
Date: Tue, 18 Dec 2018 14:03:08 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH] PCI: imx: Fix an IS_ERR() vs NULL bug
Message-ID: <20181218110308.GI19692@kadam>
References: <20181218082329.GB440@kadam>
 <20181218105742.GA22156@e107981-ln.cambridge.arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181218105742.GA22156@e107981-ln.cambridge.arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9110
 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=842
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1812180097
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181218_030322_931040_C3F8F274 
X-CRM114-Status: GOOD (  19.15  )
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
Cc: Richard Zhu <hongxing.zhu@nxp.com>, linux-pci@vger.kernel.org,
 kernel-janitors@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
 Leonard Crestez <leonard.crestez@nxp.com>,
 linux-arm-kernel@lists.infradead.org, Lucas Stach <l.stach@pengutronix.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Dec 18, 2018 at 10:57:42AM +0000, Lorenzo Pieralisi wrote:
> On Tue, Dec 18, 2018 at 11:23:29AM +0300, Dan Carpenter wrote:
> > The device_link_add() function doesn't return error pointers, it returns
> > NULL if there is an error.
> > 
> > Fixes: 7a6991159bcd ("PCI: imx: Add multi-pd support")
> > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> > ---
> >  drivers/pci/controller/dwc/pci-imx6.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> Thanks Dan, if you do not mind I will squash this in the initial
> commit given that it is not upstream yet.
> 

I don't mind at all.  Thanks.

regards,
dan carpenter


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
