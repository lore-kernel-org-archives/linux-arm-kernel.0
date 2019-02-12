Return-Path: <SRS0=CPNf=QT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 615E3C282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 11:22:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 305202084E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 11:22:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Ik4Sx8Zw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 305202084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=QQbCiAZB7AIET3EUTQPeOikgZg9dklnVbd2RuZgtBWc=; b=Ik4Sx8ZwKvogRH
	Kn4Xl2V7jwjmU3ivwffVe2ZmMHl2pjdOAxBJRaFWAhy6QrdBBT09Cg4RQymhUpJ54SDbrqRN42Ttt
	gflrruCi6KoKbmtgYPoKvYOR7ma5Aox/SAEIOZdDa6R3aezf8QpUTjFHucw8OjjoujmVO4aZKkSC2
	mGvo4qILw9mKSEfbGXh5/d6afMhQixP85sU3CD1/tNraMNP7U+vhSKg5q5K+Dub0ur7Nn0Q9fakIq
	KUnQKnZfBd0OIRR/gAtTzaYu6V9lrIzq+KQXJDXd4AEZHNfJTWRpbnClN5v279K+bGnXArQgK+GQS
	FxCV2SOudXcAsneDnXmQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtW9Q-00016t-3e; Tue, 12 Feb 2019 11:22:56 +0000
Received: from mail-pl1-f178.google.com ([209.85.214.178])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtW8Y-0000Ap-VP
 for linux-arm-kernel@lists.infradead.org; Tue, 12 Feb 2019 11:22:08 +0000
Received: by mail-pl1-f178.google.com with SMTP id r14so1135455pls.12
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 12 Feb 2019 03:22:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=BrJin9WlcA8u5x13kjg4Q27VD+Vh9kYS7jCJA+xkzCE=;
 b=Emyd4wqny5HdXmJ8+7uA38r5q92fsI+1DD68/isOflfMma+5+J/7lW2Sti70B1cqFC
 AJcL3a5NmPA25P6bg1GSPPYohBIp98+ZYqiDy7qR/QZnAF2YVjYaRzrV1GwS50oD/5TJ
 4J4bjTXQSkU+9xbGzDdCqp5VIY5ECeLBqXN8euBfOeiiEGeqiQBQ0v3Z9dci8OXhQeVD
 55Tda6qBeHVh6P3KXhXbwfGjYLOJmsQOzeB6c9EK3X6MSTiFIrOVWEI2o5PILYKndXUv
 MuFIFpJx9kJOE6ZgnlKbPo2QB+n9Vye4O6hq/iIITMXnPOSlBBDvc1Kfjx6iD99SL6oT
 VIvA==
X-Gm-Message-State: AHQUAubKx3NJXHSFW19wTD5Iqc0xv5Jj9o5WbINPGUhHF586GPl7MgVf
 7KS9SZdoa06Qogj8wvHiGVCcEA==
X-Google-Smtp-Source: AHgI3IamYMN3/iSvfZyFVppJp/gQIIcCPhB2K9hyQupijsYkxFwp+LsWmlpClqcjbRKoFjnSA0Cimw==
X-Received: by 2002:a17:902:29c9:: with SMTP id
 h67mr3527305plb.111.1549970521660; 
 Tue, 12 Feb 2019 03:22:01 -0800 (PST)
Received: from localhost.localdomain (61-216-91-114.HINET-IP.hinet.net.
 [61.216.91.114])
 by smtp.gmail.com with ESMTPSA id s16sm22282264pfk.166.2019.02.12.03.21.57
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Tue, 12 Feb 2019 03:22:00 -0800 (PST)
From: Shawn Guo <shawnguo@kernel.org>
To: arm@kernel.org
Subject: [GIT PULL 5/7] i.MX arm64 device tree changes for 5.1
Date: Tue, 12 Feb 2019 19:21:24 +0800
Message-Id: <20190212112126.572-5-shawnguo@kernel.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190212112126.572-1-shawnguo@kernel.org>
References: <20190212112126.572-1-shawnguo@kernel.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190212_032203_417373_BE6F22DF 
X-CRM114-Status: GOOD (  16.32  )
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
Cc: linux-arm-kernel@lists.infradead.org, Shawn Guo <shawnguo@kernel.org>,
 Fabio Estevam <festevam@gmail.com>, linux-imx@nxp.com, kernel@pengutronix.de
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

