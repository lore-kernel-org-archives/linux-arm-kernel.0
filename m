From: jason@lakedaemon.net (Jason Cooper)
Date: Wed, 28 Aug 2013 08:02:42 -0400
Subject: [PATCH 01/15] watchdog: orion: Remove unneeded BRIDGE_CAUSE clear
In-Reply-To: <20130827221117.GA1324@obsidianresearch.com>
References: <20130827163939.24636d80@skate> <20130827151136.GA10084@localhost>
 <20130827152535.GG19598@titan.lakedaemon.net>
 <20130827191337.GA2339@localhost> <521D063F.4040404@gmail.com>
 <20130827210248.GA19625@obsidianresearch.com>
 <20130827214121.GI19598@titan.lakedaemon.net>
 <20130827235533.2cc85d33@skate>
 <20130827220431.GJ19598@titan.lakedaemon.net>
 <20130827221117.GA1324@obsidianresearch.com>
Message-ID: <20130828120242.GK19598@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 27, 2013 at 04:11:17PM -0600, Jason Gunthorpe wrote:
> On Tue, Aug 27, 2013 at 06:04:31PM -0400, Jason Cooper wrote:
> > </pokes self> Once pxa-impedance-matcher can edit the dtb, those users
> > would have a means to upgrade to a DT enabled kernel without bootloader
> > modifications...  I really gotta get back to that. :)
> 
> Doesn't appended dtb already work?

Yes, but this allows you to append N dtbs, and select from them based on
any silly code you need to overcome vendor 'creativeness'.  Also, you
can handle non-standard atags without polluting (or at least attempting
to) atags_to_fdt.c.  eg ethernet address passing.

It should also allow Thomas to implement his CP15 hack to detect where
the bootloader mapped the register base address, and update the dtb
accordingly.

iow, it's a dirty place to work around any unforseen bootloader code
without polluting the kernel.

thx,

Jason.
