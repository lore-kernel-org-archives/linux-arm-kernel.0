Return-Path: <SRS0=fpAU=QP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 040C6C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 11:14:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B39DD21924
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 11:14:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="HBUSMlX2";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="fn9wA+Ji"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B39DD21924
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=verge.net.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=4rQAKlGrRLD6aIxz7aWVsw6J3c90r995ypB0iVy/Qjk=; b=HBUSMlX27Wr2Dn
	z4ZAdi3LIkLOHNP1SkGaEbiPuNOHCLdrGQkAnni3GlkwDc39eAZGmDLnXqh9Y/dcRyzkVt5Sc0BNq
	FMSwT0x+Wf07tv/Iw1axZzSkkVrCekw1rbhfSBhPHdHzlj1c3gUWIRgAQ3F8Dur5fo4DgYD71EcIp
	eUDZK1uXFwGvuNHu8QXsIZ8DF90pFPwz87N+feELBEZi6HL3bb8pyjeuXMmEN5rZSbpNs/9i7glQ7
	75LSWm/P1O88Yv/yECSEHk9trpMIpjrICv/if94YZXJz3/LmJuVJpXVsprn9rhG4pyvNSKM2bRr9i
	4iY7Cs+l+uEhRwnJDsow==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gs46j-0000A4-NQ; Fri, 08 Feb 2019 11:14:09 +0000
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gs45z-0007s7-K6
 for linux-arm-kernel@lists.infradead.org; Fri, 08 Feb 2019 11:13:34 +0000
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
 by kirsty.vergenet.net (Postfix) with ESMTPA id 57B1C25B7CA;
 Fri,  8 Feb 2019 22:13:22 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
 t=1549624402; bh=NIsI7rcLOeCXQs40evx+v+/+vWh2PFyjQnM/qD4zA+4=;
 h=From:To:Cc:Subject:Date:From;
 b=fn9wA+JiqF/K5I+7RPnnP7G2MeRZYN5vxbI4ulSeuHMrjiLdGzoR1Ngi1WyklFYRC
 1ycVjCqnKRgVm8ReRUAOyAwg5xtfoFDeDZDnWJ45zXf5zKNncvC+L2yfJ4mfRv5TI/
 nfl5Pj3focsEbmTO7TTNAHlsMLUl8chgAlLHyO+g=
Received: by reginn.horms.nl (Postfix, from userid 7100)
 id A6EC89401DB; Fri,  8 Feb 2019 12:13:20 +0100 (CET)
From: Simon Horman <horms+renesas@verge.net.au>
To: arm@kernel.org
Subject: [GIT PULL] Second Round of Renesas ARM64 Based SoC DT Updates for v5.1
Date: Fri,  8 Feb 2019 12:13:18 +0100
Message-Id: <cover.1549623801.git.horms+renesas@verge.net.au>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190208_031324_730675_6C4C013A 
X-CRM114-Status: GOOD (  13.46  )
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
Cc: Arnd Bergmann <arnd@arndb.de>, Kevin Hilman <khilman@kernel.org>,
 Magnus Damm <magnus.damm@gmail.com>, linux-renesas-soc@vger.kernel.org,
 Olof Johansson <olof@lixom.net>, Simon Horman <horms+renesas@verge.net.au>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGkgT2xvZiwgSGkgS2V2aW4sIEhpIEFybmQsCgpQbGVhc2UgY29uc2lkZXIgdGhlc2Ugc2Vjb25k