VGhlIGZvbGxvd2luZyBjaGFuZ2VzIHNpbmNlIGNvbW1pdCBiZmVmZmQxNTUyODM3NzJiYmU3OGM2
YTA1ZGVjN2MwMTI4ZWU1MDBjOgoKICBMaW51eCA1LjAtcmMxICgyMDE5LTAxLTA2IDE3OjA4OjIw
IC0wODAwKQoKYXJlIGF2YWlsYWJsZSBpbiB0aGUgR2l0IHJlcG9zaXRvcnkgYXQ6CgogIGdpdDov
L2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC9zaGF3bmd1by9saW51eC5n
aXQgdGFncy9pbXgtZHQ2NC01LjEKCmZvciB5b3UgdG8gZmV0Y2ggY2hhbmdlcyB1cCB0byBjYTA0
ZmVkNDcwNmRmYjEzY2I5NjRiZTJkYzI5NDA1NGVkMGVmYjZiOgoKICBhcm02NDogZHRzOiBpbXg4
bXE6IHNwZWNpZnkgZG1hLXJhbmdlcyAoMjAxOS0wMi0xMSAxMzo0NDoxMiArMDgwMCkKCi0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0KaS5NWCBhcm02NCBkZXZpY2UgdHJlZSBjaGFuZ2VzIGZvciA1LjE6CiAtIEFkZCBpbml0aWFs
IGkuTVg4UVhQIFNvQyBhbmQgTUVLIGJvYXJkIHN1cHBvcnQuCiAtIFZhcmlvdXMgZGV2aWNlIGFk
ZGl0aW9ucyB0byBpLk1YOE1RIFNvQyBhbmQgRVZLIGJvYXJkIHN1cHBvcnQ6CiAgIFJUQywgUXVh
ZFNQSSwgUE1VLCBFQ1NQSSwgUFdNLCBHUEMgcG93ZXIgZG9tYWluLCBVU0IgZXRjLgogLSBVc2Ug
Z2VuZXJpYyBub2RlIG5hbWUgZm9yIG0yNXA4MCBmbGFzaCBvbiBsYXllcnNjYXBlIGRldmljZXMu
CiAtIEFkZCBudW0tdmlld3BvcnQgcHJvcGVydHkgZm9yIGxheWVyc2NhcGUgUENJZSBkZXZpY2Vz
LCBhbmQKICAgaW5jci1idXJzdC10eXBlLWFkanVzdG1lbnQgZm9yIFVTQjMgZGV2aWNlcy4KIC0g
QWRkIExTMTAxMkFYIGJhc2VkIE94YWxpcyBib2FyZCBzdXBwb3J0LgogLSBBZGQgZnNsLW1jLCBG
bGV4U1BJIGRldmljZSBhbmQgZG1hLXJhbmdlcyBwcm9wZXJ0eSBmb3IgTFgyMTYwQSBTb0MuCiAt
IEFkZCBTTU1VIGRldmljZSBhbmQgbWlzc2luZyBkbWEtY29oZXJlbnQgcHJvcGVydHkgaW4gZnNs
LW1jIGZvcgogICBMUzEwODggU29DLgoKLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQpBYmVsIFZlc2EgKDEpOgogICAgICBhcm02
NDogZHRzOiBpbXg4bXE6IEFkZCBSVEMgc3VwcG9ydAoKQWlzaGVuZyBEb25nICgyKToKICAgICAg
YXJtNjQ6IGR0czogaW14OiBhZGQgaW14OHF4cCBzdXBwb3J0CiAgICAgIGFybTY0OiBkdHM6IGlt
eDogYWRkIGlteDhxeHAgbWVrIHN1cHBvcnQKCkFsZXhhbmRyZSBCZWxsb25pICgzKToKICAgICAg
YXJtNjQ6IGR0czogZnNsOiB1c2UgYSBnZW5lcmljIG5vZGUgbmFtZSBmb3IgbTI1cDgwIGZsYXNo
ZXMKICAgICAgYXJtNjQ6IGR0czogZnNsOiBsczEwNDZhOiBkaXNhYmxlIHRoZSBmbGFzaCBjb250
cm9sbGVyIGJ5IGRlZmF1bHQKICAgICAgYXJtNjQ6IGR0czogZnNsOiBsczEwNDZhOiBkaXNhYmxl
IHVhcnRzIGJ5IGRlZmF1bHQKCkFuc29uIEh1YW5nICgxKToKICAgICAgYXJtNjQ6IGR0czogaW14
OiBhZGQgaS5NWDhRWFAgc3lzdGVtIGNvbnRyb2xsZXIgUlRDIHN1cHBvcnQKCkNhcmxvIENhaW9u
ZSAoNSk6CiAgICAgIGFybTY0OiBkdHM6IGlteDhtcS1ldms6IGFkZCBtaXNzaW5nIE1ESU8gLyBQ
SFkgbm9kZXMKICAgICAgYXJtNjQ6IGR0czogaW14OG1xLWV2azogQWRkIGZzbCxtYWdpYy1wYWNr
ZXQgcHJvcGVydHkKICAgICAgYXJtNjQ6IGR0czogaW14OG1xOiBBZGQgUXVhZFNQSSBjb250cm9s
bGVyCiAgICAgIGFybTY0OiBkdHM6IGlteDhtcS1ldms6IEVuYWJsZSB0aGUgUXVhZFNQSSBjb250
cm9sbGVyCiAgICAgIGFybTY0OiBkdHM6IGlteDhtcTogQWRkIEFSTSBQTVUgbm9kZQoKRGFuaWVs
IEJhbHV0YSAoMSk6CiAgICAgIGFybTY0OiBkdHM6IGlteDhxeHA6IEZpeCBNVTRfSU5UIG51bWJl
cgoKRmFiaW8gRXN0ZXZhbSAoMSk6CiAgICAgIGFybTY0OiBkdHM6IGlteDhtcTogQWRkIEVDU1BJ
IHN1cHBvcnQKCkd1aWRvIEfDvG50aGVyICgxKToKICAgICAgYXJtNjQ6IGR0czogaW14OG1xOiBB
ZGQgcHdtIGRldmljZSBub2RlcwoKSG91IFpoaXFpYW5nICgxKToKICAgICAgYXJtNjQ6IGR0czog
bGF5ZXJzY2FwZTogYWRkIG51bS12aWV3cG9ydCBwcm9wZXJ0eSBmb3IgUENJZSBEVCBub2RlcwoK
SW9hbmEgQ2lvY29pIFJhZHVsZXNjdSAoMik6CiAgICAgIGFybTY0OiBkdHM6IGx4MjE2MGE6IEFk
ZCBmc2wtbWMgbm9kZQogICAgICBhcm02NDogZHRzOiBseDIxNjBhOiBBZGQgZG1hLXJhbmdlcyBw
cm9wZXJ0eQoKTHVjYXMgU3RhY2ggKDYpOgogICAgICBhcm02NDogZHRzOiBpbXg4bXE6IG1vdmUg
d2F0Y2hkb2cgbm9kZXMgdG8gY29ycmVjdCBsb2NhdGlvbgogICAgICBhcm02NDogZHRzOiBpbXg4
bXE6IGFkZCBHUEMgcG93ZXIgZG9tYWlucwogICAgICBhcm02NDogZHRzOiBpbXg4bXE6IHByb3Bl
cmx5IGRlc2NyaWJlIElSUSBoaWVyYXJjaHkKICAgICAgYXJtNjQ6IGR0czogaW14OG1xOiBhZGQg
VVNCIG5vZGVzCiAgICAgIGFybTY0OiBkdHM6IGlteDhtcS1ldms6IGVuYWJsZSBVU0Igbm9kZXMg
Zm9yIFVTQjMgaG9zdAogICAgICBhcm02NDogZHRzOiBpbXg4bXE6IHNwZWNpZnkgZG1hLXJhbmdl
cwoKTWFuaXZhbm5hbiBTYWRoYXNpdmFtICgxKToKICAgICAgYXJtNjQ6IGR0czogZnJlZXNjYWxl
OiBBZGQgZGV2aWNldHJlZSBmb3IgT3hhbGlzCgpOaXB1biBHdXB0YSAoMik6CiAgICAgIGFybTY0
OiBkdHM6IGxzMTA4ODogYWRkIHNtbXUgZGV2aWNlIG5vZGUKICAgICAgYXJtNjQ6IGR0czogbHMx
MDg4OiBhZGQgbWlzc2luZyBkbWEtY29oZXJlbnQgcHJvcGVydHkgaW4gZnNsLW1jCgpSYW4gV2Fu
ZyAoMSk6CiAgICAgIGFybTY0OiBkdHM6IGxheWVyc2NhcGU6IEFkZCBpbmNyLWJ1cnN0LXR5cGUt
YWRqdXN0bWVudCBwcm9wZXJ0eSB0byBVU0IzIG5vZGUKCllvZ2VzaCBOYXJheWFuIEdhdXIgKDIp
OgogICAgICBhcm02NDogZHRzOiBseDIxNjBhOiBhZGQgRmxleFNQSSBub2RlIHByb3BlcnR5CiAg
ICAgIGFybTY0OiBkdHM6IGx4MjE2MGE6IHVwZGF0ZSBmc3BpIG5vZGUKCiBhcmNoL2FybTY0L2Jv
b3QvZHRzL2ZyZWVzY2FsZS9NYWtlZmlsZSAgICAgICAgICAgICB8ICAgMiArCiAuLi4vYm9vdC9k
dHMvZnJlZXNjYWxlL2ZzbC1sczEwMTJhLW94YWxpcy5kdHMgICAgICB8ICA5NiArKysrKwogYXJj
aC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvZnNsLWxzMTAxMmEuZHRzaSAgICAgfCAgIDIgKwog
YXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvZnNsLWxzMTA0M2EtcWRzLmR0cyAgfCAgIDIg
Ky0KIGFyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2ZzbC1sczEwNDNhLmR0c2kgICAgIHwg
ICA2ICsKIGFyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2ZzbC1sczEwNDZhLXFkcy5kdHMg
IHwgICAyICstCiBhcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9mc2wtbHMxMDQ2YS1yZGIu
ZHRzICB8ICAgNCArLQogYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvZnNsLWxzMTA0NmEu
ZHRzaSAgICAgfCAgMTEgKwogYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvZnNsLWxzMTA4
OGEuZHRzaSAgICAgfCAgOTcgKysrKy0KIGFyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2Zz
bC1sczIwOHhhLmR0c2kgICAgIHwgICA2ICsKIGFyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxl
L2ZzbC1seDIxNjBhLXJkYi5kdHMgIHwgIDI2ICsrCiBhcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVz
Y2FsZS9mc2wtbHgyMTYwYS5kdHNpICAgICB8IDEzMyArKysrKysKIGFyY2gvYXJtNjQvYm9vdC9k
dHMvZnJlZXNjYWxlL2lteDhtcS1ldmsuZHRzICAgICAgIHwgIDQ3ICsrKwogYXJjaC9hcm02NC9i
b290L2R0cy9mcmVlc2NhbGUvaW14OG1xLmR0c2kgICAgICAgICAgfCAzMDQgKysrKysrKysrKysr
LS0KIGFyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhxeHAtbWVrLmR0cyAgICAgIHwg
MTM3ICsrKysrKysKIGFyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhxeHAuZHRzaSAg
ICAgICAgIHwgNDQ2ICsrKysrKysrKysrKysrKysrKysrKwogMTYgZmlsZXMgY2hhbmdlZCwgMTI5
MiBpbnNlcnRpb25zKCspLCAyOSBkZWxldGlvbnMoLSkKIGNyZWF0ZSBtb2RlIDEwMDY0NCBhcmNo
L2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9mc2wtbHMxMDEyYS1veGFsaXMuZHRzCiBjcmVhdGUg
bW9kZSAxMDA2NDQgYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OHF4cC1tZWsuZHRz
CiBjcmVhdGUgbW9kZSAxMDA2NDQgYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OHF4
cC5kdHNpCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwps
aW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJh
ZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51
eC1hcm0ta2VybmVsCg==
