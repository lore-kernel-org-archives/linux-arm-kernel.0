Return-Path: <SRS0=KsRD=PT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1333C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 08:14:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1A5C2084C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 08:14:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jonMWUIb";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="QovjwM4Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1A5C2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:References:
	To:From:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=gMbhmJGmhClaTqizICxIJS4t2ffraAI2ajyk+KOKznY=; b=jonMWUIbnH8GQ1e3kEcsj8Inn
	K0VbSHc3vxe8VXpl3jbHUvXyiq3lNSchwDWm8H0ccPG1EEf6nTs8S6/3CBQ5GvYNPT9zQp789BoXr
	CwhOqfaBtdLWBtGlGHzpD+R52zhrgtTpMhq1X0MIBIC+W8qd/a2CGF5kn344FIw882+P9RUXNXY/h
	+zrbJyHBI/iYgxpfvuGWKpfIPIOjRQ9F97ciaJJEWXAizRg47kWTvFw7ORczqNfBaz5Jb4NR1dnGS
	RFsN7bcLAP1yojS3ziTFObtg5urlKCkeqFxWkTyw75tWa5fRnbt3chgSkulhedmHtjRB8LWi2dvZg
	ouFv9h1aw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghrxk-00081M-Nd; Fri, 11 Jan 2019 08:14:44 +0000
Received: from hqemgate16.nvidia.com ([216.228.121.65])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghrxh-00080f-K9
 for linux-arm-kernel@lists.infradead.org; Fri, 11 Jan 2019 08:14:43 +0000
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by
 hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5c3850510000>; Fri, 11 Jan 2019 00:14:09 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate102.nvidia.com (PGP Universal service);
 Fri, 11 Jan 2019 00:14:35 -0800
X-PGP-Universal: processed;
 by hqpgpgate102.nvidia.com on Fri, 11 Jan 2019 00:14:35 -0800
Received: from [10.19.108.132] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 11 Jan
 2019 08:14:33 +0000
Subject: Re: [PATCH V4 01/20] dt-bindings: clock: tegra124-dfll: Update DFLL
 binding for PWM regulator
From: Joseph Lo <josephl@nvidia.com>
To: Thierry Reding <thierry.reding@gmail.com>, Rob Herring <robh@kernel.org>, 
 Peter De Schrijver <pdeschrijver@nvidia.com>, Jonathan Hunter
 <jonathanh@nvidia.com>
References: <20190104030702.8684-1-josephl@nvidia.com>
 <20190104030702.8684-2-josephl@nvidia.com>
 <142f619f-9939-0d87-9fe7-2e72efa027a0@nvidia.com>
Message-ID: <74087bd9-1cc4-9897-9ded-81eaa9ca434b@nvidia.com>
Date: Fri, 11 Jan 2019 16:14:31 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <142f619f-9939-0d87-9fe7-2e72efa027a0@nvidia.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL104.nvidia.com (172.18.146.11) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1547194449; bh=4R0QJ6PW6nMd9ERm2Bhc4cHql+uaH5yq/rJ6HYDjGhA=;
 h=X-PGP-Universal:Subject:From:To:CC:References:Message-ID:Date:
 User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
 X-ClientProxiedBy:Content-Type:Content-Language:
 Content-Transfer-Encoding;
 b=QovjwM4Yb/YhuX6etuQ4FV5AY68zdYuPi9IQQWLzaqjKn73jZXnNAwM89sx6uDE6V
 6A9A+x2ZIvA4YNnl1y+HUIWmjCDDKm7Rv2OrbWtVGiqx2vz6AV/aRJfzURw40n0/Mn
 Myn0lpHAHP78sjAq6c1B7usd/6GMO0FN+ZSg0UApZTrQQiYImvEXZtbuVaDt50mJeH
 J5yOB8BMKZn6FyUFmjDnixaJEGx0kQXV0RmjxXLrPZ55Ik7qG2YbO7JfkULVqnbYOs
 38wtIuzizwlIuympEDlsx+ZY65Rl797B3KONTe4E4UOSFx/CnMtqGhTpRWipjWfm4u
 GUremcEgMixxQ==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190111_001441_683290_B538DF50 
