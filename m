From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 16 Aug 2011 11:35:08 +0200
Subject: PB1176 broken in -rc1
In-Reply-To: <20110816092615.GC28656@e102144-lin.cambridge.arm.com>
References: <20110810152400.GO10121@e102144-lin.cambridge.arm.com>
	<CACRpkdaoDJy-YKONaz2j07pPvTZuHZ7KgEm6XGxNXK-jNzB8_w@mail.gmail.com>
	<20110816092615.GC28656@e102144-lin.cambridge.arm.com>
Message-ID: <CACRpkdbSG=Mnu7QrACn3y3GP-2H4_qT0kR_4C8umCmWc2YCqXQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 16, 2011 at 11:26 AM, Will Deacon <will.deacon@arm.com> wrote:

>> Will, Jamie, any hints?
>
> Can you make your .config available somewhere please?

http://www.df.lth.se/~triad/realview_config

Basically that's the realview_defconfig with these
changes done on top:

scripts/config --file $(realview_dir)/.config \
        --enable BLK_DEV_INITRD \
        --set-str INITRAMFS_SOURCE rootfs-u338.cpio \
        --enable INITRAMFS_COMPRESSION_NONE \
        --enable MISC_DEVICES \
        --enable ARM_CHARLCD \
        --enable DEBUG_LL \
        --enable EARLY_PRINTK \
        --enable ARM_TEST \
        --enable ARM_TCM_TEST \
        --set-str CMDLINE "root=/dev/ram0 console=ttyAMA0 earlyprintk mem=128M"
        yes "" | make $(make_options) oldconfig


> It sounds like an unrelated issue, so let's try to track it down.

Thanx!

> How do you use the interface
> with the TCMs once they've been mapped at the high address?

Here is my test code patch I'm cooking RFC:

------------8<-----------------------------8<-----------------------------
