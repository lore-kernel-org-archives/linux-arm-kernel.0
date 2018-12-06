Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD077C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 09:19:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D5D120892
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 09:19:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dNUgtbi6";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="t+lR5X94"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D5D120892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:References:In-Reply-To:MIME-Version:
	Date:Message-ID:To:From:Subject:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=bAZHfNuYYWwnoerEmTXDFtxohqBdwS3ODfoJT41Bzn0=; b=dNUgtbi6h+x9Wd
	LK/HNwUG3pYzR/s7fzY6L2qS9E8gD+CkQweldg43q4KCEs/geNgHop0Wx+XQUw/srwwM1iiEKhMPU
	QvVYwCPhBt+SMVyuyoYJHRz1PgjZ2qAxXkbL7lOXV8iJPtanp7tRhwGbwOIAodmvPHmqn1RygRicG
	yY50VEdxF+5BhaMgyfYuiOgtOIZX0GfSAVqJHDA2eXfXyCULvi64sJUml2I3QT6imI0M7Wfeffv5H
	n3juUxzyTw24473sa3uCHXI5YFFAscP1hbdOrBHTg3Q7RGp657c6TZ2nNP5hAOPwM+J3Bb0c+dGKj
	XH4ifB8wtIFJAdx0S1pw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUpoB-0004d3-TU; Thu, 06 Dec 2018 09:18:59 +0000
Received: from mailout2.w1.samsung.com ([210.118.77.12])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUpo8-0004cK-Op
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 09:18:58 +0000
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20181206091844euoutp0241c33165365a0d5d8e8f8b1fb307cd04~ts8ljEBie1357313573euoutp02Z
 for <linux-arm-kernel@lists.infradead.org>;
 Thu,  6 Dec 2018 09:18:44 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20181206091844euoutp0241c33165365a0d5d8e8f8b1fb307cd04~ts8ljEBie1357313573euoutp02Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1544087924;
 bh=fU4NDZZEhnTSS/xY31qXea/m2kFgUHwWN6jXhGLT0GU=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
 b=t+lR5X94Yv3YEs0susVz7MY5DP8gGg6KzAnPFp6j7MAFbvBkoQqx4XeWoqp861lo+
 o++NO+43OvErn2LLS+yGF3iIK80pUGdwllCJFlY/S3TTxW3fcSSppLQRgA3Lsk/nF0
 fM3GMqgujVJXylnxr+y+RxdsHUD1m5mWZk+a9Hs8=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTP id
 20181206091843eucas1p1a082c8351d0ddf98733ab04de5cf1f00~ts8kwHwU41705917059eucas1p1P;
 Thu,  6 Dec 2018 09:18:43 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
 eusmges3new.samsung.com (EUCPMTA) with SMTP id 94.62.04806.379E80C5; Thu,  6
 Dec 2018 09:18:43 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20181206091842eucas1p1c5410562166cbd4b8cd5bd07dd20de1c~ts8j3yFhO1308513085eucas1p1p;
 Thu,  6 Dec 2018 09:18:42 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
 eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20181206091842eusmtrp2cbb21c3c2fdd8ad271c1f2426817496b~ts8jjwRSh2990529905eusmtrp2S;
 Thu,  6 Dec 2018 09:18:42 +0000 (GMT)
X-AuditID: cbfec7f5-79db79c0000012c6-d4-5c08e973bdfd
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
 eusmgms1.samsung.com (EUCPMTA) with SMTP id DB.BB.04284.279E80C5; Thu,  6
 Dec 2018 09:18:42 +0000 (GMT)
Received: from [106.116.147.30] (unknown [106.116.147.30]) by
 eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20181206091841eusmtip1f6a2880196fb7014bee0d52e7b3e10e9~ts8i8OSbj3082130821eusmtip1G;
 Thu,  6 Dec 2018 09:18:41 +0000 (GMT)
Subject: Re: [PATCH] ARM: dts: exynos: Add proper regulator states for
 suspend-to-mem for odroid-u3
