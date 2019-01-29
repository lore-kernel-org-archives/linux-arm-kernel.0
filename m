Return-Path: <SRS0=P47x=QF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74EEBC282C7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 17:07:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4175A2086C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 17:07:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="EadEL7u2";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ox0VGu8p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4175A2086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=partner.samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:References:In-Reply-To:MIME-Version:
	Date:Message-ID:From:To:Subject:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=/xTspvXGWAl5mMCY4//0mqiJoj6v5GJXjToeq3J7xVQ=; b=EadEL7u2Owse2h
	ZqZ7lKVXVjHY+gdpxQc5RMWM4Ck1ZUXucY3bUdU4pc0xP/y3rW/mrT77P7Qqo9KVzHZmY4YjJMJ4V
	dOAo5McVX2PCGVY1jR85Tk3tGhMJ1qRsf5aoE37VfENijncyHUeQvR5VMHCmZo+/E/cM7Z+p0L25j
	ZTjsqqYyofMci0VZ+80KMTU2jyYX0Oexae2xlJox2r4/w3M6s2Bs45LYfzZBTMORuXKdudOV64bI6
	cqUUAQ9cWixVZDMbPdxKfjhjDp/2j1omEm1Mpz6Mklk+Z8wYqTCrfVuiVvuXnY6spzaXZ+FU05oqA
	02bbkDvry4KcKHNGbspA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goWqm-0003FN-0r; Tue, 29 Jan 2019 17:07:04 +0000
Received: from mailout2.w1.samsung.com ([210.118.77.12])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goWqh-0003ER-Hq
 for linux-arm-kernel@lists.infradead.org; Tue, 29 Jan 2019 17:07:01 +0000
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20190129170655euoutp02abba33fb0113373bf6c866ff8f29d67a~_YKxY2hbp0724907249euoutp02_
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 29 Jan 2019 17:06:55 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20190129170655euoutp02abba33fb0113373bf6c866ff8f29d67a~_YKxY2hbp0724907249euoutp02_
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1548781615;
 bh=uwfQPmhCNFdmrQ5L8QC0pH38Sc5WAR1dJ3Ttyjn+XPA=;
 h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
 b=ox0VGu8pyoLcyq3HZMgobo2QGUBBNTb8lqQjZKyAArBNz4w85IaKRAFl+Nd32QQ5P
 L+9DHY1NrkAhFpfspPyw2JpB1vG+BVW0u13P/oHfDQka1f4FlPClyndKAXF7RESwnI
 ej4d0n/4Yk2+qcflHIeWv7obiX3kcvdoWANT7d30=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTP id
 20190129170654eucas1p171168199fd8d4f943ced81556e6a6c77~_YKwcV87d2894628946eucas1p1b;
 Tue, 29 Jan 2019 17:06:54 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
 eusmges2new.samsung.com (EUCPMTA) with SMTP id 1D.CD.04294.D28805C5; Tue, 29
 Jan 2019 17:06:53 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20190129170653eucas1p1b1561cbfdd3488c5ec3df5232b992e0f~_YKvtp-uL2839628396eucas1p1o;
 Tue, 29 Jan 2019 17:06:53 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
 eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20190129170653eusmtrp1d668519339b9d5df85d7b8124eda421d~_YKvfGUEC1764917649eusmtrp1b;
 Tue, 29 Jan 2019 17:06:53 +0000 (GMT)
X-AuditID: cbfec7f4-835ff700000010c6-2b-5c50882d5614
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
 eusmgms1.samsung.com (EUCPMTA) with SMTP id DE.26.04284.D28805C5; Tue, 29
 Jan 2019 17:06:53 +0000 (GMT)
Received: from [106.120.51.20] (unknown [106.120.51.20]) by
 eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20190129170652eusmtip1ed35c096d806ddd6126d4ba12a04d84b~_YKvAtvhA0884208842eusmtip1h;
 Tue, 29 Jan 2019 17:06:52 +0000 (GMT)
