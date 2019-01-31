Return-Path: <SRS0=sKCI=QH=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3E33C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 16:48:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A45AB2086C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 16:48:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="YIImy4j8";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="yjuOVFpu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A45AB2086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:References
	:In-Reply-To:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=r2IKIXdLvEyV5EcdC44Su1ccTebYavOy3z1PlInyiAA=; b=YIImy4j8FxH6Cf
	GkOVApbUmm+vxPjNZ8csyYVq8Z7Dsehis7jGAlbyqSGMtapbGKxHl8oxILAYAZFy9e6BxZ3lC99LA
	DpUUgfQt6PgLziouZNYWaFjjOwxQ8HfZ3ddIrqVCKW58jkmRy5iLcxTpkm1dewKPuAdDLspOxCPER
	0zMdC8mS3+f8vEFCh446x4Fwe0LQCveJXBDnHg3u1p3SyDXLdVa0BxcikwZcGZzPfkFhOsgim6G6g
	DxqVPGpxn0EJNxL0fTtfDnt+K7sPKlRiCDxGWN58YzH/YhCgY86oJ0pYUhSufNZBlzLO6RtBI1o/3
	MznKsRUhKd/QbTiV+I1A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpFVk-0005hp-2G; Thu, 31 Jan 2019 16:48:20 +0000
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpFVf-0005gP-QD
 for linux-arm-kernel@lists.infradead.org; Thu, 31 Jan 2019 16:48:17 +0000
Received: by mail-wm1-x341.google.com with SMTP id y185so2556312wmd.1
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 31 Jan 2019 08:48:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:in-reply-to:references:date:message-id
 :mime-version:content-transfer-encoding;
 bh=St8zuU//Y2lTz8gY3eS0j/qeO26x6PaiuwoJ8bnTe7s=;
 b=yjuOVFpuad+EqiI4rLPRACfvPCLiOyTUa+o4Q6LE5VQMCrsPf4cAY9TUJ2VTYia8wY
 dLStEZ5O7Dsc6KKvdf9sTbRZTIn/+EqL9f/HHn3+2MN41eu57ZIdUMWEqDBtzfz9a5P+
 5BXanAUVXv7zsLhvir983UzLETrCaAKUHbf42MDE+301thn/oWVmavRoQ+bkLJOftSHD
 jS057pT/zF6VHmWtlVqXu5BHUe2jV0pbz8MeNZeoEQSlHqO/ng6XmqX73NK/qOB3RdlM
 2kvr5EBY7yUdtZF02gLAhnDcFb6FjobUtd3cmC8lF4IJ9r0drVV9aEnl95Siw8bp5zdl
 ZL/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
 :message-id:mime-version:content-transfer-encoding;
 bh=St8zuU//Y2lTz8gY3eS0j/qeO26x6PaiuwoJ8bnTe7s=;
 b=oLdwhZPhPG2RzxJJ1guCzrFSyovPtj7qVDix2/PgYia6epjOvE6Ctq77HBA+TsXS7V
 a2s4pZyQejoZRzdsE+4QJvCC8GM0Ksv+KjX1xYwN85qXdnjIhLvzwAueCaqbsSsbGhnH
 7XnFw7DwGlREcU91LKTpPnoTaSaYxBCqshK/lIoso+lsNM2Jau1zEzAA5+c//gxSkHQ8
 HycY21GKGTC7zzpYph9XpWtwc0C3WRGRQqVrA5eI0sQgzGxnIWCEp5e4RVlJPyEo3SVS
 Ut9qyE/z9enlCFD1a4RiPv6LO2twz7JGD4aHN1Wx1ssYjf+kvYhWK/7LLds3QnNCNW8l
 JLEg==
X-Gm-Message-State: AJcUukfSamZMcwztveMs1JGWEdKtFSl+E60z9h00sX6XDo5gpDmoLjvn
 r1OI6w9CNXgxdcISKoThRnZe8w==
X-Google-Smtp-Source: ALg8bN4Q4OebNS0Sso2hbFOC2m2ao1xWqTMbEabDKefeslcpRy6Hrgx1DlawdcYfdnQfLU4eP9rbdg==
X-Received: by 2002:a1c:8484:: with SMTP id
 g126mr31634075wmd.117.1548953293352; 
 Thu, 31 Jan 2019 08:48:13 -0800 (PST)
