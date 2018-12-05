Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E99BC04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 11:46:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70359206B7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 11:46:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="AjSK4wiA";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="slUgH+uW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70359206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=partner.samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:References:In-Reply-To:MIME-Version:
	Date:Message-ID:From:To:Subject:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=wxa7Co+IMQrgpbx1wP7yER76vCmUHzcBKEwWNkzlpsE=; b=AjSK4wiAkgx9bM
	jA18sBEWKMuyTh9tFNdqosch53AUHVlDkxJkcmPcuWZ1yLsW33i2MdK0rFx6uJQRzLkISVm1C3xWD
	RBpdp8U2lWlMpZmOHQq6ArkOojLJVpMlR9lsS+OJgqyllP4Z8Y7htov7zY0/bTdc/+ChGVIXyRR84
	IvnRNM/2b474EJ/dgAeceoUwNYOpy58BIs1X9/ltIlMhn9nQqMjYTY4zNuBzG4icj85Y6uEq823eW
	lC8uBagfngTES8iUA6pLxS+QnzTOdVUnwSzmzliKT4T5bTBOxpjPfCPjz4BRvj0rzeWrQ/4+4FFaE
	KGd0VlwR6y63MCn2sbNg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUVdH-0000vG-9z; Wed, 05 Dec 2018 11:46:23 +0000
Received: from mailout2.w1.samsung.com ([210.118.77.12])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUVd8-0000tx-MA
 for linux-arm-kernel@lists.infradead.org; Wed, 05 Dec 2018 11:46:21 +0000
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20181205114602euoutp02ebdc5a5fe017ab909446cae85a2519d9~tbT6B_jfj2418924189euoutp02w
 for <linux-arm-kernel@lists.infradead.org>;
 Wed,  5 Dec 2018 11:46:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20181205114602euoutp02ebdc5a5fe017ab909446cae85a2519d9~tbT6B_jfj2418924189euoutp02w
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1544010362;
 bh=VyyNLPI48WlffjS32suAnYarkZNSWIK4Qo30G8RiODU=;
 h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
 b=slUgH+uW+QV96dMZxrRmEHTErkYkCO8t062whYlmsb38D14OrtNfp9/mgwax74DTH
 EN8lrCZnfefgkP/9urSZ6RQJV0xNAmnB5zb60M2+Q32yQb8jiPfhQQuu88C5G8XfhY
 TcuwLc1Vf/MjKL2upnFdouA3kvqqos9iXaWNxloc=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTP id
 20181205114601eucas1p20aff8666db9c63f8abe2d955ddd002fe~tbT48E2cb0237202372eucas1p2g;
 Wed,  5 Dec 2018 11:46:01 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
 eusmges3new.samsung.com (EUCPMTA) with SMTP id B8.21.04806.87AB70C5; Wed,  5
 Dec 2018 11:46:00 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20181205114600eucas1p25c68a55f23f8fb97d4ae2febabd1b4f1~tbT4FvnFW1750517505eucas1p2d;
 Wed,  5 Dec 2018 11:46:00 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
 eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20181205114600eusmtrp1c912b3ffbe1fbefb8c977dac31153b7e~tbT31MHmM0252502525eusmtrp1h;
 Wed,  5 Dec 2018 11:46:00 +0000 (GMT)
X-AuditID: cbfec7f5-34dff700000012c6-08-5c07ba7871ca
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
 eusmgms2.samsung.com (EUCPMTA) with SMTP id F2.08.04128.87AB70C5; Wed,  5
 Dec 2018 11:46:00 +0000 (GMT)
Received: from [106.120.51.20] (unknown [106.120.51.20]) by
 eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20181205114559eusmtip1f1e18c0a9c4406fb4c642770235d1c5f~tbT2_wVzP0344103441eusmtip1o;
 Wed,  5 Dec 2018 11:45:59 +0000 (GMT)
