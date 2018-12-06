Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3A54C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 15:54:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2D63214C1
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 15:54:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="k+MljUXL";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="YHjhNzNV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2D63214C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:References:In-Reply-To:MIME-Version:
	Date:Message-ID:From:To:Subject:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=7U2ahEwcAsQzNSwEAM+wdA6vMsRmht/qaWce4tNhK+A=; b=k+MljUXLDeVQsL
	UGV2Gc+ECZ4oskLpz5PdAcXk78L4vH9e89Aw8UPea1RfkenkDlt4DEyLxSrYOzlT6xqMaujJYfOIs
	SyCcXqgmkyQP71NH1XT6YSF7sh7aN9eOTDKIpV9qRci1wHh6IIhQs4fWDRBK0WwEQeP4DMd+a45Dq
	y/aPxGA08v3iqMa2Orc0V8LhxzTIVpQqSO4uMJTPiIfV0EGOLoknUrlaOJlYjVy0dQu+jZdvQjjtd
	HhKKe17/gydoo0NBLyOuMMS2SoZ7kBC5s5oMSQC0sMGvLFLFNw3zeJHWggHUFXmcTQvW3kZVGYgo2
	gZyOlZwP/Hfs9lpKeiPg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUvzA-0000Qw-53; Thu, 06 Dec 2018 15:54:44 +0000
Received: from mailout1.w1.samsung.com ([210.118.77.11])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUvz6-0000Fl-Et
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 15:54:42 +0000
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id
 20181206155424euoutp01f4dfa9a3bb408936f13d3fa5409db190~tyWC2ZrM11230912309euoutp01N
 for <linux-arm-kernel@lists.infradead.org>;
 Thu,  6 Dec 2018 15:54:24 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com
 20181206155424euoutp01f4dfa9a3bb408936f13d3fa5409db190~tyWC2ZrM11230912309euoutp01N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1544111664;
 bh=pZxuTkssYMGIxENp2XYGwOXTYx6helKD9cnpZrWR6j4=;
 h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
 b=YHjhNzNVZbpwL05pLAQaB/H0cM2bkWEvnyjBip4gLH2yJ7XsmVaSqhecz7UxtnbQf
 zOUT00abFezVrFWednwzGNi1re5IHfr/+H6nS2/8uDkM543LSgIhU91wNrok6OC195
 tuyqhWnM+bQeNnIsh/IMR+pF9Rm0Iz+tygR+Mt2U=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTP id
 20181206155423eucas1p1a57b5d4d52818384dd3b1cfa155e935e~tyWCNQQ-P3018230182eucas1p1A;
 Thu,  6 Dec 2018 15:54:23 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
 eusmges1new.samsung.com (EUCPMTA) with SMTP id F5.AF.04441.F26490C5; Thu,  6
 Dec 2018 15:54:23 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20181206155422eucas1p2e3f0e349dcb608c9313f8cd7d1770540~tyWBWC72V3126131261eucas1p2q;
 Thu,  6 Dec 2018 15:54:22 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
 eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20181206155422eusmtrp1d8aa61e032fffae4e12fc5cd7319ccb8~tyWBHP23V0180801808eusmtrp1I;
 Thu,  6 Dec 2018 15:54:22 +0000 (GMT)
X-AuditID: cbfec7f2-a1ae89c000001159-0f-5c09462f98b6
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
 eusmgms2.samsung.com (EUCPMTA) with SMTP id 6E.44.04128.E26490C5; Thu,  6
 Dec 2018 15:54:22 +0000 (GMT)
Received: from [106.116.147.30] (unknown [106.116.147.30]) by
 eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20181206155422eusmtip176fc6af61f508a670e78c5688fa0123d~tyWAmImIt1063410634eusmtip17;
 Thu,  6 Dec 2018 15:54:22 +0000 (GMT)
Subject: Re: [PATCH v2 5/5] ARM: spectre-v2: per-CPU vtables to work around
 big.Little systems
To: Russell King - ARM Linux <linux@armlinux.org.uk>, Krzysztof Kozlowski
 <krzk@kernel.org>
