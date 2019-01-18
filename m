Return-Path: <SRS0=p0aQ=P2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49A95C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 16:38:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1489E20896
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 16:38:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="E3QnTbN8";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="chAcDzdh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1489E20896
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=56oth1wHs90W11GCoxoUOJGsRSNYO1nnDF0GsSlzees=; b=E3QnTbN80e6pRU
	pIvavPK906PfuxVk3jyKQy7tWTXapd/ZWV0EZKjYXwH7mC5sa4jPl5YpOhU4NyZjQP8T85gsGTSxN
	iTzbmAf4IvTtycfnR1JtxicBOSkqzWy3Bh1PS03hwiZJepGglXrAJIiCdtHjljJtHYAiDbIDMNsk5
	fxnTVWNBR8JXSxbNwL6ncWuddrYH7u0OCqVxfasW/6ZXxkzl+xvObNjHiRm/39249bp10AcF1C2d+
	JU9a14eTOZQRiQMdi7QJCwv3IlA4ByeX3uGgxNCrwOZpC02RrftJqnxBiVLCbXke70L4/lGhd7qtI
	kDqCwjpcxsEfJpuVMV0w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkX9l-0002f6-GT; Fri, 18 Jan 2019 16:38:09 +0000
Received: from pandora.armlinux.org.uk
 ([2001:4d48:ad52:3201:214:fdff:fe10:1be6])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkX9R-0002QE-Fm
 for linux-arm-kernel@lists.infradead.org; Fri, 18 Jan 2019 16:37:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=NqdGEANMNH6dnO3JH6obgQjJ9XDpcnvBuNABoxhKWI0=; b=chAcDzdhqYh2+DZRTV362hzgI
 911aQjXCqvvUVUvLFB5yg9Xwkuz3areZJXDfcRbctDlCvuYS7cdWW9jGha+eg779t97Yv7dfHPkbR
 YhJdlqvsAv0Eo9HzTAl2nWLXWVJJO71elM5GcCfrkjrFcjVN+hYwS9p5YOSos6c6HF/lI=;
Received: from e5254000004ec.dyn.armlinux.org.uk
 ([2001:4d48:ad52:3201:5054:ff:fe00:4ec]:37828 helo=shell.armlinux.org.uk)
 by pandora.armlinux.org.uk with esmtpsa
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <linux@armlinux.org.uk>)
 id 1gkX9F-0000Ne-Oz; Fri, 18 Jan 2019 16:37:37 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.89)
 (envelope-from <linux@shell.armlinux.org.uk>)
 id 1gkX9F-0001iJ-38; Fri, 18 Jan 2019 16:37:37 +0000
Date: Fri, 18 Jan 2019 16:37:36 +0000
From: Russell King - ARM Linux admin <linux@armlinux.org.uk>
To: Andrew Murray <andrew.murray@arm.com>
Subject: Re: [Linux-eng] [RFC 0/3] Abstract empty functions with STUB_UNLESS
 macro
Message-ID: <20190118163736.6lczivagpsdnm7ju@e5254000004ec.dyn.armlinux.org.uk>
References: <1547827230-55132-1-git-send-email-andrew.murray@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1547827230-55132-1-git-send-email-andrew.murray@arm.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190118_083749_521377_73920E02 
X-CRM114-Status: GOOD (  10.53  )
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
Cc: Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>,
 Catalin Marinas <catalin.marinas@arm.com>, rjw@rjwysocki.net,
 linux-kernel@vger.kernel.org, Will Deacon <will.deacon@arm.com>,
 Steven Price <Steven.Price@arm.com>,
 Masahiro Yamada <yamada.masahiro@socionext.com>,
 Grant Likely <Grant.Likely@arm.com>, Andrew Morton <akpm@linux-foundation.org>,
 Dave P Martin <Dave.Martin@arm.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Jan 18, 2019 at 04:00:27PM +0000, Andrew Murray wrote:
> A common pattern found in header files is a function declaration dependent
> on a CONFIG_ option being enabled, followed by an empty function for when
> that option isn't enabled. This boilerplate code can often take up a lot
> of space and impact code readability.
> 
> This series introduces a STUB_UNLESS macro that simplifies header files as
> follows:
> 
> STUB_UNLESS(CONFIG_FOO, [body], prototype)

Can you explain the desire to make the second argument optional,
rather than having the mandatory arguments first and the optional body
last?  It will mean more lines at each site, but I don't think that's
a bad thing:

STUB_UNLESS(CONFIG_HAVE_HW_BREAKPOINT,
void hw_breakpoint_thread_switch(struct task_struct *next));

STUB_UNLESS(CONFIG_CPU_FREQ,
struct cpufreq_policy *cpufreq_cpu_get_raw(unsigned int cpu), return NULL);

or:

STUB_UNLESS(CONFIG_CPU_FREQ,
struct cpufreq_policy *cpufreq_cpu_get_raw(unsigned int cpu),
	return NULL);

Seems to be more readable in terms of the flow.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
