Return-Path: <SRS0=6Gta=PZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D203C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 01:57:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF34420675
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 01:57:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WB8ovFSn";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tytqg4+v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF34420675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=heq3oiFWS4SzpE6i9+GCDWvq/mb4cNBt0FZannHTtWY=; b=WB8ovFSnar5eQ3
	a1vk2mNTIkWKCR2+uvoWV0vIy6k7MyklWdH9BrOles0IUJQmLZff7wPbdPnH7Dw4cG3tsqaoJxmTR
	BQkqn4ia0vR3p6BAVVIpkBigTUw5xhpdgVxYhzkS6Ue7mmpSQcF6tZfQjWeNSyZ9nhrvobkxlqIwb
	QA22TGzExkAMhtFnzNJj8Db6hMq7pootR0wuaXGEsYDWr17wXwJsLwfS0agMf1pF1Bk5HlhvyzZ2S
	rYXMgAm81HVRG9RNYiXji0whetKWBsgeLLdExx8GBlhf0LQHOSFrBFHDdI0eF+pyCOfIONoeqLEbB
	hQ+icxoskLDrylf0t3xQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjwwC-00007m-IM; Thu, 17 Jan 2019 01:57:44 +0000
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjwvy-0008Lv-2f
 for linux-arm-kernel@lists.infradead.org; Thu, 17 Jan 2019 01:57:36 +0000
Received: by mail-ot1-x344.google.com with SMTP id s5so9698054oth.7
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 16 Jan 2019 17:57:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=EXIW7bVzHWS1DHDPDbxMnongYlAY8CFRBhpc/tSDLb4=;
 b=tytqg4+veE2PMT5iR8Y5szfVVaeuogXMa+zTTIZ1ZQX7ZJ1ViMPbDfv0JuYClrVGfC
 apu0vIZgdyUNztXMZOc5bPi+bgkHbUhUV5JZWsu2wUBbBWlPfY1/AHUACsSN0/QRtonF
 4Y5tylh2zP4PWsn6dEdJ/xLE7YZDzW3SAJ3FIQUMsPU9PraGJXhWZFP0wL537ZONjEk3
 wFP28/4apl3ucv5BLKTeu9QQaAOnjNeosypY4Y/w6nJPGdJzQeUIlEvRiviVYFXUUKz8
 Tc5pkGAN2eo6/jgS9yRwWTDBWfXaIJJvIpBRWYUBiTg9VhdBn5FhOg9ln/IxJ1MEbVI5
 6MRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=EXIW7bVzHWS1DHDPDbxMnongYlAY8CFRBhpc/tSDLb4=;
 b=Y1/MwbOfl4V2XKEecDSoJS/Sd4pBe3aL3qhxaSVpZYA13KzxvXPjrg42mH9IaSxZ0R
 TeZIkU2sZzIiEg4HSQGoxsTebZ1mUq72br+ZOfZZ/bBqkZdvDcFyMFC3Jn5+QmZxB3F3
 aVPPoHUGCcp1OQXTJLzBmUMLrNCz+NWrv54TRLTMA9ZthLKvxl1xW0LatodsM4eXuOG5
 sgKQbvvL3ONzgrrPWg6N4n1TWnIgq+MUuWshpuxYwVvDszSx/U8lHmOUYGS58BvgLwQj
 YEUQLU2bTvNCR0w7kz4zQBqeCePkasTAgmFmPr8VhUaRpNdFx348sEr8EgFCOTdg+eSs
 xHjg==
X-Gm-Message-State: AJcUuket7WdkZkp/8yDCylu4PuuBZoiqGs/xgiA1oa5ALzVBtnVv9vrL
 ATD0FusweLR9SYHL7dun5lzH4xzMvCuTYUocwb4=
X-Google-Smtp-Source: ALg8bN5G9TaEfXLRTOiePuLXcauYHgMHYMvkWnOb0X++S+smEQIY0R+7XyL5Cf1+Y5NDExQPgDmuZ5bbjc5uw5HFkN4=
X-Received: by 2002:a05:6830:1584:: with SMTP id
 i4mr7042971otr.116.1547690248430; 
 Wed, 16 Jan 2019 17:57:28 -0800 (PST)
MIME-Version: 1.0
References: <CAKwPUowmzZ2BNi-RmJm3=ENrZ5sxPf1SeT+b9A9iHHSCUQQAUw@mail.gmail.com>
 <20190116164817.GG1910@brain-police>
