Return-Path: <SRS0=7SeU=QL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94E0BC282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 20:12:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5363820821
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 20:12:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ioYhjlAj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5363820821
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=XqKn5Xrsc9C8sP1gnu8PS8doCkKq0q0mi1tEZaIvc7o=; b=ioYhjlAjuLadYt
	QVfXexcb5aCNMR65A2w/0KUaoIwA5jYOj3Ryvs4560a9mcNGdweH45c9PSWblYejcnRCwh+nR1tu1
	faS13g4vtt6kyJ4145nDBmVXloOnxwQlASGQ9falEkNjf6e+NQ5394TrtLHNtFiE0n91tJmLe/+Wb
	bevXgTtMpS0ekU5byr3b+7Zv1a3uHhW2fKSExlDCNtFrCCFqwjBgcbt2vxAY3Q6wqLTpwcNCFoHXD
	M9PU+3Xd2D+JbApKSeeat4W1JYazTya8mFXZQ0ac2WpzIUI8vTC23ZGn++t2PmXfjoCsKBHxaw0pv
	6vDcEjGDXcgZelGP6dBg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqkbQ-0006Aq-48; Mon, 04 Feb 2019 20:12:24 +0000
Received: from mail-ot1-f66.google.com ([209.85.210.66])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqkbM-0006AG-M1
 for linux-arm-kernel@lists.infradead.org; Mon, 04 Feb 2019 20:12:22 +0000
Received: by mail-ot1-f66.google.com with SMTP id 81so2047276otj.2
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 04 Feb 2019 12:12:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=05TcC0mVNsG1FXSCe7mkTG+0mFL2ljeP6sQuGrocubQ=;
 b=rm4r4G4RwrzGIXEVjHCEDF46d8CW0G7K0C23J2XI08ycLcaIQQaDqoCKqvaWp5qYU+
 gh9KSVIlBRe9IZWQGY/8HX2vDV0a7YJ17N/cC+T3fFyKq0RvshHLLms+Iuj35vN1mgOY
 Md93WASGGqwo764Jw+zZKCyd+xvV93EXOcAlCyWZD3cm0Ft+PxXycDk9Ey3Qljfy3jX5
 egpeAXNMqTr8Ajg4gXDC2fCntpuiPNK5xGcHuLPEEjL5eGuCjH5bPyuPW7TVD1rLajVo
 4m2362F9DMtwSbDnbGA2tMo3Rccj8PUW5/xGosXB7WcMvXxh4qWc1HErZ7pEMTTUxFqs
 t8qQ==
X-Gm-Message-State: AHQUAuaXG0KvbhL7dDQ66d3/2xTSAYmWmQ7ecy3VYulsKKq7sixHXNUC
 FIoxVr0q3HuMRyo5amQskGxAGKMi
X-Google-Smtp-Source: AHgI3IZ9AqVDO3rwhKHEJcPo5zLSMhY1q5ubePF3DSF+iB9tKIjDJQLUT+WO0KqsVkpM5kzn9K7Qxg==
X-Received: by 2002:a05:6830:110:: with SMTP id
 i16mr699085otp.72.1549311139201; 
 Mon, 04 Feb 2019 12:12:19 -0800 (PST)
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com.
 [209.85.210.45])
 by smtp.gmail.com with ESMTPSA id k130sm8052227oia.47.2019.02.04.12.12.17
 for <linux-arm-kernel@lists.infradead.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 04 Feb 2019 12:12:18 -0800 (PST)
Received: by mail-ot1-f45.google.com with SMTP id n8so1991497otl.6
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 04 Feb 2019 12:12:17 -0800 (PST)
X-Received: by 2002:aca:31cb:: with SMTP id x194mr580917oix.213.1549311137614; 
 Mon, 04 Feb 2019 12:12:17 -0800 (PST)
MIME-Version: 1.0
References: <20190204143449.25040-1-pankaj.bansal@nxp.com>
 <20190204143449.25040-2-pankaj.bansal@nxp.com>
In-Reply-To: <20190204143449.25040-2-pankaj.bansal@nxp.com>
From: Li Yang <leoyang.li@nxp.com>
Date: Mon, 4 Feb 2019 14:12:06 -0600
X-Gmail-Original-Message-ID: <CADRPPNTjD1nN2eoyV6NucFYjH4vG8TaCG0u3YgEJd1699d07bQ@mail.gmail.com>
Message-ID: <CADRPPNTjD1nN2eoyV6NucFYjH4vG8TaCG0u3YgEJd1699d07bQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: soc: fsl: Document Qixis FPGA usage
To: Pankaj Bansal <pankaj.bansal@nxp.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190204_121220_732005_85A40526 
X-CRM114-Status: GOOD (  18.40  )
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

