From: daniel@caiaq.de (Daniel Mack)
Date: Thu, 12 Nov 2009 23:03:14 +0100
Subject: [PATCH] ARM: Prefix revision number in /proc/cpuinfo
In-Reply-To: <20091112215201.GA12308@n2100.arm.linux.org.uk>
References: <1258034287-4533-1-git-send-email-daniel@caiaq.de>
	<20091112215201.GA12308@n2100.arm.linux.org.uk>
Message-ID: <20091112220314.GS14091@buzzloop.caiaq.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On Thu, Nov 12, 2009 at 09:52:01PM +0000, Russell King - ARM Linux wrote:
> On Thu, Nov 12, 2009 at 02:58:07PM +0100, Daniel Mack wrote:
> > The revision field in /proc/cpuinfo is reported as hex number, so it
> > should have a '0x' prefix to make that clear. Otherwise, parsers
> > will take it as decimal number unless it contains a letter.
> 
> So what you're doing is possibly breaking existing parsers (which
> probably already assume it is hex) to fix buggy parsers?

I wouldn't call that fixing a buggy parser. On my board, the revision is
0x101 which was parsed as 101. You can't know it is in hex unless you
look at the sources.

Daniel
