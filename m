Return-Path: <SRS0=e5Gl=O3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3085C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 17:05:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C19BD217D9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 17:05:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="o3wS9oNf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C19BD217D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=7iPdAgXbWbIou5v7S7PMEyAU4bYTdUY3X1baRZHAhLY=; b=o3wS9oNfVtCE1+
	CRLXaOYNmEy6oeiZVUFYL2l10ovKUsKLcMOZr6NjCYi8pDz1kaKzHtyhuXkWa7XM3I28NIi7cJR/T
	n7kNs2Yl9IyCjGI5PjJHAfgu3+LkZslSN9mQIOK+lrqnC3CWHndbLd9TSiu/89pcuN3+j3gj5G9h5
	QXFMt/oUYFMwB4hGEwruzu2kXlQM6ziPi+pPZ1XTIrTfQaU6LdvNJ+KhV83S5/BaqmFM+l4CTVPvf
	yCR+h7oi2bCATkPkBPjS68e7W4eQrURKZ6A+yOD4MaBxbJASZXbXZ2J3Yr+lzD+UT6dDglA81fkzp
	b/3NEnRVEnO8T9o95RkA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZIoX-0003bU-5v; Tue, 18 Dec 2018 17:05:49 +0000
Received: from mx07-00178001.pphosted.com ([62.209.51.94])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZIoS-0003aF-Ic
 for linux-arm-kernel@lists.infradead.org; Tue, 18 Dec 2018 17:05:48 +0000
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 wBIGuQcD014917; Tue, 18 Dec 2018 18:05:25 +0100
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com with ESMTP id 2pcr8xrwem-1
 (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
 Tue, 18 Dec 2018 18:05:25 +0100
Received: from zeta.dmz-ap.st.com (ns6.st.com [138.198.234.13])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 632494B;
 Tue, 18 Dec 2018 17:05:21 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag6node3.st.com [10.75.127.18])
 by zeta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 5EF6D344;
 Tue, 18 Dec 2018 17:05:19 +0000 (GMT)
Received: from SFHDAG6NODE3.st.com (10.75.127.18) by SFHDAG6NODE3.st.com
 (10.75.127.18) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Tue, 18 Dec
 2018 18:05:18 +0100
Received: from SFHDAG6NODE3.st.com ([fe80::d04:5337:ab17:b6f6]) by
 SFHDAG6NODE3.st.com ([fe80::d04:5337:ab17:b6f6%20]) with mapi id
 15.00.1347.000; Tue, 18 Dec 2018 18:05:18 +0100
From: Patrice CHOTARD <patrice.chotard@st.com>
To: Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: Re: [PATCH 1/1] ARM: STi: Restore secondary CPU's bringup
Thread-Topic: [PATCH 1/1] ARM: STi: Restore secondary CPU's bringup
Thread-Index: AQHUluC8wzYjRbliykengwL93mfzKqWElOMAgAAUSoA=
Date: Tue, 18 Dec 2018 17:05:18 +0000
Message-ID: <b26902d8-79d6-2b09-6e35-9e8823f9181e@st.com>
References: <1545144493-11600-1-git-send-email-patrice.chotard@st.com>
 <20181218155239.GP26090@n2100.armlinux.org.uk>
In-Reply-To: <20181218155239.GP26090@n2100.armlinux.org.uk>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.50]
Content-ID: <0C0CCED9A72FBD41981080411894C864@st.com>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-12-18_07:, , signatures=0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181218_090544_908173_9594E61B 
X-CRM114-Status: GOOD (  19.28  )
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
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Russell

On 12/18/18 4:52 PM, Russell King - ARM Linux wrote:
> On Tue, Dec 18, 2018 at 03:48:13PM +0100, patrice.chotard@st.com wrote:
>> From: Patrice Chotard <patrice.chotard@st.com>
>>
>> Due to pen_release and boot_lock removal, secondary CPU's bringup
>> was broken. Restore CPU's bringup by reworking properly
>> .smp_prepare_cpus and .smp_boot_secondary STi callbacks.
> 
> Sorry, maybe I don't understand your commit message, but you seem to be
> saying that removal of the pen_release and boot_lock broke STi's secondary
> CPU bring up?  Please clarify, and explain how that happened.

