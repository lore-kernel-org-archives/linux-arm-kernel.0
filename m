Return-Path: <SRS0=fRgi=OV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C4F6C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 10:48:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CCEE20849
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 10:48:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="OozH4SUG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CCEE20849
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=V8vH2GfJfT9hErScG8EHXw0OPvxQ9d1xghNfb7QAIH4=; b=OozH4SUGIV/af+
	D0+c+3hJgpF/6l5GsqSGYXbwcxmiG25W75dE+DgQscd+fbND5FWnc6mm9LQme/1QKgFHmmGOQprkv
	lLfp7c2YR4XVYY9iz2CL1goER0TCMjRirrShpAt6IaIn7O0GqKKn09vnwGkmiQGU6cU6fMQcHfVdJ
	ke6mRnSMCPL8EQDru54AYG8QEG0EW5UkhGX8DhXNAiuVBlk7zLU2vNIY43ANug0pkGLXG2Q2n8bO/
	EiUU/9qIjoQBzzEs+G1y8eFSJ+MP1GiS726l3JDaVIVxwslt57dDdeJ0l5J68WsStsYe2sF5Vcstk
	PG7fWjiZ82AF9aoI2GWA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gX23c-0007n9-B1; Wed, 12 Dec 2018 10:48:00 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gX23Z-0007m8-2X
 for linux-arm-kernel@lists.infradead.org; Wed, 12 Dec 2018 10:47:58 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 358EAA78;
 Wed, 12 Dec 2018 02:47:45 -0800 (PST)
Received: from [10.1.197.36] (e112298-lin.cambridge.arm.com [10.1.197.36])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 717C63F575;
 Wed, 12 Dec 2018 02:47:43 -0800 (PST)
Subject: Re: [PATCH v8 4/5] arm64: arm_pmu: Add support for
 exclude_host/exclude_guest attributes
To: Suzuki K Poulose <suzuki.poulose@arm.com>,
 Andrew Murray <andrew.murray@arm.com>,
 Christoffer Dall <christoffer.dall@arm.com>,
 Marc Zyngier <marc.zyngier@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon
 <will.deacon@arm.com>, Mark Rutland <mark.rutland@arm.com>
References: <1544610573-28446-1-git-send-email-andrew.murray@arm.com>
 <1544610573-28446-5-git-send-email-andrew.murray@arm.com>
 <89242306-a445-017b-553e-105ae52d8cbe@arm.com>
From: Julien Thierry <julien.thierry@arm.com>
Message-ID: <5fe821a9-a2b2-c40d-7a83-b014d7b8f4d1@arm.com>
Date: Wed, 12 Dec 2018 10:47:41 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <89242306-a445-017b-553e-105ae52d8cbe@arm.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181212_024757_123372_1057F8E1 
X-CRM114-Status: GOOD (  18.12  )
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
Cc: kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

