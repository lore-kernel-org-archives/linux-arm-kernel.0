Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40EDAC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 08:26:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E664C214C1
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 08:26:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rD8aQ+Q2";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="KW+mrb3g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E664C214C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:References:In-Reply-To:MIME-Version:
	Date:Message-ID:From:To:Subject:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=mqj//AXSBAPKnG1FWr1NpsMFLzQmbRVhJD6KC2/q5jc=; b=rD8aQ+Q2OBLtc/
	AU119erYLP5TPM9agATFGVeWecrN5yXMvAbb9RIsnZWStHaQbWhIkGZ/36un9HMGap9ci/+JLZsq+
	viTKnGDVB9/DAkyiwaFEUpkGQz91RJQUwjbs2YviJy01N6j+zjJN7MR+zC/+CpznPEimvRkvkekSW
	mwpc9SKwuPe2/TR6qb6ITIAFs3W4JLoFuOfLfI8l6+Q65BMP6CkVHes4PLw/eINE3N5thyHIv84Sn
	xFaZD0kFz1kuXJ08OdLoaQDYTqEsK0AH23HMY3eigUZB9eV+shHvfhths5V03VPHDO8CsSjimBicA
	tmSi0jqclP1n/WW7CQKA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUoyx-00035i-RU; Thu, 06 Dec 2018 08:26:03 +0000
Received: from mailout2.w1.samsung.com ([210.118.77.12])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUoyu-00034u-Nk
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 08:26:02 +0000
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20181206082542euoutp029966425532822b3a84696d32e5d2e1f0~tsOSGcbC51640016400euoutp02A
 for <linux-arm-kernel@lists.infradead.org>;
 Thu,  6 Dec 2018 08:25:42 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20181206082542euoutp029966425532822b3a84696d32e5d2e1f0~tsOSGcbC51640016400euoutp02A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1544084742;
 bh=V+r4rGIlh+XUZ69DBIzNr94/0XrHVJ37pEjAeGMjYnI=;
 h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
 b=KW+mrb3geF6Zu0RmqTefqNNvFCZndDSgohAhQSmTGDhcvPn5vnxp5MJgF3YRaY41N
 3WJQZsAmCCbtSMRvPtnDfLLRq0ISUaH53/BCn6q30xsUtNRLqkjqRVwHEsS1XiQrC/
 30cyZE0wBqP9eBvJ+yKj+ZDRH0gDpoc6q0WKggJs=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTP id
 20181206082541eucas1p23b4cffe572620802fbf9d17d0b39d5b0~tsORSF86g1664416644eucas1p2e;
 Thu,  6 Dec 2018 08:25:41 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
 eusmges3new.samsung.com (EUCPMTA) with SMTP id DC.2A.04806.50DD80C5; Thu,  6
 Dec 2018 08:25:41 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20181206082541eucas1p29374bebfefa245294dedb873c81cb06c~tsOQagQ8M0475504755eucas1p2f;
 Thu,  6 Dec 2018 08:25:41 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
 eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20181206082540eusmtrp25cde4ef1836abec12fd661c79091e86a~tsOQLn_h-1535715357eusmtrp2W;
 Thu,  6 Dec 2018 08:25:40 +0000 (GMT)
X-AuditID: cbfec7f5-34dff700000012c6-4c-5c08dd05176b
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
 eusmgms1.samsung.com (EUCPMTA) with SMTP id 0B.14.04284.40DD80C5; Thu,  6
 Dec 2018 08:25:40 +0000 (GMT)
Received: from [106.116.147.30] (unknown [106.116.147.30]) by
 eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20181206082540eusmtip1a75b5e034cb79678318394a9230c45ef~tsOPsF0uI1593015930eusmtip1D;
 Thu,  6 Dec 2018 08:25:40 +0000 (GMT)
Subject: Re: [PATCH] ARM: dts: exynos: Add proper regulator states for
 suspend-to-mem for odroid-u3
