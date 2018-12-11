Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFF1DC07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 09:36:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE7C520811
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 09:36:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="G09UnuqU";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="kaVMtkpF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE7C520811
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=FPXmSLnPBa7qZx2OzsXe7Q9cQbnybS0nbXUwWIeFjUw=; b=G09UnuqUeXJFtt+yHHbiLyG2y
	Hya1y0DDwlvOst9VlNEnyyKemsqkm1xgbTQTAEDpAR7l+7aSems9KsT68izFj36lVe2oGuLeMIM11
	PNtpNGyKYczBcBC24y5syTuISX+NglfzMhmOsTOFBXkE+tjQLzThb3S+m8NBX9rglxYY0QhR6wnTb
	aMGyRnfLEj17NTELhq+lhrIkFVxe5Q/s2cHHey9QyML/WVfbh/4SUDD7lRH8rKjm361H1KxUYnx4D
	7gZ2bSa/1ltGeVSdqqzxnZHBHtjXaO7fEx6EHb745U2Y/+9HJpp85N/6Nl7616lrSu1nDpu4V9qD5
	Vzh33wacw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWeT7-0006Fi-E8; Tue, 11 Dec 2018 09:36:45 +0000
Received: from hqemgate14.nvidia.com ([216.228.121.143])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWeT3-0006EU-JE
 for linux-arm-kernel@lists.infradead.org; Tue, 11 Dec 2018 09:36:43 +0000
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5c0f851c0000>; Tue, 11 Dec 2018 01:36:28 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Tue, 11 Dec 2018 01:36:31 -0800
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Tue, 11 Dec 2018 01:36:31 -0800
Received: from [10.19.108.132] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 11 Dec
 2018 09:36:29 +0000
Subject: Re: [PATCH 01/19] dt-bindings: clock: tegra124-dfll: Update DFLL
 binding for PWM regulator
To: Peter De Schrijver <pdeschrijver@nvidia.com>, Jon Hunter
 <jonathanh@nvidia.com>
References: <20181204092548.3038-1-josephl@nvidia.com>
 <20181204092548.3038-2-josephl@nvidia.com>
 <af1211f0-dda0-bdde-f320-03e54f82d7e1@nvidia.com>
 <46b5eafa-00a0-1d91-1f4d-97ab119fcf21@nvidia.com>
 <e61b1da8-78cd-c3d4-9878-c25fd9c89ba3@nvidia.com>
 <20181211091641.GB29064@pdeschrijver-desktop.Nvidia.com>
From: Joseph Lo <josephl@nvidia.com>
Message-ID: <1293c1a9-a39b-6193-99a1-cdf1d67d2ca8@nvidia.com>
Date: Tue, 11 Dec 2018 17:36:27 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181211091641.GB29064@pdeschrijver-desktop.Nvidia.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL108.nvidia.com (172.18.146.13) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1544520988; bh=ebn3nzHVLkR3tsCkUF9v+OJ2QqielUXjkVWI522zgyY=;
 h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
 User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
 X-ClientProxiedBy:Content-Type:Content-Language:
 Content-Transfer-Encoding;
 b=kaVMtkpFU82hhMfmpWZg86qtUccizG3+skJ+dQf1ANl09sfvMnG3bIL7KGkheYTJx
 23qLB6G7qm46Fft4oIa4doxjKBKr9tc11feH7Y48KhgLDCj2rYelm3WIy97nVLn7E5
 RpymxGc8IpP6fYhnzGGBNcCh77tAF2T0iuBpS+tY+7vRWgiI9cXF1q7IugD3poMn1h
 0jEkhIuRdrEGWJECsbPmGNbU2G6cf3nLPTpC6ICKX9E6uu3H78omJ2mjruUktKVu4g
 e3sTHi6VxKptE9q0t0+GJ1cz1xC4SqTP7NGoBDc9/yt9PmazwmFxEJZWWW4NVUqJ7/
 c13NRo8R7tcqw==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_013641_649136_A066069B 
X-CRM114-Status: GOOD (  20.28  )
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
 Thierry Reding <thierry.reding@gmail.com>, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gMTIvMTEvMTggNToxNiBQTSwgUGV0ZXIgRGUgU2NocmlqdmVyIHdyb3RlOgo+IE9uIE1vbiwg