CgpPbiAxMi8xMi8yMDE4IDEwOjQyLCBTdXp1a2kgSyBQb3Vsb3NlIHdyb3RlOgo+IAo+IAo+IE9u
IDEyLzEyLzIwMTggMTA6MjksIEFuZHJldyBNdXJyYXkgd3JvdGU6Cj4+IEFkZCBzdXBwb3J0IGZv
ciB0aGUgOkcgYW5kIDpIIGF0dHJpYnV0ZXMgaW4gcGVyZiBieSBoYW5kbGluZyB0aGUKPj4gZXhj
bHVkZV9ob3N0L2V4Y2x1ZGVfZ3Vlc3QgZXZlbnQgYXR0cmlidXRlcy4KPj4KPj4gV2Ugbm90aWZ5
IEtWTSBvZiBjb3VudGVycyB0aGF0IHdlIHdpc2ggdG8gYmUgZW5hYmxlZCBvciBkaXNhYmxlZCBv
bgo+PiBndWVzdCBlbnRyeS9leGl0IGFuZCB0aHVzIGRlZmVyIGZyb20gc3RhcnRpbmcgb3Igc3Rv
cHBpbmcgOkcgZXZlbnRzCj4+IGFzIHBlciB0aGUgZXZlbnRzIGV4Y2x1ZGVfaG9zdCBhdHRyaWJ1
dGUuCj4+Cj4+IFdpdGggYm90aCBWSEUgYW5kIG5vbi1WSEUgd2Ugc3dpdGNoIHRoZSBjb3VudGVy
cyBiZXR3ZWVuIGhvc3QvZ3Vlc3QKPj4gYXQgRUwyLiBXZSBhcmUgYWJsZSB0byBlbGltaW5hdGUg
Y291bnRlcnMgY291bnRpbmcgaG9zdCBldmVudHMgb24KPj4gdGhlIGJvdW5kYXJpZXMgb2YgZ3Vl
c3QgZW50cnkvZXhpdCB3aGVuIHVzaW5nIDpHIGJ5IGZpbHRlcmluZyBvdXQKPj4gRUwyIGZvciBl
eGNsdWRlX2hvc3QuIEhvd2V2ZXIgd2hlbiB1c2luZyA6SCB1bmxlc3MgZXhjbHVkZV9odiBpcyBz
ZXQKPj4gb24gbm9uLVZIRSB0aGVuIHRoZXJlIGlzIGEgc21hbGwgYmxhY2tvdXQgd2luZG93IGF0
IHRoZSBndWVzdAo+PiBlbnRyeS9leGl0IHdoZXJlIGhvc3QgZXZlbnRzIGFyZSBub3QgY2FwdHVy
ZWQuCj4+Cj4+IFNpZ25lZC1vZmYtYnk6IEFuZHJldyBNdXJyYXkgPGFuZHJldy5tdXJyYXlAYXJt
LmNvbT4KPj4gLS0tCj4+IMKgIGFyY2gvYXJtNjQva2VybmVsL3BlcmZfZXZlbnQuYyB8IDUxCj4+
ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLQo+PiDCoCAxIGZpbGUg
Y2hhbmdlZCwgNDQgaW5zZXJ0aW9ucygrKSwgNyBkZWxldGlvbnMoLSkKPj4KPj4gZGlmZiAtLWdp
dCBhL2FyY2gvYXJtNjQva2VybmVsL3BlcmZfZXZlbnQuYwo+PiBiL2FyY2gvYXJtNjQva2VybmVs
L3BlcmZfZXZlbnQuYwo+PiBpbmRleCBkZTU2NGFlLi40YTNjNzNkIDEwMDY0NAo+PiAtLS0gYS9h
cmNoL2FybTY0L2tlcm5lbC9wZXJmX2V2ZW50LmMKPj4gKysrIGIvYXJjaC9hcm02NC9rZXJuZWwv
cGVyZl9ldmVudC5jCj4+IEBAIC0yNiw2ICsyNiw3IEBACj4+IMKgIMKgICNpbmNsdWRlIDxsaW51
eC9hY3BpLmg+Cj4+IMKgICNpbmNsdWRlIDxsaW51eC9jbG9ja3NvdXJjZS5oPgo+PiArI2luY2x1
ZGUgPGxpbnV4L2t2bV9ob3N0Lmg+Cj4+IMKgICNpbmNsdWRlIDxsaW51eC9vZi5oPgo+PiDCoCAj
aW5jbHVkZSA8bGludXgvcGVyZi9hcm1fcG11Lmg+Cj4+IMKgICNpbmNsdWRlIDxsaW51eC9wbGF0
Zm9ybV9kZXZpY2UuaD4KPj4gQEAgLTY0NywxMSArNjQ4LDI2IEBAIHN0YXRpYyBpbmxpbmUgaW50
IGFybXY4cG11X2VuYWJsZV9jb3VudGVyKGludCBpZHgpCj4+IMKgIMKgIHN0YXRpYyBpbmxpbmUg
dm9pZCBhcm12OHBtdV9lbmFibGVfZXZlbnRfY291bnRlcihzdHJ1Y3QgcGVyZl9ldmVudAo+PiAq
ZXZlbnQpCj4+IMKgIHsKPj4gK8KgwqDCoCBzdHJ1Y3QgcGVyZl9ldmVudF9hdHRyICphdHRyID0g
JmV2ZW50LT5hdHRyOwo+PiDCoMKgwqDCoMKgIGludCBpZHggPSBldmVudC0+aHcuaWR4Owo+PiAr
wqDCoMKgIGludCBmbGFncyA9IDA7Cj4+ICvCoMKgwqAgdTMyIGNvdW50ZXJfYml0cyA9IEJJVChB
Uk1WOF9JRFhfVE9fQ09VTlRFUihpZHgpKTsKPj4gwqAgLcKgwqDCoCBhcm12OHBtdV9lbmFibGVf
Y291bnRlcihpZHgpOwo+PiDCoMKgwqDCoMKgIGlmIChhcm12OHBtdV9ldmVudF9pc19jaGFpbmVk
KGV2ZW50KSkKPj4gLcKgwqDCoMKgwqDCoMKgIGFybXY4cG11X2VuYWJsZV9jb3VudGVyKGlkeCAt
IDEpOwo+PiArwqDCoMKgwqDCoMKgwqAgY291bnRlcl9iaXRzIHw9IEJJVChBUk1WOF9JRFhfVE9f
Q09VTlRFUihpZHggLSAxKSk7Cj4+ICsKPj4gK8KgwqDCoCBpZiAoIWF0dHItPmV4Y2x1ZGVfaG9z
dCkKPj4gK8KgwqDCoMKgwqDCoMKgIGZsYWdzIHw9IEtWTV9QTVVfRVZFTlRTX0hPU1Q7Cj4+ICvC
oMKgwqAgaWYgKCFhdHRyLT5leGNsdWRlX2d1ZXN0KQo+PiArwqDCoMKgwqDCoMKgwqAgZmxhZ3Mg
fD0gS1ZNX1BNVV9FVkVOVFNfR1VFU1Q7Cj4+ICsKPj4gK8KgwqDCoCBrdm1fc2V0X3BtdV9ldmVu
dHMoY291bnRlcl9iaXRzLCBmbGFncyk7Cj4+ICsKPj4gK8KgwqDCoCBpZiAoIWF0dHItPmV4Y2x1
ZGVfaG9zdCkgewo+PiArwqDCoMKgwqDCoMKgwqAgYXJtdjhwbXVfZW5hYmxlX2NvdW50ZXIoaWR4
KTsKPj4gK8KgwqDCoMKgwqDCoMKgIGlmIChhcm12OHBtdV9ldmVudF9pc19jaGFpbmVkKGV2ZW50
KSkKPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgYXJtdjhwbXVfZW5hYmxlX2NvdW50ZXIoaWR4
IC0gMSk7Cj4+ICvCoMKgwqAgfQo+PiDCoCB9Cj4+IMKgIMKgIHN0YXRpYyBpbmxpbmUgaW50IGFy
bXY4cG11X2Rpc2FibGVfY291bnRlcihpbnQgaWR4KQo+PiBAQCAtNjY0LDExICs2ODAsMjAgQEAg
c3RhdGljIGlubGluZSBpbnQgYXJtdjhwbXVfZGlzYWJsZV9jb3VudGVyKGludCBpZHgpCj4+IMKg
IHN0YXRpYyBpbmxpbmUgdm9pZCBhcm12OHBtdV9kaXNhYmxlX2V2ZW50X2NvdW50ZXIoc3RydWN0
IHBlcmZfZXZlbnQKPj4gKmV2ZW50KQo+PiDCoCB7Cj4+IMKgwqDCoMKgwqAgc3RydWN0IGh3X3Bl
cmZfZXZlbnQgKmh3YyA9ICZldmVudC0+aHc7Cj4+ICvCoMKgwqAgc3RydWN0IHBlcmZfZXZlbnRf
YXR0ciAqYXR0ciA9ICZldmVudC0+YXR0cjsKPj4gwqDCoMKgwqDCoCBpbnQgaWR4ID0gaHdjLT5p
ZHg7Cj4+ICvCoMKgwqAgdTMyIGNvdW50ZXJfYml0cyA9IEJJVChBUk1WOF9JRFhfVE9fQ09VTlRF
UihpZHgpKTsKPj4gwqAgwqDCoMKgwqDCoCBpZiAoYXJtdjhwbXVfZXZlbnRfaXNfY2hhaW5lZChl
dmVudCkpCj4+IC3CoMKgwqDCoMKgwqDCoCBhcm12OHBtdV9kaXNhYmxlX2NvdW50ZXIoaWR4IC0g
MSk7Cj4+IC3CoMKgwqAgYXJtdjhwbXVfZGlzYWJsZV9jb3VudGVyKGlkeCk7Cj4+ICvCoMKgwqDC
oMKgwqDCoCBjb3VudGVyX2JpdHMgfD0gQklUKEFSTVY4X0lEWF9UT19DT1VOVEVSKGlkeCAtIDEp
KTsKPj4gKwo+PiArwqDCoMKgIGt2bV9jbHJfcG11X2V2ZW50cyhjb3VudGVyX2JpdHMpOwo+PiAr
Cj4+ICvCoMKgwqAgaWYgKCFhdHRyLT5leGNsdWRlX2hvc3QpIHsKPj4gK8KgwqDCoMKgwqDCoMKg
IGlmIChhcm12OHBtdV9ldmVudF9pc19jaGFpbmVkKGV2ZW50KSkKPj4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgYXJtdjhwbXVfZGlzYWJsZV9jb3VudGVyKGlkeCAtIDEpOwo+PiArwqDCoMKgwqDC
oMKgwqAgYXJtdjhwbXVfZGlzYWJsZV9jb3VudGVyKGlkeCk7Cj4+ICvCoMKgwqAgfQo+IAo+IFNo
b3VsZG4ndCB3ZSBkaXNhYmxlIHRoZSBldmVudHMsIGlycmVzcGVjdGl2ZSBvZiB3aGV0aGVyIGl0
IGlzIGZvciBob3N0Cj4gb3IvYW5kIGd1ZXN0ID8gT3RoZXJ3aXNlIGxvb2tzIGdvb2QgdG8gbWUu
Cj4gCgpJIG1hZGUgdGhlIG9wcG9zaXRlIHJlbWFyayBvbiBvbmUgb2YgdGhlIGVhcmx5IHZlcnNp
b24uIE15IHJlYXNvbmluZyBpcwp0aGF0LCBpZiB3ZSByZWx5IG9uIHRoZSBoeXBlcnZpc29yIHRv
IGVuYWJsZSBldmVudCB0aGF0IGV4Y2x1ZGUgdGhlCmhvc3QsIHdlIHNob3VsZCBhbHNvIHJlbHkg
b24gdGhlIGh5cGVydmlzb3IgZGlzYWJsaW5nIHRoZXNlIGV2ZW50cy4KCkF0IGxlYXN0IGluIG15
IG1pbmQgaXQgbWFrZXMgbW9yZSBzZW5zZSB0aGlzIHdheS4KCkNoZWVycywKCi0tIApKdWxpZW4g
VGhpZXJyeQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
bGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZy
YWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGlu
dXgtYXJtLWtlcm5lbAo=
