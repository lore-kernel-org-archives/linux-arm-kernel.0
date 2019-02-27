Return-Path: <SRS0=CF3g=RC=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD23EC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 20:52:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6958E21850
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 20:52:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="KoPxwlVI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6958E21850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=yk4on5xLmKbafxcmnKKSH2xunk2y+GHeIwEdZoAJqBc=; b=KoPxwlVIzhjpHE
	iTjJfduMUlPNeoOwCH5HoaiLkb/ecGgPE6xKKFz8J52IGBuU5vm00HEDWndxbVhX837ZafqeJcI8L
	eBYtnP3l7A80IgruAqhkF91risSJTsjtU82HoqFo+dokeNYvgL2RQwMXCNohkcj8kCQSdpY7SH7FO
	BYFfXJMKRCV3BmxPpw0dJlRysS/gjCl7M18pyXLXvg0UlhBpgs4lYa5/EpSKaErXkj+kTGaCJRcv/
	X/qG7tGEr+Fi2x6YLwIn4jVelfBH2tpTYFvqGI6m5uCUaHUs7+SF6RmNbpveJv9P4IrD1pN5ZsX2g
	HhFkM8yBezgEA19yyTVg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gz6C0-0001pU-Jb; Wed, 27 Feb 2019 20:52:40 +0000
Received: from inva021.nxp.com ([92.121.34.21])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gz6Bb-0001HP-LN
 for linux-arm-kernel@lists.infradead.org; Wed, 27 Feb 2019 20:52:19 +0000
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 5C72B2001FF;
 Wed, 27 Feb 2019 21:52:12 +0100 (CET)
Received: from smtp.na-rdc02.nxp.com (inv1260.us-phx01.nxp.com [134.27.49.11])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 26CD82000ED;
 Wed, 27 Feb 2019 21:52:12 +0100 (CET)
Received: from someleo.am.freescale.net (someleo.am.freescale.net
 [10.81.32.161])
 by inv1260.us-phx01.nxp.com (Postfix) with ESMTP id 6167140C8A;
 Wed, 27 Feb 2019 13:52:11 -0700 (MST)