UGxlYXNlIGluY2x1ZGUgZGV2aWNlIHRyZWUgYmluZGluZyBtYWlsaW5nIGxpc3QgYW5kIG1haW50
YWluZXJzIGZvcgpiaW5kaW5nIHBhdGNoZXMoY2MnZWQgbm93KS4KCk9uIE1vbiwgRmViIDQsIDIw
MTkgYXQgMzoxNSBBTSBQYW5rYWogQmFuc2FsIDxwYW5rYWouYmFuc2FsQG54cC5jb20+IHdyb3Rl
Ogo+Cj4gYW4gRlBHQS1iYXNlZCBzeXN0ZW0gY29udHJvbGxlciwgY2FsbGVkIOKAnFFpeGlz4oCd
LCB3aGljaAo+IG1hbmFnZXMgc2V2ZXJhbCBjcml0aWNhbCBzeXN0ZW0gZmVhdHVyZXMsIGluY2x1
ZGluZzoKPiDigKIgUmVzZXQgc2VxdWVuY2luZwo+IOKAoiBQb3dlciBzdXBwbHkgY29uZmlndXJh
dGlvbgo+IOKAoiBCb2FyZCBjb25maWd1cmF0aW9uCj4g4oCiIGhhcmR3YXJlIGNvbmZpZ3VyYXRp
b24KPgo+IFRoZSBxaXhpcyByZWdpc3RlcnMgYXJlIGFjY2Vzc2libGUgb3ZlciBvbmUgb3IgbW9y
ZSBzeXN0ZW0tc3BlY2lmaWMKPiBpbnRlcmZhY2VzLCB0eXBpY2FsbHkgSTJDLCBKVEFHIG9yIGFu
IGVtYmVkZGVkIHByb2Nlc3Nvci4KPgo+IFNpZ25lZC1vZmYtYnk6IFBhbmthaiBCYW5zYWwgPHBh
bmthai5iYW5zYWxAbnhwLmNvbT4KPiAtLS0KPgo+IE5vdGVzOgo+ICAgICBWMzoKPiAgICAgLSBB
ZGRlZCBib2FyZG5hbWUgYmFzZWQgY29tcGF0aWJsZSBmaWVsZCBpbiBiaW5kaW5ncwo+ICAgICAt
IEFkZGVkIGJpbmRpbmdzIGZvciBNTUlPIGJhc2VkIEZQR0EKPiAgICAgVjI6Cj4gICAgIC0gTm8g
Y2hhbmdlCj4KPiAgLi4uL2JpbmRpbmdzL3NvYy9mc2wvcWl4aXNfY3RybC50eHQgICAgICAgICAg
fCA1MyArKysrKysrKysrKysrKysrKysKPiAgMSBmaWxlIGNoYW5nZWQsIDUzIGluc2VydGlvbnMo
KykKPgo+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mvc29j
L2ZzbC9xaXhpc19jdHJsLnR4dCBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9z
b2MvZnNsL3FpeGlzX2N0cmwudHh0Cj4gbmV3IGZpbGUgbW9kZSAxMDA2NDQKPiBpbmRleCAwMDAw
MDAwMDAwMDAuLjVkNTEwZGYxNGJlOAo+IC0tLSAvZGV2L251bGwKPiArKysgYi9Eb2N1bWVudGF0
aW9uL2RldmljZXRyZWUvYmluZGluZ3Mvc29jL2ZzbC9xaXhpc19jdHJsLnR4dAo+IEBAIC0wLDAg
KzEsNTMgQEAKPiArKiBRSVhJUyBGUEdBIGJsb2NrCj4gKwo+ICthbiBGUEdBLWJhc2VkIHN5c3Rl
bSBjb250cm9sbGVyLCBjYWxsZWQg4oCcUWl4aXPigJ0sIHdoaWNoCj4gK21hbmFnZXMgc2V2ZXJh
bCBjcml0aWNhbCBzeXN0ZW0gZmVhdHVyZXMsIGluY2x1ZGluZzoKPiAr4oCiIENvbmZpZ3VyYXRp
b24gc3dpdGNoIG1vbml0b3JpbmcKPiAr4oCiIFBvd2VyIG9uL29mZiBzZXF1ZW5jaW5nCj4gK+KA
oiBSZXNldCBzZXF1ZW5jaW5nCj4gK+KAoiBQb3dlciBzdXBwbHkgY29uZmlndXJhdGlvbgo+ICvi
gKIgQm9hcmQgY29uZmlndXJhdGlvbgo+ICvigKIgaGFyZHdhcmUgY29uZmlndXJhdGlvbgo+ICvi
gKIgQmFja2dyb3VuZCBwb3dlciBkYXRhIGNvbGxlY3Rpb24gKERDTSkKPiAr4oCiIEZhdWx0IG1v
bml0b3JpbmcKPiAr4oCiIFJDVyBieXBhc3MgU1JBTSAocmVwbGFjZSBmbGFzaCBSQ1cgd2l0aCBp
bnRlcm5hbCBSQ1cpIChOT1Igb25seSkKPiAr4oCiIERlZGljYXRlZCBmdW5jdGlvbmFsIHZhbGlk
YXRpb24gYmxvY2tzIChQT1N0L0lSUywgdHJpZ2dlcmVkIGV2ZW50LCBhbmQgc28gb24pCj4gK+KA
oiBJMkMgbWFzdGVyIGZvciByZW1vdGUgYm9hcmQgY29udHJvbCBldmVuIHdpdGggbm8gRFVUIGF2
YWlsYWJsZQo+ICsKPiArVGhlIHFpeGlzIHJlZ2lzdGVycyBhcmUgYWNjZXNzaWJsZSBvdmVyIG9u
ZSBvciBtb3JlIHN5c3RlbS1zcGVjaWZpYyBpbnRlcmZhY2VzLAo+ICt0eXBpY2FsbHkgSTJDLCBK
VEFHIG9yIGFuIGVtYmVkZGVkIHByb2Nlc3Nvci4KPiArCj4gK0ZQR0EgY29ubmVjdGVkIHRvIEky
QzoKPiArUmVxdWlyZWQgcHJvcGVydGllczoKPiArCj4gKyAtIGNvbXBhdGlibGU6IHNob3VsZCBi
ZSBhIGJvYXJkLXNwZWNpZmljIHN0cmluZyBmb2xsb3dlZCBieSBhIHN0cmluZwo+ICsgICBpbmRp
Y2F0aW5nIHRoZSB0eXBlIG9mIEZQR0EuICBFeGFtcGxlOgo+ICsgICAgICAgImZzbCw8Ym9hcmQ+
LWZwZ2EiLCAiZnNsLGZwZ2EtcWl4aXMtaTJjIgo+ICsgLSByZWcgOiBpMmMgYWRkcmVzcyBvZiB0
aGUgcWl4aXMgZGV2aWNlLgo+ICsKPiArRXhhbXBsZSAoTFgyMTYwQS1RRFMpOgo+ICsgICAgICAg
LyogVGhlIEZQR0Egbm9kZSAqLwo+ICsgICAgICAgIGZwZ2FANjYgewo+ICsgICAgICAgICAgICAg
ICBjb21wYXRpYmxlID0gImZzbCxseDIxNjBhcWRzLWZwZ2EiLCAiZnNsLGZwZ2EtcWl4aXMtaTJj
IjsKPiArICAgICAgICAgICAgICAgcmVnID0gPDB4NjY+Owo+ICsgICAgICAgICAgICAgICAjYWRk
cmVzcy1jZWxscyA9IDwxPjsKPiArICAgICAgICAgICAgICAgI3NpemUtY2VsbHMgPSA8MD47Cj4g
KyAgICAgICB9Cj4gKwo+ICsqIEZyZWVzY2FsZSBvbi1ib2FyZCBGUEdBCj4gKwo+ICtUaGlzIGlz
IHRoZSBtZW1vcnktbWFwcGVkIHJlZ2lzdGVycyBmb3Igb24gYm9hcmQgRlBHQS4KPiArCj4gK1Jl
cXVpcmVkIHByb3BlcnRpZXM6Cj4gKy0gY29tcGF0aWJsZTogc2hvdWxkIGJlIGEgYm9hcmQtc3Bl
Y2lmaWMgc3RyaW5nIGZvbGxvd2VkIGJ5IGEgc3RyaW5nCj4gKyAgaW5kaWNhdGluZyB0aGUgdHlw
ZSBvZiBGUEdBLiAgRXhhbXBsZToKPiArICAgICAgICJmc2wsPGJvYXJkPi1mcGdhIiwgImZzbCxm
cGdhLXFpeGlzIgo+ICstIHJlZzogc2hvdWxkIGNvbnRhaW4gdGhlIGFkZHJlc3MgYW5kIHRoZSBs
ZW5ndGggb2YgdGhlIEZQR0EgcmVnaXN0ZXIgc2V0Lgo+ICsKPiArRXhhbXBsZSAoTFMyMDgwQS1S
REIpOgo+ICsKPiArICAgICAgICBjcGxkQDMsMCB7Cj4gKyAgICAgICAgICAgICAgICBjb21wYXRp
YmxlID0gImZzbCxsczIwODBhcmRiLWZwZ2EiLCAiZnNsLGZwZ2EtcWl4aXMiOwo+ICsgICAgICAg
ICAgICAgICAgcmVnID0gPDB4MyAwIDB4MTAwMDA+Owo+ICsgICAgICAgIH07Cj4gKwo+IC0tCj4g
Mi4xNy4xCj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5m
cmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xp
bnV4LWFybS1rZXJuZWwK
