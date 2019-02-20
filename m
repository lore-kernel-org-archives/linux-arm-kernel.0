Return-Path: <SRS0=0Bxu=Q3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F106BC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 05:18:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0E6B21848
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 05:18:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="m327vaWS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0E6B21848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=4QVSaq4SD0FaDrfJbbJeMPuBiEopJXh8pDMBte0He3s=; b=m327vaWSyINvmnI1mBR0T3Bkf
	WC+uc4frH97B4EbkA38ayZNQ17JUlGjPUMxGWWS1Axvxlaw3zXM6YBxPrvjM7aMl1Y4JZO8cv5f3J
	b369C7HL0KCjpkjaUtFcRajWDCQIdIO5bkISF2UG03wNQJvOnSZa3eBknxh+8owWmyxR15txWhcLU
	6h6TXiPpkbEyesqikk0Os0mfyLOOtlKvw7cO89z1iWyzebbhfmlIPUNKc1IXvRUr5BGfIqB6rG897
	Erd4A65FNGTYxiLvm6QuMUcyclgT/VW7GngnWu2JXbLoV0QQFkLPddTUmfNymUN0O0pGP/AOJ2oZY
	QPaFNBPXw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwKGm-0003c3-Kn; Wed, 20 Feb 2019 05:18:08 +0000
Received: from mx.socionext.com ([202.248.49.38])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwKGi-0003bA-VU
 for linux-arm-kernel@lists.infradead.org; Wed, 20 Feb 2019 05:18:06 +0000
Received: from unknown (HELO iyokan-ex.css.socionext.com) ([172.31.9.54])
 by mx.socionext.com with ESMTP; 20 Feb 2019 14:17:56 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
 by iyokan-ex.css.socionext.com (Postfix) with ESMTP id E031F6117D;
 Wed, 20 Feb 2019 14:17:56 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP;
 Wed, 20 Feb 2019 14:17:56 +0900
Received: from yuzu.css.socionext.com (yuzu [172.31.8.45])
 by kinkan.css.socionext.com (Postfix) with ESMTP id 7D5FB1A04E1;
 Wed, 20 Feb 2019 14:17:56 +0900 (JST)
Received: from [127.0.0.1] (unknown [10.213.119.83])
 by yuzu.css.socionext.com (Postfix) with ESMTP id 6B78D121B6C;
 Wed, 20 Feb 2019 14:17:56 +0900 (JST)
Subject: Re: [PATCH v2 04/15] ARM: milbeaut: Add basic support for Milbeaut
 m10v SoC
To: Arnd Bergmann <arnd@arndb.de>
References: <1549628778-30785-1-git-send-email-sugaya.taichi@socionext.com>
 <CAK8P3a026P7tZpJ7gsZbf_MnJJ0eVv60ggGXYndX9kCDLpNy4Q@mail.gmail.com>
 <7266af3b-aeec-4c29-c96e-ee0d21d3e867@socionext.com>
 <CAK8P3a09+K7ZPBgHs45Z2e_w6DPzXDMPT+DpXBowT0SBu8oCtw@mail.gmail.com>
From: "Sugaya, Taichi" <sugaya.taichi@socionext.com>
Message-ID: <9979cb94-ce35-56de-df2e-33c10517ed77@socionext.com>
Date: Wed, 20 Feb 2019 14:17:55 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.1; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a09+K7ZPBgHs45Z2e_w6DPzXDMPT+DpXBowT0SBu8oCtw@mail.gmail.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190219_211805_121494_23028C86 
X-CRM114-Status: GOOD (  18.60  )
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
Cc: Shinji Kanematsu <kanematsu.shinji@socionext.com>,
 Masami Hiramatsu <masami.hiramatsu@linaro.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Russell King <linux@armlinux.org.uk>, Jassi Brar <jaswinder.singh@linaro.org>,
 Takao Orito <orito.takao@socionext.com>,
 Kazuhiro Kasai <kasai.kazuhiro@socionext.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi,

On 2019/02/19 18:21, Arnd Bergmann wrote:
> On Tue, Feb 19, 2019 at 8:12 AM Sugaya, Taichi
> <sugaya.taichi@socionext.com> wrote:
>> On 2019/02/18 21:15, Arnd Bergmann wrote:
>>> On Fri, Feb 8, 2019 at 1:26 PM Sugaya Taichi
>>> <sugaya.taichi@socionext.com> wrote:
>>
>>>> +static int __init m10v_pm_init(void)
>>>> +{
>>>> +       suspend_set_ops(&m10v_pm_ops);
>>>> +
>>>> +       return 0;
>>>> +}
>>>> +late_initcall(m10v_pm_init);
>>>
>>> This requires a check to ensure you are actually on the right platform,
>>> otherwise you break suspend/resume in a multiplatform kernel running
>>> on anything other than milbeaut.
>>>
>>
>> OK.
>> I think the solution is adding a "if statement with mlbeaut compatible"
>> above suspend_set_ops(&m10v_pm_ops).
> 
> Right, you can either use a call to of_machine_is_compatible(),
> or you add a machine descriptor with OF_MACHINE_START()
> and use this as the init_late() callback.
> 

Yeah, I will use "of_machine_is_compatible()".

Thanks,
Sugaya Taichi

>        Arnd
> 


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
