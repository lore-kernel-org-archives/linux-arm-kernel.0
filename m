Return-Path: <SRS0=7SeU=QL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 329B0C282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 16:56:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA90020815
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 16:56:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lwHtVksb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA90020815
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=SwaFDWit7DZI+XIl5VvcXU66t7Umg5LlN35UhsDLRfI=; b=lwHtVksba6b7Sk
	ui8rFCqcYR26EttqDGmV1jRtBRJfsL27IjyMNlUjtBOwn/WEc3M02xEey42NzVAKBdfxkJehbwqU+
	DSh213DdcNW1UW+NiE0QWOzDmWoecfTvr1QAUlrzJ8xFkIwXsRXeBHwGCF6qyROqjxN8yAZcYe0jr
	7ce/7jg04KcXXt6auIHqUpUeURtjz162dyrpv/AOkXcoNeUN4m97FxsEdQaI2+YHQcn8qXADiWU++
	4alTErzRRx6I0w8lgU0qg/3gUgsFeh4Crgxcm0uth6HrMEzw60WdeGHTg6jXv720sECXxCCKyaO5d
	a+oisYyrGlHFNJid5pLw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqhY3-0006tv-G6; Mon, 04 Feb 2019 16:56:43 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqhXy-0006sc-S5; Mon, 04 Feb 2019 16:56:40 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7F4CDEBD;
 Mon,  4 Feb 2019 08:56:38 -0800 (PST)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 04D693F589;
 Mon,  4 Feb 2019 08:56:36 -0800 (PST)
Subject: Re: [PATCH] arm64, vmcoreinfo : Append 'MAX_USER_VA_BITS' and
 'MAX_PHYSMEM_BITS' to vmcoreinfo
To: Bhupesh Sharma <bhsharma@redhat.com>
References: <1548850991-11879-1-git-send-email-bhsharma@redhat.com>
 <239cdca4-1c7d-f236-f4a9-a0a3fe98f966@arm.com>
 <86c0dd9f-a55b-8ce8-69ca-893f63087d1a@redhat.com>
 <a646e38d-9351-e187-1571-c49d3558b164@redhat.com>
