Return-Path: <SRS0=niBm=QV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82138C10F00
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 02:48:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5167F20818
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 02:48:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="He3ivxdG";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="rpOrk39h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5167F20818
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:In-Reply-To:
	Date:References:From:Subject:To:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=9BS99WYfbiW4dD3A1SV++6dk7C2kxX80bMZwoh2yWYw=; b=He3ivxdGUQA03q
	8Zfyrc1inItIwGhqPsoXmRS09d5v+Hi5Qh8Ytyb+TLHYitIrcXVRw/6RjhyqPDvCmO/0pF9Z4W1Vp
	RgArkZoUoFawcYseancjAA1BokxKtTIbCeDSLHh4/nhMDOQDDLyjCgQZk4f8jcU4qnjtwmCH7XfWA
	PmRTXpmlunAimx8GZyrXaRUhjtPi2ezJq6DBJq/PU90cW4F9xa+xKmG1tMH3TasmNuf/BJVzvOOwH
	h0q+DUOXNZH51nay4NfkVU82MU8M8HFgRldIuQ7SMSumTuJ8GOVfMTDvLoQ7lxechRsijNVB/8zvA
	m8q/WfCn+LEp3vFNFVPQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gu74z-0007Q8-Lt; Thu, 14 Feb 2019 02:48:49 +0000
Received: from aserp2130.oracle.com ([141.146.126.79])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gu74w-0007Pn-PB
 for linux-arm-kernel@lists.infradead.org; Thu, 14 Feb 2019 02:48:48 +0000
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
 by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x1E2dKNm010702;
 Thu, 14 Feb 2019 02:48:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=oT85RKWwjopzqOdt9LmCqIv99VvJz7mJxvF/aBAYrQA=;
 b=rpOrk39h8+v3WP9cbbAHNNOcBmKN4qyI2Qyp7qqEKfHeLTmusd/isAQA7alfn1Ulevvw
 GIS6uxdJbW3e3yYFRua45pjk5cVjKLnQ3kkZQbtI+rhyVu7Y3ccqzodqWVkJLvvjtOG+
 juQmM/Ml7mKNoN5dacu6emAlg4RInIhvFTNd8i9Rcd7J9ZOiVvPs8PwxwqsykkDgPSB8
 TQx3R8dxIqAbTAhj7AW+mkWJxYuoAPJYY8SmFaSzzgzQNFDyOZE0JZ2NoXyVDGU4DguR
 7TjBPfl609soP9iZ6G4fEcobdVuym2Ft1fZxFmZIY1kHRzjh0eMuYjtrnhf0jQxaH7eG aQ== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
 by aserp2130.oracle.com with ESMTP id 2qhre5nfb5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 14 Feb 2019 02:48:36 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x1E2mUci032640
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 14 Feb 2019 02:48:30 GMT
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x1E2mTqU000943;
 Thu, 14 Feb 2019 02:48:29 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 14 Feb 2019 02:48:29 +0000
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: Re: [PATCH v2 3/3] scsi: ufs: Add HI3670 SoC UFS driver support
From: "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20190105072859.9134-1-manivannan.sadhasivam@linaro.org>
 <20190105072859.9134-4-manivannan.sadhasivam@linaro.org>
 <20190126144711.GA14260@Mani-XPS-13-9360>
Date: Wed, 13 Feb 2019 21:48:26 -0500
In-Reply-To: <20190126144711.GA14260@Mani-XPS-13-9360> (Manivannan
 Sadhasivam's message of "Sat, 26 Jan 2019 20:17:11 +0530")
Message-ID: <yq18syjqe4l.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9166
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=665 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902140018
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190213_184846_909853_D167D64C 
X-CRM114-Status: GOOD (  10.87  )
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
Cc: devicetree@vger.kernel.org, jejb@linux.vnet.ibm.com,
 linux-scsi@vger.kernel.org, martin.petersen@oracle.com, guodong.xu@linaro.org,
 linux-kernel@vger.kernel.org, amit.kucheria@linaro.org, robh+dt@kernel.org,
 john.stultz@linaro.org, liwei213@huawei.com, vinholikatti@gmail.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


Manivannan,

> Ping on this patch!

I don't have any objections except I would like to see an Acked-by: from
Wei Li or somebody from hisilicon.

-- 
Martin K. Petersen	Oracle Linux Engineering

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
