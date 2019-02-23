Return-Path: <SRS0=s0b7=Q6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDD2CC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 13:15:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0B662084F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 13:15:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LMSfDWA6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0B662084F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=martin.sperl.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:References:Message-Id:Date:
	In-Reply-To:From:Subject:Mime-Version:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=de1Iggl2LZ5M8QvbZCX6Xvno23Lwk6mpKyjILoxQbWM=; b=LMSfDWA6uXHtxN
	DMWxjxrIIe4QtLuXmfPvCgitVSC+vI5eQ0+NnamfstWAQxtxGEupIjjEZfHZJ1kANm1tYCcYNn/00
	RfdXpQiDA3QySbPMpU4ONEZRxQsl+iLY48ky7wm+oBgZYRdeXtHJdu1b2+PCX0szAX2HFXG4VzrHo
	pcw6cYi+mKvZnzs9bN38yFzpJzJjocwRcKEdPyVA/6kwgVIA1DBYknJrydnT0kQFmWTwxoO2xAJKG
	11Ipn8MN+7lwKjcXd9ZQeGe6JPgaKHyTKUbToRyn1flpO4hKdUX4QGBgacJNxeSILWC5ZrHU2amX1
	/Ad0qWUxoTq2as75kbeQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gxX9b-00005z-BZ; Sat, 23 Feb 2019 13:15:43 +0000
Received: from 212-186-180-163.static.upcbusiness.at ([212.186.180.163]
 helo=cgate.sperl.org)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gxX9A-0007zX-4n; Sat, 23 Feb 2019 13:15:21 +0000
Received: from msmac.intern.sperl.org (account martin@sperl.org [10.10.10.11]
 verified) by sperl.org (CommuniGate Pro SMTP 6.2.1 _community_)
 with ESMTPSA id 7757532; Sat, 23 Feb 2019 13:15:10 +0000
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH 3/5] spi: core: allow defining time that cs is deasserted
 as a multiple of SCK
From: kernel@martin.sperl.org
In-Reply-To: <20190223124010.y7lsncknnxoblvgz@wunner.de>
Date: Sat, 23 Feb 2019 14:15:13 +0100
Message-Id: <CCC6392E-3189-49BE-B04D-3997434184D0@martin.sperl.org>
References: <20190223084952.14758-1-kernel@martin.sperl.org>
 <20190223084952.14758-4-kernel@martin.sperl.org>
 <20190223124010.y7lsncknnxoblvgz@wunner.de>
To: Lukas Wunner <lukas@wunner.de>
X-Mailer: Apple Mail (2.3124)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190223_051516_791652_4C1097CF 
X-CRM114-Status: UNSURE (   9.24  )
X-CRM114-Notice: Please train this message.
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
Cc: Stefan Wahren <stefan.wahren@i2se.com>,
 linux-spi <linux-spi@vger.kernel.org>, Eric Anholt <eric@anholt.net>,
 Mark Brown <broonie@kernel.org>, linux-rpi-kernel@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGkgTHVrYXMhCgo+IE9uIDIzLjAyLjIwMTksIGF0IDEzOjQwLCBMdWthcyBXdW5uZXIgPGx1a2Fz
