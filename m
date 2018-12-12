Return-Path: <SRS0=fRgi=OV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21A77C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 11:05:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E764920870
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 11:05:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="s/7Y/l5D";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=semihalf-com.20150623.gappssmtp.com header.i=@semihalf-com.20150623.gappssmtp.com header.b="So6IaWcH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E764920870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=semihalf.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Kw98t43olgsTTn+cLvbb5dQKTp0vt1eZOfeStT4EmCo=; b=s/7Y/l5DcGQGrO
	YvXWYQnYel08uQpxi8F2aJidXVxblzxKU4hWZrdIqaJgcX+9tw4CfPRuBtDCrOXWPb6Lhkri+5h4e
	iHuEAIvbf2vYeM2r3kmh3yu5iMCr2Mw2fv8GClO07tPnVcQelI2nplgApHww+R8QWmTtRmayA1Y7/
	Akte9KteO5I2itVgIU4OOL5WqdLeVXS86FOJuGN2e0wRxNghUyFfrY+Gl5u1aOgPvV4/gaKhLYTqV
	bT8CVbAR66YYrmUSRzpyq4nR83rtgmE94UWptEdW7sKV3NcidIKGQKArGCgqx8PvlOIaMl1G6II3l
	6agy8nTl7oL23MRP/Z+A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gX2KT-0000oo-QK; Wed, 12 Dec 2018 11:05:25 +0000
Received: from mail-it1-x141.google.com ([2607:f8b0:4864:20::141])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gX2KQ-0000nI-8W
 for linux-arm-kernel@lists.infradead.org; Wed, 12 Dec 2018 11:05:23 +0000
Received: by mail-it1-x141.google.com with SMTP id o19so8392128itg.5
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 12 Dec 2018 03:05:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=semihalf-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=zl65wYhWgxumjBrCQBpV7u87LqosHGb3K67coRfqFqE=;
 b=So6IaWcHN3kfoitaYVOFqvpQvaQeK2oY/S4kK1u5ZO2+VJij9OKgL3TsruZdFVUTLM
 HBtQdUdo4NiKqSix1QdZ9AJ6T4LYtMHfCvca96YcF8g4P6KXE/1aI1aGEuuL3augC5Cd
 /BGJCHO1wOw+LIn3qaEkuBqRM5cd2hB7HOhn/MeC9xfJYcHY01oZVuobxr3pvTXt++qx
 VGcjgPm5zD8UPTpWEix5PqlqD22qz+h+8CmAnKs1z/oJSB66ovtZtUpaWgsHTrcZ0dVX
 YithaOR0xt493Uk08ccapVp5xFRW+8lDGnUfCZyMcbwPXU5mfx1pNPlnKWVA/qCUHV7y
 VjoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=zl65wYhWgxumjBrCQBpV7u87LqosHGb3K67coRfqFqE=;
 b=Y+JHY0bIa61OSWTkQR2fFOHZDkv5OG0gOdUvAtOyLjjCCUc+LRnclCOO0O66QNcce+
 f5K2D3FAIZ0zAXjjmRiUV/Yx9sChcnz+LESkmOIz3KuhfAY1RScC0xgV3aSW+D2rzuXg
 adHd5Y86I8BA8rilLHDcquus2Zx3WR7zpKq4WmKfcVYnHNfCELSJ0xU4MfEUZGVdfu5Y
 WuHqajL1rlVNrmsosyk5l4lknXeWykLE/mgmtuD7OounU4R5jme6Ec+Hh3/nJgt7Driq
 xc9QsUmEPb+Qmt3SklhH8sNxzgIdmPTrG8zxFUQtiV4NSGUgvlNqlx4FgrzAaPZdI96x
 5Twg==
X-Gm-Message-State: AA+aEWa69+rAcItiPpknDKhrwnBycfNq+7jC3iGMa4hrxNxvmGYQabxq
 ul5/flLcIm2RfJ8tmM7cHFN0haHJJ/RY/Qti5cGKPg==
