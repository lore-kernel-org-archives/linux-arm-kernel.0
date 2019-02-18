Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA785C10F01
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 18:08:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BB64217D9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 18:08:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="HTLYu2DW";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="dDmdOEhY";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="dDmdOEhY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BB64217D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:In-Reply-To:
	Date:References:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=uy3TeZCt5mKkpsLg+LrtiRYEUIwlX/onHG6VEjQAc2g=; b=HTLYu2DWsJBLJ2
	g+FchvTJFrc3bOHbbM0xOhav1gv2Ysx7cdFgT6OJvwR6xPSLMu+xNDSvOx+JnKC0nX8vwjQpKes2x
	JJkvcpQ1IK6xG/9jm/sGwMfErSoJZXVwMuDo1jFtQ39IlrE0NRrZMg668ViNcnE2NOi8Lw1KyL9wK
	id1algaCkMiJ3MyqWGMQbpTEirW22iIw3GeVlKMs8353hp7/hbOUgyiFSDtvqOVoPpxzkTsmXir7f
	P6wy3W1Bd+2nGxL6HR8Wnn5QLTEKHjvoKbqUGVeB8Pt6D//Ady3KQ9TDr40j3+aXEKvm5QMja1ISy
	B7Q8nQZCaTMp/QyYOu6g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvnLC-00055r-1p; Mon, 18 Feb 2019 18:08:30 +0000
Received: from smtp.codeaurora.org ([198.145.29.96])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvnL8-00055G-BN; Mon, 18 Feb 2019 18:08:27 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
 id 833CB602FE; Mon, 18 Feb 2019 18:08:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1550513305;
 bh=xCjBUogtWIOqJZsdmRtXiOBmgDLvp893h57ZpPCX8xw=;
 h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
 b=dDmdOEhYTB4RXWskygVmUXPMZ/rPdDYnOA2nlpyw3yQmLZ/zOgW3+9KLRub13wxR4
 Wkc8atuV3wEHk7OO37OzpZEgujivVZ/qedzl2jkAGR1waUU/dm2pIsqagd5u9WRYwI
 b5/8cGWxRbLAHA92ZO7C/N78Km9Z676Hyyv42Ewk=
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi
 [88.114.240.156])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: kvalo@smtp.codeaurora.org)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id 83FD560388;
 Mon, 18 Feb 2019 18:08:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1550513305;
 bh=xCjBUogtWIOqJZsdmRtXiOBmgDLvp893h57ZpPCX8xw=;
 h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
 b=dDmdOEhYTB4RXWskygVmUXPMZ/rPdDYnOA2nlpyw3yQmLZ/zOgW3+9KLRub13wxR4
 Wkc8atuV3wEHk7OO37OzpZEgujivVZ/qedzl2jkAGR1waUU/dm2pIsqagd5u9WRYwI
 b5/8cGWxRbLAHA92ZO7C/N78Km9Z676Hyyv42Ewk=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 83FD560388
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
 spf=none smtp.mailfrom=kvalo@codeaurora.org
From: Kalle Valo <kvalo@codeaurora.org>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: [PATCH 1/2] wireless: mt76: call hweight8() instead of
 __sw_hweight8()
References: <1550469571-25933-1-git-send-email-yamada.masahiro@socionext.com>
 <1550469571-25933-2-git-send-email-yamada.masahiro@socionext.com>
Date: Mon, 18 Feb 2019 20:08:18 +0200
In-Reply-To: <1550469571-25933-2-git-send-email-yamada.masahiro@socionext.com>
 (Masahiro Yamada's message of "Mon, 18 Feb 2019 14:59:30 +0900")
Message-ID: <877edxt1f1.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_100826_410103_A9CF9908 
X-CRM114-Status: GOOD (  13.86  )
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
Cc: netdev@vger.kernel.org, x86@kernel.org, linux-wireless@vger.kernel.org,
 linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Matthias Brugger <matthias.bgg@gmail.com>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>,
 Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
 linux-mediatek@lists.infradead.org, Thomas Gleixner <tglx@linutronix.de>,
 Christoph Hellwig <hch@lst.de>, linux-arm-kernel@lists.infradead.org,
 Felix Fietkau <nbd@nbd.name>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Masahiro Yamada <yamada.masahiro@socionext.com> writes:

> __sw_hweight8() is just internal implementation.
>
> Drivers should use the common API, hweight8().
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Acked-by: Kalle Valo <kvalo@codeaurora.org>

> This patch should go to x86 tree along with 2/2.
>
> Otherwise, all{yes,mod}config of x86 would be broken.
>
> This patch is trivial enough.
> I want ACK from the net/wireless maintainer
> so that this can go in via x86 tree.

Sounds good to me, feel free to push via the x86 tree.

-- 
Kalle Valo

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
