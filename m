Return-Path: <SRS0=5Xh4=OS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E46DC65BAF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 04:26:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D751620867
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 04:26:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Y0FDAdSN";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GUlKJZBO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D751620867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=KENeV/Ki8mHoDJr3BneKdXvCV5+llmUXJczl0ujM9tk=; b=Y0FDAdSNJOIp2FW80/ArhpQMs
	ZXp4E3bPAZnZWMdek+4N375ea0uD3WZhfZmNc+paM6rPaf8cVPpOPrDUIEG1lwDWh8BRfXM/9Vq/1
	yauQr0UwpnbashhG6r0lhz5tTWqEljQl343cieewfhGcGbuiHRRS8nb+fyD8OCGW5VbuChKhlnukj
	kiZmhtvgwQgvY7fZk0V/rsh/KJV3CtnWd9pp4Tv5thRFsjsSiBnmsBoLnjEaalOpk70O1L/8/9fOu
	eDEpOK89dxSzXUA3bfqWdsdPtekWsd9Iuz4hcrkKFXgWwy6RhmJR/0Il5AxJJ+2wL5akbA4TD+pPU
	GDoJFqLiQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVqg2-0006va-QF; Sun, 09 Dec 2018 04:26:46 +0000
Received: from userp2130.oracle.com ([156.151.31.86])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVqfz-0006iv-Hc
 for linux-arm-kernel@lists.infradead.org; Sun, 09 Dec 2018 04:26:45 +0000
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wB94QPFR173088;
 Sun, 9 Dec 2018 04:26:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=WKPjiBYVhb+zOxf5+p+2Cw8+fVYvmeN2le0hr31F158=;
 b=GUlKJZBOpMGFvkxgLgITenBo8phXJMgbxbWUZDZnXlXOGaPyd7TbAzaAUkCtkxrb3P9c
 eykX1P0J1uw9PwhkdwHqTHJbzxFtADA4K8+kQPUdOm3kjNMb5aFHpHIv67U2VkMVGHrG
 HG73bxBFVM3u35Vq9YAZaRfAYbIDmTRYtuKBOKe6jAqTXj5KgJbOuuqsRYl1708A/Lch
 XNNZVtIBmgNW8TXwzyhopcHXy2/thz25m2BePsr6nURrLC3PLZU1rWvMS0G3tdmZ1NlC
 vXDBbruzP0wkdC4SnKIAZrapsyUGrdAg/aLaM300EbMT2eAA3wF68H2zM/w8HUgemlt+ Pg== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
 by userp2130.oracle.com with ESMTP id 2p85ctsu10-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 09 Dec 2018 04:26:25 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id wB94QJYc004029
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 9 Dec 2018 04:26:20 GMT
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id wB94QJUL002735;
 Sun, 9 Dec 2018 04:26:19 GMT
Received: from [10.209.243.127] (/10.209.243.127)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Sat, 08 Dec 2018 20:26:19 -0800
Subject: Re: [PATCH] firmware: ti_sci: Change to use DEFINE_SHOW_ATTRIBUTE
 macro
To: Nishanth Menon <nm@ti.com>, Yangtao Li <tiny.windzz@gmail.com>
References: <20181122140519.25166-1-tiny.windzz@gmail.com>
 <20181208160404.h7cuuq6jvafoxa32@akan>
From: Santosh Shilimkar <santosh.shilimkar@oracle.com>
Organization: Oracle Corporation
Message-ID: <06387350-3247-539a-8eea-123d2f8e94d5@oracle.com>
Date: Sat, 8 Dec 2018 20:26:32 -0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20181208160404.h7cuuq6jvafoxa32@akan>
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9101
 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=974
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1812090041
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181208_202643_792271_C2EEAE14 
X-CRM114-Status: GOOD (  17.17  )
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
Cc: t-kristo@ti.com, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, ssantosh@kernel.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 12/8/2018 8:04 AM, Nishanth Menon wrote:
> On 09:05-20181122, Yangtao Li wrote:
>> Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.
>>
>> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> 
> Thanks for the same and sorry for responding so late.
> 
> [...]
> 
> Santosh,
> could you pick this up? maybe for next rev or so?
> 
> Reviewed-by: Nishanth Menon <nm@ti.com>
> 
Sure !!

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
