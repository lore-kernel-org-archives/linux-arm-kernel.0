Return-Path: <SRS0=Odjb=PR=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BA4BC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 10:43:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A593A21783
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 10:43:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="u0XMlvH1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A593A21783
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=YXZV3vEJ+omTXbZ7+1PUmz6o9CT3/Ov6CR3O5dA4tz4=; b=u0XMlvH1/cYQD6
	j0CBa9gmR/pBPe+/x4nrxHH9TcoBRp7budOZD6UMbhvLS8YA1nVU5Y01bEXZM3MgvZ+OfUAZ/3QPt
	RzoRdm/aPF8y7XsKP5ln0zrfY0YXpuXeZWPpAYib/ptfiBSKVa7okxz/N59lhV3DTXcgVEphaxbso
	z0cn5qCx3rGHWOEQZ61kxYWci+sHG5x/n+Go2WYvZgyI3RlrBGFJfbzAc8lkiWBIMAYyrhBMovPJr
	4fS3riBRR0i9bNID7oBI7P+xfi1R5nDtatLeGt+m0FR8/YFDh6jwfyS6ANzE8zuUuPSfSKsM3TxkO
	im6NG4vgP5EeadxHPsJA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghBKy-00036B-TT; Wed, 09 Jan 2019 10:43:52 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghBKv-00035m-MP
 for linux-arm-kernel@lists.infradead.org; Wed, 09 Jan 2019 10:43:51 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CF833A78;
 Wed,  9 Jan 2019 02:43:48 -0800 (PST)
Received: from donnerap.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E09A33F70D;
 Wed,  9 Jan 2019 02:43:47 -0800 (PST)
Date: Wed, 9 Jan 2019 10:43:42 +0000
From: Andre Przywara <andre.przywara@arm.com>
To: Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: [kvmarm:kvm-arm64/nv-wip-v5.0-rc1 4/75]
 arch/arm/kvm/../../../virt/kvm/arm/arch_timer.c:700:7: error:
 'SYS_CNTP_TVAL_EL0' undeclared
Message-ID: <20190109104342.7c8ead84@donnerap.cambridge.arm.com>
In-Reply-To: <8fd0977c-9ca1-8ad8-a6b7-e36e115745b8@arm.com>
References: <201901091219.igdmvhpC%fengguang.wu@intel.com>
 <a82a7868-f3c0-0b3e-d0b7-182992c268fa@arm.com>
 <8fd0977c-9ca1-8ad8-a6b7-e36e115745b8@arm.com>
Organization: ARM
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190109_024349_740774_B18FD13A 
X-CRM114-Status: GOOD (  18.95  )
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
Cc: Christoffer Dall <christoffer.dall@arm.com>,
 linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gV2VkLCA5IEphbiAyMDE5IDEwOjA5OjUxICswMDAwCk1hcmMgWnluZ2llciA8bWFyYy56eW5n
