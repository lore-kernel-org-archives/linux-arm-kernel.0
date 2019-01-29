Return-Path: <SRS0=P47x=QF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5658FC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 15:35:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E3CB21473
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 15:35:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qKV5i3Rm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E3CB21473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=epQQSk2/+B/EdEzzkOK4Cc7RE4iLxEvdiKRdXqn7/uU=; b=qKV5i3RmbSUtv1
	fIqYUrqo2mYwBPhdPBRXaeK5PBJi0kk1nI/JhTKCZAR13jZftbCJcUc2ek6sR/N05xoWgbWVaCRyl
	au9PrHmhCl8+9TQP0LY3oKqD6jFtFy4PNFSGXfqDxu2ucsis5zd3spcXcWnAN4d8AAqeQ/9jfK9Ry
	UBTQkdKwQM8SG76cFej6n00WZR6b/tr+ouud0o3OwxZQ2hDEyskN/pN7KI8oycHyS7kmjQXU7Bp8R
	bdiTH7ayD2Nk1BHllbO7Ge2MBI7IWncRrDpmEM0jB2H7MmXoa72v9GkEHLB5jcLCiOPZywjhvRKHA
	hcOQvsslWddNVj/xyblg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goVPe-0002Bi-VQ; Tue, 29 Jan 2019 15:34:58 +0000
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goVPZ-0002BE-QV
 for linux-arm-kernel@lists.infradead.org; Tue, 29 Jan 2019 15:34:56 +0000
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id A7796653C8;
 Tue, 29 Jan 2019 15:34:50 +0000 (UTC)
Received: from redhat.com (dhcp-10-20-1-13.bss.redhat.com [10.20.1.13])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5D01A5D6A6;
 Tue, 29 Jan 2019 15:34:49 +0000 (UTC)
Date: Tue, 29 Jan 2019 10:34:47 -0500
From: Peter Jones <pjones@redhat.com>
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: Re: [PATCH] acpi: bgrt: parse BGRT to obtain BMP address before it
 gets clobbered
Message-ID: <20190129153446.yhllzxssao3px7m3@redhat.com>
References: <20190122150616.850-1-ard.biesheuvel@linaro.org>
 <20190122173222.GB11720@e107981-ln.cambridge.arm.com>
 <CAKv+Gu9-tDRbmt+T3or9pMs78-pU-9BpKorhB60N_=Bxo78A1g@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAKv+Gu9-tDRbmt+T3or9pMs78-pU-9BpKorhB60N_=Bxo78A1g@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.28]); Tue, 29 Jan 2019 15:34:51 +0000 (UTC)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190129_073454_126368_4D303B42 
X-CRM114-Status: GOOD (  19.88  )
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
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Graeme Gregory <graeme.gregory@linaro.org>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Leif Lindholm <leif.lindholm@linaro.org>, Al Stone <astone@redhat.com>,
 ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
 linux-efi <linux-efi@vger.kernel.org>, "Hsiung,
 Harry L" <harry.l.hsiung@intel.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 Len Brown <lenb@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gVHVlLCBKYW4gMjIsIDIwMTkgYXQgMDc6MDc6MzBQTSArMDEwMCwgQXJkIEJpZXNoZXV2ZWwg
