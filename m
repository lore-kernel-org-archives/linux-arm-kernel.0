Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4774C282D4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 07:04:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8419B21848
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 07:04:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="tHjImsWw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8419B21848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=soulik.info
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:References:Message-Id:Date:
	In-Reply-To:From:Subject:Mime-Version:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=huxGaZCHQ5kJqQz8WAXz7sFuV7jbmE3o+MndQ/Rz0mE=; b=tHjImsWw/xQDek
	X/B0/MlDPcUQ/M/eAUXVwxmXSKV8lYRaSvXQL5HFDVnvK62fxBxyQAqIixmbLoDokcJt2H2HpNqMu
	DZ7fceVFuLfY+l+9rm3ObCK6eDs0oE7b26QfnXXtK+SgTa3VrtY5FnWeciy8ZZS12rZjL7JQrxp8t
	D+opkrkBABlVU0UxmKfEpzOFhmmmgVHdZ3BDWJqjrscivOlfJqvXE4DTmD8eumGmIFZyv4tF0sDyF
	utzLUfhv3pry4aKzCHaJNkS4SNmcWFhCycbGItmuW4RfTyTrJjdYYeUnOb9B9087T7wfFODjXrm55
	7ac/uJLQVMQlLSUwid4Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gojui-0007G9-CC; Wed, 30 Jan 2019 07:04:00 +0000
Received: from kozue.soulik.info ([108.61.200.231])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gojue-0007Fh-EV; Wed, 30 Jan 2019 07:03:58 +0000
Received: from [192.168.10.231] (unknown [103.29.142.67])
 by kozue.soulik.info (Postfix) with ESMTPSA id 55AE210106E;
 Wed, 30 Jan 2019 16:05:05 +0900 (JST)
Mime-Version: 1.0 (1.0)
Subject: Re: [linux-sunxi] [PATCH v2 1/2] media: v4l: Add definitions for the
 HEVC slice format and controls
From: Ayaka <ayaka@soulik.info>
X-Mailer: iPad Mail (16A404)
In-Reply-To: <2442b23d3b0a00c1bd441298a712888e016acf92.camel@ndufresne.ca>
Date: Wed, 30 Jan 2019 15:03:51 +0800
Message-Id: <3E2E3087-B2C7-48A9-B465-C4BDFA1250A7@soulik.info>
References: <20181123130209.11696-1-paul.kocialkowski@bootlin.com>
 <20181123130209.11696-2-paul.kocialkowski@bootlin.com>
 <5515174.7lFZcYkk85@jernej-laptop>
 <ffe9c81db34b599f675ca5bbf02de360bf0a1608.camel@bootlin.com>
 <776e63c9-d4a5-342a-e0f7-200ef144ffc4@rock-chips.com>
 <64c793e08d61181b78125b3956ec38623fa5d261.camel@bootlin.com>
 <D8005130-F7FD-4CBD-8396-1BB08BB08E81@soulik.info>
 <f982ef378a8ade075bc7077b93640e20ecebf9f4.camel@bootlin.com>
 <82FA0C3F-BC54-4D89-AECB-90D81B89B1CE@soulik.info>
 <c3619a00-17e7-fb92-a427-a7478b96f356@soulik.info>
 <bdf14f97e98f2fd06307545ab9038ac3c2086ae7.camel@bootlin.com>
 <42520087-4EAE-4F7F-BCA0-42E422170E91@soulik.info>
 <ab8ca098ad60f209fe97f79bb93b2d1e898da524.camel@bootlin.com>
 <CAPBb6MUJu3cX9A-E32bSSjxc1cvGP83ayzZzUxa5_QMf6niK4g@mail.gmail.com>
 <2442b23d3b0a00c1bd441298a712888e016acf92.camel@ndufresne.ca>
