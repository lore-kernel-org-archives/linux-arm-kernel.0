Return-Path: <SRS0=P47x=QF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B993AC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 15:33:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88EF5214DA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 15:33:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="NiTxr9u3";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="THie7EF4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88EF5214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=brVMzYysQTej+Zaq25/VGOjw7YwGKueYSP3xz8cIBxI=; b=NiTxr9u34wu1sI
	zUrz94FBMJR2GehZQSNZouhCMEtph/jCf4o9gj1QNqbog52zOe8pkZpheMcy3Sph3CbANVYKu4sty
	SnIzZie+7CnwwwmFgoDjM1K3SWFclaSQ7HnNDT5AnxkrT8rEDM9yXiOaFT5ZN0I+onH5ML43y5mgs
	m+baLRwCVQ+/uv8/X9xO9p0tnynA23CGGoG9Y6CTLoNtts1zo2LMVVOfOsq9YW0N54Qsn1iS18HwT
	K9QaTTeX7/1T4Ya5gzm8o1yDN+7FP6rA1dsEVry8EreaEoFTDybwwMtvN5JmxSY00Dy9pZoYSresH
	FeqszUtGRjHjJyzVOPgw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goVOT-0001tl-ME; Tue, 29 Jan 2019 15:33:45 +0000
Received: from vps0.lunn.ch ([185.16.172.187])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goVOL-0001tH-7U
 for linux-arm-kernel@lists.infradead.org; Tue, 29 Jan 2019 15:33:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
 s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
 Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Ech6LQApp5+VSjWtRXNAFzld7l4UlkWMfs3igj9l97Q=; b=THie7EF4/HrClM+Bfa8T7DJRNs
 kcSxVkUhslcOtrkvK3bW36KFPkcPQgjxAvHkJ9jMAb1Afom6eSZcVXScZWWQYGUoUJ1x52DhvPSjf
 LKztFhSNQbT5/pDWY8pJCV0/D6UJr9V1H+d0zbN5eZMJx3noZEqjJ+0fQq4sndJiW5wg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
 (envelope-from <andrew@lunn.ch>)
 id 1goVOI-00024N-Fl; Tue, 29 Jan 2019 16:33:34 +0100
Date: Tue, 29 Jan 2019 16:33:34 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Russell King <rmk+kernel@armlinux.org.uk>
Subject: Re: [PATCH] ARM: add "8<--- cut here ---" to kernel dumps
Message-ID: <20190129153334.GO4765@lunn.ch>
References: <E1goUA9-0003OK-TE@rmk-PC.armlinux.org.uk>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <E1goUA9-0003OK-TE@rmk-PC.armlinux.org.uk>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190129_073339_267413_F90FAE3D 
X-CRM114-Status: UNSURE (   9.33  )
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
Cc: linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Jan 29, 2019 at 02:14:53PM +0000, Russell King wrote:
> Add a "8<--- cut here ---" marker to kernel dumps to help users cut
> the dump at the right place when emailing list, rather than cutting
> off the first line which gives the reason for the dump.

Hi Russell

Good idea.

Is it worth also putting a marked at the end? I sometime get crash
dumps with the stack trace chopped off.

Thanks
	Andrew

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
