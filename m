Return-Path: <SRS0=txfi=PP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE5B5C43612
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 09:57:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DF1A213A2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 09:57:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="tRbbPRqa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DF1A213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=T1Ws/AhrC8uwDKljfB03qnsmx+dRMb+uHJPwHoUhqPs=; b=tRbbPRqaFog65I
	76A+1e0qDYM+9hqcHT5DGcAAobhmW/RK5q/59KwaJDEt8BrhwrkxcesFSx1nFxt0YeO+gbJ4D35WM
	oo170NoKOW4FldsTZXCKX+IRFgBpKj+0ip+nZM7BD6tJBHfAcvHurxi5R3OkkXr6y5/bpk3VjJJxm
	G0ivJETp/fiGyDmsU6HoV3wauzHpgLwqiQXlvNvxaN9oQguNa8LHih3WFSXp/ULq6XsUn8DCdepQl
	I+s3XUX/x1puJDwccneeIwcr7rjeddNYG1wHvxBzLyussOTt1gHc6mqyDwEXBETG1PLqOUFVeUzoX
	oArJK/pdmcYmyMfTS/7w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ggRf7-0002as-6h; Mon, 07 Jan 2019 09:57:37 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ggRf2-0002Zn-6E; Mon, 07 Jan 2019 09:57:34 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id 4711120802; Mon,  7 Jan 2019 10:57:28 +0100 (CET)
Received: from aptenodytes (aaubervilliers-681-1-29-148.w90-88.abo.wanadoo.fr
 [90.88.149.148])
 by mail.bootlin.com (Postfix) with ESMTPSA id C958120714;
 Mon,  7 Jan 2019 10:57:17 +0100 (CET)
Message-ID: <64c793e08d61181b78125b3956ec38623fa5d261.camel@bootlin.com>
Subject: Re: [linux-sunxi] [PATCH v2 1/2] media: v4l: Add definitions for
 the HEVC slice format and controls
From: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To: Randy Li <randy.li@rock-chips.com>
Date: Mon, 07 Jan 2019 10:57:17 +0100
In-Reply-To: <776e63c9-d4a5-342a-e0f7-200ef144ffc4@rock-chips.com>
References: <20181123130209.11696-1-paul.kocialkowski@bootlin.com>
 <20181123130209.11696-2-paul.kocialkowski@bootlin.com>
 <5515174.7lFZcYkk85@jernej-laptop>
 <ffe9c81db34b599f675ca5bbf02de360bf0a1608.camel@bootlin.com>
 <776e63c9-d4a5-342a-e0f7-200ef144ffc4@rock-chips.com>
Organization: Bootlin
User-Agent: Evolution 3.30.3 
Mime-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190107_015732_504201_2EBDBC01 
X-CRM114-Status: GOOD (  19.12  )
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
Cc: devel@driverdev.osuosl.org, Alexandre Courbot <acourbot@chromium.org>,
 Maxime Ripard <maxime.ripard@bootlin.com>, Randy Li <ayaka@soulik.info>,
 linux-kernel@vger.kernel.org,
 Jernej =?UTF-8?Q?=C5=A0krabec?= <jernej.skrabec@gmail.com>,
 Tomasz Figa <tfiga@chromium.org>, Hans Verkuil <hverkuil@xs4all.nl>,
 linux-rockchip@lists.infradead.org, linux-sunxi@googlegroups.com,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Ezequiel Garcia <ezequiel@collabora.com>, linux-arm-kernel@lists.infradead.org,
 linux-media@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGksCgpPbiBNb24sIDIwMTktMDEtMDcgYXQgMTE6NDkgKzA4MDAsIFJhbmR5IExpIHdyb3RlOgo+
