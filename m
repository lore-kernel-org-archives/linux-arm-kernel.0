Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F5EFC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 09:32:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E53A120821
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 09:32:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dQdu48/m";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="XKn2Y59G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E53A120821
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=5jgF3Hfrkywm/pF89Xr1F/jveXrHgiz1CZJbpHlNo7w=; b=dQdu48/mT9eSbM8It6tJEv0+3
	qVfLgICxmX6zCSOFZuo1+hLgB0AwsjYoMgEs4l+krin+i0i7n4N4sRKYfxOGLCtUDXShv4gEu5CGq
	jsB2SrwrDm1bw5ch8cOQ8mKJnbUVp7MBq+3WHIl3vLiUpNgDzrmlrBTxrcC39L4hEi6FhZBIawAJ+
	ZtRW6E2bNx2Zz/NwVThV8qk6yd9g3jDXOMW/Q2HdoEkft0SaTtMSX0ZonTlCj63SN28dX2NQWmh+o
	uraY7h/dTjA79jb/akFK3/yPnfNZ5ln69BUHukkScHxJj2Gphf8a4EPQL8sP6e63v2yo/TT9ePTzM
	y4Xyvcdrw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWHv9-0003Ld-Lp; Mon, 10 Dec 2018 09:32:11 +0000
Received: from hqemgate16.nvidia.com ([216.228.121.65])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWHv1-0003HT-0k
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 09:32:09 +0000
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5c0e32830000>; Mon, 10 Dec 2018 01:31:47 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Mon, 10 Dec 2018 01:31:50 -0800
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Mon, 10 Dec 2018 01:31:50 -0800
Received: from [10.19.108.132] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Mon, 10 Dec
 2018 09:31:47 +0000
Subject: Re: [PATCH 01/19] dt-bindings: clock: tegra124-dfll: Update DFLL
 binding for PWM regulator
To: Jon Hunter <jonathanh@nvidia.com>, Thierry Reding
 <thierry.reding@gmail.com>, Peter De Schrijver <pdeschrijver@nvidia.com>
References: <20181204092548.3038-1-josephl@nvidia.com>
 <20181204092548.3038-2-josephl@nvidia.com>
 <af1211f0-dda0-bdde-f320-03e54f82d7e1@nvidia.com>
 <46b5eafa-00a0-1d91-1f4d-97ab119fcf21@nvidia.com>
 <e61b1da8-78cd-c3d4-9878-c25fd9c89ba3@nvidia.com>
From: Joseph Lo <josephl@nvidia.com>
Message-ID: <433ed5cf-70ce-1d03-530f-406b2cb16e07@nvidia.com>
Date: Mon, 10 Dec 2018 17:31:46 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <e61b1da8-78cd-c3d4-9878-c25fd9c89ba3@nvidia.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL108.nvidia.com (172.18.146.13) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1544434307; bh=svkkyImJmZrFuduXpS1ssjYzxqZdlEVXGoXI4XuZ4WY=;
 h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
 User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
 X-ClientProxiedBy:Content-Type:Content-Language:
 Content-Transfer-Encoding;
 b=XKn2Y59GNjHofLZu7nntCBzKhRo1GbKjiCcvWnF3JK4V6c8sZZ5821j3LFruAVcu+
 JypCrm3n9nBtbu9Kv5RXR3KkhIllAXAnhAAPmBoB2hA5ZPIFVhMNcHqg2y5H+YqEoL
 U6Ph7Qa7uCmtXmuZN7Gl3wPIyFTSZBKwL2TaWARgALrIiaFyg6oneOnsKxv+8i2NGr
 jLNemuOASAXTHD8PPAT0Z4fRBpVDIRypfPa3s9k2PGSKg4sr05htYlGR8XVcQWNUpI
 SdIuMuaLT8e07DXsSDdyOHgmSMOD9wMQkNBEW+/vT7Io0P+jWkJCy44I9TQjx1cBvP
 5g+/oW6RdL5nw==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_013203_077864_DEA0E574 