From: Marek Szyprowski <m.szyprowski@samsung.com>
To: Anand Moon <linux.amoon@gmail.com>, Krzysztof Kozlowski <krzk@kernel.org>
Message-ID: <bb894ff5-0fe7-7532-3b73-018038cad855@samsung.com>
Date: Thu, 6 Dec 2018 10:18:41 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.2
MIME-Version: 1.0
In-Reply-To: <ee0d71cd-a3e0-fbb0-3af8-0ecca1d53ec0@samsung.com>
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA02SfyyUcRzHfe/5eTenx1E+U6ldsiF01ezZEtka19bG36XVxbNj3LF7/Ihs
 Lvqhm0mm4WZppdUukUtCXEvmSvk9R7a2W5RiisT6YeTxpPz3+nw+78+P9/ahMcVTwptO0qdz
 Br0mRUnK8Kaun71B/Gc6bm9lkx/bUFFPsNWdvQR7dXwaY/v6HlKsddxBsEOtVSRb0WeTsHUN
 YxR7Z2RAwl5s76QOy9S1N2qRusX8jlJbLVdI9aOaPHVxowWp560+seRxWVgCl5KUyRlCwk/L
 Es8vTpBpbdKzz7p7cCMapkxISgNzAO5/yScEVjD3EJR/OCTydwQlSwEmJFvleQQjjhJivaF7
 tocUC3cRVLZMUWLwFYHDuCwxIZr2YDhwTkcLDSSjAtOMiRTYk4mBogYbIegxZlQCTutLiVCQ
 M+HwoHZ4jXHGF5wNtzBhzmYmDlonc0WJO7yqnMAFljIRYJz/vTYTY3bAk5kqTGQvGJuoloiH
 DlIw23pM5CPQO7SIi+wBU/bGv+63wUqLoJetcgGCyxVmSgyKEDyuaiZF1UF4YR8ghIMwxh/q
 W0PEdCSUvi0jhTQwbjA64y7e4AalTeWYmJZD4SWFqPYDs73u39rn/YNYCVKaNzgzb3Bj3uDG
 /H/vTYRbkBeXweu0HL9fz2UF8xodn6HXBsen6qxo9aVeL9sXmpFt6UwHYmikdJV/clJxCkKT
 yWfrOhDQmNJT7hJMxynkCZrsHM6QesqQkcLxHWgrjSu95OdcnCcUjFaTziVzXBpnWK9KaKm3
 ESHf+rBmNw/pj0LHYJZrQdXOYXbyQl5Uv03TYf54/Y18X9kenSomIr8r1qeWCsy5bdC+V/bE
 9HZFBw1H+da16WssXnxooCqlP2/BvmkB3x3ars8NsVScJOMji7e4FoeoSnb9uraQVBjt+q1y
 bmm7di5oJdd/IqrYEa3THzXMJStxPlGjCsAMvOYP/Qc21E4DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrIIsWRmVeSWpSXmKPExsVy+t/xu7pFLzliDC7PULHYOGM9q8X8I+dY
 Lfofv2a2OH9+A7vFpsfXWC0u75rDZjHj/D4mi3Ubb7FbLL1+kcmide8RdgcujzXz1jB67Jx1
 l91j06pONo/NS+o9+rasYvT4vEkugC1Kz6Yov7QkVSEjv7jEVina0MJIz9DSQs/IxFLP0Ng8
 1srIVEnfziYlNSezLLVI3y5BL6Px2xO2gj2cFftPnWVpYLzK3sXIySEhYCJx6sNZti5GLg4h
 gaWMEkefNLBCJGQkTk6DsYUl/lzrgip6yyhx6+U1xi5GDg5hgVSJB6/dQWrYBAwlut6C1HBy
 iAj4SvxvuMUMUs8scIdJ4se99VDNF5gklk7pYQSp4hWwk1i75ioTiM0ioCLxYOMiZhBbVCBG
 Ysrl16wQNYISJ2c+YQGxOQXsJRo+/wbbwCygLvFn3iVmCFteYvvbOVC2uMStJ/OZJjAKzULS
 PgtJyywkLbOQtCxgZFnFKJJaWpybnltsqFecmFtcmpeul5yfu4kRGJ3bjv3cvIPx0sbgQ4wC
 HIxKPLwvHrDHCLEmlhVX5h5ilOBgVhLhZdDjiBHiTUmsrEotyo8vKs1JLT7EaAr03ERmKdHk
 fGDiyCuJNzQ1NLewNDQ3Njc2s1AS5z1vUBklJJCeWJKanZpakFoE08fEwSnVwDh37saFMTN3
 HHkf9ySgrGL9vbV3dY2y2A+4iH1ZmJtzc9ekng/ZlhITP9y+n75X8vEOvfz8Y0dv7fzu9/VS
 Yl13gzRv5ravBy6vYJULeXyDxVKZT+Xoio9vPRLvham2vvk3z/77YX5BiZnHtx//+81sy6+H
 jw4f7F3IY5hisuxtZX6Yd0L1fo0eJZbijERDLeai4kQALzRH9OQCAAA=
X-CMS-MailID: 20181206091842eucas1p1c5410562166cbd4b8cd5bd07dd20de1c
X-Msg-Generator: CA
X-RootMTR: 20181205161223epcas2p24aca718c0d68056140f8430ee8219356
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181205161223epcas2p24aca718c0d68056140f8430ee8219356
References: <20181204194025.2719-1-linux.amoon@gmail.com>
 <CAJKOXPcT-x0JWVw2CaxHzSthxbp3sDRcsa4Nc5gHYqUy98b_yw@mail.gmail.com>
 <CGME20181205161223epcas2p24aca718c0d68056140f8430ee8219356@epcas2p2.samsung.com>
 <CANAwSgSSOmTbqS4WUYZHXdB8XL5fjoiGbrh3unxufQ0gZXBPkQ@mail.gmail.com>
 <ee0d71cd-a3e0-fbb0-3af8-0ecca1d53ec0@samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_011856_940874_78543CB9 
X-CRM114-Status: GOOD (  15.52  )
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

On 2018-12-06 09:25, Marek Szyprowski wrote:
> On 2018-12-05 17:11, Anand Moon wrote:
>> On Wed, 5 Dec 2018 at 19:36, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>>> On Tue, 4 Dec 2018 at 20:40, Anand Moon <linux.amoon@gmail.com> wrote:
>>>> Add suspend-to-mem node to regulator core to be enabled or disabled
>>>> during system suspend and also support changing the regulator operating
>>>> mode during runtime and when the system enter sleep mode.
>>>>
>>>> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
>>>> ---
>>>> Tested on Odroid U3+
>>>>
>>>> ...
>> Well I have tested this patch as following
>> with only one issue, before enable suspend number of On-line cpu is 4
>> after resume number of On-line cpu is 1.
> This seems to be a regression in v4.20-rc1, not related to dts changes
> at all. I'm investigating this now...


Okay, I mixed kernel versions a bit. To be precise, this regression is
between v4.20-rc2 and v4.20-rc3. Bisecting pointed commit 383fb3ee8024
("ARM: spectre-v2: per-CPU vtables to work around big.Little systems").
I will post a bug report about the regression.


Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
