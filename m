Return-Path: <SRS0=5Xh4=OS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13A67C65BAF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 11:50:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3FED20661
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 11:50:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="n6mt4Qz9";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="finkDwW4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3FED20661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=dnl4vR9hPXpvHoSMntjd63sAxVJjiJypuQXxHXAuu1A=; b=n6mt4Qz9k1LWJ2
	KgBfR0pnRknZlqtEXhjf28pv3iiqsRErkHJ7NdrkaDyaw10eMVSL8X8JDhuSqDrYi4w4Hw+wqfNf9
	YuBsO9wdGc8QtLRCekudYKlCeNTVXaVO52Z7ES6Z4xIt4gwh0BJLh/zgQ7BYcHpWHpZIavNbGNch4
	1iUwJrBeuMAE7YCvQNgtmwPDuSYoHhN8ijTkrCZYmh9tzM2rp3FTwadAgfI8/GD2k/UR27HlVdWq+
	1myqc4KvdIAlF7jjtcrX4Asw7tVKNtqFaREPMTqnp/L0oWW4OqHHndM9uKXkH8dg2aYffw3i7i14O
	akYTxCAKAFFsBlD+YUEA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVxbc-0004zX-B8; Sun, 09 Dec 2018 11:50:40 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVxab-0002o4-As
 for linux-arm-kernel@lists.infradead.org; Sun, 09 Dec 2018 11:49:40 +0000
Received: from localhost.localdomain (unknown [178.38.170.116])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id F28F120867;
 Sun,  9 Dec 2018 11:49:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1544356164;
 bh=KXMCjPkFHLUQxUDv8jaVk1A7Z06zBBDxTTQsMCVSz4E=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=finkDwW4JAkOSg3ZLPhLTgeqW5IkVV+g3G+uEcpvLX5XwAYKb+kbcQW4fjvdrwArG
 TUR8+GQOTJdd3fZfCIGXO+Kj4Q3ReETihvaexHRtnwT2jFfS1BX4HqDyiY9aso+q+h
 i2twkYy1x+6Wmyah1QKErqi760/r6jiVlEp7LRSY=
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
 arm@kernel.org
Subject: [GIT PULL 2/4] ARM: dts: exynos: Pull for v4.21
Date: Sun,  9 Dec 2018 12:49:09 +0100
Message-Id: <20181209114911.25194-3-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181209114911.25194-1-krzk@kernel.org>
References: <20181209114911.25194-1-krzk@kernel.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181209_034937_493189_37C47B97 
X-CRM114-Status: GOOD (  14.96  )
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
Cc: linux-samsung-soc@vger.kernel.org, Kukjin Kim <kgene@kernel.org>,
 linux-arm-kernel@lists.infradead.org, Krzysztof Kozlowski <krzk@kernel.org>,
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

