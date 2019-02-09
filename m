Return-Path: <SRS0=BTYN=QQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7282C282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 17:06:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74DC521934
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 17:06:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="a4ouoIWI";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="nGO/7dhj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74DC521934
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=onhfFyncmrKvdyfbSS06ho491Xek3Zt+q8vSo2Sj5+M=; b=a4ouoIWI3cAs0r
	87vu0rv30QEPqtPPfe4jpIKFrbcx6Z32I/RnFnuqHCtRaWEBfa+hbJSsRGqIDVWFPzU1qU/tEau5b
	5LCuk++KulWWW6+rvq8jhMA0bA5avrOlF5oFyTXXQdrEFlR+qAL9c3MJgqUIdLyOovEL2GQkdlC8Z
	yJjatuGFfS1l9xQVB7ixcBYGPZuULy8Uom53Q1moPCiJ/JkePJRZBXAHngSzZI/YbZ7XH/zrOHCDw
	6ETwwLkUIehC9C/d7KnVwCXRVWtLAC7dhet1OuDm6S1gjhItPp8XlQe2OcrmJgs6BAPWEoRPvJKrS
	I541VpwQHEnvBrLaQmjQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gsW4m-0005l9-Lo; Sat, 09 Feb 2019 17:06:00 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gsW4j-0005kd-9d
 for linux-arm-kernel@lists.infradead.org; Sat, 09 Feb 2019 17:05:58 +0000
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net
 [81.96.234.148])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id DFAF72192C;
 Sat,  9 Feb 2019 17:05:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1549731956;
 bh=WNXxYNEpp45e0JzheuLTWXnISOYxdjszVdvBG49Rfk0=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=nGO/7dhjdoaTSV4mElFoglDF5tMSfuMtaWi3+J0wJ5I37hAOA6J+/XSmsaPYBeiVp
 GnUOncuAMr7RUh3nRq8n9WeyDhmjUoc+t5qd5pTiwS02/Zfm9soAtVQWD21nhJmWv1
 gcrMZoL26SAzHZesAorNVjeRWITattl1NGqjwRyE=
Date: Sat, 9 Feb 2019 17:05:51 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Gregory CLEMENT <gregory.clement@bootlin.com>
Subject: Re: [PATCH 1/5] dt-bindings: iio: adc: move lpc32xx-adc out of staging
Message-ID: <20190209170551.38a8e3de@archlinux>
In-Reply-To: <20190208160944.13281-2-gregory.clement@bootlin.com>
References: <20190208160944.13281-1-gregory.clement@bootlin.com>
 <20190208160944.13281-2-gregory.clement@bootlin.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190209_090557_354911_9F6EC81A 
X-CRM114-Status: GOOD (  11.85  )
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
Cc: devicetree@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Hartmut Knaack <knaack.h@gmx.de>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri,  8 Feb 2019 17:09:40 +0100
Gregory CLEMENT <gregory.clement@bootlin.com> wrote:

> The drivers has been moved out since
> 0097e20e7771 ("staging:iio:adc:lpc32xx Move out of staging.") in v4.10,
> so let's align the binding documentation.
> 
> Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
Oops. My fault.

You forgot the iio list on these so +cc

Applied to the togreg branch of iio.git and pushed out as testing for the
autobuilders to play with it.

Thanks,

Jonathan

> ---
>  .../devicetree/bindings/{staging => }/iio/adc/lpc32xx-adc.txt     | 0
>  1 file changed, 0 insertions(+), 0 deletions(-)
>  rename Documentation/devicetree/bindings/{staging => }/iio/adc/lpc32xx-adc.txt (100%)
> 
> diff --git a/Documentation/devicetree/bindings/staging/iio/adc/lpc32xx-adc.txt b/Documentation/devicetree/bindings/iio/adc/lpc32xx-adc.txt
> similarity index 100%
> rename from Documentation/devicetree/bindings/staging/iio/adc/lpc32xx-adc.txt
> rename to Documentation/devicetree/bindings/iio/adc/lpc32xx-adc.txt


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
