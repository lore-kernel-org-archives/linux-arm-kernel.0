Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0587C07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 10:06:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF1932081B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 10:06:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lL+OR8uZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF1932081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=D3k/IxxsCzNcpvWrY4AMFTLT7ALHqpSfgPYL0B/rgMI=; b=lL+OR8uZAXEJ3d
	XaoEWgJcfEn+wF0XFY4piwqVV63le39DrV+g1MpyD7D3n352znfsvq3gyhY5ABAnkhTZpRTvA8f8R
	rWE+qjvM6hvYARHMQunrQZbBkE+2aAyxJ9okz09x5W92k6aXNb5Bao2wdSTDWf9gi8jWPjPtXYETQ
	zpHsjv9TVgKhKJCDdVjT26pchS8/CkQ87x60ZI2QuKjNgN7mdDLhEHVV6hkxMPmj0MfhGCwAdXPgm
	j/vsdf1D8VZfkuWr3uoLe/7WKcW+MD1NL4F6b17XGKH5aI7rKe+CRlPA7/e6EH0XzyMYOQIRxZ8XL
	LywmNpF7qQHnzgA4DQ8Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWevn-0003nd-Ia; Tue, 11 Dec 2018 10:06:23 +0000
Received: from mout.kundenserver.de ([212.227.126.135])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWevj-0003am-Vw
 for linux-arm-kernel@lists.infradead.org; Tue, 11 Dec 2018 10:06:21 +0000
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MwQKr-1hM0ev20Jx-00sKbk; Tue, 11 Dec 2018 11:06:04 +0100
From: Arnd Bergmann <arnd@arndb.de>
To: Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>
Subject: [PATCH] arm64: kexec_file: include linux/vmalloc.h
Date: Tue, 11 Dec 2018 11:05:46 +0100
Message-Id: <20181211100603.625505-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
X-Provags-ID: V03:K1:yYDiuhpQ+tZ2vF9nwseAh/VNtghlaPVJmWclb1ijaMXon2lItJ5
 Tgopoglfbb2g7E3BZiaQDRCEfhlrbrbhhbQU8i33VhIZR+SZLvaGcgnI6EuQHJ5YYAiDdIr
 QmxovIBpM9mXS1V7VFbMoeXHb1Nk5TsZpT2RAH2vmR6DCkaYHiECyY47V9QhU/Z9k07xCz3
 iAil+H6rlJvdmRkZFuG+A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:6/e6p/Wq+4I=:IHLTE78yGGJv4tHgxx58kc
 szN9eVbUz31GAws+PH7b8X2bau5MGL8t3V5/kBAv9BK34Nrioj52/eIgyM1dM53T8uAa6+YIH
 PQ0Dgtdefk/v5524KasFk1gUK/Hk1tEqK8MEaLx08+p8BKQ2NCn2PqTh+TAhjCrUzxEyWe5Gw
 P9sBi4W+B9n8i57qsa7i7ZQDGhYpY3NC0/Ns2dk/ijK8ZZ62ldHDBl/7Ma5Gdm33JgTEmxwCi
 IqHtkvxZJnsoffIk/1ilYNZcLMd//WK5E4cLYv6b0tvi+WOzu2hq5lfwDznyADkuvVgmfx98s
 KpKmoo3vRxYFka0mUb2Q446uZ/ghOEf1Ok717YlHY1OCv8YHrzqYVBKjdPHo4+NefKm/Jyz2c
 PZfiiHcv1jDHzLNVKSQXD9IfoiHdK34jNBWL1l4jT7XEk/Gf4sOvpENjYcTWA3rrKdRu0cJSf
 9pA1Ox2LbReLnb1TCzds2xqFh0LIEIq90p559ytejYGVDjzokxss++VD0olLzC6ehLK2IU0i0
 o5rhotVhBDGJCJ6yqt6+l0d9ULFJPBqaCtz0B8bBn+NhVTgMou8SwlRuVxpZj01NTWe1ifqjz
 cbRRsy5JIy1sHlYxNCfmjamoT12ylreur4IRSme1krCpHI8zCRdqNskW5gGe4kmVsOeGsb/3v
 tB6jfttqMIfMblgxuOdHkUtJgUjhnR25ikWeBzwj/3qZ+i1boQ5kdQo1UDhbc19YMwGNyd07b
 JMPNSoZeq96GfY41P+YDgaB0lqOGr82dzIkXoA==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_020620_326550_BB0A27F6 
X-CRM114-Status: UNSURE (   9.72  )
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
Cc: AKASHI Takahiro <takahiro.akashi@linaro.org>,
 James Morse <james.morse@arm.com>, linux-arm-kernel@lists.infradead.org,
 Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This is needed for compilation in some configurations that don't
include it implicitly:

arch/arm64/kernel/machine_kexec_file.c: In function 'arch_kimage_file_post_load_cleanup':
arch/arm64/kernel/machine_kexec_file.c:37:2: error: implicit declaration of function 'vfree'; did you mean 'kvfree'? [-Werror=implicit-function-declaration]

Fixes: 52b2a8af7436 ("arm64: kexec_file: load initrd and device-tree")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm64/kernel/machine_kexec_file.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/kernel/machine_kexec_file.c b/arch/arm64/kernel/machine_kexec_file.c
index 3c2c8a687149..10e33860e47a 100644
--- a/arch/arm64/kernel/machine_kexec_file.c
+++ b/arch/arm64/kernel/machine_kexec_file.c
@@ -19,6 +19,7 @@
 #include <linux/random.h>
 #include <linux/string.h>
 #include <linux/types.h>
+#include <linux/vmalloc.h>
 #include <asm/byteorder.h>
 
 /* relevant device tree properties */
-- 
2.20.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
