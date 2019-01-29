Return-Path: <SRS0=P47x=QF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67B1BC282C7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 17:27:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3962420989
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 17:27:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="T43fs+iD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3962420989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=h+8jBeItdX/UOW3bv5hH9A8xC/x95KmHeAIsT4AQWAs=; b=T43fs+iDP7cM+8
	bk/heoc6cBapz8WQ+BoSMzdRoBJLp9L9eAYZnHbRw3uO6UNGkbUwMhKnjklEy57TJM+wtp0OtIA9r
	pOJB9trL0CBm+tA3s/SuvT+QvohdTR4qXW278ou/qfpAQhBEK6ZZ655KYGA7TZZD4cBjoBjUmi3lc
	zkM/akJYAAEOc4tmkv4NPMMDwFwl+byQH5L5cQa7ui18dHi4ytST5fdQhxaWT9gA8V4QQnntWeGAC
	4+wKgXtCM/N/DSqCYKGSesQuAQhviUWz456SHz+krtuo8yFyJx9aNOzVux1MkUP1AthrbwaME9asS
	lAD4yntZx+fRLmvFFaEw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goXAG-0003JM-NF; Tue, 29 Jan 2019 17:27:12 +0000
Received: from muru.com ([72.249.23.125])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goXAE-0003Iz-BU
 for linux-arm-kernel@lists.infradead.org; Tue, 29 Jan 2019 17:27:11 +0000
Received: from atomide.com (localhost [127.0.0.1])
 by muru.com (Postfix) with ESMTPS id 29F31804F;
 Tue, 29 Jan 2019 17:27:18 +0000 (UTC)
Date: Tue, 29 Jan 2019 09:27:06 -0800
From: Tony Lindgren <tony@atomide.com>
To: Sebastian Reichel <sre@kernel.org>
Subject: Re: New underflow of regulator enable count warnings in v5.0-rc1
Message-ID: <20190129172706.GE5720@atomide.com>
References: <20190129164813.GA5720@atomide.com>
 <20190129171844.n6wflw4ehfdy3izs@earth.universe>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190129171844.n6wflw4ehfdy3izs@earth.universe>
User-Agent: Mutt/1.11.2 (2019-01-07)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190129_092710_431763_74E77758 
X-CRM114-Status: GOOD (  11.67  )
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
Cc: linux-omap@vger.kernel.org, Mark Brown <broonie@kernel.org>,
 Douglas Anderson <dianders@chromium.org>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

KiBTZWJhc3RpYW4gUmVpY2hlbCA8c3JlQGtlcm5lbC5vcmc+IFsxOTAxMjkgMTc6MThdOgo+IEhp
LAo+IAo+IE9uIFR1ZSwgSmFuIDI5LCAyMDE5IGF0IDA4OjQ4OjEzQU0gLTA4MDAsIFRvbnkgTGlu
ZGdyZW4gd3JvdGU6Cj4gPiBMb29rcyBsaWtlIGNvbW1pdCA1NDUxNzgxZGFkZjggKCJyZWd1bGF0
b3I6IGNvcmU6IE9ubHkgY291bnQgbG9hZCBmb3IKPiA+IGVuYWJsZWQgY29uc3VtZXJzIikgc3Rh
cnRlZCBzaG93aW5nIG5ldyB3YXJuaW5ncyB3aXRoIHY1LjAtcmMgY3ljbGU6Cj4gPiAKPiA+IHJl
Z3VsYXRvci1kdW1teTogVW5kZXJmbG93IG9mIHJlZ3VsYXRvciBlbmFibGUgY291bnQKPiA+IAo+
ID4gSSdtIHNlZWluZyB0aGlzIGF0IGxlYXN0IHdpdGggbXkgcHdtLXZpYnJhIHRlc3QgY2FzZToK
PiA+IAo+ID4gIyBydW1ibGUtdGVzdCAvZGV2L2lucHV0L2J5LXBhdGgvcGxhdGZvcm0tdmlicmF0
b3ItZXZlbnQgMHhmZmZmCj4gPiBwd20tdmlicmF0b3IgdmlicmF0b3I6IHZpYnJhdG9yIHN1cHBs
eSB2Y2Mgbm90IGZvdW5kLCB1c2luZyBkdW1teSByZWd1bGF0b3IKPiA+IGlucHV0OiBwd20tdmli
cmF0b3IgYXMgL2RldmljZXMvcGxhdGZvcm0vdmlicmF0b3IvaW5wdXQvaW5wdXQ0Cj4gPiByZWd1
bGF0b3ItZHVtbXk6IFVuZGVyZmxvdyBvZiByZWd1bGF0b3IgZW5hYmxlIGNvdW50Cj4gPiBVcGxv
YWQgcnVtYmxlIGVmZmVjdC4uLiBpZD0wCj4gPiByZWd1bGF0b3ItZHVtbXk6IFVuZGVyZmxvdyBv
ZiByZWd1bGF0b3IgZW5hYmxlIGNvdW50Cj4gPiAKPiA+IEFyZSB0aGVzZSBib2d1cyB3YXJuaW5n
cyBmb3IgZHVtbXkgcmVndWxhdG9yIG9yIGRvIHdlIGhhdmUKPiA+IHJlYWwgdW5wYWlyZWQgcmVn
dWxhdG9yIGNhbGxzIG9yIHNvbWV3aGVyZT8KPiAKPiBUaGVyZSBhcmUgcmVhbCB1bnBhaXJlZCBy
ZWd1bGF0b3IgY2FsbHMgaW4gdGhlIHB3bS12aWJyYXRvciBkcml2ZXIsCj4gdGhhdCBJIGRpZCBu
b3Qgbm90aWNlIHdoZW4gSSB3cm90ZSB0aGUgZHJpdmVyIDooLiBHb29kIG5ld3MgaXMsIHRoYXQK
PiBQYXdlxYIgQ2htaWVsIGFuZCBKb25hdGhhbiBCYWtrZXIgYXJlIGFscmVhZHkgd29ya2luZyBv
biBmaXhpbmcgbXkgbWVzczoKPiAKPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9wYXRjaHdvcmsv
cGF0Y2gvMTAzMjc1OS8KCk9LIGdvb2QgdG8gaGVhci4KCj4gT24gRHJvaWQgNCBpdCdzIGEgZHVt
bXkgcmVndWxhdG9yLCBzaW5jZSBJIGRpZCBub3Qga25vdyB3aGF0Cj4gcmVndWxhdG9yIGlzIGJl
aW5nIHVzZWQgdG8gc3VwcGx5IHRoZSB2aWJyYXRvci4gUHJvYmFibHkgZGlyZWN0bHkKPiBmcm9t
IHRoZSBiYXR0ZXJ5LgoKWWVhaCBubyBpZGVhLi4gSG1tIG1heWJlIGl0J3MgYWN0dWFsbHkgdXNp
bmcgdGhlIFZWSUIgb24gdGhlIHBtaWM/CgpSZWdhcmRzLAoKVG9ueQoKCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGlu
ZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMu
aW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
