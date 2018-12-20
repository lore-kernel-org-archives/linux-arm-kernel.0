Return-Path: <SRS0=AHqO=O5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D38AFC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 10:24:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CBB521741
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 10:24:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gjSiORNX";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="E4RlMnHM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CBB521741
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	Message-id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:List-Owner; bh=YaGTlYJHwU7s+QLyIeSPDZupA1cW6TBLUhSKkkBba2s=; b=gj
	SiORNXKXRerWE9vPqUkhtU0k3tTKeLz6jfE7X7QpzyLrbadLx1Rd0nr7i7fgummKnHNZzxOpQrNEl
	4UxCY+xyuUVlmAFS8bOpIwkHBOog6x9e2j+h3H+1Li3tGfELOcOF7icmXJxugvDyBTCKRS05Xk4W/
	GNqMK/ukOkCJbALcfZF2MPmj0Y1vdvEHdc7C51TfBqzNZRcHx0IphNkCUlMtwAK5QPfEhLI/gAIeQ
	t8Dpj9rGkOG4zxmqIPy9R9i6M7apw2G+fyMrqgVrjBQBKhn9NfEbrYnfpu8kvKl4drHIoOofiIu7l
	xairin5Krw0mLrR+ff46TU1yMLRpGBog==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZvV0-0001By-Nt; Thu, 20 Dec 2018 10:24:14 +0000
Received: from mailout2.w1.samsung.com ([210.118.77.12])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZvU2-0000NY-QC
 for linux-arm-kernel@lists.infradead.org; Thu, 20 Dec 2018 10:23:18 +0000
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20181220102300euoutp0217903aa2bbf60436ff0a66f72d3ccb83~yA2ry7d1m2904229042euoutp02o;
 Thu, 20 Dec 2018 10:23:00 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20181220102300euoutp0217903aa2bbf60436ff0a66f72d3ccb83~yA2ry7d1m2904229042euoutp02o
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1545301380;
 bh=gXXPWLyIIksGpJBpdP9wgUBqHTK9VHca9DO7KeBZFdA=;
 h=From:To:Cc:Subject:Date:References:From;
 b=E4RlMnHMZHT3MHbORlOojrC9LWHcm5YwPZKRJ41JlhHVat2R0YKsQ7DquSnJ52b3k
 wfe3oAuoQCd22TL5LYzzFnOsSPJs6fczCOoQP0vIyvcEiVnrYTEzKDBO5PPshW3zqG
 C+4T4WLFJ1KncSjtdiwmgoqqEy3J04kypq+NbN4E=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTP id
 20181220102259eucas1p2ff36a1116e23abb31680baf332651443~yA2rUN4nM0445704457eucas1p26;
 Thu, 20 Dec 2018 10:22:59 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
 eusmges1new.samsung.com (EUCPMTA) with SMTP id 92.BC.04441.38D6B1C5; Thu, 20
 Dec 2018 10:22:59 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTP id
 20181220102258eucas1p1ca5abb0b48d1f13d9234a4a7702a13da~yA2qnsYRf1719217192eucas1p1H;
 Thu, 20 Dec 2018 10:22:58 +0000 (GMT)
X-AuditID: cbfec7f2-a1ae89c000001159-be-5c1b6d836c8d
Received: from eusync3.samsung.com ( [203.254.199.213]) by
 eusmgms2.samsung.com (EUCPMTA) with SMTP id 17.6E.04128.28D6B1C5; Thu, 20
 Dec 2018 10:22:58 +0000 (GMT)
Received: from AMDC3748.DIGITAL.local ([106.120.43.17]) by
 eusync3.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0 64bit
 (built May  5 2014)) with ESMTPA id <0PK100480669SP10@eusync3.samsung.com>;
 Thu, 20 Dec 2018 10:22:58 +0000 (GMT)