aWVyQGFybS5jb20+IHdyb3RlOgoKPiBPbiAwOS8wMS8yMDE5IDA5OjEzLCBBbmRyw6kgUHJ6eXdh
cmEgd3JvdGU6Cj4gPiBPbiAwOS8wMS8yMDE5IDA0OjQwLCBrYnVpbGQgdGVzdCByb2JvdCB3cm90
ZToKPiA+IAo+ID4gTWFyYywgQ2hyaXN0b2ZmZXIsCj4gPiAgIAo+ID4+IHRyZWU6Cj4gPj4gaHR0
cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQva3ZtYXJtL2t2bWFy
bS5naXQKPiA+PiBrdm0tYXJtNjQvbnYtd2lwLXY1LjAtcmMxIGhlYWQ6Cj4gPj4gNjg4YzM4NmNh
MDk2ZjJjMWYyZWVlMzg2Njk3NTg2Yzg4ZGY1ZDViYyBjb21taXQ6Cj4gPj4gMmIxMjY1YzU4YTg3
M2Q5MTdlOTlhYzc2MmUyNDNjMTI3NDQ4MWRiZiBbNC83NV0gS1ZNOiBhcm0vYXJtNjQ6Cj4gPj4g
Y29uc29saWRhdGUgYXJjaCB0aW1lciB0cmFwIGhhbmRsZXJzIGNvbmZpZzogYXJtLWF4bTU1eHhf
ZGVmY29uZmlnCj4gPj4gKGF0dGFjaGVkIGFzIC5jb25maWcpIGNvbXBpbGVyOiBhcm0tbGludXgt
Z251ZWFiaS1nY2MgKERlYmlhbgo+ID4+IDcuMi4wLTExKSA3LjIuMCByZXByb2R1Y2U6IHdnZXQK
PiA+PiBodHRwczovL3Jhdy5naXRodWJ1c2VyY29udGVudC5jb20vaW50ZWwvbGtwLXRlc3RzL21h
c3Rlci9zYmluL21ha2UuY3Jvc3MKPiA+PiAtTyB+L2Jpbi9tYWtlLmNyb3NzIGNobW9kICt4IH4v
YmluL21ha2UuY3Jvc3MgZ2l0IGNoZWNrb3V0Cj4gPj4gMmIxMjY1YzU4YTg3M2Q5MTdlOTlhYzc2
MmUyNDNjMTI3NDQ4MWRiZiAjIHNhdmUgdGhlCj4gPj4gYXR0YWNoZWQgLmNvbmZpZyB0byBsaW51
eCBidWlsZCB0cmVlIEdDQ19WRVJTSU9OPTcuMi4wIG1ha2UuY3Jvc3MKPiA+PiBBUkNIPWFybSAK
PiA+Pgo+ID4+IEFsbCBlcnJvcnMgKG5ldyBvbmVzIHByZWZpeGVkIGJ5ID4+KTogIAo+ID4gCj4g
PiBJIHdhcyBsb29raW5nIGF0IHRoaXMgeWVzdGVyZGF5OiBJdCdzIGEgYml0IG5hc3R5LCBkb24n
dCBrbm93IGEgZ29vZAo+ID4gc29sdXRpb24gYmVzaWRlIGJyaW5naW5nIGJhY2sgdGhpcyBwYXJ0
IG9mIG15IG9yaWdpbmFsIHRpbWVyIHJld29yawo+ID4gc2VyaWVzLiBUaGUgcHJvYmxlbSBpcyB0
aGF0IHRob3NlIHN5bWJvbHMgY29udGFpbnMgdGhlIEFhcmNoNjQKPiA+IHNwZWNpZmljIChpbnN0
cnVjdGlvbikgZW5jb2Rpbmcgb2YgdGhlIHRpbWVyIHJlZ2lzdGVycywgcGx1cyB3ZQo+ID4gbmVl
ZCB0aGUgQUFyY2gzMiBlbmNvZGluZ3MgZm9yIDMyLW9uLTY0IGd1ZXN0cy4gIAo+IAo+IFdoeT8g
VGhlcmUgaXMgZXhhY3RseSBvbmUgdGltZXIgdGhhdCBuZWVkcyB0cmFwcGluZyBmb3IgQUFyY2gz
MiAodGhlCj4gRUwxIHBoeXNpY2FsIHRpbWVyKS4gQWxsIHdlIG5lZWQgaXM6Cj4gCj4gLSB0aGUg
U1lTX0FBUkNIMzJfQ05UUF8qIGVuY29kaW5ncyBvbiAzMmJpdAo+IC0gc29tZSBDUFAgbWFnaWMg
dG8gcHJldmVudCB0aGUgY29tcGlsYXRpb24gZnJvbSBicmVha2luZwoKRmFpciBlbm91Z2gsIGlm
IHlvdSBhcmUgT0sgd2l0aCB0aGlzLiBJIGhhZCBzb21ldGhpbmcgbGlrZSB0aGlzIGJlZm9yZSwK
YnV0IGl0IGxvb2tlZCBraW5kIG9mIGhhY2tpc2ggdG8gbWUsIHNvIEkgd2FzIGxvb2tpbmcgYXQg
c29tZSBwcm9wZXIoVE0pCnNvbHV0aW9uLgoKPiA+IAo+ID4gVGhhdCdzIHdoeSBJIHVzZWQgdGhl
IGdlbmVyaWMgVUFQSSBlbmNvZGluZyBmb3IgdGhlIHJlZ2lzdGVycywKPiA+IGJlY2F1c2Ugd2Ug
b25seSBuZWVkICpzb21lKiBpZGVudGlmaWNhdGlvbiBmb3IgdGhlbSwgaXQgZG9lc24ndAo+ID4g
bmVlZCB0byBiZSBzb21ldGhpbmcgZGVmaW5lZCBieSB0aGUgYXJjaGl0ZWN0dXJlLiAgCj4gCj4g
SSBkaXNhZ3JlZS4gQnkgZG9pbmcgc28sIHlvdSdyZSBjb25mbGF0aW5nIHVzZXJzcGFjZSBhY2Nl
c3MgYW5kCj4gdHJhcHBpbmcsIHdoaWNoIGhhcyBwcm92ZWQgdG8gYmUgYSBiYWQgaWRlYSBpbiB0
aGUgcGFzdC4gRm9yIGV4YW1wbGUsCj4geW91J2QgZW5kLXVwIGhhdmluZyBib3RoIENWQUwgYW5k
IFRWQUwgaW4gVUFQSSwgd2hpY2ggaXMgbm90IHNvbWV0aGluZwo+IEknbSBrZWVuIHRvIGhhdmUu
IE9uIHRoZSBvdGhlciBoYW5kLCB0aGUgdHJhcHBpbmcgZnVuY3Rpb24gZG8gbmVlZCB0bwo+IGJl
IGFibGUgdG8gaGFuZGxlIHRoZXNlLgoKRmFpciBlbm91Z2gsIEkgd2FzIGp1c3QgKmhvcGluZyog
d2UgY2FuIGtlZXAgYXJjaF90aW1lci5jIGNsZWFuIG9mIGFyY2gKc3BlY2lmaWMgZW5jb2Rpbmdz
LiBJIGNhbiB1bmRlcnN0YW5kIHRoYXQgd2l0aCBhbGwgdGhlIGFkZGVkCmNvbXBsZXhpdHkgb2Yg
dGhlIG5lc3RlZCB0aW1lcnMgdGhpcyBpcyBwcm9iYWJseSBub3QgZmVhc2libGUgYW55bW9yZS4K
CkNoZWVycywKQW5kcmUuCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxp
c3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0
aW5mby9saW51eC1hcm0ta2VybmVsCg==
