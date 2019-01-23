Return-Path: <SRS0=uP4V=P7=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10929C282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 02:13:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D243920868
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 02:13:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="cet7aHUU";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="R8JXTpfS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D243920868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:In-Reply-To:
	Date:References:From:Subject:To:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=d5RziMqCzCJYwtgM0UgcPA68xgilJIM00drIksDtIng=; b=cet7aHUUD4yQgB
	mX6/JtQkEbVnUa80oxqzClXmJ+d3Q2CsBd3HEUAA6gPn5sdaj08gJDSS8D7CV1gLcA/Zl0H+LiRUE
	miTecQcfAv/lSoqpTW1PQaUvNSoW99zpvWyeBpVnYYdDPY838mEw+c1Sd1XhmeKeDrsp8TD7nOHKX
	vyzzAjf+8x9ZRjJ7NyqEjQ2RDP3+ygVz9fTEHxbn1Y3EbnbQFY47ow81clG5e9AsEeYFhQ/BUsBun
	m3teaqZH2yUI3w+taE1FrTGPV776X00LFnrS4BTBEM/ruVfJOA4t0R3J0LQVwp40APXAQ0FfXIbZg
	qDsT0lMapq8hJyt0cTOg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gm837-0006xn-48; Wed, 23 Jan 2019 02:13:53 +0000
Received: from userp2120.oracle.com ([156.151.31.85])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gm833-0006wz-P5
 for linux-arm-kernel@lists.infradead.org; Wed, 23 Jan 2019 02:13:51 +0000
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id x0N299AG103573;
 Wed, 23 Jan 2019 02:13:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=5ck2xErcabr165VKniWDAl5YnKS8Npgkzvw/4unfxUE=;
 b=R8JXTpfS7wxokNvQ/6Z7pw/J/AlZmQy0I0Ss1GSZVzRHO40ZMjA6qDIt9tSV+TsQh6li
 B4ZXX+wPO4GXhbB3oIpfwel8O555BP0kw3DkAWvdzI2jp8tAxslW6NMnY7HI/CiAUEPe
 2w9ljdiQFTDRofFLCPhQ7Poz0jsEZC3/HZlBcep1mdk6liv/dq+VB6eRvIowMTuRcxSZ
 dNq9Mx+R7M3jHc+M52sUuCQwYPxk+M6hoe8mkn+urZXjwHKJwqPSFQAoUJf8juQdNvgi
 M1gqFnnj+pKBPMTkXCyXOK6Rl9DFD2KoWk9r5TqdZ+0Y+hRbzyXHDGEUEifr+HrMGRqn mw== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
 by userp2120.oracle.com with ESMTP id 2q3vhrq1r1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 23 Jan 2019 02:13:38 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x0N2Dc8x008524
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 23 Jan 2019 02:13:38 GMT
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x0N2DaqG006200;
 Wed, 23 Jan 2019 02:13:36 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Tue, 22 Jan 2019 18:13:36 -0800
To: Marc Gonzalez <marc.w.gonzalez@free.fr>
Subject: Re: [PATCH v1] scsi: ufs: Use explicit access size in ufshcd_dump_regs
From: "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <3bf7ea8e-4cf2-1f9b-7f46-15609dfcad19@free.fr>
Date: Tue, 22 Jan 2019 21:13:33 -0500
In-Reply-To: <3bf7ea8e-4cf2-1f9b-7f46-15609dfcad19@free.fr> (Marc Gonzalez's
 message of "Tue, 11 Dec 2018 15:18:18 +0100")
Message-ID: <yq1o988m88i.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9144
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=5 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=5 mlxscore=5 mlxlogscore=130
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1901230016
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190122_181349_952241_411D6973 
X-CRM114-Status: GOOD (  12.94  )
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
Cc: SCSI <linux-scsi@vger.kernel.org>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Joao Pinto <jpinto@synopsys.com>, MSM <linux-arm-msm@vger.kernel.org>,
 Avri Altman <avri.altman@wdc.com>, Tomas Winkler <tomas.winkler@intel.com>,
 Vinayak Holikatti <vinholikatti@gmail.com>,
 Robin Murphy <robin.murphy@arm.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


Marc,

> memcpy_fromio() doesn't provide any control over access size.
> For example, on arm64, it is implemented using readb and readq.
> This may trigger a synchronous external abort:

Applied to 5.0/scsi-fixes, thanks.

-- 
Martin K. Petersen	Oracle Linux Engineering

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
