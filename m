Return-Path: <SRS0=B2vk=P6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEBB4C282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 12:22:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9A3820879
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 12:22:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="PUk0Vq24";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="P/5oTtX+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9A3820879
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=1jvD+GBH+m3mcuGuwfPqy/gDgC1Q8Atuejg1nUlpTcY=; b=PUk0Vq243e6asw
	hsmOIJLXvI2LVKXuLnfuQGs+QqwMMZUDPp0fB0JIOqFvAPBacWqQuLzsnD88ubz7xpsBxucw8QmQO
	CnH7V7AGFPpUXStSCIihzwFQbcVIfzRW9mafQJU3W0IU/965g0zNuksbSfSnGXXZBaisQwLxSh8yV
	yCzTOIHe9kLvN0PDqkjbkHYblQERNhp/ILp23cXv9lem1lzJClB93IEQYqF4wSifrJlMV0zH+RMWP
	tGZJALt1VMryXlrjlMHlgV8/dnZOHuHEIhFFEZ4FFA6D04+h2yTWeUrWmdB03REW4n0Mw/pk5dGYC
	XcDWh1UZ8GVYELgPXkuA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glv4d-0007no-Q8; Tue, 22 Jan 2019 12:22:35 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glv4a-0007nS-BG
 for linux-arm-kernel@lists.infradead.org; Tue, 22 Jan 2019 12:22:33 +0000
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id C404520879;
 Tue, 22 Jan 2019 12:22:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1548159751;
 bh=2a47g4qcVmJDSPx4VZ30qfymjWEBE3YwXuWATS5DR4E=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=P/5oTtX+JC1vJ0Aq39acLxFZwjkFsGk/BV3sNEsZ0sBN/hwWi04h71g2kImH8F1Wj
 IptE28KzkX+cPAj2KfZRw+oubCiDN5EGMy/5iv+ro3w4RoZfUmV5fmjmaTtXRv5G4E
 moQZVb/CrooWmt7Qu1Ek4g5Fn+qRFdgXLW0WBA4A=
Date: Tue, 22 Jan 2019 13:22:28 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Sekhar Nori <nsekhar@ti.com>
Subject: Re: [RESEND PATCH 00/12] eeprom: at24: remove platform_data
Message-ID: <20190122122228.GA2736@kroah.com>
References: <20190108091539.16674-1-brgl@bgdev.pl>
 <8c190cf3-b4f3-90d0-07ce-4bb7927160df@ti.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <8c190cf3-b4f3-90d0-07ce-4bb7927160df@ti.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190122_042232_432664_95D919FE 
X-CRM114-Status: GOOD (  14.88  )
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
Cc: Arnd Bergmann <arnd@arndb.de>, Kevin Hilman <khilman@kernel.org>,
 Bartosz Golaszewski <brgl@bgdev.pl>, linux-kernel@vger.kernel.org,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>, linux-i2c@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Jan 10, 2019 at 07:43:47PM +0530, Sekhar Nori wrote:
> Hi Bartosz,
> 
> On 08/01/19 2:45 PM, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > 
> > Hi Sekhar,
> > 
> > now that all dependencies are in and v5.0-rc1 is tagged, please consider
> > picking up the second batch of davinci-specific changes into your tree.
> > Once that's done, please provide me with an immutable branch for me to
> > apply the last patch to my at24 tree.
> 
> You can use branch v5.1/eeprom-for-bartosz in my tree for this (commit
> e430685f4969).
> 
> > 
> > This is the second part of the effort to modernize the at24 driver and
> > remove the legacy platform data structure in favor of device properties.
> > It required getting rid of the at24 setup callback in favor of nvmem
> > lookups.
> > 
> > Re-tested with da850-evm and dm365-evm.
> 
> Applied patches 1-11 for v5.1

Feel free to take patch 12 as well :)

thanks,

greg k-h

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
