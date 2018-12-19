Return-Path: <SRS0=AchV=O4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E136DC43612
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 10:32:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 941CB218A6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 10:32:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jZu/m28B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 941CB218A6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=IdXR8gTokhSxW+B2nl0g1GyUfAlVc9wfwakaiiohdjM=; b=jZu/m28BO69PXy
	QQiBS1Llpa7nvg7yAOYD/Q8uxud6GlSiI1Ubw4c5bzg/a6QU0oywsKx0ctT7EMaqzS3zc33opfyW1
	wODJW1Jti+u9U2dYBP8mItHlP8NByb/Ss3PozwqTCR/aRyjnt0ahYaxAIrXj6l9A+p1QcwQ1Q8bGK
	7GUT6AzUZQju8QOsSc7Xh6f45XVkSzfeVtzIFfviLoFnjjZBqVGBNejKbbkieNpOLXJmcycP26sbK
	hoQ7UiO0BnRNGLMp2UZo4dBEGBrWhbNfgKmXw4vrIMnLuW9ExfEovTjWjItG3gsaMvK2MhP33RcY8
	5Ym1uRj9KkLY02fhuIWA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZZ8v-0003Nz-Qi; Wed, 19 Dec 2018 10:31:57 +0000
Received: from mx07-00178001.pphosted.com ([62.209.51.94])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZZ8s-0003Mw-1C
 for linux-arm-kernel@lists.infradead.org; Wed, 19 Dec 2018 10:31:56 +0000
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 wBJAVJlu025689; Wed, 19 Dec 2018 11:31:36 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx07-00178001.pphosted.com with ESMTP id 2pcr8xw6dx-1
 (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
 Wed, 19 Dec 2018 11:31:36 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 05A9D34;
 Wed, 19 Dec 2018 10:31:35 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag6node3.st.com [10.75.127.18])
 by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id D36411686;
 Wed, 19 Dec 2018 10:31:35 +0000 (GMT)
Received: from SFHDAG6NODE3.st.com (10.75.127.18) by SFHDAG6NODE3.st.com
 (10.75.127.18) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Wed, 19 Dec
 2018 11:31:35 +0100
Received: from SFHDAG6NODE3.st.com ([fe80::d04:5337:ab17:b6f6]) by
 SFHDAG6NODE3.st.com ([fe80::d04:5337:ab17:b6f6%20]) with mapi id
 15.00.1347.000; Wed, 19 Dec 2018 11:31:35 +0100
From: Patrice CHOTARD <patrice.chotard@st.com>
To: Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: Re: [PATCH 1/1] ARM: STi: Restore secondary CPU's bringup
Thread-Topic: [PATCH 1/1] ARM: STi: Restore secondary CPU's bringup
Thread-Index: AQHUluC8wzYjRbliykengwL93mfzKqWElOMAgAAUSoCAAAZLAIABHgkA
Date: Wed, 19 Dec 2018 10:31:35 +0000
Message-ID: <913263b2-7421-5174-2e7d-5a15df40e51e@st.com>
References: <1545144493-11600-1-git-send-email-patrice.chotard@st.com>
 <20181218155239.GP26090@n2100.armlinux.org.uk>
 <b26902d8-79d6-2b09-6e35-9e8823f9181e@st.com>
 <20181218172748.GQ26090@n2100.armlinux.org.uk>
In-Reply-To: <20181218172748.GQ26090@n2100.armlinux.org.uk>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.44]
Content-ID: <FE31AC30FBF01A4EB5CCA5904A1F877B@st.com>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-12-19_06:, , signatures=0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181219_023154_365121_5E37BFE9 
X-CRM114-Status: GOOD (  18.51  )
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

On 12/18/18 6:27 PM, Russell King - ARM Linux wrote:
> On Tue, Dec 18, 2018 at 05:05:18PM +0000, Patrice CHOTARD wrote:
>> Hi Russell
>>
>> On 12/18/18 4:52 PM, Russell King - ARM Linux wrote:
>>> On Tue, Dec 18, 2018 at 03:48:13PM +0100, patrice.chotard@st.com wrote:
>>>> From: Patrice Chotard <patrice.chotard@st.com>
>>>>
>>>> Due to pen_release and boot_lock removal, secondary CPU's bringup
>>>> was broken. Restore CPU's bringup by reworking properly
>>>> .smp_prepare_cpus and .smp_boot_secondary STi callbacks.
>>>
>>> Sorry, maybe I don't understand your commit message, but you seem to be
>>> saying that removal of the pen_release and boot_lock broke STi's secondary
>>> CPU bring up?  Please clarify, and explain how that happened.
>>
>> Correct, CPU1 failed to come online.
>>
>> It seems that writing secondary_startup address at cpu-release-addr in
>> .smp_prepare_cpus callback was too early.
>>
>> Doing it in .smp_boot_secondary callback, insures that secondary_data
>> struct is populated in __cpu_up() (stack, pgdir and swapper_pg_dir fields).
> 
> Ah, you're saying that it causes the CPU to jump to secondary_startup
> while the boot CPU is in smp_prepare_cpus()?  What triggers the CPU

Yes

> to jump to the address written to cpu_strt_ptr?  What you're saying
> seems to suggest that it's the write to that address, rather than the
> IPI that's sent in sti_boot_secondary().

At platform startup, an U-Bootrom firmware initialize secondary CPU and
make it spinning waiting for a jump address to be written at cpu_strt_ptr.

I didn't pay attention to the IPI, you are right IPI is useless, i will
remove it.

> 
> If the IPI in sti_boot_secondary() isn't doing anything, it ought to
> be removed.  It'd also be a good idea to document what's going on as
> comments in the code for future maintanence.

Agree, i will add a comment.

Thanks

Patrice

> 
>> If you are ok, i will pick up your patch [1] and this one to prepare a
>> STi pull-request.
> 
> Yes, although I'll have to delay patch 9 as a result.
> 
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
