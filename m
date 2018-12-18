Return-Path: <SRS0=e5Gl=O3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4121FC43444
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 15:03:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F18A021852
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 15:03:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="QgERwkV9";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="dv63YM0n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F18A021852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=ibuNiZsNjwTRffVnV4jOfxKcvfxWa/zNKWhtwNhuUQ4=; b=QgERwkV9zx11R+
	R7jknnofn6bZuH7zFOLWi8eKljYEIQSeRFqCavbErz59rCdGQKPtajTblz1YUFl1VW4P2Gzs7Ur8U
	s3BjYoLDpzzyRoREfNHohWy1lHFiEh6/R6TlcXu4zdIFDtI8mxR2lmpB211CphAYRUYza8gUtyZSf
	o02J9dXJQAWTm7fPFmtwwSxxt8Mk+A+7ITzF9DGla/7uvs+n7vl6n6jc3MTVGcAXmhh730wPAKSlN
	sQfC7CSnsY0WsBrZizsfCekUjYHiHLQ9FjdqgSsad/9A4nkUB+8s33o3IdtzfR51YkE6Jfl33fvam
	4lRywCkUg/Fk4XRh32OQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZGtn-0008U7-FC; Tue, 18 Dec 2018 15:03:07 +0000
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZGtj-0008Rn-0U
 for linux-arm-kernel@lists.infradead.org; Tue, 18 Dec 2018 15:03:04 +0000
Received: by mail-pg1-x544.google.com with SMTP id j10so6726395pga.1
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 18 Dec 2018 07:02:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=EoR9tXvS5iiZMeyLbkU3WrDtPTssA7xoNREpHrQD36c=;
 b=dv63YM0n1ELXbUR9u9DkFQXPUh4O3k9+zR/4cv0NkjBuYhfDPrYXW4s93i93i8IAAP
 4ZEJoBb/LUPzY4qrOLNV2PQ+1mxOrX1BXoLtt+WHThoy7JsqmHDemdizun7Gbb4U/vvo
 mNXnC6CDLbk3sIK9D2miSw/4XXLWJN2r6fxNI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=EoR9tXvS5iiZMeyLbkU3WrDtPTssA7xoNREpHrQD36c=;
 b=CuMsejpEtrx5STXGuLV90HF55JD2AoecVv7YmeceuHn1IVHYVHrS/9HRztnRkOQtCz
 SIZ+RmLIHuUzzs4nCLQ1kgoQRWaBAFUBeMGtjGdG53QPA8FwGncZNLlFLzpXVmytf+Lz
 YuRzlqAZik538x/9+DZY3Lrn5BZZtNHG0yPMCwiIg7joZaI10hXtXJuVTfP1SyDAvvTe
 j9q/pBLhRU3YAF9T8YLhZL87NbEagsmEd1KfduVe1bwEIGIf9SWRUxqkC++zBP48UAvk
 uZswlnc6wiPCY7nNC1C4G8aT9/jqiqySyZNpMBTJtpSxzN7bRN5J2st/QUfu6tx3L6ul
 8WkA==
X-Gm-Message-State: AA+aEWZ5XQxF4DBkh/tssh7DTHYzie+FVHCD3h15QzLLcctzE5ReYsaP
 CEX363qqgBIVrLak8InMqXYT
X-Google-Smtp-Source: AFSGD/V/9h9QNNKDX1eC1wnyt7Zw/bawJozYpB39qdXqj/4gZN2qZKnr4hL+QTlNXBR+FPne5ElFww==
X-Received: by 2002:a62:7086:: with SMTP id l128mr16872918pfc.68.1545145371950; 
 Tue, 18 Dec 2018 07:02:51 -0800 (PST)
Received: from localhost.localdomain ([2409:4072:702:382e:8c68:d268:ed20:5f25])
 by smtp.gmail.com with ESMTPSA id m198sm28798688pga.10.2018.12.18.07.02.44
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 18 Dec 2018 07:02:51 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: olof@lixom.net, arnd@arndb.de, arm@kernel.org,
 linux-arm-kernel@lists.infradead.org
Subject: [PATCH v7 00/11] Add initial RDA8810PL SoC and Orange Pi boards
 support
