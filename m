Return-Path: <SRS0=fRgi=OV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FA7DC65BAF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 15:41:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E901D20839
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 15:41:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="arkvp0jT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E901D20839
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Subject:In-Reply-To:
	Message-ID:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
	List-Owner; bh=2d+lbo9ZJP+W0pJ3tNYDVgju/ii/B/ue4B8pLBFxXbg=; b=arkvp0jTJC51cb
	6/Jp54Q3cAwisLVHH/6oykG/Zex3m21WlwoQKpRxaZ6D31mvsGd8hdB/wgUDGN/vrtQyhy1KJAPTL
	FTyxJ4nDeOxVkrLhmHJgoxeTtXFColxa9FCwDCj95PjgsH0iyie34uEw+8E43dM0iOdmaKxVGmOtZ
	ArzJ96yzfgjzToPcs/YyQYTzrih0k7I1gM5Q4k39JOotCTbgTM/Yvuef5Z0uSJsaIHNypBMKKFUJc
	nod/NZGuDrIsFdWATD2AM2f0RNj42l+ELUceM6y47aPk0po3ULDQHxG0WDXEz4ChEI8IV5kitwOAF
	/jMLphzMHESUX4cX3dFQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gX6e6-0007d1-0x; Wed, 12 Dec 2018 15:41:58 +0000
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gX6e1-0007cR-Sn
 for linux-arm-kernel@lists.infradead.org; Wed, 12 Dec 2018 15:41:55 +0000
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id BB3275F789;
 Wed, 12 Dec 2018 15:41:42 +0000 (UTC)
Received: from colo-mx.corp.redhat.com
 (colo-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.21])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id ACC685D70A;
 Wed, 12 Dec 2018 15:41:42 +0000 (UTC)
Received: from zmail17.collab.prod.int.phx2.redhat.com
 (zmail17.collab.prod.int.phx2.redhat.com [10.5.83.19])
 by colo-mx.corp.redhat.com (Postfix) with ESMTP id 4E6933F600;
 Wed, 12 Dec 2018 15:41:42 +0000 (UTC)
