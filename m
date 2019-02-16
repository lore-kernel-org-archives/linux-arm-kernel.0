Return-Path: <SRS0=BOBm=QX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AEEEC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 00:03:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C791A222DF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 00:03:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="fWZEo6Sm";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u+WC7NpD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C791A222DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=7CJjcD7eJ1qV7BN2UWH20tYPP01cVvCWn3X802aeWdk=; b=fWZEo6SmLGxThC
	Fsyvwtvzk/Hck60KMBOrIQda1Q4BIe6owXKbZrFViOsksx0E+3e0erNQirOT4tGEliL7xWakdCUMq
	AWUQpRg1XWqWamD8f4drMJ8/xFCvy+5AyXlG/zNSh5rYDizFr4ruaCIJON+zjupYDxddKRyeOOL2u
	1eTQyk92J/hYHSn/pq7mAYfbAWzQTWqnbkDOYV8aNCexG6t7TPwd1ZSbJ57QrUKfmEKsJ79vx6+ON
	mXpm7Y5Ry/HaGIGqjgaTFRCV8vZY9k9fjyfrzOzUhWF6d98XzWlsgYoNqIjCXaVbuGD/S/vssFYqj
	vFYqy+adWbFw9Srb+/iA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gunS0-0002Ip-PK; Sat, 16 Feb 2019 00:03:24 +0000
Received: from mail-lf1-x142.google.com ([2a00:1450:4864:20::142])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gunRx-0002IN-Ky
 for linux-arm-kernel@lists.infradead.org; Sat, 16 Feb 2019 00:03:23 +0000
Received: by mail-lf1-x142.google.com with SMTP id h10so8203111lfc.12
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 15 Feb 2019 16:03:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=kiV+KBPSwg0Z1g6MZq62hwk+wyU1jNWzNIFfH5wI5Tw=;
 b=u+WC7NpDtkV8qBZZ2uADf7rqQiMStmJD3WMM332Fl4kN0Hqi7A2fNYIE9/jSU9VawX
 E6TaPp1or3vm798O0J9OL57W4eT2x/NStAqsyCd2jXfX1JGA1dLH49LOBrdF1/LrGPop
 7pUfyn65iWzOzizfcPFsgMHp5gJdRabj/pPE++FriCvMmrGHEsjPdP0lYYj7Nf/iZhJ7
 yXadqk6E2ebphIt3gC6O2wpYHfmdxuz+wU9SofmZeM8U5ZWtFAyJSYtIui0oDsvICfAD
 6HezBxZQiOoy7BFzC2SH2FJ1L1b9NHRG8zRqw+KQ/SUB4v6ZBGtindB+WtIl6srxTb5Y
 tSfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=kiV+KBPSwg0Z1g6MZq62hwk+wyU1jNWzNIFfH5wI5Tw=;
 b=m9u+qVeOKkxf/n6Aj3NoYmPkiN+ov+4Tw7jG4vbx70d5jajstsj4PZN5AfPnRoWci6
 g0WG3Wtl6jfZ0Gd56v2rj2pf8FctBzYqHSXQ2i+3hn0AJPL/QAtwWFcqbai44lcB2pqm
 d0qkAgamq3ok7thn1g0lpG0gFDdGntTOsNzN9bhkfwejpBpJMIbO+Zwiyh/dymU71qRL
 LNb5H8oBEuK22HjsQynHAqCY9pd3fvkmwk62q7VlaRoqSXDPZdrxJQEum0SGtVqlJ2Tz
 7sr0VIAD0hQT0YWzH/wSnqOfaZSv96R9qlLAEUhAyqtGnBADESO09gK+XycoUA/E1Haf
 gwAg==
X-Gm-Message-State: AHQUAubab9RJtmSDiJ2L0aXBXzSnk7osuPbGLQh4I79TH8Bih8RykAAu
 z3jVu3DznDbGntrkSVmgGEBrSMAu
X-Google-Smtp-Source: AHgI3IZzDnmWFNSLNJi0pklXBIm4PJErHT3Rf2BOufMFpse3CyCmK1DJUNiULW4oJclgCilp2xATLg==
X-Received: by 2002:a19:1f10:: with SMTP id f16mr7511196lff.12.1550275398793; 
 Fri, 15 Feb 2019 16:03:18 -0800 (PST)
Received: from [192.168.2.145] (ppp91-79-175-49.pppoe.mtu-net.ru.
 [91.79.175.49])
 by smtp.googlemail.com with ESMTPSA id e23sm1436310ljj.3.2019.02.15.16.03.17
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 15 Feb 2019 16:03:17 -0800 (PST)
Subject: Re: [GIT PULL 6/9] ARM: tegra: Core changes for v5.1-rc1
To: Thierry Reding <thierry.reding@gmail.com>, Arnd Bergmann <arnd@arndb.de>
References: <20190208150935.32108-1-thierry.reding@gmail.com>
 <20190208150935.32108-7-thierry.reding@gmail.com>
 <CAK8P3a2vDG97hP80i6rknqFnDdpoCGMBpmoy2Gp-jUWnGJ5VCg@mail.gmail.com>
 <20190215214826.GB12838@ulmo>
From: Dmitry Osipenko <digetx@gmail.com>
Message-ID: <afa0e109-b24e-7b00-88c1-b3c30e1755fc@gmail.com>
Date: Sat, 16 Feb 2019 03:03:15 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190215214826.GB12838@ulmo>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_160321_744508_98AC4325 
X-CRM114-Status: GOOD (  16.90  )
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
Cc: "open list:TEGRA ARCHITECTURE SUPPORT" <linux-tegra@vger.kernel.org>,
 arm-soc <arm@kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Jon Hunter <jonathanh@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