From: Andrzej Hajda <a.hajda@samsung.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v4 0/3] driver core: add probe error check helper
Date: Thu, 20 Dec 2018 11:22:44 +0100
Message-id: <20181220102247.4911-1-a.hajda@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrHIsWRmVeSWpSXmKPExsWy7djP87rNudIxBrv/c1ncWneO1eLlhMOM
 FhtnrGe1mPrwCZtF8+L1bBYLpy1ntNj0+BqrxeVdc9gsDk3dy2ix9shddou5X6YyO3B7XL52
 kdlj56y77B6bVnWyeeyfu4bdY/OSeo/3+66yefRtWcXo8XmTXABHFJdNSmpOZllqkb5dAlfG
 4YWbWQr28FYcXJHYwPiaq4uRg0NCwERi2qOULkYuDiGBFYwSkyZ2M0M4nxklvh5aztLFyAlW
 dKpxNRNEYhmjxNar16Cq/jNKLDy1kwmkik1AU+Lv5ptsILaIgLFE/9lZ7CBFzALzmCVevroD
 ViQs4Chx7dAtZhCbRUBVYuqGpawgNq+AucSJ+S1Q6+QlVm84ALZBQmABm8TXxufMEAkXiaMr
 J0EVCUu8Or6FHcKWkbg8uRsqXi/RNPMKVHMHo8SJxcvZIBLWEoePXwTbxizAJzFp23RmSAjw
 SnS0CUGUeEhc3HQHrERIIFbi+6rVLBMYJRYwMqxiFE8tLc5NTy02zEst1ytOzC0uzUvXS87P
 3cQIjNXT/45/2sH49VLSIUYBDkYlHt4ZUVIxQqyJZcWVuYcYJTiYlUR4H2dJxwjxpiRWVqUW
 5ccXleakFh9ilOZgURLnrWZ4EC0kkJ5YkpqdmlqQWgSTZeLglGpgbN21SfM2ry1PLvdJpg9V
 qRPym1bdudB9zUP1o97VuyvEyj73vdP9Xi67V+fAYtuzi/98qjorH/T26r/nz+encc9fXp2j
 8r5P8eDdmasld1i8/Mg+R/Hl6YSwB9N3eofv6OxceMXB9fycf071Mxd/7Xmt9OjDX7u7sgu/
 HJp0NXal7KqcQ8f/1yxXYinOSDTUYi4qTgQAndPLoNECAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprILMWRmVeSWpSXmKPExsVy+t/xq7pNudIxBjsnqVvcWneO1eLlhMOM
 FhtnrGe1mPrwCZtF8+L1bBYLpy1ntNj0+BqrxeVdc9gsDk3dy2ix9shddou5X6YyO3B7XL52
 kdlj56y77B6bVnWyeeyfu4bdY/OSeo/3+66yefRtWcXo8XmTXABHFJdNSmpOZllqkb5dAlfG
 4YWbWQr28FYcXJHYwPiaq4uRk0NCwETiVONqpi5GLg4hgSWMEgfvPGGEcBqZJM5uesMCUsUm
 oCnxd/NNNhBbRMBYov/sLHaQImaBRcwSe9ftYwVJCAs4Slw7dIsZxGYRUJWYumEpWJxXwFzi
 xPwWFoh18hKrNxxgnsDItYCRYRWjSGppcW56brGRXnFibnFpXrpecn7uJkZgQG079nPLDsau
 d8GHGAU4GJV4eGdEScUIsSaWFVfmHmKU4GBWEuF9nCUdI8SbklhZlVqUH19UmpNafIhRmoNF
 SZz3vEFllJBAemJJanZqakFqEUyWiYNTqoGxLVrw0OcnFkuWWl56+oBh3vdVM63tfh16+Hhi
 VVpOqArHRMbkOLf1u6XqH5z5IJV897mekd8/vbePChaV/dxjt3BRZePJK+2XHz31aQnZyPN3
 y/nmW9dWvc79dedGz7dlNcfd1W9rXG/J3XnV/4el6wc7hpI3706oNyj56bGyLnkvu/SgcpSz
 ghJLcUaioRZzUXEiAE/OtsMkAgAA
X-CMS-MailID: 20181220102258eucas1p1ca5abb0b48d1f13d9234a4a7702a13da
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181220102258eucas1p1ca5abb0b48d1f13d9234a4a7702a13da
References: <CGME20181220102258eucas1p1ca5abb0b48d1f13d9234a4a7702a13da@eucas1p1.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181220_022315_360001_58FD287E 
X-CRM114-Status: GOOD (  13.74  )
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
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 linux-kernel@vger.kernel.org, Javier Martinez Canillas <javierm@redhat.com>,
 Andrzej Hajda <a.hajda@samsung.com>, andy.shevchenko@gmail.com,
 Mark Brown <broonie@kernel.org>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 linux-arm-kernel@lists.infradead.org,
 Marek Szyprowski <m.szyprowski@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Greg, Rafael,

This patchset proposes probe helper function which should simplify little bit
resource acquisition error handling, it also extend it with adding defer probe
reason to devices_deferred property:

This patchset is actually resend of the most important 1st and 2nd patch.

I have also attached patch adding probe_err_ptr - it will allow to replace
quite frequent calls:
    probe_err(dev, PTR_ERR(ptr), ...)
with
    probe_err_ptr(dev, ptr, ...)

I have dropped the last patch showing usage of probe_err(_ptr)? as it is
very big, should be split per subsystem, and should be applied after merge
of patches introducing probe_err(_ptr) helpers.

Just for the record - my dirty cocci script generates patch which replaces
code with probe_err* helpers with following stats (on linux_next branch):
   1585 probe_err
   1194 probe_err_ptr
   1638 files changed, 6487 insertions(+), 9163 deletions(-).
Of course there are much more places where probe_err* can be applied, the script
tries to catch the most obvious ones.
More importantly probe_err should handle probe errors more correctly
and uniformly than it is done now.

If this patchset will be accepted I will try to send patches introducing probe_err*
per subsystem.

Regards
Andrzej


Andrzej Hajda (3):
  driver core: add probe_err log helper
  driver core: add deferring probe reason to devices_deferred property
  driver core: add probe_err_ptr helper

 drivers/base/base.h    |  3 +++
 drivers/base/core.c    | 40 ++++++++++++++++++++++++++++++++++++++++
 drivers/base/dd.c      | 21 ++++++++++++++++++++-
 include/linux/device.h |  5 +++++
 4 files changed, 68 insertions(+), 1 deletion(-)

-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
