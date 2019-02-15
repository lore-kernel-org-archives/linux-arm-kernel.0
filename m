Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A7B1C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 00:46:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2AEAA2229F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 00:46:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ZMhlEKv4";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="d3VbzEm/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AEAA2229F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=H1G0YpafaZnE3Zw76v9QrUwWMryu1+hbLJpeZ0hlpjQ=; b=ZMhlEKv4YiOcKI
	WpUVnH2oHFO00wo+1/zWOc2kjyvGvwdOAhGgp0PKJY7kYbywP+DzeszqZuUMoKeGhKynHpxQkzz0O
	rLj4TXiz62y7V1pCUM50J8aSnHo2tYknYsfxoZBnZx1Vv20UF+bIHRStnONY31FQ3UqwbWn8mmItj
	crTLAeedy5yRQyJHUeX5bJ7ZFUTDWwAYnyuu0F2zacCMMKrK/aYhHPrgOl5Vu0+Py0nuQt+QlROZi
	oDe7oZ+VM0wr5nLol0lTV+z+0GSaXCWOjlijuuWQE9bkHshCG8GpvR92JtBA+1p9L8DACnTODDB0F
	r/jju7B0uyYb7ulmEMsA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guRdj-0003jg-Qj; Fri, 15 Feb 2019 00:46:03 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guRdg-0003ii-5G
 for linux-arm-kernel@lists.infradead.org; Fri, 15 Feb 2019 00:46:01 +0000
