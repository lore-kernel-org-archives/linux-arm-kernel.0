Return-Path: <SRS0=tR0U=PB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C482CC65BD9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 15:32:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9068B21736
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 15:32:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WKf0OHdY";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=mojatatu-com.20150623.gappssmtp.com header.i=@mojatatu-com.20150623.gappssmtp.com header.b="Pz+zrBkN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9068B21736
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=o6h4mRQERozpMQ8OxnhVZxk5LvPpuyCeZG52JnaEfDA=; b=WKf0OHdYit3od2
	Xa9ZJEaSCrMzMAwIuuuOWIdpaiBqu7AO4nV96Xyx2pnqDh/pHfOTZYd1niq+Ar52s1dLGI1O+h8Y/
	HAsyHA27cuzyUvVVcyGQJe11x7AANNGn8+v0N/gpgqfvCpPL27X/DDoa93IJxAyLYrdO16/5mB/FE
	pEE5nJWyGtJ4XalJg0YxgNa1UxFhftQiv4PgD58zTgeVmtyXYIqnT9BfLbqt2ZmISqH6G8KPjySOV
	7g5IEr7mqfvWzEPDF1BSg/EBCyIyoQhqucNdrL9llZfmJepD/Y5WtJnK8wvmjiYFmQniEzHKZdAGg
	Wt88xwZ4rnuX3750/5oA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gbSDc-000621-Lt; Mon, 24 Dec 2018 15:32:36 +0000
Received: from mail-it1-x141.google.com ([2607:f8b0:4864:20::141])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gbSDM-00060P-Ge
 for linux-arm-kernel@lists.infradead.org; Mon, 24 Dec 2018 15:32:21 +0000
Received: by mail-it1-x141.google.com with SMTP id g76so16180496itg.2
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 24 Dec 2018 07:32:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mojatatu-com.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to
 :user-agent; bh=hcQc4njU3S+o4H6gOXq6XyYcomBr/RPp5eE5oN5qNlg=;
 b=Pz+zrBkNiRIxetJud78i8fm8KjnPxodmWyIygYk2UWDjTLqOZ7Xa2cFJjbUp6H9hhC
 YZld0bcfhsx7Yl/bDNGwbLSLdIojbLSjEif0bk2WylQ1fk2pRRgiOsLLcQMQEBTae2HZ
 iVatpgpP6LXPcNr0fzfkc5uO9DWeWnPhv0TMuPnE6a/yoAuBu1rL6PkBsBWWajLoPwqT
 TLBL8BGQKYnp7CSWumfmwLhj4ng9CrKhvItIDBTLVgnNvqJ1D07XTFsF1HEoY0lhr1K3
 OmvZLM5+JuAGtpwiw2sDk6KnlAT0gsf199sHcS5kSsRqFSH+sXT5MdZ4VYXnQvU6bSpn
 /X7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=hcQc4njU3S+o4H6gOXq6XyYcomBr/RPp5eE5oN5qNlg=;
 b=OMZysa/Q0ddGCwc/dYlwlf2SjPi0Ma9vlZlY3S9SEIvYCBHABuhsskj1Gpm7sbnFHj
 BEJGs4OhhE9nMd30FAGDYNpXOawkxL03cKJOsCvHIoEZyckjlwS4OUCVu5AM/imNbkV8
 o1NSIfKyvE+LDuGpljpm1dT92jSrvqgMBZpXCFNBqrbXK36/iurh44mLFNUW5ngDjJzN
 B0+qchNyl2KWAXqtn1dYrK/1e+WsEkvIgW5x9i2eX7iRDBOLFSO0/eyq2srSyk2TdOGg
 kmWhiMlS/GTHvlBoswBxo9DAP6KLK7jWokYAm724DFopndFtGGWHPLAn3xt/0/JrT5Ux
 W0rg==
X-Gm-Message-State: AA+aEWaUOMH00d/ZT1g5glT3/mpCKJU+DsWGMH9Er2KANEzqvmkZp1Yc
 MYUGpmmzVi5y6XuOs3d7THAXVQ==
