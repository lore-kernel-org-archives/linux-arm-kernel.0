Return-Path: <SRS0=Odjb=PR=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57D97C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 10:49:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 275B420883
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 10:49:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="u6d+LglD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 275B420883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=vK+wdtke/FJ3qiXaADOd/qIR26saPTUsZpV6z+Y4O5M=; b=u6d+LglDbe2mX1
	swBSQd1sJos4jrfLbEsTLRk9viB0XZis/G4UlVHHLMo5GX1kYDzWKRd8yLAEJz5zLCGu8BHKvQOWF
	Db1rdKKdWW6xHRVdwmTzxuhtzmpXJ+L5ccxer3Dh8uSmQjYGR3gH/7mvvBhu7dzTBHblTLEmWWfLI
	i3atHwsOJJmGsgGLWq+//YdhRpzDOmTrbwzuJIMVvU3+vEnF1IMEoDVHxl9P26Mlbb84QseheUK6u
	+bPZFgs+fvb6K40kQe/Hv4Y267kwySzZAlPpM+O5RKIKewyJROlptNviBhJrPHZKAh3JCqJnDkCM5
	iH887fVvdMqUpO+1HGUg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghBQ1-0005KF-HE; Wed, 09 Jan 2019 10:49:05 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghBPy-0005Jl-1n
 for linux-arm-kernel@lists.infradead.org; Wed, 09 Jan 2019 10:49:04 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0B18AA78;
 Wed,  9 Jan 2019 02:49:00 -0800 (PST)
Received: from localhost (chrdal02-desktop.copenhagen.arm.com [10.32.144.41])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id
 962043F70D; Wed,  9 Jan 2019 02:48:59 -0800 (PST)
Date: Wed, 9 Jan 2019 11:48:57 +0100
From: Christoffer Dall <christoffer.dall@arm.com>
To: Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: [kvmarm:kvm-arm64/nv-wip-v5.0-rc1 4/75]
 arch/arm/kvm/../../../virt/kvm/arm/arch_timer.c:700:7: error:
 'SYS_CNTP_TVAL_EL0' undeclared
Message-ID: <20190109104857.GT10769@e113682-lin.lund.arm.com>
References: <201901091219.igdmvhpC%fengguang.wu@intel.com>
 <a82a7868-f3c0-0b3e-d0b7-182992c268fa@arm.com>
 <8fd0977c-9ca1-8ad8-a6b7-e36e115745b8@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <8fd0977c-9ca1-8ad8-a6b7-e36e115745b8@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190109_024902_098579_270589D6 
X-CRM114-Status: GOOD (  24.32  )
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
Cc: =?utf-8?B?QW5kcsOp?= Przywara <andre.przywara@arm.com>,
 kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gV2VkLCBKYW4gMDksIDIwMTkgYXQgMTA6MDk6NTFBTSArMDAwMCwgTWFyYyBaeW5naWVyIHdy