Received: from quaco.ghostprotocols.net (unknown [189.40.103.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 7DB8B21B68;
 Fri, 15 Feb 2019 00:45:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1550191559;
 bh=sAIxCpdE/fBclKe7EWnnZg+XMA9lo5WpgqS/a7OlR64=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=d3VbzEm/tcLeMndtEOzHImtxIngHZIrxnNcVL0ePWBE27wTZnYELfoB/0jNGkMxnG
 v57O53PjE2I1m9EE7NMwOzLxCO1yz/E0Z+JM06lytqmJXyR5JHovIJsQSbbnEHARfo
 UFSpt2SG7f1hr0OZ4LGv0cW3WzO2HRAR3ieRpl3o=
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 02/43] perf cs-etm: Add proper header file for symbols
Date: Thu, 14 Feb 2019 21:44:58 -0300
Message-Id: <20190215004539.23571-3-acme@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190215004539.23571-1-acme@kernel.org>
References: <20190215004539.23571-1-acme@kernel.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190214_164600_222150_E4AE3E2F 
X-CRM114-Status: UNSURE (   9.69  )
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
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Suzuki K Poulouse <suzuki.poulose@arm.com>,
 Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
 Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 Jiri Olsa <jolsa@redhat.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

RnJvbTogTWF0aGlldSBQb2lyaWVyIDxtYXRoaWV1LnBvaXJpZXJAbGluYXJvLm9yZz4KCkFmdGVy
ICdjb21taXQgZTIyYzFjNzUxMTQwICgicGVyZiB0aHJlYWQ6IERvbid0IGluY2x1ZGUgc3ltYm9s
LmgsCnN5bWJvbF9jb25mLmggaXMgZW5vdWdoIiknCgpDb21waWxhdGlvbiBvZiB0aGUgcGVyZiB0
b29scyBpcyBicm9rZW4gd2hlbiB1c2luZyB0aGUgZnVuY3Rpb25hbGl0eQpwcm92aWRlZCBieSB0
aGUgb3BlbkNTRCBsaWJyYXJ5OgoKWy4uLl0KCi4uLiAgICAgICAgICAgICAgICAgICAgICAgdGlt
ZXJmZDogWyBvbiAgXQouLi4gICAgICAgICAgICAgICAgICBzY2hlZF9nZXRjcHU6IFsgb24gIF0K
Li4uICAgICAgICAgICAgICAgICAgICAgICAgICAgc2R0OiBbIE9GRiBdCi4uLiAgICAgICAgICAg
ICAgICAgICAgICAgICBzZXRuczogWyBvbiAgXQouLi4gICAgICAgICAgICAgICAgICAgIGxpYm9w
ZW5jc2Q6IFsgb24gIF0KClsuLi5dCgogIENDICAgICAgIHV0aWwvYXJtLXNwZS5vCiAgQ0MgICAg
ICAgdXRpbC9hcm0tc3BlLXBrdC1kZWNvZGVyLm8KICBDQyAgICAgICB1dGlsL3MzOTAtY3B1bXNm
Lm8KICBDQyAgICAgICB1dGlsL2NzLWV0bS5vCiAgQ0MgICAgICAgdXRpbC9wYXJzZS1icmFuY2gt
b3B0aW9ucy5vCnV0aWwvY3MtZXRtLmM6IEluIGZ1bmN0aW9uIOKAmGNzX2V0bV9fbWVtX2FjY2Vz
c+KAmToKdXRpbC9jcy1ldG0uYzoyOTc6MjQ6IGVycm9yOiBzdG9yYWdlIHNpemUgb2Yg4oCYYWzi
gJkgaXNu4oCZdCBrbm93bgogIHN0cnVjdCAgYWRkcl9sb2NhdGlvbiBhbDsKCkFuZCByaWdodGx5
IHNvIHNpbmNlIGZpbGUgY3MtZXRtLmMgZG9lc24ndCBpbmNsdWRlIHN5bWJvbC5oLCBzb21ldGhp
bmcKdGhhdCBpcyByZWN0aWZpZWQgaW4gdGhpcyBwYXRjaC4KClNpZ25lZC1vZmYtYnk6IE1hdGhp
ZXUgUG9pcmllciA8bWF0aGlldS5wb2lyaWVyQGxpbmFyby5vcmc+CkNjOiBKaXJpIE9sc2EgPGpv
bHNhQHJlZGhhdC5jb20+CkNjOiBQZXRlciBaaWpsc3RyYSA8cGV0ZXJ6QGluZnJhZGVhZC5vcmc+
CkNjOiBTdXp1a2kgSyBQb3Vsb3VzZSA8c3V6dWtpLnBvdWxvc2VAYXJtLmNvbT4KQ2M6IGxpbnV4
LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpMaW5rOiBodHRwOi8vbGttbC5rZXJuZWwu
b3JnL3IvMjAxOTAyMDgyMjM1NDMuMzE4MzYtMS1tYXRoaWV1LnBvaXJpZXJAbGluYXJvLm9yZwpT
aWduZWQtb2ZmLWJ5OiBBcm5hbGRvIENhcnZhbGhvIGRlIE1lbG8gPGFjbWVAcmVkaGF0LmNvbT4K
LS0tCiB0b29scy9wZXJmL3V0aWwvY3MtZXRtLmMgfCAxICsKIDEgZmlsZSBjaGFuZ2VkLCAxIGlu
c2VydGlvbigrKQoKZGlmZiAtLWdpdCBhL3Rvb2xzL3BlcmYvdXRpbC9jcy1ldG0uYyBiL3Rvb2xz
L3BlcmYvdXRpbC9jcy1ldG0uYwppbmRleCA4YjNmODgyZDZlMmYuLjBiMTFkNjUzY2ZiZSAxMDA2
NDQKLS0tIGEvdG9vbHMvcGVyZi91dGlsL2NzLWV0bS5jCisrKyBiL3Rvb2xzL3BlcmYvdXRpbC9j
cy1ldG0uYwpAQCAtMjUsNiArMjUsNyBAQAogI2luY2x1ZGUgIm1hY2hpbmUuaCIKICNpbmNsdWRl
ICJtYXAuaCIKICNpbmNsdWRlICJwZXJmLmgiCisjaW5jbHVkZSAic3ltYm9sLmgiCiAjaW5jbHVk
ZSAidGhyZWFkLmgiCiAjaW5jbHVkZSAidGhyZWFkX21hcC5oIgogI2luY2x1ZGUgInRocmVhZC1z
dGFjay5oIgotLSAKMi4xOS4xCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5l
bEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4v
bGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
