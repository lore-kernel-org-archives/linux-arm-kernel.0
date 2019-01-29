Return-Path: <SRS0=P47x=QF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58E18C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 18:10:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2AB1021848
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 18:10:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="YK+Ei4jq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AB1021848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=iV2nz+xK8YGDuJwUO00Q6ClcWF/IaEg7agUfg1ClmfM=; b=YK+Ei4jqv0YI7z
	MhP3j5Dpy2HYfixLb0YcV3s8Ho5pkBvZ+xF6QGgMa9/RKeVvuiyn95olILfKhG4CBEO1Rh5arPVFR
	H29U0O22kPlh7VdUoyTeRUznvTAYPlKuvJm26P9LknheiVhVMdijjpK3OS3ZNSaRhFUnIPS16XnaS
	KuV3jwV3A9vVnlkQ6qowTwN38GHieZcan1panyrzNDUboR1JfiiDfLdycUU3N5G6nXBx+KkBdWT4H
	4KW4QUWyT6sIHXPZlTJXVhmIjl0wIVGblrN9sdeCtItux7Tc42GfYgWGJOqv7JQFYy/f5P5IDKL+Z
	Wi+ex+jKAZ37BTtCGc5w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goXqL-0007Et-HX; Tue, 29 Jan 2019 18:10:41 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goXqI-0007Da-ER
 for linux-arm-kernel@lists.infradead.org; Tue, 29 Jan 2019 18:10:39 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3E167EBD;
 Tue, 29 Jan 2019 10:10:36 -0800 (PST)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.113])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id
 0AB333F557; Tue, 29 Jan 2019 10:10:34 -0800 (PST)
Date: Tue, 29 Jan 2019 18:10:32 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: "Zhang, Lei" <zhang.lei@jp.fujitsu.com>
Subject: Re: [PATCH v3 0/1] arm64: Add workaround for Fujitsu A64FX erratum
 010001
Message-ID: <20190129181032.GC224095@arrakis.emea.arm.com>
References: <8898674D84E3B24BA3A2D289B872026A6A2C04E6@G01JPEXMBKW03>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <8898674D84E3B24BA3A2D289B872026A6A2C04E6@G01JPEXMBKW03>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190129_101038_493816_DD88CD10 
X-CRM114-Status: GOOD (  23.24  )
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
Cc: 'Mark Rutland' <mark.rutland@arm.com>,
 "'james.morse@arm.com'" <james.morse@arm.com>,
 "'will.deacon@arm.com'" <will.deacon@arm.com>,
 "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
 "'linux-arm-kernel@lists.infradead.org'"
 <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGksCgpDb3VsZCB5b3UgcGxlYXNlIGNvcHkgdGhlIHdob2xlIGRlc2NyaXB0aW9uIGZyb20gdGhl
