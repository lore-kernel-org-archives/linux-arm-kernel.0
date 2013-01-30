From: nico@fluxnic.net (Nicolas Pitre)
Date: Wed, 30 Jan 2013 14:07:53 -0500 (EST)
Subject: [RFC PATCH v3 1/2] ARM: kernel: update cpuinfo to print SoC model
 name
In-Reply-To: <1359558091-29251-2-git-send-email-ruslan.bilovol@ti.com>
References: <1359558091-29251-1-git-send-email-ruslan.bilovol@ti.com>
 <1359558091-29251-2-git-send-email-ruslan.bilovol@ti.com>
Message-ID: <alpine.LFD.2.02.1301301402330.6300@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 30 Jan 2013, Ruslan Bilovol wrote:

> Currently, reading /proc/cpuinfo provides userspace with CPU ID of
> the CPU carrying out the read from the file.
> Userspace using this information may decide what module
> to load or how to configure some specific (and processor-depended)
> settings or so.
> However, since really different SoCs can share same ARM core,
> this information currently is not so useful.
> For example, TI OMAP4460 and OMAP4470 SoCs show the same
> information in the /proc/cpuinfo whereas they are different.
> Since in most cases ARM CPU is a part of some system on a chip (SoC),
> the "cpuinfo" file looks like exactly that place, where this
> information have to be displayed.
> 
> So added new line "SoC name" in the "cpuinfo" output for system
> on a chip name. It is placed between CPU information and machine
> information, so the file structure looks gracefully (CPU-SoC-Hardware)
> 
> Example:
> 
> / # cat proc/cpuinfo
> [...]
> CPU variant     : 0x2
> CPU part        : 0xc09
> CPU revision    : 10
> 
> SoC name        : OMAP4470
> 
> Hardware        : OMAP4 Blaze Tablet

Please remove that extra blank line between "SoC name" and "Hardware".  
The blank line after "CPU revision" is fine.

Also, please rename this to "System name".  Not all systems are "on 
chip".  By using "System name" this is more universally useful.


Nicolas
