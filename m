Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFD41C04EBF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 11:08:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AAE532082B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 11:08:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="T0kkVGe0";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="YNebz0DD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAE532082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=partner.samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:References:In-Reply-To:MIME-Version:
	Date:Message-ID:From:To:Subject:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=hLLXS2SSMWFLOLgldJ6nAj8k1DPbXIjj0A777FRBkTk=; b=T0kkVGe0xhg9ux
	DDNiYrlKvWfQ3NFuh/Gvqy/X0rwOmoZE3KIQ5P4Z0bLzpeYK/ayfyWnP0J0NAWkO5k0s1RRGbtGxr
	qAVruXUW/ixJsNPh1kiq/enQc19B2iagjrfukUO7LuwEP/jpnfM6UBKz/pQgOqKS1A9m3NZ+OvD01
	x4mZGPbDeWMyWtmqIOZhEReFJNuzBNppdoNoAMVQDGjiMGW1VpwEkHINr+gG3FFMPr4leuuO6yM/y
	RZjJTfgFarQloc5zawMx4n8voi+SV+L8NsYH+VLMfIFKAPND76cqIQpkr2KVQjgYcx3kiqTIRuqST
	ancalwieNoVPn20Wlufw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUV2d-0001SM-N9; Wed, 05 Dec 2018 11:08:31 +0000
Received: from mailout1.w1.samsung.com ([210.118.77.11])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUV20-0000pM-S0
 for linux-arm-kernel@lists.infradead.org; Wed, 05 Dec 2018 11:08:27 +0000
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id
 20181205110741euoutp0141dbc1c6a081c5617d10ffbc5a6d394b~taybN1Lki1403214032euoutp01g
 for <linux-arm-kernel@lists.infradead.org>;
 Wed,  5 Dec 2018 11:07:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com
 20181205110741euoutp0141dbc1c6a081c5617d10ffbc5a6d394b~taybN1Lki1403214032euoutp01g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1544008061;
 bh=VBrP7BJueTxcWjpr5GWuBeTYkYFPmHLtaAhVTLQ7FMU=;
 h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
 b=YNebz0DDLzCxY57atm6AT2cfFRh5hFWz8FUCbDkgp7vAhBCbXC8bFncbNloSPRaAV
 usT/qPZmj9ri4sRBPkoobYE+QWEuIPCfncRHEligljkiBrdX3avV2qkggzM963tyeu
 x5biMzD+VALEIxbRNTIEe3rkQ9qZjsVDYQ1RxB90=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTP id
 20181205110740eucas1p210a192d21b8ee4a3d555bb1a948c20f2~tayaa7Ato1209512095eucas1p2v;
 Wed,  5 Dec 2018 11:07:40 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
 eusmges2new.samsung.com (EUCPMTA) with SMTP id 46.5A.04294.C71B70C5; Wed,  5
 Dec 2018 11:07:40 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20181205110739eucas1p17a395bdc62e3b6ea7fd0bc52825c0a18~tayZp6RvC3198331983eucas1p1k;
 Wed,  5 Dec 2018 11:07:39 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
 eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20181205110739eusmtrp22e6ac4b9f5b5f58f7b0c87e1735d7bdf~tayZaQTur2749527495eusmtrp2I;
 Wed,  5 Dec 2018 11:07:39 +0000 (GMT)
X-AuditID: cbfec7f4-84fff700000010c6-1a-5c07b17cf19f
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
 eusmgms2.samsung.com (EUCPMTA) with SMTP id 51.A2.04128.B71B70C5; Wed,  5
 Dec 2018 11:07:39 +0000 (GMT)
Received: from [106.120.51.20] (unknown [106.120.51.20]) by
 eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20181205110738eusmtip2944626cdd02fb2795af88f7b5264eda4~tayYgy3hi1996919969eusmtip2a;
 Wed,  5 Dec 2018 11:07:38 +0000 (GMT)
Subject: Re: [PATCH v2 2/5] devfreq: add support for suspend/resume of a
 devfreq device
