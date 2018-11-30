Return-Path: <SRS0=AWyS=OJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E07FC04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 01:16:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 500BD2145D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 01:16:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Qjs+F2AZ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bAzJ2KT7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 500BD2145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:References:Message-Id:Date:
	In-Reply-To:From:Subject:Mime-Version:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=1l97CApeUFZLYkSP/gDc4LhmigANNysnIuFWxmflfQw=; b=Qjs+F2AZ+9J1Eh
	U/2J2Y+doIfF+Ofl8mdJq8YVE1cDVT+0DD/RANOfwjRM0WeHwJP/6SkdgPjJBXaO86BAMJH7KpmjW
	WBbcbkYtKvGo1y87ZsRW4OqEphOVX+b7bSFm+Zs0+UsKe/oLHR0OPnl7QP2D3mxlgXbLTvHg7p3Pz
	uzcDdOp55Ksom8IkSLbFaUBw7G6sUorOnVkSB2T0GKZYAiZfBrFabOsXDcgMUGTn2IMhkEStaDlma
	xbpSPSSTG0ox+TjMIoaz/iq+hX8RciG7kM+IXZLSOFpQkxMr44RHRF3BXSZgWtaznQ7ZSIsxmt837
	Ug1WpsnfDxV3rb/H1xaA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSXQ5-0003CH-7s; Fri, 30 Nov 2018 01:16:37 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSXQ2-0003Bn-Pg
 for linux-arm-kernel@bombadil.infradead.org; Fri, 30 Nov 2018 01:16:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=To:References:Message-Id:
 Content-Transfer-Encoding:Cc:Date:In-Reply-To:From:Subject:Mime-Version:
 Content-Type:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=o1wTyUOeVMZY/0/B+utPa17BjaJlxC/eZCZZJEVwfrY=; b=bAzJ2KT7kmPjs9bVEBZ+lEpBP
 4SHGWnUwYOz6wZZp+eCGXWJr8IyofsgnxOd6cUEsgx7qtRxUmy0OVTx4wC4HBKiymWTL6A8HeVX2p
 OvlHwCI7fs0EyvH5Lqf+d6PO8pX/HZpp9BqsVR7HSb3WswSNMn95vzuOlKfJmKCTN+9Axmo3683xu
 VrFFz+vrLHLxeFF1cMWgKyTGuKM1MsyKrdQtOQVXhnsQBg59OAyxS3pU+b8BI9SPWU2ZLIJnhQmec
 vpo77d3Swu37Pt+AROa7fxYboBqMOwVafnaDXKXsGcSkPyJQZbOf/vAoqTBy58gTHmbrNuRdE/MHn
 mktYtFqBQ==;
Received: from smtpbgeu1.qq.com ([52.59.177.22])
 by casper.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSXPp-0003U7-78
 for linux-arm-kernel@lists.infradead.org; Fri, 30 Nov 2018 01:16:27 +0000
X-QQ-mid: bizesmtp14t1543540546t8qrugfp
Received: from [127.0.0.1] (unknown [210.22.22.130])
 by esmtp4.qq.com (ESMTP) with 
 id ; Fri, 30 Nov 2018 09:15:44 +0800 (CST)
X-QQ-SSF: 00400000002000F0FL51B00A0000000
X-QQ-FEAT: 5t7Y1p3pIzE5PSgnrySUiCT17YKQtZJHdGZrevJqNZ4G+n8QithuqADNJiZ6V
 bbBa4lTt21gERcUhgCsYMi7TX1Q7DRgPeYcX8eDi+U1E3SQmwoKBRDiY9J8E7DtnVUp1798
 xyKHSNfPoZBNO1f99Z/43PSumyJBfuvldSCUHa9E1Ucmu51K5CUdC/owrpsUbfVEmpHlTsd
 SuyHJfUgH0tUnhJPS5XEHmwslU1jIdijpwQDmGevqsbWtNYVgLmMPNpptlbhiiELD1UaKEB
 yZ+A/1vpNXTZaKViV5VosaIG3tqMwQvjF+Lpg2xhGRnnT5