IHJvdW5kIG9mIFJlbmVzYXMgQVJNNjQgYmFzZWQgU29DIERUIHVwZGF0ZXMgZm9yIHY1LjEuCgpU
aGlzIHB1bGwgcmVxdWVzdCBpcyBiYXNlZCBvbiB0aGUgcHJldmlvdXMgcm91bmQgb2YKc3VjaCBy
ZXF1ZXN0cywgdGFnZ2VkIGFzIHJlbmVzYXMtYXJtNjQtZHQtZm9yLXY1LjEsCndoaWNoIHlvdSBo
YXZlIGFscmVhZHkgcHVsbGVkLgoKClRoZSBmb2xsb3dpbmcgY2hhbmdlcyBzaW5jZSBjb21taXQg
M2UyNzlhMWQ0NGQ3M2FlYTljZTQyOGFlNjhlNzZiZjg1MTE3MDMxYToKCiAgYXJtNjQ6IGR0czog
cmVuZXNhczogcjhhNzc5OTA6IGViaXN1OiBFbmFibGUgSFM0MDAgb2YgU0RISTMgKDIwMTktMDEt
MjMgMDk6NDU6NDEgKzAxMDApCgphcmUgYXZhaWxhYmxlIGluIHRoZSBnaXQgcmVwb3NpdG9yeSBh
dDoKCiAgaHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvaG9y
bXMvcmVuZXNhcy5naXQgdGFncy9yZW5lc2FzLWFybTY0LWR0Mi1mb3ItdjUuMQoKZm9yIHlvdSB0
byBmZXRjaCBjaGFuZ2VzIHVwIHRvIGVlMjBhZWVmYjUzZjZmZmFiZWQ1YjFhM2I4NTkyOTQxOTdl
ZWIzNTE6CgogIGFybTY0OiBkdHM6IHJlbmVzYXM6IGNhdDg3NTogRW5hYmxlIFBDSWUgc3VwcG9y
dCAoMjAxOS0wMi0wOCAxMTo0OTowOSArMDEwMCkKCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KU2Vjb25kIFJvdW5kIG9mIFJl
bmVzYXMgQVJNNjQgQmFzZWQgU29DIERUIFVwZGF0ZXMgZm9yIHY1LjEKCiogUi1DYXIgR2VuMyBT
b0MgYmFzZWQgU2FsdmF0b3ItWCwgU2FsdmF0b3ItWFMgYW5kIFVMQ0IgYm9hcmRzCiAgLSBFbmFi
bGUgSFM0MDAgc3VwcG9ydCBmb3IgZU1NQwoKKiBSLUNhciBFMyAocjdhNzc5OTApIFNvQwogIC0g
QWRkIE9QUHMgdGFibGUgZm9yIGNwdSBkZXZpY2VzCgoqIFJaL0cyRSAocjhhNzc0YzApIFNvQwog
IC0gRGVzY3JpYmUgVE1VLCBDTVQsIFNESEkgZGV2aWNlcyBpbiBEVAogIC0gRGVzY3JpYmUgcGlu
Y29udHJvbCBzdXBwb3J0IGZvciBTQ0lGMiBkZXZpY2UgaW4gRFQKICAtIEFkZCBPUFBzIHRhYmxl
IGZvciBjcHUgZGV2aWNlcwoKKiBSWi9HMkUgKHI4YTc3NGMwKSBiYXNlZCBFSzg3NCBib2FyZCBh
bmQgQ0FUODc1IHN1Yi1ib2FyZCwKICBhbmQgQ0FUODc0IGJvYXJkCiAgLSBJbml0aWFsIHN1cHBv
cnQKCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0KQmlqdSBEYXMgKDkpOgogICAgICBhcm02NDogZHRzOiByZW5lc2FzOiBBZGQg
U2ktTGludXggQ0FUODc0IGJvYXJkIHN1cHBvcnQKICAgICAgYXJtNjQ6IGR0czogcmVuZXNhczog
QWRkIFNpLUxpbnV4IEVLODc0IGJvYXJkIHN1cHBvcnQKICAgICAgYXJtNjQ6IGR0czogcmVuZXNh
czogcjhhNzc0YzAtY2F0ODc0OiBBZGQgcGluY29udHJvbCBzdXBwb3J0IHRvIHNjaWYyCiAgICAg
IGFybTY0OiBkdHM6IHJlbmVzYXM6IHI4YTc3NGMwLWNhdDg3NDogQWRkIHVTRCBzdXBwb3J0CiAg
ICAgIGFybTY0OiBkdHM6IHJlbmVzYXM6IGNhdDg3NTogQWRkIGV0aGVybmV0IHN1cHBvcnQKICAg
ICAgYXJtNjQ6IGR0czogcmVuZXNhczogcjhhNzc0YzA6IEFkZCBDTVQgZGV2aWNlIG5vZGVzCiAg
ICAgIGFybTY0OiBkdHM6IHJlbmVzYXM6IHI4YTc3NGMwOiBBZGQgVE1VIGRldmljZSBub2Rlcwog
ICAgICBhcm02NDogZHRzOiByZW5lc2FzOiByOGE3NzRjMC1jYXQ4NzQ6IEFkZCBwY2llYzAgc3Vw
cG9ydAogICAgICBhcm02NDogZHRzOiByZW5lc2FzOiBjYXQ4NzU6IEVuYWJsZSBQQ0llIHN1cHBv
cnQKCkZhYnJpemlvIENhc3RybyAoMSk6CiAgICAgIGFybTY0OiBkdHM6IHJlbmVzYXM6IHI4YTc3
NGMwOiBBZGQgT1BQcyB0YWJsZSBmb3IgY3B1IGRldmljZXMKCk5pa2xhcyBTw7ZkZXJsdW5kICgx
KToKICAgICAgYXJtNjQ6IGR0czogcmVuZXNhczogZW5hYmxlIEhTNDAwIG9uIFItQ2FyIEdlbjMK
ClRha2VzaGkgS2loYXJhICgxKToKICAgICAgYXJtNjQ6IGR0czogcmVuZXNhczogcjhhNzc5OTA6
IEFkZCBPUFBzIHRhYmxlIGZvciBjcHUgZGV2aWNlcwoKIGFyY2gvYXJtNjQvYm9vdC9kdHMvcmVu
ZXNhcy9NYWtlZmlsZSAgICAgICAgICAgICB8ICAgMSArCiBhcmNoL2FybTY0L2Jvb3QvZHRzL3Jl
bmVzYXMvY2F0ODc1LmR0c2kgICAgICAgICAgfCAgNDQgKysrKysrKwogYXJjaC9hcm02NC9ib290
L2R0cy9yZW5lc2FzL3I4YTc3NGMwLWNhdDg3NC5kdHMgIHwgMTA2ICsrKysrKysrKysrKysrKwog
YXJjaC9hcm02NC9ib290L2R0cy9yZW5lc2FzL3I4YTc3NGMwLWVrODc0LmR0cyAgIHwgIDE0ICsr
CiBhcmNoL2FybTY0L2Jvb3QvZHRzL3JlbmVzYXMvcjhhNzc0YzAuZHRzaSAgICAgICAgfCAxNjAg
KysrKysrKysrKysrKysrKysrKysrKysKIGFyY2gvYXJtNjQvYm9vdC9kdHMvcmVuZXNhcy9yOGE3
Nzk5MC5kdHNpICAgICAgICB8ICAyNSArKysrCiBhcmNoL2FybTY0L2Jvb3QvZHRzL3JlbmVzYXMv
c2FsdmF0b3ItY29tbW9uLmR0c2kgfCAgIDEgKwogYXJjaC9hcm02NC9ib290L2R0cy9yZW5lc2Fz
L3VsY2IuZHRzaSAgICAgICAgICAgIHwgICAxICsKIDggZmlsZXMgY2hhbmdlZCwgMzUyIGluc2Vy
dGlvbnMoKykKIGNyZWF0ZSBtb2RlIDEwMDY0NCBhcmNoL2FybTY0L2Jvb3QvZHRzL3JlbmVzYXMv
Y2F0ODc1LmR0c2kKIGNyZWF0ZSBtb2RlIDEwMDY0NCBhcmNoL2FybTY0L2Jvb3QvZHRzL3JlbmVz
YXMvcjhhNzc0YzAtY2F0ODc0LmR0cwogY3JlYXRlIG1vZGUgMTAwNjQ0IGFyY2gvYXJtNjQvYm9v
dC9kdHMvcmVuZXNhcy9yOGE3NzRjMC1lazg3NC5kdHMKCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0Cmxp
bnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFk
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
