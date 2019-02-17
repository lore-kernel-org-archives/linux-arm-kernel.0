Return-Path: <SRS0=tnMb=QY=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D96F2C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 09:51:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A718221900
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 09:51:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GV57bjJH";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lechnology.com header.i=@lechnology.com header.b="SMJ0HNyZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A718221900
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lechnology.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=wn4KhEj7UFnFm7qBugERKFGALHcnWKC2gaVn6icom2M=; b=GV57bjJHFwfm/XEcG/ZUbW00d
	/69Dcivg7kOuMJaqhI1AZsXdGJMzLU22kisuv7Pp8UYpv1R4XvoVSKbSKsHCYJXU5l4WGvayIlu0U
	kOb5qLOqf3zaDtueG/eczUbzlUhXoobDbNJwSLnDhwDvWyaX8brv/wmUNybZYAEX6dr493AkA69bM
	IGvhCneO5rUSAxUzI5lhc0QWkMe1gtrpDVRZsGO1HfIOtnuxizEm1BOBmUts0oW+7Wvwg3QRG3cBt
	uF7h+U+78bd7nmw6bANWyeyuAWBKVp7BSbniF+Hn+/FtvH8dHrTj6UjlzFhTbauzS6jdECICNAQoX
	u9LvwcokA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvJ6p-0008GG-NA; Sun, 17 Feb 2019 09:51:39 +0000
Received: from vern.gendns.com ([98.142.107.122])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvJ6m-0008Ft-0V
 for linux-arm-kernel@lists.infradead.org; Sun, 17 Feb 2019 09:51:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
 In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=/jvlntGlSk+Xlg41FiakC/b0XUQYvDkHsuK6sir2RtE=; b=SMJ0HNyZ775tTE+d/86PonkFX0
 N+1fj8gL8DUctgx28yph5SivVjfEc1v4305gUwBch9XKaNKgo/RvmnlKL072Vlv9gWx7lXdpSq7a0
 rMIswwHf7nE+1BNNRK+qbdT5tdzbdu+bdCDynYpFxXnVtEnIna3BhGqdwssOW7Rsvc+ao90MLhDsm
 PqdZPq5UOYb/Z/mEh09+KDLv1A5uS+dxVNCW4JpNd7WZa0yoVh9pCcOm7Jy7QSMwXNLHl9xSYjfl6
 LxhkuZn7BMQrqbO4GXimk4yjFPJRvR+rw+JNJXNqai2IfcmEEsAqw8MgwTsxXpwpgAe0VREmk4EKs
 hd8vD9gA==;
Received: from [185.122.190.68] (port=25740 helo=gerda-5.local)
 by vern.gendns.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
 (Exim 4.91) (envelope-from <david@lechnology.com>)
 id 1gvJ6a-0007jF-BT; Sun, 17 Feb 2019 04:51:24 -0500
Subject: Re: [PATCH v4 22/37] irqchip: davinci-aintc: move the driver to
 drivers/irqchip
To: Bartosz Golaszewski <brgl@bgdev.pl>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Sekhar Nori <nsekhar@ti.com>,
 Kevin Hilman <khilman@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>
References: <20190214145231.8750-1-brgl@bgdev.pl>
 <20190214145231.8750-23-brgl@bgdev.pl>
From: David Lechner <david@lechnology.com>
Message-ID: <fc4a978b-e8fb-91a5-db24-b4d69ccd2527@lechnology.com>
Date: Sun, 17 Feb 2019 10:51:31 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190214145231.8750-23-brgl@bgdev.pl>
Content-Language: en-US
X-AntiAbuse: This header was added to track abuse,
 please include it with any abuse report
X-AntiAbuse: Primary Hostname - vern.gendns.com
X-AntiAbuse: Original Domain - lists.infradead.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lechnology.com
X-Get-Message-Sender-Via: vern.gendns.com: authenticated_id:
 davidmain+lechnology.com/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: vern.gendns.com: davidmain@lechnology.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190217_015136_130002_FB81DD6E 
X-CRM114-Status: UNSURE (   8.28  )
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
Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 2/14/19 8:52 AM, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> The aintc driver has now been cleaned up. Move it to drivers/irqchip
> where it belongs. There's no device-tree support for any dm* board so
> there's no IRQCHIP_OF_DECLARE() - there's only the exported init
> function called from machine code.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---

Reviewed-by: David Lechner <david@lechnology.com>


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