X-Google-Smtp-Source: AFSGD/XcQhoLHqDm9MdNT2beNWIY01r46TkBORmIw1I71ADxqn5zgjJjnlITnXL6F+i+KzTcFe0pk6ug5LZTid9cyCI=
X-Received: by 2002:a24:eb0b:: with SMTP id h11mr5405662itj.138.1544612710887; 
 Wed, 12 Dec 2018 03:05:10 -0800 (PST)
MIME-Version: 1.0
References: <1544533009-12425-1-git-send-email-mw@semihalf.com>
 <20181212104304.49026ed2@xhacker.debian>
 <CAPv3WKctDNJVq7SgHBZLO_TU50ponCLu7h5oMKLTndBiDadhaA@mail.gmail.com>
 <20181212172006.0814cf03@xhacker.debian>
In-Reply-To: <20181212172006.0814cf03@xhacker.debian>
From: Marcin Wojtas <mw@semihalf.com>
Date: Wed, 12 Dec 2018 12:04:58 +0100
Message-ID: <CAPv3WKd71XBeUo2d7199f-LNs3ZVKOMBDBB69Mtufy_Qr_w81Q@mail.gmail.com>
Subject: Re: [PATCH net] net: mvneta: fix operation for 64K PAGE_SIZE
To: Jisheng.Zhang@synaptics.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181212_030522_306626_83F29394 
X-CRM114-Status: GOOD (  26.64  )
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
Cc: Antoine Tenart <antoine.tenart@bootlin.com>,
 netdev <netdev@vger.kernel.org>,
 =?UTF-8?Q?Gr=C3=A9gory_Clement?= <gregory.clement@bootlin.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Russell King - ARM Linux <linux@armlinux.org.uk>, nadavh@marvell.com,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Grzegorz Jaszczyk <jaz@semihalf.com>, Stefan Chulski <stefanc@marvell.com>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 "David S. Miller" <davem@davemloft.net>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGkgSmlzaGVuZywKCsWbci4sIDEyIGdydSAyMDE4IG8gMTA6MjUgSmlzaGVuZyBaaGFuZyA8Smlz