QHd1bm5lci5kZT4gd3JvdGU6Cj4gCj4gT24gU2F0LCBGZWIgMjMsIDIwMTkgYXQgMDg6NDk6NTBB
TSArMDAwMCwga2VybmVsQG1hcnRpbi5zcGVybC5vcmcgd3JvdGU6Cj4+IFN1cHBvcnQgc2V0dGlu
ZyBhIGRlbGF5IGJldHdlZW4gY3MgYXNzZXJ0IGFuZCBkZWFzc2VydCBhcwo+PiBhIG11bHRpcGxl
IG9mIHNwaSBjbG9jayBsZW5ndGguCj4gCj4gVG8gd2hhdCBlbmQ/Ci4uLgo+IAo+IFRoZSBhYmls
aXR5IHRvIGRlZmluZSBhIHVuaXQgc2VlbXMgc29tZXdoYXQgb3Zlci1lbmdpbmVlcmVkIHRvIG1l
Lgo+IFlvdSdyZSBpbnRyb2R1Y2luZyBsb3RzIG9mIGJyYW5jaGluZyBhbmQgaW50ZWdlciBkaXZp
c2lvbnMgKGJvdGgKPiBjb21wYXJhdGl2ZWx5IGV4cGVuc2l2ZSBvcGVyYXRpb25zKSB3aGljaCBh
cmUgZXhlY3V0ZWQgZm9yIGV2ZXJ5Cj4gc2luZ2xlIHRyYW5zZmVyIChpLmUuIGluIGEgaG90IHBh
dGgpLiAgSSdkIHJlY29tbWVuZCBzdGFuZGFyZGl6aW5nCj4gb24gYSBzaW5nbGUgdW5pdC4gIElm
IDEgdXNlYyBpcyB0b28gY29hcnNlLWdyYWluZWQgZm9yIHlvdXIgdXNlIGNhc2UsCj4gY29udmVy
dCBldmVyeXRoaW5nIHRvIG5zZWMuCgpXZWxsIC0gYSBzcGlfZGV2aWNlIGRyaXZlciBkb2VzIG5v
dCBhY3R1YWxseSBrbm93IHdoYXQgaXMgdGhlCmFjdHVhbCBzcGkgY2xvY2sgY29uZmlndXJlZC91
c2VkIGJ5IHRoZSBzcGktYnVzLWRyaXZlci4KCkFsbCBpdCBrbm93cyBpcyB0aGF0IHRoZSBkZXZp
Y2UgcmVxdWlyZXMgWCBjbG9jayBjeWNsZXMgb2YgY3MgaGlnaC4KU28gaG93IHdvdWxkIHlvdSBk
ZWZpbmUgdGhhdCBzbyB0aGF0IGlzIHZhbGlkIGZvciBhbGwgY2FzZXMgd2l0aG91dApyZXBsaWNh
dGluZyBjb2RlIGluIGV2ZXJ5IGRyaXZlciB0aGF0IG5lZWRzIGl0IChldmVyeXdoZXJlIHNsaWdo
dGx5CmRpZmZlcmVudGx5KT8KCkFzIGZvciBob3QtcGF0aDogd2UgYXJlIG5vdCBpbiB0aGUgaG90
IHBhdGggLSB3ZSBuZWVkIHRvIHdhc3RlIHRpbWUKd2hlbiBhbnkgb2YgdGhvc2UgcGFyYW1ldGVy
cyBhcmUgc2V0IQoKY3NfY2hhbmdlIGlzIG5vdCB0aGF0IGNvbW1vbmx5IHVzZWQgLSBvciBjc19k
ZWxheV91c2VjIGZvciB0aGF0IG1hdHRlci4KClRoZSBjb3JyZXNwb25kaW5nIGlmcyBpbnQgdGhl
IGhvdCBwYXRoIGFyZSBpbiB0aGUgY29kZSByaWdodCBub3cgLSAKd29yc3RlZCBjYXNlIHdlIGFy
ZSBqdW1waW5nIGEgZmV3IG1vcmUgY3B1IGluc3RydWN0aW9ucyBmdXJ0aGVyIHRoYW4gd2UKd291
bGQgcmlnaHQgbm93LgoKQWxzbyB0aGUgY29kZSBoYXMgYmVlbiBtb3ZlZCBpbnRvIGEgc2VwYXJh
dGUgZnVuY3Rpb24gYW5kIHNvbWUgb2YgaXQKaXMgdXNlZCBmcm9tIG11bHRpcGxlIGxvY2F0aW9u
cy4KClRodXMgaXQgaXMgdXAgdG8gdGhlIGNvbXBpbGVyIHRvIGtub3cgYmVzdCBpZiBpdCBpcyB3
b3J0aCBpbmxpbmluZyB0aGUgCmZ1bmN0aW9uIG9yIGp1c3QgY2FsbGluZyBpdC4KCkZyb20gYSBD
UFUgdXRpbGl6YXRpb24gcGVyc3BlY3RpdmU6IGZvciBtb3N0IHNpdHVhdGlvbnMgd2Ugd2lsbAoo
bW9zdCBsaWtlbHkpIGJlIGJ1c3kgd2FpdGluZyB0byBwYXNzIHRoZSByZXF1aXJlZCB0aW1lIGFu
eXdheS4KU28gdGhvc2UgZGl2aWRlcyBhcmUganVzdCB0YWtpbmcgdGltZSBmcm9tIHRob3NlIGJ1
c3kgY3ljbGVz4oCmCgpGaW5hbGx5IGlmIHRoZSBjb21wdXRhdGlvbiB5aWVsZHMgYSBzaG9ydGVy
IHZhbHVlIHRoYW4gYSAoY29uc2VydmF0aXZlKQp0aW1lLXZhbHVlIHRoYXQgd291bGQgaGF2ZSBi
ZWVuIGdpdmVuIGluc3RlYWQsIHRoZW4gdGhvc2UgY29tcHV0YXRpb25zCihkaXZpZGVzKSAgaGF2
ZSBoZWxwZWQgc2F2ZSBjcHUgY3ljbGVzIGFuZCBTUEkgYnVzIGJhbmR3aWR0aCwgc28gdGhleQph
cmUgYmVuZWZpY2lhbC4KCkFzIGZvciB0aGUgcnBpLW1haWxpbmctbGlzdDogaWYgdGhpcyBpcyBh
biBpc3N1ZSwgdGhlbiB0aGlzIGlzIGEKc2VwYXJhdGUgaXNzdWUgdGhhdCBuZWVkcyB0byBnZXQg
YWRkcmVzc2VkIHNlcGFyYXRlbHkgYXMgaXQgaXMgbm90CnJlYWxseSBjb2RlLXJlbGF0ZWQuCgpN
YXJ0aW4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGlu
dXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRl
YWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgt
YXJtLWtlcm5lbAo=
