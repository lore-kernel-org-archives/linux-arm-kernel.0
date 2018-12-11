Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 836A1C07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:40:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53ACA20855
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:40:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="q/QsC+ZV";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="ClN8zShx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53ACA20855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=RFgLKEHeaOP4kn85ImgGAnlOXFqjKw2nOPfgTErIW9E=; b=q/Q
	sC+ZVlYBl4pbX82MAg4YW9amJs2m7OZQoOHR9pmTc+IZMvCtL8QNGf3/7NzPNXYwQgY1l12A64Gte
	VX32Y/0CWLMyoB7yTD/gBroSZb8ISWf/fwLM3cMsoTEFoVpmPlLEY/vj9j7p9twQpvhTu5OE4cdhp
	y7fPM8mnNhmMD8P/hHTB4hyotf9bNqDjtaENbSCvOZrHkJK3NCHZ9gI2TQRUG0fJGmy6WWNFs7s3Z
	m+NP4wZBqzOK5YMC/RwtoU00QQGmQyw9ll4aaKMRhcgZAQ9FmVMfJQtFRNPJMHLMs+oWZKYLY1IES
	UqZ9Hv98uKqmQay/cKx/R1WRj1oWExg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWl5O-0002tx-Vt; Tue, 11 Dec 2018 16:40:42 +0000
Received: from mout.web.de ([217.72.192.78])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWl5L-0002so-5a
 for linux-arm-kernel@lists.infradead.org; Tue, 11 Dec 2018 16:40:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1544546424;
 bh=v3XrqVczNVedwAG97ASb6TnKEHff7b+E2d40qCiElEA=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
 b=ClN8zShxRUzAlqomCYhSiMjQYVRdm0mQh32UNWcT8pAxK5UeN4Fia6Dz3moDD64Wq
 mxktecEZwyeu/2C+lXBrs1tYfRnGg0I5iXu034H3qmDCfzF77eCIJTBqfpTUVCiSW2
 E3RvlR3S6qWTgbj3q1dLABmq1UrXr5GMPV2v1i6M=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from platinum.office.videantis.de ([62.227.160.211]) by smtp.web.de
 (mrweb101 [213.165.67.124]) with ESMTPSA (Nemesis) id
 0MOAjQ-1ga4zj3lpM-005bdg; Tue, 11 Dec 2018 17:40:23 +0100
From: Soeren Moch <smoch@web.de>
To: Shawn Guo <shawnguo@kernel.org>
Subject: [PATCH] ARM: dts: tbs2910: Switch to SPDX identifier
Date: Tue, 11 Dec 2018 17:40:10 +0100
Message-Id: <20181211164010.22596-1-smoch@web.de>
X-Mailer: git-send-email 2.17.1
X-Provags-ID: V03:K1:yknsyAZ5B33SnOuH+2/1eAx8xh1QDWv3jtTDRyaliFKkCdASL7+
 YNb5KB7fRIByh8o/wIiYhq8T4oHJL9O/dQRdMK11Zt0OEEqhxpifufuuf4h7DtknOPu/6mZ
 UVHp7nugBzubO1tHYLr8I3baY2X/X/9yMFMcZzwIeAEC9wg1ZRmfcuhTCF3ihTVkaB9NvEq
 LOm1D7LGXMO2siU/dK5gg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:mjwXbVxrRWA=:3perLQAIMEzy6C2vimT2Ae
 auIe3UQi4LohDbcjpR68XOc4LrSVqerWGDynZOes/TLLXsyUd6nUGFkiGLPswNPRk7dtDL52c
 b8zAroLWVqrOZwd2YvXmquM9HfMIWlVe+9KMvmz33+A7e0i0re2mFEcdYtA7v7v3pgx+K6qc7
 Xqy0UA0Z66kKy5WaRW9OVI+SdCLju4WL/WJcX9EixWUeQQteBLrRkBU/3xuPbmripv2Ic8cgt
 91r2j7AkUa2r8FUD+FfxiT/SJVn2zdNvVzufao8Ph4n3FLq4mOoC/R+FFwLNGOGZ6qPTtUMAs
 g0ua/DLZ9EhdS6cLOPJ7pMmSoLQW1PUBq25Q/K6HPwovLttJ5Hh4lH6q+L7g24RHDV1PJxNxt
 18pF1+Br3XXFcRw1H9gZXeDkyR1RE1pxFLxpyx0qDRlqout0KG91pZMfNcam1CiGj67Gd/jco
 xmI4yHbJxWc4YlT3Xt3DOJ8M8wEJZLDvSStBYKjv9I3PW4vNFQcmnf+TIdpJCyhONvYMQ4rkS
 In/gBuuQxWwCuVt5lwvToDoJvjjTkmLogX/+mIKWGTdr/WYBBQ30DFaqZDsXpGDpOCkgApZNM
 67rrNePw2BM8W1VY4XaAanKOURwoBQuZN4warMXZyxWlvav6SD9sWhgFLQnnOxB7XcnXM16bN
 WXgXIpcrCCRMTADlUz7o8UGI2RoZeiHf5bdw8GUNKzS2jLKxgIy77z9c6Eb9cgOEYl22ucWpH
 MRi0xh4fApnBB6NkvSe/SwRSGj6URYIRnHIHwNgUm18IwAgmZDAyEEDud/LAoRSSa1JgI1the
 7zjDJK00ZqiAy2Njsb233TrWbyRyDwCgSir3ZgEencgEl3dsSuqid757uaj4CMAjygI+LCKO9
 RL7OEK75bJ+LMb/RvjkaWDQgfHiTLIWd508DInNik=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_084039_545435_6188870E 