From: Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <3bc43a53-40b1-3053-850b-5b401a3b294d@samsung.com>
Date: Thu, 6 Dec 2018 16:54:21 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.2
MIME-Version: 1.0
In-Reply-To: <20181206153128.GW30658@n2100.armlinux.org.uk>
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA01SfSyUcRz38zyee+7W2c8h32G7dtPpzXGbP56lGa3Jpte/WnXK4RmWQ3eI
 stxCObMii1x6WfOWGbqQWaIL52WLY3kpjaSaDFFWKuQ8lP8+n8/3+9nn8/3tRxOiWhtnOiom
 nlXHKKMllICsb1/s8fAM4Cu8jHfFzMecOoK58voo09NTw2MMHwZsGOOtJsQsjSxTTMmg2ZqZ
 nflNMU0Vfyhmcq6D9BMEVt6rRIH9A2Yi0FChowKfFKceI08J9oWz0VGJrNrTN0QQma4bJOLa
 tiYttpdSWtQiykJ8GrA3FL67g7KQgBbhcgRteTdsOPIdgbF6kbJsifA3BDWdvhsO42TDuqMM
 ge5H/zqZRdCcM73msMch8H4s19qCHXAw5LdoeZYlAr9CMJ82gywDCsshazprzSDEvmBYyl3T
 SewGv6oyV3vQtCNWQOPnFG7FDjoLJ0gL5mMf0NW28iyYwGJ4Ol1EcNgJ3kzct7ZkAX7OA21b
 P8XVPgAVP4sRh+3hi6mWx2FX6M7LJjlDGoJrt/U8jmQjqCtqWHf7wEuTea0RgXdCdaMnJ/vD
 1MoUZZEB28LQtB1XwhZu1hcQnCyEzKvrby0FvanqX+yL3j4iB0n0m07TbzpHv+kc/f/cB4is
 QE5sgkYVwWrkMewFmUap0iTERMjCYlUGtPqXupdN8w1ooS/UiDCNJFuESX58hchGmahJVhkR
 0ITEQWgloxUiYbgy+SKrjj2rTohmNUbkQpMSJ+Elq7HTIhyhjGfPsWwcq96YWtN8Zy3CAdnP
 uty3nX/kJy0baHCXueN+8XBOZLOPfxCEqa6vnPCdGlnYrU+ZP1QUXZI+Pk5n1Bkeu27Pd5ub
 eCs9M3R5tFlhHv3UelBe5u1RPh7hsafya75XTalPx+H9BfLUAfEO816tp0tQkbQpuDKjV6rr
 qg0Vs7Ru+OHx3LCTR3odJaQmUinfRag1yr9AUE2FRwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrBIsWRmVeSWpSXmKPExsVy+t/xu7p6bpwxBstnyVk8nbCV2aLpqr/F
 +fMb2C02Pb7GanFo6l5Gi793/rFZLL1+kcni/bvfbBZ7V/1hs3j58QSLA5fHmnlrGD0uX7vI
 7LFpVSebx+Yl9QEsUXo2RfmlJakKGfnFJbZK0YYWRnqGlhZ6RiaWeobG5rFWRqZK+nY2Kak5
 mWWpRfp2CXoZLZ3XmQuOilX8PLaMrYHxgFAXIyeHhICJxKGXOxi7GLk4hASWMkocn/6dCSIh
 I3FyWgMrhC0s8edaFxtE0VtGiUl3GxhBEsICCRIPH0wEaxARiJWY92QyWBGzwDlGiR+3e5kg
 Oi6wSjQsngLWwSZgKNH1FmQUJwevgJ3Epr8TweIsAioSv9Z1gK0TFYiRmHL5NStEjaDEyZlP
 WEBsTgFric4tR9hBbGYBdYk/8y4xQ9jyEtvfzoGyxSVuPZnPNIFRaBaS9llIWmYhaZmFpGUB
 I8sqRpHU0uLc9NxiI73ixNzi0rx0veT83E2MwFjcduznFmA4vQs+xCjAwajEw1vhwBkjxJpY
 VlyZe4hRgoNZSYSXQY8jRog3JbGyKrUoP76oNCe1+BCjKdBzE5mlRJPzgWkiryTe0NTQ3MLS
 0NzY3NjMQkmc97xBZZSQQHpiSWp2ampBahFMHxMHp1QD44RcZTmWuSdevuWwvJTQbHVd2nj2
 Cq+CHqZtKuIFR80nLWXlmZnlGGGy47xnqudzNaNd+VXbu17Pn9l85/+MoJa42lmfN75ZtD/P
 SaZUzvZEyZZ1WZJVz6Ni/MJO1xtbJDfrPat+abCcQ/5s5BnNz23zZr+O7C2rqJ42+cAFhvB9
 3SvyMzZvVGIpzkg01GIuKk4EACJEkpDbAgAA
