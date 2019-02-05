Return-Path: <SRS0=y9BX=QM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B8A8C282CB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 21:30:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16790217D6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 21:30:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="YQGUW/Rz";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y/cmGSFm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16790217D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:In-Reply-To:To:References:
	Message-ID:From:Subject:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=W8ArbMBcvJLNICDlGjptLDZoqf0B+Ou692sVta+SkRQ=; b=YQGUW/RzznoEfZ
	dfFa8VLI322bauvuS5oWhOEi6KyukqqRhAEb38/4CO1R6JfBQmOKzuSNnO9L3EYEdFYaqyoy7g0fF
	tFETe5dCeZoqWtPTLUaMuusrBdHZezyyJxdOcuV20Xa3xB/IWAtF5rBmg6JaN/YRB1R25PkVDna9N
	F3WYugto48EtW/J6I02FvHk36CcR/Iq17hsHFrj367pvZBwPp62J0zCA4TaruFoNTB9Dh7lWavp1J
	oTEG3KwjVDXCc9DIkoreZKUJ8AO/M7BQvHi6HDJHAnYSwdl0J50onT7kzikKFIU7RbcPFT6RWNpDf
	f2gofa4Jn58am7Mqj7Cw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gr8IC-0003Vj-RV; Tue, 05 Feb 2019 21:30:08 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gr8Hu-00032m-2E; Tue, 05 Feb 2019 21:29:51 +0000
Received: from localhost (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id B28C5217F9;
 Tue,  5 Feb 2019 21:29:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1549402189;
 bh=bbKcB1JsG/ITujaZdHQEdr6LNN7KR3W9+mdQly0/BDs=;
 h=Subject:From:Cc:References:To:In-Reply-To:Date:From;
 b=Y/cmGSFme0zeMMIuxVkxe33OuPGQq7d5T6OSxFXVZ4j64w5nQ2qzitEwGVJF8rLpR
 +sDQ1beqjecE28lgSoSxKaU5xuCBWNaIFvxFt6/qwcNg08i7RYL0adLyvJ6ToYrjhN
 K/HZgNKjag5gljKgY2D/Iy3vJ6boFroW+gYXdFo4=
MIME-Version: 1.0
Subject: Re: [resend PATCH v1 2/2] clk: mediatek: update clock driver of MT2712
From: Stephen Boyd <sboyd@kernel.org>
Message-ID: <154940218901.169292.2323058934299497356@swboyd.mtv.corp.google.com>
References: <20181214020417.2871-1-weiyi.lu@mediatek.com>
 <20181214020417.2871-4-weiyi.lu@mediatek.com>
User-Agent: alot/0.8
To: Matthias Brugger <matthias.bgg@gmail.com>, Rob Herring <robh@kernel.org>,
 Stephen Boyd <sboyd@codeaurora.org>, Weiyi Lu <weiyi.lu@mediatek.com>
In-Reply-To: <20181214020417.2871-4-weiyi.lu@mediatek.com>
Date: Tue, 05 Feb 2019 13:29:49 -0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190205_132950_119169_F8FCD1C7 
X-CRM114-Status: UNSURE (   5.53  )
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
Cc: James Liao <jamesjj.liao@mediatek.com>, Weiyi Lu <weiyi.lu@mediatek.com>,
 srv_heupstream@mediatek.com, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Fan Chen <fan.chen@mediatek.com>,
 linux-mediatek@lists.infradead.org, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Quoting Weiyi Lu (2018-12-13 18:04:17)
> According to 3rd ECO design change,
> 1. Add new fixed factor clock of audio.
> 2. Add the parent clocks for audio clock mux.
> 
> Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
> ---

Applied to clk-next


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
