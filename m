Return-Path: <SRS0=7SeU=QL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB27EC282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 09:55:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B973720811
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 09:55:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="fUzY7t6Q";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="005/w22S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B973720811
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=8+t1HNdDHQJaYqSFZ4dUb5jr0QD2q91q4BXwq972ylU=; b=fUzY7t6QFzKrWs
	IuJnoNhXT1pY4nAwD/Wk58TnzueMIEW0ZKeY6w4lbGFbVDZ3Ba5IRIraHZZ0B6a7CNHee4xY6dUEs
	8CUY6jy+hDpUrpOZtmhSGqFmQwoGjDffmuVFcwXgO+KCVNwM2420ooZfsaskaOCoGj6OYPW8KCN2/
	Esr4Bxi2l3JjsZePHknH75JfzPw9VBQzVRnV8LXqR+7l8M2wGQrCAyyORBQAoksS+i4Jd/p9la4wg
	l/M9rot1pY2VMJ3W2LBCtZxtRFReGAi/D/e7sYjLEypKszCZ5TBveetg9wTEsnA9fRRgn02xwuJSO
	dC3K+D8xl7Ax6X01NdSQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqayb-0008AM-Nm; Mon, 04 Feb 2019 09:55:41 +0000
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqayX-00088j-3y
 for linux-arm-kernel@lists.infradead.org; Mon, 04 Feb 2019 09:55:38 +0000
Received: by mail-wm1-x344.google.com with SMTP id a62so12419649wmh.4
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 04 Feb 2019 01:55:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=pkjz/f0QfqEm9NzY0SVdhwC//Bv3LcwK48URNAuYP+A=;
 b=005/w22SjKaKR+OcSUPI0xl637BCseo2Vn7Ri2qV4IF2msRMe2NJBsZ79L8nefX8cn
 Ym7ZT5o74573nDVQRufx8Jy1COyDtO0rVEFqJb+1ukeyEJ2YiQMTWbSzr2bFiouXKv44
 Td4xnY/yo5iCjCCRu8lEPixq/xI0MAwJL8ym/3wnylukSGIQkqforVcJbo4XoHLsMS5+
 Bqbl5dzaib6RDHfnYAuxLMTTJ8Fdjj8fqcuZZEYlUAGv3bA+q7O5jLiAUg3/O4xHKltb
 UkVxNTmaj4Ti3fjpFcB3cOoz5MTuGacokYr73H3eu7D9KfHD+Brx1r5tIxfuj9NBtNa6
 hzFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=pkjz/f0QfqEm9NzY0SVdhwC//Bv3LcwK48URNAuYP+A=;
 b=Py2MOh1YMqDlJXoFQuig1nj+yAwK0t6f21mWig55zxHvYi0MiIxwHBHdRf5nmZr4pF
 m6jI212MQ9HLPotJrFpIkAgCRZSKynyJLJmty055KwCR5kJ9rk3Et5NUQQ+KR08RP3Cl
 Ek3caU/e8zgAl+Ix6OdQwqbbWlcWLj+yn/kitdLmT2e48hpj2c6klspUswe8jPlZG9IY
 BeQdLkrIR2OR2mGRDOjPL+tUT8HIbVBYranI47E0BchpcEqI1MEJZJRfLeCdwwk1gNGO
 55jfOK+dYo0GP2I+ZMy5z4LkAi8elVIKoj+b6qolNGoTVR5KJhNi+j17mIvekjR+lKyK
 z5/g==
X-Gm-Message-State: AHQUAubFhLWGl81TufAm6BXdx+cpkCoChQh5JzALU4o50PAYi422c3tF
 FyD/EVFH8Q7HxOaPUsGpl3MKaQ==
X-Google-Smtp-Source: AHgI3IYQZtyGrCgztWDiCxQW2vcfV7LQU+ZmP5HkQx2m5TyjJ/4sZs9DC4i01BhL+drnz7l8aBEPZA==
X-Received: by 2002:a1c:410b:: with SMTP id o11mr12752545wma.109.1549274135224; 
 Mon, 04 Feb 2019 01:55:35 -0800 (PST)
Received: from bender.baylibre.local
 (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
 by smtp.gmail.com with ESMTPSA id y14sm12450683wro.92.2019.02.04.01.55.34
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Mon, 04 Feb 2019 01:55:34 -0800 (PST)
From: Neil Armstrong <narmstrong@baylibre.com>
To: daniel@ffwll.ch
Subject: [PATCH] drm/meson: handle when meson_canvas_get returns -EPROBE_DEFER
Date: Mon,  4 Feb 2019 10:55:32 +0100
Message-Id: <20190204095532.27185-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190204_015537_221396_9869CBC1 
X-CRM114-Status: GOOD (  11.45  )
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
Cc: linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, dri-devel@lists.freedesktop.org,
 Neil Armstrong <narmstrong@baylibre.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

When meson_canvas is not yet probed, meson_canvas_get returns -EPROBE_DEFER.

Handle this case but deferring the probe of the drm driver aswell.

Fixes: 66cae477c380 ("drm/meson: Use optional canvas provider")
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/gpu/drm/meson/meson_drv.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/meson/meson_drv.c b/drivers/gpu/drm/meson/meson_drv.c
index ef4afaadaf8d..17e55d63daff 100644
--- a/drivers/gpu/drm/meson/meson_drv.c
+++ b/drivers/gpu/drm/meson/meson_drv.c
@@ -236,6 +236,9 @@ static int meson_drv_bind_master(struct device *dev, bool has_components)
 			meson_canvas_free(priv->canvas, priv->canvas_id_vd1_1);
 			goto free_drm;
 		}
+	} else if (PTR_ERR(priv->canvas) == -EPROBE_DEFER) {
+		ret = PTR_ERR(priv->canvas);
+		goto free_drm;
 	} else {
 		priv->canvas = NULL;
 
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
