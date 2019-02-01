Return-Path: <SRS0=JyYb=QI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C217C282D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 09:36:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5797F20870
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 09:36:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="igB1maqy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5797F20870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=foss.arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=pJu7Oc20omfyYZ5REQeFrTanvRs9W0mwjx0IhHvS+Ms=; b=igB1maqyEtlqiU
	oVjpOQY+g+MTT+WHBqafQOPTbyXPz1bTwtG68X3EE6lVDx8YOZX2TGZ7vaHCrmIYy2hNP1mxRQ358
	kePzw8/XUUe+QzNr1SaMKVs8f+xXJtLnN7SWtzsGc6L6GGuSqPKKclGo2fMLtvgRwfS5FcIDEGtjn
	dmH0r6FunVlMOfDoa5yPuY5L/nZ0aA4q8fjLOGSsIiKbkYfxSPs6yikOC9uyGs4rShabGbb79GloG
	T4KBmE/qLaSLeDXm2fv9eoKPAxGIWwu7Y9fFjFyuZx1sXkROIj7Gm6lDyK5gkYCD+rLUqjhKM4rWr
	ZAaSfPsc627wDqdUxW3A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpVEq-00069f-Uj; Fri, 01 Feb 2019 09:35:56 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpVEn-00069J-TW
 for linux-arm-kernel@lists.infradead.org; Fri, 01 Feb 2019 09:35:55 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B37E215BE;
 Fri,  1 Feb 2019 01:35:53 -0800 (PST)
Received: from e110455-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5F9923F71E;
 Fri,  1 Feb 2019 01:35:53 -0800 (PST)
Received: by e110455-lin.cambridge.arm.com (Postfix, from userid 1000)
 id B56506820DA; Fri,  1 Feb 2019 09:35:51 +0000 (GMT)
Date: Fri, 1 Feb 2019 09:35:51 +0000
From: Liviu Dudau <Liviu.Dudau@foss.arm.com>
To: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] ARM: dts: Augment panel setting for Integrator/CP
Message-ID: <20190201093550.GA23125@e110455-lin.cambridge.arm.com>
References: <20190123075314.3384-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190123075314.3384-1-linus.walleij@linaro.org>
User-Agent: Mutt/1.11.2 (2019-01-07)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190201_013553_973090_5017FCCA 
X-CRM114-Status: GOOD (  22.17  )
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
Cc: Mali DP Maintainers <malidp@foss.arm.com>,
 Liviu Dudau <liviu.dudau@arm.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gV2VkLCBKYW4gMjMsIDIwMTkgYXQgMDg6NTM6MTRBTSArMDEwMCwgTGludXMgV2FsbGVpaiB3
