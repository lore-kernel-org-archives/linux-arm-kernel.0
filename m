Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA992C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 06:22:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A5E320848
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 06:22:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="MsZPgd94"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A5E320848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Message-Id:In-Reply-To:MIME-Version:
	Date:From:References:To:Subject:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=dSX7LZlGxqtT8B9foytjqsCeC5zoPW+gSVIipZGZV1I=; b=MsZPgd94APIi5w
	era5VMDFl1X50TNPIyieXjgSUKvn72c5YJ6CowJVvKSR087MlCvnMTUbk/zsXGTv4Awn7DS+PwXpU
	X2TsG/skPf7sjvYI2QRZNHFqPeB0QtuyXG5767cRfQdYltX6OOXtDV8sb8k7pZ7nbP9/Ogik4ZWtl
	p3sAhZz6CDJNeum+XNSBl7zeop2rmizAjgh4C0ongvOQL22Jr7PDGXWGS8v+gBTxjmRYL6iBFMNj/
	040+XYEIDBZVALyclfmDLtRuBJuk9akTpWWWVd0TJ+gLXfU7q3h+4PqQQMAq32cfD2/+B1HlRY39h
	ALbhmwg7THUTVhp0UEaw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gThco-0003Qv-Sb; Mon, 03 Dec 2018 06:22:34 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]
 helo=mx0a-001b2d01.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gThcl-0003QG-9K
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 06:22:33 +0000
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 wB36JBHE129288
 for <linux-arm-kernel@lists.infradead.org>; Mon, 3 Dec 2018 01:22:18 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2p4y3xg3mq-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linux-arm-kernel@lists.infradead.org>; Mon, 03 Dec 2018 01:22:18 -0500
Received: from localhost
 by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linux-arm-kernel@lists.infradead.org> from <ravi.bangoria@linux.ibm.com>; 
 Mon, 3 Dec 2018 06:22:16 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
 by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Mon, 3 Dec 2018 06:22:11 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com
 (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 wB36MAWo7733632
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 3 Dec 2018 06:22:10 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8077DA405B;
 Mon,  3 Dec 2018 06:22:10 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7ADBFA4060;
 Mon,  3 Dec 2018 06:22:07 +0000 (GMT)
Received: from [9.124.31.174] (unknown [9.124.31.174])
 by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Mon,  3 Dec 2018 06:22:07 +0000 (GMT)
Subject: Re: [PATCH] Uprobes: Fix kernel oops with delayed_uprobe_remove()
To: rostedt@goodmis.org
References: <20181114081921.26484-1-ravi.bangoria@linux.ibm.com>
 <20181114160600.GD13885@redhat.com>
 <556c2aa5-550d-d96f-7ed2-549d8f3d803b@linux.ibm.com>
 <20181115124317.GA23272@redhat.com>
From: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Date: Mon, 3 Dec 2018 11:52:41 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20181115124317.GA23272@redhat.com>
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18120306-0012-0000-0000-000002D3AA5F
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18120306-0013-0000-0000-00002108FEC8
Message-Id: <9f73b926-b3a5-2519-3a9e-91de35899a6e@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-12-03_03:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=924 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812030062
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181202_222231_448704_F3B268EC 
X-CRM114-Status: GOOD (  21.79  )
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
Cc: linux-mips@linux-mips.org, srikar@linux.vnet.ibm.com, linux@armlinux.org.uk,
 peterz@infradead.org, ralf@linux-mips.org, liu.song.a23@gmail.com,
 Oleg Nesterov <oleg@redhat.com>, acme@kernel.org, linux-kernel@vger.kernel.org,
 alexander.shishkin@linux.intel.com, paul.burton@mips.com, mingo@redhat.com,
 mhiramat@kernel.org, ananth@linux.vnet.ibm.com, namhyung@kernel.org,
 naveen.n.rao@linux.vnet.ibm.com, alexis.berlemont@gmail.com, jolsa@redhat.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Steve,

Please pull this patch.

Thanks.

On 11/15/18 6:13 PM, Oleg Nesterov wrote:
> On 11/15, Ravi Bangoria wrote:
>>
>> There could be a race between task exit and probe unregister:
>>
>>   exit_mm()
>>   mmput()
>>   __mmput()                     uprobe_unregister()
>>   uprobe_clear_state()          put_uprobe()
>>   delayed_uprobe_remove()       delayed_uprobe_remove()
>>
>> put_uprobe() is calling delayed_uprobe_remove() without taking
>> delayed_uprobe_lock and thus the race sometimes results in a
>> kernel crash. Fix this by taking delayed_uprobe_lock before
>> calling delayed_uprobe_remove() from put_uprobe().
>>
>> Detailed crash log can be found at:
>>   https://lkml.org/lkml/2018/11/1/1244
> 
> Thanks, looks good,
> 
> Oleg.
> 


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
