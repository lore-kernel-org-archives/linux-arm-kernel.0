Return-Path: <SRS0=JyYb=QI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC40CC282DA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 11:22:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B9CB21904
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 11:22:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LxrHhEsG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B9CB21904
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=MgjTDh7IrTzI0hmVcutFZ2z3Vj81gaCKVMVN4BRH8fw=; b=LxrHhEsGzOlfPy
	ye6eH3jBEwsmxFjsiyJes/QgdwVvQeDkkLNDkrnONobKOunfLnNnD5prAI6M77kEmvmtZBWpN2jUr
	5hlRQfelnld6i1hKXedVt+B1aVJxYSZFG8I3aJG0uOzqkm2XOIaVupDz44ZnwBZr2Z5F7NNkRr86c
	vJZRfzOtMDMkuAu6JTXbVqQdAADjVaKR9VWfoSCPU1i8Ha5r4zyjfql0X4iv4bdypDSDkjTn1G73J
	PSc2Of4xUoLwP+SYqCRdC4+YjDRsNtE8eCFupboUEjF0XpO8o/AjD8pLZbkIhz58kV2mwazS/zkXY
	f+MGcJ+Q5KOcUaaNKZMA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpWu3-0005CB-Sg; Fri, 01 Feb 2019 11:22:35 +0000
