Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1774DC04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 19:42:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB60120892
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 19:42:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="R+9cLvmL";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JRuB1HkU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB60120892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=8GapnIOQHeaacTABEbCIG//XSTH/8SILObhTCYri4MI=; b=R+9cLvmL+cOLYF
	W1S7Ub9Uum8di9Owv0fHt3sFBPBYtbckHT2y9+Gws4+EFKpWsR/myxgPBPYaCy0ON0IMYHLhDEnSA
	F5QpS2KVM7tdmABV6wmmVI86yUgNQP803UURrhqmz5uF7jjvnlsL92KYLALVJZWsZ5GMSQI878iSY
	d6Wk8YH2UHuvboEiOgZqHhKCBD7gEpQQEZ9dT5MKDIgvx/p/JdxNYj+oPqPgBsPx8ccFHhaamVF2x
	DCjRUFXvP9HHm8dJgS36Y3Dq0/1hiiyXJPJx5Dq6CWIIK0FektO1tIkbANtK1v9hTfzuR0jb8n8CJ
	FuCoxOhfYxbxPDqxPutg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUd3X-000596-Un; Wed, 05 Dec 2018 19:41:59 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUd3W-00058x-IM; Wed, 05 Dec 2018 19:41:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
 MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=WHWyNGi+fAqkqFV8pHjE4cUOzONQY7F2RPGkiNttmMA=; b=JRuB1HkUCqt42nay8R6HG/a1iL
 48s4Es1zeHrqnY+AqAebP/laYoJ9TRMRQeuSP6VoF/dGi1SGceI8W3tR4oCmtLuml/dBlJ9wnnGRB
 +Wzz2TzOGYw7eXlIGwBr7523Uw77bCnEM9Mpiqt4GVbkAjFo40VVCxz7gm8UzognFJecRYhUm47sD
 JW71A2Da0Iyacg27WkSebtiKJHE/zrNBUAFBCzXIgVejFfcHcRAIFmvuqFHrN0AqrXDj34rZIVnDx
 bEOQgoVvwnVk1T3eiA/1ldhzdMMXqEDeDIPMEOBONQhHNKVhn5h0Nuajx44bv4CGxpsXRak76mZb9
 LlBUwELw==;
Received: from 201.86.173.17.dynamic.adsl.gvt.net.br ([201.86.173.17]
 helo=coco.lan)
 by casper.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUd3U-0006Oa-1w; Wed, 05 Dec 2018 19:41:56 +0000
Date: Wed, 5 Dec 2018 17:41:50 -0200
From: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Subject: Re: [PATCH] media: rockchip/vpu: fix a few alignments
Message-ID: <20181205174150.00ed1912@coco.lan>
In-Reply-To: <45972676-265a-51ce-c9eb-ff49f8eab5bb@xs4all.nl>
References: <bcebf81255a71b34541bc00bcb505e815193f0be.1544035391.git.mchehab+samsung@kernel.org>
 <45972676-265a-51ce-c9eb-ff49f8eab5bb@xs4all.nl>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
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
Cc: devel@driverdev.osuosl.org, Heiko Stuebner <heiko@sntech.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Mauro Carvalho Chehab <mchehab@infradead.org>,
 linux-rockchip@lists.infradead.org, Ezequiel Garcia <ezequiel@collabora.com>,
 linux-arm-kernel@lists.infradead.org,
 Linux Media Mailing List <linux-media@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Em Wed, 5 Dec 2018 19:48:25 +0100
Hans Verkuil <hverkuil-cisco@xs4all.nl> escreveu:

> On 12/05/2018 07:43 PM, Mauro Carvalho Chehab wrote:
> > As reported by checkpatch.pl, some function calls have a wrong
> > alignment.
> > 
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
> > ---
> >  drivers/staging/media/rockchip/vpu/rk3288_vpu_hw_jpeg_enc.c | 4 ++--
> >  drivers/staging/media/rockchip/vpu/rk3399_vpu_hw_jpeg_enc.c | 4 ++--
> >  2 files changed, 4 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/staging/media/rockchip/vpu/rk3288_vpu_hw_jpeg_enc.c b/drivers/staging/media/rockchip/vpu/rk3288_vpu_hw_jpeg_enc.c
> > index 8919151e1631..e27c10855de5 100644
> > --- a/drivers/staging/media/rockchip/vpu/rk3288_vpu_hw_jpeg_enc.c
> > +++ b/drivers/staging/media/rockchip/vpu/rk3288_vpu_hw_jpeg_enc.c
> > @@ -106,8 +106,8 @@ void rk3288_vpu_jpeg_enc_run(struct rockchip_vpu_ctx *ctx)
> >  	rk3288_vpu_set_src_img_ctrl(vpu, ctx);
> >  	rk3288_vpu_jpeg_enc_set_buffers(vpu, ctx, src_buf);
> >  	rk3288_vpu_jpeg_enc_set_qtable(vpu,
> > -		rockchip_vpu_jpeg_get_qtable(&jpeg_ctx, 0),
> > -		rockchip_vpu_jpeg_get_qtable(&jpeg_ctx, 1));
> > +				       rockchip_vpu_jpeg_get_qtable(&jpeg_ctx, 0),
> > +				       rockchip_vpu_jpeg_get_qtable(&jpeg_ctx, 1));  
> 
> But now you get warnings because this is > 80 columns.
> 
> I think the 'cure' is worse than the disease.
> 
> I see this is already merged, but I don't think this patch improves readability,
> which is more important than a checkpatch warning IMHO.

IMHO, it is a way more readable if things got aligned. Very very few
people nowadays (if any) write patches directly at a 80 columns console.

Btw, speaking about 80 cols, usually your commit messages are longer
than that (the limit is actually 80 cols - 4). I keep fixing the
corresponding checkpatch.pl warnings from your patches
(when I have time) :-)

> 
> Regards,
> 
> 	Hans
> 
> >  
> >  	reg = VEPU_REG_AXI_CTRL_OUTPUT_SWAP16
> >  		| VEPU_REG_AXI_CTRL_INPUT_SWAP16
> > diff --git a/drivers/staging/media/rockchip/vpu/rk3399_vpu_hw_jpeg_enc.c b/drivers/staging/media/rockchip/vpu/rk3399_vpu_hw_jpeg_enc.c
> > index 8afa2162bf9f..5f75e4d11d76 100644
> > --- a/drivers/staging/media/rockchip/vpu/rk3399_vpu_hw_jpeg_enc.c
> > +++ b/drivers/staging/media/rockchip/vpu/rk3399_vpu_hw_jpeg_enc.c
> > @@ -137,8 +137,8 @@ void rk3399_vpu_jpeg_enc_run(struct rockchip_vpu_ctx *ctx)
> >  	rk3399_vpu_set_src_img_ctrl(vpu, ctx);
> >  	rk3399_vpu_jpeg_enc_set_buffers(vpu, ctx, src_buf);
> >  	rk3399_vpu_jpeg_enc_set_qtable(vpu,
> > -			rockchip_vpu_jpeg_get_qtable(&jpeg_ctx, 0),
> > -			rockchip_vpu_jpeg_get_qtable(&jpeg_ctx, 1));
> > +				       rockchip_vpu_jpeg_get_qtable(&jpeg_ctx, 0),
> > +				       rockchip_vpu_jpeg_get_qtable(&jpeg_ctx, 1));
> >  
> >  	reg = VEPU_REG_OUTPUT_SWAP32
> >  		| VEPU_REG_OUTPUT_SWAP16
> >   
> 



Thanks,
Mauro

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
