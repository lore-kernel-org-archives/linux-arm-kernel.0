Return-Path: <SRS0=vaNk=PS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3418EC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 00:11:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 037E62075C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 00:11:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="BNZ2W8vj";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="TdG8S+of"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 037E62075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:Message-ID:References:From:
	In-Reply-To:To:Subject:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=A4/dibCHhv4xeaxocYfqdsK4KFYRNDqNQBtx6/Jw6nU=; b=BNZ2W8vjcAVXmg
	rc4yXYcqvn0h5+sz8hoHeJijCem66WFR463Mpcieqc/kwf0RU0f1yFXFAPPqmZBhUbI+xLV+InOCc
	RhGdVkfvuU30l808XkRpQ6CB1gM4yQAK/y9wiwvUka3EU0NWJucHOZqFJpcybGLUkqjGk/E7QqkR/
	iQQ0kj7DuXcmpuTHrOV2ckHgmjfsRE9ZNwHmOwagLO+MJk/NZ3lqnx7r+6SwE0SIqqwfdRgwG/JgB
	D5BbVhfNdm32AfzpQVV2kfwJ6lC6DtHav7nibKppXzXBeJhUOFUK2dDRDxwnuHupgiLDdWj3fDDD2
	pYSnIo9v9/PaNp4uNLSA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghNwo-0004Er-Dl; Thu, 10 Jan 2019 00:11:46 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghNhf-0006Bn-Cz
 for linux-arm-kernel@lists.infradead.org; Wed, 09 Jan 2019 23:56:10 +0000
Received: from localhost (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 3AEE920675;
 Wed,  9 Jan 2019 23:56:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1547078166;
 bh=BtZKa8ke/W+kc1urj0r2VWXhtZFrHzTiN6ylajabc0Y=;
 h=Subject:Cc:To:In-Reply-To:From:References:Date:From;
 b=TdG8S+ofsSX2xZQFjPfVLgRP27fJB0CQyZCM0NE5woscCBlEsSoQTuZzCbXIV1kn4
 pKHCL24iDqT1qVNSK5J3CigGTvbuEdQC+f3xauo6TqcbIJMinEv/2otyzaUc/rZBLN
 IzTM9maBA6onBbHIxixSd+qWHrWh5zGy/x67FL5g=
MIME-Version: 1.0
Subject: Re: [PATCH 1/1] clk: meson: meson8b: fix naming of the APB clocks
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Neil Armstrong <narmstrong@baylibre.com>
In-Reply-To: <CAFBinCAginPSuBObJE52puvbay-S698OjAj6aLEm5kfn0SdU0A@mail.gmail.com>
From: Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.8
References: <20181223235836.12466-1-martin.blumenstingl@googlemail.com>
 <20181223235836.12466-2-martin.blumenstingl@googlemail.com>
 <154705938114.15366.1098954164811397084@swboyd.mtv.corp.google.com>
 <CAFBinCAginPSuBObJE52puvbay-S698OjAj6aLEm5kfn0SdU0A@mail.gmail.com>
Message-ID: <154707816530.15366.6699688522231286811@swboyd.mtv.corp.google.com>
Date: Wed, 09 Jan 2019 15:56:05 -0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190109_155608_314517_B25C5755 
X-CRM114-Status: GOOD (  14.33  )
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
Cc: mturquette@baylibre.com, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, jbrunet@baylibre.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Quoting Martin Blumenstingl (2019-01-09 14:30:24)
> Hi Stephen, Hi Neil,
> 
> On Wed, Jan 9, 2019 at 7:43 PM Stephen Boyd <sboyd@kernel.org> wrote:
> >
> > Quoting Martin Blumenstingl (2018-12-23 15:58:36)
> > > Fix a typo in the APB clock names by renaming them from "abp" to "apb".
> > > No functional changes.
> > >
> > > Fixes: 8e1dd17c8b0e3f ("dt-bindings: clock: meson8b: export the CPU post dividers")
> > > Fixes: a7d19b05ce817d ("clk: meson: meson8b: add the CPU clock post divider clocks")
> > > Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> > > ---
> >
> > Can I apply this directly to fixes? Or it's not critical so we can punt
> > until next merge window?
> actually it's not critical:
> I'm not aware of any IP block that I needs the APB clock as input (I'm
> pretty sure there is some, but I'm not aware of it so it can wait).
> 
> Neil already applied another patch for -next which conflicts with this.
> we can choose now:
> 1. Stephen takes this patch, Neil drops the (conflicting) GPU clock
> patches from -next and I re-send the GPU clock patches
> 2. Stephen and Neil don't do anything, I re-send this patch on top of
> the GPU clock patches
> 
> I'm fine either way, but #2 is less work for you guys.
> if I don't hear back from you then I'll go with option #2

If it's not critical then I'll let it go via the normal paths through
Neil's tree.


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
