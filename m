Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83A16C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 16:31:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54D18222A1
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 16:31:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LvlPs+07"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54D18222A1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=E2rvKyZgLMkiaxKxHL2Qv0ttB/37xUDZ0BG85d/AnRs=; b=LvlPs+07QgC3lqTfyqg34wBCy
	Bkz+0QyUYN8QGnszoZJlLjP6e+09IMn8deRnSGf8A/zixFb315/Cv2+5ERCL4kPluYXFjhjgNKwHB
	reTE83n/4orCszLAbINMRwS/v/61wgBTz4cYjiti/3Xv0n7oyusXyCBcKJaCEGFOal5HYM5dkmf1C
	Y0+v7+r4lflTJrc5bVvjDKcLxo261CzT8oXHjcATL0TfHYVpd8JCPK4fzmmQF7qpqPwtwPSKBKaJj
	RH1w0has7yCVvM9rU7hLOvEF451uGSzePFoN7k6dbeyxl4COlv4Pft/KCCx9bNnI584NuC4pnpDiQ
	MeFL1409g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gugOG-0003KD-Hu; Fri, 15 Feb 2019 16:31:04 +0000
Received: from mx07-00178001.pphosted.com ([62.209.51.94])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gugOB-0003Jd-1o
 for linux-arm-kernel@lists.infradead.org; Fri, 15 Feb 2019 16:31:01 +0000
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x1FGUiLv025972; Fri, 15 Feb 2019 17:30:47 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx07-00178001.pphosted.com with ESMTP id 2qmy1njgm8-1
 (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
 Fri, 15 Feb 2019 17:30:47 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 8574F31;
 Fri, 15 Feb 2019 16:30:46 +0000 (GMT)
Received: from Webmail-eu.st.com (gpxdag3node5.st.com [10.75.127.72])
 by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 544B25AD5;
 Fri, 15 Feb 2019 16:30:46 +0000 (GMT)
Received: from [10.201.21.58] (10.75.127.47) by GPXDAG3NODE5.st.com
 (10.75.127.72) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Fri, 15 Feb
 2019 17:30:45 +0100
Subject: Re: [PATCH 0/2] ARM errata 814220
To: Arnd Bergmann <arnd@arndb.de>, Benjamin Gaignard
 <benjamin.gaignard@linaro.org>
References: <20190213095613.31045-1-benjamin.gaignard@linaro.org>
 <CAK8P3a0mbEqfzQhP0qX3kSnErBLws9ojkmbVQng9HhujFLCMvA@mail.gmail.com>
From: Alexandre Torgue <alexandre.torgue@st.com>
Message-ID: <755c9689-9027-b085-d511-05d833d1e6ef@st.com>
Date: Fri, 15 Feb 2019 17:30:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a0mbEqfzQhP0qX3kSnErBLws9ojkmbVQng9HhujFLCMvA@mail.gmail.com>
Content-Language: en-US
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG1NODE1.st.com (10.75.127.1) To GPXDAG3NODE5.st.com
 (10.75.127.72)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-02-15_12:, , signatures=0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_083059_413648_B442B8EE 
X-CRM114-Status: GOOD (  21.19  )
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
Cc: linux-stm32@st-md-mailman.stormreply.com,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org



On 2/13/19 3:52 PM, Arnd Bergmann wrote:
> On Wed, Feb 13, 2019 at 10:56 AM Benjamin Gaignard
> <benjamin.gaignard@linaro.org> wrote:
>>
>> Implement ARM errata 814220 for Cortex A7.
>>
>> This patch has been wroten by Jason Liu years ago but never send upstream.
>> I have tried to contact the author on multiple email addresses but I haven't
>> found any valid one...
>> I have keep Jason's sign-off and just rebase the patch on to v5-rc6.
>>
>> Benjamin Gaignard (2):
>>    ARM: errata 814220-B-Cache maintenance by set/way operations can
>>      execute out of order.
>>    ARM: stm32: select ARM errata 814220
>>
>>   arch/arm/Kconfig            | 10 ++++++++++
>>   arch/arm/mach-stm32/Kconfig |  1 +
>>   arch/arm/mm/cache-v7.S      |  3 +++
>>   3 files changed, 14 insertions(+)
> 
> Looks good to me,
> 
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> 
> It probably makes most sense to keep them as a series, either
> through the soc tree or Russell's patch tracker, so feel free to add
> it there, and have them both in the stm32 soc branch for arm-soc
> if Russell prefers.

Russel, what do you think about Arnd proposition? I could take both
patches in my stm32 tree. It'll make part of future v5.2 pull request.

Alex


> 
> As we have a number of Cortex-A7 based platforms with all
> kinds of revisions, I wonder if we should also select the workaround
> for the others. I can probably figure out which SoC platforms
> are based on Cortex-A7, but I have no idea about the revisions,
> so that might mean we'd have to do it for all of them. According
> to the latest TRM I found, only revisions r0p0 through r0p5
> exist, and the erraturm text lists r0p2 through r0p5, which may
> mean all products ever shipped in practice (the oldest public
> TRM from 2012 already describe r0p3).
> 
> 
> 
> 
>       Arnd
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