Subject: Re: [PATCH v3 5/5] arm: dts: exynos4: opp-suspend in DMC and leftbus
To: Krzysztof Kozlowski <krzk@kernel.org>
From: Lukasz Luba <l.luba@partner.samsung.com>
Message-ID: <33ad7c21-c36c-d879-c3d7-592e8231f8a6@partner.samsung.com>
Date: Wed, 5 Dec 2018 12:45:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAJKOXPd8eErBf4a4x2bAQUnCenOsM+omJoVJ3FrakcTT6KWedg@mail.gmail.com>
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa1CMYRj1fvdim88W+yiTmR1mMJTrzEuNYRjzGT/ohxmXTBafMtpiP+XW
 TKtoK5dcV20lhHa2iFqVJZe1KVLZksh9mAxak1qXRhpt3xr9O895znmfc2ZejlTmMYHc5rjt
 oi5OE6tmfKmK+72NU3fa2MhpdlMYvnttEr6aXUrjyqs/aNzm/kjjAkcjjVMLSxn86IAWZ73/
 QuKmpissbkjpZLHpRDWBy94/pXGLLY/BPYccCGc33SLwJccrFl9ocxL4xV4zg189rBnw1zfT
 eH+1g8VpxV007nz8mpqvEipuVNBCyekSJOTqnZRwJKsbCYU3PxFCmSWDEW7nl7BC+flkof8+
 K1hbDZRw2GpBgrn4Jyv0lAUvV6z2Dd8oxm5OFHWh89b5xnw3P2S2ZvnvrLaIelQ3PBP5cMDP
 gs6iFjIT+XJK3ozgUk0fKw9uBBd/NdDy0IPg6/5c9p/lyb5KQl4UIXhx3OC1uBC0tBtoj8qf
 Xwb6dy7CgwP4SdD25+fgUyRfTkN5+TeUiTiO4UOgyrLNo1Hwi8HYVE96MMWPhyvG34N4FL8S
 0t8UM7JmJDzI+UB5rD58BFTWLfLQJK+C9g8FhIzHQaUrb7AP8C85aD9dzcipF0FqYwchY3/4
 XGv1thkL9ccPUjKWoCHd4tUngeFBlVcTBvdqnbTnLjnQpdQWKtMLoM/dT3po4P3gmWukHMEP
 jlWc8tIKSE9TyuqJYD342BtgNBSVGNkjSG0a0ss0pIxpSBnT/7tnEGVBKjFB0kaL0sw4cUeI
 pNFKCXHRIRvitWVo4M/W99d+r0K3+tbbEc8h9QgFnGAilbQmUdqltSPgSHWAwhzORioVGzW7
 dou6+ChdQqwo2VEQR6lVij3D3q5R8tGa7eIWUdwq6v5tCc4nUI+mgSq0YwYRNiW+6NzCyOtj
 L7itET5kcNj155+atWyr2lgXmKnL5YIOCbbsmKi5J8PT55435Py4PHtFirFri56ZXFOQmrwk
 vycgp/fw2+W5SUeLm++kueLnJBxzdscEkfecjojapauSJiwJXls4ZlNUyucDypdGW8rrjH1n
 /dxvptrVlBSjmT6Z1Emav91gzJevAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA03Sa0hTYRgHcN6dq9bqODVfFt1GEROaTrO9hkUfIk5XsvrQZVHDHbzkNtuZ
 ol1ndqFZTc3ElmWQ1ljWci4npkVqZppN01wUBuUgZKWVNYlK2hqB3/48z//34YGHxkR2Qkxn
 ag2cXqvKlpDheM/U0+Fl+c2UMn6glECP70tRfaWdQK56P4E83z8SqLrjBYGKbthJ9LxYg8wj
 Pgy53fco1HviE4Us5a0C5BgZItBAcxWJJs53AFTpfihAdzqGKVTr6Regt4VWEg13Pwn4npcE
 OtXaQaHTt78Q6FPfO3xNDNv4oJFg667VAfaKsR9nS8zfAHujZVTAOmxnSfbR1TqKbag5zk51
 Uqzz1RmcveC0AdZ6e5JiJxzztwp3y1L0ulwDtzBDxxtWSfbIUYJMnoxkCcuTZfJExd6VCUmS
 uNUpai47M4/Tx63eL8v4Ye0mc8yR+a02zgi6ZphAGA2Z5XDwpEtgAuG0iKkFcGx8AoQWc2DZ
 QxcVypHw95CJDJV8ALaPDmImQNORzGbYXZ8V7EQxUuj5M0kEOxjTQMBB72siBG4KoP1cJxkE
 JCODTbaDQSBk1sEKdw8WzDizGN6r+PUvRzM7Ye/oXRDqRMBnl714kIYxqdDVtTY4xpgV8FrD
 eyyUY+Abb7UglBdA1+cqrASILNO0ZRqxTCOWaeQ6wG0gisvlNekaPkHGqzR8rjZdlqbTOEDg
 WRo7fzqbgGlsextgaCCZKYTlpFJEqPL4Ak0bgDQmiRJaUyilSKhWFRzi9Lp9+txsjm8DSYHb
 SjFxdJou8Hpawz55klyBkuWKREXiCiSJEbrjC3aLmHSVgTvAcTmc/r8T0GFiI3BsO+zV+ja2
 a48czmGNG/bEyyPq4m71zZ3nxc2KAb3H3HV90XBxls+zrjlixhU4+/jKZ0cn+8cWt1c5L5bH
 bvHYCvOOFEpT0/3rMeWQYleNb9SuVj8dF4/c9V9uKar3X8q3n1769cwa67GW2B0furqfvClb
 Ui398jXVtynL5puVKcH5DJU8FtPzqr/fX9j8QgMAAA==
