Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75B5CC10F02
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 09:49:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3DA49218D9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 09:49:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="CCjAL0Gq";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Blj1IeGy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DA49218D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:References:In-Reply-To:MIME-Version:
	Date:Message-ID:From:To:Subject:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=bKy2tdVLnIud/9yNeF/70jZ7Ud3G/PkdwLuW5kMbirM=; b=CCjAL0Gq/x/KgW
	cPZknB6EDVcYPj/0V2BCqxcO8zaiaOvweMhbneuzbh8EnS8ivTeFa+VLmBPudihNHLE6lmlwJ7f5h
	zJ7MJI9kldnwjU7jmE7xpLZUexJ9wr4SHGIjqxyS34UYHQFs27n/bk28j2iOVqu8Ht9q/MP6pNvT/
	8Lnngnb6hlHF3mcrnX2Q3kMjzpvCnbfj+k8IigycNxQa4C8DRKS/RbZUDH8kUE07I+UalEhnQXBqz
	Mf0OUq73A4vaByYvQB4Maji2/qKMGlnM8xj7ygQaOEzPMZGxITTW7c7231+oncHNtdGi63qqiz9El
	bXI2gGBYTI2QRvgXSz3A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvfYc-00007K-3S; Mon, 18 Feb 2019 09:49:50 +0000
Received: from mailout2.w1.samsung.com ([210.118.77.12])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvfYY-00006k-95
 for linux-arm-kernel@lists.infradead.org; Mon, 18 Feb 2019 09:49:48 +0000
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20190218094944euoutp0220cd83bd0eac01584149bec25c279f95~EbGxLiY0T1222912229euoutp02w
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 18 Feb 2019 09:49:44 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20190218094944euoutp0220cd83bd0eac01584149bec25c279f95~EbGxLiY0T1222912229euoutp02w
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1550483384;
 bh=jG1tSpJWH3VCG1b75ZrQolZY9yLDDwb1tlLCfBAt5qY=;
 h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
 b=Blj1IeGyODpnKa71UbnvSIGHXcumbKTm0d3XHuA+LfommgSbYw6L8DQ8Y92owU0+f
 z9dX4NtofpcUUDh+p+NeqFhEJjK6DVS/WaJzEJAxukigFGDNt/48cacfTYXbsXCepl
 EFRaE1HUjmbeuCweImSSb0viLerXMrqHODLhzgpo=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTP id
 20190218094943eucas1p1fe5c60979537d7a53caced1ab9b03dcd~EbGwrvWcc2728927289eucas1p1h;
 Mon, 18 Feb 2019 09:49:43 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
 eusmges2new.samsung.com (EUCPMTA) with SMTP id 69.82.04294.7BF7A6C5; Mon, 18
 Feb 2019 09:49:43 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20190218094942eucas1p1dd7f43f42a7e5a1d14c848b2850d9dfc~EbGvlv9yX2049220492eucas1p1h;
 Mon, 18 Feb 2019 09:49:42 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
 eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20190218094942eusmtrp257ce74cbece13083408ad7431d84f473~EbGvXSM3h0103201032eusmtrp2i;
 Mon, 18 Feb 2019 09:49:42 +0000 (GMT)
X-AuditID: cbfec7f4-84fff700000010c6-76-5c6a7fb7e475
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
 eusmgms1.samsung.com (EUCPMTA) with SMTP id 8C.BE.04284.5BF7A6C5; Mon, 18
 Feb 2019 09:49:42 +0000 (GMT)
Received: from [106.116.147.30] (unknown [106.116.147.30]) by
 eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20190218094941eusmtip227360cafe02254420fe2f8143fdae2be~EbGu2H4MP2665126651eusmtip2q;
 Mon, 18 Feb 2019 09:49:41 +0000 (GMT)
Subject: Re: [PATCH 3/5] clocksource: exynos_mct: Increase priority over ARM
 arch timer
To: Daniel Lezcano <daniel.lezcano@linaro.org>,
 linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