X-CRM114-Status: GOOD (  14.81  )
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
Cc: Fabio Estevam <fabio.estevam@nxp.com>, Soeren Moch <smoch@web.de>,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Adopt the SPDX license identifier headers to ease license compliance
management.

Signed-off-by: Soeren Moch <smoch@web.de>
--
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Cc: linux-arm-kernel@lists.infradead.org
---
 arch/arm/boot/dts/imx6q-tbs2910.dts | 49 ++---------------------------
 1 file changed, 3 insertions(+), 46 deletions(-)

diff --git a/arch/arm/boot/dts/imx6q-tbs2910.dts b/arch/arm/boot/dts/imx6q-tbs2910.dts
index 505cba776a2d..f1c40d5715c6 100644
--- a/arch/arm/boot/dts/imx6q-tbs2910.dts
+++ b/arch/arm/boot/dts/imx6q-tbs2910.dts
@@ -1,49 +1,6 @@
-/*
- * Copyright 2014 Soeren Moch <smoch@web.de>
- *
- * This file is dual-licensed: you can use it either under the terms
- * of the GPL or the X11 license, at your option. Note that this dual
- * licensing only applies to this file, and not this project as a
- * whole.
- *
- *  a) This file is free software; you can redistribute it and/or
- *     modify it under the terms of the GNU General Public License as
- *     published by the Free Software Foundation; either version 2 of
- *     the License, or (at your option) any later version.
- *
- *     This file is distributed in the hope that it will be useful,
- *     but WITHOUT ANY WARRANTY; without even the implied warranty of
- *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *     GNU General Public License for more details.
- *
- *     You should have received a copy of the GNU General Public
- *     License along with this file; if not, write to the Free
- *     Software Foundation, Inc., 51 Franklin St, Fifth Floor, Boston,
- *     MA 02110-1301 USA
- *
- * Or, alternatively,
- *
- *  b) Permission is hereby granted, free of charge, to any person
- *     obtaining a copy of this software and associated documentation
- *     files (the "Software"), to deal in the Software without
- *     restriction, including without limitation the rights to use,
- *     copy, modify, merge, publish, distribute, sublicense, and/or
- *     sell copies of the Software, and to permit persons to whom the
- *     Software is furnished to do so, subject to the following
- *     conditions:
- *
- *     The above copyright notice and this permission notice shall be
- *     included in all copies or substantial portions of the Software.
- *
- *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
- *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
- *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
- *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
- *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
- *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
- *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
- *     OTHER DEALINGS IN THE SOFTWARE.
- */
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+//
+// Copyright 2014 Soeren Moch <smoch@web.de>
 
 /dts-v1/;
 
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