X-CMS-MailID: 20181205114600eucas1p25c68a55f23f8fb97d4ae2febabd1b4f1
X-Msg-Generator: CA
X-RootMTR: 20181205110625eucas1p10c7b3137fb77ae51a211c4f040c4eb6f
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181205110625eucas1p10c7b3137fb77ae51a211c4f040c4eb6f
References: <CGME20181205110625eucas1p10c7b3137fb77ae51a211c4f040c4eb6f@eucas1p1.samsung.com>
 <1544007956-28889-1-git-send-email-l.luba@partner.samsung.com>
 <1544007956-28889-6-git-send-email-l.luba@partner.samsung.com>
 <CAJKOXPd8eErBf4a4x2bAQUnCenOsM+omJoVJ3FrakcTT6KWedg@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_034614_859732_AE4E42C7 
X-CRM114-Status: GOOD (  15.78  )
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
Cc: mark.rutland@arm.com, anton@enomsg.org, len.brown@intel.com, pavel@ucw.cz,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>,
 =?UTF-8?Q?Bart=c5=82omiej_=c5=bbo=c5=82nierkiewicz?=
 <b.zolnierkie@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>,
 myungjoo.ham@samsung.com, devicetree@vger.kernel.org, keescook@chromium.org,
 linux-pm@vger.kernel.org, robh+dt@kernel.org,
 linux-arm-kernel@lists.infradead.org, tony.luck@intel.com,
 gregkh@linuxfoundation.org, rjw@rjwysocki.net, linux-kernel@vger.kernel.org,
 tjakobi@math.uni-bielefeld.de, kyungmin.park@samsung.com, kgene@kernel.org,
 ccross@android.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org



On 12/5/18 12:12 PM, Krzysztof Kozlowski wrote:
> On Wed, 5 Dec 2018 at 12:06, Lukasz Luba <l.luba@partner.samsung.com> wrote:
>>
>> Mark the state for devfreq device while entring suspend/resume process.
>>
>> Suggested-by: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
>> Suggested-by: Chanwoo Choi <cw00.choi@samsung.com>
>> Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
>> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
> 
> I already applied v2:
> https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git/commit/?h=next/dt

Thank you!

Regards,
Lukasz
> 
> Best regards,
> Krzysztof
> 
>> ---
>>   arch/arm/boot/dts/exynos4210.dtsi | 2 ++
>>   arch/arm/boot/dts/exynos4412.dtsi | 2 ++
>>   2 files changed, 4 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/exynos4210.dtsi b/arch/arm/boot/dts/exynos4210.dtsi
>> index b6091c2..4429b72 100644
>> --- a/arch/arm/boot/dts/exynos4210.dtsi
>> +++ b/arch/arm/boot/dts/exynos4210.dtsi
>> @@ -298,6 +298,7 @@
>>                          opp-400000000 {
>>                                  opp-hz = /bits/ 64 <400000000>;
>>                                  opp-microvolt = <1150000>;
>> +                               opp-suspend;
>>                          };
>>                  };
>>
>> @@ -367,6 +368,7 @@
>>                          };
>>                          opp-200000000 {
>>                                  opp-hz = /bits/ 64 <200000000>;
>> +                               opp-suspend;
>>                          };
>>                  };
>>          };
>> diff --git a/arch/arm/boot/dts/exynos4412.dtsi b/arch/arm/boot/dts/exynos4412.dtsi
>> index 51f72f0..908c0c4 100644
>> --- a/arch/arm/boot/dts/exynos4412.dtsi
>> +++ b/arch/arm/boot/dts/exynos4412.dtsi
>> @@ -432,6 +432,7 @@
>>                          opp-400000000 {
>>                                  opp-hz = /bits/ 64 <400000000>;
>>                                  opp-microvolt = <1050000>;
>> +                               opp-suspend;
>>                          };
>>                  };
>>
>> @@ -520,6 +521,7 @@
>>                          opp-200000000 {
>>                                  opp-hz = /bits/ 64 <200000000>;
>>                                  opp-microvolt = <1000000>;
>> +                               opp-suspend;
>>                          };
>>                  };
>>
>> --
>> 2.7.4
>>
> 
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
