Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7451BC5CFFE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 21:59:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F41D2081F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 21:59:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="QiB9gDLw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F41D2081F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=DW4hfitImfa5nnL4/Ct7w/X14vT1MoLKFCU1ZmrfpqI=; b=QiB9gDLwn0HzGn
	Y1332ZHAvKpddg9coZJna2mL/d3RipvVCqkR+zBXxFzM6e8LICYIRThat8fvK2YVYrtjpnTyPcyJr
	NuZMWtIPmLJOerkjd3f9vIfVKidjU8OCeFdwA9BKYbqf2WD/77nQrMPQe+oJAvU9WZSD5ASCjNp+2
	5rd3EbDk9y+TN2LW8mrLsurjnHSv/maWOoPTavz7ruPTfroGBSYyaJU9JUSDm5rS8QyTHyU1fqgwJ
	Y+x92LgMOcJzS4Cu5pca4So7sgnr4ETeTWkxj9mqauRyKK1Dty/DVMRZI3FV4Xn9KUFDb7EzkAn6K
	ONCRl0sAPgwJVNyosbYg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWTag-0007Sq-CN; Mon, 10 Dec 2018 21:59:50 +0000
Received: from mout.kundenserver.de ([212.227.126.130])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWTaZ-0007C3-7A
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 21:59:47 +0000
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MrPyJ-1hHLfj1trD-00oZyJ; Mon, 10 Dec 2018 22:59:28 +0100
From: Arnd Bergmann <arnd@arndb.de>
To: arm@kernel.org, Greg Ungerer <gerg@uclinux.org>,
 Robert Jarzmik <robert.jarzmik@free.fr>, Wolfram Sang <wsa@the-dreams.de>,
 James Hogan <jhogan@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 3/4] ARM: ks8695: fix section mismatch warning
Date: Mon, 10 Dec 2018 22:58:38 +0100
Message-Id: <20181210215856.2238253-3-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181210215856.2238253-1-arnd@arndb.de>
References: <20181210215856.2238253-1-arnd@arndb.de>
MIME-Version: 1.0
X-Provags-ID: V03:K1:C08GXU7G/QybJVSD6XwmX6YnmR+EjGBU/Jra0yrgutJo0sYTaDd
 9syqErBwHA8qnXfo+0SrIcGwI21H3g6LYFSFK5+v1umL5eLNfNQWQuHZc37wnZo+pzPK+IX
 Xb5c/GiDmdU2E0GGLDzBsGoQtBx6DoMb2AhcOkNB2YtSX/09ie0tZgTFkNJ+9EUFBnuNvH6
 QATu7Ik6SBwZquhJ9xzOw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Ntbpk4aPYZQ=:d0XjQYNwtnuQM85Pi6ajdM
 FMW7i573FTC4U0FhsPfu/5R+aOhR+MxOelpOODeEdbEe3jou7KEoB08yIBfSUw/+gOpGiwSOL
 TqXOwWf2JKz3vO6BOPCjUy+sGPP+1k3BHOcCOstohqCyMKmGAQbGGYCabvtJ6xy1x57QLYWRP
 E5SEP6FiaSOmSwXC8uyNA4JmVUHWVEA7lg+6cPWD9jkj98fbMiSrcx3VeOi8m82MP+mZyBMFu
 KY2aeMY1Zo8slt5M/JcRD9j4p3sV00pg/jDZoEVkCLWEVIAqOQ64ixnEJWeGuxyHLXqSsRtp/
 LUKT/afsONPkF20rFpIl/EOj3wyjoxo/+IRp0dOafdyKHtmeBXDImlopQP76Q/fiWZw7ExzpZ
 7YEyrXXnIXM3hE31//H2eVbg8ipS0Q/o1GxhCFCjizxw8XIhX7Sk1HK9ARJpPm9ExhRTbM+IC
 sLTfgwELHXozN9Gy05E3MtuDf8v7EYJ1zaQcg0PEE36eHPKBtqOMxjdXg8d92k/GeKwzMCaFN
 znoWurQdgMorW40zUcJyvv2edI+ido1xIFhJD+zw4WnZO5MP54TJaITmUzTCuElYfddXew825
 kWMXTWtrah85heGqwd8lkQGKnACQ7FbZBorDPTwnkSdLLy6OwXL3QzMqOktOLbNvtSrfgBXWs
 D3cDA7Hzzh17X4nMFn7MOAcxuz1nTMvJy0xdfFawyzPyXXJ3lZM8H5114UpGcATjZ0AA7gaF2
 +wrVO83GKc3FpI7ii24KqlLeVoxCG8Zgk+XSqA==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_135943_962188_C21CBC58 
X-CRM114-Status: GOOD (  12.53  )
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
Cc: Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

WARNING: vmlinux.o(.text+0x13250): Section mismatch in reference from the function acs5k_i2c_init() to the (unknown reference) .init.data:(unknown)
The function acs5k_i2c_init() references
the (unknown reference) __initdata (unknown).
This is often because acs5k_i2c_init lacks a __initdata
annotation or the annotation of (unknown) is wrong.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-ks8695/board-acs5k.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-ks8695/board-acs5k.c b/arch/arm/mach-ks8695/board-acs5k.c
index ef835d82cdb9..5783062224c3 100644
--- a/arch/arm/mach-ks8695/board-acs5k.c
+++ b/arch/arm/mach-ks8695/board-acs5k.c
@@ -100,7 +100,7 @@ static struct i2c_board_info acs5k_i2c_devs[] __initdata = {
 	},
 };
 
-static void acs5k_i2c_init(void)
+static void __init acs5k_i2c_init(void)
 {
 	/* The gpio interface */
 	gpiod_add_lookup_table(&acs5k_i2c_gpiod_table);
-- 
2.20.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