X-Google-Smtp-Source: AFSGD/UJxNItKX+WMvijj4yYoHXYsp5ZHgB6W7TmS43iHP4K8IQ/Ek7Gfjl7V2oPs05PoKmFm/RugQ==
X-Received: by 2002:a24:6fc4:: with SMTP id x187mr9931961itb.93.1545665528818; 
 Mon, 24 Dec 2018 07:32:08 -0800 (PST)
Received: from x220t ([64.26.149.125])
 by smtp.gmail.com with ESMTPSA id w129sm11502194ita.0.2018.12.24.07.32.07
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 24 Dec 2018 07:32:08 -0800 (PST)
Date: Mon, 24 Dec 2018 10:32:05 -0500
From: Alexander Aring <aring@mojatatu.com>
To: Xue Liu <liuxuenetmail@gmail.com>
Subject: Re: [PATCH v5 6/6] net: lorawan: List LORAWAN in menuconfig
Message-ID: <20181224153205.ycr2zdrjbyklulfh@x220t>
References: <CAC=mGziyi1ierhg++SUcHMrq1JQ0vH4gZCKUZgchzb8aD1Rv5Q@mail.gmail.com>
 <20181216101858.9585-7-starnight@g.ncu.edu.tw>
 <CAJuUDwtS3c7NhcNqijyFNtZeupO2HLQ8ZuMA1a-azEQL5yHjng@mail.gmail.com>
 <8bfdccbf-fb47-daa5-fbd0-ed16a3d6d334@suse.de>
 <CAJuUDwsypFMEbTXZO+NwQ_FnD1wsO3ZRc3dthZphFGJ-u0n_=Q@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAJuUDwsypFMEbTXZO+NwQ_FnD1wsO3ZRc3dthZphFGJ-u0n_=Q@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181224_073220_558173_58605823 
X-CRM114-Status: GOOD (  14.83  )
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
Cc: Alan Cox <gnomes@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>,
 Dollar Chen <dollar.chen@wtmec.com>, linux-lpwan@lists.infradead.org,
 "David S . Miller" <davem@davemloft.net>,
 Jian-Hong Pan <starnight@g.ncu.edu.tw>, Ken Yu <ken.yu@rakwireless.com>,
 linux-wpan - ML <linux-wpan@vger.kernel.org>,
 Andreas =?utf-8?Q?F=C3=A4rber?= <afaerber@suse.de>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGksCgpPbiBUdWUsIERlYyAxOCwgMjAxOCBhdCAwMjo1MDo1OFBNICswMTAwLCBYdWUgTGl1IHdy
