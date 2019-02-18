Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 898D8C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 00:19:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56446218A6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 00:19:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="aDe1sx9e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56446218A6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sntech.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=nLW2eUBi6NeHJXKHHp5vGkUa1zIArehzpPYx7RkzNxY=; b=aDe1sx9erXcoy9
	cTqnBhtb+luGCf8tCQJemFVITHFb6TRC6UlMoH3w9k5SapLByTTcwpZecxFaGXtjredGamLlL2Qbb
	dTK+2OX7bLW9yfgawtJk+7Fm0G6zYTsQXS7z4056RihzjPFI2E4lv/esd5MXMe3VFtuJObqdg9tDE
	lfqQlX/g3J7JcWPF25l8IcA8nGuwEmNpgClnSeDt9REkv/c1mAiLqhdozRwxkErV0FsJDzm9yGS87
	3Sk0IrN2y1ET4lKaKqXwP4zsLc+D0cX+kdSm8npE53VzihB/MZt58lNM9EmQnYGyHJ0VHH27LaiEA
	9qV8o2/CR0KZpCR0635A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvWeR-00013V-Ad; Mon, 18 Feb 2019 00:19:15 +0000
Received: from gloria.sntech.de ([185.11.138.130])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvWeO-000137-1T; Mon, 18 Feb 2019 00:19:13 +0000
Received: from p5b127a91.dip0.t-ipconnect.de ([91.18.122.145]
 helo=phil.localnet)
 by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.89) (envelope-from <heiko@sntech.de>)
 id 1gvWeM-00043P-Oc; Mon, 18 Feb 2019 01:19:10 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: arm@kernel.org
Subject: [GIT PULL 2/2] Rockchip dts64 updates for 5.1 - round 2
Date: Mon, 18 Feb 2019 01:19:10 +0100
Message-ID: <29818451.VkXVVsXLZK@phil>
In-Reply-To: <1972197.JU0Au1QvNm@phil>
References: <1972197.JU0Au1QvNm@phil>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190217_161912_228883_90CF0CFD 
X-CRM114-Status: GOOD (  10.19  )
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
Cc: linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

VGhlIGZvbGxvd2luZyBjaGFuZ2VzIHNpbmNlIGNvbW1pdCA3OTE2NGM5OWRiMjg0ZDA3YWE0ZTg0
ZTU3YjQ2OWQyMjU2MDk3OTljOgoKICBhcm02NDogZHRzOiByb2NrY2hpcDogY2xlYW4gdXAgdGhl
IGFidXNlIG9mIGRpc2FibGUtd3AgKDIwMTktMDEtMjggMTA6NTE6MjIgKzAxMDApCgphcmUgYXZh
aWxhYmxlIGluIHRoZSBHaXQgcmVwb3NpdG9yeSBhdDoKCiAgZ2l0Oi8vZ2l0Lmtlcm5lbC5vcmcv
cHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L21taW5kL2xpbnV4LXJvY2tjaGlwLmdpdCB0YWdzL3Y1
LjEtcm9ja2NoaXAtZHRzNjQtMgoKZm9yIHlvdSB0byBmZXRjaCBjaGFuZ2VzIHVwIHRvIDAyMjYw
YTYxOWVmZTU3NGQwZjZjMmE0NDIwYjhiNzZjNjgwMjI5NGU6CgogIGFybTY0OiBkdHM6IHJvY2tj
aGlwOiBFbmFibGUgdHNhZGMgZGV2aWNlIG9uIHJvY2s5NjAgKDIwMTktMDItMTcgMjM6NTk6MDUg
KzAxMDApCgotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tCnJvY2twcm82NCByZWd1bGF0b3IgaW1wcm92ZW1lbnRzLCByb2NrOTYw
IGltcHJvdmVtZW50cyAodHNhZGMsIHdpZmksIGhkbWkKYXVkaW8pLCBuYW5vcGk0IGJsdWV0b290
aCBzdXBwb3J0IGFuZCByazMzMjgtcm9jLWNjIGdtYWMgaW1wcm92ZW1lbnQuCgotLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCkFr
YXNoIEdhamphciAoMyk6CiAgICAgIGFybTY0OiBkdHM6IHJvY2tjaGlwOiByb2NrcHJvNjQgZHRz
IG1ha2UgcmVndWxhdG9yIG1vcmUgcmVhZGFibGUKICAgICAgYXJtNjQ6IGR0czogcm9ja2NoaXA6
IHJvY2twcm82NCBkdHMgcmVtb3ZlIHVudXNlZCBsY2QtcmVzZXQgcGlubXV4CiAgICAgIGFybTY0
OiBkdHM6IHJvY2tjaGlwOiByb2NrcHJvNjQgZHRzIGFkZCB1c2IgcmVndWxhdG9yCgpBbmRyaXVz
IMWgdGlrb25hcyAoMSk6CiAgICAgIGFybTY0OiBkdHM6IHJvY2tjaGlwOiBlbmFibGUgbWFsaSBw
b3dlciBzdXBwbHkgb24gcmszMzk5LXJvY2twcm82NAoKRXplcXVpZWwgR2FyY2lhICgyKToKICAg
ICAgYXJtNjQ6IGR0czogcm9ja2NoaXA6IEVuYWJsZSBIRE1JIGF1ZGlvIGRldmljZXMgb24gcmsz
Mzk5LXJvY2s5NjAKICAgICAgYXJtNjQ6IGR0czogcm9ja2NoaXA6IEVuYWJsZSB0c2FkYyBkZXZp
Y2Ugb24gcm9jazk2MAoKTWFuaXZhbm5hbiBTYWRoYXNpdmFtICgxKToKICAgICAgYXJtNjQ6IGR0
czogcm9ja2NoaXA6IEFkZCBvbi1ib2FyZCBXaUZpL0JUIHN1cHBvcnQgZm9yIFJvY2s5NjAgYm9h
cmRzCgpQZXRlciBHZWlzICgxKToKICAgICAgYXJtNjQ6IGR0czogcm9ja2NoaXA6IGZpeCByazMz
Mjgtcm9jLWNjIGdtYWMyaW8gc3RhYmlsaXR5IGlzc3VlcwoKUm9iaW4gTXVycGh5ICgxKToKICAg
ICAgYXJtNjQ6IGR0czogcm9ja2NoaXA6IEFkZCBuYW5vcGk0IGJsdWV0b290aAoKIGFyY2gvYXJt
NjQvYm9vdC9kdHMvcm9ja2NoaXAvcmszMzI4LXJvYy1jYy5kdHMgICAgfCAgIDEgKwogYXJjaC9h
cm02NC9ib290L2R0cy9yb2NrY2hpcC9yazMzOTktbmFub3BpNC5kdHNpICB8ICAzMSArKysrKy0K
IGFyY2gvYXJtNjQvYm9vdC9kdHMvcm9ja2NoaXAvcmszMzk5LXJvY2s5NjAuZHRzaSAgfCAxMTAg
KysrKysrKysrKysrKysrKysrKysrLQogYXJjaC9hcm02NC9ib290L2R0cy9yb2NrY2hpcC9yazMz
OTktcm9ja3BybzY0LmR0cyB8ICA4MyArKysrKysrKy0tLS0tLS0tCiA0IGZpbGVzIGNoYW5nZWQs
IDE4NSBpbnNlcnRpb25zKCspLCA0MCBkZWxldGlvbnMoLSkKCgoKCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBs
aXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5m
cmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