Received: from localhost (aputeaux-684-1-8-223.w90-86.abo.wanadoo.fr.
 [90.86.125.223])
 by smtp.googlemail.com with ESMTPSA id g67sm12654800wmd.38.2019.01.31.08.48.12
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 31 Jan 2019 08:48:12 -0800 (PST)
From: Kevin Hilman <khilman@baylibre.com>
To: Chris Moore <moore@free.fr>, linux-amlogic@lists.infradead.org
Subject: Re: [PATCH v2 1/2] dt-bindings: arm: amlogic: add amediatech x96-max
 bindings
In-Reply-To: <dc14926f-4433-fa7b-311f-cb275a7e7aee@free.fr>
References: <20181219233519.35287-1-khilman@baylibre.com>
 <dc14926f-4433-fa7b-311f-cb275a7e7aee@free.fr>
Date: Thu, 31 Jan 2019 17:48:11 +0100
Message-ID: <7h8sz0hiyc.fsf@baylibre.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190131_084815_859751_03BB05CA 
X-CRM114-Status: GOOD (  11.39  )
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
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Q2hyaXMgTW9vcmUgPG1vb3JlQGZyZWUuZnI+IHdyaXRlczoKCj4gSGksCj4KPiBTb3JyeSBmb3Ig
dGhlIHJlcGVhdCA6IEkgcmVwbGllZCBwcmV2aW91c2x5IHRvIHYxIGFzIEkgaGFkbid0IG5vdGlj
ZWQgCj4gdGhhdCB0aGVyZSB3YXMgYWxyZWFkeSBhIHYyLgo+Cj4gTGUgMjAvMTIvMjAxOCDDoCAw
MDozNSwgS2V2aW4gSGlsbWFuIGEgw6ljcml0wqA6Cj4+IEFkZCBuZXcgdmVuZG9yIGZvciBhbWVk
aWF0ZWNoLCBhbmQgaW5pdGlhbCBib2FyZDogeDk2LW1heAo+Pgo+PiBTaWduZWQtb2ZmLWJ5OiBL
ZXZpbiBIaWxtYW4gPGtoaWxtYW5AYmF5bGlicmUuY29tPgo+PiAtLS0KPj4gICBEb2N1bWVudGF0
aW9uL2RldmljZXRyZWUvYmluZGluZ3MvYXJtL2FtbG9naWMudHh0ICAgICB8IDEgKwo+PiAgIERv
Y3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy92ZW5kb3ItcHJlZml4ZXMudHh0IHwgMSAr
Cj4+ICAgMiBmaWxlcyBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKykKPj4KPj4gZGlmZiAtLWdpdCBh
L0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0vYW1sb2dpYy50eHQgYi9Eb2N1
bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvYXJtL2FtbG9naWMudHh0Cj4+IGluZGV4IDhk
YmMyNTkwODFlNC4uYzUwYjA4NGI2YzU5IDEwMDY0NAo+PiAtLS0gYS9Eb2N1bWVudGF0aW9uL2Rl
dmljZXRyZWUvYmluZGluZ3MvYXJtL2FtbG9naWMudHh0Cj4+ICsrKyBiL0RvY3VtZW50YXRpb24v
ZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0vYW1sb2dpYy50eHQKPj4gQEAgLTk5LDYgKzk5LDcgQEAg
Qm9hcmQgY29tcGF0aWJsZSB2YWx1ZXMgKGFscGhhYmV0aWNhbGx5LCBncm91cGVkIGJ5IFNvQyk6
Cj4+ICAgICAtICJhbWxvZ2ljLHAyODEiIChNZXNvbiBneGwgczkwNXcpCj4+ICAgICAtICJvcmFu
dGgsdHgzLW1pbmkiIChNZXNvbiBneGwgczkwNXcpCj4+ICAgCj4+ICsgIC0gImFtZWRpYXRlY2gs
eDk2LW1heCIgKE1lc29uIGd4bSBzOTEyKQo+Cj4gU2hvdWxkbid0IHRoYXQgYmUgTWVzb24gZzEy
YSBzOTA1eDIgPwoKWWVzIGluZGVlZC4KCktldmluCgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51
eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5v
cmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