cm90ZToKPiBUaGlzIGFkZHMgdGhlIGFjdHVhbCBWR0EgREFDIGJyaWRnZSB0aGF0IGlzIHVzZWQg
aW4gdGhlCj4gVmVyc2F0aWxlIEFCLCBhbmQgc2V0cyB0aGUgbW9kZSB0byA2NDB4NDgwIFZHQSBh
bmQKPiByb3V0ZXMgdGhlIENMQ0QgcGFkcyBhcHByb3ByaWF0ZWx5Lgo+IAo+IENjOiBMaXZpdSBE
dWRhdSA8bGl2aXUuZHVkYXVAYXJtLmNvbT4KCkFja2VkLWJ5OiBMaXZpdSBEdWRhdSA8bGl2aXUu
ZHVkYXVAYXJtLmNvbT4KCj4gQ2M6IE1hbGkgRFAgTWFpbnRhaW5lcnMgPG1hbGlkcEBmb3NzLmFy
bS5jb20+CgpIbW0sIE1hbGkgRFAgTWFpbnRhaW5lcnMgc2hvdWxkIG5vdCBoYXZlIGVuZGVkIHVw
IGluIHlvdXIgQ2MgbGlzdCBmb3IKdGhpcyBwYXRjaCwgdW5sZXNzIHlvdSBoYXZlIG1hbnVhbGx5
IGFkZGVkIHRoZSBlbWFpbCBhZGRyZXNzLgoKQmVzdCByZWdhcmRzLApMaXZpdQoKPiBTaWduZWQt
b2ZmLWJ5OiBMaW51cyBXYWxsZWlqIDxsaW51cy53YWxsZWlqQGxpbmFyby5vcmc+Cj4gLS0tCj4g
IGFyY2gvYXJtL2Jvb3QvZHRzL2ludGVncmF0b3JjcC5kdHMgfCA4OSArKysrKysrKysrKysrKysr
KysrLS0tLS0tLS0tLS0KPiAgMSBmaWxlIGNoYW5nZWQsIDU3IGluc2VydGlvbnMoKyksIDMyIGRl
bGV0aW9ucygtKQo+IAo+IGRpZmYgLS1naXQgYS9hcmNoL2FybS9ib290L2R0cy9pbnRlZ3JhdG9y
Y3AuZHRzIGIvYXJjaC9hcm0vYm9vdC9kdHMvaW50ZWdyYXRvcmNwLmR0cwo+IGluZGV4IGExODVh
Yjg3NTlmYS4uMDFmYTIyOWUxYmQwIDEwMDY0NAo+IC0tLSBhL2FyY2gvYXJtL2Jvb3QvZHRzL2lu
dGVncmF0b3JjcC5kdHMKPiArKysgYi9hcmNoL2FybS9ib290L2R0cy9pbnRlZ3JhdG9yY3AuZHRz
Cj4gQEAgLTE5Miw2ICsxOTIsNDMgQEAKPiAgCQlpbnRlcnJ1cHRzID0gPDI3PjsKPiAgCX07Cj4g
IAo+ICsJYnJpZGdlIHsKPiArCQljb21wYXRpYmxlID0gInRpLHRoczgxMzRhIiwgInRpLHRoczgx
MzQiOwo+ICsJCSNhZGRyZXNzLWNlbGxzID0gPDE+Owo+ICsJCSNzaXplLWNlbGxzID0gPDA+Owo+
ICsKPiArCQlwb3J0cyB7Cj4gKwkJCSNhZGRyZXNzLWNlbGxzID0gPDE+Owo+ICsJCQkjc2l6ZS1j
ZWxscyA9IDwwPjsKPiArCj4gKwkJCXBvcnRAMCB7Cj4gKwkJCQlyZWcgPSA8MD47Cj4gKwo+ICsJ
CQkJdmdhX2JyaWRnZV9pbjogZW5kcG9pbnQgewo+ICsJCQkJCXJlbW90ZS1lbmRwb2ludCA9IDwm
Y2xjZF9wYWRzX3ZnYV9kYWM+Owo+ICsJCQkJfTsKPiArCQkJfTsKPiArCj4gKwkJCXBvcnRAMSB7
Cj4gKwkJCQlyZWcgPSA8MT47Cj4gKwo+ICsJCQkJdmdhX2JyaWRnZV9vdXQ6IGVuZHBvaW50IHsK
PiArCQkJCQlyZW1vdGUtZW5kcG9pbnQgPSA8JnZnYV9jb25faW4+Owo+ICsJCQkJfTsKPiArCQkJ
fTsKPiArCQl9Owo+ICsJfTsKPiArCj4gKwl2Z2Egewo+ICsJCWNvbXBhdGlibGUgPSAidmdhLWNv
bm5lY3RvciI7Cj4gKwo+ICsJCXBvcnQgewo+ICsJCQl2Z2FfY29uX2luOiBlbmRwb2ludCB7Cj4g
KwkJCQlyZW1vdGUtZW5kcG9pbnQgPSA8JnZnYV9icmlkZ2Vfb3V0PjsKPiArCQkJfTsKPiArCQl9
Owo+ICsJfTsKPiArCj4gIAlmcGdhIHsKPiAgCQkvKgo+ICAJCSAqIFRoZXNlIFByaW1lQ2VsbHMg
YXJlIGF0IHRoZSBzYW1lIGxvY2F0aW9uIGFuZCB1c2luZwo+IEBAIC0yNTQsMzkgKzI5MSwyNyBA
QAo+ICAJCQlpbnRlcnJ1cHRzID0gPDIyPjsKPiAgCQkJY2xvY2tzID0gPCZhdXhvc2M+LCA8JnBj
bGs+Owo+ICAJCQljbG9jay1uYW1lcyA9ICJjbGNkY2xrIiwgImFwYl9wY2xrIjsKPiArCQkJLyog
NjQweDQ4MCAxNmJwcCBAIDI1LjE3NU1IeiBpcyAzNjgyNzQyOCBieXRlcy9zICovCj4gKwkJCW1h
eC1tZW1vcnktYmFuZHdpZHRoID0gPDQwMDAwMDAwPjsKPiAgCj4gLQkJCXBvcnQgewo+IC0JCQkJ
LyoKPiAtCQkJCSAqIFRoZSBWR0EgY29ubmVjdGVkIGlzIGltcGxlbWVudGVkIHdpdGggYQo+IC0J
CQkJICogVEhTODEzNEEgdHJpcGxlIERBQyB0aGF0IGNhbiBiZSBydW4gaW4gMjRiaXQKPiAtCQkJ
CSAqIG9yIDE2Yml0IFJHQiBtb2RlLgo+IC0JCQkJICovCj4gLQkJCQljbGNkX3BhZHM6IGVuZHBv
aW50IHsKPiAtCQkJCQlyZW1vdGUtZW5kcG9pbnQgPSA8JmNsY2RfcGFuZWw+Owo+IC0JCQkJCWFy
bSxwbDExeCx0ZnQtcjBnMGIwLXBhZHMgPSA8MSA3IDEzPjsKPiAtCQkJCX07Cj4gLQkJCX07Cj4g
LQo+IC0JCQlwYW5lbCB7Cj4gLQkJCQljb21wYXRpYmxlID0gInBhbmVsLWRwaSI7Cj4gLQo+IC0J
CQkJcG9ydCB7Cj4gLQkJCQkJY2xjZF9wYW5lbDogZW5kcG9pbnQgewo+IC0JCQkJCQlyZW1vdGUt
ZW5kcG9pbnQgPSA8JmNsY2RfcGFkcz47Cj4gLQkJCQkJfTsKPiAtCQkJCX07Cj4gLQo+IC0JCQkJ
LyogU3RhbmRhcmQgNjQweDQ4MCBWR0EgdGltaW5ncyAqLwo+IC0JCQkJcGFuZWwtdGltaW5nIHsK
PiAtCQkJCQljbG9jay1mcmVxdWVuY3kgPSA8MjUxNzUwMDA+Owo+IC0JCQkJCWhhY3RpdmUgPSA8
NjQwPjsKPiAtCQkJCQloYmFjay1wb3JjaCA9IDw0OD47Cj4gLQkJCQkJaGZyb250LXBvcmNoID0g
PDE2PjsKPiAtCQkJCQloc3luYy1sZW4gPSA8OTY+Owo+IC0JCQkJCXZhY3RpdmUgPSA8NDgwPjsK
PiAtCQkJCQl2YmFjay1wb3JjaCA9IDwzMz47Cj4gLQkJCQkJdmZyb250LXBvcmNoID0gPDEwPjsK
PiAtCQkJCQl2c3luYy1sZW4gPSA8Mj47Cj4gKwkJCS8qCj4gKwkJCSAqIFRoaXMgcG9ydCBpcyBy
b3V0ZWQgdGhyb3VnaCBhIFBMRCAoUHJvZ3JhbW1hYmxlCj4gKwkJCSAqIExvZ2ljIERldmljZSkg
dGhhdCByb3V0ZXMgdGhlIG91dHB1dCBmcm9tIHRoZSBDTENECj4gKwkJCSAqIChhZnRlciB0cmFu
c2Zvcm1hdGlvbnMpIHRvIHRoZSBWR0EgREFDIGFuZCBhbHNvIGFuCj4gKwkJCSAqIGV4dGVybmFs
IHBhbmVsIGNvbm5lY3Rvci4gVGhlIFBMRCBpcyBlc3NlbnRpYWwgZm9yCj4gKwkJCSAqIHN1cHBv
cnRpbmcgUkdCNTY1L0JHUjU2NS4KPiArCQkJICoKPiArCQkJICogVGhlIHNpZ25hbHMgZnJvbSB0
aGUgcG9ydCB0aHVzIHJlYWNoZXMgdHdvIGVuZHBvaW50cy4KPiArCQkJICogVGhlIFBMRCBpcyBt
YW5hZ2VkIHRocm91Z2ggYSBmZXcgc3BlY2lhbCBiaXRzIGluIHRoZQo+ICsJCQkgKiBGUEdBICJz
eXNyZWciLgo+ICsJCQkgKgo+ICsJCQkgKiBUaGlzIGFycmFuZ2VtZW50IGNhbiBiZSBjbGVhcmx5
IHNlZW4gaW4KPiArCQkJICogQVJNIERVSSAwMjI1RCwgcGFnZSAzLTQxLCBmaWd1cmUgMy0xOS4K
PiArCQkJICovCj4gKwkJCXBvcnRAMCB7Cj4gKwkJCQljbGNkX3BhZHNfdmdhX2RhYzogZW5kcG9p
bnQgewo+ICsJCQkJCXJlbW90ZS1lbmRwb2ludCA9IDwmdmdhX2JyaWRnZV9pbj47Cj4gKwkJCQkJ
YXJtLHBsMTF4LHRmdC1yMGcwYjAtcGFkcyA9IDwwIDggMTY+Owo+ICAJCQkJfTsKPiAgCQkJfTsK
PiAgCQl9Owo+IC0tIAo+IDIuMjAuMQo+IAoKLS0gCj09PT09PT09PT09PT09PT09PT09CnwgSSB3
b3VsZCBsaWtlIHRvIHwKfCBmaXggdGhlIHdvcmxkLCAgfAp8IGJ1dCB0aGV5J3JlIG5vdCB8Cnwg
Z2l2aW5nIG1lIHRoZSAgIHwKIFwgc291cmNlIGNvZGUhICAvCiAgLS0tLS0tLS0tLS0tLS0tCiAg
ICDCr1xfKOODhClfL8KvCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxp
c3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0
aW5mby9saW51eC1hcm0ta2VybmVsCg==
