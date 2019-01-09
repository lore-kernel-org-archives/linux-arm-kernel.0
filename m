Return-Path: <SRS0=Odjb=PR=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49052C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 20:51:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14A482075C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 20:51:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="eRZjuIVU";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZaEuS2h6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14A482075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=eJLN1nnBROJEDabixMQ+is+f4q5nn9w361P1l05CRXA=; b=eRZjuIVUJCblGmjr/N++oQTmB
	DM184XeNzPF8lgPTvVvKYGWclFD4kNej6oOEHpjjhehMAXWj12lPlZ/b9s7/a6NCy/V1eLhNXaGeJ
	Jp99RO2R8VcGb3kNLUQCe3pmdBhnsVDEcYyLKxa8KJjcL1RDXOJ4/+D3DEzLvWxZ6PTxM+05q09UR
	PVG03tnxURB3osU3JiWIi/NZc12TpnwwLzRIX10hXJRJzwLtYzGd9qr1zWJPVW48ksF9Za9l82omc
	PPCpzAjhNJqWfP0sJ8OvM/ujnwhY6RjEIqJm2fNz5jOdWoKcQ/49ztqNvduWzRXXF0DBBMfGEBAI9
	q9WzwGpbw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghKoV-0006QR-9M; Wed, 09 Jan 2019 20:50:59 +0000
Received: from mail-lf1-x142.google.com ([2a00:1450:4864:20::142])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghKoN-0006PY-Tz
 for linux-arm-kernel@lists.infradead.org; Wed, 09 Jan 2019 20:50:58 +0000
Received: by mail-lf1-x142.google.com with SMTP id n18so6697254lfh.6
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 09 Jan 2019 12:50:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=B42gs8Y3HgVHs+5T0aoIuishxfjjrxk1B5kiRgNNK0A=;
 b=ZaEuS2h6aAzWZUhyZGtuHYMxWM2IR/3aPP/mXJgGz9Mof5VOWdbmdu4ooWc7lpieqi
 GP79IUQjXd4I48tXilbh32g+03ufwIoscYAv+3GyD/fLnvoNfcWkwoREJSDxzDvvpxO7
 YJ1RN6NQLhPRIttZ091xuKCPWZ65gYVRwP5Aet6uePpXCEuhyWMQZFYLd8LbNY4UyDD9
 IUwfdaN1/7eeXsehtqPoWloKCT1D2TEhTtktl2irNaS/uZvSEkuCunbZdgxba8+JBEsi
 5meg3K5AjwMv2AJQXI9WwFr1y2/TgZY6cZLdVuAOUA+tzBUU0JwdU4J5HLlUsRN0tYGs
 U17g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=B42gs8Y3HgVHs+5T0aoIuishxfjjrxk1B5kiRgNNK0A=;
 b=eQRHPFRFo572Vlm6kg2FWnR93eLxbk9sJrkyiiQ5cZlMlFMPRwU9bUlLfggpo/+3/0
 olCV2gvR/mlGQhWcmHRX6bB1B1cdYkRs8qhwvQGlMAV16FnU10gMedV4/pfDdDteqyf7
 p8S5tG+vH+8O47Z0h7vdnnyQh0B8+mC3vWHUfZIQneoG8gE4b4CQSd+cbz2Wt8wShEUW
 4KsKttR4O0rh4fGHk6ntw8KbeBBQVc1XZ2vADPZyOJWOJPjWIqhEC+ad/zrfJpO74OXw
 00s4TYc99p1aZnkaIJPDZTixjYaT4/qQ5DPpaD4JPZvBk86lJpgTELcqlKXiZJacna8V
 RHDw==
X-Gm-Message-State: AJcUukfxFYQvIlLEOAWXGw/B064M+SJKtWbQ6Ud7LxlhlFGm31V0Kj1S
 pEO711lK6nAusmn3oD3nAUg=
X-Google-Smtp-Source: ALg8bN4jWDbiVaQ6UqbalhDJl1H+6XAAhUcEYZ3FZ3nQCka3PW5vTUwBHXPvuJ1oO20kQNMfHDC3fg==
X-Received: by 2002:a19:1994:: with SMTP id 142mr4590396lfz.134.1547067049570; 
 Wed, 09 Jan 2019 12:50:49 -0800 (PST)
Received: from [192.168.1.18] (chc231.neoplus.adsl.tpnet.pl. [83.31.0.231])
 by smtp.gmail.com with ESMTPSA id t18sm13710341lft.93.2019.01.09.12.50.47
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 09 Jan 2019 12:50:48 -0800 (PST)
Subject: Re: [PATCH] media: s5p-jpeg: Correct step and max values for
 V4L2_CID_JPEG_RESTART_INTERVAL
To: =?UTF-8?Q?Pawe=c5=82_Chmiel?= <pawel.mikolaj.chmiel@gmail.com>,
 andrzej.p@samsung.com