IE9uIDEyLzEyLzE4IDg6NTEgUE0sIFBhdWwgS29jaWFsa293c2tpIHdyb3RlOgo+ID4gSGksCj4g
PiAKPiA+IE9uIFdlZCwgMjAxOC0xMi0wNSBhdCAyMTo1OSArMDEwMCwgSmVybmVqIMWga3JhYmVj
IHdyb3RlOgo+ID4gCj4gPiA+ID4gKwo+ID4gPiA+ICsjZGVmaW5lIFY0TDJfSEVWQ19EUEJfRU5U
UllfUlBTX1NUX0NVUlJfQkVGT1JFCTB4MDEKPiA+ID4gPiArI2RlZmluZSBWNEwyX0hFVkNfRFBC
X0VOVFJZX1JQU19TVF9DVVJSX0FGVEVSCTB4MDIKPiA+ID4gPiArI2RlZmluZSBWNEwyX0hFVkNf
RFBCX0VOVFJZX1JQU19MVF9DVVJSCQkweDAzCj4gPiA+ID4gKwo+ID4gPiA+ICsjZGVmaW5lIFY0
TDJfSEVWQ19EUEJfRU5UUklFU19OVU1fTUFYCQkxNgo+ID4gPiA+ICsKPiA+ID4gPiArc3RydWN0
IHY0bDJfaGV2Y19kcGJfZW50cnkgewo+ID4gPiA+ICsJX191MzIJYnVmZmVyX3RhZzsKPiA+ID4g
PiArCV9fdTgJcnBzOwo+ID4gPiA+ICsJX191OAlmaWVsZF9waWM7Cj4gPiA+ID4gKwlfX3UxNglw
aWNfb3JkZXJfY250WzJdOwo+ID4gPiA+ICt9Owo+IAo+IFBsZWFzZSBhZGQgYSBwcm9wZXJ0eSBm
b3IgcmVmZXJlbmNlIGluZGV4LCBpZiB0aGF0IHJwcyBpcyBub3QgdXNlZCBmb3IgCj4gdGhpcywg
c29tZSBkZXZpY2Ugd291bGQgcmVxdWVzdCB0aGF0KG5vdCB0aGUgcm9ja2NoaXAgb25lKS4gQW5k
IAo+IFJvY2tjaGlwJ3MgVkRQVTEgYW5kIFZEUFUyIGZvciBBVkMgd291bGQgcmVxdWVzdCBhIHNp
bWlsYXIgcHJvcGVydHkuCgpXaGF0IGV4YWN0bHkgaXMgdGhhdCByZWZlcmVuY2UgaW5kZXg/IElz
IGl0IGEgYml0c3RyZWFtIGVsZW1lbnQgb3IKc29tZXRoaW5nIGRlZHVjZWQgZnJvbSB0aGUgYml0
c3RyZWFtPwoKPiBBZGRpbmcgYW5vdGhlciBidWZmZXJfdGFnIGZvciByZWZlcnJpbmcgdGhlIG1l
bW9yeSBvZiB0aGUgbW90aW9uIHZlY3RvcnMgCj4gZm9yIGVhY2ggZnJhbWVzLiBPciBhIGJldHRl
ciBtZXRob2QgaXMgYWRkIGEgbWV0YSBkYXRhIHRvIGVjaG8gcGljdHVyZSAKPiBidWZmZXIsICBz
aW5jZSB0aGUgcGljdHVyZSBvdXRwdXQgaXMganVzdCB0aGUgc2FtZSBhcyB0aGUgb3JpZ2luYWws
IAo+IGRpc3BsYXkgd29uJ3QgY2FyZSB3aGV0aGVyIHRoZSBtb3Rpb24gdmVjdG9ycyBhcmUgd3Jp
dHRlbiB0aGUgYnV0dG9uIG9mIAo+IHBpY3R1cmUgb3Igc29tZXdoZXJlIGVsc2UuCgpUaGUgbW90
aW9uIHZlY3RvcnMgYXJlIHBhc3NlZCBhcyBwYXJ0IG9mIHRoZSByYXcgYml0c3RyZWFtIGRhdGEs
IGluIHRoZQpzbGljZXMuIElzIHRoZXJlIGEgY2FzZSB3aGVyZSB0aGUgbW90aW9uIHZlY3RvcnMg
YXJlIGNvZGVkIGRpZmZlcmVudGx5PwoKPiA+ID4gPiArCj4gPiA+ID4gK3N0cnVjdCB2NGwyX2hl
dmNfcHJlZF93ZWlnaHRfdGFibGUgewo+ID4gPiA+ICsJX191OAlsdW1hX2xvZzJfd2VpZ2h0X2Rl
bm9tOwo+ID4gPiA+ICsJX19zOAlkZWx0YV9jaHJvbWFfbG9nMl93ZWlnaHRfZGVub207Cj4gPiA+
ID4gKwo+ID4gPiA+ICsJX19zOAlkZWx0YV9sdW1hX3dlaWdodF9sMFtWNEwyX0hFVkNfRFBCX0VO
VFJJRVNfTlVNX01BWF07Cj4gPiA+ID4gKwlfX3M4CWx1bWFfb2Zmc2V0X2wwW1Y0TDJfSEVWQ19E
UEJfRU5UUklFU19OVU1fTUFYXTsKPiA+ID4gPiArCV9fczgJZGVsdGFfY2hyb21hX3dlaWdodF9s
MFtWNEwyX0hFVkNfRFBCX0VOVFJJRVNfTlVNX01BWF1bMl07Cj4gPiA+ID4gKwlfX3M4CWNocm9t
YV9vZmZzZXRfbDBbVjRMMl9IRVZDX0RQQl9FTlRSSUVTX05VTV9NQVhdWzJdOwo+ID4gPiA+ICsK
PiA+ID4gPiArCV9fczgJZGVsdGFfbHVtYV93ZWlnaHRfbDFbVjRMMl9IRVZDX0RQQl9FTlRSSUVT
X05VTV9NQVhdOwo+ID4gPiA+ICsJX19zOAlsdW1hX29mZnNldF9sMVtWNEwyX0hFVkNfRFBCX0VO
VFJJRVNfTlVNX01BWF07Cj4gPiA+ID4gKwlfX3M4CWRlbHRhX2Nocm9tYV93ZWlnaHRfbDFbVjRM
Ml9IRVZDX0RQQl9FTlRSSUVTX05VTV9NQVhdWzJdOwo+ID4gPiA+ICsJX19zOAljaHJvbWFfb2Zm
c2V0X2wxW1Y0TDJfSEVWQ19EUEJfRU5UUklFU19OVU1fTUFYXVsyXTsKPiA+ID4gPiArfTsKPiA+
ID4gPiArCj4gVGhvc2UgcHJvcGVydGllcyBJIHRoaW5rIGFyZSBub3QgbmVjZXNzYXJ5IGFyZSBh
cHBseWluZyBmb3IgdGhlIAo+IFJvY2tjaGlwJ3MgZGV2aWNlLCBtYXkgbm90IHdvcmsgZm9yIHRo
ZSBvdGhlcnMuCgpZZXMsIGl0J3MgcG9zc2libGUgdGhhdCBzb21lIG9mIHRoZSBlbGVtZW50cyBh
cmUgbm90IG5lY2Vzc2FyeSBmb3Igc29tZQpkZWNvZGVycy4gV2hhdCB3ZSB3YW50IGlzIHRvIGNv
dmVyIGFsbCB0aGUgZWxlbWVudHMgdGhhdCBtaWdodCBiZQpyZXF1aXJlZCBmb3IgYSBkZWNvZGVy
LgoKPiA+ID4gPiArc3RydWN0IHY0bDJfY3RybF9oZXZjX3NsaWNlX3BhcmFtcyB7Cj4gPiA+ID4g
KwlfX3UzMgliaXRfc2l6ZTsKPiA+ID4gPiArCV9fdTMyCWRhdGFfYml0X29mZnNldDsKPiA+ID4g
PiArCj4gPiA+ID4gKwkvKiBJU08vSUVDIDIzMDA4LTIsIElUVS1UIFJlYy4gSC4yNjU6IE5BTCB1
bml0IGhlYWRlciAqLwo+ID4gPiA+ICsJX191OAluYWxfdW5pdF90eXBlOwo+ID4gPiA+ICsJX191
OAludWhfdGVtcG9yYWxfaWRfcGx1czE7Cj4gPiA+ID4gKwo+ID4gPiA+ICsJLyogSVNPL0lFQyAy
MzAwOC0yLCBJVFUtVCBSZWMuIEguMjY1OiBHZW5lcmFsIHNsaWNlIHNlZ21lbnQgaGVhZGVyICov
Cj4gPiA+ID4gKwlfX3U4CXNsaWNlX3R5cGU7Cj4gPiA+ID4gKwlfX3U4CWNvbG91cl9wbGFuZV9p
ZDsKPiAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCj4gPiA+ID4gKwlfX3UxNglzbGljZV9waWNfb3JkZXJf
Y250Owo+ID4gPiA+ICsJX191OAlzbGljZV9zYW9fbHVtYV9mbGFnOwo+ID4gPiA+ICsJX191OAlz
bGljZV9zYW9fY2hyb21hX2ZsYWc7Cj4gPiA+ID4gKwlfX3U4CXNsaWNlX3RlbXBvcmFsX212cF9l
bmFibGVkX2ZsYWc7Cj4gPiA+ID4gKwlfX3U4CW51bV9yZWZfaWR4X2wwX2FjdGl2ZV9taW51czE7
Cj4gPiA+ID4gKwlfX3U4CW51bV9yZWZfaWR4X2wxX2FjdGl2ZV9taW51czE7Cj4gUm9ja2NoaXAn
cyBkZWNvZGVyIGRvZXNuJ3QgdXNlIHRoaXMgcGFydC4KPiA+ID4gPiArCV9fdTgJbXZkX2wxX3pl
cm9fZmxhZzsKPiA+ID4gPiArCV9fdTgJY2FiYWNfaW5pdF9mbGFnOwo+ID4gPiA+ICsJX191OAlj
b2xsb2NhdGVkX2Zyb21fbDBfZmxhZzsKPiA+ID4gPiArCV9fdTgJY29sbG9jYXRlZF9yZWZfaWR4
Owo+ID4gPiA+ICsJX191OAlmaXZlX21pbnVzX21heF9udW1fbWVyZ2VfY2FuZDsKPiA+ID4gPiAr
CV9fdTgJdXNlX2ludGVnZXJfbXZfZmxhZzsKPiA+ID4gPiArCV9fczgJc2xpY2VfcXBfZGVsdGE7
Cj4gPiA+ID4gKwlfX3M4CXNsaWNlX2NiX3FwX29mZnNldDsKPiA+ID4gPiArCV9fczgJc2xpY2Vf
Y3JfcXBfb2Zmc2V0Owo+ID4gPiA+ICsJX19zOAlzbGljZV9hY3RfeV9xcF9vZmZzZXQ7Cj4gPiA+
ID4gKwlfX3M4CXNsaWNlX2FjdF9jYl9xcF9vZmZzZXQ7Cj4gPiA+ID4gKwlfX3M4CXNsaWNlX2Fj
dF9jcl9xcF9vZmZzZXQ7Cj4gPiA+ID4gKwlfX3U4CXNsaWNlX2RlYmxvY2tpbmdfZmlsdGVyX2Rp
c2FibGVkX2ZsYWc7Cj4gPiA+ID4gKwlfX3M4CXNsaWNlX2JldGFfb2Zmc2V0X2RpdjI7Cj4gPiA+
ID4gKwlfX3M4CXNsaWNlX3RjX29mZnNldF9kaXYyOwo+ID4gPiA+ICsJX191OAlzbGljZV9sb29w
X2ZpbHRlcl9hY3Jvc3Nfc2xpY2VzX2VuYWJsZWRfZmxhZzsKPiA+ID4gPiArCj4gPiA+ID4gKwkv
KiBJU08vSUVDIDIzMDA4LTIsIElUVS1UIFJlYy4gSC4yNjU6IFBpY3R1cmUgdGltaW5nIFNFSSBt
ZXNzYWdlICovCj4gPiA+ID4gKwlfX3U4CXBpY19zdHJ1Y3Q7Cj4gSSB0aGluayB0aGUgZGVjb2Rl
ciBkb2Vzbid0IGNhcmUgYWJvdXQgdGhpcywgaXQgaXMgdXNlZCBmb3IgZGlzcGxheS4KClRoZSBw
dXJwb3NlIG9mIHRoaXMgZmllbGQgaXMgdG8gaW5kaWNhdGUgd2hldGhlciB0aGUgY3VycmVudCBw
aWN0dXJlIGlzCmEgcHJvZ3Jlc3NpdmUgZnJhbWUgb3IgYW4gaW50ZXJsYWNlZCBmaWVsZCBwaWN0
dXJlLCB3aGljaCBpcyB1c2VmdWwgZm9yCmRlY29kaW5nLgoKQXQgbGVhc3Qgb3VyIGRlY29kZXIg
aGFzIGEgcmVnaXN0ZXIgZmllbGQgdG8gaW5kaWNhdGUgZnJhbWUvdG9wCmZpZWxkL2JvdHRvbSBm
aWVsZCwgc28gd2UgY2VydGFpbmx5IG5lZWQgdG8ga2VlcCB0aGUgaW5mbyBhcm91bmQuCkxvb2tp
bmcgYXQgdGhlIHNwZWMgYW5kIHRoZSBmZm1wZWcgaW1wbGVtZW50YXRpb24sIGl0IGxvb2tzIGxp
a2UgdGhpcwpmbGFnIG9mIHRoZSBiaXRzdHJlYW0gaXMgdGhlIHVzdWFsIHdheSB0byByZXBvcnQg
ZmllbGQgY29kaW5nLgoKQ2hlZXJzLAoKUGF1bAoKPiA+ID4gPiArCj4gPiA+ID4gKwkvKiBJU08v
SUVDIDIzMDA4LTIsIElUVS1UIFJlYy4gSC4yNjU6IEdlbmVyYWwgc2xpY2Ugc2VnbWVudCBoZWFk
ZXIgKi8KPiA+ID4gPiArCXN0cnVjdCB2NGwyX2hldmNfZHBiX2VudHJ5IGRwYltWNEwyX0hFVkNf
RFBCX0VOVFJJRVNfTlVNX01BWF07Cj4gPiA+ID4gKwlfX3U4CW51bV9hY3RpdmVfZHBiX2VudHJp
ZXM7Cj4gPiA+ID4gKwlfX3U4CXJlZl9pZHhfbDBbVjRMMl9IRVZDX0RQQl9FTlRSSUVTX05VTV9N
QVhdOwo+ID4gPiA+ICsJX191OAlyZWZfaWR4X2wxW1Y0TDJfSEVWQ19EUEJfRU5UUklFU19OVU1f
TUFYXTsKPiA+ID4gPiArCj4gPiA+ID4gKwlfX3U4CW51bV9ycHNfcG9jX3N0X2N1cnJfYmVmb3Jl
Owo+ID4gPiA+ICsJX191OAludW1fcnBzX3BvY19zdF9jdXJyX2FmdGVyOwo+ID4gPiA+ICsJX191
OAludW1fcnBzX3BvY19sdF9jdXJyOwo+ID4gPiA+ICsKPiA+ID4gPiArCS8qIElTTy9JRUMgMjMw
MDgtMiwgSVRVLVQgUmVjLiBILjI2NTogV2VpZ2h0ZWQgcHJlZGljdGlvbiBwYXJhbWV0ZXIgKi8K
PiA+ID4gPiArCXN0cnVjdCB2NGwyX2hldmNfcHJlZF93ZWlnaHRfdGFibGUgcHJlZF93ZWlnaHRf
dGFibGU7Cj4gPiA+ID4gK307Cj4gPiA+ID4gKwo+ID4gPiA+ICAgI2VuZGlmCi0tIApQYXVsIEtv
Y2lhbGtvd3NraSwgQm9vdGxpbiAoZm9ybWVybHkgRnJlZSBFbGVjdHJvbnMpCkVtYmVkZGVkIExp
bnV4IGFuZCBrZXJuZWwgZW5naW5lZXJpbmcKaHR0cHM6Ly9ib290bGluLmNvbQoKCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwg
bWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8v
bGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