aGVuZy5aaGFuZ0BzeW5hcHRpY3MuY29tPiBuYXBpc2HFgihhKToKPgo+IEhpIE1hcmNpbiwKPgo+
IE9uIFdlZCwgMTIgRGVjIDIwMTggMDk6MjI6NTcgKzAxMDAgTWFyY2luIFdvanRhcyA8bXdAc2Vt
aWhhbGYuY29tPiB3cm90ZToKPgo+ID4gSGkgSmlzaGVuZywKPiA+Cj4gPiDFm3IuLCAxMiBncnUg
MjAxOCBvIDAzOjQ4IEppc2hlbmcgWmhhbmcgPEppc2hlbmcuWmhhbmdAc3luYXB0aWNzLmNvbT4g
bmFwaXNhxYIoYSk6Cj4gPiA+Cj4gPiA+IEhpLAo+ID4gPgo+ID4gPiBPbiBUdWUsIDExIERlYyAy
MDE4IDEzOjU2OjQ5ICswMTAwIE1hcmNpbiBXb2p0YXMgd3JvdGU6Cj4gPiA+Cj4gPiA+ID4gUmVj
ZW50IGNoYW5nZXMgaW4gdGhlIG12bmV0YSBkcml2ZXIgcmV3b3JrZWQgYWxsb2NhdGlvbgo+ID4g
PiA+IGFuZCBoYW5kbGluZyBvZiB0aGUgaW5ncmVzcyBidWZmZXJzIHRvIHVzZSBlbnRpcmUgcGFn
ZXMuCj4gPiA+ID4gQXBhcnQgZnJvbSB0aGF0IGluIFNXIEJNIHNjZW5hcmlvIHRoZSBIVyBtdXN0
IGJlIGluZm9ybWVkCj4gPiA+ID4gdmlhIFBSWERRUyBhYm91dCB0aGUgYmlnZ2VzdCBwb3NzaWJs
ZSBpbmNvbWluZyBidWZmZXIKPiA+ID4gPiB0aGF0IGNhbiBiZSBwcm9wYWdhdGVkIGJ5IFJYIGRl
c2NyaXB0b3JzLgo+ID4gPiA+Cj4gPiA+ID4gVGhlIEJ1ZmZlclNpemUgZmllbGQgd2FzIGZpbGxl
ZCBhY2NvcmRpbmcgdG8gdGhlIE1UVS1kZXBlbmRlbnQKPiA+ID4gPiBwa3Rfc2l6ZSB2YWx1ZS4g
TGF0ZXIgY2hhbmdlIHRvIFBBR0VfU0laRSBicm9rZSBSWCBvcGVyYXRpb24KPiA+ID4gPiB3aGVu
IHVzaW4gNjRLIHBhZ2VzLCBhcyB0aGUgZmllbGQgaXMgc2ltcGx5IHRvbyBzbWFsbC4KPiA+ID4g
Pgo+ID4gPiA+IFRoaXMgcGF0Y2ggY29uZGl0aW9uYWxseSBsaW1pdHMgdGhlIHZhbHVlIHBhc3Nl
ZCB0byB0aGUgQnVmZmVyU2l6ZQo+ID4gPiA+IG9mIHRoZSBQUlhEUVMgcmVnaXN0ZXIsIGRlcGVu
ZGluZyBvbiB0aGUgUEFHRV9TSVpFIHVzZWQuCj4gPiA+ID4gT24gdGhlIG9jY2FzaW9uIHJlbW92
ZSBub3cgdW51c2VkIGZyYWdfc2l6ZSBmaWVsZCBvZiB0aGUgbXZuZXRhX3BvcnQKPiA+ID4gPiBz
dHJ1Y3R1cmUuCj4gPiA+ID4KPiA+ID4gPiBGaXhlczogNTYyZTJmNDY3ZTcxICgibmV0OiBtdm5l
dGE6IEltcHJvdmUgdGhlIGJ1ZmZlciBhbGxvY2F0aW9uCj4gPiA+ID4gbWV0aG9kIGZvciBTV0JN
IikKPiA+ID4KPiA+ID4gSU1ITywgd2UnZCBiZXR0ZXIgcmV2ZXJ0IDU2MmUyZjQ2N2U3MSBhbmQg
N2U0N2ZkODRiNTZiYgo+ID4gPgo+ID4gPiBUaGUgaXNzdWUgY29tbWl0IDU2MmUyZjQ2N2U3MSB3
YW50cyB0byBzb2x2ZSBpcyBkdWUgdG8gY29tbWl0IDdlNDdmZDg0YjU2YmIKPiA+ID4gSXQgbG9v
a3MgYSBiaXQgd2lyZWQsIHRvIGludHJvZHVjZSByZWdyZXNzaW9uIHRoZW4gc3VibWl0IGFub3Ro
ZXIgY29tbWl0KGluCj4gPiA+IHRoZSBzYW1lIHBhdGNoIHNldCkgc29sdmUgaXQKPiA+ID4KPiA+
ID4gUGVyIG15IHRlc3QsIGFmdGVyIHJldmVydGluZyA1NjJlMmY0NjdlNzEgYW5kIDdlNDdmZDg0
YjU2YmIsIEkgY2FuJ3QgcmVwcm9kdWNlCj4gPiA+IHdoYXQncyBjbGFpbWVkIGluIGNvbW1pdCA1
NjJlMmY0NjdlNzEgLS0gIldpdGggc3lzdGVtIGhhdmluZyBhIHNtYWxsIG1lbW9yeQo+ID4gPiAo
YXJvdW5kIDI1Nk1CKSwgdGhlIHN0YXRlICJjYW5ub3QgYWxsb2NhdGUgbWVtb3J5IHRvIHJlZmls
bCB3aXRoIG5ldyBidWZmZXIiCj4gPiA+IGlzIHJlYWNoIHByZXR0eSBxdWlja2x5LiIKPiA+Cj4g
PiBJIGFtIG5vdCB0aGUgb25lIHRvIGRlY2lkZSBhYm91dCBwYXRjaCByZXZlcnRpbmcuIEZyb20g
d2hhdCBJCj4gPiB1bmRlcnN0YW5kLCBjb21taXQgN2U0N2ZkODRiNTZiYiB3YXMgaW50b3JkdWNl
ZCBpbiBvcmRlciB0byBpbmNyZWFzZQo+ID4gcGVyZm9ybWFuY2UgdGhhbmtzIHRvIHJlcGxhY2lu
ZyBtdm5ldGFfZnJhZ19hbGxvYy9mcmVlIHdpdGggdXNpbmcKPiA+IGVudGlyZSBwYWdlcyBmb3Ig
UlggYnVmZmVycy4gSSBoYXZlIDIgcXVlc3Rpb25zOgo+ID4gLSB3aXRob3V0IHJldmVydGluZyBh
bnl0aGluZywgZG8geW91IG9ic2VydmUgbWVtb3J5IGFsbG9jYXRpb24KPiA+IHByb2JsZW1zIGR1
cmluZyByZWZpbGw/Cj4KPiBJIHNlZSBtZW1vcnkgd2FzdGU6IEZvciBub3JtYWwgMTUwMCBNVFUs
IGJlZm9yZSBjb21taXQgN2U0N2ZkODRiNTZiYiB3ZQo+IGFsbG9jYXRlIDE5MjBCeXRlcyBmb3Ig
cnguIEFmdGVyIGNvbW1pdCA3ZTQ3ZmQ4NGI1NmJiLCB3ZSBhbHdheXMgYWxsb2NhdGUKPiBQQUdF
X1NJWkUgYnl0ZXMsIGlmIFBBR0VfU0laRT00MDk2LCB3ZSB3YXN0ZSA1MyUgbWVtb3J5IGZvciBl
YWNoIHJ4IGJ1Zi4KPgo+ID4gLSBhcmUgeW91IGFibGUgdG8gY2hlY2sgTDIgZm9yd2FyZGluZyBu
dW1iZXJzIG9uIHRvcCBvZiB0aGUgcHVyZQo+ID4gbWFpbmxpbmUgYnJhbmNoIGFuZCBhZnRlciBy
ZXZlcnRpbmcgdGhlIG1lbnRpb25lZCBwYXRjaGVzPyBJJ20KPiA+IHdvbmRlcmluZyB3aGF0IHdv
dWxkIGJlIHRoZSBwZXJmb3JtYW5jZSBwZW5hbHR5IChpZiBhbnkpLgo+Cj4gSSBkaWRuJ3QgaGF2
ZSB0aGUgbnVtYmVycy4gSU1ITywgd2hlbiB0aGUgcGVyZm9ybWFuY2UgbnVtYmVyIHNob3VsZAo+
IGJlIHB1dCBpbnRvIHRoZSBjb21taXQgbXNnIHdoZW4gaW50cm9kdWNpbmcgY29tbWl0IDdlNDdm
ZDg0YjU2YmIuCj4KCkluIGdlbmVyYWwgSSBhZ3JlZSB3aXRoIHlvdSBhYm91dCB0aGUgbWVtb3J5
IHdhc3RlIGFuZCBsYWNrIG9mIG51bWJlcnMKYmFja2luZyB0aGUgN2U0N2ZkODRiNTZiYiBjaGFu
Z2UuIEhvd2V2ZXIgdGhlIGltcHJvdmVkIHJlZmlsbAptZWNoYW5pc20gZnJvbSA1NjJlMmY0Njdl
NzEgaXMgc29tZXRoaW5nIElNTyB3b3J0aCB0byBrZWVwLCBzbyBzaW1wbGUKcmV2ZXJ0cyBtYXkg
bm90IGJlIHRoZSBiZXN0IGlkZWEuIFdlIHNob3VsZCBmb2N1cyBvbiBkcm9wcGluZyB0aGUgZnVs
bApwYWdlIHBlciBkZXNjcmlwdG9yIGRlcGVuZGVuY3kgLSBJIHdhbnQgdG8gZG8gaXQsIGJ1dCBz
aW5jZSBpdCdzIGEKc2xpZ2h0bHkgYmlnZ2VyIHJld29yaywgSSBjYW5ub3QgcHJvbWlzZSBpdCB3
aWxsIGhhcHBlbiBmYXN0LgoKQmVzdCByZWdhcmRzLApNYXJjaW4KCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBs
aXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5m
cmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
