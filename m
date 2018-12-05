Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BEA2C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 11:08:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50F782081B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 11:08:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="m9OBnntB";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="icpBkkbu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50F782081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=partner.samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=iR7wISc9n3vILBNSle9vdEunG3zKHD447PgcKUa5+do=; b=m9OBnntBzTRjymI7QQUqcOe990
	qWCtZV9d6DDFRZKpQE6oIDwtW+h8fqYxXyPW9GUczQobsoAXh1ARe/j5z9APRi9u7sz9ayUtJTKxs
	D0FH8hQpwcp2pkcnxqW8kqsVl8TAoFxsCl4Fehk16+bdq6vZmKS02J38P9Dc7yKkkyNPZqrw/o9sc
	uUqb8EpYaCmj4dfi4QLpsVgeMB5y8tKRirNQQ+pAX8/JgeUffhCuuN7HonA2EB1HnjOkNdyJ+UjXJ
	00AG5uViSrgqzFvh4jWpkMUXdHzocSWv7EWZwGnvJmQFqJdBpoas3nM3oFKrCXf3gqR4BEXJpD8zI
	gHIhZvUA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUV2E-00018I-Qg; Wed, 05 Dec 2018 11:08:06 +0000
Received: from mailout2.w1.samsung.com ([210.118.77.12])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUV0p-0008Bq-Aq
 for linux-arm-kernel@lists.infradead.org; Wed, 05 Dec 2018 11:06:43 +0000
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20181205110627euoutp023f656a3cf09ace75765e689e22cd770f~taxVyZFug0210202102euoutp02b
 for <linux-arm-kernel@lists.infradead.org>;
 Wed,  5 Dec 2018 11:06:27 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20181205110627euoutp023f656a3cf09ace75765e689e22cd770f~taxVyZFug0210202102euoutp02b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1544007987;
 bh=yHjclQEFD6YZMbzKTlG0nEejpZttIshoVnBmSaCyCpg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=icpBkkbubKm4TJhBdTOuLvJ+N+TLIYo8MZrLUTyq9nP4PNucGCgbHG0QLDhEOt2Qw
 tYksgS1KobVT90ysC66DNz6qQncqdajcQq9BYDWzwqqrtYqx03kZ9q2PM5QWonZq99
 Bbd6MKi4fyNJ93szGUgUmaegKgDukQKHsmKfOYCk=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTP id
 20181205110626eucas1p12f47ff506e871191f7e95525ce7223d4~taxU7tiPy1455014550eucas1p1L;
 Wed,  5 Dec 2018 11:06:26 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
 eusmges2new.samsung.com (EUCPMTA) with SMTP id 95.2A.04294.131B70C5; Wed,  5
 Dec 2018 11:06:25 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20181205110625eucas1p10c7b3137fb77ae51a211c4f040c4eb6f~taxUHzZjp1456514565eucas1p1J;
 Wed,  5 Dec 2018 11:06:25 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
 eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20181205110625eusmtrp208d0f5609fa2e5dc3de577ee1b203e92~taxT3Lheq2749027490eusmtrp2l;
 Wed,  5 Dec 2018 11:06:25 +0000 (GMT)
X-AuditID: cbfec7f4-835ff700000010c6-33-5c07b131f44b
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
 eusmgms2.samsung.com (EUCPMTA) with SMTP id 49.72.04128.031B70C5; Wed,  5
 Dec 2018 11:06:24 +0000 (GMT)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
 eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20181205110624eusmtip14ac0690a7b5fafe9097feabf419f624b~taxS63r1P2535525355eusmtip1V;
 Wed,  5 Dec 2018 11:06:24 +0000 (GMT)