In-Reply-To: <20190116164817.GG1910@brain-police>
From: Kassey <kassey1216@gmail.com>
Date: Thu, 17 Jan 2019 09:57:17 +0800
Message-ID: <CAKwPUoyWy64-o2NgB5iPXNs4UR7bmYjmKk3Ub0X6DND40fCtPA@mail.gmail.com>
Subject: Re: arm64: copy_from_user access the last page of ddr has problem on
 4.14 kernel
To: Will Deacon <will.deacon@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190116_175730_850792_F45F728F 
X-CRM114-Status: GOOD (  20.74  )
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
Cc: mark.rutland@arm.com, kassey@126.com, ard.biesheuvel@linaro.org,
 catalin.marinas@arm.com, linux-kernel@vger.kernel.org, willy@infradead.org,
 robin.murphy@arm.com, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

aGksIFdpbGwKICAgICAgaXQgaXMgaGFyZCB0byB0cnkgb24gdjUuMC1yYzIga2VybmVsLCBzaW5j
ZSB0aGVyZSBpcyBtdWNoIHBvcnQKam9iIHRvIGJlIGRvbmUuCiAgICAgZHN0IGtlcm5lbCBidWZm
ZXIgaXMgbG9va3Mgb3ZlcndyaXRlbiBieSBzb21lIHNhbWUoZml4KSBwYXR0ZXIKc3RhcnQgd2l0
aCAibW1hcCIgICAgKDB4NmQ2ZDcwNjEpICBzZWUgYmVsb3cgY29kZSAoZGF0YSBmcm9tIHZtYWxs
b2MpLAphbmQgZmlsZSBpcyBtbWFwZWQgKGluY2x1ZGUgdGhlIGxhc3QgcGh5IHBhZ2Ugb2YgZGRy
LikKICAgICBzZWUgYmVsb3cgcGF0dGVybiBhbmQgcGllY2VzIG9mIGNvZGUuCiAgICAgbm90IHN1
cmUgaWYgdGhlcmUgaXMgYm91bmRhcnkgaXNzdWUgZm9yIGNvcHlfZnJvbV91c2VyLCBwbGVhc2UK
aGVscCB0byBzdWdnZXN0IGlmIHlvdSBnb3Qgc29tZSBpZGVhIGZyb20gdGhlIHBhdHRlcm4sIHRo
YW5rcy4KCjAwNzljMDAgNmQ2ZCA3MDYxIDAwMDAgMDAwMCAwODQ4IGZkOGYgMDAwMSAwMDAwCjAw
NzljMTAgMDA0OCBmZDhmIDAwMDEgMDAwMCAwMDAxIDAwMDAgMDAwMyAwMDAwCjAwNzljMjAgMjAw
MCBmZDgzIDAwMDEgMDAwMCAxZmZmIGZkODYgMDAwMSAwMDAwCjAwNzljMzAgMDAwMCAwMDAwIDAw
MDAgMDAwMCA3MDBmIDAwMDAgMDAwMCAwMDAwCjAwNzljNDAgNmQ2ZCA3MDYxIDAwMDAgMDAwMCBm
NDQ4IGZmZmYgMDAwMSAwMDAwCjAwNzljNTAgZjc0OCBmZmZmIDAwMDEgMDAwMCAwMDAxIDAwMDAg
MDAwNCAwMDAwCjAwNzljNjAgMzAwMCBmZDhjIDAwMDEgMDAwMCAyZmZmIGZkOGUgMDAwMSAwMDAw
CjAwNzljNzAgMDAwMCAwMDAwIDAwMDAgMDAwMCA3MDBmIDAwMDAgMDAwMCAwMDAwCjAwNzljODAg
YzEwMyAwNjA2IDAxMDAgYmUwMCAxMDA5IDNiMDAgM2IwNyAwNjA3CjAwNzljOTAgMDEwMCA1NzAw
IDEwMDYgZTgwMCA4YzAzIDMxMDMgMDEwMCAwYTAwCjAwNzljYTAgMDAwMCBjZjAwIGJmMDggMGEw
MCAwMTAwIDU3MDAgMTAwNiAzNzAwCjAwNzljYjAgMzkwNiAwNjA2IDAxMDAgMTYwMCAwMDA0IDQ3
MDAgOTkwMiAwMjA3CjAwNzljYzAgNmQ2ZCA3MDYxIDAwMDAgMDAwMCBmODA4IGZmZmYgMDAwMSAw
MDAwCjAwNzljZDAgZjFjOCBmZmZmIDAwMDEgMDAwMCAwMDAxIDAwMDAgMDAwNSAwMDAwCjAwNzlj
ZTAgZDAwMCBmZmY4IDAwMDEgMDAwMCBlZmZmIGZmZmEgMDAwMSAwMDAwCjAwNzljZjAgMDAwMCAw
MDAwIDAwMDAgMDAwMCA3MDBmIDAwMDAgMDAwMCAwMDAwCjAwNzlkMDAgNmQ2ZCA3MDYxIDAwMDAg
MDAwMCBmMWM4IGZmZmYgMDAwMSAwMDAwCjAwNzlkMTAgZjM4OCBmZmZmIDAwMDEgMDAwMCAwMDAx
IDAwMDAgMDAwMyAwMDAwCjAwNzlkMjAgYzAwMCBmZmRmIDAwMDEgMDAwMCA2ZmZmIGZmZjggMDAw
MSAwMDAwCjAwNzlkMzAgMDAwMCAwMDAwIDAwMDAgMDAwMCA3MDBmIDAwMDAgMDAwMCAwMDAwCjAw
NzlkNDAgOTQwNyAwOTAxIDAxMDAgNTMwMCAwMjA0IGI0MDAgZDUwMyAwYTA0CjAwNzlkNTAgMDEw
MCAwMDAwIDAwMDEgMDIwMCA3MzA5IDAyMDIgMDEwMCAwMjAwCjAwNzlkNjAgNTAwMCAwMjAwIDcz
MDkgMDIwMiAwNDAwIGZmMDAgZjdmZiA5NGZmCjAwNzlkNzAgYjQwMCAwMjA4IDAxMDAgZGMwMCAw
MDAwIGI0MDAgNTgwMyAwNjA3CjAwNzlkODAgNmQ2ZCA3MDYxIDAwMDAgMDAwMCBmN2M4IGZmZmYg
MDAwMSAwMDAwCgoKc3RhdGljIHNzaXplX3Qgc2VsX3dyaXRlX2xvYWQoc3RydWN0IGZpbGUgKmZp
bGUsIGNvbnN0IGNoYXIgX191c2VyICpidWYsCiAgICAgc2l6ZV90IGNvdW50LCBsb2ZmX3QgKnBw
b3MpCgp7CnNzaXplX3QgbGVuZ3RoOwp2b2lkICpkYXRhID0gTlVMTDsKCm11dGV4X2xvY2soJnNl
bF9tdXRleCk7CgpsZW5ndGggPSBhdmNfaGFzX3Blcm0oY3VycmVudF9zaWQoKSwgU0VDSU5JVFNJ
RF9TRUNVUklUWSwKICAgICBTRUNDTEFTU19TRUNVUklUWSwgU0VDVVJJVFlfX0xPQURfUE9MSUNZ
LCBOVUxMKTsKaWYgKGxlbmd0aCkKZ290byBvdXQ7CgovKiBObyBwYXJ0aWFsIHdyaXRlcy4gKi8K
bGVuZ3RoID0gLUVJTlZBTDsKaWYgKCpwcG9zICE9IDApCmdvdG8gb3V0OwoKbGVuZ3RoID0gLUVG
QklHOwppZiAoY291bnQgPiA2NCAqIDEwMjQgKiAxMDI0KQpnb3RvIG91dDsKCmxlbmd0aCA9IC1F
Tk9NRU07CmRhdGEgPSB2bWFsbG9jKGNvdW50KTsgICAgICAgICAgICAvLyBkc3QgYnVmZmVyIGlu
IGtlcm5lbAppZiAoIWRhdGEpCmdvdG8gb3V0OwoKbGVuZ3RoID0gLUVGQVVMVDsKaWYgKGNvcHlf
ZnJvbV91c2VyKGRhdGEsIGJ1ZiwgY291bnQpICE9IDApCmdvdG8gb3V0OwoKCgoKQlIKS2Fzc2V5
CgpXaWxsIERlYWNvbiA8d2lsbC5kZWFjb25AYXJtLmNvbT4g5LqOMjAxOeW5tDHmnIgxN+aXpeWR
qOWbmyDkuIrljYgxMjo0OOWGmemBk++8mgo+Cj4gW0knbSBkdWUgdG8gZ2V0IG9uIGEgbG9uZyBm
bGlnaHQgc2hvcnRseSwgc28gSSd2ZSBhZGRlZCBMQUtNTCBhbmQgYSBmZXcKPiBvdGhlcnMgdG8g
Q0NdCj4KPiBPbiBXZWQsIEphbiAxNiwgMjAxOSBhdCAxMToyNToxNUFNICswODAwLCBLYXNzZXkg
d3JvdGU6Cj4gPiBIaSwgV2lsbCBhbmQgdGVhbToKPiA+Cj4gPiAgICB3ZSBtZXQgYSBpc3N1ZSB3
aGVuIGNvcHlfZnJvbV91c2VyIHRvIGFjY2VzcyB0aGUgbGFzdCBwYWdlIG9mIEREUgo+ID4gb24g
NC4xNCBrZW5yZWwsIGJlbG93IGlzIHRoZSBkZXRhaWwgc3RlcHMsCj4gPiAgICBjYW4geW91IGhl
bHAgdG8gc3VnZ2VzdCBpZiB0aGVyZSBpcyBrbm93IGZpeCBvciBkZWJ1ZyBzb21ldGhpbmcgPwo+
ID4KPiA+IDEuIHdlIG1tYXAgKCBpbiB1c2Vyc3BhY2UpICBhIHJlZ2lvbiBvZiAgcGh5IGFkZHJl
c3MgdGhhdCBpcyBub3QKPiA+IGNvbnRpbm91cyAgYnV0IGluY2x1ZGUgdGhlIGxhc3QgcGFnZSBv
ZiBkZHIKPiA+Cj4gPiAgIGZvciBleGFtcGxlIG91ciBkZHIgZW5kIGlzIDB4MjAwMDAwMDAwCj4g
PiAgIHRoZSBsYXN0IHBhZ2UgaXMgZmFsbCBpbiBiZWxvdyBhZGRyOgo+ID4gICAweDFmZmZmZjAw
MCAgdG8gIDB4MjAwMDAwMDAwCj4gPgo+ID4gMi4gd2UgdXNpbmcgY29weV9mcm9tX3VzZXIgdG8g
Y29weSB0aGVzZSBtbWFwIGFkZHJlc3MgdG8ga2VybmVsIGJ1ZmZlcgo+ID4KPiA+IDMuIGFuZCB3
ZSBmaW5kIGV2ZXJ5dGltZSB3aGVuIHRyeWluZyB0byBjb3B5X2Zyb21fdXNlciAgdGhlIGxhc3Qg
cGFnZQo+ID4gaW4gcGh5IG9mIGRkciwKPiA+ICAgICB0aGUgZHN0IGtlcm5lbCBidWZmZXIgaXMg
bG9va3Mgb3ZlcndyaXRlIGJ5IHNvbWUgc2FtZSBwYXR0ZW4gc3RhcnQKPiA+IHdpdGggIm1tYXAi
IGluIHRoaXMgbGFzdCBwYWdlICxidXQgdGhlIHNyYyBpbiB0aGUgbGFzdCBwYWdlIG9mIGRkciBp
cwo+ID4gc3RpbGwgY29ycmVjdC4KPiA+Cj4gPiBpcyB0aGVyZSBhbnkga25vdyBpc3N1ZSBmb3Ig
Y29weV9mcm9tX3VzZXIgdG8gYWNjY2VzIHRoZSBsYXN0IHBhZ2Ugb2YKPiA+IHBoeSBkZHIgbW1h
cGVkIGJ5IHVzZXJzcGFjZSAgPwo+Cj4gTm90IHRoYXQgSSdtIGF3YXJlIG9mLiBBcmUgeW91IHVz
aW5nIGRlZmNvbmZpZyBhbmQgY2FuIHlvdSByZXByb2R1Y2UgdGhlCj4gcHJvYmxlbSB3aXRoIG1h
aW5saW5lIChlLmcuIHY1LjAtcmMyKT8gV2hhdCBleGFjdGx5IGRvIHlvdSBtZWFuIGJ5Ogo+Cj4g
ICAidGhlIGZzdCBrZXJuZWwgYnVmZmVyIGlzIGxvb2tzIG92ZXJ3cml0ZSBieSBzb21lIHNhbWUg
cGF0dGVuIHN0YXJ0IHdpdGgKPiAgICJtbWFwIiI/Cj4KPiBEb2VzIHRoZSBjb3B5X2Zyb21fdXNl
ciBmYWlsICh3aGF0IGRvZXMgaXQgcmV0dXJuPykgb3IgZG9lcyBpdCBzdWNjZWVkIGJ1dAo+IHRo
ZSBkYXRhIGNvcGllZCBhcHBlYXJzIHRvIGJlIGp1bms/IElzIGl0IGRldGVybWluaXN0aWM/IENv
dWxkIHlvdSBzaGFyZSBhbgo+IGV4YW1wbGUgb2Ygd2hhdCB0aGUgY29ycnVwdGVkIGRhdGEgbG9v
a3MgbGlrZSwgcGxlYXNlPwo+Cj4gQ2hlZXJzLAo+Cj4gV2lsbAoKCgotLSAKQmVzdCByZWdhcmRz
Ckthc3NleQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
bGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZy
YWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGlu
dXgtYXJtLWtlcm5lbAo=