MTYuMDIuMjAxOSAwOjQ4LCBUaGllcnJ5IFJlZGluZyDQv9C40YjQtdGCOgo+IE9uIEZyaSwgRmVi
IDE1LCAyMDE5IGF0IDA1OjQ4OjI1UE0gKzAxMDAsIEFybmQgQmVyZ21hbm4gd3JvdGU6Cj4+IE9u
IEZyaSwgRmViIDgsIDIwMTkgYXQgNDowOSBQTSBUaGllcnJ5IFJlZGluZyA8dGhpZXJyeS5yZWRp
bmdAZ21haWwuY29tPiB3cm90ZToKPj4+Cj4+PiBIaSBBUk0gU29DIG1haW50YWluZXJzLAo+Pj4K
Pj4+IFRoZSBmb2xsb3dpbmcgY2hhbmdlcyBzaW5jZSBjb21taXQgYmZlZmZkMTU1MjgzNzcyYmJl
NzhjNmEwNWRlYzdjMDEyOGVlNTAwYzoKPj4+Cj4+PiAgIExpbnV4IDUuMC1yYzEgKDIwMTktMDEt
MDYgMTc6MDg6MjAgLTA4MDApCj4+Pgo+Pj4gYXJlIGF2YWlsYWJsZSBpbiB0aGUgR2l0IHJlcG9z
aXRvcnkgYXQ6Cj4+Pgo+Pj4gICBnaXQ6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tl
cm5lbC9naXQvdGVncmEvbGludXguZ2l0IHRhZ3MvdGVncmEtZm9yLTUuMS1hcm0tY29yZQo+Pj4K
Pj4+IGZvciB5b3UgdG8gZmV0Y2ggY2hhbmdlcyB1cCB0byAxYzYyNzliNDlkM2ZmZmYzODM1N2U5
M2QxMTI1MTJmZWNmMzcxMWE3Ogo+Pj4KPj4+ICAgQVJNOiB0ZWdyYTogUmVzdG9yZSBtZW1vcnkg
YXJiaXRyYXRpb24gb24gcmVzdW1lIGZyb20gTFAxIG9uIFRlZ3JhMzArICgyMDE5LTAxLTE2IDEz
OjIyOjA0ICswMTAwKQo+Pj4KPj4+IFRoYW5rcywKPj4+IFRoaWVycnkKPj4+Cj4+PiAtLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
Cj4+PiBBUk06IHRlZ3JhOiBDb3JlIGNoYW5nZXMgZm9yIHY1LjEtcmMxCj4+Pgo+Pj4gVGhpcyBj
b250YWlucyB0aHJlZSBmaXhlcyBmb3IgcmVzdW1lIGZyb20gTFAxIG9uIFRlZ3JhMzAuCj4+Pgo+
Pgo+PiBQdWxsZWQgaW50byBhcm0vc29jPwo+Pgo+PiBTaG91bGQgdGhlc2UgYnVnZml4ZXMgaGF2
ZSBiZWVuIG1hcmtlZCBDYzpzdGFibGU/Cj4gCj4gSSBkb24ndCB0aGluayB0aGF0J2QgYmUgd29y
dGggaXQuIEFzIGZhciBhcyBJIGNhbiB0ZWxsIHRoZXNlIGhhdmUgYmVlbgo+IGJyb2tlbiBzaW5j
ZSBmb3JldmVyLiBCYWNrcG9ydGluZyB0aGlzIHdvdWxkIGJlIGZhaXJseSBpbnZvbHZlZCBhbmQg
SSdtCj4gbm90IHN1cmUgaWYgdGhpcyBodXJ0cyBlbm91Z2ggdG8gd2FycmFudCB0aGUgYWRkaXRp
b25hbCB3b3JrLCBnaXZlbiB0aGF0Cj4gaXQncyBub3QgYmVlbiByZXBvcnRlZCBpbiBhbGwgdGhp
cyB0aW1lLgo+IAo+IERtaXRyeSwgY2FuIHlvdSBjbGFyaWZ5IHdoZXRoZXIgeW91IHdhbnQgdGhl
c2UgdG8gYmUgYmFja3BvcnRlZD8KClRlY2huaWNhbGx5IGl0IGZpeGVzIGEgcmVhbCBwcm9ibGVt
LCBidXQgcmVhbGlzdGljYWxseSB0aGVyZSBpcyBubyByZWFsIG5lZWQgdG8gYmFja3BvcnQgdGhl
c2UgcGF0Y2hlcyBiZWNhdXNlIG9mIG90aGVyIHN1c3BlbmQtcmVzdW1lIHRyb3VibGVzIHRoYXQg
YWxzbyBleGlzdGVkIGFsbCB0aGUgdGltZSBhbmQgaGF2ZW4ndCBiZWVuIHJlc29sdmVkIHlldCAo
bGlrZWx5IGZpeGVzIHdvbid0IGJlIGJhY2twb3J0YWJsZSkuIEluIGdlbmVyYWwgc3VzcGVuZC1y
ZXN1bWUga2luZGEgd29ya3MgYW5kIGZhaWxzIG1vc3RseSB1bmRlciBzb21lIGxvYWQgKGxpa2Ug
c3RyZXNzIHRlc3RpbmcpLCBhdCBsZWFzdCB0aGF0J3MgdGhlIGNhc2UgZm9yIFQzMC4KCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJu
ZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRw
Oi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