Subject: Re: [PATCH 6/8] DT: arm: exynos: add DMC device for exynos5422
To: Krzysztof Kozlowski <krzk@kernel.org>
From: Lukasz Luba <l.luba@partner.samsung.com>
Message-ID: <0daee320-1494-172a-9500-8b60dbdda3b7@partner.samsung.com>
Date: Tue, 29 Jan 2019 18:06:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAJKOXPfHzspKWxHcf=DGf73v0sdnG=oDAa-9QLv2eRCHoC9RwQ@mail.gmail.com>
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrGKsWRmVeSWpSXmKPExsWy7djP87q6HQExBt8/mVhsnLGe1WL+kXOs
 Fv2PXzNbnD+/gd1i0+NrrBaXd81hs5hxfh+TxdLrF5ksbjeuYLNo3XuE3YHLY828NYwem1Z1
 snlsXlLv0bdlFaPH501yAaxRXDYpqTmZZalF+nYJXBkPvxxlK2iwrHh7sryB8bx8FyMnh4SA
 icSM/1PYuhi5OIQEVjBKNDS+Z4RwvjBKdL5+ygThfGaUWHDnDzNMy7mn89hAbCGB5YwSbx6l
 QBS9ZZQ42NPKCJIQFnCXuLhyOliRiICmxPW/31lBipgFOpglFrceYu9i5OBgE9CT2LGqEKSG
 V8BN4nA3xFAWAVWJRZfOsIDYogIREod73zFC1AhKnJz5BCzOKRAosaW3D8xmFhCXuPVkPhOE
 LS+x/e0cZpBdEgLH2CU2rdnGCnG1i8Tj76ehbGGJV8e3sEPYMhKnJ/ewQNjFEmc7VrFB2DUS
 7Sd3QNVYSxw+fpEV5GZmoGfW79KHCDtKLNz9HuwVCQE+iRtvBSFO4JOYtG06M0SYV6KjTQii
 WkNiS88FJghbTGL5mmnsExiVZiF5bBaSZ2YheWYWwt4FjCyrGMVTS4tz01OLjfJSy/WKE3OL
 S/PS9ZLzczcxAlPT6X/Hv+xg3PUn6RCjAAejEg8vQ3BAjBBrYllxZe4hRgkOZiURXsPf/jFC
 vCmJlVWpRfnxRaU5qcWHGKU5WJTEeasZHkQLCaQnlqRmp6YWpBbBZJk4OKUaGIs3n9YNjXkQ
 LVG5nbvVOajwrN+FZV9F33vbu08RNWaTUa98v8d8r4dKL8vONe0s0psc+6bc+Ra75vtyQTYx
 N8WFPr3bNSLy/nzzMxR69Gvjpq/+ExfOy4rUWlHw/mFYhAM7x5NXk4yb3/N5K7+Z3dBcyeud
 YRX08NyNxmUL/Db35X3e/uXeNyWW4oxEQy3mouJEAES5O8xJAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNIsWRmVeSWpSXmKPExsVy+t/xu7q6HQExBrsmsFtsnLGe1WL+kXOs
 Fv2PXzNbnD+/gd1i0+NrrBaXd81hs5hxfh+TxdLrF5ksbjeuYLNo3XuE3YHLY828NYwem1Z1
 snlsXlLv0bdlFaPH501yAaxRejZF+aUlqQoZ+cUltkrRhhZGeoaWFnpGJpZ6hsbmsVZGpkr6
 djYpqTmZZalF+nYJehkPvxxlK2iwrHh7sryB8bx8FyMnh4SAicS5p/PYuhi5OIQEljJK3Pzz
 kB0iISYxad92KFtY4s+1Lqii14wSC+7tYwZJCAu4S1xcOZ0NxBYR0JS4/vc7K0gRs0AHs8S9
 WeeZIDqWMUmcvXUeaBQHB5uAnsSOVYUgDbwCbhKHu+eBNbMIqEosunSGBcQWFYiQ+Ph0HxNE
 jaDEyZlPwOKcAoESW3r7wGxmATOJeZsfMkPY4hK3nsxngrDlJba/ncM8gVFoFpL2WUhaZiFp
 mYWkZQEjyypGkdTS4tz03GJDveLE3OLSvHS95PzcTYzAiNx27OfmHYyXNgYfYhTgYFTi4WUI
 DogRYk0sK67MPcQowcGsJMJr+Ns/Rog3JbGyKrUoP76oNCe1+BCjKdBzE5mlRJPzgckiryTe
 0NTQ3MLS0NzY3NjMQkmc97xBZZSQQHpiSWp2ampBahFMHxMHp1QDY1HW6hlP3k8W+hdVs/l2
 1/G9+pseLlWY8dQjKHbixuNNtVd8XD86BrIZfVvQPT0l3LHKRuzpp0p+Vaaoqg725RsKtu5d
 ZJN+S1m/WmRGoNFOzhOPll+YGH3+X+yVnDPJ938veDu95HCkBpOi36d2Y9cJS643JP1yV/NR
 M758jmv/2YpluY3vnZVYijMSDbWYi4oTAcB3foLeAgAA
