Return-Path: <SRS0=e5Gl=O3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47EBCC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 13:51:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1623A218A1
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 13:51:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Kj+1pweS";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KPnHy6r2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1623A218A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=eFQxEKR5ZFPuj5qFhCpzqUOYGoWTDc/HmfR64BQfFfU=; b=Kj+1pweS43Ccjc
	JXIs6GOttZjArkj96PlPk3nq239Hu/5A7V6gdEL97ettCHtSfcHl1zAnRJGg95B2K9m9luXaASc3x
	NmjUlV5wKgK7Yk/zmpElsDxm1eRzAHoKBg9x/75MnTUGRbUdLrBe7hFytdRHMJMD7giYiQZ81x0iU
	sGgELz67jQDa6FOqpTb6IN22KI2SUyVkr/WO4TuGxRBMzN1AZ7zl4pOpw0wpxgDw+WO1akbmY7gNT
	CnGiQXdZ6GTZf09XNaaE1KOSn9bPqxFozZlzZBe+LCiLkv9xmWPpe7FE1Q7b+EyvcJ9H69+cnfu6t
	uyOf0XsTCO1BTZiVF7gw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZFmo-0006Yz-TA; Tue, 18 Dec 2018 13:51:50 +0000
Received: from mail-lf1-x144.google.com ([2a00:1450:4864:20::144])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZFml-0006Y9-FT; Tue, 18 Dec 2018 13:51:49 +0000
Received: by mail-lf1-x144.google.com with SMTP id a16so12335369lfg.3;
 Tue, 18 Dec 2018 05:51:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=ZnvMIjYAEZ92ZLJ+02Brs3Waw8miEaBAQU/ogngkheg=;
 b=KPnHy6r26CRrUTavwExfR9JUTT4z5pwMQdnVYrRDWnjXwIF2JkxZ6dKSHo2o8EwfuN
 onbAGs0BLMRIJ1lIO8TEm8i6qc4usU6/VetF9U9pkmEQ+fv083r/LmpU+8uijV+NUcKv
 zH++GANwRaEv15PATmUMTWvx4myek/W4/yfgf2+ZGQmMRkSwfirL2t7hsio8oLc2Re+B
 k5jYbuKERSe7dUdOl9asVJkGcUSoZrm0/RsbZiS+XMPPkcK2x09OkadZLEbIzxR53WZl
 jHJtaW0/pPlEZubn8w0QZj5mUlQ0H29/sscQkzt4A3nlpnHuRunqCf8rq4duZZ9kXtU5
 u6Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=ZnvMIjYAEZ92ZLJ+02Brs3Waw8miEaBAQU/ogngkheg=;
 b=pWPoNgRDrYurWjQeU0ZtM2dlrXYozckYuIOpvMs83PtFvspps56nHGtNJJLEIhq0BV
 hmcd2fk0aSooWQ9r4TM/CPwWwjNOxTE0ZPw3efqfsFOGCtfgxxZ1VNQcCDpZJkNu+BY5
 QuU6hW7imHMWaapD3WuXfdyu7IU5FUN2cuYF793mR9n6MMgaXtfjgAyrgHECQnsPL1/f
 WX6sXTcI+ed+cTYqIXdwhFewVOY9yuDbWSt6ktACRNQ3S2xVqPswmZDp+N+itQYmpLC/
 CeZhdsGpV8LT3PN3GrCXcaqS5T09MA9JHrnG/ulzJL3kp+JQJlAc13mA7ETuZUlnsgT8
 RkhQ==
X-Gm-Message-State: AA+aEWYSseG5bfLs57A4N0d6oihR4iXerlh8L+L6vQbMKFEOb2ssuZSa
 nSU7KrfGYfWI/xjN0roBWorYtonTlxuLAYNTDms=
X-Google-Smtp-Source: AFSGD/UBd0oUKejm+BByh1spZf1wAyGPpcAQ0V9d8iz7U3Bsw6KMfkQpJTXX6joRjjkmbxR91wGlnBSocjTYOXKrUXs=
X-Received: by 2002:a19:4bc9:: with SMTP id y192mr9761456lfa.49.1545141095038; 
 Tue, 18 Dec 2018 05:51:35 -0800 (PST)