X-QQ-GoodBg: 2
Mime-Version: 1.0 (Mac OS X Mail 12.1 \(3445.101.1\))
Subject: Re: [PATCH v3 2/2] arm64: crypto: add NEON accelerated XOR
 implementation
From: JackieLiu <liuyun01@kylinos.cn>
In-Reply-To: <20181129182040.GR3505@e103592.cambridge.arm.com>
Date: Fri, 30 Nov 2018 09:15:44 +0800
Message-Id: <D0DE560B-476F-4E86-A60D-76F6D5CC2207@kylinos.cn>
References: <20181127100858.6995-1-liuyun01@kylinos.cn>
 <20181127100858.6995-2-liuyun01@kylinos.cn>
 <20181129170048.GQ3505@e103592.cambridge.arm.com>
 <CAKv+Gu-rm6uygi7+_=ssJ7UK-RgYgGNVyiTQ4O9zkN3JoYEB7g@mail.gmail.com>
 <20181129182040.GR3505@e103592.cambridge.arm.com>
To: Dave Martin <Dave.Martin@arm.com>
X-Mailer: Apple Mail (2.3445.101.1)
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:kylinos.cn:qybgforeign:qybgforeign2
X-QQ-Bgrelay: 1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181130_011621_340569_759F6FA1 
X-CRM114-Status: GOOD (  17.43  )
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
Cc: linux-block@vger.kernel.org,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Cgo+IOWcqCAyMDE45bm0MTHmnIgzMOaXpe+8jDAyOjIw77yMRGF2ZSBNYXJ0aW4gPERhdmUuTWFy
dGluQGFybS5jb20+IOWGmemBk++8mgo+IAo+IE9uIFRodSwgTm92IDI5LCAyMDE4IGF0IDA3OjA5
OjEwUE0gKzAxMDAsIEFyZCBCaWVzaGV1dmVsIHdyb3RlOgo+PiBPbiBUaHUsIDI5IE5vdiAyMDE4
IGF0IDE4OjAwLCBEYXZlIE1hcnRpbiA8RGF2ZS5NYXJ0aW5AYXJtLmNvbT4gd3JvdGU6Cj4+PiAK
Pj4+IE9uIFR1ZSwgTm92IDI3LCAyMDE4IGF0IDA2OjA4OjU4UE0gKzA4MDAsIEphY2tpZSBMaXUg
d3JvdGU6Cj4gCj4gWy4uLl0KPiAKPj4+PiArc3RhdGljIHN0cnVjdCB4b3JfYmxvY2tfdGVtcGxh
dGUgeG9yX2Jsb2NrX2FybTY0ID0gewo+Pj4+ICsgICAgIC5uYW1lICAgPSAiYXJtNjRfbmVvbiIs
Cj4+Pj4gKyAgICAgLmRvXzIgICA9IHhvcl9uZW9uXzIsCj4+Pj4gKyAgICAgLmRvXzMgICA9IHhv
cl9uZW9uXzMsCj4+Pj4gKyAgICAgLmRvXzQgICA9IHhvcl9uZW9uXzQsCj4+Pj4gKyAgICAgLmRv
XzUgICA9IHhvcl9uZW9uXzUKPj4+PiArfTsKPj4+PiArI3VuZGVmIFhPUl9UUllfVEVNUExBVEVT
Cj4+Pj4gKyNkZWZpbmUgWE9SX1RSWV9URU1QTEFURVMgICAgICAgICAgIFwKPj4+PiArICAgICBk
byB7ICAgICAgICBcCj4+Pj4gKyAgICAgICAgICAgICB4b3Jfc3BlZWQoJnhvcl9ibG9ja184cmVn
cyk7ICAgIFwKPj4+PiArICAgICAgICAgICAgIHhvcl9zcGVlZCgmeG9yX2Jsb2NrXzMycmVncyk7
ICAgIFwKPj4+PiArICAgICAgICAgICAgIGlmIChjcHVfaGFzX25lb24oKSkgeyBcCj4+Pj4gKyAg
ICAgICAgICAgICAgICAgICAgIHhvcl9zcGVlZCgmeG9yX2Jsb2NrX2FybTY0KTtcCj4+Pj4gKyAg
ICAgICAgICAgICB9IFwKPj4+PiArICAgICB9IHdoaWxlICgwKQo+Pj4gCj4+PiBTaG91bGQgdGhl
cmUgYmUgYSBtYXlfdXNlX3NpbWQoKSBjaGVjayBzb21ld2hlcmU/Cj4+PiAKPj4+IElmIHdlIGlu
dm9rZSB0aGlzIGluIGEgc29mdGlycSBJIGRvbid0IHNlZSB3aGF0IHByZXZlbnRzIHVzIGZyb20K
Pj4+IGNvcnJ1cHRpbmcgdGhlIHRhc2sncyBORU9OIHN0YXRlLgo+Pj4gCj4+PiAoVGhlIGNoZWNr
IG1pZ2h0IGJlIGluIHNvbWUgc3Vycm91bmRpbmcgZ2x1ZSBjb2RlIHRoYXQgSSBtaXNzZWQuLi4p
Cj4+PiAKPj4gCj4+IFRoZXJlIGlzIG5vIGNoZWNrLiBUaGlzIGNvZGUgc2hvdWxkIHNpbXBseSBu
b3QgYmUgY2FsbGVkIGZyb20KPj4gbm9uLXByb2Nlc3MgY29udGV4dCwgc2FtZSBhcyB0aGUgUkFJ
RDU2IGNvZGUuCj4+IAo+PiBUaGlzIGlzIG5vdCB0ZXJyaWJseSByb2J1c3QsIG9idmlvdXNseSwg
YnV0IGFwcGVhcnMgdG8gYmUgY29tbW9uCj4+IHByYWN0aWNlIGluIHRoaXMgcmVhbG0gb2YgdGhl
IGtlcm5lbC4KPiAKPiBGYWlyIGVub3VnaCAtLSBJIHdhcyBqdXN0IGN1cmlvdXMuCj4gCj4gSWYg
dGhpcyBnb2VzIHdyb25nLCB3ZSBzaG91bGQgZ2V0IGEgY2xlYXIgc3BsYXQgaW4ga2VybmVsX25l
b25fYmVnaW4oKQo+IGFueXdheS4gIEknZCBiZSBtb3JlIGNvbmNlcm5lZCBpZiB3ZSBjb3VsZCBq
dXN0IGVuZCB1cCBzY3JpYmJsaW5nIG92ZXIKPiB0aGUgTkVPTiBzdGF0ZSBzaWxlbnRseS4KPiAK
PiBDaGVlcnMKPiDigJREYXZlCgpJIGNoZWNrZWQgdGhlIGNvZGUgb2YgeG9yLmggZm9yIG90aGVy
IGFyY2hpdGVjdHVyZXMuIGV4Y2VwdCB0aGUgYXJtMzIgCnBsYXRmb3JtIGhhcyBpbnRlcnJ1cHQg
anVkZ21lbnQsIGFuZCB0aGUgb3RoZXJzIGFyZSBrZXB0IHNpbXBsZS4KCkluIGZhY3QsIHRoZSB4
b3IgYWxnb3JpdGhtIGlzIGN1cnJlbnRseSBvbmx5IGF2YWlsYWJsZSB0byBSQUlENDU2IChtYXli
ZT8pLApJIGhvcGUgaXQgY2FuIGJlIHNpbXBsZSBlbm91Z2guCgoKCgoKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5n
IGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5p
bmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