To: Chanwoo Choi <cw00.choi@samsung.com>,
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org
From: Lukasz Luba <l.luba@partner.samsung.com>
Message-ID: <60b64304-2aa9-2831-d94f-610be31b4e8e@partner.samsung.com>
Date: Wed, 5 Dec 2018 12:07:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <5C071740.7090000@samsung.com>
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa1BMYRju23Otsc1pk95xd4ZxG+U25nO/jMsx/Wn8ITIszlSjLfYot5Bb
 1oqWMcqWwkbNllltW7IkVjSVVBRmkxrCoIyU28Ri96zRv+d93+eZ53m++VhClU0PZmPitona
 OHUsT/uRpfd/PJyUVMRETtYdH4nvlIzHRRkWCl8r+krhp71vKZxT+ZDCB00WGj84psFprz4Q
 uL7+KoPrDnQy2Hi6XIGtr55Q+LE9i8Y9xysRzqi/pcBXKlsZfOlpowK37M+ncWvNvb/62kcU
 PlxeyeCUgk8U7mx4QS4IFkpvlFJCYXYhEjKTG0nBkPYZCaab7xSC1XyUFirOFTJCce4+wXWf
 EWzNR0jhhM2MhPyCb4zQYx0erlztN2eTGBuTKGpD5633i642F1BbnLN26PqKyWRkCdUjlgVu
 OmTZZ+qRH6vi8hH0fT5JyUMvgh5HNS0PPQi67S8VeuTrUbTbbiL5kIeg93Kzl9WFoKntFuVm
 BXIRUGN6TbgPA7laBBUVDg+L4A4T4Ppko93uNBcCZeatboGSWwp9h2o8YpIbDbcbyj12Qdwq
 0LUV0DInAKrPdpBu7MtNBGdbuodDcMHg7Mjx4hFwsCTTYwzccxaKM/WEnHsx/L5xjJRxILyv
 sjEyHgq/r+d4u0lQpzPTMk6CI9VlXs5suFvVSLkzE9x4sNhD5fVCsFysVcgP6Q/PugLkCP5w
 qjSdkNdK0KWoZPY4sKU2eI0GQV7hGcaAeGO/YsZ+ZYz9yhj/+55HpBkFiwmSJkqUpsaJ20Mk
 tUZKiIsK2RivsaK/v7bWVdVbhuw/NzgQxyJ+gBJO05EqSp0o7dQ4ELAEP1CZP4eJVCk3qXfu
 ErXx67QJsaLkQENYkg9W7vZpX6PiotTbxM2iuEXU/rsqWN/ByWj5qjIipJw2rbSmdfksa5n2
 1b9ldnfYlLVDNRG7jR3RplF8GE7GdHZn+/z1uV8mEnuu2FO7LxjOPzoZVB/OxyZu/+5ylgS9
 X5LarN87Y2yrwkmNCx9tSP/1ZsL3ql1ZZxfV5foc2rxnbpMU83FY0grbsDEpHYEBR+v4j2Ep
 hvh1TS6elKLVUyYQWkn9B/9UCw6xAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0hTcRTH+e0+DQe3qfnD6MGwKKVr85E/RSOC4lJE0gPSDFt6cdUetjst
 S8gyNbXSQkjnK3ykzKm5+aJSy5ahptOsDKWHaIiPQrKXGdLmDPzve873+zmHA4fGJGbCgz6t
 1vFatVwpJVfhPYsvPmy7VE9FbjelbkJPG7ei+rw6AjXX/yTQ0PcJApVY+giUUlZHopdZKpQ9
 No0hq/UBhXqvzlBIn9sqQqaxtwQafFhIormbFoDyrG0iVGN5T6GKoQERGrlSRaL33c9tfM8r
 AqW2WiiUVj1LoJn+D/gud67pURPBGYuNgCtIHsC5nOxvgCt7PCniTIYMkmsvMlKcufwyt9hJ
 cQ1v0nHuVoMBcFXVvyhuzrQ+TBzBhmg18Tp+o0Ij6EKlx2XIl5UFIdbXP4iV+QWeCPYNkPrs
 DInhlacTeK3PzpOsostQTcQNB1+4vmDGk0GdTyZwoiHjDz81PAaZYBUtYSoAnC2fEzmMNfBO
 WzPl0C7w79tM0hGaBjBtwoLZDRcmHHaXfcbshivTA2CutVtkLzAmFYOTX0qX5xZicKpAb3No
 mmRY2GI4Z6fFzF64cK2bsGuc8YRP+luXVrsxx2DvZC1wZFbDrvxx3K6dGG84/PHuUgZjdsBi
 8yjm0O5weLxkub8BpjQWYDlAol+B61cg+hWIfgVyD+AG4MrHC6pYleDLCnKVEK+OZaM1KhOw
 PUxT53xDC8j8ergDMDSQOothLhkpIeQJQqKqA0Aak7qKq0KoSIk4Rp54kddqorTxSl7oAAG2
 425jHm7RGtv7qXVRsgBZIAqSBfoF+u1AUnexdXtihISJlev4szwfx2v/cyLaySMZEEVbfhQf
 qM7vKO33c+4c7S9US6j52oR0b87Qrq96F3ZkrSl7356BjMSKiGdpjbXr8mn5Zs/wyrLXKLry
 xnmFS+/BZyXrs5/EJPDnjMpk/NDwn7w2Mss79L7HaNTu9qSjU5oa1yRgXPjb5zW455SFDf09
 rxBh5v27ZkZAl+GMUooLCrnMC9MK8n/N6y19RgMAAA==