MIME-Version: 1.0
References: <CAC=mGziyi1ierhg++SUcHMrq1JQ0vH4gZCKUZgchzb8aD1Rv5Q@mail.gmail.com>
 <20181216101858.9585-7-starnight@g.ncu.edu.tw>
 <CAJuUDwtS3c7NhcNqijyFNtZeupO2HLQ8ZuMA1a-azEQL5yHjng@mail.gmail.com>
 <8bfdccbf-fb47-daa5-fbd0-ed16a3d6d334@suse.de>
In-Reply-To: <8bfdccbf-fb47-daa5-fbd0-ed16a3d6d334@suse.de>
From: Xue Liu <liuxuenetmail@gmail.com>
Date: Tue, 18 Dec 2018 14:50:58 +0100
Message-ID: <CAJuUDwsypFMEbTXZO+NwQ_FnD1wsO3ZRc3dthZphFGJ-u0n_=Q@mail.gmail.com>
Subject: Re: [PATCH v5 6/6] net: lorawan: List LORAWAN in menuconfig
To: =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181218_055147_521593_8727C157 
X-CRM114-Status: GOOD (  19.61  )
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
Cc: Alan Cox <gnomes@lxorguk.ukuu.org.uk>, netdev@vger.kernel.org,
 Marcel Holtmann <marcel@holtmann.org>, Dollar Chen <dollar.chen@wtmec.com>,
 linux-lpwan@lists.infradead.org, linux-kernel@vger.kernel.org,
 Jian-Hong Pan <starnight@g.ncu.edu.tw>, Ken Yu <ken.yu@rakwireless.com>,
 linux-wpan - ML <linux-wpan@vger.kernel.org>,
 "David S . Miller" <davem@davemloft.net>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGVsbG8gQW5kcmVhcywKCk9uIE1vbiwgMTcgRGVjIDIwMTggYXQgMTU6MTksIEFuZHJlYXMgRsOk
