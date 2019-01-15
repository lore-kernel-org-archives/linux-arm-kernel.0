Return-Path: <SRS0=3lKL=PX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4A84C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 17:04:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3EE420675
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 17:04:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="mRhmUHtW";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="AqE0Vwi1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3EE420675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=xBk3rvftIOXvrzIrL87VU7rs1F4tS88SfJ8qSDJkwUM=; b=mRhmUHtW4hL4FC
	srysP1dvA2fFmxEV1SZTlA/481PlbjamjqmATAuF2oqoWNHpvRnf4GtwJl6ulBax0ddhbQnGU7sb7
	Bd9dIg4n1l/rVRu2DeDNqOpoj930CpXe3CDxKGABj8uFES5LoUwViOaiu6cxoqMHzfy4iNtgh7YX1
	UuMtenVaJiOwAPmsaKZZT0ADcbCq+Ys49lVmvJJuv97tLMtHAyqf1BlDowYh9M7uyeyhlN83RW2O9
	1Z9XXI7HbijGDe7mX0KQNRbHZDU+VYmo5ldKHLx+FP9YmH1bDXz2szJVBVCncocfYstJUnZC8sQxD
	X5nu4nDDpNoK/Umlj4mw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjS8a-0001Cy-Q6; Tue, 15 Jan 2019 17:04:28 +0000
Received: from pandora.armlinux.org.uk
 ([2001:4d48:ad52:3201:214:fdff:fe10:1be6])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjS8V-0001Ce-CM
 for linux-arm-kernel@lists.infradead.org; Tue, 15 Jan 2019 17:04:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=gLgm24oPY5w6kZYRtI8PNkX2DEYk176OHCOkKdm3T8k=; b=AqE0Vwi1ghwnuvFMY83ZFqT+g
 eGUz4ZukZqRWeASXZ3gwhVNUbXlAGIIaidCjgZvjRzjD1mBa/+rEnISDbQlC1dhxpGjHRnx2rS0vR
 IQS3lLTHm64OWM/L87Se/zyQAEsF31cnwFRLgFuO5beYb1+FB2q0BPpsCVVKzOH8UFtZQ=;
Received: from e5254000004ec.dyn.armlinux.org.uk
 ([2002:4e20:1eda:1:5054:ff:fe00:4ec]:35778 helo=shell.armlinux.org.uk)
 by pandora.armlinux.org.uk with esmtpsa
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <linux@armlinux.org.uk>)
 id 1gjS8O-0006rE-EH; Tue, 15 Jan 2019 17:04:16 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.89)
 (envelope-from <linux@shell.armlinux.org.uk>)
 id 1gjS8N-0005M5-Ov; Tue, 15 Jan 2019 17:04:15 +0000
Date: Tue, 15 Jan 2019 17:04:15 +0000
From: Russell King - ARM Linux admin <linux@armlinux.org.uk>
To: Vincent Whitchurch <vincent.whitchurch@axis.com>
Subject: Re: [PATCH] ARM: Implement pgprot_device()
Message-ID: <20190115170415.hkt2kllktxseypdw@e5254000004ec.dyn.armlinux.org.uk>
References: <20190114135638.13520-1-vincent.whitchurch@axis.com>
 <20190115102428.yji6viia4lfhecqz@e5254000004ec.dyn.armlinux.org.uk>
 <20190115150816.352ujzjaszj2pbch@axis.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190115150816.352ujzjaszj2pbch@axis.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190115_090424_844343_FA66A9F8 
X-CRM114-Status: GOOD (  17.12  )
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

On Tue, Jan 15, 2019 at 04:08:16PM +0100, Vincent Whitchurch wrote:
> The login page in the patch system doesn't seem to work if I go to it
> from the https://www.armlinux.org.uk/developer/ page.  I always get the
> "Error: The server detected that the session cookie was not retained by
> your browser, or returned to the server..." message.  It only works if I
> go to the login page
> (https://www.armlinux.org.uk/utils/login.php?url=/developer/) directly
> in a new incognito browser session.
> 
> I've tried several different browsers from two different networks so it
> seems unlikely that the problem is on the client side.
> 
> Attempting to log in (from the incognito session) results in:
> 
>  Could not get user id: SQLSTATE[42000]: Syntax error or access
>  violation: 1064 You have an error in your SQL syntax; check the manual
>  that corresponds to your MySQL server version for the right syntax to
>  use near 'foo@bar.com'' and password=PASSWORD(''foo'')' at line 1

Argh, soo many problems!  Okay, should be resolved, and I hope I got
all the places where <unprintable> PHP has changed. ;)  Sorry about
that.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