From: Li Yang <leoyang.li@nxp.com>
To: arm@kernel.org
Subject: [GIT PULL] updates to soc/fsl drivers for v5.1 take4
Date: Wed, 27 Feb 2019 14:52:11 -0600
Message-Id: <20190227205211.32425-1-leoyang.li@nxp.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-Virus-Scanned: ClamAV using ClamSMTP
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190227_125216_295948_4B6F879C 
X-CRM114-Status: GOOD (  10.96  )
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
Cc: shawnguo@kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGkgYXJtLXNvYyBtYWludGFpbmVycywKClNpbmNlIHdlIGFyZSBoYXZpbmcgYSAtcmM4IGZvciB2
NS4wLCBwbGVhc2UgaGVscCB0byBtZXJnZSBhIGZldyBhZGRpdGlvbmFsCnBhdGNoZXMgZm9yIHRo
ZSB1cGNvbWluZyBtZXJnZSB3aW5kb3cuICBUaGFua3MKClJlZ2FyZHMsCkxlbwoKVGhlIGZvbGxv
d2luZyBjaGFuZ2VzIHNpbmNlIGNvbW1pdCBiZDNiZDNiMzZkZjcyNTY0NTAzNjc0OGU1OGE4YzM1
YzhkMmNiZjkxOgoKICBzb2M6IGZzbDogZHBpbzogZml4IG1lbW9yeSBsZWFrIG9mIGEgc3RydWN0
IHFibWFuIG9uIGVycm9yIGV4aXQgcGF0aCAoMjAxOS0wMi0xOSAxNDo1OTozOSAtMDYwMCkKCmFy
ZSBhdmFpbGFibGUgaW4gdGhlIEdpdCByZXBvc2l0b3J5IGF0OgoKICBnaXQ6Ly9naXQua2VybmVs
Lm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvbGVvL2xpbnV4LmdpdCB0YWdzL3NvYy1mc2wt
bmV4dC12NS4xLTQKCmZvciB5b3UgdG8gZmV0Y2ggY2hhbmdlcyB1cCB0byBmOGI5OTU4NTM0NDRh
YmE5YzE2YzFjY2RjY2RkMzk3NTI3ZmRlOTZkOgoKICBkcGFhMi1ldGg6IGNvbmZpZ3VyZSB0aGUg
Y2FjaGUgc3Rhc2hpbmcgYW1vdW50IG9uIGEgcXVldWUgKDIwMTktMDItMjYgMTQ6NTM6MzAgLTA2
MDApCgotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tCk5YUC9GU0wgU29DIGRyaXZlciB1cGRhdGVzIGZvciB2NS4xIHRha2U0CgpE
UElPIGRyaXZlcgotIEFkZCBzdXBwb3J0IGZvciBjYWNoZSBzdGFzaGluZyBhbmQgZW5hYmxlIGl0
IGluIGRwYWEyLWV0aCBkcml2ZXIKCkdVVFMgZHJpdmVyCi0gTWFrZSBmc2xfZ3V0c19nZXRfc3Zy
KCkgQVBJIGludGVybmFsIGluIGZhdm9yIG9mIG1vcmUgZ2VuZXJpYwogIHNvY19kZXZpY2VfbWF0
Y2goKQoKLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLQpIb3JpYSBHZWFudMSDICgxKToKICAgICAgc29jOiBmc2w6IGd1dHM6IG1h
a2UgZnNsX2d1dHNfZ2V0X3N2cigpIHN0YXRpYwoKSW9hbmEgQ2lvcm5laSAoMyk6CiAgICAgIHNv
YzogZnNsOiBkcGlvOiBlbmFibGUgZnJhbWUgZGF0YSBjYWNoZSBzdGFzaGluZyBwZXIgc29mdHdh
cmUgcG9ydGFsCiAgICAgIHNvYzogZnNsOiBkcGlvOiBjb25maWd1cmUgY2FjaGUgc3Rhc2hpbmcg
ZGVzdGluYXRpb24KICAgICAgZHBhYTItZXRoOiBjb25maWd1cmUgdGhlIGNhY2hlIHN0YXNoaW5n
IGFtb3VudCBvbiBhIHF1ZXVlCgogZHJpdmVycy9uZXQvZXRoZXJuZXQvZnJlZXNjYWxlL2RwYWEy
L2RwYWEyLWV0aC5jIHwgIDcgKysrLQogZHJpdmVycy9zb2MvZnNsL0tjb25maWcgICAgICAgICAg
ICAgICAgICAgICAgICAgIHwgIDEgKwogZHJpdmVycy9zb2MvZnNsL2RwaW8vZHBpby1jbWQuaCAg
ICAgICAgICAgICAgICAgIHwgIDUgKysrCiBkcml2ZXJzL3NvYy9mc2wvZHBpby9kcGlvLWRyaXZl
ci5jICAgICAgICAgICAgICAgfCA1MiArKysrKysrKysrKysrKysrKysrKysrKysKIGRyaXZlcnMv
c29jL2ZzbC9kcGlvL2RwaW8uYyAgICAgICAgICAgICAgICAgICAgICB8IDE2ICsrKysrKysrCiBk
cml2ZXJzL3NvYy9mc2wvZHBpby9kcGlvLmggICAgICAgICAgICAgICAgICAgICAgfCAgNSArKysK
IGRyaXZlcnMvc29jL2ZzbC9kcGlvL3FibWFuLXBvcnRhbC5jICAgICAgICAgICAgICB8ICA0ICst
CiBkcml2ZXJzL3NvYy9mc2wvZ3V0cy5jICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgMyAr
LQogaW5jbHVkZS9saW51eC9mc2wvZ3V0cy5oICAgICAgICAgICAgICAgICAgICAgICAgIHwgIDIg
LQogOSBmaWxlcyBjaGFuZ2VkLCA4OCBpbnNlcnRpb25zKCspLCA3IGRlbGV0aW9ucygtKQoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtl
cm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0
dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5l
bAo=
