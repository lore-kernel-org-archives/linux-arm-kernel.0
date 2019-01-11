Return-Path: <SRS0=KsRD=PT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94A28C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 09:47:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 674FA2177B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 09:47:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="NB35HJSw";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="feyzz4iF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 674FA2177B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=5Lms1m5DuXq7zaRifmkG2UES4+4AMjxHSSeWJtXQI8s=; b=NB35HJSwvEIruc
	apOZdRMm95LpMzN4i2K0cWlEh87cAUqoLDxyDUMWswFR7kteDTBByrQSdUyAlSZ70M/UnV3Zyj9SI
	0zNypeFmJjNe4a0ajPUS34x8Be6ZiisemaK4xHT26coOBGXo6oYiLNajo3+9iKxyWRZT5+Nc0jNec
	zupXf91n9nl2/76XW1IZ2QEtQdkNjSTwLRIcOxhnmF1/3G++WsInAx8iHYK98lF74GAGGicbXuNym
	+Na9SGU/+uHtm5MW4mFPNAR/8eV/35m6C8n9BvjlW4L10XCp+wPShIjKV+ezYtCRpBDwoK5pdoZri
	2nuAWEyzcPeLEKF7Dwsg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghtPo-0006Ip-9k; Fri, 11 Jan 2019 09:47:48 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghtPl-0006IH-1P
 for linux-arm-kernel@lists.infradead.org; Fri, 11 Jan 2019 09:47:46 +0000
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com
 [209.85.208.169])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 6014120874
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 11 Jan 2019 09:47:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1547200064;
 bh=RwTGqC0ZNDGGuS9uSs4IEPvaTiNO/rC4cyFReSfkiNg=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=feyzz4iF8OTgvrMJsz0fih1teANSLTlSAF9ZfEO1lgXlDMhi7CftcMSDQII4DmUcz
 LGjzKnwdhQbrt7SR63demryhDiOtiQ5P6gQ39neq3xshia7Ggk1pPT0gDDLlZLdeKf
 rvcu4tZo+Vjj9a1KDHxwXVMmzrX1gJ7By43c/C/8=
Received: by mail-lj1-f169.google.com with SMTP id s5-v6so12331071ljd.12
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 11 Jan 2019 01:47:44 -0800 (PST)
X-Gm-Message-State: AJcUukfssx+7WWIVg6MYDfiNsxYczo1Sm8vMs6710ZIaFL2ffzNMdwU3
 vwA5LMQkdp7y8dU0GmoIJQWDZRRr3moDyeGwt6o=
X-Google-Smtp-Source: ALg8bN59D7wP7OBsr8D6l9siYq4VQsyJeyGiNUUpnwJ4LNrIRtRTnFZCZuUMJGT/qIDceNuBN2im/tPh1pq2BJ/bWdc=
X-Received: by 2002:a2e:990e:: with SMTP id
 v14-v6mr8771787lji.60.1547200062579; 
 Fri, 11 Jan 2019 01:47:42 -0800 (PST)
MIME-Version: 1.0
References: <20190110205215.22030-1-pawel.mikolaj.chmiel@gmail.com>
 <20190110205215.22030-2-pawel.mikolaj.chmiel@gmail.com>
 <CAJKOXPcWOtTh5nDpZuX=NfrcOcQDPUXoFJLc8JtLs6UEY9LL6w@mail.gmail.com>
 <20190111094120.6dcnspccp6ufxd4y@vireshk-i7>
In-Reply-To: <20190111094120.6dcnspccp6ufxd4y@vireshk-i7>
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Fri, 11 Jan 2019 10:47:31 +0100
X-Gmail-Original-Message-ID: <CAJKOXPehsZV30Nhak3opcME6sceiF3s6MkGAbKKoxerGYmX57g@mail.gmail.com>
Message-ID: <CAJKOXPehsZV30Nhak3opcME6sceiF3s6MkGAbKKoxerGYmX57g@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] ARM: dts: s5pv210: Add dmc nodes
To: Viresh Kumar <viresh.kumar@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190111_014745_095925_4BAC6E27 
X-CRM114-Status: GOOD (  13.64  )
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
 "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>,
 linux-pm@vger.kernel.org, rjw@rjwysocki.net, linux@armlinux.org.uk,
 robh+dt@kernel.org, linux-kernel@vger.kernel.org, kgene@kernel.org,
 linux-arm-kernel@lists.infradead.org,
 =?UTF-8?Q?Pawe=C5=82_Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gRnJpLCAxMSBKYW4gMjAxOSBhdCAxMDo0MSwgVmlyZXNoIEt1bWFyIDx2aXJlc2gua3VtYXJA
bGluYXJvLm9yZz4gd3JvdGU6Cj4KPiBPbiAxMS0wMS0xOSwgMDk6MzIsIEtyenlzenRvZiBLb3ps
b3dza2kgd3JvdGU6Cj4gPiBPbiBUaHUsIDEwIEphbiAyMDE5IGF0IDIxOjUzLCBQYXdlxYIgQ2ht
aWVsCj4gPiA8cGF3ZWwubWlrb2xhai5jaG1pZWxAZ21haWwuY29tPiB3cm90ZToKPiA+ID4KPiA+
ID4gVGhpcyBjb21taXQgYWRkcyBkbWMgbm9kZXMsIHdoaWNoIGFyZSBuZWVkZWQgYnkgczVwdjIx
MCBjcHVmcmVxIGRyaXZlcgo+ID4gPiB0byB3b3JrLgo+ID4gPgo+ID4gPiBTaWduZWQtb2ZmLWJ5
OiBQYXdlxYIgQ2htaWVsIDxwYXdlbC5taWtvbGFqLmNobWllbEBnbWFpbC5jb20+Cj4gPiA+IC0t
LQo+ID4gPiAgYXJjaC9hcm0vYm9vdC9kdHMvczVwdjIxMC5kdHNpIHwgMTIgKysrKysrKysrKysr
Cj4gPiA+ICAxIGZpbGUgY2hhbmdlZCwgMTIgaW5zZXJ0aW9ucygrKQo+ID4gPgo+ID4KPiA+IFRo
YW5rcywgYXBwbGllZCAoYWN0dWFsbHkgSSBhcHBsaWVkIHYxIC0gSSBob3BlIHRoZXJlIHdlcmUg
bm8gY2hhbmdlcykuCj4KPiBXb3VsZCB5b3UgbGlrZSB0byBBY2sgdGhlIG90aGVyIHBhdGNoZXMg
c28gdGhhdCBJIGNhbiBhcHBseSB0aGVtID8KClN1cmUsIGxldCBtZSB0YWtlIGEgbG9vay4gQW55
d2F5LCBJIHdpbGwgdGFrZSBwYXRjaCA0LzQgKGRlZmNvbmZpZykuIEkKbGVmdCBpdCBmb3IgbGF0
ZXIgYmVjYXVzZSBvZiBvbmdvaW5nIGRpc2N1c3Npb24uCgpCZXN0IHJlZ2FyZHMsCktyenlzenRv
ZgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgt
YXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQu
b3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJt
LWtlcm5lbAo=