IGNvdmVyIGxldHRlciB0byB0aGUKYWN0dWFsIHBhdGNoIGFuZCBvbmx5IHNlbmQgb25lIGVtYWls
IChmdWxsIGRlc2NyaXB0aW9uIGFzIGluIGhlcmUKdG9nZXRoZXIgd2l0aCB0aGUgcGF0Y2gpPyBJ
ZiB3ZSBjb21taXQgdGhpcyB0byB0aGUga2VybmVsLCBpdCB3b3VsZCBiZQp1c2VmdWwgdG8gaGF2
ZSB0aGUgaW5mb3JtYXRpb24gaW4gdGhlIGxvZyBmb3IgcmVmZXJlbmNlIGxhdGVyIG9uLgoKTW9y
ZSBjb21tZW50cyBiZWxvdzoKCk9uIFR1ZSwgSmFuIDI5LCAyMDE5IGF0IDEyOjI5OjU4UE0gKzAw
MDAsIFpoYW5nLCBMZWkgd3JvdGU6Cj4gT24gc29tZSB2YXJpYW50cyBvZiB0aGUgRnVqaXRzdS1B
NjRGWCBjb3JlcyB2ZXIoMS4wLCAxLjEpLCAgCj4gbWVtb3J5IGFjY2Vzc2VzIG1heSBjYXVzZSB1
bmRlZmluZWQgZmF1bHQgKERhdGEgYWJvcnQsIERGU0M9MGIxMTExMTEpLgo+IFRoaXMgcHJvYmxl
bSB3aWxsIGJlIGZpeGVkIGJ5IG5leHQgdmVyc2lvbiBvZiBGdWppdHN1LUE2NEZYLgo+IAo+IFRo
aXMgZmF1bHQgb2NjdXJzIHVuZGVyIGEgc3BlY2lmaWMgaGFyZHdhcmUgY29uZGl0aW9uIAo+IHdo
ZW4gYSBsb2FkL3N0b3JlIGluc3RydWN0aW9uIHBlcmZvcm0gYW4gYWRkcmVzcyB0cmFuc2xhdGlv
biB1c2luZzoKPiAgIGNhc2UtMSAgVFRCUjBfRUwxIHdpdGggVENSX0VMMS5ORkQwID09IDEuCj4g
ICBjYXNlLTIgIFRUQlIwX0VMMiB3aXRoIFRDUl9FTDIuTkZEMCA9PSAxLgo+ICAgY2FzZS0zICBU
VEJSMV9FTDEgd2l0aCBUQ1JfRUwxLk5GRDEgPT0gMS4KPiAgIGNhc2UtNCAgVFRCUjFfRUwyIHdp
dGggVENSX0VMMi5ORkQxID09IDEuCj4gQW5kIHRoaXMgZmF1bHQgb2NjdXJzIGNvbXBsZXRlbHkg
c3B1cmlvdXMuCgpTbyB0aGlzIGxvb2tzIGxpa2UgbmV3IGluZm9ybWF0aW9uIG9uIHRoZSBoYXJk
d2FyZSBiZWhhdmlvdXIgc2luY2UgdGhlCnYyIG9mIHRoZSBwYXRjaC4gQ2FuIHRoaXMgZmF1bHQg
b2NjdXIgZm9yIGFueSB0eXBlIG9mIGluc3RydWN0aW9uCmFjY2Vzc2luZyB0aGUgbWVtb3J5IG9y
IG9ubHkgZm9yIFNWRSBpbnN0cnVjdGlvbnM/Cgo+IFNpbmNlIFRDUl9FTHguTkZEMSBpcyBzZXQg
dG8gJzEnIGF0IHRoZSBrZXJuZWwgaW4gdmVyc2lvbnMgCj4gcGFzdCA0LjE3LCB0aGUgY2FzZS0z
IG9yIGNhc2UtNCBtYXkgaGFwcGVuLgo+IAo+IFRoaXMgZmF1bHQgY2FuIGJlIHRha2VuIG9ubHkg
YXQgc3RhZ2UtMSwgCj4gc28gdGhpcyBmYXVsdCBpcyB0YWtlbiBmcm9tIEVMMCB0byBFTDEvRUwy
LCBmcm9tIEVMMSB0byBFTDEsIAo+IG9yIGZyb20gRUwyIHRvIEVMMi4KPiAKPiBJIHdvdWxkIGxp
a2UgdG8gcG9zdCBhIHdvcmthcm91bmQgdG8gYXZvaWQgdGhpcyBwcm9ibGVtIG9uIAo+IGV4aXN0
aW5nIEZ1aml0c3UtQTY0RlggdmVyc2lvbi4KCkhvdyBsaWtlbHkgaXMgaXQgdG8gdHJpZ2dlciB0
aGlzIGVycmF0dW0/IEluIG90aGVyIHdvcmRzLCBhcmVuJ3Qgd2UKYmV0dGVyIG9mZiB3aXRoIGEg
c3B1cmlvdXMgZmF1bHQgdGhhdCB3ZSBpZ25vcmUgcmF0aGVyIHRoYW4gdG9nZ2xpbmcgdGhlClRD
Ul9FTHguTkZEMSBiaXQ/Cgo+IFRoZXJlIGFyZSAyIHBvaW50cyBpbiB0aGlzIHdvcmthcm91bmQu
Cj4gUG9pbnQxOiB0cmFwIGZyb20gRUwxIHRvIEVMMSwgRUwyIHRvIEVMMgo+IFNldCAnMCcgdG8g
VENSX0VMeC5ORkQxaW4ga2VybmVsLWVudHJ5LCAKPiBhbmQgc2V0ICcxJyBpbiBrZXJuZWwtZXhp
dC4KPiAKPiBGcm9tIHRoZSB2aWV3IHBvaW50IG9mIEFSTSBzcGVjaWZpY2F0aW9uLCB0aGVyZSBp
cyBubyBwcm9ibGVtIHRvIAo+IHJlc2V0IFRDUl9FTHgue05GRDAsTkZEMX0gd2hpbGUgaW4gRUwx
L0VMMiwgYmVjYXVzZSAKPiBUQ1JfRUx4LntORkQwLE5GRDF9IGNvbnRyb2xzIHdoZXRoZXIgdG8g
cGVyZm9ybSBhIHRyYW5zbGF0aW9uIAo+IHRhYmxlIHdhbGsgaW4gcmVzcG9uc2UgdG8gYW4gYWNj
ZXNzIGZyb20gRUwwLgoKVGhlIHByb2JsZW0gaXMgdGhhdCB0aGlzIGJpdCBtYXkgYmUgY2FjaGVk
IGluIHRoZSBUTEIgKEkgaGF2ZW4ndCBjaGVja2VkCnRoZSBBUk0gQVJNIGJ1dCB0aGF0J3MgdXN1
YWxseSB0aGUgY2FzZSB3aXRoIHRoZSBUQ1JfRUx4IGJpdHMpLiBJZgp0aGF0J3MgdGhlIGNhc2Us
IHlvdSBjYW4ndCBndWFyYW50ZWUgYSBjaGFuZ2UgdW5sZXNzIHlvdSBhbHNvIHBlcmZvcm0gYQpU
TEJJIFZNQUxMLiBBcmd1YWJseSwgaWYgRnVqaXRzdSdzIG1pY3JvYXJjaGl0ZWN0dXJlIGRvZXNu
J3QgY2FjaGUgdGhlCk5GRCBiaXRzIGluIHRoZSBUTEIsIHdlIGNvdWxkIGFwcGx5IHRoZSB3b3Jr
YXJvdW5kIGJ1dCBJJ2QgcmF0aGVyIGhhdmUKdGhlIHNwdXJpb3VzIHRyYXAgaWYgaXQncyBub3Qg
dG9vIG9mdGVuLgoKPiBJIGNvbmZpcm1lZCB0aGF0Ogo+IOODu1RoZXJlIGlzIG5vIGxvYWQvc3Rv
cmUgaW5zdHJ1Y3Rpb24gYmV0d2VlbiAKPiAgIHRyYW1wX3ZlbnRyeSBhbmQgc2V0dGluZyBUQ1Jf
RUx4Lk5GRDEgdG8gJzAnLgo+IOODu1RoZXJlIGlzIG5vIGxvYWQvc3RvcmUgaW5zdHJ1Y3Rpb24g
YmV0d2VlbiAKPiAgIHNldHRpbmcgVENSX0VMeC5ORkQxIHRvICcxJyBhbmQgdHJhbXBfZXhpdC4K
CkNvdWxkIHNwZWN1bGF0aXZlIGxvYWRzIGFsc28gdHJpZ2dlciB0aGlzPyBBbm90aGVyIG9wdGlv
biB3b3VsZCBiZSB0bwp0b2dnbGUgaXQgZHVyaW5nIGtlcm5lbF9uZW9uX2JlZ2luL2VuZCAod2l0
aCB0aGUgY2F2ZWF0IG9mIFRMQkkgYXMKbWVudGlvbmVkIGFib3ZlKS4KCi0tIApDYXRhbGluCgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0t
a2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcK
aHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2Vy
bmVsCg==
