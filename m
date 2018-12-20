Return-Path: <SRS0=AHqO=O5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E11D2C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 05:38:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AAFB821741
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 05:38:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="r/nXdXoD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAFB821741
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=free.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=+uK02i3EjkIxq/KUUbHmKKmpn6nr9JSrI10CAJrFKZI=; b=r/nXdXoDMWjkABr6GXQdRbTXj
	+LxvqzffiHU3+xH5vjW8hQfoVtomvLjh2j7g842DBkMmIZCpl7r948Dm6n3CpJVebc0N9PZcxQkZL
	E8ePQdHxD+9QEuK4zlqFdMP5ZM5QtamPs5Zpg+tAtZzziP+lF/xcTUCKYVLakYpV54P0qjt5aegbq
	4sELJLKsUheV+JVIa6p2ILQ+qKsAOmjgD73W60wt3CQQwsIbOlbscLCumckajC+MGlBKIq3rzhTHp
	l/PyARZUkdGn+jkFw5cAbUuoEhcNtlOJ3lCgdiHv4cWo8SuiKZEO6yQqTaJ7HrZmi0OvZS/rHm7F+
	sRBIjN6sw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZr2o-0007CQ-8I; Thu, 20 Dec 2018 05:38:50 +0000
Received: from smtp4-g21.free.fr ([212.27.42.4])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZr2k-0007BL-La; Thu, 20 Dec 2018 05:38:48 +0000
Received: from [192.168.2.7] (unknown [78.218.214.33])
 by smtp4-g21.free.fr (Postfix) with ESMTP id B948B19F58A;
 Thu, 20 Dec 2018 06:38:28 +0100 (CET)
Subject: Re: [PATCH 1/2] dt-bindings: arm: amlogic: add amediatech x96-max
 bindings
To: Kevin Hilman <khilman@baylibre.com>, linux-amlogic@lists.infradead.org
References: <20181219002620.12138-1-khilman@baylibre.com>
From: Chris Moore <moore@free.fr>
Message-ID: <7584b0db-573e-fef8-b5c7-2e02cc5bd780@free.fr>
Date: Thu, 20 Dec 2018 06:38:25 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <20181219002620.12138-1-khilman@baylibre.com>
Content-Language: fr
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181219_213846_848388_9A5D77AD 
X-CRM114-Status: GOOD (  11.24  )
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGksCgpMZSAxOS8xMi8yMDE4IMOgIDAxOjI2LCBLZXZpbiBIaWxtYW4gYSDDqWNyaXTCoDoKPiBB
ZGQgbmV3IHZlbmRvciBmb3IgYW1lZGlhdGVjaCwgYW5kIGluaXRpYWwgYm9hcmQ6IHg5Ni1tYXgK
Pgo+IFNpZ25lZC1vZmYtYnk6IEtldmluIEhpbG1hbiA8a2hpbG1hbkBiYXlsaWJyZS5jb20+Cj4g
LS0tCj4gICBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvYXJtL2FtbG9naWMudHh0
ICAgICB8IDEgKwo+ICAgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3ZlbmRvci1w
cmVmaXhlcy50eHQgfCAxICsKPiAgIDIgZmlsZXMgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspCj4K
PiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2FybS9hbWxv
Z2ljLnR4dCBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0vYW1sb2dpYy50
eHQKPiBpbmRleCA4ZGJjMjU5MDgxZTQuLmM1MGIwODRiNmM1OSAxMDA2NDQKPiAtLS0gYS9Eb2N1
bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvYXJtL2FtbG9naWMudHh0Cj4gKysrIGIvRG9j
dW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2FybS9hbWxvZ2ljLnR4dAo+IEBAIC05OSw2
ICs5OSw3IEBAIEJvYXJkIGNvbXBhdGlibGUgdmFsdWVzIChhbHBoYWJldGljYWxseSwgZ3JvdXBl
ZCBieSBTb0MpOgo+ICAgICAtICJhbWxvZ2ljLHAyODEiIChNZXNvbiBneGwgczkwNXcpCj4gICAg
IC0gIm9yYW50aCx0eDMtbWluaSIgKE1lc29uIGd4bCBzOTA1dykKPiAgIAo+ICsgIC0gImFtZWRp
YXRlY2gseDk2LW1heCIgKE1lc29uIGd4bSBzOTEyKQo+CgpTaG91bGRuJ3QgdGhhdCBiZSBNZXNv
biBnMTJhIHM5MDV4MiA/CgpDaGVlcnMsCkNocmlzCgoKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGlu
dXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQu
b3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
