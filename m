Return-Path: <SRS0=pdKw=QA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92AABC282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 07:01:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5EDBF2184C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 07:01:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WYbcMqxD";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="u9V0sZcg";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=marvell.onmicrosoft.com header.i=@marvell.onmicrosoft.com header.b="Vx6ltav5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EDBF2184C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=marvell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date
	:Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=NAPmw0o6Ep904499RVS9w8Q6YeRMMzXRcy4cD0G/oS8=; b=WYbcMqxDQAK/Sy
	qbpZok5DXiY/yDDbTmDQocCN6l1vO+gcwjXZHTN3+cuLbCJ6Nq0v0p75SsX8e6cvQrXiHzX0nuKd/
	ZZNHoYIo5j7g+oDgymc/aPzfI28JydHdjqUQ9SC4mowHGSd2cuwqRgOw8UjEAm5vtMJfK9wwS9qwh
	kfNtunYgh3LFm+HOpkgyeLaJ/z27iD9R+aTesashnFtf69vW/NzxvX2zrWl2wii2jbyrmndNJRHEy
	2uZnDzUNd4RsJp2bhneqtfBxbssdcKe9zMDv6BTpueseYgVJ3eLL5RjzYRej0Vh9OQ2lv6aPa5q4A
	ABoPtMLpFQL75MeXRdSw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmZ0b-0005nY-Vn; Thu, 24 Jan 2019 07:01:05 +0000
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]
 helo=mx0b-0016f401.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmZ0W-0005lC-AS
 for linux-arm-kernel@lists.infradead.org; Thu, 24 Jan 2019 07:01:04 +0000
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x0O6slNV027374; Wed, 23 Jan 2019 23:00:48 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 h=from : to : cc :
 subject : date : message-id : references : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=fc9IXfGdE9sM+XtxwZapVJdQk8emv1URaobNKTvsalk=;
 b=u9V0sZcgOT8YCSQrpiCez6aMncnU+edrc2de30ykCLtlni+9Dt0tONRapWKusn5s8/ct
 15xLhi9zWxQDcoGuo7RahE34zQdcK6ld3Ds8/vKSv7uhKdk5joJvaCQocFRbD7EbAACQ
 UYJushr+Wmh+Vugkh6gD2wi/Pm9as5y5UInHRVxFed6XC/JXFaG8++knnig8+1acMefQ
 bsqWTqcRV9nP5YCt0ARc6LnJ2XBZKhz9ufoTthdfLxs8Y7o2hKx0rvBmJSs5loLs3S6G
 fycr47O63LfQsVavc7RwiTpg9dEtDhUU9dZ69c7P7zJ8B/AI+7E9FT3SNxDoZZO+Momx SA== 
Received: from sc-exch02.marvell.com ([199.233.58.182])
 by mx0a-0016f401.pphosted.com with ESMTP id 2q6w0kkb88-15
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
 Wed, 23 Jan 2019 23:00:48 -0800
Received: from SC-EXCH02.marvell.com (10.93.176.82) by SC-EXCH02.marvell.com
 (10.93.176.82) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Wed, 23 Jan
 2019 23:00:46 -0800
Received: from NAM05-CO1-obe.outbound.protection.outlook.com (104.47.48.54) by
 SC-EXCH02.marvell.com (10.93.176.82) with Microsoft SMTP Server
 (TLS) id
 15.0.1367.3 via Frontend Transport; Wed, 23 Jan 2019 23:00:46 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fc9IXfGdE9sM+XtxwZapVJdQk8emv1URaobNKTvsalk=;
 b=Vx6ltav5ZSZpRmFDDhCGyh823EXtrif/DhcF7f6Xxw0OWATHpdPqBc9zpuFBCSLlS7RR2oXW0olON38QwFPaa9GZfxcMA90GD/YZLjhouW9EbiaJ17DatjQRyxapJCXCtmdJZlqYrqSmD5OSf+niulX4eoWO6b1KXFrXSIjctFY=
