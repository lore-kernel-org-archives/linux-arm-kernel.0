Return-Path: <SRS0=Fp1N=PV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30E2EC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 22:40:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6E0420663
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 22:39:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="fKNgSFW/";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="g7J5s6VE";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="R8DPXSer"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6E0420663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aj.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:In-Reply-To:References:Subject:
	MIME-Version:To:From:Message-Id:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=WYad/cVFQ1vqA4qfm/eD8ogQ/TJmNkidz/3lGy2hEy8=; b=fKNgSFW/q3dl1/
	Cmky0RuNRB6QYTaVqBVQXsuNF1vRJyoRA8siSKpv8sG0B2Ma2uo2e0WuEbdFme4nSsWzqS1Bqy/Fp
	Ddc6dt3pGmd075qDJ/2IpkhrvKE4JyBU9k2m/BLst1jsGQWhYtgtgb3imDrpQ76MN9s62DCTSR5X+
	AFBiPYLJgOJV9Fs1jUskf5e3yIFyXzQKrofecM8rHlcSFGO4tyThoYwE0WCAFKUBsJSx2EdCe04Ml
	CvIQu5YVw6EurWB8KsqORRljcwQEjiiwgeHgL46nY9o2glKQ9YjoTgxrRKbvoTL1n3p7zzFPpqdAn
	XemP0ir6eZ50SJcZ+QBA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gioQA-0002Vf-5U; Sun, 13 Jan 2019 22:39:58 +0000
Received: from out2-smtp.messagingengine.com ([66.111.4.26])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gioQ6-0002UQ-B9
 for linux-arm-kernel@lists.infradead.org; Sun, 13 Jan 2019 22:39:56 +0000
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailout.nyi.internal (Postfix) with ESMTP id BD6D628A59;
 Sun, 13 Jan 2019 17:39:43 -0500 (EST)
Received: from web3 ([10.202.2.213])
 by compute4.internal (MEProxy); Sun, 13 Jan 2019 17:39:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=
 message-id:from:to:cc:mime-version:content-transfer-encoding
 :content-type:subject:references:in-reply-to:date; s=fm1; bh=1Aq
 xfHCXzG8QusTyedU+zAqb2TmJJlUJlTMkSL/MNVQ=; b=g7J5s6VEh05GGxCNYuD
 Z/dkx7QeAA+w21+eMjfNWe5zoU//Zy4FYn8tz75B/BRqQ/gXACMvOcZrbHzV3mOF
 6tn952bmvXzoBK6Rxjz8Kas+tJqS8huey62AT8pHZXK+9ypvYYmh3voOFvyaLt75
 rah3TluI/bImsQcSdDtCooVehGWyPr1K14cwk1waPBF90vep8CM2gK6h3hdFKXj3
 4yyl8v1bnj/QMZvzWeDKlf64y7PKesHmQy0npR97ZFw5x/Aqo3lvZgoeaem9nPpK
 Nz1NYDwxeNMn5Owt6sjfBnHL5nmgd2hrD5W/PVzDDxLK5pfYP6UuADdVls0XG5DH
 Vyg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:content-type
 :date:from:in-reply-to:message-id:mime-version:references
 :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm1; bh=1AqxfHCXzG8QusTyedU+zAqb2TmJJlUJlTMkSL/MN
 VQ=; b=R8DPXSerWmcZ9of+Z8tTvwkp6j6v8B3cNO2rzSTC/ZRMgSmV0t9BRkbxB
 XV9aHurUENiuU6yXl1r7Q/L+qF7CcLaP1qm0PKMMLAqz7KcRCZeh5FlQ9iz2IYUK
 3/JVP+ZHzxr/ZoXtaM6+ZuTZetzABP+2W5qPoldcXxiYNIZCXbOzYI5a6slgvHR+
 aUlcK0nmrZgkGtiL6JWgMtTmY5XMoP5akxouFhxSR9bKOYl8UZaH3ebEigUSz76/
 9PKd4guqPm72DX4K5VzHkG2iXWhsRW7Ul1Dw66af1o+zVtcxuaO2Hcu2ookCvZWN
 MtqkCmkgBBBBcNFqdk6oswrkIRDEg==