X-CRM114-Status: GOOD (  22.33  )
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

T24gMTIvMTAvMTggNDo1OSBQTSwgSm9uIEh1bnRlciB3cm90ZToKPiAKPiBPbiAxMC8xMi8yMDE4
IDA4OjQ5LCBKb3NlcGggTG8gd3JvdGU6Cj4+IEhpIEpvbiwKPj4KPj4gVGhhbmtzIGZvciByZXZp
ZXdpbmcgdGhpcyBzZXJpZXMuCj4+Cj4+IE9uIDEyLzcvMTggOTo0MSBQTSwgSm9uIEh1bnRlciB3
cm90ZToKPj4+Cj4+PiBPbiAwNC8xMi8yMDE4IDA5OjI1LCBKb3NlcGggTG8gd3JvdGU6Cj4+Pj4g
RnJvbTogUGV0ZXIgRGUgU2NocmlqdmVyIDxwZGVzY2hyaWp2ZXJAbnZpZGlhLmNvbT4KPj4+Pgo+
Pj4+IEFkZCBuZXcgcHJvcGVydGllcyB0byBjb25maWd1cmUgdGhlIERGTEwgUFdNIHJlZ3VsYXRv
ciBzdXBwb3J0LiBBbHNvCj4+Pj4gYWRkIGFuIGV4YW1wbGUgYW5kIG1ha2UgdGhlIEkyQyBjbG9j
ayBvbmx5IHJlcXVpcmVkIHdoZW4gSTJDIHN1cHBvcnQgaXMKPj4+PiB1c2VkLgo+Pj4+Cj4+Pj4g
Q2M6IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnCj4+Pj4gU2lnbmVkLW9mZi1ieTogUGV0ZXIg
RGUgU2NocmlqdmVyIDxwZGVzY2hyaWp2ZXJAbnZpZGlhLmNvbT4KPj4+PiBTaWduZWQtb2ZmLWJ5
OiBKb3NlcGggTG8gPGpvc2VwaGxAbnZpZGlhLmNvbT4KPj4+PiAtLS0KPj4+PiAgwqAgLi4uL2Jp
bmRpbmdzL2Nsb2NrL252aWRpYSx0ZWdyYTEyNC1kZmxsLnR4dMKgwqAgfCA3MyArKysrKysrKysr
KysrKysrKystCj4+Pj4gIMKgIDEgZmlsZSBjaGFuZ2VkLCA3MSBpbnNlcnRpb25zKCspLCAyIGRl
bGV0aW9ucygtKQo+Pj4+Cj4+Pj4gZGlmZiAtLWdpdAo+Pj4+IGEvRG9jdW1lbnRhdGlvbi9kZXZp
Y2V0cmVlL2JpbmRpbmdzL2Nsb2NrL252aWRpYSx0ZWdyYTEyNC1kZmxsLnR4dAo+Pj4+IGIvRG9j
dW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Nsb2NrL252aWRpYSx0ZWdyYTEyNC1kZmxs
LnR4dAo+Pj4+IGluZGV4IGRmZjIzNmY1MjRhNy4uOGM5NzYwMGQyYmFkIDEwMDY0NAo+Pj4+IC0t
LSBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9jbG9jay9udmlkaWEsdGVncmEx
MjQtZGZsbC50eHQKPj4+PiArKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mv
Y2xvY2svbnZpZGlhLHRlZ3JhMTI0LWRmbGwudHh0Cj4+Pj4gQEAgLTgsNyArOCw2IEBAIHRoZSBm
YXN0IENQVSBjbHVzdGVyLiBJdCBjb25zaXN0cyBvZiBhIGZyZWUtcnVubmluZwo+Pj4+IHZvbHRh
Z2UgY29udHJvbGxlZAo+Pj4+ICDCoCBvc2NpbGxhdG9yIGNvbm5lY3RlZCB0byB0aGUgQ1BVIHZv
bHRhZ2UgcmFpbCAoVkREX0NQVSksIGFuZCBhCj4+Pj4gY2xvc2VkIGxvb3AKPj4+PiAgwqAgY29u
dHJvbCBtb2R1bGUgdGhhdCB3aWxsIGF1dG9tYXRpY2FsbHkgYWRqdXN0IHRoZSBWRERfQ1BVIHZv
bHRhZ2UgYnkKPj4+PiAgwqAgY29tbXVuaWNhdGluZyB3aXRoIGFuIG9mZi1jaGlwIFBNSUMgZWl0
aGVyIHZpYSBhbiBJMkMgYnVzIG9yIHZpYQo+Pj4+IFBXTSBzaWduYWxzLgo+Pj4+IC1DdXJyZW50
bHkgb25seSB0aGUgSTJDIG1vZGUgaXMgc3VwcG9ydGVkIGJ5IHRoZXNlIGJpbmRpbmdzLgo+Pj4+
ICDCoCDCoCBSZXF1aXJlZCBwcm9wZXJ0aWVzOgo+Pj4+ICDCoCAtIGNvbXBhdGlibGUgOiBzaG91
bGQgYmUgIm52aWRpYSx0ZWdyYTEyNC1kZmxsIgo+Pj4+IEBAIC00NSwxMCArNDQsMjggQEAgUmVx
dWlyZWQgcHJvcGVydGllcyBmb3IgdGhlIGNvbnRyb2wgbG9vcCBwYXJhbWV0ZXJzOgo+Pj4+ICDC
oCBPcHRpb25hbCBwcm9wZXJ0aWVzIGZvciB0aGUgY29udHJvbCBsb29wIHBhcmFtZXRlcnM6Cj4+
Pj4gIMKgIC0gbnZpZGlhLGNnLXNjYWxlOiBCb29sZWFuIHZhbHVlLCBzZWUgdGhlIGZpZWxkCj4+
Pj4gREZMTF9QQVJBTVNfQ0dfU0NBTEUgaW4gdGhlIFRSTS4KPj4+PiAgwqAgK09wdGlvbmFsIHBy
b3BlcnRpZXMgZm9yIG1vZGUgc2VsZWN0aW9uOgo+Pj4+ICstIG52aWRpYSxwd20tdG8tcG1pYzog
VXNlIFBXTSB0byBjb250cm9sIHJlZ3VsYXRvciByYXRoZXIgdGhlbiBJMkMuCj4+Pj4gKwo+Pj4+
ICDCoCBSZXF1aXJlZCBwcm9wZXJ0aWVzIGZvciBJMkMgbW9kZToKPj4+PiAgwqAgLSBudmlkaWEs
aTJjLWZzLXJhdGU6IEkyQyB0cmFuc2ZlciByYXRlLCBpZiB1c2luZyBmdWxsIHNwZWVkIG1vZGUu
Cj4+Pj4gIMKgIC1FeGFtcGxlOgo+Pj4+ICtSZXF1aXJlZCBwcm9wZXJ0aWVzIGZvciBQV00gbW9k
ZToKPj4+PiArLSBudmlkaWEscHdtLXBlcmlvZDogcGVyaW9kIG9mIFBXTSBzcXVhcmUgd2F2ZSBp
biBtaWNyb3NlY29uZHMuCj4+Pj4gKy0gbnZpZGlhLGluaXQtdXY6IFJlZ3VsYXRvciB2b2x0YWdl
IGluIG1pY3JvIHZvbHRzIHdoZW4gUFdNIGNvbnRyb2wKPj4+PiBpcyBkaXNhYmxlZC4KPj4+Cj4+
PiBNYXliZSBjb25zaWRlciAncHdtLWluYWN0aXZlLXZvbHRhZ2UtbWljcm92b2x0Jy4KPj4gQWgs
IEkgdGhpbmsgSSBuZWVkIHRvIHJlZmluZSB0aGUgZGVzY3JpcHRpb24gaGVyZS4gSXQgc2hvdWxk
IGJlCj4+IHNvbWV0aGluZyBsaWtlIGJlbG93Lgo+PiAgwqAtIG52aWRpYSxwd20taW5pdC1taWNy
b3ZvbHQgOiBSZWd1bGF0b3Igdm9sdGFnZSBpbiBtaWNybyB2b2x0cyB3aGVuIFBXTQo+PiBjb250
cm9sIGlzIGluaXRpYWxpemVkCj4+Cj4+IFRoaXMgaXMgdGhlIGluaXRpYWwgdm9sdGFnZSB0aGF0
IHdoZW4gd2UganVzdCBpbml0aWFsaXplIHRoZSBERkxMCj4+IGhhcmR3YXJlIGZvciBQV00gb3V0
cHV0LiBBbmQgYmVmb3JlIHdlIHN3aXRjaCB0aGUgQ1BVIGNsb2NrIGZyb20gUExMWCB0bwo+PiBE
RkxMLCB3ZSB3aWxsIGVuYWJsZSBERkxMIGhhcmR3YXJlIGluIGNsb3NlZCBsb29wIG1vZGUgd2hp
Y2ggd2lsbCBhcGxseQo+PiB0aGUgRFZGUyB0YWJsZSB0aGF0IHdhcyBjYWxjdWxhdGVkIGZyb20g
Q1ZCIHRhYmxlLgo+Pgo+PiBUaGUgb3JpZ2luYWwgZGVzY3JpcHRpb24gbWF5YmUgbWFrZSB5b3Ug
dGhpbmsgdGhhdCBpdCdzIHRoZSB3b3JraW5nCj4+IHZvbHRhZ2Ugd2hlbiBpdCdzIHVuZGVyIG9w
ZW4tbG9vcCBtb2RlLiBCdXQgaXQncyBub3QuIFNvcnJ5Lgo+Pgo+PiBXaGVuIHdlIHdvcmtpbmcg
b24gb3Blbi1sb29wIG1vZGUgd2hpY2ggd2lsbCBzd2l0Y2ggdG8gbG93IHZvbHRhZ2UgcmFuZ2UK
Pj4gd2hpY2ggYWxzbyBmb2xsb3dzIHRoZSBEVkZTIHRhYmxlLiBOb3QgdGhpcyBvbmUuCj4gCj4g
T0ssIGJ1dCBJIGFtIHN0aWxsIG5vdCBzdXJlIHdoYXQgdGhpcyB2b2x0YWdlIGlzLiBJIG1lYW4g
dGhhdCBJCj4gdW5kZXJzdGFuZCBpdCBpcyB0aGUgaW5pdGlhbCB2b2x0YWdlLCBidXQgaG93IGV4
YWN0bHkgZG8gd2UgZGVmaW5lIHRoaXMKPiBudW1iZXI/IFdoZXJlIGRvZXMgaXQgY29tZSBmcm9t
LCBob3cgaXMgdGhpcyBkZXRlcm1pbmVkPwpJSVJDLCB0aGlzIGlzIHRoZSBzYW1lIG91dHB1dCB2
b2x0YWdlIHRoYXQgYm9vdGxvYWRlciBjb25maWd1cmVkIHdpdGggCnByb3BlciBQTExYIHJhdGUu
IFNvIGJlZm9yZSBERkxMIGhhbmRsaW5nIHRoZSBDUFUgY2xvY2ssIHRoYXQgaXMgdGhlIApvdXRw
dXQgdm9sdGFnZS4gV2UgY29uZmlndXJlIHRoZSBzYW1lIHdoZW4gREZMTCBIVyBpcyBqdXN0IGlu
aXRpYWxpemVkLgoKMSB2b2x0IGhlcmUgaXMgcHJldHR5IHNhZmUgd2hlbiBDUFUgY2xvY2sgc3dp
dGNoZWQgZnJvbSBib290bG9hZGVyIHRvIAprZXJuZWwgYXQgNi45MTJNSHpAcGxseC4KCj4gCj4+
Pgo+Pj4+ICstIG52aWRpYSxhbGlnbi1vZmZzZXQtdXY6IFJlZ3VsYXRvciB2b2x0YWdlIGluIG1p
Y3JvIHZvbHRzIHdoZW4gUFdNCj4+Pj4gY29udHJvbCBpcwo+Pj4+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBlbmFibGVkIGFuZCBQV00gb3V0cHV0IGlzIGxvdy4KPj4+Cj4+PiBXb3VsZCB0
aGlzIGJlIGNvbnNpZGVyZWQgdGhlIG1pbmltdW0gcHdtIGFjdGl2ZSB2b2x0YWdlPwo+PiBUaGlz
IHdvdWxkIGJlIHVzZWQgZm9yIG1pbmltdW0gdm9sdGFnZSBmb3IgTFVUIHRhYmxlLCB3aGljaCBp
cyB0aGUgdGFibGUKPj4gdGhhdCBQTUlDIGNhbiBvdXRwdXQuIFRoZSByZWFsIG1pbmltdW0gdm9s
dGFnZSBpbiBQV00gbW9kZSBzdGlsbCBkZXBlbmRzCj4+IG9uIHRoZSBDVkIgdGFibGUuCj4+Cj4+
IFNvIG1heWJlIGNoYW5nZSB0aGlzIG9uZSB0byAnbnZpZGlhLHB3bS1vZmZzZXQtdXYnLgo+IAo+
IFNvIGlzIHRoaXMgdGhlIG1pbiBzdXBwb3J0ZWQgYnkgdGhlIFBNSUM/IE1heWJlIHRoZSBuYW1l
IHNob3VsZCByZWZsZWN0Cj4gdGhhdCBiZWNhdXNlIHRoZSBhYm92ZSBuYW1lIGRvZXMgbm90IHJl
ZmxlY3QgdGhpcy4gRnVydGhlcm1vcmUsIGlmIHRoaXMKPiBpcyBhIG1pbiB0aGVuIG1heWJlIHRo
ZSBuYW1lIHNob3VsZCB1c2UgJ21pbicgYXMgb3Bwb3NlZCB0byAnb2Zmc2V0Jy4KPiBmb3IgZXhh
bXBsZSwgJ252aWRpYSxwd20tcG1pYy1taW4tbWljcm92b2x0cycuCj4gCj4gRG9lcyB0aGlzIG5l
ZWQgdG8gYmUgZGVzY3JpYmVkIGluIERULCBjYW4gaXQgbm90IGJlIHF1ZXJpZWQgZnJvbSB0aGUg
UE1JQz8KPiAKWWVzLCBlaXRoZXIgd2F5IG5lZWRzIHRvIGdvIHdpdGggRFQuIFRoZSB2ZXJ5IGlu
aXRpYWwgcGF0Y2hzZXQgZm9yIApERkxMLVBXTSBzdXBwb3J0LCB3aGljaCBpbnRyb2R1Y2VkIGEg
cmVkdW5kYW50IHB3bS1kZmxsIGRyaXZlci4gQW5kIHdpdGggCnRoZSBkcml2ZXIsIHdlIGNhbiBk
ZXNjcmliZSB0aGUgUFdNIHZkZC1jcHUgcmVndWxhdG9yIGluIERUIHdpdGggdGhlIAp2b2x0YWdl
IHRhYmxlIHRoYXQgdGhlIFBNSUMgY2FuIG91dHB1dC4gQnV0IE5BS2VkIGJ5IHJldmlld2VyLgoK
T2theSwgJ252aWRpYSxwd20tcG1pYy1taW4tbWljcm92b2x0cycgbG9va3MgZmluZS4gVGhhbmtz
LgoKWzFdOiBodHRwczovL3BhdGNod29yay5vemxhYnMub3JnL3BhdGNoLzYxMzUyNC8KCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJu
ZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRw
Oi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
