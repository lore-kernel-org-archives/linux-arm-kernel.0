Return-Path: <SRS0=Fp1N=PV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A82AC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 16:15:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 592B920836
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 16:15:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="fG3kao2I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 592B920836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=F1IBU0KmnMPM5Sdx5Qxdfo34ZbbEyKVYKd9w0GthPVI=; b=fG3kao2IY0aeti
	mIU0qUvGzqsCVoT/merISZoBU3QaQO+PN3WyF7/QH9IjlKf//T3Ymz9sfV+A2GFKszJW0g8oj6UqN
	E8zIWVLcOnAhyIGYUYligo/xBOJPxkdpz/2WqUxILuNuLUhGuixZ+AJzTyHLrP4SQAVb+KQcLScv3
	CLBOlHSpQlj7PY4C4r4Ig04awyn3A48VDRU4YSgn1C4gYWcMznyLQKRKWYKYm0LNbQm7yotLqSVgp
	w4JYdhI788bT3gokoI0Gwf4P+oyGcga+AeaGh2oEimSkrIEQCuTTcQ0F4biDd+ritQPsTTY8j19yv
	zQcZblqVobqigOB7hnCQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1giiPw-0002de-FC; Sun, 13 Jan 2019 16:15:20 +0000
Received: from mout.gmx.net ([212.227.17.22])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1giiPt-0002Ad-Eh
 for linux-arm-kernel@lists.infradead.org; Sun, 13 Jan 2019 16:15:19 +0000
Received: from longitude ([109.90.232.48]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MBIAz-1gahfo0DrR-00AGtc; Sun, 13
 Jan 2019 17:15:05 +0100
From: =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH] arm64: dts: allwinner: a64: Fix a typo
Date: Sun, 13 Jan 2019 17:14:13 +0100
Message-Id: <20190113161413.14654-1-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-Provags-ID: V03:K1:CK/EgY7EQx0Q4QI163sRiEttrNT3KpYgbe/wDTjbcIbVQ2v6VFf
 3YYkR2Nw5dDEFGuxwdm0eZ/5fgtF4ryRV1TYQLCR7UN8q4yWQs7qFo+13/5B/bzL9KqImum
 2rmMnGZ8FoyL+bbMq0xNiYqhBDp5ukT7IWXRdxN2rDnYx/RIbJer7SP6s7SGfAUaYZMEvKP
 UzjP3blBT5m+ucMx0LzTg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:k4EH+YnfaTw=:wtJgbtrL8NI1HOf9ahbVVc
 jjKpRWQiDFNheW+WHtFGZiqy4UvipEXbP77li/AbciTu2F7zVOtvw8EqTzIwRAFlnY5IRVh9j
 MRIZmpmhmB3YyfVGGvwxBfpfJzdARM4Bqx1hoKcpYrm+5uhUC5fv7hWgTgZo3XiWzGhNoCaVY
 tGLhXOxfoXC6o4VwcCo6i5KfZOACn9IhQwMaxyt+bcyxHATEUqqumq37lJkw7uJn1ZqcXDO0U
 uAYE70fKuvif0roa11XrPnQdRq0P0r89BVc8V9c/tNxFT3blizJQSxiNPbAgyGIWumXFaBjfd
 LpjAHUmg+mxF06UMhodm9QimsYPqcrLmfESXTgrzEgsO/kWNIClNKkgJ+77gRg/CVcO6Yo1IG
 oBBRtTyqS+3nV4YFqhbR5J84cApliXLuBkXsAAsM5ZhZuixfNKDByOoHP8yphPfVapdzCEMM1
 t7odH6RFSeHN7BCz8+rOjrvxk26GVBiTkvzO30v4agC7QbLG18q5OI3dh9ASf5ayFAX9gcE07
 nNBL779ZDqZCIGGzlVLI1zoF/bRykcco6Pt94a+0r00Z+pfkfntr0rUBow3ELCzcWAyPaaNEP
 tMyRfsw2KMpWT0w6zMiCGT7uBzhIGcMXeLdM3ElFP0vIA7BkbHYPG05B4tOFNq/BKMKsNDJlA
 gn4t7KPjy6mu921Y4PnrihRJyI+6so2ueG0SEBTqHxI+b1kfdPL7TCs29b3xz9NTLZYQSeJRN
 XZycmvLptAIwx2AwjCjKjqBg3G+aFWpc7OkFwyru8uIhUpWYMHzeR5G7ZLXPLksK88C9seXN8
 BHurpniVkb89ZKomPZ6a9nAw2yIeCR8O8Y24l1GsDgFRYB7GHQ10HOOxj8sIi+vBr9KHCoY3i
 6U2SBXamkODvET6VN2HguFhF2nIaJu8azP5WfA/+Y+v+eWWncD7gS5mkKMWUi9vr3P2ZirBjz
 W/ws8sTV0aQ==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190113_081517_848367_97300CFB 
