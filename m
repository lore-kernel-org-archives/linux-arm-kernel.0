Return-Path: <SRS0=x1Tr=QU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6815C282CA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 03:35:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8652421905
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 03:35:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="g2TB+8wu";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="bBEj64mk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8652421905
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=gOypA3MknbuWG/knBnorCB0jaya4Oe//ScBbbYs7ki0=; b=g2TB+8wuLOUnbY
	9rNOjEQ/ePHHY7je40QRJXVDlmYTMZr0g0r4Kaiwu/e19ROX+Ly0y/TW6zq+N9/IyOIzkSykNDMJA
	xncVkYEc5INQFfXtX17E2MZ/oXLuNWF1A/HiW8Bv4tBzWX0djgy9pqK6I09s5e/rOz4x0Idr21hfp
	QQgYB0sKyqMpLxEnze0hnOatCbnO1HaUpO+fG3gDhCCaT44gnpL4q/SF0iPl0waTjW/f+BHQ4ZURj
	Ki2xS+bemO4eZAo9ch0s/zdqBTlto8r/m4Kbuo0e31n3iYAoR3A8O3k1v+wDoEPzcdhuzE1SF6kdD
	i6eGapuVPlnyRZTwiJuw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtlK9-00068L-9G; Wed, 13 Feb 2019 03:35:01 +0000
Received: from vps0.lunn.ch ([185.16.172.187])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtlK5-00067b-Tp
 for linux-arm-kernel@lists.infradead.org; Wed, 13 Feb 2019 03:34:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
 s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
 Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=ii43ULNnlduPsPypx4gQnpVpxjmmHvrGE4eRGScJFuQ=; b=bBEj64mk9Xw9NfumUahvr0UQWL
 Shpjb4rtr2/Tw6wt2w76j/EoULEkUPDP8qgfh/JMiSxkci5sIVYPaHNIcNTQ7XsJYR8lCYzefPJ/X
 ZW8bucpPbZw5/KWYsjHlN9yO5hK1kRLUBSYY9xDXqDNsJ8tcxFsiYLp5uPydJwTJRM6Y=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
 (envelope-from <andrew@lunn.ch>)
 id 1gtlJz-0002V7-Dh; Wed, 13 Feb 2019 04:34:51 +0100
Date: Wed, 13 Feb 2019 04:34:51 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH 1/2] ARM: dts: vf610-zii: Disable SNVS RTC
Message-ID: <20190213033451.GF7527@lunn.ch>
References: <20190213014549.29283-1-festevam@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190213014549.29283-1-festevam@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190212_193458_113630_9AD4499C 
X-CRM114-Status: UNSURE (   8.53  )
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
Cc: andrew.smirnov@gmail.com, shawnguo@kernel.org,
 linux-arm-kernel@lists.infradead.org, cphealy@gmail.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Feb 12, 2019 at 11:45:48PM -0200, Fabio Estevam wrote:
> None of these vf610-zii boards have a battery or super-capacitor
> holding up power to the SNVS RTC embedded in the Vybrid SoC,
> so it is preferable to disable the snvsrtc node.

Hi Fabio

Another vf610-zii board was merged last week, ssmb-dtu. You might want
expand your patch to include that.

       Andrew

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
