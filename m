Return-Path: <SRS0=niBm=QV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CD68C4360F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 18:13:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0AB8620836
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 18:13:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="R90iXfEt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AB8620836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=u2nWPiNwosstoD6iPmLTTRyIfMRGig9AKgzhTlPG66c=; b=R90iXfEtPGvYgj
	NcORSLbTVy7Qe333pZtt9fNi45QlBJhZLvZDa5VmcIKLKmvWRVD3ISZII+Z9WLCQR9S+lsuJOgh2a
	W6PGZFUqHvMioPItCxq2aYJQ3jFutdR8XAn4LQi6bWAN30zVWSU7lgWOG9if8LGaeke9zfilR1g3S
	wERMx4jgHS7pxskJ5LjH96in/KE9nAwzUeONRVc8x2n23/PNY/9DxTQEobhqeBmbsBr9Rly5Vqt0t
	fwoPuCu8/rfRZlZCuEomXzNK0PJUtYDRdnxKaZzUz2IInLBm0TZFAIBPiCf3yciPU2mAukz68apsC
	3E6hwahfh/Phb1Yi8c1A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guLVj-0008Qn-9Z; Thu, 14 Feb 2019 18:13:23 +0000
Received: from muru.com ([72.249.23.125])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guLVb-0008JW-Cf
 for linux-arm-kernel@lists.infradead.org; Thu, 14 Feb 2019 18:13:16 +0000
Received: from hillo.muru.com (localhost [127.0.0.1])
 by muru.com (Postfix) with ESMTP id 3A9658192;
 Thu, 14 Feb 2019 18:13:25 +0000 (UTC)
From: Tony Lindgren <tony@atomide.com>
To: arm@kernel.org
Subject: [GIT PULL 2/2] more dts changes for omaps for v5.1
Date: Thu, 14 Feb 2019 10:13:06 -0800
Message-Id: <pull-1550167958-188990@atomide.com-2>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <pull-1550167958-188990@atomide.com>
References: <pull-1550167958-188990@atomide.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190214_101315_461926_4DD898F9 
X-CRM114-Status: GOOD (  10.20  )
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
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

RnJvbTogIlRvbnkgTGluZGdyZW4iIDx0b255QGF0b21pZGUuY29tPgoKVGhlIGZvbGxvd2luZyBj
aGFuZ2VzIHNpbmNlIGNvbW1pdCBiNGMzMGRmMGViMzU0ZDhlMDgxMTMyYjdiNzQ0OWY2ZDE3NjE5
NjE0OgoKICBBUk06IGR0czogb21hcDQtc2RwOiBNYWtlIGV0aGVybmV0IHdvcmtpbmcgZXZlbiBp
ZiBib290ZWQgd2l0aCBsYXRlc3QgdS1ib290ICgyMDE5LTAxLTI0IDA4OjIzOjQzIC0wODAwKQoK
YXJlIGF2YWlsYWJsZSBpbiB0aGUgR2l0IHJlcG9zaXRvcnkgYXQ6CgogIGdpdDovL2dpdC5rZXJu
ZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC90bWxpbmQvbGludXgtb21hcCB0YWdzL29t
YXAtZm9yLXY1LjEvZHQtcHQyLXNpZ25lZAoKZm9yIHlvdSB0byBmZXRjaCBjaGFuZ2VzIHVwIHRv
IDk0N2I3ODAyNTk3MTA2ZGNiZWYyZGRjYTIzZDM4NmY5MzM5YmEzMzQ6CgogIEFSTTogZHRzOiBv
bWFwMy1ndGEwNDogZGVjbGFyZSBiYWNrbGlnaHQgaW4gbGNkIG5vZGUgKDIwMTktMDItMTIgMTA6
NTI6MjUgLTA4MDApCgotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tCk1vcmUgZHRzIGNoYW5nZXMgZm9yIG9tYXBzCgpXZSBhZGQg
c3VwcG9ydCBmb3IgQm9zY2ggR3VhcmRpYW4gYW0zMzV4IGRldmljZSwgYW5kIGNvbmZpZ3VyZSBt
b3JlCmRldmljZXMgbGlrZSBHTlNTIGFuZCBMQ0QgYmFja2xpZ2h0IGZvciBvbWFwMy1ndGEwNC4g
QW5kIHdlIHJlcGxhY2UKdGhlIHdsY29yZSBiaW5kaW5nIGRvY3VtZW50YXRpb24gVVJMIHdpdGgg
YSBsb2NhbCBmaWxlIHRoYXQgd2UgaGF2ZS4KCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KQW5kcmVhcyBLZW1uYWRlICg0KToK
ICAgICAgQVJNOiBkdHM6IGd0YTA0OiBhZGQgcGluY3RybCBzZXR0aW5ncyBmb3Igd2t1cCBkb21h
aW4KICAgICAgQVJNOiBkdHM6IGd0YTA0OiBhZGQgbGRvIDN2MyByZWd1bGF0b3IKICAgICAgQVJN
OiBkdHM6IGd0YTA0OiBhZGQgZ3BzIHN1cHBvcnQKICAgICAgQVJNOiBkdHM6IG9tYXAzLWd0YTA0
OiBkZWNsYXJlIGJhY2tsaWdodCBpbiBsY2Qgbm9kZQoKSm9uYXRoYW4gTmV1c2Now6RmZXIgKDEp
OgogICAgICBBUk06IGR0czogb21hcDMtZ3RhMDRhNTogUmVwbGFjZSBMWFIgcmVmZXJlbmNlIHdp
dGggYSBsb2NhbCBvbmUKCk1hcnR5biBXZWxjaCAoMSk6CiAgICAgIEFSTTogZHRzOiBhbTMzNXg6
IEFkZCBzdXBwb3J0IGZvciBCb3NjaCBHdWFyZGlhbgoKIGFyY2gvYXJtL2Jvb3QvZHRzL01ha2Vm
aWxlICAgICAgICAgICAgfCAgIDEgKwogYXJjaC9hcm0vYm9vdC9kdHMvYW0zMzV4LWd1YXJkaWFu
LmR0cyB8IDUxMSArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrCiBhcmNoL2FybS9i
b290L2R0cy9vbWFwMy1ndGEwNC5kdHNpICAgIHwgIDM5ICsrLQogYXJjaC9hcm0vYm9vdC9kdHMv
b21hcDMtZ3RhMDRhNS5kdHMgICB8ICAgMiArLQogNCBmaWxlcyBjaGFuZ2VkLCA1NTEgaW5zZXJ0
aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKIGNyZWF0ZSBtb2RlIDEwMDY0NCBhcmNoL2FybS9ib290
L2R0cy9hbTMzNXgtZ3VhcmRpYW4uZHRzCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0t
a2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFp
bG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