X-CRM114-Status: GOOD (  15.13  )
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
Cc: linux-tegra@vger.kernel.org, devicetree@vger.kernel.org,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gMS84LzE5IDg6MzUgQU0sIEpvc2VwaCBMbyB3cm90ZToKPiBPbiAxLzQvMTkgMTE6MDYgQU0s
IEpvc2VwaCBMbyB3cm90ZToKPj4gRnJvbTogUGV0ZXIgRGUgU2NocmlqdmVyIDxwZGVzY2hyaWp2
ZXJAbnZpZGlhLmNvbT4KPj4KPj4gQWRkIG5ldyBwcm9wZXJ0aWVzIHRvIGNvbmZpZ3VyZSB0aGUg
REZMTCBQV00gcmVndWxhdG9yIHN1cHBvcnQuCj4+Cj4+IENjOiBkZXZpY2V0cmVlQHZnZXIua2Vy
bmVsLm9yZwo+PiBTaWduZWQtb2ZmLWJ5OiBQZXRlciBEZSBTY2hyaWp2ZXIgPHBkZXNjaHJpanZl
ckBudmlkaWEuY29tPgo+PiBTaWduZWQtb2ZmLWJ5OiBKb3NlcGggTG8gPGpvc2VwaGxAbnZpZGlh
LmNvbT4KPj4gQWNrZWQtYnk6IEpvbiBIdW50ZXIgPGpvbmF0aGFuaEBudmlkaWEuY29tPgo+PiAt
LS0KPj4gKlY0Ogo+PiDCoCAtIHMvbnZpZGlhLHB3bS1wZXJpb2QvbnZpZGlhLHB3bS1wZXJpb2Qt
bmFub3NlY29uZHMvCj4+ICpWMzoKPj4gwqAgLSBubyBjaGFuZ2UKPj4gKlYyOgo+PiDCoCAtIHVw
ZGF0ZSB0aGUgYmluZGluZyBzdHJpbmdzIGFuZCBkZXNjcmlwdGlvbnMgZm9yCj4+IMKgIG52aWRp
YSxwd20tdHJpc3RhdGUtbWljcm92b2x0cwo+PiDCoCBudmlkaWEscHdtLW1pbi1taWNyb3ZvbHRz
Cj4+IMKgIG52aWRpYSxwd20tdm9sdGFnZS1zdGVwLW1pY3Jvdm9sdHMKPj4gLS0tCj4gCj4gSGkg
Um9iLAo+IAo+IENvdWxkIHlvdSBoZWxwIG1lIHRvIHJldmlldyB0aGlzIHBhdGNoIGFnYWluPwoK
R2VudGxlIHBpbmcuCgpUaGFua3MsCkpvc2VwaAoKPiAKPiBUaGFua3MsCj4gSm9zZXBoCj4gCj4+
IMKgIC4uLi9iaW5kaW5ncy9jbG9jay9udmlkaWEsdGVncmExMjQtZGZsbC50eHTCoMKgIHwgNzkg
KysrKysrKysrKysrKysrKysrLQo+PiDCoCAxIGZpbGUgY2hhbmdlZCwgNzcgaW5zZXJ0aW9ucygr
KSwgMiBkZWxldGlvbnMoLSkKPj4KPj4gZGlmZiAtLWdpdCAKPj4gYS9Eb2N1bWVudGF0aW9uL2Rl
dmljZXRyZWUvYmluZGluZ3MvY2xvY2svbnZpZGlhLHRlZ3JhMTI0LWRmbGwudHh0IAo+PiBiL0Rv
Y3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9jbG9jay9udmlkaWEsdGVncmExMjQtZGZs
bC50eHQKPj4gaW5kZXggZGZmMjM2ZjUyNGE3Li41NTU4YmI1ZmNmMmMgMTAwNjQ0Cj4+IC0tLSBh
L0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9jbG9jay9udmlkaWEsdGVncmExMjQt
ZGZsbC50eHQKPj4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Nsb2Nr
L252aWRpYSx0ZWdyYTEyNC1kZmxsLnR4dAo+PiBAQCAtOCw3ICs4LDYgQEAgdGhlIGZhc3QgQ1BV
IGNsdXN0ZXIuIEl0IGNvbnNpc3RzIG9mIGEgZnJlZS1ydW5uaW5nIAo+PiB2b2x0YWdlIGNvbnRy
b2xsZWQKPj4gwqAgb3NjaWxsYXRvciBjb25uZWN0ZWQgdG8gdGhlIENQVSB2b2x0YWdlIHJhaWwg
KFZERF9DUFUpLCBhbmQgYSBjbG9zZWQgCj4+IGxvb3AKPj4gwqAgY29udHJvbCBtb2R1bGUgdGhh
dCB3aWxsIGF1dG9tYXRpY2FsbHkgYWRqdXN0IHRoZSBWRERfQ1BVIHZvbHRhZ2UgYnkKPj4gwqAg
Y29tbXVuaWNhdGluZyB3aXRoIGFuIG9mZi1jaGlwIFBNSUMgZWl0aGVyIHZpYSBhbiBJMkMgYnVz
IG9yIHZpYSBQV00gCj4+IHNpZ25hbHMuCj4+IC1DdXJyZW50bHkgb25seSB0aGUgSTJDIG1vZGUg
aXMgc3VwcG9ydGVkIGJ5IHRoZXNlIGJpbmRpbmdzLgo+PiDCoCBSZXF1aXJlZCBwcm9wZXJ0aWVz
Ogo+PiDCoCAtIGNvbXBhdGlibGUgOiBzaG91bGQgYmUgIm52aWRpYSx0ZWdyYTEyNC1kZmxsIgo+
PiBAQCAtNDUsMTAgKzQ0LDMxIEBAIFJlcXVpcmVkIHByb3BlcnRpZXMgZm9yIHRoZSBjb250cm9s
IGxvb3AgcGFyYW1ldGVyczoKPj4gwqAgT3B0aW9uYWwgcHJvcGVydGllcyBmb3IgdGhlIGNvbnRy
b2wgbG9vcCBwYXJhbWV0ZXJzOgo+PiDCoCAtIG52aWRpYSxjZy1zY2FsZTogQm9vbGVhbiB2YWx1
ZSwgc2VlIHRoZSBmaWVsZCBERkxMX1BBUkFNU19DR19TQ0FMRSAKPj4gaW4gdGhlIFRSTS4KPj4g
K09wdGlvbmFsIHByb3BlcnRpZXMgZm9yIG1vZGUgc2VsZWN0aW9uOgo+PiArLSBudmlkaWEscHdt
LXRvLXBtaWM6IFVzZSBQV00gdG8gY29udHJvbCByZWd1bGF0b3IgcmF0aGVyIHRoZW4gSTJDLgo+
PiArCj4+IMKgIFJlcXVpcmVkIHByb3BlcnRpZXMgZm9yIEkyQyBtb2RlOgo+PiDCoCAtIG52aWRp
YSxpMmMtZnMtcmF0ZTogSTJDIHRyYW5zZmVyIHJhdGUsIGlmIHVzaW5nIGZ1bGwgc3BlZWQgbW9k
ZS4KPj4gLUV4YW1wbGU6Cj4+ICtSZXF1aXJlZCBwcm9wZXJ0aWVzIGZvciBQV00gbW9kZToKPj4g
Ky0gbnZpZGlhLHB3bS1wZXJpb2QtbmFub3NlY29uZHM6IHBlcmlvZCBvZiBQV00gc3F1YXJlIHdh
dmUgaW4gCj4+IG5hbm9zZWNvbmRzLgo+PiArLSBudmlkaWEscHdtLXRyaXN0YXRlLW1pY3Jvdm9s
dHM6IFJlZ3VsYXRvciB2b2x0YWdlIGluIG1pY3JvIHZvbHRzIAo+PiB3aGVuIFBXTQo+PiArwqAg
Y29udHJvbCBpcyBkaXNhYmxlZCBhbmQgdGhlIFBXTSBvdXRwdXQgaXMgdHJpc3RhdGVkLiBOb3Rl
IHRoYXQgdGhpcyAKPj4gdm9sdGFnZSBpcwo+PiArwqAgY29uZmlndXJlZCBpbiBoYXJkd2FyZSwg
dHlwaWNhbGx5IHZpYSBhIHJlc2lzdG9yIGRpdmlkZXIuCj4+ICstIG52aWRpYSxwd20tbWluLW1p
Y3Jvdm9sdHM6IFJlZ3VsYXRvciB2b2x0YWdlIGluIG1pY3JvIHZvbHRzIHdoZW4gCj4+IFBXTSBj
b250cm9sCj4+ICvCoCBpcyBlbmFibGVkIGFuZCBQV00gb3V0cHV0IGlzIGxvdy4gSGVuY2UsIHRo
aXMgaXMgdGhlIG1pbmltdW0gb3V0cHV0IAo+PiB2b2x0YWdlCj4+ICvCoCB0aGF0IHRoZSByZWd1
bGF0b3Igc3VwcG9ydHMgd2hlbiBQV00gY29udHJvbCBpcyBlbmFibGVkLgo+PiArLSBudmlkaWEs
cHdtLXZvbHRhZ2Utc3RlcC1taWNyb3ZvbHRzOiBWb2x0YWdlIGluY3JlYXNlIGluIG1pY3JvIHZv
bHRzCj4+ICvCoCBjb3JyZXNwb25kaW5nIHRvIGEgMS8zM3RoIGluY3JlYXNlIGluIGR1dHkgY3lj
bGUuIEVnIHRoZSB2b2x0YWdlIAo+PiBmb3IgMi8zM3RoCj4+ICvCoCBkdXR5IGN5Y2xlIHdvdWxk
IGJlOiBudmlkaWEscHdtLW1pbi1taWNyb3ZvbHRzICsKPj4gK8KgIG52aWRpYSxwd20tdm9sdGFn
ZS1zdGVwLW1pY3Jvdm9sdHMgKiAyLgo+PiArLSBwaW5jdHJsLTA6IEkvTyBwYWQgY29uZmlndXJh
dGlvbiB3aGVuIFBXTSBjb250cm9sIGlzIGVuYWJsZWQuCj4+ICstIHBpbmN0cmwtMTogSS9PIHBh
ZCBjb25maWd1cmF0aW9uIHdoZW4gUFdNIGNvbnRyb2wgaXMgZGlzYWJsZWQuCj4+ICstIHBpbmN0
cmwtbmFtZXM6IG11c3QgaW5jbHVkZSB0aGUgZm9sbG93aW5nIGVudHJpZXM6Cj4+ICvCoCAtIGR2
ZnNfcHdtX2VuYWJsZTogSS9PIHBhZCBjb25maWd1cmF0aW9uIHdoZW4gUFdNIGNvbnRyb2wgaXMg
ZW5hYmxlZC4KPj4gK8KgIC0gZHZmc19wd21fZGlzYWJsZTogSS9PIHBhZCBjb25maWd1cmF0aW9u
IHdoZW4gUFdNIGNvbnRyb2wgaXMgCj4+IGRpc2FibGVkLgo+PiArCj4+ICtFeGFtcGxlIGZvciBJ
MkM6Cj4+IMKgIGNsb2NrQDcwMTEwMDAwIHsKPj4gwqDCoMKgwqDCoMKgwqDCoMKgIGNvbXBhdGli
bGUgPSAibnZpZGlhLHRlZ3JhMTI0LWRmbGwiOwo+PiBAQCAtNzYsMyArOTYsNTggQEAgY2xvY2tA
NzAxMTAwMDAgewo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgbnZpZGlhLGkyYy1mcy1yYXRlID0gPDQw
MDAwMD47Cj4+IMKgIH07Cj4+ICsKPj4gK0V4YW1wbGUgZm9yIFBXTToKPj4gKwo+PiArY2xvY2tA
NzAxMTAwMDAgewo+PiArwqDCoMKgIGNvbXBhdGlibGUgPSAibnZpZGlhLHRlZ3JhMTI0LWRmbGwi
Owo+PiArwqDCoMKgIHJlZyA9IDwwIDB4NzAxMTAwMDAgMCAweDEwMD4sIC8qIERGTEwgY29udHJv
bCAqLwo+PiArwqDCoMKgwqDCoMKgwqDCoMKgIDwwIDB4NzAxMTAwMDAgMCAweDEwMD4sIC8qIEky
QyBvdXRwdXQgY29udHJvbCAqLwo+PiArwqDCoMKgwqDCoMKgwqDCoMKgIDwwIDB4NzAxMTAxMDAg
MCAweDEwMD4sIC8qIEludGVncmF0ZWQgSTJDIGNvbnRyb2xsZXIgKi8KPj4gK8KgwqDCoMKgwqDC
oMKgwqDCoCA8MCAweDcwMTEwMjAwIDAgMHgxMDA+OyAvKiBMb29rLXVwIHRhYmxlIFJBTSAqLwo+
PiArwqDCoMKgIGludGVycnVwdHMgPSA8R0lDX1NQSSA2MiBJUlFfVFlQRV9MRVZFTF9ISUdIPjsK
Pj4gK8KgwqDCoCBjbG9ja3MgPSA8JnRlZ3JhX2NhciBURUdSQTIxMF9DTEtfREZMTF9TT0M+LAo+
PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIDwmdGVncmFfY2FyIFRFR1JBMjEwX0NMS19ERkxM
X1JFRj4sCj4+ICvCoMKgwqDCoMKgwqDCoMKgIDwmdGVncmFfY2FyIFRFR1JBMTI0X0NMS19JMkM1
Pjs7Cj4+ICvCoMKgwqAgY2xvY2stbmFtZXMgPSAic29jIiwgInJlZiIsICJpMmMiOwo+PiArwqDC
oMKgIHJlc2V0cyA9IDwmdGVncmFfY2FyIFRFR1JBMTI0X1JTVF9ERkxMX0RWQ08+Owo+PiArwqDC
oMKgIHJlc2V0LW5hbWVzID0gImR2Y28iOwo+PiArwqDCoMKgICNjbG9jay1jZWxscyA9IDwwPjsK
Pj4gK8KgwqDCoCBjbG9jay1vdXRwdXQtbmFtZXMgPSAiZGZsbENQVV9vdXQiOwo+PiArCj4+ICvC
oMKgwqAgbnZpZGlhLHNhbXBsZS1yYXRlID0gPDI1MDAwPjsKPj4gK8KgwqDCoCBudmlkaWEsZHJv
b3AtY3RybCA9IDwweDAwMDAwZjAwPjsKPj4gK8KgwqDCoCBudmlkaWEsZm9yY2UtbW9kZSA9IDwx
PjsKPj4gK8KgwqDCoCBudmlkaWEsY2YgPSA8Nj47Cj4+ICvCoMKgwqAgbnZpZGlhLGNpID0gPDA+
Owo+PiArwqDCoMKgIG52aWRpYSxjZyA9IDwyPjsKPj4gKwo+PiArwqDCoMKgIG52aWRpYSxwd20t
bWluLW1pY3Jvdm9sdHMgPSA8NzA4MDAwPjsgLyogNzA4bVYgKi8KPj4gK8KgwqDCoCBudmlkaWEs
cHdtLXBlcmlvZC1uYW5vc2Vjb25kcyA9IDwyNTAwPjsgLyogMi41dXMgKi8KPj4gK8KgwqDCoCBu
dmlkaWEscHdtLXRvLXBtaWM7Cj4+ICvCoMKgwqAgbnZpZGlhLHB3bS10cmlzdGF0ZS1taWNyb3Zv
bHRzID0gPDEwMDAwMDA+Owo+PiArwqDCoMKgIG52aWRpYSxwd20tdm9sdGFnZS1zdGVwLW1pY3Jv
dm9sdHMgPSA8MTkyMDA+OyAvKiAxOS4ybVYgKi8KPj4gKwo+PiArwqDCoMKgIHBpbmN0cmwtbmFt
ZXMgPSAiZHZmc19wd21fZW5hYmxlIiwgImR2ZnNfcHdtX2Rpc2FibGUiOwo+PiArwqDCoMKgIHBp
bmN0cmwtMCA9IDwmZHZmc19wd21fYWN0aXZlX3N0YXRlPjsKPj4gK8KgwqDCoCBwaW5jdHJsLTEg
PSA8JmR2ZnNfcHdtX2luYWN0aXZlX3N0YXRlPjsKPj4gK307Cj4+ICsKPj4gKy8qIHBpbm11eCBu
b2RlcyBhZGRlZCBmb3IgY29tcGxldGVuZXNzLiBCaW5kaW5nIGRvYyBjYW4gYmUgZm91bmQgaW46
Cj4+ICsgKiBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcGluY3RybC9udmlkaWEs
dGVncmEyMTAtcGlubXV4LnR4dAo+PiArICovCj4+ICsKPj4gK3Bpbm11eDogcGlubXV4QDcwMDAw
OGQ0IHsKPj4gK8KgwqDCoCBkdmZzX3B3bV9hY3RpdmVfc3RhdGU6IGR2ZnNfcHdtX2FjdGl2ZSB7
Cj4+ICvCoMKgwqDCoMKgwqDCoCBkdmZzX3B3bV9wYmIxIHsKPj4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgbnZpZGlhLHBpbnMgPSAiZHZmc19wd21fcGJiMSI7Cj4+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIG52aWRpYSx0cmlzdGF0ZSA9IDxURUdSQV9QSU5fRElTQUJMRT47Cj4+ICvCoMKgwqDC
oMKgwqDCoCB9Owo+PiArwqDCoMKgIH07Cj4+ICvCoMKgwqAgZHZmc19wd21faW5hY3RpdmVfc3Rh
dGU6IGR2ZnNfcHdtX2luYWN0aXZlIHsKPj4gK8KgwqDCoMKgwqDCoMKgIGR2ZnNfcHdtX3BiYjEg
ewo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBudmlkaWEscGlucyA9ICJkdmZzX3B3bV9wYmIx
IjsKPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgbnZpZGlhLHRyaXN0YXRlID0gPFRFR1JBX1BJ
Tl9FTkFCTEU+Owo+PiArwqDCoMKgwqDCoMKgwqAgfTsKPj4gK8KgwqDCoCB9Owo+PiArfTsKPj4K
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFy
bS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9y
ZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1r
ZXJuZWwK
