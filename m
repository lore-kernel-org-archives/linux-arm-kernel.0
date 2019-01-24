Return-Path: <SRS0=pdKw=QA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BD11C282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 15:28:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8EC3218A2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 15:28:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="INB5905Q";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ncentric-com.20150623.gappssmtp.com header.i=@ncentric-com.20150623.gappssmtp.com header.b="vz0PAS7B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8EC3218A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=ncentric.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=N43NZ6Cliu9ggJKDL6DqzOp7TYWz/ABmLAgFBduTYsY=; b=INB5905QHBwYxnT3/nt7h0PAm
	tepd+uPNqvcQe0wsdE+9qRAIIcDVKT2HekhsA7XEEZC7O77g4AMZ8eJomYDWWBy09ku1XJXFvFJ4U
	yF+hacLbBS8yDxY7AdwM7HScMfAVYyIMXvHhdS7fyg8EKT5sKBwgfPtxeNzogqm8utCJjJY+oVcQX
	8cofQGCNxzrszfR2InEuJIs++/OneJvK+hICTMDEs+7SLACFbIbS0OVZdwuAxi6W7mdN6/ZUw/SLf
	o0BroOWhdLusL6u3ooAWrCKNnK/7zPUD2vDGkFlbISLYg7ChxfdgWiUQkKVaKGMthhKvadiFAbBhn
	Yo70huzmg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmgvg-0001mv-Ic; Thu, 24 Jan 2019 15:28:32 +0000
Received: from mail-ed1-x542.google.com ([2a00:1450:4864:20::542])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmgqT-0003sP-7O
 for linux-arm-kernel@lists.infradead.org; Thu, 24 Jan 2019 15:23:11 +0000
Received: by mail-ed1-x542.google.com with SMTP id a20so4868019edc.8
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 24 Jan 2019 07:23:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ncentric-com.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=GXdQgYGth7576FUZgtf9G8w7Dw9MAY0ouCZtk1cxqAE=;
 b=vz0PAS7BMLyCFXCwTiDRcEcgbo7tefk81wrS+2sSiQ0ZCqUzd/KlcU2mVNLrgQZSIm
 WDwnTp3L2vSQBcKORpEbJxH9nlOnlQSppRREtLRbbMQXR9OpVANOgDCui08pbIXZalPh
 oT+I104XAMTblJB3diHbRmIKhwxOQOMJ16z+q1hXWZ6R55MnXwXbprhtzmX4oZ68EhrA
 oJkjHKOZ+uIoYy4gl75yy5frQE2NDZmvQiY8ZEjvWRCnJI0faG8ASp759yTllFXpyb2c
 ssaHBBCdHEDtojyojq6nY93AzWmS87/Ruy6dWsQaq0T/aYd4/DgE4QIxucaKgCwlapza
 vWOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=GXdQgYGth7576FUZgtf9G8w7Dw9MAY0ouCZtk1cxqAE=;
 b=tXmbNbD2Rgb1+RKvZOBQiBJO/Z97arJzs9dfGgwxpeGjxFomM4rkp6gLhogakxSPO+
 aGwy1BnLadol02McdRPIEvr+/BVqTBWfozWJT8ryUc+I6pOYJPTRWbhh4uQlOSb56lhS
 L9eKqRwjyQQlnwmyM01ZXjhArA1HVL+BwnCMI8DSTkBqycRvF+b0TcsJMkTcMgAhhUWi
 +nPnKSGbOyJSSQHyos0HOs/giCv4nXoeVOclQKex1XNPSkBn+BEXGhDdthXUsWJjz/gt
 veshJwmDKGWuPk2Gqe8SIeqme3IuPgRQUNbP4Gizt9CIddb3SA2cw5crNJnA3bMffSGW
 1O1g==
X-Gm-Message-State: AJcUukdSprcypyBwBNstBcZzoPCkgC3tbLSEoirAIxsfX4p7FeMDxqZb
 FLiuXWE4JJnsixz3J/dJVCmPo8j78VUytg==