From: Lukasz Luba <l.luba@partner.samsung.com>
To: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org
Subject: [PATCH v3 5/5] arm: dts: exynos4: opp-suspend in DMC and leftbus
Date: Wed,  5 Dec 2018 12:05:56 +0100
Message-Id: <1544007956-28889-6-git-send-email-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1544007956-28889-1-git-send-email-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WSbUhTYRTHe3Z3X1xNbjPrkFI0CDNQ0/zwQBpFfrgZUVGfSqhVN62c2a6z
 N6OV5GtpSG+omWDhmlPbUjNNUzOtTOeyfCsrsJBcRepFEYbm9a769jv/8z/n/xx4GEIzSS5n
 jiYk8YYEXbyWUilr2qYdQaE2OmZd/WQ4bq4OxLbblSR+bJskcZ84QuK7rV0kTi2ppPCbbD3O
 HXYR2OF4SOPOSz9oPGjyx/nXGxTYPtxL4p66QgpPXG1F+LajUYHLW4dofL/PqcAfLpopPPT6
 xdyOjrckvtzQSuO0st8k/tH9SbkJuJr6GpKzFlkRV2ByKrlrueOIK3n6XcHZLZkU9+yOleYe
 3bvAzbTRXPOvpwqu6n26ksupsiDOXDZFcxP2FTu996oiDvPxR5N5Q8jGA6q4rm92MvHSwtMD
 UyO0CfUxWciLATYcCsQCMgupGA1rRvD9wQdCLkQEtnGrp5hAcKt8eM7GzI9kpW2W9VIEs6n1
 9L+JvOkpJJkoNhhqLSeliCVsCYK3tYGSh2BfElA3lqeQGj7sVsjKF0mJlexq6PhdTEmsZqPB
 4Sqk5fetgIGuTEJiL3YbZM9WUNIiYB8wMF3sQrIpCh6WFpIy+8Boe5Vn2B9mn9xVyCxAZ4aF
 kjkF0l/Vejwb4Hm7c/4ygg2EyroQWd4MbnGGkA/2hv6fiyWZmMO8mlseWQ0ZaRrZvQaqrnR7
 gpZCqfWmZzkHOT3l86xhixCITYHX0Mr8/1nFCFnQMt4o6GN5ISyBPxUs6PSCMSE2+NAJvR3N
 /caOmXaxFtW5D7YglkHaRWq4TsVoSF2ycEbfgoAhtEvU5gg6RqM+rDtzljec2G8wxvNCC/Jj
 lNpl6nMLvuzTsLG6JP44zyfyhr9dBeO13ISM5vXGr66+T4t8U/tvqCZCPoedfJcd3Zu/s2fL
 r7zuxo/Puga2ZVw8G7W9uiLZe2nZdL14nj03ZJh64j06OhhGCnuKQ6ojAkwFyb2r3FFu2m3b
 PRY5FtqSFNl4ZMfAoSbCJTqPUV+czVvHNzFpubO7goxFvk0BXrt3+N0bsVWmBGmVQpwudC1h
 EHR/AAgrDuyJAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrFIsWRmVeSWpSXmKPExsVy+t/xu7oGG9ljDBautLQ4uFXTYuOM9awW
 2zd+Y7W4/uU5q8X8I+dYLZoXr2ezONOda9H/+DWzxfnzG9gtzja9Ybe41SBjMWvKXiaLTY+v
 sVpc3jWHzeJz7xFGixnn9zFZrD1yl91i6fWLTBa3G1ewWdw9dRRoxulLrBate4+wW7St/sBq
 8ebCPRYHCY9tu7exeqyZt4bRY3bDRRaPCf2fGD0W73nJ5LFpVSebx/65a9g9Ni+p9/h3jN3j
 4Ls9TB5brrazePRtWcXosWL1d3aPz5vkAvii9GyK8ktLUhUy8otLbJWiDS2M9AwtLfSMTCz1
 DI3NY62MTJX07WxSUnMyy1KL9O0S9DLOPd3EWtDEXXHz+3P2BsbrHF2MHBwSAiYSXW2OXYxc
 HEICSxklvl2dy9jFyAkUF5OYtG87O4QtLPHnWhcbRNEnRom/85tYQJrZBPQkdqwqBImLCCxn
 lLj/czY7iMMs8IBZouP5JlaQbmEBT4muWV/AbBYBVYnTHxawgdi8Al4S51/PgdogJ3HzXCcz
 iM0p4C3R/X8dWI0QUM3U/uVMExj5FjAyrGIUSS0tzk3PLTbSK07MLS7NS9dLzs/dxAiM123H
 fm7Zwdj1LvgQowAHoxIPr8QUthgh1sSy4srcQ4wSHMxKIrwrbNhjhHhTEiurUovy44tKc1KL
 DzGaAh01kVlKNDkfmErySuINTQ3NLSwNzY3Njc0slMR5zxtURgkJpCeWpGanphakFsH0MXFw
 SjUwbtwSuK249MfnR/ckU76LMm+dsEr9+ha3NVm37Le3f/cVbHAqa928ONvjsF3TKwWrN1+d
 xXgbrDsmc98ufWTGGObzqH/TYpfuN8fWLv22rmrv9irDOXav256mSd0NsHm5p+3L7hUTHi4I
 rjs6+9h1E8sb8csL21pdvmtdVl4R/7ZMsHj6W9U91kosxRmJhlrMRcWJAOagR8jtAgAA