Correct, CPU1 failed to come online.

It seems that writing secondary_startup address at cpu-release-addr in
.smp_prepare_cpus callback was too early.

Doing it in .smp_boot_secondary callback, insures that secondary_data
struct is populated in __cpu_up() (stack, pgdir and swapper_pg_dir fields).

If you are ok, i will pick up your patch [1] and this one to prepare a
STi pull-request.

Thanks

Patrice

[1] https://patchwork.kernel.org/patch/10729479/

> 
> Thanks.
> 
>>
>> Signed-off-by: Patrice Chotard <patrice.chotard@st.com>
>> ---
>>  arch/arm/mach-sti/platsmp.c | 31 ++++++++++++++++---------------
>>  1 file changed, 16 insertions(+), 15 deletions(-)
>>
>> diff --git a/arch/arm/mach-sti/platsmp.c b/arch/arm/mach-sti/platsmp.c
>> index 2166850..9bfc93a 100644
>> --- a/arch/arm/mach-sti/platsmp.c
>> +++ b/arch/arm/mach-sti/platsmp.c
>> @@ -28,8 +28,21 @@
>>  
>>  #include "smp.h"
>>  
>> +static u32 __iomem *cpu_strt_ptr;
>> +
>>  static int sti_boot_secondary(unsigned int cpu, struct task_struct *idle)
>>  {
>> +	unsigned long entry_pa = __pa_symbol(secondary_startup);
>> +
>> +	__raw_writel(entry_pa, cpu_strt_ptr);
>> +
>> +	/*
>> +	 * wmb so that data is actually written
>> +	 * before cache flush is done
>> +	 */
>> +	smp_wmb();
>> +	sync_cache_w(cpu_strt_ptr);
>> +
>>  	/*
>>  	 * Send the secondary CPU a soft interrupt, thereby causing
>>  	 * it to jump to the secondary entrypoint.
>> @@ -43,10 +56,8 @@ static void __init sti_smp_prepare_cpus(unsigned int max_cpus)
>>  {
>>  	struct device_node *np;
>>  	void __iomem *scu_base;
>> -	u32 __iomem *cpu_strt_ptr;
>>  	u32 release_phys;
>>  	int cpu;
>> -	unsigned long entry_pa = __pa_symbol(secondary_startup);
>>  
>>  	np = of_find_compatible_node(NULL, NULL, "arm,cortex-a9-scu");
>>  
>> @@ -74,8 +85,8 @@ static void __init sti_smp_prepare_cpus(unsigned int max_cpus)
>>  		}
>>  
>>  		/*
>> -		 * holding pen is usually configured in SBC DMEM but can also be
>> -		 * in RAM.
>> +		 * cpu-release-addr is usually configured in SBC DMEM but can
>> +		 * also be in RAM.
>>  		 */
>>  
>>  		if (!memblock_is_memory(release_phys))
>> @@ -85,17 +96,7 @@ static void __init sti_smp_prepare_cpus(unsigned int max_cpus)
>>  			cpu_strt_ptr =
>>  				(u32 __iomem *)phys_to_virt(release_phys);
>>  
>> -		__raw_writel(entry_pa, cpu_strt_ptr);
>> -
>> -		/*
>> -		 * wmb so that data is actually written
>> -		 * before cache flush is done
>> -		 */
>> -		smp_wmb();
>> -		sync_cache_w(cpu_strt_ptr);
>> -
>> -		if (!memblock_is_memory(release_phys))
>> -			iounmap(cpu_strt_ptr);
>> +		set_cpu_possible(cpu, true);
>>  	}
>>  }
>>  
>> -- 
>> 1.9.1
>>
> 
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
