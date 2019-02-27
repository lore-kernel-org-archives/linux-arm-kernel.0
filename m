Return-Path: <SRS0=CF3g=RC=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B41E1C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 15:05:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8140D2184A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 15:05:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="TZMJ6OzW";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="IwiUPDIM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8140D2184A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=4w0jHqtH+ATOM8GAsttYdeoEbBc8UVaKMhK/E4pvWOY=; b=TZMJ6OzWp24r6j
	oLIkv4s62jKHETFFEjhGyVKiYQd6Lp1jKajVy9fMPTnt1eijiVKgjCi3cV4cUy9sAGasa52IC/VTX
	sw84xLTQV0aqPnIGnbhY1KSdAPkN1AvvLJbkOcLd9itqfB4ZQxsjCfStwljQ4t6uFrvrVBaaPRDJs
	3gULbc6vg7tf7y8yFJLMArvNSraHj+1D7Jb40gQNzEvcoD9VUdLE6mkil2hA6lAA3Gd+FPcC05vdG
	qaeHPNQScZfoNAusbEPC1Cs6ZsW8ysLMM93DDxFzaIFKD7AI5X3PeV/tD/b7vlgovfHOA1pd6nwjQ
	wncbXN2Qa9+vplYDyqaw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gz0la-0002kI-3d; Wed, 27 Feb 2019 15:05:02 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gz0lR-0002jR-D1
 for linux-arm-kernel@lists.infradead.org; Wed, 27 Feb 2019 15:04:58 +0000
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 40BC62184A;
 Wed, 27 Feb 2019 15:04:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1551279892;
 bh=2QWv8Act9X7mmWlRFXS4rlbrs+OxCMh4QEMVObmHD4s=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=IwiUPDIMFf4Tm0n7/M9VTVXzb+mCDGQytvfjhkKmt0+5FK8uq++e6bAHAToH0mS3H
 gODFx8Vv8+bbHzCrvUWTnfwrEBoar4WbXU56GqHVmfZpjRb5O1knLqfI3KS16KbwvM
 jnZVjyQQBzhaB9WdSN9a3M/x6I0RC+S85iESBsjA=
Date: Wed, 27 Feb 2019 16:04:50 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Sugaya Taichi <sugaya.taichi@socionext.com>
Subject: Re: [PATCH v4 07/10] dt-bindings: serial: Add Milbeaut serial driver
 description
Message-ID: <20190227150450.GA7056@kroah.com>
References: <1551243210-10826-1-git-send-email-sugaya.taichi@socionext.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1551243210-10826-1-git-send-email-sugaya.taichi@socionext.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190227_070453_452367_1AB525ED 
X-CRM114-Status: GOOD (  10.52  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 Masami Hiramatsu <masami.hiramatsu@linaro.org>,
 Shinji Kanematsu <kanematsu.shinji@socionext.com>,
 linux-kernel@vger.kernel.org, Jassi Brar <jaswinder.singh@linaro.org>,
 soc@kernel.org, Rob Herring <robh+dt@kernel.org>, linux-serial@vger.kernel.org,
 Takao Orito <orito.takao@socionext.com>,
 Kazuhiro Kasai <kasai.kazuhiro@socionext.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Feb 27, 2019 at 01:53:30PM +0900, Sugaya Taichi wrote:
> Add DT bindings document for Milbeaut serial driver.
> 
> Signed-off-by: Sugaya Taichi <sugaya.taichi@socionext.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
>  .../devicetree/bindings/serial/milbeaut-uart.txt    | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/serial/milbeaut-uart.txt

I have already queued this up in my tty tree for merging in 5.1-rc1.

thanks,

greg k-h

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
