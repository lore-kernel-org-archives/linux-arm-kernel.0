From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 1 Mar 2012 20:19:04 +0000
Subject: [PATCH 0/8] ARM: Tegra: cleanup patches from Arnd Bergmann
In-Reply-To: <1330630010-11241-1-git-send-email-alan@signal11.us>
References: <1330630010-11241-1-git-send-email-alan@signal11.us>
Message-ID: <201203012019.04316.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 01 March 2012, Alan Ott wrote:
> I'm helping Arnd Bergmann get some of his cleanup patches upstream. This
> set covers the Tegra.
> 
> Thanks,
> 
> Alan.
> 
> Arnd Bergmann (8):
>   ARM: tegra: export tegra_gpio_{en,dis}able
>   ARM: tegra: do not hide dma declarations
>   ARM: tegra: select CPU_FREQ_TABLE
>   ARM: tegra: build localtimer support only when needed
>   ARM: tegra: work around tegra THUMB2_KERNEL bug
>   ARM: tegra: USB_ULPI needs USB
>   ARM: tegra: export usb phy symbols
>   ARM: tegra: HACK: remove set_irq_flags() from driver
> 

Hi Alan,

Thanks for getting this started!

As Greg already commented, there are some patches that you
should probably drop. When you send out a series with the
name of a subarchitecture, it's best to leave out the patches
that only address device drivers. I had initially sorted these
into the subarch series instead of the drivers series but that
turned out to be a bad idea. Sorry I didn't remember about this
detail when we first discussed the way forward on my patches.

Also, it's better if you have a slightly shorter Cc list and
for each patch take only the people on Cc that are actually
interested, rather than send the whole series to everyone
that get_maintainer.pl lists for one of the patches. If the
Cc list gets too long, that often means that the mails get
dropped from the mailing lists, and people might ignore them
when they don't understand why they were on Cc to start with.
It does help to have everyone on Cc for the initial mail though.

You can add 'Cc:' tags in the individual patches to help you
with that. This is another thing I never got around to for
the patches I did not send out.

Finally, when sending patches from someone else, you have
to add your own Signed-off-by: line below the others (i.e. mine).
Everyone who is handling the patch by sending it to someone
else should have a Signed-off-by in the email until the
point when it gets applied to a git tree that is pulled into
the Linus' tree.

	Arnd
