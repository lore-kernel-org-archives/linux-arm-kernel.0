From: avorontsov@mvista.com (Anton Vorontsov)
Date: Wed, 2 Jun 2010 16:29:44 +0400
Subject: [PATCH 3/4] ARM: cns3xxx: Add support for AHCI controllers
In-Reply-To: <4C0623D8.6030701@ru.mvista.com>
References: <20100601165409.GA29614@oksana.dev.rtsoft.ru>
	<20100601165540.GC7123@oksana.dev.rtsoft.ru>
	<4C0623D8.6030701@ru.mvista.com>
Message-ID: <20100602122944.GA11087@oksana.dev.rtsoft.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 02, 2010 at 01:26:48PM +0400, Sergei Shtylyov wrote:
[...]
> >+	tmp = MISC_SATA_POWER_MODE;
> >+	tmp |= 0x1 << 16; /* Disable SATA PHY 0 from SLUMBER Mode */
> >+	tmp |= 0x1 << 17; /* Disable SATA PHY 1 from SLUMBER Mode */
> >+	MISC_SATA_POWER_MODE = tmp;
> 
>    Why aren't you using I/O accessors?

For CNS3xxx __raw_{read,write} are equivalent to direct accesses,
and originally Cavium used registers directly just because it was
easier (less keystrokes, quite understandable).

Ben Dooks also pointed out this concern, and I agree that using
IO accessors would be a good cleanup.

As I'm going to send other improvements, I think I'll fix this for
all CNS3xxx code base on top of this pull request, if nobody minds.

Thanks!

-- 
Anton Vorontsov
email: cbouatmailru at gmail.com
irc://irc.freenode.net/bd2