X-ME-Sender: <xms:LL47XB5qSbzVNlPh645KTvUSim5yxr_KCHf8BySmmGi2YVLFYbsmOA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedtledrgedtgddtudcutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfhuthenuceurghilhhouhhtmecufedt
 tdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkffhvfgggfgtof
 fufhgjffesthhqredtredtjeenucfhrhhomheptehnughrvgifucflvghffhgvrhihuceo
 rghnughrvgifsegrjhdrihgurdgruheqnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrnh
 gurhgvfiesrghjrdhiugdrrghunecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:LL47XPortDmDTGHjPTZEqpAd9RFDJhFRLKoZE-NRpd7mCCmpLfd_RA>
 <xmx:LL47XBWFdvWk_21yCu3iW3nTjpqLaZIDWLgPDE6XJWIqNZHMkwez_Q>
 <xmx:LL47XCAeAiquHg_VgAvGImOETlspkqgi-_Jlzs7OYTpGvTjU0ayQkw>
 <xmx:L747XBs5p78guqnEe3y0tv9RObT5qNSSx3zZLpfiHvunTFoXKAZaIw>
Received: by mailuser.nyi.internal (Postfix, from userid 99)
 id C46969E564; Sun, 13 Jan 2019 17:39:40 -0500 (EST)
Message-Id: <1547419180.2315773.1633559160.3F7D29CF@webmail.messagingengine.com>
From: Andrew Jeffery <andrew@aj.id.au>
To: Vijay Khemka <vijaykhemka@fb.com>, Rob Herring <robh+dt@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Joel Stanley <joel@jms.id.au>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
MIME-Version: 1.0
X-Mailer: MessagingEngine.com Webmail Interface - ajax-36e4bfd3
Subject: Re: [Potential Spoof] Re: [Potential Spoof] Re: [PATCH v2 4/4] ARM:
 dts: aspeed: Add lpc ctrl for Facebook
