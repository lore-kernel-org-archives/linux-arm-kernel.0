Return-Path: <SRS0=e5Gl=O3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F858C43612
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 08:06:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6FB4F21850
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 08:06:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dW1EA9e5";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="AGhyNpLB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FB4F21850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=SkYYQ3iqlN3m22jBLbjPRhwTGkEHqj0YGrKieaOObVM=; b=dW1EA9e5U4QHQj
	i8DoSWT4tCR/WIRKluxuAveNzs6InCbIG97O42lnHWf3GVC/S32ljwJ7ih8gCPzXW2ee81fwmIDnD
	VN0o6LEfsviuQSI98ujvS/uvn3DsfqeqTppq4gUQ7mcne0AtDRH4rzR9mbQQ6/9nvaDiHNRYjWiPJ
	Uf4Vy/KtSH771M8XrgJRdFMTT98UnL5RHB+z/L78vDjyRdWXxyfs4/4YpTO46dP9KUEbIriLl2OIH
	caqEU8d/ehr5kLBy4jaQMHsYAIGRvDLVgGnOvkUmF8rLpdpc9vhl5u4oGQK27FxUgLb5EkQKUqx/d
	zJnDExqQgFqgBxe0qBwg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZAOD-0007nc-HL; Tue, 18 Dec 2018 08:06:05 +0000
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZAO1-0007UY-BH
 for linux-arm-kernel@lists.infradead.org; Tue, 18 Dec 2018 08:05:58 +0000
Received: by mail-pg1-x52b.google.com with SMTP id c25so5944052pgb.4
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 18 Dec 2018 00:05:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=fNnQ01QtOuLnNql7u2t1TXH3JBjCSJxCTLjx8RnrsZs=;
 b=AGhyNpLBYn3t5YLs9m7KwDZnzvwgL5He9FWKcKJPDsP/H2qb6QPvkoP3MBvfWKtnAc
 lEHGqdSiWXEmm1lXtxfMX5oNi77av22ErUHkDpi0YrrbDnb5AJDPw21fYcwBc+AyjCnp
 EeRsxH1INShwnYEpTvW7Qzv+gmBxsWA4Cw+iA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=fNnQ01QtOuLnNql7u2t1TXH3JBjCSJxCTLjx8RnrsZs=;
 b=hS4z5Mg16UDzsTcwSIX+/qWWGcWfsXMfQVXbfZYragV252uSi15+xW2sg0ofzzOYy6
 8HX6eTmpkf/BVg5peS4fALlqiFjsC//FKlnE0COEkWxu7oyxITWpf2kCrMYrZP0/lRY6
 hH2HwLNYkPqdh3VlLVDV+YeClZ4Rus66DqgR/kC07oH1wn764uUsn6jxG7pfspqiFBKg
 afCSkXlQhRKjdIE5nVQ2lFVKz6V4ZDoGfodz1P7RShqtnjOKjblk0EJIIgANXzJwNXys
 HZqX72VqJNDdfjGkVJAGad5JGlKo5V8753daMLmcXeajWvSVEX8lR+L8+RA1Sd6qv9pm
 7GIQ==
X-Gm-Message-State: AA+aEWagtMJziGZvO/QNC3Gb/+npIU1AQBYMMP9xvp+gpbFzoeXnVMoD
 RZedN2MirqPJE9hANDjgu7Oa
X-Google-Smtp-Source: AFSGD/VDJXLTW+B475kSPScvDNwv5U4Utxec7tilT4zJphA1Eg6dC8SA3AX+LCqblMvn35vxYA36aA==
X-Received: by 2002:a63:4926:: with SMTP id w38mr14291485pga.353.1545120342280; 
 Tue, 18 Dec 2018 00:05:42 -0800 (PST)
Received: from localhost.localdomain ([2409:4072:702:382e:8c68:d268:ed20:5f25])
 by smtp.gmail.com with ESMTPSA id 7sm45596888pfm.8.2018.12.18.00.05.34
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 18 Dec 2018 00:05:41 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: olof@lixom.net, arnd@arndb.de, robh+dt@kernel.org,
 gregkh@linuxfoundation.org, jslaby@suse.com
Subject: [PATCH v6 00/11] Add initial RDA8810PL SoC and Orange Pi boards
 support
