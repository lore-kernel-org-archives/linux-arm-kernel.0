From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 27 Apr 2016 11:49:18 +0100
Subject: [PATCH 3/3] ARM: domain: move {set, get}_domain under config guard
In-Reply-To: <1461325416-29570-4-git-send-email-vladimir.murzin@arm.com>
References: <1461325416-29570-1-git-send-email-vladimir.murzin@arm.com>
 <1461325416-29570-4-git-send-email-vladimir.murzin@arm.com>
Message-ID: <20160427104918.GQ19428@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 22, 2016 at 12:43:36PM +0100, Vladimir Murzin wrote:
> Domains is not available on !MMU cores, like R/M class. However,
> currently guarding manages M-class only, for the R-class, in case
> of fault we get in recursive "undefined instruction" faulting because
> __show_regs() tries to get domain information.
> 
> Fix it by extending CONFIG_CPU_USE_DOMAINS on {set,get}_domain
> functions and providing stubs for the case where Domains is not
> supported.

Huge big bloody NAK.

I think it would be useful if you read the history of the file,
particularly looking at commit a5e090acbf545c0a3b04080f8a488b17ec41fe02.

It really amazes me how people propose patches which undo bits of
previous patches without making comments about it.

No way is this patch going in, which has the effect of completely
disabling SW PAN, sorry.

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
