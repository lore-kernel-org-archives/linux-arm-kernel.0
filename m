From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Tue, 27 Aug 2013 16:11:17 -0600
Subject: [PATCH 01/15] watchdog: orion: Remove unneeded BRIDGE_CAUSE clear
In-Reply-To: <20130827220431.GJ19598@titan.lakedaemon.net>
References: <1377614079-10000-2-git-send-email-ezequiel.garcia@free-electrons.com>
 <20130827163939.24636d80@skate> <20130827151136.GA10084@localhost>
 <20130827152535.GG19598@titan.lakedaemon.net>
 <20130827191337.GA2339@localhost> <521D063F.4040404@gmail.com>
 <20130827210248.GA19625@obsidianresearch.com>
 <20130827214121.GI19598@titan.lakedaemon.net>
 <20130827235533.2cc85d33@skate>
 <20130827220431.GJ19598@titan.lakedaemon.net>
Message-ID: <20130827221117.GA1324@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 27, 2013 at 06:04:31PM -0400, Jason Cooper wrote:

> I understand that they both *can* use it.  Do any distro's actually use
> it in default configurations?  Do any users actually load it and kick
> the dog in their main loop?

watchdog is always fully optional in distros. Even in x86 where there
is watchdog hardware on every new chipset. It is rare to even see the
kernel modules to enable watchdog loaded (they don't autoprobe for
some reason), let alone the userspace to tickle it.

> I don't have the answers to those questions, but I'd be surprised if it
> was more than a few specialty users.

I thought things were now at the point where orion5x/etc were just
needing a dts file and testing? Is there any more code work required?
Sebastian's IRQ and timer changes seemed like the last of it?

> </pokes self> Once pxa-impedance-matcher can edit the dtb, those users
> would have a means to upgrade to a DT enabled kernel without bootloader
> modifications...  I really gotta get back to that. :)

Doesn't appended dtb already work?

I didn't think bootloader support was a gating item to run with DT??

Jason