VGhlIGZvbGxvd2luZyBjaGFuZ2VzIHNpbmNlIGNvbW1pdCA2NTEwMjIzODJjN2Y4ZGE0NmNiNDg3
MmE1NDVlZTFkYTZkMDk3ZDJhOgoKICBMaW51eCA0LjIwLXJjMSAoMjAxOC0xMS0wNCAxNTozNzo1
MiAtMDgwMCkKCmFyZSBhdmFpbGFibGUgaW4gdGhlIEdpdCByZXBvc2l0b3J5IGF0OgoKICBodHRw
czovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC9rcnprL2xpbnV4Lmdp
dCB0YWdzL3NhbXN1bmctZHQtNC4yMQoKZm9yIHlvdSB0byBmZXRjaCBjaGFuZ2VzIHVwIHRvIDU3
YjEzYjhiMzQwMDJjZThmMWQ4MjJlYTA1ZjBhODRlNWJjM2E2NGE6CgogIEFSTTogZHRzOiBleHlu
b3M6IHJlbW92ZSBkaXNwbGF5LXBvcnQgbm9kZSBmcm9tIEFybmRhbGUgKDIwMTgtMTItMDYgMTk6
NDc6MTUgKzAxMDApCgotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tClNhbXN1bmcgRFRTIEFSTSBjaGFuZ2VzIGZvciB2NC4yMQoK
MS4gQWRkIG1pc3NpbmcgcHJvcGVydGllcyBhbmQgbm9kZXMgZm9yIFBNSUMgY2xvY2tzIGluIG11
bHRpcGxlIERUUwogICBmaWxlcy4KMi4gQWRkIFVIUy1JIGJ1cyBzcGVlZCBzdXBwb3J0IHRvIE9k
cm9pZCBYVTMvWFU0L0hDIFNEIGNhcmQgYW5kIGJ1bXAgdGhlCiAgIG1heGltdW0gY2xvY2sgZnJl
cXVlbmN5IHRvIDIwMCBNSHogZm9yIFNEIGFuZCBlTU1DLgozLiBVcGRhdGUgY29vbGluZyBtYXBz
IHRvIGluY2x1ZGUgYWxsIENQVSBkZXZpY2VzIGluIG11bHRpcGxlIERUUyBmaWxlcy4KNC4gRW5h
YmxlIHF1aXJrcyBmb3IgRXh5bm9zMzI1MCBEV0MuCjUuIEFkZCBKUEVHIENPREVDIG5vZGUgdG8g
UzVQdjIxMC4KNi4gQWRkIG9wcC1zdXNwZW5kIHRvIGRldmZyZXEgT1BQcyBvbiBFeHlub3M0IGJv
YXJkcyB0byBmaXggcmVzdW1pbmcKICAgZnJvbSBzdXNwZW5kIHRvIFJBTS4KNy4gUmVtb3ZlIGVE
UCBmcm9tIEFybmRhbGUgYm9hcmQgYXMgaXQgZG9lcyBub3Qgd29yayBhbmQgYnJlYWtzIGFsc28K
ICAgRFNJLgoKLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLQpBbmFuZCBNb29uICg1KToKICAgICAgQVJNOiBkdHM6IGV4eW5vczog
QWRkIFVIUy1JIGJ1cyBzcGVlZCBzdXBwb3J0IHRvIE9kcm9pZCBYVTMvWFU0L0hDMQogICAgICBB
Uk06IGR0czogZXh5bm9zOiBGaXggTERPMTMgbWluIHZhbHVlcyBvbiBPZHJvaWQgWFUzL1hVNC9I
QzEKICAgICAgQVJNOiBkdHM6IGV4eW5vczogVXBkYXRlIG1heGltdW0gZnJlcXVlbmN5IGZvciBT
RCBjYXJkIHRvIDIwME1IeiBvbiBPZHJvaWQgWFUzL1hVNC9IQzEKICAgICAgQVJNOiBkdHM6IGV4
eW5vczogVXBkYXRlIG1heGltdW0gZnJlcXVlbmN5IGZvciBlTU1DIHRvIDIwME1IeiBvbiBPZHJv
aWQgWFUzL1hVNAogICAgICBBUk06IGR0czogZXh5bm9zOiBBZGQgcGluIGNvbmZpZ3VyYXRpb24g
Zm9yIFNEIHdyaXRlIHByb3RlY3Qgb24gT2Ryb2lkIFhVMy9YVTQvSEMxCgpBbmRyemVqIEhhamRh
ICgxKToKICAgICAgQVJNOiBkdHM6IGV4eW5vczogcmVtb3ZlIGRpc3BsYXktcG9ydCBub2RlIGZy
b20gQXJuZGFsZQoKS3J6eXN6dG9mIEtvemxvd3NraSAoMyk6CiAgICAgIEFSTTogZHRzOiBleHlu
b3M6IEFkZCBjb21wYXRpYmxlIGZvciBzMm1wczExIGNsb2NrcyBub2RlIG9uIEV4eW5vczU0MngK
ICAgICAgQVJNOiBkdHM6IGV4eW5vczogQWRkIGNvbXBhdGlibGUgZm9yIHM1bTg3NjcgY2xvY2tz
IG5vZGUgb24gSXRvcCBDb3JlCiAgICAgIEFSTTogZHRzOiBleHlub3M6IENsYXJpZnkgY29tbWVu
dCBleHBsYWluaW5nIHB1cnBvc2Ugb2YgT2Ryb2lkIFhVMyBEVFNJCgpMdWthc3ogTHViYSAoMSk6
CiAgICAgIEFSTTogZHRzOiBleHlub3M6IEFkZCBvcHAtc3VzcGVuZCB0byBETUMgYW5kIGxlZnRi
dXMgZGV2ZnJlcSBPUFBzIG9uIEV4eW5vczQKCk1hcmVrIFN6eXByb3dza2kgKDIpOgogICAgICBB
Uk06IGR0czogZXh5bm9zOiBBZGQgbWlzc2luZyBjbG9ja3MgdG8gUlRDIG5vZGUgZm9yIEFybmRh
bGUgYm9hcmQKICAgICAgQVJNOiBkdHM6IGV4eW5vczogVXNlIFNhbXN1bmcgU29DIHNwZWNpZmlj
IGNvbXBhdGlibGUgZm9yIERXQzIgbW9kdWxlCgpQYXdlxYIgQ2htaWVsICgxKToKICAgICAgQVJN
OiBkdHM6IHM1cHYyMTA6IEFkZCBzNXAtanBlZyBjb2RlYyBub2RlLgoKVmlyZXNoIEt1bWFyICgx
KToKICAgICAgQVJNOiBkdHM6IGV4eW5vczogQWRkIGFsbCBDUFVzIGluIGNvb2xpbmcgbWFwcwoK
IGFyY2gvYXJtL2Jvb3QvZHRzL2V4eW5vczMyNTAtYXJ0aWs1LmR0c2kgICAgICAgICAgIHwgICA2
ICstCiBhcmNoL2FybS9ib290L2R0cy9leHlub3MzMjUwLW1vbmsuZHRzICAgICAgICAgICAgICB8
ICAgNiArLQogYXJjaC9hcm0vYm9vdC9kdHMvZXh5bm9zMzI1MC1yaW5hdG8uZHRzICAgICAgICAg
ICAgfCAgIDYgKy0KIGFyY2gvYXJtL2Jvb3QvZHRzL2V4eW5vczMyNTAuZHRzaSAgICAgICAgICAg
ICAgICAgIHwgICAyICstCiBhcmNoL2FybS9ib290L2R0cy9leHlub3M0MjEwLXRyYXRzLmR0cyAg
ICAgICAgICAgICB8ICAgNCArLQogYXJjaC9hcm0vYm9vdC9kdHMvZXh5bm9zNDIxMC5kdHNpICAg
ICAgICAgICAgICAgICAgfCAgIDQgKy0KIGFyY2gvYXJtL2Jvb3QvZHRzL2V4eW5vczQ0MTItaXRv
cC1zY3AtY29yZS5kdHNpICAgIHwgICA5ICstCiBhcmNoL2FybS9ib290L2R0cy9leHlub3M0NDEy
LW1pZGFzLmR0c2kgICAgICAgICAgICB8ICAgOCArLQogYXJjaC9hcm0vYm9vdC9kdHMvZXh5bm9z
NDQxMi1vZHJvaWQtY29tbW9uLmR0c2kgICAgfCAgIDggKy0KIGFyY2gvYXJtL2Jvb3QvZHRzL2V4
eW5vczQ0MTItb2Ryb2lkdTMuZHRzICAgICAgICAgIHwgIDE4ICsrLS0KIGFyY2gvYXJtL2Jvb3Qv
ZHRzL2V4eW5vczQ0MTIuZHRzaSAgICAgICAgICAgICAgICAgIHwgICA4ICstCiBhcmNoL2FybS9i
b290L2R0cy9leHlub3M1MjUwLWFybmRhbGUuZHRzICAgICAgICAgICB8ICAzNCArKy0tLS0tCiBh
cmNoL2FybS9ib290L2R0cy9leHlub3M1MjUwLmR0c2kgICAgICAgICAgICAgICAgICB8ICAgNyAr
LQogYXJjaC9hcm0vYm9vdC9kdHMvZXh5bm9zNTQyMC1hcm5kYWxlLW9jdGEuZHRzICAgICAgfCAg
IDEgKwogYXJjaC9hcm0vYm9vdC9kdHMvZXh5bm9zNTQyMC1waW5jdHJsLmR0c2kgICAgICAgICAg
fCAgIDcgKysKIGFyY2gvYXJtL2Jvb3QvZHRzL2V4eW5vczU0MjAtc21kazU0MjAuZHRzICAgICAg
ICAgIHwgICAxICsKIGFyY2gvYXJtL2Jvb3QvZHRzL2V4eW5vczU0MjItb2Ryb2lkLWNvcmUuZHRz
aSAgICAgIHwgIDExICsrLQogYXJjaC9hcm0vYm9vdC9kdHMvZXh5bm9zNTQyMi1vZHJvaWRoYzEu
ZHRzICAgICAgICAgfCAxMDYgKysrKysrKysrKysrLS0tLS0tLS0KIGFyY2gvYXJtL2Jvb3QvZHRz
L2V4eW5vczU0MjItb2Ryb2lkeHUzLWNvbW1vbi5kdHNpIHwgMTA5ICsrKysrKysrKysrKystLS0t
LS0tLQogYXJjaC9hcm0vYm9vdC9kdHMvczVwdjIxMC5kdHNpICAgICAgICAgICAgICAgICAgICAg
fCAgIDkgKysKIDIwIGZpbGVzIGNoYW5nZWQsIDIyMSBpbnNlcnRpb25zKCspLCAxNDMgZGVsZXRp
b25zKC0pCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwps
aW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJh
ZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51
eC1hcm0ta2VybmVsCg==
