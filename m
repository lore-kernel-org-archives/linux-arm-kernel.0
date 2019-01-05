Return-Path: <SRS0=qjmB=PN=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C89AC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 16:45:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E401208E3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 16:45:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WxjECUIZ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="TaAQXZbl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E401208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=UhL7yBJzN7pjBQI2J9zySq6U2XaHFeVhGatow6EdOKY=; b=WxjECUIZAUaygz
	C2QKMu+8Z9akpFxMXBZymdOeCDjQxa+8cS6vhycRuvd4FK/p04JhxtGpzMigggZL5OmgfSQwGlw5r
	66uOA9mehf7vMN5hRuAIibHD3LIbMixZzQjy9cALKye9UnUiSDXQzjKdp8UGmSJXDxRTYdu8mIU6I
	dFgrhxZ/0IHCRmARMIkKFS7TYyMyrRCZ+cAgqlAgTWOKKEi7hVk+tXNoDYXuHuIdLPSddS63W4lpT
	9ay+Zb2NlsBRNuPMORpun5tepEIlAcQXUgEZTMIJXQiXw+LgbgMG9lCiinArhsdg/l59swZCD4gTf
	3C/s0g/a3LwsiH36KGfA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gfp4j-00050L-No; Sat, 05 Jan 2019 16:45:29 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gfp4h-0004zz-0Q
 for linux-arm-kernel@lists.infradead.org; Sat, 05 Jan 2019 16:45:28 +0000
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net
 [81.96.234.148])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id C6CD620868;
 Sat,  5 Jan 2019 16:45:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1546706726;
 bh=d4uGYWaRaXbN5bN8zOAvu7q+clbKfknzepFJ/pXx+EA=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=TaAQXZblzDYx8X1nzk7g20hkvRzpuJBAtFWPWbl9sAiRUx1XoETcmczUC0pgsE9e4
 0kLqa/VEnDQWq1UNhlRqndJs6pEOh9gZCJl6Vp0hpvYE5e0wtbH0Q0xH8RDCbJOnEs
 idCEo3iS4XgutzSzZVF0LIHaIdC2UVz7aVYcDLm8=
Date: Sat, 5 Jan 2019 16:45:21 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Michal Simek <michal.simek@xilinx.com>
Subject: Re: [PATCH] iio: adc: xilinx: check return value of xadc_write_adc_reg
Message-ID: <20190105164521.458a08e8@archlinux>
In-Reply-To: <bfd90c61-233f-b200-a8f2-f1dc2bb4c003@xilinx.com>
References: <20181227195454.26344-1-pakki001@umn.edu>
 <bfd90c61-233f-b200-a8f2-f1dc2bb4c003@xilinx.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190105_084527_070403_CF393C81 
X-CRM114-Status: GOOD (  15.77  )
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
Cc: Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
 Aditya Pakki <pakki001@umn.edu>, kjlu@umn.edu, linux-kernel@vger.kernel.org,
 Manish Narani <manish.narani@xilinx.com>,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Hartmut Knaack <knaack.h@gmx.de>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, 3 Jan 2019 12:16:49 +0100
Michal Simek <michal.simek@xilinx.com> wrote:

> On 27. 12. 18 20:54, Aditya Pakki wrote:
> > In function xadc_probe, xadc_write_adc_reg can return an error value
> > when write fails. The fix checks for the return value consistent with
> > other invocations of the latter function.
> > 
> > Signed-off-by: Aditya Pakki <pakki001@umn.edu>
> > ---
> >  drivers/iio/adc/xilinx-xadc-core.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/iio/adc/xilinx-xadc-core.c b/drivers/iio/adc/xilinx-xadc-core.c
> > index 3f6be5ac049a..b13c61539d46 100644
> > --- a/drivers/iio/adc/xilinx-xadc-core.c
> > +++ b/drivers/iio/adc/xilinx-xadc-core.c
> > @@ -1273,8 +1273,10 @@ static int xadc_probe(struct platform_device *pdev)
> >  			xadc->threshold[i] = 0xffff;
> >  		else
> >  			xadc->threshold[i] = 0;
> > -		xadc_write_adc_reg(xadc, XADC_REG_THRESHOLD(i),
> > +		ret = xadc_write_adc_reg(xadc, XADC_REG_THRESHOLD(i),
> >  			xadc->threshold[i]);
> > +		if (ret)
> > +			goto err_free_irq;
> >  	}
> >  
> >  	/* Go to non-buffered mode */
> >   
> 
> Reviewed-by: Michal Simek <michal.simek@xilinx.com>
> 
Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan

> Thanks,
> Michal


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
