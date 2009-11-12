From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 12 Nov 2009 21:52:01 +0000
Subject: [PATCH] ARM: Prefix revision number in /proc/cpuinfo
In-Reply-To: <1258034287-4533-1-git-send-email-daniel@caiaq.de>
References: <1258034287-4533-1-git-send-email-daniel@caiaq.de>
Message-ID: <20091112215201.GA12308@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 12, 2009 at 02:58:07PM +0100, Daniel Mack wrote:
> The revision field in /proc/cpuinfo is reported as hex number, so it
> should have a '0x' prefix to make that clear. Otherwise, parsers
> will take it as decimal number unless it contains a letter.

So what you're doing is possibly breaking existing parsers (which
probably already assume it is hex) to fix buggy parsers?