cmJlciA8YWZhZXJiZXJAc3VzZS5kZT4gd3JvdGU6Cj4KPiBIZWxsbyBYdWUgTGl1LAo+Cj4gQW0g
MTcuMTIuMTggdW0gMDk6NTAgc2NocmllYiBYdWUgTGl1Ogo+ID4gSSBoYXZlIGEgcXVlc3Rpb24g
YWJvdXQgdGhlIGFyY2hpdGVjdHVyZSBvZiB5b3VyIG1vZHVsZS4gQUZBSUsgTG9SYVdBTgo+ID4g
aXMgYWxyZWFkeSB0aGUgTUFDIExheWVyIGFib3ZlIHRoZSBMb1JhIHRlY2hub2xvZ3kuIFdoeSBk
byB5b3Ugd2FudCB0bwo+ID4gbWFrZSBhIG5ldyBsYXllciBjYWxsZWQgIm1hY2xvcmF3YW4iID8K
Pgo+IEkgaGFkIGFza2VkIEppYW4tSG9uZyB0byBzZXBhcmF0ZSBiZXR3ZWVuIGhpcyBzb2Z0LU1B
QyBpbXBsZW1lbnRhdGlvbgo+IGFuZCB0aGUgY29tbW9uIGJpdHMgbmVlZGVkIHRvIGRyaXZlIGhh
cmQtTUFDIGltcGxlbWVudGF0aW9ucyBmb3VuZCBvbgo+IHNldmVyYWwgb2YgdGhlIGhhcmR3YXJl
IG1vZHVsZXMgbWFkZSBhdmFpbGFibGUgdG8gbWUuCj4KQXMgYSByZWZlcmVuY2UgTGludXggODAy
LjExIHVzZXMgY2ZnODAyMTEgdG8gdGFsayB3aXRoIGhhcmQtTUFDIGRldmljZXMuCldlIG1heSBh
bHNvIHVzZSB0aGUgbmFtZSDigJxjZmdsb3Jh4oCdIGZvciBoYXJkLU1BQyBpbXBsZW1lbnRhdGlv
bi4KCj4gVGhlIHByZWZpeCAibWFjIiB3YXMgY29waWVkIGZyb20gbWFjODAyMTEgYW5kIG1hYzgw
MjE1NDoKPiBodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC90
b3J2YWxkcy9saW51eC5naXQvdHJlZS9uZXQKPgpPSy4gVW5kZXJzdG9vZC4gSSBndWVzcyB0aGV5
IHVzZSBtYWM4MDIxMSBhbmQgbWFjODAyMTU0IHRvIGRpc3Rpbmd1aXNoCnBoeXNpY2FsIGxheWVy
IGFuZCBNQUMgbGF5ZXIuIFNpbmNlIExvUmEgYW5kIExvUmFXQU4gYXJlIGFscmVhZHkKc2VwYXJh
dGUgSSB0aGluawoibWFjbG9yYXdhbiIgaXMgbm90IG5lY2Vzc2FyeS4KCj4gSWYgeW91IGhhdmUg
YmV0dGVyIGlkZWFzIGZvciBob3cgdG8gc3RydWN0dXJlIHRoaXMsIGp1c3QgbGV0IHVzIGtub3cs
Cj4gaWRlYWxseSBhcyBpbmxpbmUgY29tbWVudCB3aGVyZSB5b3Ugc2VlIGl0IChvciBvbiB0aGUg
Y292ZXIgbGV0dGVyKS4KPgo+IE9ubHkgY29tbWVudCBJIGhhdmUgZm9yIHRoaXMgcGF0Y2ggYXQg
dGhlIG1vbWVudCBpcyB0aGF0IEkgd291bGQgcHJlZmVyCj4gdG8gaGF2ZSB0aGUgS2NvbmZpZyBi
aXRzIGJlIGluIHRoZSBwYXRjaGVzIGFkZGluZyB0aGUgY29kZSwgc28gdGhhdCB3ZQo+IGNhbiBh
Y3R1YWxseSBidWlsZC10ZXN0IHRoZW0gYmVmb3JlIDYvNi4KPgo+IEJlZW4gdXBkYXRpbmcgbXkg
bGFiIHRvIDQuMjAtcmNYIHdpdGggc29tZSBoaWNjdXBzLiBCZW4ncwo+IHJlZ21hcF9ub2luY193
cml0ZSBzdXBwb3J0IG1hZGUgaXQgaW50byA0LjIwLCBzbyBJIGV4cGVjdCB0byBoYXZlIEJlbidz
Cj4gcGVuZGluZyBicmFuY2ggZm9yIHN4MTMwMSBtZXJnZWQgaW50byByZWJhc2VkIGxvcmEtbmV4
dCBiZWZvcmUgQ2hyaXN0bWFzCj4gYW5kIG15IHN4MTI3NiBjb252ZXJzaW9uIHRvIGZvbGxvdywg
bGVhdmluZyB0aGUgUEZfUEFDS0VUIHZzLiBQRl9MT1JBCj4gZGlzY3Vzc2lvbiBmcm9tIEVMQ0Ug
LSBoYXZlbid0IGFzc2Vzc2VkIHlldCBob3cgbXVjaCB0aGlzIHNlcmllcyB3b3VsZAo+IGJlIGFm
ZmVjdGVkIGJ5IHRoZSB1bmRlcmx5aW5nIGNoYW5nZXMsIGJ1dCBpZiB0aGUgYWJzdHJhY3Rpb24g
d2FzIGRvbmUKPiByaWdodCB0aGVuIG9ubHkgbWFjbG9yYXdhbiBpbXBsZW1lbnRhdGlvbiBzaG91
bGQgYmUgYWZmZWN0ZWQuCj4KPiBSZWdhcmRzLAo+IEFuZHJlYXMKPgo+IC0tCj4gU1VTRSBMaW51
eCBHbWJILCBNYXhmZWxkc3RyLiA1LCA5MDQwOSBOw7xybmJlcmcsIEdlcm1hbnkKPiBHRjogRmVs
aXggSW1lbmTDtnJmZmVyLCBKYW5lIFNtaXRoYXJkLCBHcmFoYW0gTm9ydG9uCj4gSFJCIDIxMjg0
IChBRyBOw7xybmJlcmcpClJlZ2FyZHMsCgpYdWUgTGl1CgoKLS0KCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBs
aXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5m
cmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
