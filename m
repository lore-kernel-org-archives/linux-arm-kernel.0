Return-Path: <SRS0=vAN3=QB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60857C282C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 06:55:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 306C9218D0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 06:55:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="YZufx4iz";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="iSMhlvcL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 306C9218D0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=tOsVK/3KOtZ35xMKnD0u6Pk9cX6Oo/6en3ZsoGngBGU=; b=YZu
	fx4izmwFOzPHfLPw63CBVixuRMDfxjs+pRUO30+vLJCMHhFNMkvNk+0rjw42hOZrwUTyELIzy/uDv
	keFMqFOoe5mitQEu7FrcjWIOUQ/s14Uvv1HkSfRFn7yff0f6ARb8njwhqVShcdDqoUCWhHWlvybtr
	lEKfzQZkiF3oHW5Or7GiQkmUOj9o28A4/LM3ykeigJHYm78/k1nAeihvoN+ElTG1Va2qSFr5eqVxs
	iN3NCAuSWCXzO8LagtdOmzJ22437CpFhXBu5A60TesWqiau1PnR3daj/LTHSB4p7XxVgBfWrG3+ju
	5wxJ8PZRjL/27PF0UtMVGi6/Rp0h6IA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmvOM-0001HL-Jv; Fri, 25 Jan 2019 06:55:06 +0000
Received: from conuserg-10.nifty.com ([210.131.2.77])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmvOB-0000sw-Cz
 for linux-arm-kernel@lists.infradead.org; Fri, 25 Jan 2019 06:54:58 +0000
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp
 [153.142.97.92]) (authenticated)
 by conuserg-10.nifty.com with ESMTP id x0P6sNWn014857;
 Fri, 25 Jan 2019 15:54:24 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com x0P6sNWn014857
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
 s=dec2015msa; t=1548399265;
 bh=kOFx2JtTztRNzevV/1XzwIagjECo3SMM4V/39EhMnQo=;
 h=From:To:Cc:Subject:Date:From;
 b=iSMhlvcLLuDzzMVrbnPuv8WfWzETeB4UyKz9HKWhNE/IfbUPXMRbERobKnwXFLGmd
 cIKiTnJcK6n94Hm7AmXViRtUWerr1tZyblXO/Z6ARr0Kd+ByA90fbwzI4PZ8C6B3tA
 gqthXvT9fcj5C/4lw+iyumyysPLWLLnx02IxNjbqECv+C5fuwjcYNS1cJCRLSbwzND
 2rP3zjnP9iI6fgpP4xYI29Q5K/ojbv4X2UOKBxsrXP7gPeFtaAwm2Gk7VXaLIczq57
 qSkuIX5hpoXvS3PZCPxabvZJlttsVMteIDNUs/EQC9CNm8PQ+HFKdHiFdiwVNG59et
 IjjH+RpLdDc1g==
X-Nifty-SrcIP: [153.142.97.92]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: Mauro Carvalho Chehab <mchehab@kernel.org>, linux-media@vger.kernel.org
Subject: [PATCH 0/3] media: clean-up header search paths and add $(srctree)/
 prefix
Date: Fri, 25 Jan 2019 15:54:16 +0900
Message-Id: <1548399259-17750-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190124_225455_888273_E20C9E08 
X-CRM114-Status: UNSURE (   7.42  )
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
Cc: Abylay Ospan <aospan@netup.ru>, Andy Walls <awalls@md.metrocast.net>,
 Sergey Kozlov <serjk@netup.ru>, Akihiro Tsukada <tskd08@gmail.com>,
 linux-kernel@vger.kernel.org, Patrice Chotard <patrice.chotard@st.com>,
 Hans Verkuil <hverkuil@xs4all.nl>,
 Masahiro Yamada <yamada.masahiro@socionext.com>,
 Sakari Ailus <sakari.ailus@iki.fi>, linux-arm-kernel@lists.infradead.org,
 Philipp Zabel <p.zabel@pengutronix.de>, Hans Verkuil <hans.verkuil@cisco.com>,
 Mike Isely <isely@pobox.com>, Yasunari Takiguchi <Yasunari.Takiguchi@sony.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

My main motivation is to get rid of crappy header search path manipulation
from Kbuild core.

Before that, I want to do as many treewide cleanups as possible.

If you are interested in the big picture of this work,
the full patch set is available at:
git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git build-test



Masahiro Yamada (3):
  media: coda: remove -I$(src) header search path
  media: remove unneeded header search paths
  media: prefix header search paths with $(srctree)/

 drivers/media/common/b2c2/Makefile            | 4 ++--
 drivers/media/dvb-frontends/cxd2880/Makefile  | 2 --
 drivers/media/i2c/smiapp/Makefile             | 2 +-
 drivers/media/mmc/siano/Makefile              | 3 +--
 drivers/media/pci/b2c2/Makefile               | 2 +-
 drivers/media/pci/bt8xx/Makefile              | 5 ++---
 drivers/media/pci/cx18/Makefile               | 4 ++--
 drivers/media/pci/cx23885/Makefile            | 4 ++--
 drivers/media/pci/cx88/Makefile               | 4 ++--
 drivers/media/pci/ddbridge/Makefile           | 4 ++--
 drivers/media/pci/dm1105/Makefile             | 2 +-
 drivers/media/pci/mantis/Makefile             | 2 +-
 drivers/media/pci/netup_unidvb/Makefile       | 2 +-
 drivers/media/pci/ngene/Makefile              | 4 ++--
 drivers/media/pci/pluto2/Makefile             | 2 +-
 drivers/media/pci/pt1/Makefile                | 4 ++--
 drivers/media/pci/pt3/Makefile                | 4 ++--
 drivers/media/pci/smipcie/Makefile            | 5 ++---
 drivers/media/pci/ttpci/Makefile              | 4 ++--
 drivers/media/platform/coda/Makefile          | 2 --
 drivers/media/platform/coda/coda-h264.c       | 3 ++-
 drivers/media/platform/coda/trace.h           | 2 +-
 drivers/media/platform/sti/c8sectpfe/Makefile | 5 ++---
 drivers/media/radio/Makefile                  | 2 --
 drivers/media/spi/Makefile                    | 4 +---
 drivers/media/usb/as102/Makefile              | 2 +-
 drivers/media/usb/au0828/Makefile             | 4 ++--
 drivers/media/usb/b2c2/Makefile               | 2 +-
 drivers/media/usb/cx231xx/Makefile            | 5 ++---
 drivers/media/usb/em28xx/Makefile             | 4 ++--
 drivers/media/usb/go7007/Makefile             | 2 +-
 drivers/media/usb/pvrusb2/Makefile            | 4 ++--
 drivers/media/usb/siano/Makefile              | 2 +-
 drivers/media/usb/tm6000/Makefile             | 4 ++--
 drivers/media/usb/ttusb-budget/Makefile       | 2 +-
 drivers/media/usb/usbvision/Makefile          | 2 --
 36 files changed, 50 insertions(+), 64 deletions(-)

-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
