Return-Path: <SRS0=fRgi=OV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF627C65BAF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 17:19:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A06FE20851
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 17:19:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="CrHlEvO/";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="uxTrmvka"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A06FE20851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=qRI9yYz/r7n6aSKx67dAmb1nbai3LbkcU2c7wb8VEag=; b=CrHlEvO/NyZClO
	bcLhMbfExBkGaFkOoypztgDZNSYf15rxmXJQcQRAX9CyqpqPVEEwyi+l58+Fl/o6BiN5b/Gfbiy/f
	n1P9xOMEAq3QU7EBCTgApTXZ1U3t1J20jCu33/z64YCpFutwmLFfgB89eCw1+oWGaoKdel8DQA9o0
	qklE9hHW+zjv5fqvaUltKBR/7UeuxrIGA0FFSaMY3E36U49hdxY6FAB+c+7jolpuNYsL36KxabH/Q
	sdLSZRtNtU/tbHvsJ+VT4KWW1I0cJTgSAT9VxfkhvzIlfeEscnpqaQpqjVke74uEYYbIyhqwqhIRG
	V1AsLkeumgeZncdzJkmg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gX8AF-0003hL-Pg; Wed, 12 Dec 2018 17:19:15 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gX8AC-0003e3-5G
 for linux-arm-kernel@lists.infradead.org; Wed, 12 Dec 2018 17:19:13 +0000
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net
 [81.96.234.148])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id E3F8720851;
 Wed, 12 Dec 2018 17:18:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1544635141;
 bh=ppSsWLSPQN9/OSxzftYBE+M4YZMmUtfNScoa3kV4+T4=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=uxTrmvkaTB7c7MIxVIMlAiOSjODDOxNeclC3tKq6YfVrs0v/llFmDmMftzwcid4ol
 xXOfdpZL+q0hgAElKsFcq/5bWo/quUlO0tYjQNKzLgtvHDBJrJTZul6FqGvGi79XSp
 lKpBQKsNnH6JRVfNKkeeK1wLR0tOSlieFoUQR/lI=
Date: Wed, 12 Dec 2018 17:18:46 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: =?UTF-8?B?UGF3ZcWC?= Chmiel <pawel.mikolaj.chmiel@gmail.com>
Subject: Re: [PATCH 1/3] iio: adc: exynos-adc: Add S5PV210 variant
Message-ID: <20181212171846.4f4675a7@archlinux>
In-Reply-To: <20181207191136.5464-2-pawel.mikolaj.chmiel@gmail.com>
References: <20181207191136.5464-1-pawel.mikolaj.chmiel@gmail.com>
 <20181207191136.5464-2-pawel.mikolaj.chmiel@gmail.com>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181212_091912_228514_056F5012 
X-CRM114-Status: GOOD (  14.22  )
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
Cc: mark.rutland@arm.com, linux-iio@vger.kernel.org, xc-racer2@live.ca,
 pmeerw@pmeerw.net, freeman.liu@spreadtrum.com, marcus.folkesson@gmail.com,
 lars@metafoo.de, krzk@kernel.org, linux-samsung-soc@vger.kernel.org,
 kgene@kernel.org, geert@linux-m68k.org, devicetree@vger.kernel.org,
 smohanad@codeaurora.org, vilhelm.gray@gmail.com, robh+dt@kernel.org,
 linux-arm-kernel@lists.infradead.org, baolin.wang@linaro.org,
 rdunlap@infradead.org, arnaud.pouliquen@st.com, linux-kernel@vger.kernel.org,
 broonie@kernel.org, knaack.h@gmx.de, eugen.hristev@microchip.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gRnJpLCAgNyBEZWMgMjAxOCAyMDoxMTozNCArMDEwMApQYXdlxYIgQ2htaWVsIDxwYXdlbC5t