To: Nicolas Dufresne <nicolas@ndufresne.ca>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190129_230356_694306_82DB584E 
X-CRM114-Status: GOOD (  16.95  )
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
Cc: devel@driverdev.osuosl.org, Hans Verkuil <hverkuil@xs4all.nl>,
 Alexandre Courbot <acourbot@chromium.org>,
 Maxime Ripard <maxime.ripard@bootlin.com>, Randy Li <randy.li@rock-chips.com>,
 LKML <linux-kernel@vger.kernel.org>,
 =?utf-8?Q?Jernej_=C5=A0krabec?= <jernej.skrabec@gmail.com>,
 Tomasz Figa <tfiga@chromium.org>,
 Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
 linux-rockchip@lists.infradead.org,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Ezequiel Garcia <ezequiel@collabora.com>, linux-arm-kernel@lists.infradead.org,
 Linux Media Mailing List <linux-media@vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

CgpTZW50IGZyb20gbXkgaVBhZAoKPiBPbiBKYW4gMzAsIDIwMTksIGF0IDU6NDEgQU0sIE5pY29s
YXMgRHVmcmVzbmUgPG5pY29sYXNAbmR1ZnJlc25lLmNhPiB3cm90ZToKPiAKPj4gTGUgbWFyZGkg
MjkgamFudmllciAyMDE5IMOgIDE2OjQ0ICswOTAwLCBBbGV4YW5kcmUgQ291cmJvdCBhIMOpY3Jp
dCA6Cj4+IE9uIEZyaSwgSmFuIDI1LCAyMDE5IGF0IDEwOjA0IFBNIFBhdWwgS29jaWFsa293c2tp
Cj4+IDxwYXVsLmtvY2lhbGtvd3NraUBib290bGluLmNvbT4gd3JvdGU6Cj4+PiBIaSwKPj4+IAo+
Pj4+IE9uIFRodSwgMjAxOS0wMS0yNCBhdCAyMDoyMyArMDgwMCwgQXlha2Egd3JvdGU6Cj4+Pj4g
U2VudCBmcm9tIG15IGlQYWQKPj4+PiAKPj4+Pj4gT24gSmFuIDI0LCAyMDE5LCBhdCA2OjI3IFBN
LCBQYXVsIEtvY2lhbGtvd3NraSA8cGF1bC5rb2NpYWxrb3dza2lAYm9vdGxpbi5jb20+IHdyb3Rl
Ogo+Pj4+PiAKPj4+Pj4gSGksCj4+Pj4+IAo+Pj4+Pj4gT24gVGh1LCAyMDE5LTAxLTEwIGF0IDIx
OjMyICswODAwLCBheWFrYSB3cm90ZToKPj4+Pj4+IEkgZm9yZ2V0IGEgaW1wb3J0YW50IHRoaW5n
LCBmb3IgdGhlIHJrdmRlYyBhbmQgcmsgaGV2YyBkZWNvZGVyLCBpdCB3b3VsZAo+Pj4+Pj4gcmVx
dWVzdHMgY2FiYWMgdGFibGUsIHNjYWxpbmcgbGlzdCwgcGljdHVyZSBwYXJhbWV0ZXIgc2V0IGFu
ZCByZWZlcmVuY2UKPj4+Pj4+IHBpY3R1cmUgc3RvcmluZyBpbiBvbmUgb3IgdmFyaW91cyBvZiBE
TUEgYnVmZmVycy4gSSBhbSBub3QgdGFsa2luZyBhYm91dAo+Pj4+Pj4gdGhlIGRhdGEgYmVlbiBw
YXJzZWQsIHRoZSBkZWNvZGVyIHdvdWxkIHJlcXVlc3RzIGEgcmF3IGRhdGEuCj4+Pj4+PiAKPj4+
Pj4+IEZvciB0aGUgcHBzIGFuZCBycHMsIGl0IGlzIHBvc3NpYmxlIHRvIHJldXNlIHRoZSBzbGlj
ZSBoZWFkZXIsIGp1c3QgbGV0Cj4+Pj4+PiB0aGUgZGVjb2RlciBrbm93IHRoZSBvZmZzZXQgZnJv
bSB0aGUgYml0c3RyZWFtIGJ1ZmVyLCBJIHdvdWxkIHN1Z2dlc3QgdG8KPj4+Pj4+IGFkZCB0aHJl
ZSBwcm9wZXJ0aWVzKHdpdGggc3BzKSBmb3IgdGhlbS4gQnV0IEkgdGhpbmsgd2UgbmVlZCBhIG1l
dGhvZCB0bwo+Pj4+Pj4gbWFyayBhIE9VVFBVVCBzaWRlIGJ1ZmZlciBmb3IgdGhvc2UgYXV4IGRh
dGEuCj4+Pj4+IAo+Pj4+PiBJJ20gcXVpdGUgY29uZnVzZWQgYWJvdXQgdGhlIGhhcmR3YXJlIGlt
cGxlbWVudGF0aW9uIHRoZW4uIEZyb20gd2hhdAo+Pj4+PiB5b3UncmUgc2F5aW5nLCBpdCBzZWVt
cyB0aGF0IGl0IHRha2VzIHRoZSByYXcgYml0c3RyZWFtIGVsZW1lbnRzIHJhdGhlcgo+Pj4+PiB0
aGFuIHBhcnNlZCBlbGVtZW50cy4gSXMgaXQgcmVhbGx5IGEgc3RhdGVsZXNzIGltcGxlbWVudGF0
aW9uPwo+Pj4+PiAKPj4+Pj4gVGhlIHN0YXRlbGVzcyBpbXBsZW1lbnRhdGlvbiB3YXMgZGVzaWdu
ZWQgd2l0aCB0aGUgaWRlYSB0aGF0IG9ubHkgdGhlCj4+Pj4+IHJhdyBzbGljZSBkYXRhIHNob3Vs
ZCBiZSBwYXNzZWQgaW4gYml0c3RyZWFtIGZvcm0gdG8gdGhlIGRlY29kZXIuIEZvcgo+Pj4+PiBI
LjI2NCwgaXQgc2VlbXMgdGhhdCBzb21lIGRlY29kZXJzIGFsc28gbmVlZCB0aGUgc2xpY2UgaGVh
ZGVyIGluIHJhdwo+Pj4+PiBiaXRzdHJlYW0gZm9ybSAoYmVjYXVzZSB0aGV5IHRha2UgdGhlIGZ1
bGwgc2xpY2UgTkFMIHVuaXQpLCBzZWUgdGhlCj4+Pj4+IGRpc2N1c3Npb25zIGluIHRoaXMgdGhy
ZWFkOgo+Pj4+PiBtZWRpYTogZG9jcy1yc3Q6IERvY3VtZW50IG0ybSBzdGF0ZWxlc3MgdmlkZW8g
ZGVjb2RlciBpbnRlcmZhY2UKPj4+PiAKPj4+PiBTdGF0ZWxlc3MganVzdCBtZWFuIGl0IHdvbuKA
mXQgdHJhY2sgdGhlIHByZXZpb3VzIHJlc3VsdCwgYnV0IEkgZG9u4oCZdAo+Pj4+IHRoaW5rIHlv
dSBjYW4gZGVmaW5lIHdoYXQgYSBkYXRlIHRoZSBoYXJkd2FyZSB3b3VsZCBuZWVkLiBFdmVuIHlv
dQo+Pj4+IGp1c3QgYnVpbGQgYSBkcGIgZm9yIHRoZSBkZWNvZGVyLCBpdCBpcyBzdGlsbCBzdGF0
ZWxlc3MsIGJ1dCBwYXJzaW5nCj4+Pj4gbGVzcyBvciBtb3JlIGRhdGEgZnJvbSB0aGUgYml0c3Ry
ZWFtIGRvZXNu4oCZdCBzdG9wIGEgZGVjb2RlciBiZWNvbWUgYQo+Pj4+IHN0YXRlbGVzcyBkZWNv
ZGVyLgo+Pj4gCj4+PiBZZXMgZmFpciBlbm91Z2gsIHRoZSBmb3JtYXQgaW4gd2hpY2ggdGhlIGhh
cmR3YXJlIGRlY29kZXIgdGFrZXMgdGhlCj4+PiBiaXRzdHJlYW0gcGFyYW1ldGVycyBkb2VzIG5v
dCBtYWtlIGl0IHN0YXRlbGVzcyBvciBzdGF0ZWZ1bCBwZXItc2UuCj4+PiBJdCdzIGp1c3QgdGhh
dCBzdGF0ZWxlc3MgZGVjb2RlcnMgc2hvdWxkIGhhdmUgbm8gcGFydGljdWxhciByZWFzb24gZm9y
Cj4+PiBwYXJzaW5nIHRoZSBiaXRzdHJlYW0gb24gdGhlaXIgb3duIHNpbmNlIHRoZSBoYXJkd2Fy
ZSBjYW4gYmUgZGVzaWduZWQKPj4+IHdpdGggcmVnaXN0ZXJzIGZvciBlYWNoIHJlbGV2YW50IGJp
dHN0cmVhbSBlbGVtZW50IHRvIGNvbmZpZ3VyZSB0aGUKPj4+IGRlY29kaW5nIHBpcGVsaW5lLiBU
aGF0J3MgaG93IEdQVS1iYXNlZCBkZWNvZGVyIGltcGxlbWVudGF0aW9ucyBhcmUKPj4+IGltcGxl
bWVudGVkIChWQUFQSS9WRFBBVS9OVkRFQywgZXRjKS4KPj4+IAo+Pj4gU28gdGhlIGZvcm1hdCB3
ZSBoYXZlIGFncmVlZCBvbiBzbyBmYXIgZm9yIHRoZSBzdGF0ZWxlc3MgaW50ZXJmYWNlIGlzCj4+
PiB0byBwYXNzIHBhcnNlZCBlbGVtZW50cyB2aWEgdjRsMiBjb250cm9sIHN0cnVjdHVyZXMuCj4+
PiAKPj4+IElmIHRoZSBoYXJkd2FyZSBjYW4gb25seSB3b3JrIGJ5IHBhcnNpbmcgdGhlIGJpdHN0
cmVhbSBpdHNlbGYsIEknbSBub3QKPj4+IHN1cmUgd2hhdCB0aGUgYmVzdCBzb2x1dGlvbiB3b3Vs
ZCBiZS4gUmVjb25zdHJ1Y3RpbmcgdGhlIGJpdHN0cmVhbSBpbgo+Pj4gdGhlIGtlcm5lbCBpcyBh
IHByZXR0eSBiYWQgb3B0aW9uLCBidXQgc28gaXMgcGFyc2luZyBpbiB0aGUga2VybmVsIG9yCj4+
PiBoYXZpbmcgdGhlIGRhdGEgYm90aCBpbiBwYXJzZWQgYW5kIHJhdyBmb3Jtcy4gRG8geW91IHNl
ZSBhbm90aGVyCj4+PiBwb3NzaWJpbGl0eT8KPj4gCj4+IElzIHJlY29uc3RydWN0aW5nIHRoZSBi
aXRzdHJlYW0gc28gYmFkPyBUaGUgdjRsMiBjb250cm9scyBwcm92aWRlIGEKPj4gZ2VuZXJpYyBp
bnRlcmZhY2UgdG8gYW4gZW5jb2RlZCBmb3JtYXQgd2hpY2ggdGhlIGRyaXZlciBuZWVkcyB0bwo+
PiBjb252ZXJ0IGludG8gYSBzZXF1ZW5jZSB0aGF0IHRoZSBoYXJkd2FyZSBjYW4gdW5kZXJzdGFu
ZC4gVHlwaWNhbGx5Cj4+IHRoaXMgaXMgZG9uZSBieSBwb3B1bGF0aW5nIGhhcmR3YXJlLXNwZWNp
ZmljIHN0cnVjdHVyZXMuIENhbid0IHdlCj4+IGNvbnNpZGVyIHRoYXQgaW4gdGhpcyBzcGVjaWZp
YyBpbnN0YW5jZSwgdGhlIGhhcmR3YXJlLXNwZWNpZmljCj4+IHN0cnVjdHVyZSBqdXN0IGhhcHBl
bnMgdG8gYmUgaWRlbnRpY2FsIHRvIHRoZSBvcmlnaW5hbCBiaXRzdHJlYW0KPj4gZm9ybWF0Pwo+
IAo+IEF0IG1heGltdW0gYWxsb3dlZCBiaXRyYXRlIGZvciBsZXQncyBzYXkgSEVWQyAoOTQwTUIv
cyBpaXJjKSwgeWVzLCBpdApMdWNreSwgbW9zdCBvZiBoYXJkd2FyZSB3b27igJl0IGJlIGFibGUg
dG8gcHJvY2Vzc2luZyBzdWNoIGEgYmlnIGJ1ZmZlci4KR2VuZXJhbCBzcGVha2luZywgdGhlIHJl
Z2lzdGVyIGlzIDI0Yml0cyBmb3Igc3RyZWFtIGxlbmd0aCBpbiBieXRlcy4KPiB3b3VsZCBiZSBy
ZWFsbHkgcmVhbGx5IGJhZC4gSW4gR1N0cmVhbWVyIHByb2plY3Qgd2UgaGF2ZSBkaXNjdXNzZWQg
Zm9yCj4gYSB3aGlsZSAoYnV0IGhhdmUgbmV2ZXIgZG9uZSBhbnl0aGluZyBhYm91dCkgYWRkaW5n
IHRoZSBhYmlsaXR5IHRocm91Z2gKPiBhIGJpdG1hc2sgdG8gc2VsZWN0IHdoaWNoIHBhcnQgb2Yg
dGhlIHN0cmVhbSBuZWVkIHRvIGJlIHBhcnNlZCwgYXMKPiBwYXJzaW5nIGl0c2VsZiB3YXMgY2F1
c2luZyBzb21lIG92ZXJoZWFkLiBNYXliZSBzaW1pbGFyIHRoaW5nIGFwcGxpZXMsCj4gdGhvdWdo
IGFzIHBlciBvdXIgbmV3IGRlc2lnbiwgaXQncyB0aGUgZm91cmNjIHRoYXQgZGljdGF0ZSB0aGUg
ZHJpdmVyCj4gYmVoYXZpb3VyLCB3ZSdkIG5lZWQgeWV0IGFub3RoZXIgZm91cmNjIGZvciBkcml2
ZXJzIHRoYXQgd2FudHMgdGhlIGZ1bGwKPiBiaXRzdHJlYW0gKHdoaWNoIHNlZW1zIG9kZCBpZiB5
b3UgaGF2ZSBhbHJlYWR5IHBhcnNlZCBldmVyeXRoaW5nLCBJCj4gdGhpbmsgdGhpcyBuZWVkIHNv
bWUgY2xhcmlmaWNhdGlvbikuCj4gCj4+IAo+PiBJIGFncmVlIHRoYXQgdGhpcyBpcyBub3Qgc3Ry
aWN0bHkgb3B0aW1hbCBmb3IgdGhhdCBwYXJ0aWN1bGFyCj4+IGhhcmR3YXJlLCBidXQgc3VjaCBp
cyB0aGUgY29zdCBvZiBhYnN0cmFjdGlvbnMsIGFuZCBpbiB0aGlzIHNwZWNpZmljCj4+IGNhc2Ug
SSBkb24ndCBiZWxpZXZlIHRoZSBjb3N0IHdvdWxkIGJlIHBhcnRpY3VsYXJseSBoaWdoPwoKCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1r
ZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpo
dHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJu
ZWwK
