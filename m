Return-Path: <SRS0=qRPW=OW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02A00C65BAE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 04:08:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C651220811
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 04:08:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="fjX5EWQI";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nic.cz header.i=@nic.cz header.b="DAV3sxeA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C651220811
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nic.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=4byBiXssFpaFlqgomE+zAYuEszzu/3DV4P6wt0ip4Ss=; b=fjX5EWQIP0xHl9
	P4a2yjZ4u+nstQloxf/2TNXvwMQbvJxzcvybC76jnomO3lFntgYw2w3pc+ZwTwrShEh0WZfxb1WId
	LSCPMJDbsI+GpN+AsPfKAjN4h+5IVkYxDW4+Yx3uAWr+xkXDhWD45N2vs6WB/ogB4ubK9fg/nUAhF
	h9oCttAC52VrZRDR5EGD7c7hhy2MGg4TX5BFIcHrjp3dy1y+q8e9grZJgwnmy4IFPuwzOWzLCJBun
	AXj+00sWsvTtfQCpqGs5HCxhZQ/YQuqbUto0sBuU2/ARNFHs1Ui5WdvHjIv7dETZ/ykDMkhmtWGju
	/4pnQlN2JmE9LXkegx2A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXIIq-0005cf-QU; Thu, 13 Dec 2018 04:08:48 +0000
Received: from mail.nic.cz ([217.31.204.67])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXIIn-0005b7-3n
 for linux-arm-kernel@lists.infradead.org; Thu, 13 Dec 2018 04:08:47 +0000
Received: from localhost (unknown [172.20.6.218])
 by mail.nic.cz (Postfix) with ESMTPS id 8A7B162921;
 Thu, 13 Dec 2018 05:08:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nic.cz; s=default;
 t=1544674110; bh=j7Zf0G2rtW7vEnmWtnVZudM/ZAQStV4sQ+VkHkrAlQI=;
 h=Date:From:To;
 b=DAV3sxeApFvxVejH66JVCSG+J/J/utyy7UlVVmP2q4BUNWF1I1hD5XPPHeuunNM40
 xgLQU+IYeaAxR+kxmg+6/Lh++TyupjualS04nXIMBSyfz+kzzghr5rbeS22F8iCRMT
 bJ5J+mlXz0DGkCLujzqbxktI/I9Gsqer3jZDJQgo=
Date: Thu, 13 Dec 2018 05:08:29 +0100
From: Marek Behun <marek.behun@nic.cz>
To: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH RFC] ARM64: dts: marvell: Add DTS file for Turris Mox
Message-ID: <20181213050829.6d942510@nic.cz>
In-Reply-To: <20181204203706.GA25038@bogus>
References: <20181113134408.5681-1-marek.behun@nic.cz>
 <20181204203706.GA25038@bogus>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.99.2 at mail
X-Virus-Status: Clean
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181212_200845_315861_6B1E77FF 
X-CRM114-Status: UNSURE (   7.89  )
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
Cc: devicetree@vger.kernel.org, Gregory CLEMENT <gregory.clement@bootlin.com>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Andrew Lunn <andrew@lunn.ch>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Rob

On Tue, 4 Dec 2018 14:37:06 -0600
Rob Herring <robh@kernel.org> wrote:

> > +
> > +	switch1@2 {  
> 
> Ideally, we shouldn't have this switch0, switch1, etc.

I can rename peridot switches (switch0@10, switch1@11, switch2@12 to
swtich@10, switch@11, switch@12), but I cannot rename Topaz to
switch@2. Topaz always has MDIO address 2, because there can be only
one, but it can be connected either directly or after the first or
second peridot. Therefore I have three different nodes, each describing
different connection to the previous switch/cpu.

How should I rename it?

Marek

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