d3JvdGU6Cj4gT24gVHVlLCAyMiBKYW4gMjAxOSBhdCAxODozMiwgTG9yZW56byBQaWVyYWxpc2kg
PGxvcmVuem8ucGllcmFsaXNpQGFybS5jb20+IHdyb3RlOgo+ID4gU2lkZSBub3RlIChub3QgcmVs
YXRlZCB0byB0aGlzIHBhdGNoKToKPiA+Cj4gPiBJIGRvIG5vdCB1bmRlcnN0YW5kIHRoaXMgY2hl
Y2s6Cj4gPgo+ID4gaWYgKGJncnQtPnN0YXR1cyAmIDB4ZmUpIHsKPiA+ICAgICAgICAgcHJfbm90
aWNlKCJJZ25vcmluZyBCR1JUOiByZXNlcnZlZCBzdGF0dXMgYml0cyBhcmUgbm9uLXplcm8gJXVc
biIsCj4gPiAgICAgICAgICAgICAgICBiZ3J0LT5zdGF0dXMpOwo+ID4gICAgICAgICBnb3RvIG91
dDsKPiA+IH0KPiA+Cj4gPiBTaG91bGQgbm90IHdlIGNoZWNrIGFnYWluc3QgMHhmOCAocmVzZXJ2
ZWQgYml0cyBhcmUgWzc6M10pID8gQW5kIHdoYXQKPiA+IGFib3V0IHN0YXR1c1swXSAodmFsaWQp
LCBzaG91bGQgd2UgY2hlY2sgdGhhdCBhcyB3ZWxsID8KPiAKPiBJIHdpbGwgbGV0IFBldGVyIHRh
a2UgdGhhdCBxdWVzdGlvbiAuLi4KCkkgdGhpbmsgdGhpcyB3YXMgb3JpZ2luYWxseSBjb2RlZCBm
cm9tIGEgZHJhZnQgc3BlYywgYnV0IGFsc28gaW4gQUNQSQo2LjFBIGJpdHMgWzI6MV0gZ290IGRl
ZmluZWQgd2l0aG91dCB1cGRhdGluZyB0aGUgInZlcnNpb24iIGZpZWxkIDovLCBzbwppZiB3ZSdy
ZSBnb2luZyB0byBjaGVjayB0aGVtLCBjaGVja2luZyBhZ2FpbnN0IDB4Zjggd291bGQgYmUgY29y
cmVjdCAtCmJ1dCBpdCdzIHByb2JhYmx5IHNhbmVyIGp1c3QgdG8gbm90IGNoZWNrIHRoZW0/ICBO
b3RoaW5nIHRoYXQncyBiZWVuCmRlZmluZWQgc28gZmFyIGlzIGFjdHVhbGx5IGEgcmVhc29uIG5v
dCB0byBleHBvc2UgdGhlIGRhdGEsIGFuZCBpdCdzIG5vdApjbGVhciB0aGF0IGFueXRoaW5nIGlu
IHRoZSBmdXR1cmUgd291bGQgZWl0aGVyLiAgQWxzbywgdGhlICJ2YWxpZCIgYml0CmlzIG1lYW50
IG9ubHkgdG8gcmVmbGVjdCBpZiB0aGUgaW1hZ2UgaXMgb24gdGhlIHNjcmVlbiBvciBub3QuICBU
aGlzIHdhcwpjbGFyaWZpZWQgaW4gb25lIG9mIHRoZSBBQ1BJIDUuMEEgc3BlYyAtIHRoZSBmaWVs
ZCBoYXMgYmVlbiByZW5hbWVkIHRvCiJkaXNwbGF5ZWQiLCBzbyBhcyBub3QgdG8gY29uZnVzZSBw
ZW9wbGUuICBIZXJlJ3Mgd2hhdCB0aGUgY3VycmVudCBBQ1BJCnNwZWMgc2F5czoKCk5hbWUgICAg
U2l6ZSAgICBPZmZzZXQgIERlc2NyaXB0aW9uClN0YXR1cyAgMSAgICAgICAzOCAgICAgIDEtYnl0
ZSBzdGF0dXMgZmllbGQgaW5kaWNhdGluZyBjdXJyZW50IHN0YXR1cwogICAgICAgICAgICAgICAg
ICAgICAgICBhYm91dCB0aGUgdGFibGUuCiAgICAgICAgICAgICAgICAgICAgICAgIEJpdHMgWzc6
M10gPSBSZXNlcnZlZCAobXVzdCBiZSB6ZXJvKQogICAgICAgICAgICAgICAgICAgICAgICBCaXRz
IFsyOjFdID0gT3JpZW50YXRpb24gT2Zmc2V0LiBUaGVzZSBiaXRzCiAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBkZXNjcmliZSB0aGUgY2xvY2t3aXNlIGRlZ3JlZQogICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgb2Zmc2V0IGZyb20gdGhlIGltYWdl4oCZcyBk
ZWZhdWx0CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBvcmllbnRhdGlvbi4K
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFswMF0gPSAwLCBubyBvZmZzZXQK
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFswMV0gPSA5MAogICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgWzEwXSA9IDE4MAogICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgWzExXSA9IDI3MAoKQW5kIEkgdGhpbmsgNi4xIG9yIDYuMUEgaGFz
IGFjY2lkZW50YWxseSBkcm9wcGVkIHRoZSB0ZXh0OgoKICAgICAgICAgICAgICAgICAgICAgICAg
Qml0IFswXSA9IERpc3BsYXllZC4gQSBvbmUgaW5kaWNhdGVzIHRoZSBib290CiAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBpbWFnZSBncmFwaGljIGlzIGRpc3BsYXllZC4KCkZ1cnRo
ZXIgZG93biBpdCBzYXlzOgoKICAgICAgICBCaXQgMCAtIERpc3BsYXllZAogICAgICAgIFRoZSBz
dGF0dXMgZmllbGQgY29udGFpbnMgaW5mb3JtYXRpb24gYWJvdXQgdGhlIGN1cnJlbnQgc3RhdHVz
CiAgICAgICAgb2YgdGhlIHRhYmxlLiAgVGhlIFZhbGlkIGJpdCBpcyBiaXQgMCBvZiB0aGUgbG93
ZXN0IGJ5dGUuICBJdAogICAgICAgIHNob3VsZCBiZSBzZXQgdG8gMSB3aGlsZSB0aGUgaW1hZ2Ug
cmVzb3VyY2UgaXMgZGlzcGxheWVkIG9uIHRoZQogICAgICAgIHNjcmVlbiwgYW5kIHNldCB0byAw
IHdoaWxlIGl0IGlzIG5vdCBkaXNwbGF5ZWQuCgpDbGVhcmx5IHRoZXJlIGhhcyBiZWVuIHNvbWUg
ZWRpdGluZyBlcnJvciBnb2luZyBvbiBoZXJlLCBhbmQgSSdsbCBzZW5kCmluIGFuIEVDUiB0byBm
aXggdGhhdCB1cC4gIEl0IG1pZ2h0IGJlIHdvcnRoIGV4cG9zaW5nICJvcmllbnRhdGlvbiIgYW5k
CiJkaXNwbGF5ZWQiIGRpcmVjdGx5IGluc3RlYWQgb2YganVzdCBleHBvc2luZyAic3RhdHVzIi4K
CkFzaWRlIGZyb20gdGhhdCBhbiBMb3JlbnpvJ3Mgb3RoZXIgb2JzZXJ2YXRpb25zLCB0aGUgcGF0
Y2ggbG9va3MKcmVhc29uYWJsZSB0byBtZS4KCi0tIAogIFBldGVyCgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcg
bGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmlu
ZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