Date: Tue, 18 Dec 2018 20:32:27 +0530
Message-Id: <20181218150238.23010-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181218_070303_054042_E309E040 
X-CRM114-Status: GOOD (  13.87  )
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
Cc: devicetree@vger.kernel.org, gregkh@linuxfoundation.org,
 linus.walleij@linaro.org,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 linux-kernel@vger.kernel.org, amit.kucheria@linaro.org,
 linux-unisoc@lists.infradead.org, robh+dt@kernel.org,
 linux-serial@vger.kernel.org, jslaby@suse.com, afaerber@suse.de,
 zhao_steven@263.net
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGVsbG8gTWFpbnRhaW5lcnMsCgpUaGlzIHBhdGNoIHNlcmllcyBhZGRzIGluaXRpYWwgUkRBODgx
MFBMIFNvQyBhbmQgT3JhbmdlIFBpIGJvYXJkcyAoMkcgSW9UIGFuZAppOTYpIHN1cHBvcnQuIFJE
QTg4MTBQTCBpcyBhbiBBUk0gQ29ydGV4IEE1IGJhc2VkIFNvQyB3aXRoIFZpdmFudGUncyBHQzg2
MApHUFUuIFRoZSBTb0MgaGFzIGJlZW4gYWRkZWQgYXMgYSBuZXcgQVJNIHN1YiBhcmNoaXRlY3R1
cmUgd2l0aCBteXNlbGYgYXMgdGhlCm1haW50YWluZXIuCgpNb3JlIGluZm9ybWF0aW9uIGFib3V0
IHRoZSBib2FyZHMgY2FuIGJlIGZvdW5kIGluIGJlbG93IGxpbmtzOgoKMS4gT3JhbmdlIFBpIDJH
LUlvVCAtIGh0dHA6Ly93d3cub3JhbmdlcGkub3JnL09yYW5nZVBpMkdJT1QvCjIuIE9yYW5nZSBQ
aSBpOTYgLSBodHRwczovL3d3dy45NmJvYXJkcy5vcmcvcHJvZHVjdC9vcmFuZ2VwaS1pOTYvCgpB
bGwgcGF0Y2hlcyBhcmUgcmV2aWV3ZWQgYnkgdGhlIGNvcnJlc3BvbmRpbmcgc3Vic3lzdGVtIG1h
aW50YWluZXJzLiBUaGUKY2xvY2tzb3VyY2UgYW5kIGlycWNoaXAgcGF0Y2hlcyBhcmUgcmV2aWV3
ZWQgYW5kIG1lcmdlZCB3aGlsZSB0aGUgc2VyaWFsCmRyaXZlciBnb3QgcmV2aWV3IGZyb20gR3Jl
ZyBidXQgSSdtIG5vdCBzdXJlIHdobyB3aWxsIGFwcGx5IGl0LgoKU28gYXMgcGVyIG15IGRpc2N1
c3Npb24gd2l0aCBBcm5kLCBzZW5kaW5nIHRoZSBpbmRpdmlkdWFsIHBhdGNoZXMgaW5zdGVhZApv
ZiBhIFB1bGwgcmVxdWVzdCBzbyB0aGF0IHRoZSByZXN0IG9mIHRoZSBwYXRjaGVzIGNhbiBnbyB0
aHJvdWdoIHRoZQpBUk0gU29DIHRyZWUuCgpQbGVhc2UgY29uc2lkZXIgYXBwbHlpbmcgaXQuCgpU
aGFua3MsCk1hbmkKCkFuZHJlYXMgRsOkcmJlciAoNCk6CiAgZHQtYmluZGluZ3M6IEFkZCBSREEg
TWljcm8gdmVuZG9yIHByZWZpeAogIGR0LWJpbmRpbmdzOiBhcm06IERvY3VtZW50IFJEQTg4MTBQ
TCBhbmQgcmVmZXJlbmNlIGJvYXJkcwogIEFSTTogUHJlcGFyZSBSREE4ODEwUEwgU29DCiAgZHQt
YmluZGluZ3M6IHNlcmlhbDogRG9jdW1lbnQgUkRBIE1pY3JvIFVBUlQKCk1hbml2YW5uYW4gU2Fk
aGFzaXZhbSAoNyk6CiAgQVJNOiBkdHM6IEFkZCBkZXZpY2V0cmVlIGZvciBSREE4ODEwUEwgU29D
CiAgQVJNOiBkdHM6IEFkZCBkZXZpY2V0cmVlIGZvciBPcmFuZ2VQaSAyRyBJb1QgYm9hcmQKICBB
Uk06IGR0czogQWRkIGRldmljZXRyZWUgZm9yIE9yYW5nZVBpIGk5NiBib2FyZAogIEFSTTogZHRz
OiByZGE4ODEwcGw6IEFkZCB0aW1lciBzdXBwb3J0CiAgQVJNOiBkdHM6IHJkYTg4MTBwbDogQWRk
IGludGVycnVwdCBzdXBwb3J0IGZvciBVQVJUCiAgdHR5OiBzZXJpYWw6IEFkZCBSREE4ODEwUEwg
VUFSVCBkcml2ZXIKICBNQUlOVEFJTkVSUzogQWRkIGVudHJ5IGZvciBSREEgTWljcm8gU29DIGFy
Y2hpdGVjdHVyZQoKIC4uLi9hZG1pbi1ndWlkZS9rZXJuZWwtcGFyYW1ldGVycy50eHQgICAgICAg
ICB8ICAgNiArCiBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvYXJtL3JkYS50eHQg
fCAgMTcgKwogLi4uL2JpbmRpbmdzL3NlcmlhbC9yZGEsODgxMHBsLXVhcnQudHh0ICAgICAgIHwg
IDE3ICsKIC4uLi9kZXZpY2V0cmVlL2JpbmRpbmdzL3ZlbmRvci1wcmVmaXhlcy50eHQgICB8ICAg
MSArCiBNQUlOVEFJTkVSUyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgMTQg
KwogYXJjaC9hcm0vS2NvbmZpZyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgICAyICsK
IGFyY2gvYXJtL01ha2VmaWxlICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgMSArCiBh
cmNoL2FybS9ib290L2R0cy9NYWtlZmlsZSAgICAgICAgICAgICAgICAgICAgfCAgIDMgKwogLi4u
L2Jvb3QvZHRzL3JkYTg4MTBwbC1vcmFuZ2VwaS0yZy1pb3QuZHRzICAgIHwgIDUwICsrCiBhcmNo
L2FybS9ib290L2R0cy9yZGE4ODEwcGwtb3JhbmdlcGktaTk2LmR0cyAgfCAgNTAgKysKIGFyY2gv
YXJtL2Jvb3QvZHRzL3JkYTg4MTBwbC5kdHNpICAgICAgICAgICAgICB8ICA5OSArKysKIGFyY2gv
YXJtL21hY2gtcmRhL0tjb25maWcgICAgICAgICAgICAgICAgICAgICB8ICAgNyArCiBhcmNoL2Fy
bS9tYWNoLXJkYS9NYWtlZmlsZSAgICAgICAgICAgICAgICAgICAgfCAgIDEgKwogZHJpdmVycy90
dHkvc2VyaWFsL0tjb25maWcgICAgICAgICAgICAgICAgICAgIHwgIDE5ICsKIGRyaXZlcnMvdHR5
L3NlcmlhbC9NYWtlZmlsZSAgICAgICAgICAgICAgICAgICB8ICAgMSArCiBkcml2ZXJzL3R0eS9z
ZXJpYWwvcmRhLXVhcnQuYyAgICAgICAgICAgICAgICAgfCA4MzEgKysrKysrKysrKysrKysrKysr
CiBpbmNsdWRlL3VhcGkvbGludXgvc2VyaWFsX2NvcmUuaCAgICAgICAgICAgICAgfCAgIDMgKwog
MTcgZmlsZXMgY2hhbmdlZCwgMTEyMiBpbnNlcnRpb25zKCspCiBjcmVhdGUgbW9kZSAxMDA2NDQg
RG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2FybS9yZGEudHh0CiBjcmVhdGUgbW9k
ZSAxMDA2NDQgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NlcmlhbC9yZGEsODgx
MHBsLXVhcnQudHh0CiBjcmVhdGUgbW9kZSAxMDA2NDQgYXJjaC9hcm0vYm9vdC9kdHMvcmRhODgx
MHBsLW9yYW5nZXBpLTJnLWlvdC5kdHMKIGNyZWF0ZSBtb2RlIDEwMDY0NCBhcmNoL2FybS9ib290
L2R0cy9yZGE4ODEwcGwtb3JhbmdlcGktaTk2LmR0cwogY3JlYXRlIG1vZGUgMTAwNjQ0IGFyY2gv
YXJtL2Jvb3QvZHRzL3JkYTg4MTBwbC5kdHNpCiBjcmVhdGUgbW9kZSAxMDA2NDQgYXJjaC9hcm0v
bWFjaC1yZGEvS2NvbmZpZwogY3JlYXRlIG1vZGUgMTAwNjQ0IGFyY2gvYXJtL21hY2gtcmRhL01h
a2VmaWxlCiBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy90dHkvc2VyaWFsL3JkYS11YXJ0LmMK
Ci0tIAoyLjE3LjEKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3Rz
LmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5m
by9saW51eC1hcm0ta2VybmVsCg==
