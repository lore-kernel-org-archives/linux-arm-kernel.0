From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Sun, 28 Oct 2012 13:28:07 +0100
Subject: [PATCH] arm: bcm2835: enable proc and sysfs in defconfig
In-Reply-To: <508D1A65.20506@mvista.com>
References: <1351357249-17658-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <508D1A65.20506@mvista.com>
Message-ID: <20121028132807.266a1d52@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Sergei Shtylyov,

On Sun, 28 Oct 2012 15:43:33 +0400, Sergei Shtylyov wrote:

> > diff --git a/arch/arm/configs/bcm2835_defconfig b/arch/arm/configs/bcm2835_defconfig
> > index 7aea702..74e27f0 100644
> > --- a/arch/arm/configs/bcm2835_defconfig
> > +++ b/arch/arm/configs/bcm2835_defconfig
> > @@ -66,8 +66,6 @@ CONFIG_TTY_PRINTK=y
> >   # CONFIG_FILE_LOCKING is not set
> >   # CONFIG_DNOTIFY is not set
> >   # CONFIG_INOTIFY_USER is not set
> > -# CONFIG_PROC_FS is not set
> > -# CONFIG_SYSFS is not set
> 
>     Hm, I don't see where are you enabling them... So I miss something?

Yes:

config PROC_FS
        bool "/proc file system support" if EXPERT
        default y

config SYSFS
        bool "sysfs file system support" if EXPERT
        default y

Those options are enabled by default. So, when there's nothing in the
defconfig file to disable them, they are enabled.

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