X-CMS-MailID: 20181205110739eucas1p17a395bdc62e3b6ea7fd0bc52825c0a18
X-Msg-Generator: CA
X-RootMTR: 20181203143131eucas1p217f22ac6d19682a54a57658a06980914
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181203143131eucas1p217f22ac6d19682a54a57658a06980914
References: <1543847475-7600-1-git-send-email-l.luba@partner.samsung.com>
 <CGME20181203143131eucas1p217f22ac6d19682a54a57658a06980914@eucas1p2.samsung.com>
 <1543847475-7600-3-git-send-email-l.luba@partner.samsung.com>
 <5C06124B.5030409@samsung.com> <5C06140E.7010603@samsung.com>
 <5C061A57.7040002@samsung.com>
 <7662d626-5c3e-aec5-05e4-c6cd2e56ef49@partner.samsung.com>
 <5C071740.7090000@samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_030753_436095_11139825 
X-CRM114-Status: GOOD (  24.15  )
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
Cc: mark.rutland@arm.com, len.brown@intel.com, tony.luck@intel.com,
 keescook@chromium.org, b.zolnierkie@samsung.com, gregkh@linuxfoundation.org,
 anton@enomsg.org, rjw@rjwysocki.net, robh+dt@kernel.org,
 tjakobi@math.uni-bielefeld.de, kyungmin.park@samsung.com,
 myungjoo.ham@samsung.com, kgene@kernel.org, pavel@ucw.cz, ccross@android.com,
 krzk@kernel.org, m.szyprowski@samsung.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGkgQ2hhbndvbywKCk9uIDEyLzUvMTggMTowOSBBTSwgQ2hhbndvbyBDaG9pIHdyb3RlOgo+IEhp