Received: from mailgw01.mediatek.com ([216.200.240.184])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpWto-0004wG-Mq; Fri, 01 Feb 2019 11:22:22 +0000
X-UUID: b52ee55da2504a99aa2853af3d57be29-20190201
X-UUID: b52ee55da2504a99aa2853af3d57be29-20190201
Received: from mtkcas66.mediatek.inc [(172.29.193.44)] by mailgw01.mediatek.com
 (envelope-from <frederic.chen@mediatek.com>)
 (musrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 1082348845; Fri, 01 Feb 2019 03:22:17 -0800
Received: from MTKMBS01N2.mediatek.inc (172.21.101.79) by
 MTKMBS62N1.mediatek.inc (172.29.193.41) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 1 Feb 2019 03:22:15 -0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 1 Feb 2019 19:22:01 +0800
Received: from mtkslt306.mediatek.inc (10.21.14.136) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via
 Frontend Transport; Fri, 1 Feb 2019 19:22:01 +0800
From: Frederic Chen <frederic.chen@mediatek.com>
To: <hans.verkuil@cisco.com>, <laurent.pinchart+renesas@ideasonboard.com>,
 <tfiga@chromium.org>, <matthias.bgg@gmail.com>, <mchehab@kernel.org>
Subject: [RFC PATCH V0 4/7] [media] dt-bindings: mt8183: Added DIP dt-bindings
Date: Fri, 1 Feb 2019 19:21:28 +0800
Message-ID: <1549020091-42064-5-git-send-email-frederic.chen@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1549020091-42064-1-git-send-email-frederic.chen@mediatek.com>
References: <1549020091-42064-1-git-send-email-frederic.chen@mediatek.com>
MIME-Version: 1.0
X-TM-SNTS-SMTP: 18C74CA7A39999E4FCECA10D172320C41F10C77B23289B10E84C14A4714016962000:8
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190201_032220_745229_84F1CEA6 
X-CRM114-Status: UNSURE (   9.02  )
X-CRM114-Notice: Please train this message.
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
Cc: Sean.Cheng@mediatek.com, Rynn.Wu@mediatek.com, srv_heupstream@mediatek.com,
 holmes.chiou@mediatek.com, Jerry-ch.Chen@mediatek.com, jungo.lin@mediatek.com,
 sj.huang@mediatek.com, christie.yu@mediatek.com,
 linux-mediatek@lists.infradead.org, frederic.chen@mediatek.com,
 linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

VGhpcyBwYXRjaCBhZGRzIERUIGJpbmRpbmcgZG9jdW1lbnRhdGlvbiBmb3IgdGhlIERpZ2l0YWwg
SW1hZ2UKUHJvY2Vzc2luZyAoRElQKSB1bml0IG9mIGNhbWVyYSBJU1Agc3lzdGVtIG9uIE1lZGlh
dGVr4oCZcyBTb0NzLgoKU2lnbmVkLW9mZi1ieTogRnJlZGVyaWMgQ2hlbiA8ZnJlZGVyaWMuY2hl
bkBtZWRpYXRlay5jb20+Ci0tLQogLi4uL2JpbmRpbmdzL21lZGlhL21lZGlhdGVrLG10ODE4My1k
aXAudHh0ICAgICAgICAgfCAzNSArKysrKysrKysrKysrKysrKysrKysrCiAxIGZpbGUgY2hhbmdl
ZCwgMzUgaW5zZXJ0aW9ucygrKQogY3JlYXRlIG1vZGUgMTAwNjQ0IERvY3VtZW50YXRpb24vZGV2
aWNldHJlZS9iaW5kaW5ncy9tZWRpYS9tZWRpYXRlayxtdDgxODMtZGlwLnR4dAoKZGlmZiAtLWdp
dCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tZWRpYS9tZWRpYXRlayxtdDgx
ODMtZGlwLnR4dCBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tZWRpYS9tZWRp
YXRlayxtdDgxODMtZGlwLnR4dApuZXcgZmlsZSBtb2RlIDEwMDY0NAppbmRleCAwMDAwMDAwLi4w
ZTE5OTRiCi0tLSAvZGV2L251bGwKKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRp
bmdzL21lZGlhL21lZGlhdGVrLG10ODE4My1kaXAudHh0CkBAIC0wLDAgKzEsMzUgQEAKKyogTWVk
aWF0ZWsgRGlnaXRhbCBJbWFnZSBQcm9jZXNzb3IgKERJUCkKKworRGlnaXRhbCBJbWFnZSBQcm9j
ZXNzb3IgKERJUCkgdW5pdCBpbiBNZWRpYXRlayBJU1Agc3lzdGVtIGlzIHJlc3BvbnNpYmxlIGZv
cgoraW1hZ2UgY29udGVudCBhZGp1c3RtZW50IGFjY29yZGluZyB0byB0aGUgdHVuaW5nIHBhcmFt
ZXRlcnMuIERJUCBjYW4gcHJvY2VzcwordGhlIGltYWdlIGZvcm0gbWVtb3J5IGJ1ZmZlciBhbmQg
b3V0cHV0IHRoZSBwcm9jZXNzZWQgaW1hZ2UgdG8gbXVsdGlwbGUgb3V0cHV0CitidWZmZXJzLiBG
dXJ0aGVybW9yZSwgaXQgY2FuIHN1cHBvcnQgZGVtb3NhaWNpbmcgYW5kIG5vaXNlIHJlZHVjdGlv
biBvbiB0aGUKK2ltYWdlcy4KKworUmVxdWlyZWQgcHJvcGVydGllczoKKy0gY29tcGF0aWJsZTog
Im1lZGlhdGVrLG10ODE4My1kaXAiCistIHJlZzogUGh5c2ljYWwgYmFzZSBhZGRyZXNzIGFuZCBs
ZW5ndGggb2YgdGhlIGZ1bmN0aW9uIGJsb2NrIHJlZ2lzdGVyIHNwYWNlCistIGludGVycnVwdHM6
IGludGVycnVwdCBudW1iZXIgdG8gdGhlIGNwdQorLSBpb21tdXM6IHNob3VsZCBwb2ludCB0byB0
aGUgcmVzcGVjdGl2ZSBJT01NVSBibG9jayB3aXRoIG1hc3RlciBwb3J0IGFzCisgIGFyZ3VtZW50
LCBzZWUgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2lvbW11L21lZGlhdGVrLGlv
bW11LnR4dAorICBmb3IgZGV0YWlscy4KKy0gbWVkaWF0ZWssbGFyYjogbXVzdCBjb250YWluIHRo
ZSBsb2NhbCBhcmJpdGVycyBpbiB0aGUgY3VycmVudCBTb2NzLCBzZWUKKyAgRG9jdW1lbnRhdGlv
bi9kZXZpY2V0cmVlL2JpbmRpbmdzL21lbW9yeS1jb250cm9sbGVycy9tZWRpYXRlayxzbWktbGFy
Yi50eHQKKyAgZm9yIGRldGFpbHMuCistIGNsb2NrczogbXVzdCBjb250YWluIHRoZSBsb2NhbCBh
cmJpdGVycyA1IChMQVJCNSkgYW5kIERJUCBjbG9jaworLSBjbG9jay1uYW1lczogbXVzdCBjb250
YWluIERJUF9DR19JTUdfTEFSQjUgYW5kIERJUF9DR19JTUdfRElQCisKK0V4YW1wbGU6CisJZGlw
OiBkaXBAMTUwMjIwMDAgeworCQljb21wYXRpYmxlID0gIm1lZGlhdGVrLG10ODE4My1kaXAiOwor
CQltZWRpYXRlayxsYXJiID0gPCZsYXJiNT47CisJCW1lZGlhdGVrLG1kcDMgPSA8Jm1kcF9yZG1h
MD47CisJCW1lZGlhdGVrLHZwdSA9IDwmdnB1PjsKKwkJaW9tbXVzID0gPCZpb21tdSBNNFVfUE9S
VF9DQU1fSU1HST47CisJCXJlZyA9IDwwIDB4MTUwMjIwMDAgMCAweDYwMDA+OworCQlpbnRlcnJ1
cHRzID0gPEdJQ19TUEkgMjY4IElSUV9UWVBFX0xFVkVMX0xPVz47CisJCWNsb2NrcyA9IDwmaW1n
c3lzIENMS19JTUdfTEFSQjU+LAorCQkJIDwmaW1nc3lzIENMS19JTUdfRElQPjsKKwkJY2xvY2st
bmFtZXMgPSAiRElQX0NHX0lNR19MQVJCNSIsCisJCQkgICAgICAiRElQX0NHX0lNR19ESVAiOwor
CX07Ci0tIAoxLjkuMQoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlz
dHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2xpbnV4LWFybS1rZXJuZWwK
