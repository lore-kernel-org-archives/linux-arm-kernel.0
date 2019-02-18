Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD77DC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 06:02:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7AB7D218C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 06:02:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="iTYxadEd";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="YYo8l7fA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AB7D218C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=HUG7Rn7nh2fhxHdmcwX0zRjiIrK9vpnFg/n7oxe4H5k=; b=iTYxadEdA/ZLJ/8VYrauEU6ZdZ
	r4tZjBMKY8ctw8SWnFeQ+Hkb8uHem/8AqTBf5z4XS+6gQI0PuKJ6JzvWoUhsVrjio78dG0KCZ4tXt
	A8jZSWBWzOVQ4v53urabNVbtIEB6EMY/PsfIkdLR1NVMzZjSbMoESnlXr5fAhRBpiBtrzYOq+i5b+
	BV6KtcsLhhB4ZXDmnqza9H8QdToFFt9AvyInXJPYFOYibWJ7hscijay1EBMvWt9GU48h3n7fHfscr
	hhital9KJQkXXfpYC0NTPH61j3moq7F8tZlN/Mr7cWOvhcmOW4nF6uU393hidApyQbSc9L0yiOjsQ
	tqLdl4GA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvc07-0000I4-MK; Mon, 18 Feb 2019 06:01:59 +0000
Received: from conuserg-07.nifty.com ([210.131.2.74])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvbzv-00008a-H1; Mon, 18 Feb 2019 06:01:49 +0000
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp
 [153.142.97.92]) (authenticated)
 by conuserg-07.nifty.com with ESMTP id x1I617hQ006910;
 Mon, 18 Feb 2019 15:01:09 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com x1I617hQ006910
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
 s=dec2015msa; t=1550469670;
 bh=qOxNgKzvwDnjG50PQePnvnPUqjWVkaPbhPq17iGF30M=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=YYo8l7fAwJT/nx0ArY/No5xP16LoQ3HbWUe2PSY3OXR7minn3wmrACWbJVQP46EUb
 ZswDcrb30TOQbhhfqbbx39fmJqILnNiRlBjFFFthNsUROoQWh4+5NUjxxWz5dQp8iQ
 l9688rRodF0N+Lq0e3BwZWksHw4xCOHZgSmkr5XIpqrzUlPYuTLBNhcbfgYGes8aLK
 W3cpwF7az8tkzQR+R+c1Voco6bX3GzYy/SDYEBPyU4+uh82DDlhL0B305UuXV7B5M8
 ePYFGl65I1Ti0kcbqewERUBfr/MYJWpmLu96A7NbMyHSnE/Czm/M22YmBHwAl9H2Sk
 MTI3qGDusKrlw==
X-Nifty-SrcIP: [153.142.97.92]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
 Borislav Petkov <bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>,
 x86@kernel.org
Subject: [PATCH 1/2] wireless: mt76: call hweight8() instead of __sw_hweight8()
Date: Mon, 18 Feb 2019 14:59:30 +0900
Message-Id: <1550469571-25933-2-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1550469571-25933-1-git-send-email-yamada.masahiro@socionext.com>
References: <1550469571-25933-1-git-send-email-yamada.masahiro@socionext.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190217_220147_890690_623FD0F0 
X-CRM114-Status: GOOD (  10.43  )
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
Cc: Matthias Brugger <matthias.bgg@gmail.com>, netdev@vger.kernel.org,
 linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>,
 Masahiro Yamada <yamada.masahiro@socionext.com>,
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
 Christoph Hellwig <hch@lst.de>, Kalle Valo <kvalo@codeaurora.org>,
 Felix Fietkau <nbd@nbd.name>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

__sw_hweight8() is just internal implementation.

Drivers should use the common API, hweight8().

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

This patch should go to x86 tree along with 2/2.

Otherwise, all{yes,mod}config of x86 would be broken.

This patch is trivial enough.
I want ACK from the net/wireless maintainer
so that this can go in via x86 tree.


 drivers/net/wireless/mediatek/mt76/mac80211.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/wireless/mediatek/mt76/mac80211.c
index 7b926df..c42e0d3 100644
--- a/drivers/net/wireless/mediatek/mt76/mac80211.c
+++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
@@ -124,7 +124,7 @@ static void mt76_init_stream_cap(struct mt76_dev *dev,
 				 bool vht)
 {
 	struct ieee80211_sta_ht_cap *ht_cap = &sband->ht_cap;
-	int i, nstream = __sw_hweight8(dev->antenna_mask);
+	int i, nstream = hweight8(dev->antenna_mask);
 	struct ieee80211_sta_vht_cap *vht_cap;
 	u16 mcs_map = 0;
 
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