References: <5972B57A-23D5-43F4-9476-229379B96C7C@fb.com>
In-Reply-To: <5972B57A-23D5-43F4-9476-229379B96C7C@fb.com>
Date: Mon, 14 Jan 2019 09:09:40 +1030
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190113_143954_815367_D42505CA 
X-CRM114-Status: GOOD (  17.84  )
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
Cc: "openbmc @ lists . ozlabs . org" <openbmc@lists.ozlabs.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGkgVmlqYXksCgpTb3JyeSBmb3IgcHJvdmlkaW5nIGFuIG9waW5pb24gc28gbGF0ZSwgaG93ZXZl
cjoKCk9uIFNhdCwgMTIgSmFuIDIwMTksIGF0IDExOjAzLCBWaWpheSBLaGVta2Egd3JvdGU6Cj4g
Sm9lbCwKPiBQbGVhc2UgbWVyZ2UgdGhlc2UgcGF0Y2hlcyBhcyBpdCBpcyByZXF1aXJlZCBieSBm
YWNlYm9vayBwbGF0Zm9ybS4KPiAKPiBSZWdhcmRzCj4gLVZpamF5Cj4gCj4g77u/T24gMS83LzE5
LCAxMToyNSBBTSwgIkxpbnV4LWFzcGVlZCBvbiBiZWhhbGYgb2YgVmlqYXkgS2hlbWthIiA8bGlu
dXgtCj4gYXNwZWVkLWJvdW5jZXMrdmlqYXlraGVta2E9ZmIuY29tQGxpc3RzLm96bGFicy5vcmcg
b24gYmVoYWxmIG9mIAo+IHZpamF5a2hlbWthQGZiLmNvbT4gd3JvdGU6Cj4gCj4gICAgIFBsZWFz
ZSBtZXJnZSB0aGVzZSBwYXRjaGVzIGluIHVwc3RyZWFtIGtlcm5lbC4KPiAgICAgCj4gICAgIFJl
Z2FyZHMKPiAgICAgLVZpamF5Cj4gICAgIAo+ICAgICBPbiAxMi8yMC8xOCwgMTA6MDYgQU0sICJM
aW51eC1hc3BlZWQgb24gYmVoYWxmIG9mIFZpamF5IEtoZW1rYSIgCj4gPGxpbnV4LWFzcGVlZC1i
b3VuY2VzK3ZpamF5a2hlbWthPWZiLmNvbUBsaXN0cy5vemxhYnMub3JnIG9uIGJlaGFsZiBvZiAK
PiB2aWpheWtoZW1rYUBmYi5jb20+IHdyb3RlOgo+ICAgICAKPiAgICAgICAgIEpvZWwsIENhbiB5
b3UgcGxlYXNlIHRha2UgY2FyZSBvZiB0aGVzZSBwYXRjaGVzIG1lcmdlLgo+ICAgICAgICAgCj4g
ICAgICAgICBPbiAxMi8xNy8xOCwgMTI6MDQgUE0sICJWaWpheSBLaGVta2EiIDx2aWpheWtoZW1r
YUBmYi5jb20+IHdyb3RlOgo+ICAgICAgICAgCj4gICAgICAgICAgICAgQWRkZWQgbHBjIGN0cmwg
ZGV2aWNlIHRvIGVuYWJsZSBMUEMgY2xvY2sgaW4gRmFjZWJvb2sKPiAgICAgICAgICAgICBUaW9n
YXBhc3MgZGV2aWNlIHRyZWUuCj4gICAgICAgICAgICAgCj4gICAgICAgICAgICAgU2lnbmVkLW9m
Zi1ieTogVmlqYXkgS2hlbWthIDx2aWpheWtoZW1rYUBmYi5jb20+Cj4gICAgICAgICAgICAgLS0t
Cj4gICAgICAgICAgICAgIC4uLi9ib290L2R0cy9hc3BlZWQtYm1jLWZhY2Vib29rLXRpb2dhcGFz
cy5kdHMgIHwgMTcgKysrKysrCj4gKysrKysrKysrKysKPiAgICAgICAgICAgICAgMSBmaWxlIGNo
YW5nZWQsIDE3IGluc2VydGlvbnMoKykKPiAgICAgICAgICAgICAKPiAgICAgICAgICAgICBkaWZm
IC0tZ2l0IGEvYXJjaC9hcm0vYm9vdC9kdHMvYXNwZWVkLWJtYy1mYWNlYm9vay0KPiB0aW9nYXBh
c3MuZHRzIGIvYXJjaC9hcm0vYm9vdC9kdHMvYXNwZWVkLWJtYy1mYWNlYm9vay10aW9nYXBhc3Mu
ZHRzCj4gICAgICAgICAgICAgaW5kZXggNzNlNThhODIxNjEzLi5lZjc4NzViNTQ1NjIgMTAwNjQ0
Cj4gICAgICAgICAgICAgLS0tIGEvYXJjaC9hcm0vYm9vdC9kdHMvYXNwZWVkLWJtYy1mYWNlYm9v
ay10aW9nYXBhc3MuZHRzCj4gICAgICAgICAgICAgKysrIGIvYXJjaC9hcm0vYm9vdC9kdHMvYXNw
ZWVkLWJtYy1mYWNlYm9vay10aW9nYXBhc3MuZHRzCj4gICAgICAgICAgICAgQEAgLTIyLDYgKzIy
LDE3IEBACj4gICAgICAgICAgICAgIAkJcmVnID0gPDB4ODAwMDAwMDAgMHgyMDAwMDAwMD47Cj4g
ICAgICAgICAgICAgIAl9Owo+ICAgICAgICAgICAgICAKPiAgICAgICAgICAgICArCXJlc2VydmVk
LW1lbW9yeSB7Cj4gICAgICAgICAgICAgKwkJI2FkZHJlc3MtY2VsbHMgPSA8MT47Cj4gICAgICAg
ICAgICAgKwkJI3NpemUtY2VsbHMgPSA8MT47Cj4gICAgICAgICAgICAgKwkJcmFuZ2VzOwo+ICAg
ICAgICAgICAgICsKPiAgICAgICAgICAgICArCQlmbGFzaF9tZW1vcnk6IHJlZ2lvbkA5ODAwMDAw
MCB7Cj4gICAgICAgICAgICAgKwkJCW5vLW1hcDsKPiAgICAgICAgICAgICArCQkJcmVnID0gPDB4
OTgwMDAwMDAgMHgwMDAwMTAwMD47IC8qIDRLICovCj4gICAgICAgICAgICAgKwkJfTsKPiAgICAg
ICAgICAgICArCX07Cj4gICAgICAgICAgICAgKwo+ICAgICAgICAgICAgICAJaWlvLWh3bW9uIHsK
PiAgICAgICAgICAgICAgCQljb21wYXRpYmxlID0gImlpby1od21vbiI7Cj4gICAgICAgICAgICAg
IAkJaW8tY2hhbm5lbHMgPSA8JmFkYyAwPiwgPCZhZGMgMT4sIDwmYWRjIDI+LCA8JmFkYyAzPiwK
PiAgICAgICAgICAgICBAQCAtNTQsNiArNjUsMTIgQEAKPiAgICAgICAgICAgICAgCX07Cj4gICAg
ICAgICAgICAgIH07Cj4gICAgICAgICAgICAgIAo+ICAgICAgICAgICAgICsmbHBjX2N0cmwgewo+
ICAgICAgICAgICAgICsJc3RhdHVzID0gIm9rYXkiOwo+ICAgICAgICAgICAgICsJbWVtb3J5LXJl
Z2lvbiA9IDwmZmxhc2hfbWVtb3J5PjsKPiAgICAgICAgICAgICArCWZsYXNoID0gPCZzcGkxPjsK
PiAgICAgICAgICAgICArfTsKPiAgICAgICAgICAgICArCj4gICAgICAgICAgICAgICZ1YXJ0MSB7
Cj4gICAgICAgICAgICAgIAkvLyBIb3N0IENvbnNvbGUKPiAgICAgICAgICAgICAgCXN0YXR1cyA9
ICJva2F5IjsKPiAgICAgICAgICAgICAtLSAKPiAgICAgICAgICAgICAyLjE3LjEKCkkgdW5kZXJz
dGFuZCB5b3UganVzdCB3YW50IHRvIG1ha2UgeW91ciBzeXN0ZW0gd29yaywgYnV0IHRoaXMgaXMg
YQpicm9rZW4gd2F5IHRvIGRvIGl0LiBBbmQgdGhhdCdzIG5vdCB5b3VyIGZhdWx0IC0gd2Ugc2hv
dWxkIHJlYWxseSBmaXgKdGhlIGRyaXZlci4gSSB0aGluayB0aGUgbWVtb3J5LXJlZ2lvbiBwaGFu
ZGxlIHNob3VsZCBiZSBvcHRpb25hbAphbmQgdGhlIGRyaXZlciBzaG91bGQgc2ltcGx5IGxpbWl0
IHRoZSBvcHRpb25zIGF2YWlsYWJsZSB0byB0aGUgaW9jdGwKdG8ganVzdCB0aGUgZmxhc2ggcmVn
aW9uIGlmIHRoZSBtZW1vcnkgbm9kZSBpcyBub3QgcHJlc2VudCAoaS5lLiByZXR1cm4KYW4gZXJy
b3IgaWYgdGhlIG1lbW9yeSByZWdpb24gaXMgcmVxdWVzdGVkIGJ1dCBub3QgZGVzY3JpYmVkIGlu
IHRoZQpkZXZpY2V0cmVlKS4KCkFuZHJldwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJt
LWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21h
aWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