X-CMS-MailID: 20181205110625eucas1p10c7b3137fb77ae51a211c4f040c4eb6f
X-Msg-Generator: CA
X-RootMTR: 20181205110625eucas1p10c7b3137fb77ae51a211c4f040c4eb6f
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181205110625eucas1p10c7b3137fb77ae51a211c4f040c4eb6f
References: <1544007956-28889-1-git-send-email-l.luba@partner.samsung.com>
 <CGME20181205110625eucas1p10c7b3137fb77ae51a211c4f040c4eb6f@eucas1p1.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_030639_844237_67755EB0 
X-CRM114-Status: GOOD (  10.45  )
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
Cc: mark.rutland@arm.com, len.brown@intel.com, tony.luck@intel.com,
 keescook@chromium.org, cw00.choi@samsung.com, b.zolnierkie@samsung.com,
 gregkh@linuxfoundation.org, anton@enomsg.org, rjw@rjwysocki.net,
 robh+dt@kernel.org, Lukasz Luba <l.luba@partner.samsung.com>,
 tjakobi@math.uni-bielefeld.de, kyungmin.park@samsung.com,
 myungjoo.ham@samsung.com, kgene@kernel.org, pavel@ucw.cz, ccross@android.com,
 krzk@kernel.org, m.szyprowski@samsung.com
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Mark the state for devfreq device while entring suspend/resume process.

Suggested-by: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
Suggested-by: Chanwoo Choi <cw00.choi@samsung.com>
Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
---
 arch/arm/boot/dts/exynos4210.dtsi | 2 ++
 arch/arm/boot/dts/exynos4412.dtsi | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/exynos4210.dtsi b/arch/arm/boot/dts/exynos4210.dtsi
index b6091c2..4429b72 100644
--- a/arch/arm/boot/dts/exynos4210.dtsi
+++ b/arch/arm/boot/dts/exynos4210.dtsi
@@ -298,6 +298,7 @@
 			opp-400000000 {
 				opp-hz = /bits/ 64 <400000000>;
 				opp-microvolt = <1150000>;
+				opp-suspend;
 			};
 		};
 
@@ -367,6 +368,7 @@
 			};
 			opp-200000000 {
 				opp-hz = /bits/ 64 <200000000>;
+				opp-suspend;
 			};
 		};
 	};
diff --git a/arch/arm/boot/dts/exynos4412.dtsi b/arch/arm/boot/dts/exynos4412.dtsi
index 51f72f0..908c0c4 100644
--- a/arch/arm/boot/dts/exynos4412.dtsi
+++ b/arch/arm/boot/dts/exynos4412.dtsi
@@ -432,6 +432,7 @@
 			opp-400000000 {
 				opp-hz = /bits/ 64 <400000000>;
 				opp-microvolt = <1050000>;
+				opp-suspend;
 			};
 		};
 
@@ -520,6 +521,7 @@
 			opp-200000000 {
 				opp-hz = /bits/ 64 <200000000>;
 				opp-microvolt = <1000000>;
+				opp-suspend;
 			};
 		};
 
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