IEx1a2FzeiwKPiAKPiBPbiAyMDE464WEIDEy7JuUIDA07J28IDE4OjUzLCBMdWthc3ogTHViYSB3
cm90ZToKPj4gSGkgQ2hhbndvbywKPj4KPj4gT24gMTIvNC8xOCA3OjEwIEFNLCBDaGFud29vIENo
b2kgd3JvdGU6Cj4+PiBIaSBMdWthc3osCj4+Pgo+Pj4gSSBhZGQgdGhlIGNvbW1lbnQgYWJvdXQg
J3N1c3BlbmRfY291bnQnLgo+Pj4KPj4+IE9uIDIwMTjrhYQgMTLsm5QgMDTsnbwgMTQ6NDMsIENo
YW53b28gQ2hvaSB3cm90ZToKPj4+PiBIaSwKPj4+Pgo+Pj4+IE9uIDIwMTjrhYQgMTLsm5QgMDTs
nbwgMTQ6MzYsIENoYW53b28gQ2hvaSB3cm90ZToKPj4+Pj4gSGkgTHVrYXN6LAo+Pj4+Pgo+Pj4+
PiBMb29rcyBnb29kIHRvIG1lLiBCdXQsIEkgYWRkIHRoZSBzb21lIGNvbW1lbnRzLgo+Pj4+PiBJ
ZiB5b3Ugd2lsbCBmaXggaXQsIGZlZWwgZnJlZSB0byBhZGQgbXkgdGFnOgo+Pj4+PiBSZXZpZXdl
ZC1ieTogQ2hhbndvbyBjaG9pIDxjdzAwLmNob2lAc2Ftc3VuZy5jb20+Cj4+Pj4KPj4+PiBTb3Jy
eS4gRml4IHR5cG8gJ2Nob2knIHRvICdDaG9pJyBhcyBmb2xsb3dpbmcuCj4+Pj4gUmV2aWV3ZWQt
Ynk6IENoYW53b28gQ2hvaSA8Y3cwMC5jaG9pQHNhbXN1bmcuY29tPgo+Pj4+Cj4+Pj4+Cj4+Pj4+
IE9uIDIwMTjrhYQgMTLsm5QgMDPsnbwgMjM6MzEsIEx1a2FzeiBMdWJhIHdyb3RlOgo+Pj4+Pj4g
VGhlIHBhdGNoIHByZXBhcmVzIGRldmZyZXEgZGV2aWNlIGZvciBoYW5kbGluZyBzdXNwZW5kL3Jl
c3VtZQo+Pj4+Pj4gZnVuY3Rpb25hbGl0eS4gIFRoZSBuZXcgZmllbGRzIHdpbGwgc3RvcmUgbmVl
ZGVkIGluZm9ybWF0aW9uIGR1cmluZyB0aGlzCj4+Pj4+Cj4+Pj4+IG5pdHBpY2suIFJlbW92ZSB1
bm5lZWRlZCBzcGFjZS4gVGhlcmUgYXJlIHR3byBzcGFjZXMgYmV0d2VlbiAnLicgYW5kICdUaGUg
bmV3Jy4KPj4+Pj4KPj4+Pj4+IHByb2Nlc3MuICBEZXZmcmVxIGZyYW1ld29yayBoYW5kbGVzIG9w
cC1zdXNwZW5kIERUIGVudHJ5IGFuZCB0aGVyZSBpcyBubwo+Pj4+Pgo+Pj4+PiBkaXR0by4KPj4+
Pj4KPj4+Pj4+IG5lZWQgb2YgbW9keWZpY2F0aW9ucyBpbiB0aGUgZHJpdmVycyBjb2RlLiAgSXQg
dXNlcyBhdG9taWMgdmFyaWFibGVzIHRvCj4+Pj4+Cj4+Pj4+IGRpdHRvLgo+Pj4+Pgo+Pj4+Pj4g
bWFrZSBzdXJlIG5vIHJhY2UgY29uZGl0aW9uIGFmZmVjdHMgdGhlIHByb2Nlc3MuCj4+Pj4+Pgo+
Pj4+Pj4gVGhlIHBhdGNoIGlzIGJhc2VkIG9uIGVhcmxpZXIgd29yayBieSBUb2JpYXMgSmFrb2Jp
Lgo+Pj4+Pgo+Pj4+PiBQbGVhc2UgcmVtb3ZlIGl0IGZyb20gZWFjaCBwYXRjaCBkZXNjcmlwdGlv
bi4KPj4+Pj4KPj4+Pj4+Cj4+Pj4+PiBTdWdnZXN0ZWQtYnk6IFRvYmlhcyBKYWtvYmkgPHRqYWtv
YmlAbWF0aC51bmktYmllbGVmZWxkLmRlPgo+Pj4+Pj4gU3VnZ2VzdGVkLWJ5OiBDaGFud29vIENo
b2kgPGN3MDAuY2hvaUBzYW1zdW5nLmNvbT4KPj4+Pj4+IFNpZ25lZC1vZmYtYnk6IEx1a2FzeiBM
dWJhIDxsLmx1YmFAcGFydG5lci5zYW1zdW5nLmNvbT4KPj4+Pj4+IC0tLQo+Pj4+Pj4gICAgZHJp
dmVycy9kZXZmcmVxL2RldmZyZXEuYyB8IDUxICsrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKy0tLS0tLS0tCj4+Pj4+PiAgICBpbmNsdWRlL2xpbnV4L2RldmZyZXEuaCAgIHwg
IDcgKysrKysrKwo+Pj4+Pj4gICAgMiBmaWxlcyBjaGFuZ2VkLCA1MCBpbnNlcnRpb25zKCspLCA4
IGRlbGV0aW9ucygtKQo+Pj4+Pj4KPj4+Pj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2RldmZyZXEv
ZGV2ZnJlcS5jIGIvZHJpdmVycy9kZXZmcmVxL2RldmZyZXEuYwo+Pj4+Pj4gaW5kZXggYTlmZDYx
Yi4uMzZiZWQyNCAxMDA2NDQKPj4+Pj4+IC0tLSBhL2RyaXZlcnMvZGV2ZnJlcS9kZXZmcmVxLmMK
Pj4+Pj4+ICsrKyBiL2RyaXZlcnMvZGV2ZnJlcS9kZXZmcmVxLmMKPj4+Pj4+IEBAIC0zMTYsNiAr
MzE2LDEwIEBAIHN0YXRpYyBpbnQgZGV2ZnJlcV9zZXRfdGFyZ2V0KHN0cnVjdCBkZXZmcmVxICpk
ZXZmcmVxLCB1bnNpZ25lZCBsb25nIG5ld19mcmVxLAo+Pj4+Pj4gICAgCQkJIkNvdWxkbid0IHVw
ZGF0ZSBmcmVxdWVuY3kgdHJhbnNpdGlvbiBpbmZvcm1hdGlvbi5cbiIpOwo+Pj4+Pj4gICAgCj4+
Pj4+PiAgICAJZGV2ZnJlcS0+cHJldmlvdXNfZnJlcSA9IG5ld19mcmVxOwo+Pj4+Pj4gKwo+Pj4+
Pj4gKwlpZiAoZGV2ZnJlcS0+c3VzcGVuZF9mcmVxKQo+Pj4+Pj4gKwkJZGV2ZnJlcS0+cmVzdW1l
X2ZyZXEgPSBjdXJfZnJlcTsKPj4+Pj4+ICsKPj4+Pj4+ICAgIAlyZXR1cm4gZXJyOwo+Pj4+Pj4g
ICAgfQo+Pj4+Pj4gICAgCj4+Pj4+PiBAQCAtNjY3LDYgKzY3MSw5IEBAIHN0cnVjdCBkZXZmcmVx
ICpkZXZmcmVxX2FkZF9kZXZpY2Uoc3RydWN0IGRldmljZSAqZGV2LAo+Pj4+Pj4gICAgCX0KPj4+
Pj4+ICAgIAlkZXZmcmVxLT5tYXhfZnJlcSA9IGRldmZyZXEtPnNjYWxpbmdfbWF4X2ZyZXE7Cj4+
Pj4+PiAgICAKPj4+Pj4+ICsJZGV2ZnJlcS0+c3VzcGVuZF9mcmVxID0gZGV2X3BtX29wcF9nZXRf
c3VzcGVuZF9vcHBfZnJlcShkZXYpOwo+Pj4+Pj4gKwlhdG9taWNfc2V0KCZkZXZmcmVxLT5zdXNw
ZW5kX2NvdW50LCAwKTsKPj4+Pj4+ICsKPj4+Pj4+ICAgIAlkZXZfc2V0X25hbWUoJmRldmZyZXEt
PmRldiwgImRldmZyZXElZCIsCj4+Pj4+PiAgICAJCQkJYXRvbWljX2luY19yZXR1cm4oJmRldmZy
ZXFfbm8pKTsKPj4+Pj4+ICAgIAllcnIgPSBkZXZpY2VfcmVnaXN0ZXIoJmRldmZyZXEtPmRldik7
Cj4+Pj4+PiBAQCAtODY3LDE0ICs4NzQsMjggQEAgRVhQT1JUX1NZTUJPTChkZXZtX2RldmZyZXFf
cmVtb3ZlX2RldmljZSk7Cj4+Pj4+PiAgICAgKi8KPj4+Pj4+ICAgIGludCBkZXZmcmVxX3N1c3Bl
bmRfZGV2aWNlKHN0cnVjdCBkZXZmcmVxICpkZXZmcmVxKQo+Pj4+Pj4gICAgewo+Pj4+Pj4gKwlp
bnQgcmV0Owo+Pj4+Pj4gKwo+Pj4+Pj4gICAgCWlmICghZGV2ZnJlcSkKPj4+Pj4+ICAgIAkJcmV0
dXJuIC1FSU5WQUw7Cj4+Pj4+PiAgICAKPj4+Pj4+IC0JaWYgKCFkZXZmcmVxLT5nb3Zlcm5vcikK
Pj4+Pj4+IC0JCXJldHVybiAwOwo+Pj4+Pj4gKwlpZiAoZGV2ZnJlcS0+Z292ZXJub3IpIHsKPj4+
Pj4+ICsJCXJldCA9IGRldmZyZXEtPmdvdmVybm9yLT5ldmVudF9oYW5kbGVyKGRldmZyZXEsCj4+
Pj4+PiArCQkJCQlERVZGUkVRX0dPVl9TVVNQRU5ELCBOVUxMKTsKPj4+Pj4+ICsJCWlmIChyZXQp
Cj4+Pj4+PiArCQkJcmV0dXJuIHJldDsKPj4+Pj4+ICsJfQo+Pj4+Pj4gKwo+Pj4+Pj4gKwlpZiAo
ZGV2ZnJlcS0+c3VzcGVuZF9mcmVxKSB7Cj4+Pj4+PiArCQlpZiAoYXRvbWljX2luY19yZXR1cm4o
JmRldmZyZXEtPnN1c3BlbmRfY291bnQpID4gMSkKPj4+Pj4+ICsJCQlyZXR1cm4gMDsKPj4+Pj4+
ICsKPj4+Pj4+ICsJCXJldCA9IGRldmZyZXFfc2V0X3RhcmdldChkZXZmcmVxLCBkZXZmcmVxLT5z
dXNwZW5kX2ZyZXEsIDApOwo+Pj4+Pj4gKwkJaWYgKHJldCkKPj4+Pj4+ICsJCQlyZXR1cm4gcmV0
Owo+Pj4+Pj4gKwl9Cj4+Pgo+Pj4gSW4gdGhpcyBwYXRjaCwgaWYgc29tZSB1c2VycyBjYWxsICdk
ZXZmcmVxX3N1c3BlbmRfZGV2aWNlJyB0d2ljZSwKPj4+ICdkZXZmcmVxLT5nb3Zlcm5vci0+ZXZl
bnRfaGFuZGxlcihkZXZmcmVxLCBERVZGUkVRX0dPVl9TVVNQRU5ELCBOVUxMKScKPj4+IGlzIGNh
bGxlZCB0d2ljZSBidXQgZGV2ZnJlcV9zZXRfdGFyZ2V0KCkgaXMgY2FsbGVkIG9ubHkgb25lLgo+
Pj4gSSBrbmV3IHRoYXQgaXQgaXMgbm8gcHJvYmxlbSBmb3Igb3BlcmF0aW9uLgo+Pj4KPj4+IEJ1
dCwKPj4+IEkgdGhpbmsgdGhhdCB5b3UgYmV0dGVyIHRvIHVzZSAnc3VzcGVuZF9jb3VudCcgYXMg
dGhlIHJlZmVyZW5jZSBjb3VudAo+Pj4gb2YgZGV2ZnJlcV9zdXNwZW5kL3Jlc3VtZV9kZXZpY2Uo
KS4gQnV0LCBpZiB5b3UgdXNlICdzdXNwZW5kX2NvdW50Jwo+Pj4gaW4gb3JkZXIgdG8gY2hlY2sg
d2hldGhlciB0aGlzIGRldmZyZXEgaXMgc3VzcGVuZGVkIG9yIG5vdCwKPj4+IHdlIGNhbiByZWR1
Y2UgdGhlIHVubmVlZGVkIHJlZHVuZGFudCBjYWxsIHdoZW4gY2FsbGluZyBpdCB0d2ljZS4KPj4+
Cj4+PiBjbG9jayBhbmQgcmVndWxhdG9yIHVzZWQgdGhlICdyZWZlcmVuY2UgY291bnQnIG1ldGhv
ZCBpbiBvcmRlciB0bwo+Pj4gcmVtb3ZlIHRoZSByZWR1bmRhbnQgY2FsbC4KPj4KPj4gSSB0aGlu
ayBJJ3ZlIGdvdCB0aGUgcG9pbnQuIEkgd2lsbCBtb3ZlIHRoZSBhdG9taWMgY2hlY2sganVzdAo+
PiBhZnRlciB0aGUgIWRldmZyZXEgY2hlY2suIFNvbWV0aGluZyBsaWtlIHRoZSBjb2RlIGJlbGxv
dyBpcyB3aGF0IHlvdQo+PiB3b3VsZCBsaWtlIHRvIHNlZT8KPj4gLS0tODwtLS0tLQo+PiBpZiAo
IWRldmZyZXEpCj4+IAlyZXR1cm4gLUVJTlZBTDsKPj4gaWYgKGF0b21pY19pbmNfcmV0dXJuKCZk
ZXZmcmVxLT5zdXNwZW5kX2NvdW50KSA+IDEpCj4+IAlyZXR1cm4wOwo+IAo+IExvb2tzIGdvb2Qg
dG8gbWUuIEkgYWdyZWUuCk9LCj4gCj4+Cj4+IC0tLS0+OC0tLS0tLS0KPj4+Cj4+Pgo+Pj4+Pj4g
ICAgCj4+Pj4+PiAtCXJldHVybiBkZXZmcmVxLT5nb3Zlcm5vci0+ZXZlbnRfaGFuZGxlcihkZXZm
cmVxLAo+Pj4+Pj4gLQkJCQlERVZGUkVRX0dPVl9TVVNQRU5ELCBOVUxMKTsKPj4+Pj4+ICsJcmV0
dXJuIDA7Cj4+Pj4+PiAgICB9Cj4+Pj4+PiAgICBFWFBPUlRfU1lNQk9MKGRldmZyZXFfc3VzcGVu
ZF9kZXZpY2UpOwo+Pj4+Pj4gICAgCj4+Pj4+PiBAQCAtODg4LDE0ICs5MDksMjggQEAgRVhQT1JU
X1NZTUJPTChkZXZmcmVxX3N1c3BlbmRfZGV2aWNlKTsKPj4+Pj4+ICAgICAqLwo+Pj4+Pj4gICAg
aW50IGRldmZyZXFfcmVzdW1lX2RldmljZShzdHJ1Y3QgZGV2ZnJlcSAqZGV2ZnJlcSkKPj4+Pj4+
ICAgIHsKPj4+Pj4+ICsJaW50IHJldDsKPj4+Pj4+ICsKPj4+Pj4+ICAgIAlpZiAoIWRldmZyZXEp
Cj4+Pj4+PiAgICAJCXJldHVybiAtRUlOVkFMOwo+Pj4+Pj4gICAgCj4+Pj4+PiAtCWlmICghZGV2
ZnJlcS0+Z292ZXJub3IpCj4+Pj4+PiAtCQlyZXR1cm4gMDsKPj4+Pj4+ICsJaWYgKGRldmZyZXEt
PnJlc3VtZV9mcmVxKSB7Cj4+Pj4+PiArCQlpZiAoYXRvbWljX2RlY19yZXR1cm4oJmRldmZyZXEt
PnN1c3BlbmRfY291bnQpID49IDEpCj4+Pj4+PiArCQkJcmV0dXJuIDA7Cj4+Pgo+Pj4gZGl0dG8u
Cj4+IFNhbWUgYXBwcm9hY2ggaGVyZToKPj4gLS0tODwtLS0tLQo+PiBpZiAoIWRldmZyZXEpCj4+
IAlyZXR1cm4gLUVJTlZBTDsKPj4gaWYgKGF0b21pY19kZWNfcmV0dXJuKCZkZXZmcmVxLT5zdXNw
ZW5kX2NvdW50KSA+PSAxKQo+PiAJcmV0dXJuIDA7Cj4gCj4gTG9va3MgZ29vZCB0byBtZS4KVGhh
bmsgeW91LiBUaGUgcGF0Y2ggc2V0IHYzIGlzIGdvaW5nIHRvIGJlIHNlbnQuCgpSZWdhcmRzLApM
dWthc3oKCj4gCj4+IC0tLS0+OC0tLS0tLS0KPj4KPj4gUmVnYXJkcywKPj4gTHVrYXN6Cj4+Pgo+
Pj4+Pj4gICAgCj4+Pj4+PiAtCXJldHVybiBkZXZmcmVxLT5nb3Zlcm5vci0+ZXZlbnRfaGFuZGxl
cihkZXZmcmVxLAo+Pj4+Pj4gLQkJCQlERVZGUkVRX0dPVl9SRVNVTUUsIE5VTEwpOwo+Pj4+Pj4g
KwkJcmV0ID0gZGV2ZnJlcV9zZXRfdGFyZ2V0KGRldmZyZXEsIGRldmZyZXEtPnJlc3VtZV9mcmVx
LCAwKTsKPj4+Pj4+ICsJCWlmIChyZXQpCj4+Pj4+PiArCQkJcmV0dXJuIHJldDsKPj4+Pj4+ICsJ
fQo+Pj4+Pj4gKwo+Pj4+Pj4gKwlpZiAoZGV2ZnJlcS0+Z292ZXJub3IpIHsKPj4+Pj4+ICsJCXJl
dCA9IGRldmZyZXEtPmdvdmVybm9yLT5ldmVudF9oYW5kbGVyKGRldmZyZXEsCj4+Pj4+PiArCQkJ
CQlERVZGUkVRX0dPVl9SRVNVTUUsIE5VTEwpOwo+Pj4+Pj4gKwkJaWYgKHJldCkKPj4+Pj4+ICsJ
CQlyZXR1cm4gcmV0Owo+Pj4+Pj4gKwl9Cj4+Pj4+PiArCj4+Pj4+PiArCXJldHVybiAwOwo+Pj4+
Pj4gICAgfQo+Pj4+Pj4gICAgRVhQT1JUX1NZTUJPTChkZXZmcmVxX3Jlc3VtZV9kZXZpY2UpOwo+
Pj4+Pj4gICAgCj4+Pj4+PiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9kZXZmcmVxLmggYi9p
bmNsdWRlL2xpbnV4L2RldmZyZXEuaAo+Pj4+Pj4gaW5kZXggZTQ5NjNiMC4uZDk4NTE5OSAxMDA2
NDQKPj4+Pj4+IC0tLSBhL2luY2x1ZGUvbGludXgvZGV2ZnJlcS5oCj4+Pj4+PiArKysgYi9pbmNs
dWRlL2xpbnV4L2RldmZyZXEuaAo+Pj4+Pj4gQEAgLTEzMSw2ICsxMzEsOSBAQCBzdHJ1Y3QgZGV2
ZnJlcV9kZXZfcHJvZmlsZSB7Cj4+Pj4+PiAgICAgKiBAc2NhbGluZ19taW5fZnJlcToJTGltaXQg
bWluaW11bSBmcmVxdWVuY3kgcmVxdWVzdGVkIGJ5IE9QUCBpbnRlcmZhY2UKPj4+Pj4+ICAgICAq
IEBzY2FsaW5nX21heF9mcmVxOglMaW1pdCBtYXhpbXVtIGZyZXF1ZW5jeSByZXF1ZXN0ZWQgYnkg
T1BQIGludGVyZmFjZQo+Pj4+Pj4gICAgICogQHN0b3BfcG9sbGluZzoJIGRldmZyZXEgcG9sbGlu
ZyBzdGF0dXMgb2YgYSBkZXZpY2UuCj4+Pj4+PiArICogQHN1c3BlbmRfZnJlcToJIGZyZXF1ZW5j
eSBvZiBhIGRldmljZSBzZXQgZHVyaW5nIHN1c3BlbmQgcGhhc2UuCj4+Pj4+PiArICogQHJlc3Vt
ZV9mcmVxOgkgZnJlcXVlbmN5IG9mIGEgZGV2aWNlIHNldCBpbiByZXN1bWUgcGhhc2UuCj4+Pj4+
PiArICogQHN1c3BlbmRfY291bnQ6CSBzdXNwZW5kIHJlcXVlc3RzIGNvdW50ZXIgZm9yIGEgZGV2
aWNlLgo+Pj4+Pj4gICAgICogQHRvdGFsX3RyYW5zOglOdW1iZXIgb2YgZGV2ZnJlcSB0cmFuc2l0
aW9ucwo+Pj4+Pj4gICAgICogQHRyYW5zX3RhYmxlOglTdGF0aXN0aWNzIG9mIGRldmZyZXEgdHJh
bnNpdGlvbnMKPj4+Pj4+ICAgICAqIEB0aW1lX2luX3N0YXRlOglTdGF0aXN0aWNzIG9mIGRldmZy
ZXEgc3RhdGVzCj4+Pj4+PiBAQCAtMTY3LDYgKzE3MCwxMCBAQCBzdHJ1Y3QgZGV2ZnJlcSB7Cj4+
Pj4+PiAgICAJdW5zaWduZWQgbG9uZyBzY2FsaW5nX21heF9mcmVxOwo+Pj4+Pj4gICAgCWJvb2wg
c3RvcF9wb2xsaW5nOwo+Pj4+Pj4gICAgCj4+Pj4+PiArCXVuc2lnbmVkIGxvbmcgc3VzcGVuZF9m
cmVxOwo+Pj4+Pj4gKwl1bnNpZ25lZCBsb25nIHJlc3VtZV9mcmVxOwo+Pj4+Pj4gKwlhdG9taWNf
dCBzdXNwZW5kX2NvdW50Owo+Pj4+Pj4gKwo+Pj4+Pj4gICAgCS8qIGluZm9ybWF0aW9uIGZvciBk
ZXZpY2UgZnJlcXVlbmN5IHRyYW5zaXRpb24gKi8KPj4+Pj4+ICAgIAl1bnNpZ25lZCBpbnQgdG90
YWxfdHJhbnM7Cj4+Pj4+PiAgICAJdW5zaWduZWQgaW50ICp0cmFuc190YWJsZTsKPj4+Pj4+Cj4+
Pj4+Cj4+Pj4+Cj4+Pj4KPj4+Pgo+Pj4KPj4+Cj4+Cj4+Cj4gCj4gCgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcg
bGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmlu
ZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