X-Google-Smtp-Source: ALg8bN6V2l/V6wONt2XPRn+VspGdmGGQQ/07YDk1Kyy4Qd1kkPFTg7Krk+/FdjIDu1OTdrkS14I8bw==
X-Received: by 2002:a50:8863:: with SMTP id c32mr6832840edc.156.1548343386823; 
 Thu, 24 Jan 2019 07:23:06 -0800 (PST)
Received: from [192.168.3.176] (d515300d8.static.telenet.be. [81.83.0.216])
 by smtp.gmail.com with ESMTPSA id v11sm10873020edy.49.2019.01.24.07.23.05
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 24 Jan 2019 07:23:06 -0800 (PST)
Subject: Re: [PATCH v2 1/2] arm: cns3xxx: fix writing to wrong PCI registers
 after alignment
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
References: <20190107134510.32494-1-koen.vandeputte@ncentric.com>
 <20190124115656.GA23362@e107981-ln.cambridge.arm.com>
From: Koen Vandeputte <koen.vandeputte@ncentric.com>
Message-ID: <47437c58-d7b3-f77c-7bc7-973373f1e78e@ncentric.com>
Date: Thu, 24 Jan 2019 16:23:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190124115656.GA23362@e107981-ln.cambridge.arm.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190124_072309_313512_A2919891 
X-CRM114-Status: GOOD (  22.25  )
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
Cc: Rob Herring <robh@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 linux-pci@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
 stable@vger.kernel.org, Robin Leblon <robin.leblon@ncentric.com>,
 Olof Johansson <olof@lixom.net>, Bjorn Helgaas <bhelgaas@google.com>,
 linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Ck9uIDI0LjAxLjE5IDEyOjU2LCBMb3JlbnpvIFBpZXJhbGlzaSB3cm90ZToKPiBPbiBNb24sIEph
