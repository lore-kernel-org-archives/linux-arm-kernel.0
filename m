Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2B68C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 14:20:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79EFE206B7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 14:20:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="BuUQtLa7";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=g.ncu.edu.tw header.i=@g.ncu.edu.tw header.b="cxFvVBhv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79EFE206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=g.ncu.edu.tw
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=BWAbMrHSPoZgbDZCmRB21VBywTRFj43MleM/XAOiY4o=; b=BuUQtLa7uJxRNi
	FAuS3Z+5AcFbHTydIGERnrcsrQNgODbIdxrhxUH5mWGhntULT+j8T8gyfOxGdC3biPYOYT+kJI2xP
	LH05BkF/3P6SIXDxOozW3wzsBa2pikRQz9z0ec5QAccGBZlfT7KhE128CIUlx2MemTBW7VVDHSJW2
	bQaMFytf5FFkDPadFYd62YFZLG8RXcwL/fYZm3ETfrF5rg20kN0idLk//nSTlGvE5OAOPYwARF+TD
	FMDrrCOczf/FG1iZRoa1/b/vJi1beyvRgubJk+DYtHN5njefFGH15pBEdhXx9EwWpoYroJXNSl36r
	EiEYL+vAsIO8YjZEkF2w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUBYG-0004cu-SD; Tue, 04 Dec 2018 14:19:52 +0000
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUBUE-0000eR-5s
 for linux-arm-kernel@lists.infradead.org; Tue, 04 Dec 2018 14:16:15 +0000
Received: by mail-pf1-x444.google.com with SMTP id q1so8278101pfi.5
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 04 Dec 2018 06:15:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=g.ncu.edu.tw; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ytv1cVXpRljGfxPS2GlCpo+dCCVwID6zj0f5fmzf1uM=;
 b=cxFvVBhvR03pzVBh5BBs+bt8HA+laXWMlIBnoX641jWSzhVI1Dfn+kaXcRtB+mrPcH
 U4tIPSrundX+c/3ARbT7q+aHz/1rciydBf+Q30yn2mos8H8PbWdPG3Kt4syBhAR3lHn7
 FKQ+pS8bCBsJgDwnI/HenGp5i8xwuefE8SbJ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ytv1cVXpRljGfxPS2GlCpo+dCCVwID6zj0f5fmzf1uM=;
 b=qhMzglmRTKkiBg01gvRIomQKO5NSe9WX0cicvyEo8d5QG0H/Ru6+Ju17I5+L4lNSJS
 KAxHT2ctHKFTj9/BOaf6vj3TI3hIleEmdZlYOoBX55CVeADMvuOjpbAIpXSj0lUBsa2r
 XxAWNklUF8BgAtCb+rAC3wbSGYwhPGf8hEbvS4SgpPn8y08TIEtUVcFhoYKlR8/V6WmN
 BcH056jDba7p+CxXqf7EG18aIIwWq4MjTbR/Q0+6bwUpH3K5ESM4PGWITmEOdujxzBtE
 x/q4nqPfL5anBGPX9GmnApGVyOSYdZS70duHBoZEvsW8fyuFTFZCqLtzlWQxBl+0rK00
 IhVA==
X-Gm-Message-State: AA+aEWZV7ygrt04gG9orICFBCY8YZcuXSmNCIeZvlTJA63WxOYDBLiji
 F3zXURiFUluzMuGFfdsYijvipw==
X-Google-Smtp-Source: AFSGD/XfACY41/aOz7I7Z4emP5ODuI3J85+x+j7KicG3oIVyanrXqtXeVg1bb/L4PTNhFZiHXBwyQg==
X-Received: by 2002:a63:42c1:: with SMTP id
 p184mr16715011pga.202.1543932941254; 
 Tue, 04 Dec 2018 06:15:41 -0800 (PST)
Received: from starnight.local ([150.116.248.145])
 by smtp.gmail.com with ESMTPSA id n66sm36975863pfk.19.2018.12.04.06.15.38
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 04 Dec 2018 06:15:40 -0800 (PST)
From: Jian-Hong Pan <starnight@g.ncu.edu.tw>
To: =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
 "David S . Miller" <davem@davemloft.net>
Subject: [PATCH V4 4/6] net: maclorawan: Implement the crypto of maclorawan
 module
Date: Tue,  4 Dec 2018 22:13:41 +0800
Message-Id: <20181204141341.4353-5-starnight@g.ncu.edu.tw>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <CAC=mGzhs0smXzRxn1k9jDFsaLNAkpCd7rMs--E-SafQVTob7JQ@mail.gmail.com>
References: <CAC=mGzhs0smXzRxn1k9jDFsaLNAkpCd7rMs--E-SafQVTob7JQ@mail.gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_061543_282164_F7BADF3E 
X-CRM114-Status: GOOD (  15.50  )
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
Cc: netdev@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>,
 linux-kernel@vger.kernel.org, Stefan Schmidt <stefan@datenfreihafen.org>,
 Dollar Chen <dollar.chen@wtmec.com>, Ken Yu <ken.yu@rakwireless.com>,
 linux-wpan@vger.kernel.org, Jian-Hong Pan <starnight@g.ncu.edu.tw>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Implement the crypto for encryption/decryption and message integrity