From: Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <fd3aac7b-029e-5873-f472-a0c83dda4da5@samsung.com>
Date: Mon, 18 Feb 2019 10:49:41 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <4b054e7d-5dd5-5796-6c08-22f15060f940@linaro.org>
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrHKsWRmVeSWpSXmKPExsWy7djP87rb67NiDM5c57fYOGM9q8X1L89Z
 LeZ9lrU4f34Du8Wmx9dYLWac38dksXnTVGYHdo9NqzrZPO5c28Pm8e7cOXaPzUvqPfq2rGL0
 +LxJLoAtissmJTUnsyy1SN8ugSujb/cjtoJzChU39q1lamCcKd3FyMkhIWAi0T75NVsXIxeH
 kMAKRonzj/ezQjhfGCWWnXzNDOF8ZpS41PSXCabl3NtOqMRyRokX7/uhWt4zSpy7eIQVpEpY
 IFLiyvrz7CC2iEClxLm2KewgRcwC6xkl1i6YB1bEJmAo0fW2iw3E5hWwkzi/8AXQCg4OFgFV
 iQcTk0DCogIxElPOHWGHKBGUODnzCQtICSdQ+dUPnCBhZgF5ie1v5zBD2OISt57MZwJZJSGw
 jV3i5Ypj7BBXu0g8XbEfyhaWeHV8C5QtI/F/J0xDM6NE+4xZ7BBOD6PE1jk72CCqrCUOH7/I
 CrKZWUBTYv0ufYiwo8T3tldgYQkBPokbbwUhjuCTmLRtOjNEmFeio00IolpNYtbxdXBrD164
 xDyBUWkWks9mIXlnFpJ3ZiHsXcDIsopRPLW0ODc9tdgoL7Vcrzgxt7g0L10vOT93EyMwFZ3+
 d/zLDsZdf5IOMQpwMCrx8H4oy4wRYk0sK67MPcQowcGsJMIbFJsVI8SbklhZlVqUH19UmpNa
 fIhRmoNFSZy3muFBtJBAemJJanZqakFqEUyWiYNTqoFxs/Of/37fdx+/Ntny5mX7yoiu+IXG
 Uts3Gx5n4OfeuiGhaQ1r1Jazug+mzdinoOrYwKNX8/dYdOKufy+5VvRe9WWZt37RUVGLi0ci
 2J4aJVXLVJ0KD9/yY4/ge6m8h/8s50W+D3/f5st39KVIq+yDNaLZxts0GiZpmr7TfzpbbtF7
 9mjbT1tfKLEUZyQaajEXFScCAIHT4iZBAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrLIsWRmVeSWpSXmKPExsVy+t/xe7rb6rNiDN5sZbLYOGM9q8X1L89Z
 LeZ9lrU4f34Du8Wmx9dYLWac38dksXnTVGYHdo9NqzrZPO5c28Pm8e7cOXaPzUvqPfq2rGL0
 +LxJLoAtSs+mKL+0JFUhI7+4xFYp2tDCSM/Q0kLPyMRSz9DYPNbKyFRJ384mJTUnsyy1SN8u
 QS+jb/cjtoJzChU39q1lamCcKd3FyMkhIWAice5tJzOILSSwlFFi1nEHiLiMxMlpDawQtrDE
 n2tdbF2MXEA1bxklft3aAtYgLBApcWX9efYuRg4OEYFKiUnLskFqmAXWM0p8Xn+ZEaLhEZPE
 l84zYA1sAoYSXW9BJnFy8ArYSZxf+IIJpJlFQFXiwcQkEFNUIEbi6jlGiApBiZMzn7CAhDmB
 qq9+4AQJMwuoS/yZd4kZwpaX2P52DpQtLnHryXymCYxCs5B0z0LSMgtJyywkLQsYWVYxiqSW
 Fuem5xYb6hUn5haX5qXrJefnbmIERt22Yz8372C8tDH4EKMAB6MSD++HsswYIdbEsuLK3EOM
 EhzMSiK8QbFZMUK8KYmVValF+fFFpTmpxYcYTYE+m8gsJZqcD0wIeSXxhqaG5haWhubG5sZm
 FkrivOcNKqOEBNITS1KzU1MLUotg+pg4OKUaGPP2XrjG/MPWR47PQFNw54LOSXtmn3jNo8xz
 zcDzVL6b2rYzYruLElwt3bbOft7qF1cQVODL4ny1sVb76Yl2vtrkP4v+zZzvXT3j10b/ZpaM
 BzVujcoGC3+sVNl9gf1XZdHT/LAQvYlb/aV3aO4QEjknr+ReN0nkQIroBpEJNsbR4VfL028u
 VmIpzkg01GIuKk4EABBL3PDQAgAA
X-CMS-MailID: 20190218094942eucas1p1dd7f43f42a7e5a1d14c848b2850d9dfc
X-Msg-Generator: CA
X-RootMTR: 20190215125239eucas1p2d9167af42f2d04e462c56a070c3371c2
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190215125239eucas1p2d9167af42f2d04e462c56a070c3371c2
References: <20190215125229.30180-1-m.szyprowski@samsung.com>
 <CGME20190215125239eucas1p2d9167af42f2d04e462c56a070c3371c2@eucas1p2.samsung.com>
 <20190215125229.30180-4-m.szyprowski@samsung.com>
 <01569ba7-2e3e-5811-81e1-ca51cacbcb95@linaro.org>
 <7b994b86-9a84-39a7-e88d-203c64b30de8@samsung.com>
 <4b054e7d-5dd5-5796-6c08-22f15060f940@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_014946_623838_E4F6F128 