Received: from DM6PR18MB2460.namprd18.prod.outlook.com (20.179.104.155) by
 DM6PR18MB2537.namprd18.prod.outlook.com (20.179.105.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.16; Thu, 24 Jan 2019 07:00:42 +0000
Received: from DM6PR18MB2460.namprd18.prod.outlook.com
 ([fe80::bc61:3698:d8a8:f93c]) by DM6PR18MB2460.namprd18.prod.outlook.com
 ([fe80::bc61:3698:d8a8:f93c%2]) with mapi id 15.20.1558.016; Thu, 24 Jan 2019
 07:00:42 +0000
From: Shijith Thotton <sthotton@marvell.com>
To: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon
 <will.deacon@arm.com>
Subject: Re: [Qestion] Softlockup when send IPI to other CPUs
Thread-Topic: [Qestion] Softlockup when send IPI to other CPUs
Thread-Index: AQHUsFLrrYWN2sDbSEeIkTghgif1Ug==
Date: Thu, 24 Jan 2019 07:00:42 +0000
Message-ID: <DM6PR18MB24607427B3B2BEAD80A75780D99A0@DM6PR18MB2460.namprd18.prod.outlook.com>
References: <95C141B25E7AB14BA042DCCC556C0E6501620A47@dggeml529-mbx.china.huawei.com>
 <20190119235825.GG26876@brain-police>
 <20190121142127.GD29504@arrakis.emea.arm.com>
 <20190122054400.GB6445@brain-police>
 <20190123181530.GA234790@arrakis.emea.arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [111.93.218.67]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; DM6PR18MB2537;
 20:j53mggkNk3vVKWLCIN0+heKAriIPd2fKN5gdLL9aTfk0sAwVSkWxtq9PLOSij2CMtxzLIAAJfzJtJIXryaYWPKC46zcpp7gIYd6Uedbz8Q+KGjwYjrWx92LoOQfD4uIpN72W+MRsSA7oQLrsOqKcNYqWo2SeiXGvDrGQRu/G5js=
x-ms-office365-filtering-correlation-id: 195d9aa4-fa8f-4086-2638-08d681c9a80d
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605077)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);
 SRVR:DM6PR18MB2537; 