code (MIC) according to LoRaWAN(TM) Specification Ver. 1.0.2.

Signed-off-by: Jian-Hong Pan <starnight@g.ncu.edu.tw>
---
V2:
- Split the LoRaWAN class module patch in V1 into LoRaWAN socket and
  LoRaWAN Soft MAC modules
- Rename the lrwsec files to crypto files
- Modify for Big/Little-Endian
- Use SPDX license identifiers

V3:
- Order local variables from longest to shortest line in the functions

V4:
- Fix by coding style report from scripts/checkpatch.pl

 net/maclorawan/crypto.c | 212 ++++++++++++++++++++++++++++++++++++++++
 net/maclorawan/crypto.h |  27 +++++
 2 files changed, 239 insertions(+)
 create mode 100644 net/maclorawan/crypto.c
 create mode 100644 net/maclorawan/crypto.h

diff --git a/net/maclorawan/crypto.c b/net/maclorawan/crypto.c
new file mode 100644
index 000000000000..0ae9d211cd14
--- /dev/null
+++ b/net/maclorawan/crypto.c
@@ -0,0 +1,212 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR BSD-3-Clause
+/*-
+ * LoRaWAN soft MAC
+ *
+ * Copyright (c) 2018 Jian-Hong, Pan <starnight@g.ncu.edu.tw>
+ *
+ */
+
+#include <linux/scatterlist.h>
+#include <crypto/hash.h>
+#include <crypto/skcipher.h>
+#include "crypto.h"
+
+struct crypto_shash *
+lrw_mic_key_setup(u8 *k, size_t k_len)
+{
+	struct crypto_shash *tfm;
+	char *algo = "cmac(aes)";
+	int err;
+
+	tfm = crypto_alloc_shash(algo, 0, 0);
+	if (!IS_ERR(tfm)) {
+		err = crypto_shash_setkey(tfm, k, k_len);
+		if (err) {
+			crypto_free_shash(tfm);
+			tfm = NULL;
+		}
+	}
+
+	return tfm;
+}
+
+int
+lrw_aes_cmac(struct crypto_shash *tfm, u8 *bz, u8 *data, size_t len, u8 *out)
+{
+	SHASH_DESC_ON_STACK(desc, tfm);
+	int err;
+
+	desc->tfm = tfm;
+
+	err = crypto_shash_init(desc);
+	if (err)
+		goto lrw_aes_cmac_end;
+
+	err = crypto_shash_update(desc, bz, 16);
+	if (err)
+		goto lrw_aes_cmac_end;
+
+	err = crypto_shash_update(desc, data, len);
+	if (err)
+		goto lrw_aes_cmac_end;
+
+	err = crypto_shash_final(desc, out);
+
+lrw_aes_cmac_end:
+	return err;
+}
+
+int
+lrw_set_bzero(u8 dir, u32 devaddr, u32 fcnt, u8 len, u8 *bz)
+{
+	__le32 le_devaddr = cpu_to_le32(devaddr);
+	__le32 le_fcnt = cpu_to_le32(fcnt);
+
+	bz[0] = 0x49;
+	memset(bz + 1, 0x00, 4);
+	bz[5] = dir;
+	memcpy(bz + 6, &le_devaddr, 4);
+	memcpy(bz + 10, &le_fcnt, 4);
+	bz[14] = 0x00;
+	bz[15] = len;
+
+	return 0;
+}
+
+int
+lrw_calc_mic(struct crypto_shash *tfm,
+	     u8 dir, u32 devaddr, u32 fcnt, u8 *buf, size_t len, u8 *mic4)
+{
+	u8 mic[16];
+	u8 bz[16];
+	int err;
+
+	/* According to LoRaWAN Specification Version 1.0.2
+	 * - 4.4 Massege Integrity Code (MIC)
+	 */
+	lrw_set_bzero(dir, devaddr, fcnt, len, bz);
+	err = lrw_aes_cmac(tfm, bz, buf, len, mic);
+	if (!err)
+		memcpy(mic4, mic, 4);
+
+	return err;
+}
+
+void
+lrw_mic_key_free(struct crypto_shash *tfm)
+{
+	crypto_free_shash(tfm);
+}
+
+struct crypto_sync_skcipher *
+lrw_aes_enc_key_setup(char *algo, u8 *k, size_t k_len)
+{
+	struct crypto_sync_skcipher *tfm;
+	int err;
+
+	tfm = crypto_alloc_sync_skcipher(algo, 0, CRYPTO_ALG_ASYNC);
+	if (!IS_ERR(tfm)) {
+		err = crypto_sync_skcipher_setkey(tfm, k, k_len);
+		if (err) {
+			crypto_free_sync_skcipher(tfm);
+			tfm = NULL;
+		}
+	}
+
+	return tfm;
+}
+
+struct crypto_sync_skcipher *
+lrw_encrypt_key_setup(u8 *k, size_t k_len)
+{
+	return lrw_aes_enc_key_setup("cbc(aes)", k, k_len);
+}
+
+int
+lrw_aes_enc(struct crypto_sync_skcipher *tfm, u8 *in, size_t len, u8 *out)
+{
+	SYNC_SKCIPHER_REQUEST_ON_STACK(req, tfm);
+	struct scatterlist src, dst;
+	u8 iv[16];
+	int err;
+
+	memset(iv, 0, 16);
+	/* The buffer for sg_init_one cannot be a global or const local
+	 * (will confuse the scatterlist)
+	 */
+	sg_init_one(&src, in, len);
+	sg_init_one(&dst, out, len);
+
+	skcipher_request_set_sync_tfm(req, tfm);
+	skcipher_request_set_callback(req, 0, NULL, NULL);
+	skcipher_request_set_crypt(req, &src, &dst, len, iv);
+	err = crypto_skcipher_encrypt(req);
+	skcipher_request_zero(req);
+
+	return err;
+}
+
+#define	LRW_SEQUENCE_OF_BLOCK_LEN	16
+
+int
+lrw_set_sob(u8 dir, u32 devaddr, u32 fcnt, u8 index, u8 *sob)
+{
+	__le32 le_devaddr = cpu_to_le32(devaddr);
+	__le32 _fcnt = cpu_to_le32(fcnt);
+
+	sob[0] = 0x01;
+	memset(sob + 1, 0x00, 4);
+	sob[5] = dir;
+	memcpy(sob + 6, &le_devaddr, 4);
+	memcpy(sob + 10, &_fcnt, 4);
+	sob[14] = 0x00;
+	sob[15] = index;
+
+	return 0;
+}
+
+int
+lrw_encrypt_sob(struct crypto_sync_skcipher *tfm, u8 *sob)
+{
+	return lrw_aes_enc(tfm, sob, LRW_SEQUENCE_OF_BLOCK_LEN, sob);
+}
+
+int
+lrw_encrypt_buf(struct crypto_sync_skcipher *tfm,
+		u8 dir, u32 devaddr, u32 fcnt, u8 *buf, size_t len)
+{
+	u8 sob[LRW_SEQUENCE_OF_BLOCK_LEN];
+	u8 i, j;
+
+	/* According to LoRaWAN Specification Version 1.0.2
+	 * - 4.3.3 MAC Frame Payload Encryption (FRMPayload)
+	 */
+	for (i = 0; (i * LRW_SEQUENCE_OF_BLOCK_LEN) < len; i++) {
+		lrw_set_sob(dir, devaddr, fcnt, i, sob);
+		lrw_encrypt_sob(tfm, sob);
+		for (j = 0; (i * LRW_SEQUENCE_OF_BLOCK_LEN + j) < len; j++)
+			buf[i * LRW_SEQUENCE_OF_BLOCK_LEN + j] ^= sob[j];
+	}
+
+	return 0;
+}
+
+int
+lrw_decrypt_buf(struct crypto_sync_skcipher *tfm,
+		u8 dir, u32 devaddr, u32 fcnt, u8 *buf, size_t len)
+{
+	/* According to XOR swap algorithm */
+	return lrw_encrypt_buf(tfm, dir, devaddr, fcnt, buf, len);
+}
+
+void
+lrw_aes_enc_key_free(struct crypto_sync_skcipher *tfm)
+{
+	crypto_free_sync_skcipher(tfm);
+}
+
+void
+lrw_encrypt_key_free(struct crypto_sync_skcipher *tfm)
+{
+	lrw_aes_enc_key_free(tfm);
+}
diff --git a/net/maclorawan/crypto.h b/net/maclorawan/crypto.h
new file mode 100644
index 000000000000..22dd810040c0
--- /dev/null
+++ b/net/maclorawan/crypto.h
@@ -0,0 +1,27 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later OR BSD-3-Clause */
+/*-
+ * LoRaWAN soft MAC
+ *
+ * Copyright (c) 2018 Jian-Hong, Pan <starnight@g.ncu.edu.tw>
+ *
+ */
+
+#ifndef __LORAWAN_CRYPTO_H__
+#define __LORAWAN_CRYPTO_H__
+
+#include <crypto/hash.h>
+#include <crypto/skcipher.h>
+
+struct crypto_shash *lrw_mic_key_setup(u8 *k, size_t k_len);
+int lrw_calc_mic(struct crypto_shash *tfm,
+		 u8 dir, u32 devaddr, u32 fcnt, u8 *buf, size_t len, u8 *mic4);
+void lrw_mic_key_free(struct crypto_shash *tfm);
+
+struct crypto_sync_skcipher *lrw_encrypt_key_setup(u8 *k, size_t k_len);
+int lrw_encrypt_buf(struct crypto_sync_skcipher *tfm,
+		    u8 dir, u32 devaddr, u32 fcnt, u8 *buf, size_t len);
+int lrw_decrypt_buf(struct crypto_sync_skcipher *tfm,
+		    u8 dir, u32 devaddr, u32 fcnt, u8 *buf, size_t len);
+void lrw_encrypt_key_free(struct crypto_sync_skcipher *tfm);
+
+#endif
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