X-CRM114-Status: GOOD (  22.25  )
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
Cc: Chanwoo Choi <cw00.choi@samsung.com>, Thomas Gleixner <tglx@linutronix.de>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Daniel,

On 2019-02-18 10:24, Daniel Lezcano wrote:
> On 18/02/2019 08:41, Marek Szyprowski wrote:
>> On 2019-02-15 17:35, Daniel Lezcano wrote:
>>> On 15/02/2019 13:52, Marek Szyprowski wrote:
>>>> Exynos Multi-Core Timer driver (exynos_mct) must be started before ARM
>>>> Architected Timers (arch_timer), because they both share some common
>>>> hardware blocks (global system counter) and turning on MCT is needed
>>>> to get ARM Architected Timer working properly. Increase MCT timer rating
>>>> and hotplug priority over ARM Archictected timer driver to achieve that.
>>> This is a hack.
>>>
>>> There are mechanisms to handle this kind of dependency.
>>>
>>> eg. https://www.kernel.org/doc/html/v4.15/driver-api/device_link.html
>> Sorry, but this is not a hack, but proper way to handle this in
>> clocksource/timers framework. The ratings assigned to each driver and
>> cpu hotplug priority list are exactly for managing the requested order
>> of operations if more than one driver has been registered.
> Actually, I'm reluctant with this change (even if it is correct) because
> it introduces an implicit dependency in the cpu hotplug enumeration for
> the timer subsystem while it may be more correct to have it explicitly
> with the hardware description (or whatever).

Maybe additional comment in the cpu hotplug list will convince you? For
the current code changing the order of enums it is more than enough.
There are no dynamic CPU hotplug priorities, so MCT driver cannot change
its behavior depending on any dt-property or so. Increasing MCT priority
has no side-effects in relation to other drivers (as they cannot
existing on the same board).

> However I don't see a proper way to describe this dependency without
> touching the DT and add a phandle to the arch timer in the exynos_mct
> timer description.
>
>> Device links operates on the 'kernel device' objects, which are created
>> and managed much later than clocksource/timers are initialized. I see no
>> use of device links in this context.
> Yes, that was just an example to show there are mechanisms to allow
> proper ordering. As said before, not the best example for this situation.
>
>>>> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
>>>> ---
>>>>  drivers/clocksource/exynos_mct.c | 4 ++--
>>>>  include/linux/cpuhotplug.h       | 2 +-
>>>>  2 files changed, 3 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/drivers/clocksource/exynos_mct.c b/drivers/clocksource/exynos_mct.c
>>>> index 49413900b24c..58090f57ada3 100644
>>>> --- a/drivers/clocksource/exynos_mct.c
>>>> +++ b/drivers/clocksource/exynos_mct.c
>>>> @@ -211,7 +211,7 @@ static void exynos4_frc_resume(struct clocksource *cs)
>>>>  
>>>>  static struct clocksource mct_frc = {
>>>>  	.name		= "mct-frc",
>>>> -	.rating		= 400,
>>>> +	.rating		= 450,
>>>>  	.read		= exynos4_frc_read,
>>>>  	.mask		= CLOCKSOURCE_MASK(32),
>>>>  	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
>>>> @@ -465,7 +465,7 @@ static int exynos4_mct_starting_cpu(unsigned int cpu)
>>>>  	evt->set_state_oneshot_stopped = set_state_shutdown;
>>>>  	evt->tick_resume = set_state_shutdown;
>>>>  	evt->features = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT;
>>>> -	evt->rating = 450;
>>>> +	evt->rating = 500;
>>>>  
>>>>  	exynos4_mct_write(TICK_BASE_CNT, mevt->base + MCT_L_TCNTB_OFFSET);
>>>>  
>>>> diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
>>>> index fd586d0301e7..bdd544f21102 100644
>>>> --- a/include/linux/cpuhotplug.h
>>>> +++ b/include/linux/cpuhotplug.h
>>>> @@ -115,10 +115,10 @@ enum cpuhp_state {
>>>>  	CPUHP_AP_PERF_ARM_ACPI_STARTING,
>>>>  	CPUHP_AP_PERF_ARM_STARTING,
>>>>  	CPUHP_AP_ARM_L2X0_STARTING,
>>>> +	CPUHP_AP_EXYNOS4_MCT_TIMER_STARTING,
>>>>  	CPUHP_AP_ARM_ARCH_TIMER_STARTING,
>>>>  	CPUHP_AP_ARM_GLOBAL_TIMER_STARTING,
>>>>  	CPUHP_AP_JCORE_TIMER_STARTING,
>>>> -	CPUHP_AP_EXYNOS4_MCT_TIMER_STARTING,
>>>>  	CPUHP_AP_ARM_TWD_STARTING,
>>>>  	CPUHP_AP_QCOM_TIMER_STARTING,
>>>>  	CPUHP_AP_ARMADA_TIMER_STARTING,
>>>>
Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