From: James Morse <james.morse@arm.com>
Message-ID: <d2f193ef-0fb9-f76b-073d-746304cffc44@arm.com>
Date: Mon, 4 Feb 2019 16:56:35 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <a646e38d-9351-e187-1571-c49d3558b164@redhat.com>
Content-Language: en-GB
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190204_085638_916428_CA3A7773 
X-CRM114-Status: GOOD (  18.37  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, ard.biesheuvel@linaro.org,
 catalin.marinas@arm.com, kexec@lists.infradead.org,
 Will Deacon <will.deacon@arm.com>,
 AKASHI Takahiro <takahiro.akashi@linaro.org>, bhupesh.linux@gmail.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGkgQmh1cGVzaCwKCk9uIDA0LzAyLzIwMTkgMTQ6MzUsIEJodXBlc2ggU2hhcm1hIHdyb3RlOgo+
IE9uIDAxLzMxLzIwMTkgMDM6MDkgQU0sIEJodXBlc2ggU2hhcm1hIHdyb3RlOgo+PiBPbiAwMS8z
MC8yMDE5IDA4OjUxIFBNLCBKYW1lcyBNb3JzZSB3cm90ZToKPj4+IE9uIDAxLzMwLzIwMTkgMTI6
MjMgUE0sIEJodXBlc2ggU2hhcm1hIHdyb3RlOgo+Pj4+IFdpdGggQVJNdjguMi1MVkEgYW5kIExQ
QSBhcmNoaXRlY3R1cmUgZXh0ZW5zaW9ucywgYXJtNjQgaGFyZHdhcmUgd2hpY2gKPj4+PiBzdXBw
b3J0cyB0aGVzZSBleHRlbnNpb25zIGNhbiBzdXBwb3J0IHVwdG8gNTItYml0IHZpcnR1YWwgYW5k
IDUyLWJpdAo+Pj4+IHBoeXNpY2FsIGFkZHJlc3NlcyByZXNwZWN0aXZlbHkuCj4+Pj4KPj4+PiBT
aW5jZSBhdCB0aGUgbW9tZW50IHdlIGVuYWJsZSB0aGUgc3VwcG9ydCBvZiB0aGVzZSBleHRlbnNp
b25zIHZpYSBDT05GSUcKPj4+PiBmbGFncywgZS5nLgo+Pj4+IMKgIC0gTFBBIHZpYSBDT05GSUdf
QVJNNjRfUEFfQklUU181Mgo+Pj4+Cj4+Pj4gdGhlcmUgYXJlIG5vIGNsZWFyIG1lY2hhbmlzbXMg
aW4gdXNlci1zcGFjZSByaWdodCBub3cgdG8KPj4+PiBkZXRlcmVtaW5lIHRoZXNlIENPTkZJRyBm
bGFnIHZhbHVlcyBhbmQgYWxzbyBkZXRlcm1pbmUgdGhlIFBBUmFuZ2UgYW5kCj4+Pj4gVkFSYW5n
ZSBhZGRyZXNzIHZhbHVlcy4KPj4+PiBVc2VyLXNwYWNlIHRvb2xzIGxpa2UgJ21ha2VkdW1wZmls
ZScgYW5kICdjcmFzaC11dGlsaXR5JyBjYW4gaW5zdGVhZAo+Pj4+IHVzZSB0aGUgJ01BWF9VU0VS
X1ZBX0JJVFMnIGFuZCAnTUFYX1BIWVNNRU1fQklUUycgdmFsdWVzIHRvIGRldGVybWluZQo+Pj4+
IHRoZSBtYXhpbXVtIHZpcnR1YWwgYWRkcmVzcyBhbmQgcGh5c2ljYWwgYWRkcmVzcyAocmVzcGVj
dGl2ZWx5KQo+Pj4+IHN1cHBvcnRlZCBieSB1bmRlcmx5aW5nIGtlcm5lbC4KPj4+Pgo+Pj4+IEEg
cmVmZXJlbmNlICdtYWtlZHVtcGZpbGUnIGltcGxlbWVudGF0aW9uIHdoaWNoIHVzZXMgdGhpcyBh
cHByb2FjaCB0bwo+Pj4+IGRldGVybWluaW5nIHRoZSBtYXhpbXVtIHBoeXNpY2FsIGFkZHJlc3Mg
aXMgYXZhaWxhYmxlIGluIFswXS4KPj4+Cj4+PiBXaHkgZG9lcyBpdCBuZWVkIHRvIGtub3c/Cj4+
Pgo+Pj4gKFN1enVraSBhc2tlZCB0aGUgc2FtZSBxdWVzdGlvbiBvbiB5b3VyIGVhcmxpZXIgdmVy
c2lvbikKPj4+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LWFybS1rZXJuZWwvY2ZmNDQ3
NTQtN2ZlNC1lZmVhLWJjOGUtNGRkZTIyNzdjODIxQGFybS5jb20vCgoKPj4gSSBoYXZlIHNoYXJl
ZCBzb21lIGRldGFpbHMgKGFmdGVyIGRpc2N1c3Npb24gd2l0aCBvdXIgdGVzdCB0ZWFtcykgaW4g
cmVwbHkgdG8KPj4gdGhlIHJldmlldyBjb21tZW50cyBmcm9tIFN1enVraSBoZXJlOgo+PiBodHRw
Oi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9waXBlcm1haWwva2V4ZWMvMjAxOS1KYW51YXJ5LzAyMjM4
OS5odG1sLCBhbmQKPj4gaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvcGlwZXJtYWlsL2tleGVj
LzIwMTktSmFudWFyeS8wMjIzOTAuaHRtbAo+Pgo+PiBKdXN0IHRvIHN1bW1hcml6ZSwgSSBtZW50
aW9uZWQgaW4gbXkgcmVwbGllcyB0byB0aGUgcmV2aWV3IGNvbW1lbnRzIHRoYSB0aGUKPj4gbWFr
ZWR1bXBmaWxlIGltcGxlbWVudGF0aW9uIChmb3IgZGVjb2RpbmcgdGhlIFBURSkgd2FzIGp1c3Qg
YXMgYW4gZXhhbXBsZSwKPj4gaG93ZXZlciB0aGVyZSBjYW4gYmUgb3RoZXIgdXNlci1zcGFjZSBh
cHBsaWNhdGlvbnMsIGZvciBlLmcgYSB1c2VyLXNwYWNlCj4+IGFwcGxpY2F0aW9uIHJ1bm5pbmcg
d2l0aCA0OC1iaXQga2VybmVsIFZBIGFuZCA1Mi1iaXQgdXNlciBzcGFjZSBWQSBhbmQKPj4gcmVx
dWVzdGluZyBhbGxvY2F0aW9uIGluICdoaWdoJyBhZGRyZXNzIHZpYSBhICdoaW50JyB0byBtbWFw
LgoKQnV0IHZtY29yZWluZm8gaXMgdGhlIHdyb25nIHBsYWNlIHRvIGV4cG9zZSB0aGlzIGluZm9y
bWF0aW9uLiAoaXQgY2FuIGJlCmNvbmZpZ3VyZWQgb2ZmLCBhbmQgaXMgb25seSBhY2Nlc3NpYmxl
IHRvIHJvb3QpCgoKPj4+IMKgRnJvbSB5b3VyIGdpdGh1YiBsaW5rIGl0IGxvb2tzIGxpa2UgeW91
IHVzZSB0aGlzIHRvIHJlLWFzc2VtYmxlIHRoZSB0d28gYml0cwo+Pj4gb2YgdGhlIFBGTiBmcm9t
IHRoZSBwdGUuIENhbid0IHlvdSBhbHdheXMgZG8gdGhpcyBmb3IgNjRLIHBhZ2VzPyBDUFVzIHdp
dGgKPj4+IHRoZSBmZWF0dXJlIGFsd2F5cyBkbyB0aGlzIHRvbywgaXRzIG5vdCBzb21ldGhpbmcg
dGhlIGtlcm5lbCB0dXJucyBvbi4KPj4KPj4gT2ssIGxldCBtZSB0cnkgdG8gZ2l2ZSBzb21lIHBl
cnNwZWN0aXZlIG9mIGEgY29tbW9uIG1ha2VkdW1wZmlsZSB1c2UtY2FzZQo+PiBiZWZvcmUgSSBq
dW1wIGludG8gdGhlIGRldGFpbHM6CgoKPj4gQWxzbyBoYXJkY29kaW5nIHRoZSBQVEUgY2FsY3Vs
YXRpb24gdG8gdXNlIHRoZSBoaWdoIGFkZHJlc3MgYml0IG1hc2sgYWx3YXlzCj4+IHdpbGwgYnJl
YWsgdGhlIGJhY2t3YXJkIGNvbXBhdGliaWxpdHkgd2l0aCBvbGRlciBrZXJuZWxzICh3aGljaCBk
b24ndCBzdXBwb3J0Cj4+IDUyLWJpdCBhZGRyZXNzIHNwYWNlIGV4dGVuc2lvbnMpLgoKV2hhdCB3
b3VsZCBnbyB3cm9uZz8KClRoZSBoYXJkd2FyZSBpZ25vcmVzIHRob3NlIGJpdHMgYW5kIHN1cHBs
aWVzIHplcm8uIEFzIGZhciBhcyBJIGNhbiBzZWUgdGhlCmtlcm5lbCBoYXMgYWx3YXlzIGdlbmVy
YXRlZCB6ZXJvIHRoZXJlLgoKCj4+IChiKS4gQWxzbyB4ODZfNjQgYWxyZWFkeSBoYXMgYSB2bWNv
cmVpbmZvIGV4cG9ydCBmb3IgJ3BndGFibGVfbDVfZW5hYmxlZCc6CgpTbz8gNS1sZXZlbCBwYWdl
IHRhYmxlcyBpcyBhIGRpZmZlcmVudCBmZWF0dXJlLiBJIGFncmVlIHlvdSBuZWVkIHRvIGtub3cg
dGhlCm51bWJlciBvZiBsZXZlbHMgdG8gd2FsayB0aGUgcGFnZS10YWJsZXMsIGJ1dCB0aGF0IGlz
bid0IGhvdyBhcm02NCdzIDUyYml0IHN0dWZmCndvcmtzLgoKCj4gUGluZy4gU2luY2UgdGhpcyBw
YXRjaCBmaXhlcyBhIHJlZ3Jlc3Npb24gd2l0aCB1c2VyLXNwYWNlIHRvb2xzIGxpa2UKPiBtYWtl
ZHVtcGZpbGUgYW5kIGNyYXNoLXV0aWxpdHkgd2hpY2ggYXJlIGJyb2tlbiBzaW5jZSBhcm02NCBr
ZXJuZWxzIHdpdGggNTItYml0Cj4gVkEgYW5kIFBBIHN1cHBvcnQgYXJlIGF2YWlsYWJsZSAoYW5k
IGRpc3RyaWJ1dGlvbnMgd2hpY2ggZW5hYmxlIHRoZW0pLCB3b3VsZAo+IHJlcXVlc3QgcmV2aWV3
IGNvbW1lbnRzL2FjayBvbiB0aGlzIHNpbXBsZSBjaGFuZ2UuCgpCcm9rZW4gaG93PyBXaGF0IGdv
ZXMgd3Jvbmc/CgpJIGNhbiBzZWUgaG93IGEgbm90LTUyYml0LWF3YXJlIGNyYXNoL2dkYi93aGF0
ZXZlciB3b3VsZCBiZSBjb25mdXNlZCBieSBoaWdoCmJpdHMgYmVpbmcgc2V0IGluIHRoZSBwaHlz
aWNhbCBhZGRyZXNzLCBhbmQgcG9zc2libHkgdGhyb3cgdGhlbSBhd2F5LgpCdXQgb25jZSBpdCBz
dXBwb3J0cyB0aGlzIGZvciA2NEsgcGFnZXMsIEkgZG9uJ3Qgc2VlIHdoYXQgY2FuIGdvIHdyb25n
IGlmIHRob3NlCmJpdHMgYXJlbid0IHNldC4gV2h5IGRvZXMgaXQgbmVlZCB0byBrbm93PwoKClRo
YW5rcywKCkphbWVzCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3Rz
LmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5m
by9saW51eC1hcm0ta2VybmVsCg==