Date: Wed, 12 Dec 2018 10:41:42 -0500 (EST)
From: Jan Stancek <jstancek@redhat.com>
To: linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org
Message-ID: <1125108393.85764095.1544629302243.JavaMail.zimbra@redhat.com>
In-Reply-To: <769820788.85756226.1544627443438.JavaMail.zimbra@redhat.com>
Subject: [bug?] poor migrate_pages() performance on arm64
MIME-Version: 1.0
X-Originating-IP: [10.43.17.9, 10.4.195.18]
Thread-Topic: poor migrate_pages() performance on arm64
Thread-Index: /nLhWS5SrKLu8uvlNg0YQHAVAFqb3Q==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.39]); Wed, 12 Dec 2018 15:41:42 +0000 (UTC)
X-Bad-Reply: In-Reply-To but no 'Re:' in Subject.
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181212_074153_974333_F7163C72 
X-CRM114-Status: UNSURE (   9.76  )
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
Cc: jstancek@redhat.com, "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGksCgpJJ20gb2JzZXJ2aW5nIG1pZ3JhdGVfcGFnZXMoKSB0YWtpbmcgcXVpdGUgbG9uZyB0aW1l
IG9uIGFybTY0CnN5c3RlbSAoSHVhd2VpIFRhaVNoYW4gMjI4MCwgNCBub2RlcywgNjQgQ1BVcyku
IEknbSB1c2luZyA0LjIwLjAtcmM2LApidXQgaXQncyByZXByb2R1Y2libGUgd2l0aCBvbGRlciBr
ZXJuZWxzICg0LjE0KSBhcyB3ZWxsLgoKVGhlIHRlc3QgKHNlZSBbMV0gYmVsb3cpLCBpcyBhIHRy
aXZpYWwgQyBhcHBsaWNhdGlvbiwgdGhhdCBtaWdyYXRlcwpjdXJyZW50IHByb2Nlc3MgZnJvbSBv
bmUgbm9kZSB0byBhbm90aGVyLiBNb3JlIGNvbXBsaWNhdGVkIGV4YW1wbGUKaXMgYWxzbyBMVFAn
cyBtaWdyYXRlX3BhZ2VzMDMsIHdoZXJlIHRoaXMgaGFzIGJlZW4gb3JpZ2luYWxseSByZXBvcnRl
ZC4KCkl0IHRha2VzIDIrIHNlY29uZHMgdG8gbWlncmF0ZSBwcm9jZXNzIGZyb20gb25lIG5vZGUg
dG8gYW5vdGhlcjoKICAjIHN0cmFjZSAtZiAtdCAtVCAuL2Eub3V0CiAgLi4uCiAgW3BpZCAxMzc1
NF0gMTA6MTc6MTMgbWlncmF0ZV9wYWdlcygwLCA4LCBbMHgwMDAwMDAwMDAwMDAwMDAyXSwgWzB4
MDAwMDAwMDAwMDAwMDAwMV0pID0gMSA8MC4wNTgxMTU+CiAgW3BpZCAxMzc1NF0gMTA6MTc6MTMg
bWlncmF0ZV9wYWdlcygwLCA4LCBbMHgwMDAwMDAwMDAwMDAwMDAxXSwgWzB4MDAwMDAwMDAwMDAw
MDAwMl0pID0gMTIgPDIuMzQ4MTg2PgogIFtwaWQgMTM3NTRdIDEwOjE3OjE2IG1pZ3JhdGVfcGFn
ZXMoMCwgOCwgWzB4MDAwMDAwMDAwMDAwMDAwMl0sIFsweDAwMDAwMDAwMDAwMDAwMDFdKSA9IDEg
PDAuMDU3ODg5PgogIFtwaWQgMTM3NTRdIDEwOjE3OjE2IG1pZ3JhdGVfcGFnZXMoMCwgOCwgWzB4
MDAwMDAwMDAwMDAwMDAwMV0sIFsweDAwMDAwMDAwMDAwMDAwMDJdKSA9IDEwIDwyLjE5NDg5MD4K
ICAuLi4KClRoaXMgc2NhbGVzIHdpdGggbnVtYmVyIG9mIGNoaWxkcmVuLiBGb3IgZXhhbXBsZSB3
aXRoIE1BWENISUxEIDEwMDAsCml0IHRha2VzIH4zMyBzZWNvbmRzOgogICMgc3RyYWNlIC1mIC10
IC1UIC4vYS5vdXQKICAuLi4KICBbcGlkIDEzNzczXSAxMDoxNzo1NSBtaWdyYXRlX3BhZ2VzKDAs
IDgsIFsweDAwMDAwMDAwMDAwMDAwMDFdLCBbMHgwMDAwMDAwMDAwMDAwMDAyXSkgPSAxMSA8MzMu
NjE1NTUwPgogIFtwaWQgMTM3NzNdIDEwOjE4OjI5IG1pZ3JhdGVfcGFnZXMoMCwgOCwgWzB4MDAw
MDAwMDAwMDAwMDAwMl0sIFsweDAwMDAwMDAwMDAwMDAwMDFdKSA9IDIgPDUuNDYwMjcwPgogIC4u
LgoKSXQgYXBwZWFycyB0byBiZSByZWxhdGVkIHRvIG1pZ3JhdGlvbiBvZiBzaGFyZWQgcGFnZXMs
IHByZXN1bWFibHkKZXhlY3V0YWJsZSBjb2RlIG9mIGdsaWJjLgoKSWYgSSBydW4gWzFdIHdpdGhv
dXQgQ0FQX1NZU19OSUNFLCBpdCBjb21wbGV0ZXMgdmVyeSBxdWlja2x5OgogICMgc3VkbyAtdSBu
b2JvZHkgc3RyYWNlIC1mIC10IC1UIC4vYS5vdXQKICAuLi4KICBbcGlkIDE0ODQ3XSAxMDoyNDo1
NyBtaWdyYXRlX3BhZ2VzKDAsIDgsIFsweDAwMDAwMDAwMDAwMDAwMDFdLCBbMHgwMDAwMDAwMDAw
MDAwMDAyXSkgPSAwIDwwLjAwMDE3Mj4KICBbcGlkIDE0ODQ3XSAxMDoyNDo1NyBtaWdyYXRlX3Bh
Z2VzKDAsIDgsIFsweDAwMDAwMDAwMDAwMDAwMDJdLCBbMHgwMDAwMDAwMDAwMDAwMDAxXSkgPSAw
IDwwLjAwMDA5MT4KICBbcGlkIDE0ODQ3XSAxMDoyNDo1NyBtaWdyYXRlX3BhZ2VzKDAsIDgsIFsw
eDAwMDAwMDAwMDAwMDAwMDFdLCBbMHgwMDAwMDAwMDAwMDAwMDAyXSkgPSAwIDwwLjAwMDA3ND4K
ICBbcGlkIDE0ODQ3XSAxMDoyNDo1NyBtaWdyYXRlX3BhZ2VzKDAsIDgsIFsweDAwMDAwMDAwMDAw
MDAwMDJdLCBbMHgwMDAwMDAwMDAwMDAwMDAxXSkgPSAwIDwwLjAwMDA2OT4KICAuLi4KCgpMb29r
aW5nIGF0IHBlcmYsIG1vc3Qgb2YgdGltZSBpcyBzcGVudCBpbnZhbGlkYXRpbmcgaWNhY2hlLgoK
LSAgMTAwLjAwJSAgICAgMC4wMCUgIGEub3V0ICAgIFtrZXJuZWwua2FsbHN5bXNdICBba10gX19z
eXNfdHJhY2VfcmV0dXJuCiAgIC0gX19zeXNfdHJhY2VfcmV0dXJuCiAgICAgIC0gMTAwLjAwJSBf
X3NlX3N5c19taWdyYXRlX3BhZ2VzCiAgICAgICAgICAgZG9fbWlncmF0ZV9wYWdlcy5wYXJ0LjkK
ICAgICAgICAgLSBtaWdyYXRlX3BhZ2VzCiAgICAgICAgICAgIC0gOTkuOTIlIHJtYXBfd2Fsawog
ICAgICAgICAgICAgICAtIDk5LjkyJSBybWFwX3dhbGtfZmlsZQogICAgICAgICAgICAgICAgICAt
IDk5LjkwJSByZW1vdmVfbWlncmF0aW9uX3B0ZQogICAgICAgICAgICAgICAgICAgICAtIDk5Ljg1
JSBfX3N5bmNfaWNhY2hlX2RjYWNoZQogICAgICAgICAgICAgICAgICAgICAgICAgIF9fZmx1c2hf
Y2FjaGVfdXNlcl9yYW5nZQoKUGVyY2VudOKUgiAgICAgIG5vcAogICAgICAg4pSCICAgICAgdWJm
eCAgIHgzLCB4MywgIzE2LCAjNAogICAgICAg4pSCICAgICAgbW92ICAgIHgyLCAjMHg0ICAgICAg
ICAgICAgICAgICAgICAgICAgLy8gIzQKICAgICAgIOKUgiAgICAgIGxzbCAgICB4MiwgeDIsIHgz
CiAgICAgICDilIIgICAgICBzdWIgICAgeDMsIHgyLCAjMHgxCiAgICAgICDilIIgICAgICBiaWMg
ICAgeDQsIHgwLCB4MwogIDEuODIg4pSCICAgICAgZGMgICAgIGN2YXUsIHg0CiAgICAgICDilIIg
ICAgICBhZGQgICAgeDQsIHg0LCB4MgogICAgICAg4pSCICAgICAgY21wICAgIHg0LCB4MQogICAg
ICAg4pSCICAgIOKGkiBiLmNjICAgMHhmZmZmMDAwMDA4MDllZmM4ICAvLyBiLmxvLCBiLnVsLCBm
ZmZmZjdmNjEwNjcKICAgICAgIOKUgiAgICAgIGRzYiAgICBpc2gKICAgICAgIOKUgiAgICAgIG5v
cAogIDAuMDcg4pSCICAgICAgbm9wCiAgICAgICDilIIgICAgICBtcnMgICAgeDMsIGN0cl9lbDAK
ICAgICAgIOKUgiAgICAgIG5vcAogICAgICAg4pSCICAgICAgYW5kICAgIHgzLCB4MywgIzB4Zgog
ICAgICAg4pSCICAgICAgbW92ICAgIHgyLCAjMHg0ICAgICAgICAgICAgICAgICAgICAgICAgLy8g
IzQKICAgICAgIOKUgiAgICAgIGxzbCAgICB4MiwgeDIsIHgzCiAgICAgICDilIIgICAgICBzdWIg
ICAgeDMsIHgyLCAjMHgxCiAgICAgICDilIIgICAgICBiaWMgICAgeDMsIHgwLCB4MwogOTYuMTcg
4pSCICAgICAgaWMgICAgIGl2YXUsIHgzCiAgICAgICDilIIgICAgICBhZGQgICAgeDMsIHgzLCB4
MgogICAgICAg4pSCICAgICAgY21wICAgIHgzLCB4MQogICAgICAg4pSCICAgIOKGkiBiLmNjICAg
MHhmZmZmMDAwMDA4MDlmMDAwICAvLyBiLmxvLCBiLnVsLCBmZmZmZjdmNjEwNjcKICAwLjEwIOKU
giAgICAgIGRzYiAgICBpc2gKICAgICAgIOKUgiAgICAgIGlzYgogIDEuODUg4pSCICAgICAgbW92
ICAgIHgwLCAjMHgwICAgICAgICAgICAgICAgICAgICAgICAgLy8gIzAKICAgICAgIOKUgjc4OiDi
hpAgcmV0CiAgICAgICDilIIgICAgICBtb3YgICAgeDAsICMweGZmZmZmZmZmZmZmZmZmZjIgICAg
ICAgICAvLyAjLTE0CiAgICAgICDilIIgICAg4oaRIGIgICAgICA3OAoKUmVnYXJkcywKSmFuCgpb
MV0KLS0tLS0gODwgLS0tLS0KI2luY2x1ZGUgPHNpZ25hbC5oPgojaW5jbHVkZSA8c3RkaW8uaD4K
I2luY2x1ZGUgPHN0ZGxpYi5oPgojaW5jbHVkZSA8dW5pc3RkLmg+CiNpbmNsdWRlIDxzeXMvc3lz
Y2FsbC5oPgoKI2RlZmluZSBNQVhDSElMRCAxMAoKaW50IG1haW4odm9pZCkKewoJbG9uZyBub2Rl
MSA9IDEsIG5vZGUyID0gMjsKCWludCBpLCBjaGlsZDsKCWludCBwaWRzW01BWENISUxEXTsKCglm
b3IgKGkgPSAwOyBpIDwgTUFYQ0hJTEQ7IGkrKykgewoJCWNoaWxkID0gZm9yaygpOwoJCWlmIChj
aGlsZCA9PSAwKSB7CgkJCXNsZWVwKDYwMCk7CgkJCWV4aXQoMCk7CgkJfQoJCXBpZHNbaV0gPSBj
aGlsZDsKCX0KCglmb3IgKGkgPSAwOyBpIDwgNTsgaSsrKSB7CgkJc3lzY2FsbChfX05SX21pZ3Jh
dGVfcGFnZXMsIDAsIDgsICZub2RlMSwgJm5vZGUyKTsKCQlzeXNjYWxsKF9fTlJfbWlncmF0ZV9w
YWdlcywgMCwgOCwgJm5vZGUyLCAmbm9kZTEpOwoJfQoKCWZvciAoaSA9IDA7IGkgPCBNQVhDSElM
RDsgaSsrKSB7CgkJa2lsbChwaWRzW2ldLCBTSUdLSUxMKTsKCX0KCglyZXR1cm4gMDsKfQotLS0t
LSA+OCAtLS0tLQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5p
bmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8v
bGludXgtYXJtLWtlcm5lbAo=
