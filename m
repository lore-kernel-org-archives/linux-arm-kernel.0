Return-Path: <SRS0=2lwk=Q5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A5C4C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 14:11:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC1EE2075A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 14:11:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="tMnx59Si";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="yRA3GFcX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC1EE2075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=3drWI8mXN9ZwMXg11p1S/Em9t7mcpKBJSCjL5SJWY4I=; b=tMnx59SiQ0gXdV
	Beid+d14R8UPeY3pg5+3EHkuIIE5a1tSoF6/HbfcnO0CWhbPW94Hg+NOfA+hv4faXkFm7vjz3OQi4
	S6BjiUuaQGiQ2OKSCLGelnwoNe+9D3xBxHmAn/GdmyJLHAO93PUQa1YRM3A1x7IKZPyoTN3/59zVf
	WelnDlXrF9+nFvYxVHbyh9Mk5c+r4bLRCHT+G/z9G9zaLzKUWcsgcUD7kvi/k9wqKM2gcSDcTJ1RE
	7rc4FPZVfzOK6EnngAOkdq48yCBxGNxCRh7u+7r1c8PQOpq3Z4XczzHHRCOMM81azDAoFVC7RWESn
	+GlK5VScRtbLCW6PMrxQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gxBY6-0006xc-QA; Fri, 22 Feb 2019 14:11:34 +0000
Received: from pandora.armlinux.org.uk
 ([2001:4d48:ad52:3201:214:fdff:fe10:1be6])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gxBY2-0005NX-O0
 for linux-arm-kernel@lists.infradead.org; Fri, 22 Feb 2019 14:11:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=+/7vqQy77FExuuhV6Frm5x3df5XjG08RwQ93AAEhkaM=; b=yRA3GFcXmMQ23/Y9N/Pm2T2Vk
 BQJNptJ/4s1XAfdIPbzoupGT9CHajMkHUNhtys3azbuF2ZhOiHeqC2rYizZpn7mVqaKDMLPuQ0hJ7
 lEEKM6jeKjB9gbQEChX74ff/ROeT6pTRCzIQQBGg7LfXmYtDWJEzt+TZfeS9MsI6djdvMRWlaPiai
 5DJNOaDSha72geBNuRhKJOmzAEpJCEm7kei0VBacbEc79MrgCC+VvaoupZgzgelisnqXOAKU1n/Rc
 H6LItHvFcSUZsF05hwnuc2AMMpYWhT2pmEA+vjKWHOvpiuofnoDFlIRVc0jmVpRYVzUXtOB0351Zl
 TMRO3gyVw==;
Received: from shell.armlinux.org.uk
 ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:51336)
 by pandora.armlinux.org.uk with esmtpsa
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <linux@armlinux.org.uk>)
 id 1gxBVw-0002JD-Ko; Fri, 22 Feb 2019 14:09:20 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.89)
 (envelope-from <linux@shell.armlinux.org.uk>)
 id 1gxBVs-0002Eu-AB; Fri, 22 Feb 2019 14:09:16 +0000
Date: Fri, 22 Feb 2019 14:09:16 +0000
From: Russell King - ARM Linux admin <linux@armlinux.org.uk>
To: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v5 08/23] arm64: compat: Add KUSER_HELPERS config option
Message-ID: <20190222140916.cgnq22trogt4dnzc@shell.armlinux.org.uk>
References: <20190222122430.21180-1-vincenzo.frascino@arm.com>
 <20190222122430.21180-9-vincenzo.frascino@arm.com>
 <20190222140427.GI42419@lakrids.cambridge.arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190222140427.GI42419@lakrids.cambridge.arm.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190222_061130_777279_95FC72FB 
X-CRM114-Status: GOOD (  11.14  )
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
Cc: linux-arch@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
 Arnd Bergmann <arnd@arndb.de>, Catalin Marinas <catalin.marinas@arm.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Will Deacon <will.deacon@arm.com>,
 Ralf Baechle <ralf@linux-mips.org>, Mark Salyzyn <salyzyn@android.com>,
 Paul Burton <paul.burton@mips.com>, Dmitry Safonov <0x7f454c46@gmail.com>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Thomas Gleixner <tglx@linutronix.de>,
 Vincenzo Frascino <vincenzo.frascino@arm.com>,
 Peter Collingbourne <pcc@google.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Feb 22, 2019 at 02:04:27PM +0000, Mark Rutland wrote:
> I believe that Will wanted to default the kuser helpers off, as applications
> using them need the instruction emulation which is also disabled by default.
> 
> I'm also not sure which binaries we expect to work on arm64, so I'm not sure if
> the ARMv4 reference is correct.

Do you expect ARMv4 - even ARMv4 OABI binaries to fail on ARM64?

(I've run my OABI ARMv4 distro under KVM on Macchiatobin when I've
needed to rebuild a RPM without problems - using its own gcc.  No
observable issues.)

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