X-CMS-MailID: 20190129170653eucas1p1b1561cbfdd3488c5ec3df5232b992e0f
X-Msg-Generator: CA
X-RootMTR: 20190128192154eucas1p2e696de47c5aab0cdb80cff32254daaf9
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190128192154eucas1p2e696de47c5aab0cdb80cff32254daaf9
References: <CGME20190128192154eucas1p2e696de47c5aab0cdb80cff32254daaf9@eucas1p2.samsung.com>
 <1548703299-15806-1-git-send-email-l.luba@partner.samsung.com>
 <1548703299-15806-7-git-send-email-l.luba@partner.samsung.com>
 <CAJKOXPfHzspKWxHcf=DGf73v0sdnG=oDAa-9QLv2eRCHoC9RwQ@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190129_090659_897431_B334F0C5 
X-CRM114-Status: GOOD (  19.38  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>,
 =?UTF-8?Q?Bart=c5=82omiej_=c5=bbo=c5=82nierkiewicz?=
 <b.zolnierkie@samsung.com>, linux-kernel@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>, myungjoo.ham@samsung.com,
 Kukjin Kim <kgene@kernel.org>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Krzysztof,

On 1/29/19 4:13 PM, Krzysztof Kozlowski wrote:
> On Mon, 28 Jan 2019 at 20:21, Lukasz Luba <l.luba@partner.samsung.com> wrote:
>>
>> Add description of Dynamic Memory Controller and PPMU counters.
>> They are used by exynos5-dmc driver.
>>
>> CC: Rob Herring <robh+dt@kernel.org>
>> CC: Mark Rutland <mark.rutland@arm.com>
>> CC: Kukjin Kim <kgene@kernel.org>
>> CC: Krzysztof Kozlowski <krzk@kernel.org>
>> CC: devicetree@vger.kernel.org
>> CC: linux-arm-kernel@lists.infradead.org
>> CC: linux-samsung-soc@vger.kernel.org
>> CC: linux-kernel@vger.kernel.org
>> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
>> ---
>>   arch/arm/boot/dts/exynos5420.dtsi             | 81 +++++++++++++++++++++++++++
>>   arch/arm/boot/dts/exynos5422-odroid-core.dtsi | 22 ++++++++
>>   2 files changed, 103 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
>> index aaff158..6880d13 100644
>> --- a/arch/arm/boot/dts/exynos5420.dtsi
>> +++ b/arch/arm/boot/dts/exynos5420.dtsi
>> @@ -1337,6 +1337,87 @@
>>                                  opp-hz = /bits/ 64 <400000000>;
>>                          };
>>                  };
>> +
>> +               ppmu_dmc0_0: ppmu_dmc0_0@10d00000 {
>> +                       compatible = "samsung,exynos-ppmu";
>> +                       reg = <0x10d00000 0x2000>;
>> +                       clocks = <&clock CLK_PCLK_PPMU_DREX0_0>;
>> +                       clock-names = "ppmu";
>> +                       events {
>> +                               ppmu_event_dmc0_0: ppmu-event3-dmc0_0 {
>> +                                       event-name = "ppmu-event3-dmc0_0";
>> +                               };
>> +                       };
>> +               };
>> +
>> +
> 
> No need for double line.
Agree
> 
>> +               ppmu_dmc0_1: ppmu_dmc0_1@10d10000 {
>> +                       compatible = "samsung,exynos-ppmu";
>> +                       reg = <0x10d10000 0x2000>;
>> +                       clocks = <&clock CLK_PCLK_PPMU_DREX0_1>;
>> +                       clock-names = "ppmu";
>> +                       events {
>> +                               ppmu_event_dmc0_1: ppmu-event3-dmc0_1 {
>> +                                       event-name = "ppmu-event3-dmc0_1";
>> +                               };
>> +                       };
>> +               };
>> +
>> +               ppmu_dmc1_0: ppmu_dmc1_0@10d10000 {
>> +                       compatible = "samsung,exynos-ppmu";
>> +                       reg = <0x10d60000 0x2000>;
>> +                       clocks = <&clock CLK_PCLK_PPMU_DREX1_0>;
>> +                       clock-names = "ppmu";
>> +                       events {
>> +                               ppmu_event_dmc1_0: ppmu-event3-dmc1_0 {
>> +                                       event-name = "ppmu-event3-dmc1_0";
>> +                               };
>> +                       };
>> +               };
>> +
>> +               ppmu_dmc1_1: ppmu_dmc1_1@10d70000 {
> 
> 1. Generic node name, e.g. "ppmu".
> 2. Please put all ppmu nodes after nocp nodes to group everything logically.
OK
> 
>> +                       compatible = "samsung,exynos-ppmu";
>> +                       reg = <0x10d70000 0x2000>;
>> +                       clocks = <&clock CLK_PCLK_PPMU_DREX1_1>;
>> +                       clock-names = "ppmu";
>> +                       events {
>> +                               ppmu_event_dmc1_1: ppmu-event3-dmc1_1 {
>> +                                       event-name = "ppmu-event3-dmc1_1";
>> +                               };
>> +                       };
>> +               };
>> +
>> +               dmc: dmc@10c20000 {
> 
> 1. Node name: memory-controller.
> 2. Put it before nocp nodes.
OK
> 
>> +                       compatible = "samsung,exynos5422-dmc";
>> +                       reg = <0x10c20000 0x10000>, <0x10c30000 0x10000>,
>> +                               <0x10030000 0x1000>, <0x10000000 0x1000>;
>> +                       clocks =        <&clock CLK_FOUT_SPLL>,
> 
> Weird indentation.
> 
>> +                                       <&clock CLK_MOUT_SCLK_SPLL>,
>> +                                       <&clock CLK_FF_DOUT_SPLL2>,
> 
> Indent all continued lines with first entry (like in other places in this file)
> 
>> +                                       <&clock CLK_FOUT_BPLL>,
>> +                                       <&clock CLK_MOUT_BPLL>,
>> +                                       <&clock CLK_SCLK_BPLL>,
>> +                                       <&clock CLK_MOUT_MX_MSPLL_CCORE>,
>> +                                       <&clock CLK_MOUT_MX_MSPLL_CCORE_PHY>,
>> +                                       <&clock CLK_MOUT_MCLK_CDREX>,
>> +                                       <&clock CLK_DOUT_CLK2X_PHY0>,
>> +                                       <&clock CLK_CLKM_PHY0>,
>> +                                       <&clock CLK_CLKM_PHY1>
>> +                                       ;
> 
> Join the trailing semicolon with previous lines.
OK
> 
>> +                       clock-names =   "fout_spll",
>> +                                       "mout_sclk_spll",
> 
> Indent all continued lines with first entry (like in other places in this file).
OK and all the entries will be compacted where possible for 80lines.
> 
>> +                                       "ff_dout_spll2",
>> +                                       "fout_bpll",
>> +                                       "mout_bpll",
>> +                                       "sclk_bpll",
>> +                                       "mout_mx_mspll_ccore",
>> +                                       "mout_mx_mspll_ccore_phy",
>> +                                       "mout_mclk_cdrex",
>> +                                       "dout_clk2x_phy0",
>> +                                       "clkm_phy0",
>> +                                       "clkm_phy1"
>> +                                       ;
> 
> Join the trailing semicolon with previous lines.
>> +               };
>>          };
>>
>>          thermal-zones {
>> diff --git a/arch/arm/boot/dts/exynos5422-odroid-core.dtsi b/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
>> index bf09eab..54ee8b2 100644
>> --- a/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
>> +++ b/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
>> @@ -119,6 +119,28 @@
>>          status = "okay";
>>   };
>>
>> +&ppmu_dmc0_0 {
>> +       status = "okay";
>> +};
>> +
>> +&ppmu_dmc0_1 {
>> +       status = "okay";
>> +};
>> +
>> +&ppmu_dmc1_0 {
>> +       status = "okay";
>> +};
>> +
>> +&ppmu_dmc1_1 {
>> +       status = "okay";
>> +};
> 
> Put the new entries respecting alphabetical order (order of label name).
OK
> 
>> +
>> +&dmc {
> 
> The same.

Thank you for review, in v2 it will be fixed.

Regards,
Lukasz
> 
> Best regards,
> Krzysztof
> 
>> +       devfreq-events = <&ppmu_dmc0_0>, <&ppmu_dmc0_1>,
>> +                       <&ppmu_dmc1_0>, <&ppmu_dmc1_1>;
>> +       status = "okay";
>> +};
>> +
>>   &cpu0 {
>>          cpu-supply = <&buck6_reg>;
>>   };
>> --
>> 2.7.4
>>
> 
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