biAwNywgMjAxOSBhdCAwMjo0NTowOVBNICswMTAwLCBLb2VuIFZhbmRlcHV0dGUgd3JvdGU6Cj4+
IE9yaWdpbmFsbHksIGNuczN4eHggdXNlZCBpdCdzIG93biBmdW5jdGlvbnMgZm9yIG1hcHBpbmcs
IHJlYWRpbmcgYW5kIHdyaXRpbmcgcmVnaXN0ZXJzLgo+Pgo+PiBDb21taXQgODAyYjdjMDZhZGM3
ICgiQVJNOiBjbnMzeHh4OiBDb252ZXJ0IFBDSSB0byB1c2UgZ2VuZXJpYyBjb25maWcgYWNjZXNz
b3JzIikKPj4gcmVtb3ZlZCB0aGUgaW50ZXJuYWwgUENJIGNvbmZpZyB3cml0ZSBmdW5jdGlvbiBp
biBmYXZvciBvZiB0aGUgZ2VuZXJpYyBvbmU6Cj4+Cj4+IGNuczN4eHhfcGNpX3dyaXRlX2NvbmZp
ZygpIC0tPiBwY2lfZ2VuZXJpY19jb25maWdfd3JpdGUoKQo+Pgo+PiBjbnMzeHh4X3BjaV93cml0
ZV9jb25maWcoKSBleHBlY3RlZCBhbGlnbmVkIGFkZHJlc3NlcywgYmVpbmcgcHJvZHVjZWQgYnkg
Y25zM3h4eF9wY2lfbWFwX2J1cygpCj4+IHdoaWxlIHRoZSBnZW5lcmljIG9uZSBwY2lfZ2VuZXJp
Y19jb25maWdfd3JpdGUoKSBhY3R1YWxseSBleHBlY3RzIHRoZSByZWFsIGFkZHJlc3MKPj4gYXMg
Ym90aCB0aGUgZnVuY3Rpb24gYW5kIGhhcmR3YXJlIGFyZSBjYXBhYmxlIG9mIGJ5dGUtYWxpZ25l
ZCB3cml0ZXMuCj4+Cj4+IFRoaXMgY3VycmVudGx5IGxlYWRzIHRvIHBjaV9nZW5lcmljX2NvbmZp
Z193cml0ZSgpIHdyaXRpbmcKPj4gdG8gdGhlIHdyb25nIHJlZ2lzdGVycyBvbiBzb21lIG9jYXNp
b25zLgo+Pgo+PiBGaXJzdCBpc3N1ZSBzZWVuIGR1ZSB0byB0aGlzOgo+Pgo+PiAtIGRyaXZlciBh
dGg5ayBnZXRzIGxvYWRlZAo+PiAtIFRoZSBkcml2ZXIgd2FudHMgdG8gd3JpdGUgdmFsdWUgMHhB
OCB0byByZWdpc3RlciBQQ0lfTEFURU5DWV9USU1FUiwgbG9jYXRlZCBhdCAweDBECj4+IC0gY25z
M3h4eF9wY2lfbWFwX2J1cygpIGFsaWducyB0aGUgYWRkcmVzcyB0byAweDBDCj4+IC0gcGNpX2dl
bmVyaWNfY29uZmlnX3dyaXRlKCkgZWZmZWN0aXZlbHkgd3JpdGVzIDB4QTggaW50byByZWdpc3Rl
ciAweDBDIChDQUNIRV9MSU5FX1NJWkUpCj4+Cj4+IFRoaXMgc2VlbXMgdG8gY2F1c2Ugc29tZSBz
bGlnaHQgaW5zdGFiaWxpdHkgd2hlbiBjZXJ0YWluIFBDSSBkZXZpY2VzIGFyZSB1c2VkLgo+Pgo+
PiBBbm90aGVyIGlzc3VlIGV4YW1wbGUgY2F1c2VkIGJ5IHRoaXMgdGhpcyBpcyB0aGUgUENJIGJ1
cyBudW1iZXJpbmcsCj4+IHdoZXJlIHRoZSBwcmltYXJ5IGJ1cyBpcyBoaWdoZXIgdGhhbiB0aGUg
c2Vjb25kYXJ5LCB3aGljaCBpcyBpbXBvc3NpYmxlLgo+Pgo+PiBCZWZvcmU6Cj4+Cj4+IDAwOjAw
LjAgUENJIGJyaWRnZTogQ2F2aXVtLCBJbmMuIERldmljZSAzNDAwIChyZXYgMDEpIChwcm9nLWlm
IDAwIFtOb3JtYWwgZGVjb2RlXSkKPj4gICAgICBGbGFnczogYnVzIG1hc3RlciwgZmFzdCBkZXZz
ZWwsIGxhdGVuY3kgMCwgSVJRIDI1NQo+PiAgICAgIEJ1czogcHJpbWFyeT0wMiwgc2Vjb25kYXJ5
PTAxLCBzdWJvcmRpbmF0ZT1mZiwgc2VjLWxhdGVuY3k9MAo+Pgo+PiBBZnRlciBmaXg6Cj4+Cj4+
IDAwOjAwLjAgUENJIGJyaWRnZTogQ2F2aXVtLCBJbmMuIERldmljZSAzNDAwIChyZXYgMDEpIChw
cm9nLWlmIDAwIFtOb3JtYWwgZGVjb2RlXSkKPj4gICAgICBGbGFnczogYnVzIG1hc3RlciwgZmFz
dCBkZXZzZWwsIGxhdGVuY3kgMCwgSVJRIDI1NQo+PiAgICAgIEJ1czogcHJpbWFyeT0wMCwgc2Vj
b25kYXJ5PTAxLCBzdWJvcmRpbmF0ZT0wMiwgc2VjLWxhdGVuY3k9MAo+Pgo+PiBBbmQgdmVyeSBs
aWtlbHkgc29tZSBtb3JlIC4uCj4+Cj4+IEZpeCBhbGwgYnkgb21pdHRpbmcgdGhlIGFsaWdubWVu
dCBiZWluZyBkb25lIGluIHRoZSBtYXBwaW5nIGZ1bmN0aW9uLgo+Pgo+PiBGaXhlczogODAyYjdj
MDZhZGM3ICgiQVJNOiBjbnMzeHh4OiBDb252ZXJ0IFBDSSB0byB1c2UgZ2VuZXJpYyBjb25maWcg
YWNjZXNzb3JzIikKPj4gQWNrZWQtYnk6IEtyenlzenRvZiBIYWxhc2EgPGtoYWxhc2FAcGlhcC5w
bD4KPj4gQWNrZWQtYnk6IFRpbSBIYXJ2ZXkgPHRoYXJ2ZXlAZ2F0ZXdvcmtzLmNvbT4KPj4gU2ln
bmVkLW9mZi1ieTogS29lbiBWYW5kZXB1dHRlIDxrb2VuLnZhbmRlcHV0dGVAbmNlbnRyaWMuY29t
Pgo+PiBDQzogQXJuZCBCZXJnbWFubiA8YXJuZEBhcm5kYi5kZT4KPj4gQ0M6IEJqb3JuIEhlbGdh
YXMgPGJoZWxnYWFzQGdvb2dsZS5jb20+Cj4+IENDOiBPbG9mIEpvaGFuc3NvbiA8b2xvZkBsaXhv
bS5uZXQ+Cj4+IENDOiBSb2JpbiBMZWJsb24gPHJvYmluLmxlYmxvbkBuY2VudHJpYy5jb20+Cj4+
IENDOiBSb2IgSGVycmluZyA8cm9iaEBrZXJuZWwub3JnPgo+PiBDQzogUnVzc2VsbCBLaW5nIDxs
aW51eEBhcm1saW51eC5vcmcudWs+Cj4+IENDOiBzdGFibGVAdmdlci5rZXJuZWwub3JnICMgdjQu
MCsKPj4gLS0tCj4+ICAgYXJjaC9hcm0vbWFjaC1jbnMzeHh4L3BjaWUuYyB8IDIgKy0KPj4gICAx
IGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKPiBJIGhhdmUgYXBw
bGllZCBib3RoIHBhdGNoZXMgdG8gcGNpL2FybS1jbnMzeHh4IGZvciB2NS4xLCBob3dldmVyIEkg
aGFkCj4gdG8gcmVmb3JtYXQgYW5kIHJld3JpdGUgYm90aCBsb2dzIChjb21taXQgbGluZSB3cmFw
cGluZ3MsCj4gY2FwaXRhbGl6YXRpb24sIGV0Yy4pIHNvIGhhdmUgYSBsb29rLgo+Cj4gVGhhbmtz
LAo+IExvcmVuem8KCkhpIExvcmVuem8sCgpUaGFuayB5b3UgZm9yIHRha2luZyBjYXJlIG9mIHRo
ZSB3cmFwcGluZ3MgZXRjLsKgIGl0IHNlZW1zIG15IGF1dG8td3JhcCAKd2FzIGRpc2FibGVkIGlu
IG15IGdpdCB0b29saW5nIC4uCllvdXIgYWRhcHRpb25zIGxvb2sgbW9yZSB0aGFuIGZpbmUuCgoK
UHVyZWx5IGZvciBteSBpbmZvcm1hdGlvbjoKClRlc3Rpbmcgb24gYSBsb3Qgb2YgZGV2aWNlcyBo
ZXJlIHNob3dzIGEgaHVnZSBpbXByb3ZlbWVudCB0b3dhcmRzIHN0YWJpbGl0eS4KSXMgaXQgcG9z
c2libGUgdG8gZ2V0IGl0IG1lcmdlZCBzb29uZXI/CkRvZXMgInF1ZXVlZCBmb3IgNS4xIiBhbHNv
IG1lYW4gdGhhdCBiYWNrcG9ydGluZyB0byBzdGFibGVzIG9ubHkgd2lsbCAKaGFwcGVuIGF0IDUu
MV9yYzEgcmVsZWFzZT8KCgpUaGFua3MgYWdhaW4hCgpLb2VuCgoKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxp
c3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZy
YWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
