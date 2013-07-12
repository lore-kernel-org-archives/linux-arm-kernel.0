From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri, 12 Jul 2013 13:47:26 +0200
Subject: v3.10 - big endian core support
In-Reply-To: <CALicx6u89THSiRa4FzGZrcoG8q+o_BD8qVEC4CYXEjPUVK_fJw@mail.gmail.com>
References: <CALicx6u89THSiRa4FzGZrcoG8q+o_BD8qVEC4CYXEjPUVK_fJw@mail.gmail.com>
Message-ID: <20130712134726.0a909165@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Vijay Kilari,

On Fri, 12 Jul 2013 17:09:12 +0530, Vijay Kilari wrote:

> > Ben Dooks has a separate branch on top of this base branch for
> > big-endian support, that adds atags compat code to convert the ATAGs
> > data from LE to BE. See the baserock/311/be/atags branch in
> > git://git.baserock.org/delta/linux. Or
> > http://git.baserock.org/cgi-bin/cgit.cgi/delta/linux.git/log/?h=baserock/311/be/atags.
> 
>  ARM VE TC2 board, enabling CONFIG_THUMB2_KERNEL failed to boot in BE mode
> It hangs at very early stage of boot

Yeah, the Thumb2 code is not supported by Ben Dooks patches, it's part
of the TODO-list. I think Ben said he would probably not have much time
to work on this. I might be able to spare some time on this, so just
let me know if I should start working on this. If I remember correctly,
it's mainly the fixup_pv_table code that needed some Thumb2/BE love.

Will, is getting Thumb2 working a requirement to get the BE support
merged, or can we for now make the BE option depends on !THUMB2_KERNEL ?

Thanks!

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