References: <20190109180041.31052-1-pawel.mikolaj.chmiel@gmail.com>
From: Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <843c632a-0804-8a30-0002-a87b85de1ed3@gmail.com>
Date: Wed, 9 Jan 2019 21:50:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190109180041.31052-1-pawel.mikolaj.chmiel@gmail.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190109_125052_017741_C7ADD74D 
X-CRM114-Status: GOOD (  18.62  )
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
Cc: linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
 s.nawrocki@samsung.com, mchehab@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGkgUGF3ZcWCLAoKVGhhbmsgeW91IGZvciB0aGUgcGF0Y2guCgpPbiAxLzkvMTkgNzowMCBQTSwg
UGF3ZcWCIENobWllbCB3cm90ZToKPiBUaGlzIGNvbW1pdCBjb3JyZWN0cyBtYXggYW5kIHN0ZXAg
dmFsdWVzIGZvciB2NGwyIGNvbnRyb2wgZm9yCj4gVjRMMl9DSURfSlBFR19SRVNUQVJUX0lOVEVS
VkFMLiBNYXggc2hvdWxkIGJlIDB4ZmZmZiBhbmQgc3RlcCBzaG91bGQgYmUgMS4KPiBJdCB3YXMg
Zm91bmQgYnkgdXNpbmcgdjRsMi1jb21wbGlhbmNlIHRvb2wgYW5kIGNoZWNraW5nIHJlc3VsdCBv
Zgo+IFZJRElPQ19RVUVSWV9FWFRfQ1RSTC9RVUVSWU1FTlUgdGVzdC4KPiBQcmV2aW91c2x5IGl0
IHdhcyBjb21wbGFpbmluZyB0aGF0IHN0ZXAgd2FzIGJpZ2dlciB0aGFuIGRpZmZlcmVuY2UKPiBi
ZXR3ZWVuIG1heCBhbmQgbWluLgo+IAo+IEZpeGVzOiAxNWY0YmMzYjFmNDIgKCJbbWVkaWFdIHM1
cC1qcGVnOiBBZGQgSlBFRyBjb250cm9scyBzdXBwb3J0IikKPiBTaWduZWQtb2ZmLWJ5OiBQYXdl
xYIgQ2htaWVsIDxwYXdlbC5taWtvbGFqLmNobWllbEBnbWFpbC5jb20+Cj4gLS0tCj4gICBkcml2
ZXJzL21lZGlhL3BsYXRmb3JtL3M1cC1qcGVnL2pwZWctY29yZS5jIHwgMiArLQo+ICAgMSBmaWxl
IGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCj4gCj4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvbWVkaWEvcGxhdGZvcm0vczVwLWpwZWcvanBlZy1jb3JlLmMgYi9kcml2ZXJzL21l
ZGlhL3BsYXRmb3JtL3M1cC1qcGVnL2pwZWctY29yZS5jCj4gaW5kZXggM2Y5MDAwYjcwMzg1Li4z
M2U5OTI3ZGI5YTAgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9zNXAtanBl
Zy9qcGVnLWNvcmUuYwo+ICsrKyBiL2RyaXZlcnMvbWVkaWEvcGxhdGZvcm0vczVwLWpwZWcvanBl
Zy1jb3JlLmMKPiBAQCAtMjAwMiw3ICsyMDAyLDcgQEAgc3RhdGljIGludCBzNXBfanBlZ19jb250
cm9sc19jcmVhdGUoc3RydWN0IHM1cF9qcGVnX2N0eCAqY3R4KQo+ICAgCj4gICAJCXY0bDJfY3Ry
bF9uZXdfc3RkKCZjdHgtPmN0cmxfaGFuZGxlciwgJnM1cF9qcGVnX2N0cmxfb3BzLAo+ICAgCQkJ
CSAgVjRMMl9DSURfSlBFR19SRVNUQVJUX0lOVEVSVkFMLAo+IC0JCQkJICAwLCAzLCAweGZmZmYs
IDApOwo+ICsJCQkJICAwLCAweGZmZmYsIDEsIDApOwo+ICAgCQlpZiAoY3R4LT5qcGVnLT52YXJp
YW50LT52ZXJzaW9uID09IFNKUEVHX1M1UCkKPiAgIAkJCW1hc2sgPSB+MHgwNjsgLyogNDIyLCA0
MjAgKi8KPiAgIAl9Cj4gCgpSZXZpZXdlZC1ieTogSmFjZWsgQW5hc3pld3NraSA8amFjZWsuYW5h
c3pld3NraUBnbWFpbC5jb20+CgotLSAKQmVzdCByZWdhcmRzLApKYWNlayBBbmFzemV3c2tpCgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0t
a2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcK
aHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2Vy
bmVsCg==
