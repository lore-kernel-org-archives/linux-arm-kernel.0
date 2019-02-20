Return-Path: <SRS0=0Bxu=Q3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 099EDC10F0B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 14:21:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C72DE20880
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 14:21:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="SP1kTudf";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fckD+Utu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C72DE20880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:In-Reply-To:
	Date:References:From:Subject:To:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=PyMQ2BNOOsldOOkAc9sxpN9HDqZDkHWVt/DKnfDJ3e0=; b=SP1kTudf5s6o+D
	5pQJf3Rv0TrORVMEw9mBk5PyZOTnK5/VfVAfx20+iOJ3kZ7utwUZrScWd5khHjEEDv/+84O1uW013
	ETQKJU6It/f7mIcyNbc2dtzKjkSdxiWKXQqP9bnojLdqHaj431TU2oCRQj5Uqr3/GXAEys6ylPCVz
	b1/FmYTxtM0FELwkhkVwKTh091+fH6MSXSRJa/sAOwPFoyW/QqSbAg6SFCrhdcKy/1k4awmBYMz38
	16CFO/bJh/t7yM9xZev/ojmVfyvq6rpawrqRCCcyXPQpMZL973zewy+TkR6phQmzNtHeazM1/Fpyg
	RqrR56bW9G6EUmTE0uzQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwSki-0004Il-R1; Wed, 20 Feb 2019 14:21:36 +0000
Received: from userp2120.oracle.com ([156.151.31.85])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwSkf-0004I1-KH
 for linux-arm-kernel@lists.infradead.org; Wed, 20 Feb 2019 14:21:35 +0000
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x1KEIiFL158103;
 Wed, 20 Feb 2019 14:21:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=hGcPQ2L5NAHFuLuFgEGUnQ0V/GI9Z63apyRnnHFbiog=;
 b=fckD+UtuDcDasPhkHGl12EE5VJQjOBup7K3/w6pfYjlNEEONEgp7xOTjab4b9A3IJzLT
 LdgeR9onj7wdf5zYGxw15lA2/XjchmB44TWGZEBeFHyuyanU97ZQuZ0BMIEE7LiJhrA4
 wJvuts4ejOYEzmduLA7OTO/rbjydTOuk0Xm5fwYfEEK8b/+kfAn9Ccq01DMl3woxD6Ez
 VYVpjb/lDFCun2seTM0Eb3IMzV2JznsCyJnvo/seRl7no9g4K4c87DArhw+BSneiMB+S
 KNMZMgNpwZIKmHNNlDute4YnB6N9+OS583YPsUUQigdGgdnMg+iMUZ/O4Y4WG4ML6YIu gg== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
 by userp2120.oracle.com with ESMTP id 2qpb5rhq8p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 20 Feb 2019 14:21:09 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x1KEL8H2019492
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 20 Feb 2019 14:21:08 GMT
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x1KEL6qm011223;
 Wed, 20 Feb 2019 14:21:06 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Wed, 20 Feb 2019 06:21:06 -0800
To: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v2 2/3] arm64: dts: hisilicon: hi3670: Add UFS controller
 support
From: "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20190105072859.9134-1-manivannan.sadhasivam@linaro.org>
 <20190105072859.9134-3-manivannan.sadhasivam@linaro.org>
 <20190220113508.GB7498@ulmo>
Date: Wed, 20 Feb 2019 09:21:01 -0500
In-Reply-To: <20190220113508.GB7498@ulmo> (Thierry Reding's message of "Wed,
 20 Feb 2019 12:35:08 +0100")
Message-ID: <yq18syak0c2.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9172
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=873 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902200104
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190220_062133_753047_3DFF5190 
X-CRM114-Status: GOOD (  14.74  )
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
Cc: devicetree@vger.kernel.org, jejb@linux.vnet.ibm.com, guodong.xu@linaro.org,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Wei Xu <xuwei5@hisilicon.com>, linux-kernel@vger.kernel.org,
 amit.kucheria@linaro.org, linux-scsi@vger.kernel.org,
 linux-next@vger.kernel.org, robh+dt@kernel.org, john.stultz@linaro.org,
 liwei213@huawei.com, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 vinholikatti@gmail.com, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


Hi Thierry,

> it looks like you picked this up into the SCSI tree (perhaps
> inadvertently). It's been causing linux-next to fail to build since
> Monday (next-20190218) because it references a phandle (&crg_rst)
> that's not available.

I dropped the offending patch from the SCSI tree yesterday. When Stephen
updates -next, things should be fine.

-- 
Martin K. Petersen	Oracle Linux Engineering

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
