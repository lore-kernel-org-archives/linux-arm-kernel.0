From: f.fainelli@gmail.com (Florian Fainelli)
Date: Sun, 03 Apr 2016 18:53:56 -0700
Subject: [RFC PATCH 0/9] ARM: start to move arch/arm/mach-* to
 arch/arm/platforms/*
In-Reply-To: <20160403182543.GQ19428@n2100.arm.linux.org.uk>
References: <1459694367-18635-1-git-send-email-yamada.masahiro@socionext.com>
 <20160403182543.GQ19428@n2100.arm.linux.org.uk>
Message-ID: <58FF13BE-384C-4EF6-9202-E3A57CA7F4FF@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On April 3, 2016 11:25:43 AM PDT, Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:
>On Sun, Apr 03, 2016 at 11:39:18PM +0900, Masahiro Yamada wrote:
>> We have growing number of mach-* directories in arch/arm, and I guess
>> it might be a good time to discuss moving them into a sub-directory.
>
>What does it buy us?  Let me summarise the actual change:
>
>- Move up to 71 arch/arm/mach-* directories to arch/arm/platforms/*,
>  which just means another level of directory structure.  We still
>  end up with up to 71 directories in arch/arm/platforms/
>
>- The ability to use obj-y rather than machine-y, where both already
>  work in the same way.
>
>Is there anything I missed?
>
>If that is all, then I really do not like this change - it's seems
>to be churn for no benefit, and that's something we really should be
>minimising.  Linus Torvalds has historically moaned at the ARM
>architecture for stuff like this.

Agreed, it also makes the life of people back porting, or just  submitting changes harder (even though git does an excellent job at tracking renames). Nack from me.

-- 
Florian
