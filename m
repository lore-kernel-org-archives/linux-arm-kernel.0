From: tony@atomide.com (Tony Lindgren)
Date: Tue, 8 Sep 2015 07:38:11 -0700
Subject: mysterious crashes on OMAP5 uevm
In-Reply-To: <CANOLnOO3NdK1r1jZQtS=TcHEE7SQwhGHh0YsqqoCJpFW3NO05Q@mail.gmail.com>
References: <CANOLnOO3NdK1r1jZQtS=TcHEE7SQwhGHh0YsqqoCJpFW3NO05Q@mail.gmail.com>
Message-ID: <20150908143810.GD4215@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Grazvydas Ignotas <notasas@gmail.com> [150908 05:50]:
> Hi,
> 
> this is a longstanding problem I'm seeing since the very beginning,
> which was around 3.12 or so (when I've first got the hardware) and it
> seems 4.2 is affected by it still. Basically what happens is Xorg
> randomly segfaults at some "impossible" location. I don't have the
> details at the moment (could get them is needed), but from what I
> examined with gdb some time ago the situation did not make any sense.
> 
> There are 2 workarounds that I know which make the problem go away
> (one is enough):
> - recompile Xorg with -marm (I'm using Debian armhf so it's thumb2 by default)
> - disable ARCH_MULTI_V6 in the kernel config
> 
> Because of the above workarounds I have forgotten about it several
> times, but it regularly comes back and bites again. It would look like
> some missing erratum workaround, but I have all of them enabled in the
> kernel.
> 
> Does anyone know about this? Perhaps some missing erratum workaround
> in the bootloader? u-boot isn't too old here (2015.07).

Seems like some incorrect handling with CONFIG_CPU_V6 compiled in.. 
Maybe try to narrow it down by commenting out some CONFIG_CPU_V6 and
__LINUX_ARM_ARCH__ = 6 ifdefs in the git grep CONFIG_CPU_V6
places ignoring uncompress and davinci code.

Do you have some easy way to reproduce this issue?

Regards,

Tony