RGVjIDEwLCAyMDE4IGF0IDA4OjU5OjEwQU0gKzAwMDAsIEpvbiBIdW50ZXIgd3JvdGU6Cj4+Cj4+
IE9uIDEwLzEyLzIwMTggMDg6NDksIEpvc2VwaCBMbyB3cm90ZToKPj4+IEhpIEpvbiwKPj4+Cj4+
PiBUaGFua3MgZm9yIHJldmlld2luZyB0aGlzIHNlcmllcy4KPj4+Cj4+PiBPbiAxMi83LzE4IDk6
NDEgUE0sIEpvbiBIdW50ZXIgd3JvdGU6Cj4+Pj4KPj4+PiBPbiAwNC8xMi8yMDE4IDA5OjI1LCBK
b3NlcGggTG8gd3JvdGU6Cj4+Pj4+IEZyb206IFBldGVyIERlIFNjaHJpanZlciA8cGRlc2Nocmlq
dmVyQG52aWRpYS5jb20+Cj4+Pj4+Cj4+Pj4+IEFkZCBuZXcgcHJvcGVydGllcyB0byBjb25maWd1
cmUgdGhlIERGTEwgUFdNIHJlZ3VsYXRvciBzdXBwb3J0LiBBbHNvCj4+Pj4+IGFkZCBhbiBleGFt
cGxlIGFuZCBtYWtlIHRoZSBJMkMgY2xvY2sgb25seSByZXF1aXJlZCB3aGVuIEkyQyBzdXBwb3J0
IGlzCj4+Pj4+IHVzZWQuCj4+Pj4+Cj4+Pj4+IENjOiBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9y
Zwo+Pj4+PiBTaWduZWQtb2ZmLWJ5OiBQZXRlciBEZSBTY2hyaWp2ZXIgPHBkZXNjaHJpanZlckBu
dmlkaWEuY29tPgo+Pj4+PiBTaWduZWQtb2ZmLWJ5OiBKb3NlcGggTG8gPGpvc2VwaGxAbnZpZGlh
LmNvbT4KPj4+Pj4gLS0tCj4+Pj4+ICDCoCAuLi4vYmluZGluZ3MvY2xvY2svbnZpZGlhLHRlZ3Jh
MTI0LWRmbGwudHh0wqDCoCB8IDczICsrKysrKysrKysrKysrKysrKy0KPj4+Pj4gIMKgIDEgZmls
ZSBjaGFuZ2VkLCA3MSBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQo+Pj4+Pgo+Pj4+PiBk
aWZmIC0tZ2l0Cj4+Pj4+IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Nsb2Nr
L252aWRpYSx0ZWdyYTEyNC1kZmxsLnR4dAo+Pj4+PiBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJl
ZS9iaW5kaW5ncy9jbG9jay9udmlkaWEsdGVncmExMjQtZGZsbC50eHQKPj4+Pj4gaW5kZXggZGZm
MjM2ZjUyNGE3Li44Yzk3NjAwZDJiYWQgMTAwNjQ0Cj4+Pj4+IC0tLSBhL0RvY3VtZW50YXRpb24v
ZGV2aWNldHJlZS9iaW5kaW5ncy9jbG9jay9udmlkaWEsdGVncmExMjQtZGZsbC50eHQKPj4+Pj4g
KysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Nsb2NrL252aWRpYSx0ZWdy
YTEyNC1kZmxsLnR4dAo+Pj4+PiBAQCAtOCw3ICs4LDYgQEAgdGhlIGZhc3QgQ1BVIGNsdXN0ZXIu
IEl0IGNvbnNpc3RzIG9mIGEgZnJlZS1ydW5uaW5nCj4+Pj4+IHZvbHRhZ2UgY29udHJvbGxlZAo+
Pj4+PiAgwqAgb3NjaWxsYXRvciBjb25uZWN0ZWQgdG8gdGhlIENQVSB2b2x0YWdlIHJhaWwgKFZE
RF9DUFUpLCBhbmQgYQo+Pj4+PiBjbG9zZWQgbG9vcAo+Pj4+PiAgwqAgY29udHJvbCBtb2R1bGUg
dGhhdCB3aWxsIGF1dG9tYXRpY2FsbHkgYWRqdXN0IHRoZSBWRERfQ1BVIHZvbHRhZ2UgYnkKPj4+
Pj4gIMKgIGNvbW11bmljYXRpbmcgd2l0aCBhbiBvZmYtY2hpcCBQTUlDIGVpdGhlciB2aWEgYW4g
STJDIGJ1cyBvciB2aWEKPj4+Pj4gUFdNIHNpZ25hbHMuCj4+Pj4+IC1DdXJyZW50bHkgb25seSB0
aGUgSTJDIG1vZGUgaXMgc3VwcG9ydGVkIGJ5IHRoZXNlIGJpbmRpbmdzLgo+Pj4+PiAgwqAgwqAg
UmVxdWlyZWQgcHJvcGVydGllczoKPj4+Pj4gIMKgIC0gY29tcGF0aWJsZSA6IHNob3VsZCBiZSAi
bnZpZGlhLHRlZ3JhMTI0LWRmbGwiCj4+Pj4+IEBAIC00NSwxMCArNDQsMjggQEAgUmVxdWlyZWQg
cHJvcGVydGllcyBmb3IgdGhlIGNvbnRyb2wgbG9vcCBwYXJhbWV0ZXJzOgo+Pj4+PiAgwqAgT3B0
aW9uYWwgcHJvcGVydGllcyBmb3IgdGhlIGNvbnRyb2wgbG9vcCBwYXJhbWV0ZXJzOgo+Pj4+PiAg
wqAgLSBudmlkaWEsY2ctc2NhbGU6IEJvb2xlYW4gdmFsdWUsIHNlZSB0aGUgZmllbGQKPj4+Pj4g
REZMTF9QQVJBTVNfQ0dfU0NBTEUgaW4gdGhlIFRSTS4KPj4+Pj4gIMKgICtPcHRpb25hbCBwcm9w
ZXJ0aWVzIGZvciBtb2RlIHNlbGVjdGlvbjoKPj4+Pj4gKy0gbnZpZGlhLHB3bS10by1wbWljOiBV
c2UgUFdNIHRvIGNvbnRyb2wgcmVndWxhdG9yIHJhdGhlciB0aGVuIEkyQy4KPj4+Pj4gKwo+Pj4+
PiAgwqAgUmVxdWlyZWQgcHJvcGVydGllcyBmb3IgSTJDIG1vZGU6Cj4+Pj4+ICDCoCAtIG52aWRp
YSxpMmMtZnMtcmF0ZTogSTJDIHRyYW5zZmVyIHJhdGUsIGlmIHVzaW5nIGZ1bGwgc3BlZWQgbW9k
ZS4KPj4+Pj4gIMKgIC1FeGFtcGxlOgo+Pj4+PiArUmVxdWlyZWQgcHJvcGVydGllcyBmb3IgUFdN
IG1vZGU6Cj4+Pj4+ICstIG52aWRpYSxwd20tcGVyaW9kOiBwZXJpb2Qgb2YgUFdNIHNxdWFyZSB3
YXZlIGluIG1pY3Jvc2Vjb25kcy4KPj4+Pj4gKy0gbnZpZGlhLGluaXQtdXY6IFJlZ3VsYXRvciB2
b2x0YWdlIGluIG1pY3JvIHZvbHRzIHdoZW4gUFdNIGNvbnRyb2wKPj4+Pj4gaXMgZGlzYWJsZWQu
Cj4+Pj4KPj4+PiBNYXliZSBjb25zaWRlciAncHdtLWluYWN0aXZlLXZvbHRhZ2UtbWljcm92b2x0
Jy4KPj4+IEFoLCBJIHRoaW5rIEkgbmVlZCB0byByZWZpbmUgdGhlIGRlc2NyaXB0aW9uIGhlcmUu
IEl0IHNob3VsZCBiZQo+Pj4gc29tZXRoaW5nIGxpa2UgYmVsb3cuCj4+PiAgwqAtIG52aWRpYSxw
d20taW5pdC1taWNyb3ZvbHQgOiBSZWd1bGF0b3Igdm9sdGFnZSBpbiBtaWNybyB2b2x0cyB3aGVu
IFBXTQo+Pj4gY29udHJvbCBpcyBpbml0aWFsaXplZAo+Pj4KPj4+IFRoaXMgaXMgdGhlIGluaXRp
YWwgdm9sdGFnZSB0aGF0IHdoZW4gd2UganVzdCBpbml0aWFsaXplIHRoZSBERkxMCj4+PiBoYXJk
d2FyZSBmb3IgUFdNIG91dHB1dC4gQW5kIGJlZm9yZSB3ZSBzd2l0Y2ggdGhlIENQVSBjbG9jayBm
cm9tIFBMTFggdG8KPj4+IERGTEwsIHdlIHdpbGwgZW5hYmxlIERGTEwgaGFyZHdhcmUgaW4gY2xv
c2VkIGxvb3AgbW9kZSB3aGljaCB3aWxsIGFwbGx5Cj4+PiB0aGUgRFZGUyB0YWJsZSB0aGF0IHdh
cyBjYWxjdWxhdGVkIGZyb20gQ1ZCIHRhYmxlLgo+Pj4KPj4+IFRoZSBvcmlnaW5hbCBkZXNjcmlw
dGlvbiBtYXliZSBtYWtlIHlvdSB0aGluayB0aGF0IGl0J3MgdGhlIHdvcmtpbmcKPj4+IHZvbHRh
Z2Ugd2hlbiBpdCdzIHVuZGVyIG9wZW4tbG9vcCBtb2RlLiBCdXQgaXQncyBub3QuIFNvcnJ5Lgo+
Pj4KPj4+IFdoZW4gd2Ugd29ya2luZyBvbiBvcGVuLWxvb3AgbW9kZSB3aGljaCB3aWxsIHN3aXRj
aCB0byBsb3cgdm9sdGFnZSByYW5nZQo+Pj4gd2hpY2ggYWxzbyBmb2xsb3dzIHRoZSBEVkZTIHRh
YmxlLiBOb3QgdGhpcyBvbmUuCj4+Cj4+IE9LLCBidXQgSSBhbSBzdGlsbCBub3Qgc3VyZSB3aGF0
IHRoaXMgdm9sdGFnZSBpcy4gSSBtZWFuIHRoYXQgSQo+PiB1bmRlcnN0YW5kIGl0IGlzIHRoZSBp
bml0aWFsIHZvbHRhZ2UsIGJ1dCBob3cgZXhhY3RseSBkbyB3ZSBkZWZpbmUgdGhpcwo+PiBudW1i
ZXI/IFdoZXJlIGRvZXMgaXQgY29tZSBmcm9tLCBob3cgaXMgdGhpcyBkZXRlcm1pbmVkPwo+Pgo+
IAo+IEl0IGlzIHNldCBieSBhIHJlc2lzdGl2ZSBkaXZpZGVyIG9uIHRoZSBib2FyZCBpaXJjLgoK
WWVzLCBjb3JyZWN0LiBUaGUgcHJldmlvdXMgcmVwbHkgSSBkaWQgd2FzIHRoZSBjYXNlIG9mIEky
QyByZWd1bGF0b3IuIApTb3JyeSwgSSBtYWRlIHRoZSBjb25mdXNpb24gaGVyZS4KCj4gCj4+Pj4K
Pj4+Pj4gKy0gbnZpZGlhLGFsaWduLW9mZnNldC11djogUmVndWxhdG9yIHZvbHRhZ2UgaW4gbWlj
cm8gdm9sdHMgd2hlbiBQV00KPj4+Pj4gY29udHJvbCBpcwo+Pj4+PiArwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgZW5hYmxlZCBhbmQgUFdNIG91dHB1dCBpcyBsb3cuCj4+Pj4KPj4+PiBXb3Vs
ZCB0aGlzIGJlIGNvbnNpZGVyZWQgdGhlIG1pbmltdW0gcHdtIGFjdGl2ZSB2b2x0YWdlPwo+Pj4g
VGhpcyB3b3VsZCBiZSB1c2VkIGZvciBtaW5pbXVtIHZvbHRhZ2UgZm9yIExVVCB0YWJsZSwgd2hp
Y2ggaXMgdGhlIHRhYmxlCj4+PiB0aGF0IFBNSUMgY2FuIG91dHB1dC4gVGhlIHJlYWwgbWluaW11
bSB2b2x0YWdlIGluIFBXTSBtb2RlIHN0aWxsIGRlcGVuZHMKPj4+IG9uIHRoZSBDVkIgdGFibGUu
Cj4+Pgo+Pj4gU28gbWF5YmUgY2hhbmdlIHRoaXMgb25lIHRvICdudmlkaWEscHdtLW9mZnNldC11
dicuCj4+Cj4+IFNvIGlzIHRoaXMgdGhlIG1pbiBzdXBwb3J0ZWQgYnkgdGhlIFBNSUM/IE1heWJl
IHRoZSBuYW1lIHNob3VsZCByZWZsZWN0Cj4+IHRoYXQgYmVjYXVzZSB0aGUgYWJvdmUgbmFtZSBk
b2VzIG5vdCByZWZsZWN0IHRoaXMuIEZ1cnRoZXJtb3JlLCBpZiB0aGlzCj4+IGlzIGEgbWluIHRo
ZW4gbWF5YmUgdGhlIG5hbWUgc2hvdWxkIHVzZSAnbWluJyBhcyBvcHBvc2VkIHRvICdvZmZzZXQn
Lgo+PiBmb3IgZXhhbXBsZSwgJ252aWRpYSxwd20tcG1pYy1taW4tbWljcm92b2x0cycuCj4+Cj4+
IERvZXMgdGhpcyBuZWVkIHRvIGJlIGRlc2NyaWJlZCBpbiBEVCwgY2FuIGl0IG5vdCBiZSBxdWVy
aWVkIGZyb20gdGhlIFBNSUM/Cj4+Cj4gCj4gVGhlcmUgaXMgbm8gaW50ZXJmYWNlIHRvIHF1ZXJ5
IGFueXRoaW5nIGZyb20gdGhlIE9WUiByZWd1bGF0b3IuCj4gCj4gUGV0ZXIuCj4gCgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVs
IG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDov
L2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