Date: Tue, 18 Dec 2018 13:35:16 +0530
Message-Id: <20181218080527.10801-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181218_000553_897810_2981CDA6 
X-CRM114-Status: GOOD (  14.64  )
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
Cc: devicetree@vger.kernel.org, linus.walleij@linaro.org,
 linux-kernel@vger.kernel.org, amit.kucheria@linaro.org,
 linux-unisoc@lists.infradead.org, linux-serial@vger.kernel.org,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, afaerber@suse.de,
 linux-arm-kernel@lists.infradead.org, zhao_steven@263.net
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGVsbG8sCgpUaGlzIHBhdGNoc2V0IGFkZHMgaW5pdGlhbCBSREE4ODEwUEwgU29DIGFuZCBPcmFu
Z2UgUGkgYm9hcmRzICgyRyBJb1QgYW5kCmk5Nikgc3VwcG9ydC4gUkRBODgxMFBMIGlzIGFuIEFS
TSBDb3J0ZXggQTUgYmFzZWQgU29DIHdpdGggVml2YW50ZSdzIEdDODYwCkdQVS4gVGhlIFNvQyBo
YXMgYmVlbiBhZGRlZCBhcyBhIG5ldyBBUk0gc3ViIGFyY2hpdGVjdHVyZSB3aXRoIG15c2VsZgph
bmQgQW5kcmVhcyBhcyB0aGUgbWFpbnRhaW5lcnMuCgpNb3JlIGluZm9ybWF0aW9uIGFib3V0IHRo
ZSBib2FyZHMgY2FuIGJlIGZvdW5kIGluIGJlbG93IGxpbmtzOgoKMS4gT3JhbmdlIFBpIDJHLUlv
VCAtIGh0dHA6Ly93d3cub3JhbmdlcGkub3JnL09yYW5nZVBpMkdJT1QvCjIuIE9yYW5nZSBQaSBp
OTYgLSBodHRwczovL3d3dy45NmJvYXJkcy5vcmcvcHJvZHVjdC9vcmFuZ2VwaS1pOTYvCgpUaGlz
IHBhdGNoc2V0IGlzIGJhc2VkIG9uIHRoZSBpbml0aWFsIHJldmlzaW9uIHNlbnQgb3V0IGJ5IEFu
ZHJlYXMgbG9uZwpiYWNrIChodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9waXBlcm1haWwvbGlu
dXgtYXJtLWtlcm5lbC8yMDE3LUp1bmUvNTE1OTUxLmh0bWwpLgoKSSBoYXZlIGV4dGVuZGVkIGhp
cyBwYXRjaHNldCB3aXRoIHByb3BlciBpcnFjaGlwIGFuZCBVQVJUIGRyaXZlcnMuIE5vdywKYm9h
cmRzIGNhbiBib290IGludG8gaW5pdHJhbWZzIHdpdGggY29uc29sZSBhdCBVQVJUMi4KClRoYW5r
cywKTWFuaQoKQ2hhbmdlcyBpbiB2NjoKCiogRml4ZWQgdGhlIE1BSU5UQUlORVJTIHBhdGNoIGNv
bW1pdCBtZXNzYWdlCgpDaGFuZ2VzIGluIHY1OgoKKiBEcm9wcGVkIHRpbWVyIGFuZCBpcnFjaGlw
IHBhdGNoZXMgc2luY2UgdGhleSBnb3QgYXBwbGllZAoqIERyb3BwZWQgQW5kcmVhcyBmcm9tIE1B
SU5UQUlORVJTIGFzIHBlciBoaXMgcmVxdWVzdAoKQ2hhbmdlcyBpbiB2NDoKCiogQWRkZWQgUm9i
J3MgUmV2aWV3ZWQtYnkgdGFncyBmb3IgdmVuZG9yIGFuZCBTb0MgcGF0Y2hlcy4KKiBNb3ZlZCBw
bGF0Zm9ybSBLY29uZmlnIGNoYW5nZXMgZnJvbSB0aW1lciBhbmQgaXJxY2hpcCBkcml2ZXJzIHRv
CiAgU29DIHN1cHBvcnQgcGF0Y2guCiogQWRkZWQgTWFyYydzIFJldmlld2VkLWJ5IHRhZyBmb3Ig
aXJxY2hpcCBkcml2ZXIuCiogQWRkcmVzc2VkIFJvYidzIHJldmlldyBjb21tZW50cyBmb3IgYmlu
ZGluZ3MgcGF0Y2hlcy4KKiBBZGRlZCB0aGUgbmV3bHkgY3JlYXRlZCBsaW51eC11bmlzb2MgbWFp
bGluZyBsaXN0IHRvIE1BSU5UQUlORVJTCiAgZW50cnkuCiogRHJvcHBlZCBvdmVyc2Vhcy5zYWxl
c0B1bmlzb2MuY29tIG1haWwgYWRkcmVzcyBhcyBpdCBpcyBib3VuY2luZyBiYWNrLgoqIE1vZGlm
aWVkIHRoZSBEVFMgc3ViamVjdCBwcmVmaXggdG8gQVJNOiBmcm9tIGFybToKCkNoYW5nZXMgaW4g
djM6CgpBcyBwZXIgTWFyYydzIHJldmlldzoKCiogUmVtb3ZlZCB1bnVzZWQgaGVhZGVyIGFuZCBk
ZWZpbmVzIGZyb20gaXJxY2hpcCBkcml2ZXIuCiogUmVtb3ZlZCBzZXR0aW5nIGZsb3cgaGFuZGxl
cnMgZnJvbSBzZXRfdHlwZSBjYWxsYmFjay4KKiBNaW5vciBjb2RlIGNsZWFudXBzLgoKQXMgcGVy
IEFybmQncyByZXZpZXc6CgoqIE1vZGlmaWVkIHRoZSBVQVJUIGluZGV4ZXMgdG8gc3RhcnQgZnJv
bSAxIHRvIG1hdGNoIHRoZSBTb0MgbnVtYmVyaW5nCiogRW5hYmxlZCBleHBvc2VkIFVBUlRzIChh
bGwgMyBvbiBib3RoIGJvYXJkcykKKiBNb2RpZmllZCB0aGUgc2VyaWFsIGFsaWFzZXMgYXMgcGVy
IGJvYXJkIG51bWJlcmluZwoKKiBBZGRlZCBHcmVnJ3MgUmV2aWV3ZWQtYnkgdGFnIGZvciBzZXJp
YWwgZHJpdmVyLgoKQ2hhbmdlcyBpbiB2MjoKCiogVXNlZCByZWFkbC93cml0ZWxfcmVsYXhlZCBj
YWxscyBmb3IgYm90aCBpcnFjaGlwIGFuZCB0aW1lciBkcml2ZXJzIGFzCiAgcGVyIE1hcmMncyBy
ZXZpZXcuCiogSW1wbGVtZW50ZWQgdGhlIGxvZ2ljIHRvIHByZXZlbnQgY291bnRlciB3cmFwcGlu
ZyBkdXJpbmcgcmVhZCBhcwogIHN1Z2dlc3RlZCBieSBNYXJjLgoqIFVzZWQgdGhlIHRpbWVyLW9m
IEFQSSBhcyBwZXIgRGFuaWVsJ3Mgc3VnZ2VzdGlvbi4KKiBBZGRlZCBkZXNjcmlwdGlvbiBhYm91
dCB0aGUgdGltZXIgaW4gYm90aCBjb21taXQgbG9nIGFuZCBkcml2ZXIuCiogQ2hhbmdlZCB0aGUg
VmVuZG9yIG5hbWUgZm9yIFJEQSB0byBVbmlzb2MgQ29tbXVuaWNhdGlvbnMgSW5jLgoqIFJlbW92
ZWQgdGhlIHNvYyBub2RlIGxldmVsIGFuZCBjbGVhbmVkIHVwIGRldmljZXRyZWVzIGFzIHBlciBS
b2IncwogIHJldmlldy4KKiBNZXJnZWQgaW50ZXJydXB0IGNvbnRyb2xsZXIgRFQgcGF0Y2ggdG8g
U29DLgoqIE1vdmVkIGFsaWFzZXMgdG8gYm9hcmQgZHRzIGFzIHBlciBBcm5kJ3Mgc3VnZ2VzdGlv
bi4KKiBSZW1vdmVkIFJEQSBNaWNybyBzdXBwb3J0IG1haWwgYWRkcmVzcyBhbmQgdXNlZCBVbmlz
b2Mgb25lIGFuZCBhZGRlZAogIG15IG1pc3Npbmcgc2lnbmVkIG9mZiBieSB0YWcgYXMgcGVyIEFu
ZHJlYXMncyBjb21tZW50cy4KCkFuZHJlYXMgRsOkcmJlciAoNCk6CiAgZHQtYmluZGluZ3M6IEFk
ZCBSREEgTWljcm8gdmVuZG9yIHByZWZpeAogIGR0LWJpbmRpbmdzOiBhcm06IERvY3VtZW50IFJE
QTg4MTBQTCBhbmQgcmVmZXJlbmNlIGJvYXJkcwogIEFSTTogUHJlcGFyZSBSREE4ODEwUEwgU29D
CiAgZHQtYmluZGluZ3M6IHNlcmlhbDogRG9jdW1lbnQgUkRBIE1pY3JvIFVBUlQKCk1hbml2YW5u
YW4gU2FkaGFzaXZhbSAoNyk6CiAgQVJNOiBkdHM6IEFkZCBkZXZpY2V0cmVlIGZvciBSREE4ODEw
UEwgU29DCiAgQVJNOiBkdHM6IEFkZCBkZXZpY2V0cmVlIGZvciBPcmFuZ2VQaSAyRyBJb1QgYm9h
cmQKICBBUk06IGR0czogQWRkIGRldmljZXRyZWUgZm9yIE9yYW5nZVBpIGk5NiBib2FyZAogIEFS
TTogZHRzOiByZGE4ODEwcGw6IEFkZCB0aW1lciBzdXBwb3J0CiAgQVJNOiBkdHM6IHJkYTg4MTBw
bDogQWRkIGludGVycnVwdCBzdXBwb3J0IGZvciBVQVJUCiAgdHR5OiBzZXJpYWw6IEFkZCBSREE4
ODEwUEwgVUFSVCBkcml2ZXIKICBNQUlOVEFJTkVSUzogQWRkIGVudHJ5IGZvciBSREEgTWljcm8g
U29DIGFyY2hpdGVjdHVyZQoKIC4uLi9hZG1pbi1ndWlkZS9rZXJuZWwtcGFyYW1ldGVycy50eHQg
ICAgICAgICB8ICAgNiArCiBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvYXJtL3Jk
YS50eHQgfCAgMTcgKwogLi4uL2JpbmRpbmdzL3NlcmlhbC9yZGEsODgxMHBsLXVhcnQudHh0ICAg
ICAgIHwgIDE3ICsKIC4uLi9kZXZpY2V0cmVlL2JpbmRpbmdzL3ZlbmRvci1wcmVmaXhlcy50eHQg
ICB8ICAgMSArCiBNQUlOVEFJTkVSUyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
fCAgMTQgKwogYXJjaC9hcm0vS2NvbmZpZyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwg
ICAyICsKIGFyY2gvYXJtL01ha2VmaWxlICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAg
MSArCiBhcmNoL2FybS9ib290L2R0cy9NYWtlZmlsZSAgICAgICAgICAgICAgICAgICAgfCAgIDMg
KwogLi4uL2Jvb3QvZHRzL3JkYTg4MTBwbC1vcmFuZ2VwaS0yZy1pb3QuZHRzICAgIHwgIDUwICsr
CiBhcmNoL2FybS9ib290L2R0cy9yZGE4ODEwcGwtb3JhbmdlcGktaTk2LmR0cyAgfCAgNTAgKysK
IGFyY2gvYXJtL2Jvb3QvZHRzL3JkYTg4MTBwbC5kdHNpICAgICAgICAgICAgICB8ICA5OSArKysK
IGFyY2gvYXJtL21hY2gtcmRhL0tjb25maWcgICAgICAgICAgICAgICAgICAgICB8ICAgOSArCiBh
cmNoL2FybS9tYWNoLXJkYS9NYWtlZmlsZSAgICAgICAgICAgICAgICAgICAgfCAgIDEgKwogZHJp
dmVycy90dHkvc2VyaWFsL0tjb25maWcgICAgICAgICAgICAgICAgICAgIHwgIDE5ICsKIGRyaXZl
cnMvdHR5L3NlcmlhbC9NYWtlZmlsZSAgICAgICAgICAgICAgICAgICB8ICAgMSArCiBkcml2ZXJz
L3R0eS9zZXJpYWwvcmRhLXVhcnQuYyAgICAgICAgICAgICAgICAgfCA4MzEgKysrKysrKysrKysr
KysrKysrCiBpbmNsdWRlL3VhcGkvbGludXgvc2VyaWFsX2NvcmUuaCAgICAgICAgICAgICAgfCAg
IDMgKwogMTcgZmlsZXMgY2hhbmdlZCwgMTEyNCBpbnNlcnRpb25zKCspCiBjcmVhdGUgbW9kZSAx
MDA2NDQgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2FybS9yZGEudHh0CiBjcmVh
dGUgbW9kZSAxMDA2NDQgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NlcmlhbC9y
ZGEsODgxMHBsLXVhcnQudHh0CiBjcmVhdGUgbW9kZSAxMDA2NDQgYXJjaC9hcm0vYm9vdC9kdHMv
cmRhODgxMHBsLW9yYW5nZXBpLTJnLWlvdC5kdHMKIGNyZWF0ZSBtb2RlIDEwMDY0NCBhcmNoL2Fy
bS9ib290L2R0cy9yZGE4ODEwcGwtb3JhbmdlcGktaTk2LmR0cwogY3JlYXRlIG1vZGUgMTAwNjQ0
IGFyY2gvYXJtL2Jvb3QvZHRzL3JkYTg4MTBwbC5kdHNpCiBjcmVhdGUgbW9kZSAxMDA2NDQgYXJj
aC9hcm0vbWFjaC1yZGEvS2NvbmZpZwogY3JlYXRlIG1vZGUgMTAwNjQ0IGFyY2gvYXJtL21hY2gt
cmRhL01ha2VmaWxlCiBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy90dHkvc2VyaWFsL3JkYS11
YXJ0LmMKCi0tIAoyLjE3LjEKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVs
QGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9s
aXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