b3RlOgo+IEhlbGxvIEFuZHJlYXMsCj4gCj4gT24gTW9uLCAxNyBEZWMgMjAxOCBhdCAxNToxOSwg
QW5kcmVhcyBGw6RyYmVyIDxhZmFlcmJlckBzdXNlLmRlPiB3cm90ZToKPiA+Cj4gPiBIZWxsbyBY
dWUgTGl1LAo+ID4KPiA+IEFtIDE3LjEyLjE4IHVtIDA5OjUwIHNjaHJpZWIgWHVlIExpdToKPiA+
ID4gSSBoYXZlIGEgcXVlc3Rpb24gYWJvdXQgdGhlIGFyY2hpdGVjdHVyZSBvZiB5b3VyIG1vZHVs
ZS4gQUZBSUsgTG9SYVdBTgo+ID4gPiBpcyBhbHJlYWR5IHRoZSBNQUMgTGF5ZXIgYWJvdmUgdGhl
IExvUmEgdGVjaG5vbG9neS4gV2h5IGRvIHlvdSB3YW50IHRvCj4gPiA+IG1ha2UgYSBuZXcgbGF5
ZXIgY2FsbGVkICJtYWNsb3Jhd2FuIiA/Cj4gPgo+ID4gSSBoYWQgYXNrZWQgSmlhbi1Ib25nIHRv
IHNlcGFyYXRlIGJldHdlZW4gaGlzIHNvZnQtTUFDIGltcGxlbWVudGF0aW9uCj4gPiBhbmQgdGhl
IGNvbW1vbiBiaXRzIG5lZWRlZCB0byBkcml2ZSBoYXJkLU1BQyBpbXBsZW1lbnRhdGlvbnMgZm91
bmQgb24KPiA+IHNldmVyYWwgb2YgdGhlIGhhcmR3YXJlIG1vZHVsZXMgbWFkZSBhdmFpbGFibGUg
dG8gbWUuCj4gPgo+IEFzIGEgcmVmZXJlbmNlIExpbnV4IDgwMi4xMSB1c2VzIGNmZzgwMjExIHRv
IHRhbGsgd2l0aCBoYXJkLU1BQyBkZXZpY2VzLgo+IFdlIG1heSBhbHNvIHVzZSB0aGUgbmFtZSDi
gJxjZmdsb3Jh4oCdIGZvciBoYXJkLU1BQyBpbXBsZW1lbnRhdGlvbi4KPiAKClRoZXJlIGV4aXN0
cyBhbHNvIGEgY2ZnODAyMTU0LiA6LSkKCk5vdGUgdGhhdCBjZmc4MDIxMSBpcyBhbHNvIGZvciBw
cm92aWRpbmcgYSBiYWNrd2FyZHNjb21wYXRpYmlsaXR5IHRvIHRoZQp3aXJlbGVzcyBpb2N0bCgp
IGludGVyZmFjZS4KCkluIHRoZW9yeSBpdCdzIHNpbXBsZToKCm5ldGxpbmsgQVBJIC0+IFNvZnRN
QUMgKG1hY0ZPT0JBUiBsYXllcikgLT4gY2ZnRk9PQkFSIGltcGxlbWVudGF0aW9uIC0+IGRyaXZl
ciBsYXllcgogICAgICAgICAgICBcLT4gSGFyZE1BQyAoZHJpdmVyIGxheWVyKSAtPiBjZmdGT09C
QVIgaW1wbGVtZW50YXRpb24KClRoZSAiZGlmZmljdWx0IiBwYXJ0IGlzIHByb3ZpZGluZyBvbmUg
dXNlcnNwYWNlIGludGVyZmFjZSBmb3IgYm90aAplaXRoZXIgU29mdE1BQyBsYXllciBhbmQgYWxs
IEhhcmRNQUMgZHJpdmVycy4KClRoZXJlIGJvdGggbWFpbnRhaW5lcnMgbmVlZCB0byBiZSBzeW5j
aHJvbml6ZWQuCgpBcyBhIHNpZGUgbm90ZSBJIHdhbnQgdG8gbWVudGlvbiB0aGF0IHRoZSA4MDIu
MTUuNCBzdWJzeXN0ZW0gc3VwcG9ydHMKY3VycmVudGx5IGEgSGFyZE1BQyB0cmFuc2NlaXZlciBp
biB0aGUgU29mdE1BQyBsYXllci4gV2UgZG9uJ3QgaGF2ZQpxdWl0ZSBIYXJkTUFDIHN1cHBvcnQg
eWV0IGJ1dCBhcmUgc29tZWhvdyBwcmVwYXJlZCBhY2NvcmRpbmcgdGhlCndpcmVsZXNzIGFyY2hp
dGVjdHVyZSBhYm92ZS4KClRoZSBwZW9wbGUgd2hvIGRpZCB0aGF0IGRpZG4ndCB3YW50ZWQgdG8g
aW52ZXN0aWdhdGUgdGltZSB0byBpbXBsZW1lbnQgYQp3aG9sZSBIYXJkTUFDIGxheWVyLCBhcyBJ
IHRvbGQgdGhlbSB3aGVuIHdlIHN1cHBvcnQgbW9yZSBpbiB0aGUgU29mdE1BQwpsYXllciBpdCB3
aWxsIGJyZWFrIHRoZWlyIHRyYW5zY2VpdmVyLi4uIHNvIHRoZXkgd2FzIGZpbmUgd2l0aCB0aGF0
IGFzCndhcm5pbmcgaXQgc2VlbXMuIDotKQoKLSBBbGV4CgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdAps
aW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVh
ZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