X-CMS-MailID: 20181206155422eucas1p2e3f0e349dcb608c9313f8cd7d1770540
X-Msg-Generator: CA
X-RootMTR: 20181206153248epcas3p3c82828e563e6ac3bccb1fa28a8beab71
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181206153248epcas3p3c82828e563e6ac3bccb1fa28a8beab71
References: <E1gK0dU-0007Mp-4h@rmk-PC.armlinux.org.uk>
 <dda0be26-5ac8-a158-3210-4bc6861bede2@samsung.com>
 <20181206100052.GR30658@n2100.armlinux.org.uk>
 <CAJKOXPdUFfOXqMkgdv4fjhpbrmjNmw_f9cMj03a2h65snNJ4qw@mail.gmail.com>
 <20181206123956.GS30658@n2100.armlinux.org.uk>
 <CAJKOXPf=nGN53EK=+bjhKyaY_knMnY5J+JSW2Jb6KRQuJy37vA@mail.gmail.com>
 <20181206140717.GU30658@n2100.armlinux.org.uk>
 <CAJKOXPdUABPbni+1H=tTvA5wKe8Rc8EPTFKtLGMwQ8yLcb3=gg@mail.gmail.com>
 <20181206143703.GV30658@n2100.armlinux.org.uk>
 <CAJKOXPchTZtFKtycEEhYoxZR53VckqZYQfOrGNhDvUARxBS4fw@mail.gmail.com>
 <CGME20181206153248epcas3p3c82828e563e6ac3bccb1fa28a8beab71@epcas3p3.samsung.com>
 <20181206153128.GW30658@n2100.armlinux.org.uk>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_075440_792843_055E2D6B 
X-CRM114-Status: GOOD (  15.61  )
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
Cc: mark.rutland@arm.com, julien.thierry@arm.com, marc.zyngier@arm.com,
 will.deacon@arm.com, Morten.Rasmussen@arm.com, dietmar.eggemann@arm.com,
 linux-arm-kernel@lists.infradead.org, Qais.Yousef@arm.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 2018-12-06 16:31, Russell King - ARM Linux wrote:
> On Thu, Dec 06, 2018 at 04:03:27PM +0100, Krzysztof Kozlowski wrote:
>> On Thu, 6 Dec 2018 at 15:37, Russell King - ARM Linux
>> <linux@armlinux.org.uk> wrote:
>>> On Thu, Dec 06, 2018 at 03:30:22PM +0100, Krzysztof Kozlowski wrote:
>>>> On Thu, 6 Dec 2018 at 15:07, Russell King - ARM Linux
>>>>> That basically means that the dcache_clean_area method for CPU1
>>>>> differs from the dcache_clean_area method for CPU0.  If all your
>>>>> CPUs are identical, that definitely should not be happening.
>>>>>
>>>>> Hmm.  Interestingly, OMAP4430 passes hotplug tests just fine.
>>>>>
>>>>> Please try this patch.
>>>> This fixes both hotplug and suspend to RAM. I was trying to narrow why
>>>> the pointers to all processor functions differ. During first boot they
>>>> were OK but it seems they were changed just before suspend.
>>> Thanks for testing.  I think this is probably a better patch which
>>> should end up with the same result.
>>>
>>> I suspect no one else has noticed because most people have big.Little
>>> support disabled - that'd explain why it doesn't show up on OMAP4.
>>>
>>> diff --git a/arch/arm/mm/proc-macros.S b/arch/arm/mm/proc-macros.S
>>> index 81d0efb055c6..44f9776139a8 100644
>>> --- a/arch/arm/mm/proc-macros.S
>>> +++ b/arch/arm/mm/proc-macros.S
>>> @@ -274,6 +274,13 @@
>>>         .endm
>>>
>>>  .macro define_processor_functions name:req, dabort:req, pabort:req, nommu=0, suspend=0, bugs=0
>>> +/*
>>> + * If we are building for big.Little with branch predictor hardening,
>>> + * we need the processor function tables to remain available after boot.
>>> + */
>>> +#if defined(CONFIG_BIG_LITTLE) && defined(CONFIG_HARDEN_BRANCH_PREDICTOR)
>>> +       .rodata
>>> +#endif
>>>         .type   \name\()_processor_functions, #object
>>>         .align 2
>>>  ENTRY(\name\()_processor_functions)
>>> @@ -309,6 +316,9 @@ ENTRY(\name\()_processor_functions)
>>>         .endif
>>>
>>>         .size   \name\()_processor_functions, . - \name\()_processor_functions
>>> +#if defined(CONFIG_BIG_LITTLE) && defined(CONFIG_HARDEN_BRANCH_PREDICTOR)
>>> +       .previous
>>> +#endif
>>>  .endm
>>>
>>>  .macro define_cache_functions name:req
>> Does not compile:
>> ../arch/arm/mm/proc-v7.S: Assembler messages:
>> ../arch/arm/mm/proc-v7.S:560: Error: unknown pseudo-op: `.rodata'
>> ../arch/arm/mm/proc-v7.S:575: Error: unknown pseudo-op: `.rodata'
>> ../arch/arm/mm/proc-v7.S:596: Error: unknown pseudo-op: `.rodata'
>> ../arch/arm/mm/proc-v7.S:611: Error: unknown pseudo-op: `.rodata'
>> ../arch/arm/mm/proc-v7.S:629: Error: unknown pseudo-op: `.rodata'
> It should be .section ".rodata", sorry.


With the above change, the issue is fixed, both for hotplug and s2r.


Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