To: Anand Moon <linux.amoon@gmail.com>, Krzysztof Kozlowski <krzk@kernel.org>
From: Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <ee0d71cd-a3e0-fbb0-3af8-0ecca1d53ec0@samsung.com>
Date: Thu, 6 Dec 2018 09:25:39 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.2
MIME-Version: 1.0
In-Reply-To: <CANAwSgSSOmTbqS4WUYZHXdB8XL5fjoiGbrh3unxufQ0gZXBPkQ@mail.gmail.com>
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA01Se0hTcRj1t7u7ex1NrlPzw0RjSJSQZgXdKKRCaJRkRWDpQJdeVHLTNl1Z
 QtJ6mIiZZdoaabFwLHV6860JPnKVoqlUvltpWImJWZpoltvV8r9zvtc5Bz4SEzfiHmScMolR
 KeXxEoGQX9U237kVHyZl2/pZH7o834zTBa2dOH1zdAKju7rKCJodfYvTvXV6AZ3f1cijS8sH
 CPrxu24effVZK7FPKC1+UIyktbphQsqabgikTw2XpFkVJiSdYb2OCsKEe6OZ+DgNo/IPjBTG
 jrAfBIklxHlLtZ5IQ5/wDORIArUTOqZnl7GQFFNGBHkNZh5HfiCYMk+vkBkEM9ocwepK0ZJ2
 pVGEYOmbieDIFIJbudrlKZJ0oRiwThy0LbhSIZBZ3mjXwKg+HljZFzxbQ0AFQMZkhv2qiAqE
 j3VthA3zKR+of1VP2O64UTKoG0/lRpzh5b0xvg07Usdg3qi1Z8Aob6ie1GMcdoeBsQK7OaB6
 CPhiLORxroMge+gNxmEX+GqpIDjsCX9qVxe0CK7n6wiOZCKo1NesZN4DLZZu3OYIo7aAuc6f
 K++HnP479sBAOUHfpDNnwglyqvIwriyC9GtibnoT6Cyl/2SbXvdg2UiiWxNNtyaObk0c3X/d
 QsQ3IXcmWa2IYdQ7lMw5P7VcoU5WxvhFJShYtPxV7UuWnzWocfF0M6JIJFkn+mwlZGJcrlGn
 KJoRkJjEVeTgR8rEomh5ygVGlRChSo5n1M1oA8mXuIsuOljDxVSMPIk5wzCJjGq1yyMdPdJQ
 //uCYANvd+aBSv8jAfLfhKdgcdAwO9LUwic3ptz3WhgqUYwGpZ58GO2clfFkOxnZ3uomOzun
 9d01MaoZDj01oPEODj9kGB961OCmH1xQKmeJwydCDGTY8az1NXcH8Y4rz8tzL08kSoRGNpSt
 72uN2mz8HjEfklmm7f01dzvdQcJXx8oDfDGVWv4X5wjz4lEDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrAIsWRmVeSWpSXmKPExsVy+t/xu7osdzliDHp3aVpsnLGe1WL+kXOs
 Fv2PXzNbnD+/gd1i0+NrrBaXd81hs5hxfh+TxbqNt9gtll6/yGTRuvcIuwOXx5p5axg9ds66
 y+6xaVUnm8fmJfUefVtWMXp83iQXwBalZ1OUX1qSqpCRX1xiqxRtaGGkZ2hpoWdkYqlnaGwe
 a2VkqqRvZ5OSmpNZllqkb5egl3Fv00O2grXsFce3z2FvYHzK2sXIySEhYCKx/F8zUxcjF4eQ
 wFJGiTvLZrJDJGQkTk5rgCoSlvhzrYsNougto8Spm6uYuxg5OIQFUiUevHYHqRER8JX433CL
 GaSGWeAOk8SPe+vZQBJCArOZJO6cLwGx2QQMJbredoHFeQXsJB7tOga2jEVARWL3qd1gtqhA
 jMSUy69ZIWoEJU7OfMICYnMKBEr8XNEMFmcWUJf4M+8SM4QtL7H97RwoW1zi1pP5TBMYhWYh
 aZ+FpGUWkpZZSFoWMLKsYhRJLS3OTc8tNtQrTswtLs1L10vOz93ECIzNbcd+bt7BeGlj8CFG
 AQ5GJR7eFw/YY4RYE8uKK3MPMUpwMCuJ8DLoccQI8aYkVlalFuXHF5XmpBYfYjQFem4is5Ro
 cj4wbeSVxBuaGppbWBqaG5sbm1koifOeN6iMEhJITyxJzU5NLUgtgulj4uCUamCMZt0wa8+p
 LIfNpx9FOHIaVj/+x/7x4QWr6KgO952vmziXT2e8aTgtQtjh9ub7fSyPdqV0Rhzml+TalnZw
 9/tr4W9eH9Ff8rTetyNA3mY7g17aS+2NG1l9SuV1GVke7Yk2aGRNzOdpUViygv1k8Ncmxr3/
 pYQb/V7yKNeWHIpwDL/4yiL+kIcSS3FGoqEWc1FxIgBBlUi54wIAAA==
X-CMS-MailID: 20181206082541eucas1p29374bebfefa245294dedb873c81cb06c
X-Msg-Generator: CA
X-RootMTR: 20181205161223epcas2p24aca718c0d68056140f8430ee8219356
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181205161223epcas2p24aca718c0d68056140f8430ee8219356
References: <20181204194025.2719-1-linux.amoon@gmail.com>
 <CAJKOXPcT-x0JWVw2CaxHzSthxbp3sDRcsa4Nc5gHYqUy98b_yw@mail.gmail.com>
 <CGME20181205161223epcas2p24aca718c0d68056140f8430ee8219356@epcas2p2.samsung.com>
 <CANAwSgSSOmTbqS4WUYZHXdB8XL5fjoiGbrh3unxufQ0gZXBPkQ@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_002600_909292_D89B0AB0 
X-CRM114-Status: GOOD (  16.08  )
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 devicetree <devicetree@vger.kernel.org>, linux-samsung-soc@vger.kernel.org,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 Linux Kernel <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Kukjin Kim <kgene@kernel.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi All,

On 2018-12-05 17:11, Anand Moon wrote:
> Hi Krzysztof,
>
> Thanks for your review.
> .
> On Wed, 5 Dec 2018 at 19:36, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>> On Tue, 4 Dec 2018 at 20:40, Anand Moon <linux.amoon@gmail.com> wrote:
>>> Add suspend-to-mem node to regulator core to be enabled or disabled
>>> during system suspend and also support changing the regulator operating
>>> mode during runtime and when the system enter sleep mode.
>>>
>>> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
>>> ---
>>> Tested on Odroid U3+


>>> ...


> Well I have tested this patch as following
> with only one issue, before enable suspend number of On-line cpu is 4
> after resume number of On-line cpu is 1.

This seems to be a regression in v4.20-rc1, not related to dts changes
at all. I'm investigating this now...

> ...

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