aWtvbGFqLmNobWllbEBnbWFpbC5jb20+IHdyb3RlOgoKPiBGcm9tOiBKb25hdGhhbiBCYWtrZXIg
PHhjLXJhY2VyMkBsaXZlLmNhPgo+IAo+IFM1UFYyMTAncyBBREMgdmFyaWFudCBpcyBhbG1vc3Qg
dGhlIHNhbWUgYXMgdjEgZXhjZXB0IHRoYXQgaXQgaGFzIDEwCj4gY2hhbm5lbHMgYW5kIGRvZXNu
J3QgcmVxdWlyZSB0aGUgcG11IHJlZ2lzdGVyCj4gCj4gU2lnbmVkLW9mZi1ieTogSm9uYXRoYW4g
QmFra2VyIDx4Yy1yYWNlcjJAbGl2ZS5jYT4KPiBTaWduZWQtb2ZmLWJ5OiBQYXdlxYIgQ2htaWVs
IDxwYXdlbC5taWtvbGFqLmNobWllbEBnbWFpbC5jb20+CkxvbmcgZW5vdWdoIEkgdGhpbmcgOykK
CkFwcGxpZWQgdG8gdGhlIHRvZ3JlZyBicmFuY2ggb2YgaWlvLmdpdCBhbmQgcHVzaGVkIG91dCBh
cyB0ZXN0aW5nCmZvciB0aGUgYXV0b2J1aWxkZXJzIHRvIHBsYXkgd2l0aCBpdC4KClRoYW5rcywK
CkpvbmF0aGFuCgo+IC0tLQo+ICBkcml2ZXJzL2lpby9hZGMvZXh5bm9zX2FkYy5jIHwgMTQgKysr
KysrKysrKysrKysKPiAgMSBmaWxlIGNoYW5nZWQsIDE0IGluc2VydGlvbnMoKykKPiAKPiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9paW8vYWRjL2V4eW5vc19hZGMuYyBiL2RyaXZlcnMvaWlvL2FkYy9l
eHlub3NfYWRjLmMKPiBpbmRleCBmMTA0NDNmOTJlNGMuLmZhMmQyYjU3NjdmMyAxMDA2NDQKPiAt
LS0gYS9kcml2ZXJzL2lpby9hZGMvZXh5bm9zX2FkYy5jCj4gKysrIGIvZHJpdmVycy9paW8vYWRj
L2V4eW5vc19hZGMuYwo+IEBAIC0xMTUsNiArMTE1LDcgQEAKPiAgI2RlZmluZSBNQVhfQURDX1Yy
X0NIQU5ORUxTCQkxMAo+ICAjZGVmaW5lIE1BWF9BRENfVjFfQ0hBTk5FTFMJCTgKPiAgI2RlZmlu
ZSBNQVhfRVhZTk9TMzI1MF9BRENfQ0hBTk5FTFMJMgo+ICsjZGVmaW5lIE1BWF9TNVBWMjEwX0FE
Q19DSEFOTkVMUwkxMAo+ICAKPiAgLyogQml0IGRlZmluaXRpb25zIGNvbW1vbiBmb3IgQURDX1Yx
IGFuZCBBRENfVjIgKi8KPiAgI2RlZmluZSBBRENfQ09OX0VOX1NUQVJUCSgxdSA8PCAwKQo+IEBA
IC0yODIsNiArMjgzLDE2IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgZXh5bm9zX2FkY19kYXRhIGV4
eW5vc19hZGNfdjFfZGF0YSA9IHsKPiAgCS5zdGFydF9jb252CT0gZXh5bm9zX2FkY192MV9zdGFy
dF9jb252LAo+ICB9Owo+ICAKPiArc3RhdGljIGNvbnN0IHN0cnVjdCBleHlub3NfYWRjX2RhdGEg
ZXh5bm9zX2FkY19zNXB2MjEwX2RhdGEgPSB7Cj4gKwkubnVtX2NoYW5uZWxzCT0gTUFYX1M1UFYy
MTBfQURDX0NIQU5ORUxTLAo+ICsJLm1hc2sJCT0gQURDX0RBVFhfTUFTSywJLyogMTIgYml0IEFE
QyByZXNvbHV0aW9uICovCj4gKwo+ICsJLmluaXRfaHcJPSBleHlub3NfYWRjX3YxX2luaXRfaHcs
Cj4gKwkuZXhpdF9odwk9IGV4eW5vc19hZGNfdjFfZXhpdF9odywKPiArCS5jbGVhcl9pcnEJPSBl
eHlub3NfYWRjX3YxX2NsZWFyX2lycSwKPiArCS5zdGFydF9jb252CT0gZXh5bm9zX2FkY192MV9z
dGFydF9jb252LAo+ICt9Owo+ICsKPiAgc3RhdGljIHZvaWQgZXh5bm9zX2FkY19zM2MyNDE2X3N0
YXJ0X2NvbnYoc3RydWN0IGV4eW5vc19hZGMgKmluZm8sCj4gIAkJCQkJICB1bnNpZ25lZCBsb25n
IGFkZHIpCj4gIHsKPiBAQCAtNDc4LDYgKzQ4OSw5IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3Qgb2Zf
ZGV2aWNlX2lkIGV4eW5vc19hZGNfbWF0Y2hbXSA9IHsKPiAgCX0sIHsKPiAgCQkuY29tcGF0aWJs
ZSA9ICJzYW1zdW5nLHMzYzY0MTAtYWRjIiwKPiAgCQkuZGF0YSA9ICZleHlub3NfYWRjX3MzYzY0
eHhfZGF0YSwKPiArCX0sIHsKPiArCQkuY29tcGF0aWJsZSA9ICJzYW1zdW5nLHM1cHYyMTAtYWRj
IiwKPiArCQkuZGF0YSA9ICZleHlub3NfYWRjX3M1cHYyMTBfZGF0YSwKPiAgCX0sIHsKPiAgCQku
Y29tcGF0aWJsZSA9ICJzYW1zdW5nLGV4eW5vcy1hZGMtdjEiLAo+ICAJCS5kYXRhID0gJmV4eW5v
c19hZGNfdjFfZGF0YSwKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxp
c3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0
aW5mby9saW51eC1hcm0ta2VybmVsCg==