x-ms-traffictypediagnostic: DM6PR18MB2537:
x-microsoft-antispam-prvs: <DM6PR18MB25370FB599466BE96CC69F34D99A0@DM6PR18MB2537.namprd18.prod.outlook.com>
x-forefront-prvs: 0927AA37C7
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(346002)(39860400002)(136003)(396003)(376002)(366004)(189003)(199004)(305945005)(102836004)(446003)(6506007)(4326008)(53546011)(93886005)(186003)(7736002)(7696005)(26005)(99286004)(76176011)(97736004)(110136005)(54906003)(55016002)(486006)(476003)(71190400001)(3846002)(229853002)(74316002)(6116002)(6306002)(71200400001)(53936002)(25786009)(316002)(9686003)(8936002)(14454004)(256004)(14444005)(6436002)(8676002)(105586002)(81156014)(81166006)(33656002)(2906002)(966005)(78486014)(6246003)(478600001)(86362001)(66066001)(107886003)(68736007)(106356001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR18MB2537;
 H:DM6PR18MB2460.namprd18.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: yX6EZNlyBevqX9BqJVd4P14IUogxtVgrvw1MRTlH3o1roxwOMkPjtfREBuOWPdpfTMKG3XfTA2w6YSSMtzyax81oN+hSe4mvKdiiwxX4PR+mZqe3a8s402FkY3sAec4jaKwnoWBV2viiDSQx0O/yozAQqLlOJB9aCtTAKPU/5XI2byGYVZjDEkeaOYyZgXpTN3njmhAsf8vI4WkhByTfMrv8eCjHfO1aj/9+PTaQ22ftNpYSlb89T5qo4t8fYmaSmEt4B7+H3mp425W6i6zCYoRbYdQAbMqTTwNL7jLiV5RDffLvMb2fSk2bCHCvIRZpKEKIX0wLfkw3nD/LktcpuCjskK7VTv2roO+BgD4O41EtVYjXS/8i2O7ToteLsIMphzCeygQIIgrQ7q2FAbAs40oqCGcvn5h9viqL3hM2vo4=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 195d9aa4-fa8f-4086-2638-08d681c9a80d
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jan 2019 07:00:42.6722 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR18MB2537
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-01-24_03:, , signatures=0
X-Proofpoint-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901240049
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190123_230100_946453_C47BB088 
X-CRM114-Status: GOOD (  19.52  )
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
Cc: "Wangkefeng \(Kevin\)" <wangkefeng.wang@huawei.com>,
 Ganapatrao Kulkarni <gkulkarni@marvell.com>,
 "anshuman.khandual@arm.com" <anshuman.khandual@arm.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Jayachandran Chandrasekharan Nair <jnair@marvell.com>,
 chenwandun <chenwandun@huawei.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Catalin,

On 01/23/2019 11:45 PM, Catalin Marinas wrote:
> On Tue, Jan 22, 2019 at 05:44:02AM +0000, Will Deacon wrote:
>> On Mon, Jan 21, 2019 at 02:21:28PM +0000, Catalin Marinas wrote:
>>> arm64: Do not issue IPIs for user executable ptes
>>>
>>> From: Catalin Marinas <catalin.marinas@arm.com>
>>>
>>> Commit 3b8c9f1cdfc5 ("arm64: IPI each CPU after invalidating the I-cache
>>> for kernel mappings") was aimed at fixing the I-cache invalidation for
>>> kernel mappings. However, it inadvertently caused all cache maintenance
>>> for user mappings via set_pte_at() -> __sync_icache_dcache() to call
>>> kick_all_cpus_sync().
>>>
>>> Fixes: 3b8c9f1cdfc5 ("arm64: IPI each CPU after invalidating the I-cache for kernel mappings")
>>> Cc: <stable@vger.kernel.org> # 4.19.x-
>>> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
>>> ---
>>>   arch/arm64/include/asm/cacheflush.h |    2 +-
>>>   arch/arm64/kernel/probes/uprobes.c  |    2 +-
>>>   arch/arm64/mm/flush.c               |   14 ++++++++++----
>>>   3 files changed, 12 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/arch/arm64/include/asm/cacheflush.h b/arch/arm64/include/asm/cacheflush.h
>>> index 19844211a4e6..18e92d9dacd4 100644
>>> --- a/arch/arm64/include/asm/cacheflush.h
>>> +++ b/arch/arm64/include/asm/cacheflush.h
>>> @@ -80,7 +80,7 @@ extern void __clean_dcache_area_poc(void *addr, size_t len);
>>>   extern void __clean_dcache_area_pop(void *addr, size_t len);
>>>   extern void __clean_dcache_area_pou(void *addr, size_t len);
>>>   extern long __flush_cache_user_range(unsigned long start, unsigned long end);
>>> -extern void sync_icache_aliases(void *kaddr, unsigned long len);
>>> +extern void sync_icache_aliases(void *kaddr, unsigned long len, bool sync);
>>
>> I'd much prefer just adding something like sync_user_icache_aliases(), which
>> would avoid the IPI, since bool arguments tend to make the callsites
>> unreadable imo.
> 
> I wonder whether we need the IPI for uprobes and ptrace. I would say we
> can avoid it for ptrace since normally the debugged thread should be
> stopped. I think it's different for uprobes but changing the text of a
> live thread doesn't come with many guarantees anyway. So I'm tempted to
> simply change sync_icache_aliases() to not issue an IPI at all, in which
> case we wouldn't even need the bool argument; it's only used for user
> addresses. So the new diff would be (the text is the same):
> 
> diff --git a/arch/arm64/mm/flush.c b/arch/arm64/mm/flush.c
> index 30695a868107..5c9073bace83 100644
> --- a/arch/arm64/mm/flush.c
> +++ b/arch/arm64/mm/flush.c
> @@ -33,7 +33,11 @@ void sync_icache_aliases(void *kaddr, unsigned long len)
>   		__clean_dcache_area_pou(kaddr, len);
>   		__flush_icache_all();
>   	} else {
> -		flush_icache_range(addr, addr + len);
> +		/*
> +		 * Don't issue kick_all_cpus_sync() after I-cache invalidation
> +		 * for user mappings.
> +		 */
> +		__flush_icache_range(addr, addr + len);
>   	}
>   }

We also faced similar issue with LTP test migrate_pages03 in past and this patch 
fixes the issue.

http://lists.infradead.org/pipermail/linux-arm-kernel/2019-January/623574.html

Thanks,
Shijith

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