b3RlOgo+IE9uIDA5LzAxLzIwMTkgMDk6MTMsIEFuZHLDqSBQcnp5d2FyYSB3cm90ZToKPiA+IE9u
IDA5LzAxLzIwMTkgMDQ6NDAsIGtidWlsZCB0ZXN0IHJvYm90IHdyb3RlOgo+ID4gCj4gPiBNYXJj
LCBDaHJpc3RvZmZlciwKPiA+IAo+ID4+IHRyZWU6ICAgaHR0cHM6Ly9naXQua2VybmVsLm9yZy9w
dWIvc2NtL2xpbnV4L2tlcm5lbC9naXQva3ZtYXJtL2t2bWFybS5naXQga3ZtLWFybTY0L252LXdp
cC12NS4wLXJjMQo+ID4+IGhlYWQ6ICAgNjg4YzM4NmNhMDk2ZjJjMWYyZWVlMzg2Njk3NTg2Yzg4
ZGY1ZDViYwo+ID4+IGNvbW1pdDogMmIxMjY1YzU4YTg3M2Q5MTdlOTlhYzc2MmUyNDNjMTI3NDQ4
MWRiZiBbNC83NV0gS1ZNOiBhcm0vYXJtNjQ6IGNvbnNvbGlkYXRlIGFyY2ggdGltZXIgdHJhcCBo
YW5kbGVycwo+ID4+IGNvbmZpZzogYXJtLWF4bTU1eHhfZGVmY29uZmlnIChhdHRhY2hlZCBhcyAu
Y29uZmlnKQo+ID4+IGNvbXBpbGVyOiBhcm0tbGludXgtZ251ZWFiaS1nY2MgKERlYmlhbiA3LjIu
MC0xMSkgNy4yLjAKPiA+PiByZXByb2R1Y2U6Cj4gPj4gICAgICAgICB3Z2V0IGh0dHBzOi8vcmF3
LmdpdGh1YnVzZXJjb250ZW50LmNvbS9pbnRlbC9sa3AtdGVzdHMvbWFzdGVyL3NiaW4vbWFrZS5j
cm9zcyAtTyB+L2Jpbi9tYWtlLmNyb3NzCj4gPj4gICAgICAgICBjaG1vZCAreCB+L2Jpbi9tYWtl
LmNyb3NzCj4gPj4gICAgICAgICBnaXQgY2hlY2tvdXQgMmIxMjY1YzU4YTg3M2Q5MTdlOTlhYzc2
MmUyNDNjMTI3NDQ4MWRiZgo+ID4+ICAgICAgICAgIyBzYXZlIHRoZSBhdHRhY2hlZCAuY29uZmln
IHRvIGxpbnV4IGJ1aWxkIHRyZWUKPiA+PiAgICAgICAgIEdDQ19WRVJTSU9OPTcuMi4wIG1ha2Uu
Y3Jvc3MgQVJDSD1hcm0gCj4gPj4KPiA+PiBBbGwgZXJyb3JzIChuZXcgb25lcyBwcmVmaXhlZCBi
eSA+Pik6Cj4gPiAKPiA+IEkgd2FzIGxvb2tpbmcgYXQgdGhpcyB5ZXN0ZXJkYXk6IEl0J3MgYSBi
aXQgbmFzdHksIGRvbid0IGtub3cgYSBnb29kCj4gPiBzb2x1dGlvbiBiZXNpZGUgYnJpbmdpbmcg
YmFjayB0aGlzIHBhcnQgb2YgbXkgb3JpZ2luYWwgdGltZXIgcmV3b3JrIHNlcmllcy4KPiA+IFRo
ZSBwcm9ibGVtIGlzIHRoYXQgdGhvc2Ugc3ltYm9scyBjb250YWlucyB0aGUgQWFyY2g2NCBzcGVj
aWZpYwo+ID4gKGluc3RydWN0aW9uKSBlbmNvZGluZyBvZiB0aGUgdGltZXIgcmVnaXN0ZXJzLCBw
bHVzIHdlIG5lZWQgdGhlIEFBcmNoMzIKPiA+IGVuY29kaW5ncyBmb3IgMzItb24tNjQgZ3Vlc3Rz
Lgo+IAo+IFdoeT8gVGhlcmUgaXMgZXhhY3RseSBvbmUgdGltZXIgdGhhdCBuZWVkcyB0cmFwcGlu
ZyBmb3IgQUFyY2gzMiAodGhlIEVMMQo+IHBoeXNpY2FsIHRpbWVyKS4gQWxsIHdlIG5lZWQgaXM6
Cj4gCj4gLSB0aGUgU1lTX0FBUkNIMzJfQ05UUF8qIGVuY29kaW5ncyBvbiAzMmJpdAo+IC0gc29t
ZSBDUFAgbWFnaWMgdG8gcHJldmVudCB0aGUgY29tcGlsYXRpb24gZnJvbSBicmVha2luZwo+IAo+
ID4gCj4gPiBUaGF0J3Mgd2h5IEkgdXNlZCB0aGUgZ2VuZXJpYyBVQVBJIGVuY29kaW5nIGZvciB0
aGUgcmVnaXN0ZXJzLCBiZWNhdXNlCj4gPiB3ZSBvbmx5IG5lZWQgKnNvbWUqIGlkZW50aWZpY2F0
aW9uIGZvciB0aGVtLCBpdCBkb2Vzbid0IG5lZWQgdG8gYmUKPiA+IHNvbWV0aGluZyBkZWZpbmVk
IGJ5IHRoZSBhcmNoaXRlY3R1cmUuCj4gCj4gSSBkaXNhZ3JlZS4gQnkgZG9pbmcgc28sIHlvdSdy
ZSBjb25mbGF0aW5nIHVzZXJzcGFjZSBhY2Nlc3MgYW5kCj4gdHJhcHBpbmcsIHdoaWNoIGhhcyBw
cm92ZWQgdG8gYmUgYSBiYWQgaWRlYSBpbiB0aGUgcGFzdC4gRm9yIGV4YW1wbGUsCj4geW91J2Qg
ZW5kLXVwIGhhdmluZyBib3RoIENWQUwgYW5kIFRWQUwgaW4gVUFQSSwgd2hpY2ggaXMgbm90IHNv
bWV0aGluZwo+IEknbSBrZWVuIHRvIGhhdmUuIE9uIHRoZSBvdGhlciBoYW5kLCB0aGUgdHJhcHBp
bmcgZnVuY3Rpb24gZG8gbmVlZCB0byBiZQo+IGFibGUgdG8gaGFuZGxlIHRoZXNlLgo+IApJIHRo
aW5rIGl0IHByb2JhYmx5IG1ha2VzIHNlbnNlIHRvIGhhdmUgdGhlIHN5c3JlZyBlbmNvZGluZyBz
dHVmZiBpbiB0aGUKYXJjaC1zcGVjaWZpYyBmaWxlcywgYW5kIGhhdmUgYW4gaW5kaXJlY3Rpb24g
aW4gc3lzX3JlZ3MuYyBhbmQgY29wcm9jLmMKd2hpY2ggJ3RyYW5zbGF0ZXMnIGZyb20gYSBzeXN0
ZW0gcmVnaXN0ZXIgdG8gc29tZSBnZW5lcmljIGFyY2ggdGltZXIKZGVmaW5lIGlkZW50aWZ5aW5n
IGEgJ3RpbWVyJy4KCkkgdGhpbmsgdGhlIG1ham9yIGJyZWFrYWdlIGluIHRoZSBwcmV2aW91cyBk
ZXNpZ24gd2FzIHRvIHVzZSB0aGUgc2FtZQoqZnVuY3Rpb25zKiBmb3IgdWFjY2VzcyBhbmQgZm9y
IHN5c3JlZ3MgdHJhcHMsIGJ1dCBJIGRvbid0IHRoaW5rIGl0IHdhcwpuZWNlc3NhcmlseSBhIHBy
b2JsZW0gdG8gdXNlIHRoZSBzYW1lIGRlZmluaXRpb25zIHRvIGlkZW50aWZ5IGEgdGltZXIuCgpU
aGF0IG9mIGNvdXNlIGxlYXZlcyB0aGUgcHJvYmxlbSBvZiBob3cgdG8gaWRlbnRpZnkgYSByZWdp
c3RlciB3aXRoaW4gYQp0aW1lci4gIENvdWxkIHdlIGRvIHNvbWV0aGluZyBhcyBicmFpbmRlYWQg
YXM6CgoKZGlmZiAtLWdpdCBhL2luY2x1ZGUva3ZtL2FybV9hcmNoX3RpbWVyLmggYi9pbmNsdWRl
L2t2bS9hcm1fYXJjaF90aW1lci5oCmluZGV4IGNlNDQxZGRhNDEyYy4uMWQ3YmQ0NTJlNWZkIDEw
MDY0NAotLS0gYS9pbmNsdWRlL2t2bS9hcm1fYXJjaF90aW1lci5oCisrKyBiL2luY2x1ZGUva3Zt
L2FybV9hcmNoX3RpbWVyLmgKQEAgLTMyLDYgKzMyLDEzIEBAIGVudW0ga3ZtX2FyY2hfdGltZXJz
IHsKIAlOUl9LVk1fVElNRVJTCiB9OwogCitlbnVtIGFyY2hfdGltZXJfcmVnIHsKKwlBUkNIX1RJ
TUVSX1JFR19DVEwsCisJQVJDSF9USU1FUl9SRUdfQ1ZBTCwKKwlBUkNIX1RJTUVSX1JFR19UVkFM
LAorCUFSQ0hfVElNRVJfUkVHX0NOVAorfQorCiBzdHJ1Y3QgYXJjaF90aW1lcl9jb250ZXh0IHsK
IAlzdHJ1Y3Qga3ZtX3ZjcHUJCQkqdmNwdTsKIApAQCAtODYsOCArOTMsMTMgQEAgYm9vbCBrdm1f
dGltZXJfc2hvdWxkX25vdGlmeV91c2VyKHN0cnVjdCBrdm1fdmNwdSAqdmNwdSk7CiB2b2lkIGt2
bV90aW1lcl91cGRhdGVfcnVuKHN0cnVjdCBrdm1fdmNwdSAqdmNwdSk7CiB2b2lkIGt2bV90aW1l
cl92Y3B1X3Rlcm1pbmF0ZShzdHJ1Y3Qga3ZtX3ZjcHUgKnZjcHUpOwogCi11NjQga3ZtX2FybV90
aW1lcl9nZXRfcmVnKHN0cnVjdCBrdm1fdmNwdSAqLCB1NjQgcmVnaWQpOwotaW50IGt2bV9hcm1f
dGltZXJfc2V0X3JlZyhzdHJ1Y3Qga3ZtX3ZjcHUgKiwgdTY0IHJlZ2lkLCB1NjQgdmFsdWUpOwor
dTY0IGt2bV9hcm1fdGltZXJfZ2V0X3JlZyhzdHJ1Y3Qga3ZtX3ZjcHUgKiwKKwkJCSAgZW51bSBr
dm1fYXJjaF90aW1lcnMgdGltZXIsCisJCQkgIGVudW0gYXJjaF90aW1lcl9yZWcgcmVnKTsKK2lu
dCBrdm1fYXJtX3RpbWVyX3NldF9yZWcoc3RydWN0IGt2bV92Y3B1ICosCisJCQkgIGVudW0ga3Zt
X2FyY2hfdGltZXJzIHRpbWVyLAorCQkJICBlbnVtIGFyY2hfdGltZXJfcmVnIHJlZywKKwkJCSAg
dTY0IHZhbHVlKTsKIAogdTY0IGt2bV9hcm1fdGltZXJfcmVhZF9zeXNyZWcoc3RydWN0IGt2bV92
Y3B1ICp2Y3B1LCB1MzIgc3IpOwogdm9pZCBrdm1fYXJtX3RpbWVyX3dyaXRlX3N5c3JlZyhzdHJ1
Y3Qga3ZtX3ZjcHUgKnZjcHUsIHUzMiBzciwgdTY0IHZhbCk7CgoKVGhhbmtzLAoKICAgIENocmlz
dG9mZmVyCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwps
aW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJh
ZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51
eC1hcm0ta2VybmVsCg==