X-CRM114-Status: GOOD (  11.59  )
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
 Maxime Ripard <maxime.ripard@bootlin.com>,
 =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
 linux-kernel@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>,
 Rob Herring <robh+dt@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

VGhpcyB0eXBvIGludmVydGVkIHRoZSBtZWFuaW5nIG9mIHRoZSBjb21tZW50LCBidXQgdGhlIHJl
c3Qgb2YgdGhlCmNvbW1lbnQgYW5kIHRoZSBjb2RlIHJldmVhbCB0aGF0IHRoZSByZWd1bGF0b3Ig
aW4gcXVlc3Rpb24gbmVlZHMgdG8gYmUKb24gYXQgYWxsIHRpbWVzLgoKU2lnbmVkLW9mZi1ieTog
Sm9uYXRoYW4gTmV1c2Now6RmZXIgPGoubmV1c2NoYWVmZXJAZ214Lm5ldD4KLS0tCiBhcmNoL2Fy
bTY0L2Jvb3QvZHRzL2FsbHdpbm5lci9zdW41MGktYTY0LXRlcmVzLWkuZHRzIHwgMiArLQogMSBm
aWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEv
YXJjaC9hcm02NC9ib290L2R0cy9hbGx3aW5uZXIvc3VuNTBpLWE2NC10ZXJlcy1pLmR0cyBiL2Fy
Y2gvYXJtNjQvYm9vdC9kdHMvYWxsd2lubmVyL3N1bjUwaS1hNjQtdGVyZXMtaS5kdHMKaW5kZXgg
YzQ1NWIyNGRkMDc5Li5mOWVlZGUwYThiZDMgMTAwNjQ0Ci0tLSBhL2FyY2gvYXJtNjQvYm9vdC9k
dHMvYWxsd2lubmVyL3N1bjUwaS1hNjQtdGVyZXMtaS5kdHMKKysrIGIvYXJjaC9hcm02NC9ib290
L2R0cy9hbGx3aW5uZXIvc3VuNTBpLWE2NC10ZXJlcy1pLmR0cwpAQCAtMjM5LDcgKzIzOSw3IEBA
CiB9OwogCiAvKgotICogVGhlIEE2NCBjaGlwIGNhbm5vdCB3b3JrIHdpdGhvdXQgdGhpcyByZWd1
bGF0b3Igb2ZmLCBhbHRob3VnaAorICogVGhlIEE2NCBjaGlwIGNhbm5vdCB3b3JrIHdpdGggdGhp
cyByZWd1bGF0b3Igb2ZmLCBhbHRob3VnaAogICogaXQgc2VlbXMgdG8gYmUgb25seSBkcml2aW5n
IHRoZSBBUjEwMCBjb3JlLgogICogTWF5YmUgd2UgZG9uJ3Qgc3RpbGwga25vdyB3ZWxsIGFib3V0
IENQVXMgZG9tYWluLgogICovCi0tIAoyLjIwLjEKCgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51
eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5v
cmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
