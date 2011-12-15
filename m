From: jkrzyszt@tis.icnet.pl (Janusz Krzysztofik)
Date: Thu, 15 Dec 2011 02:28:34 +0100
Subject: [PATCH] ARM: fix $(CROSS_COMPILE) prefix missing from size
 invocation
In-Reply-To: <20111214215815.GP32251@atomide.com>
References: <1322186338-6020-1-git-send-email-jkrzyszt@tis.icnet.pl>
 <201112140021.42598.jkrzyszt@tis.icnet.pl>
 <20111214215815.GP32251@atomide.com>
Message-ID: <201112150228.34815.jkrzyszt@tis.icnet.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 14 of December 2011 at 22:58:15, Tony Lindgren wrote:
> * Janusz Krzysztofik <jkrzyszt@tis.icnet.pl> [111213 14:55]:
> > On Friday 25 of November 2011 at 02:58:58, Janusz Krzysztofik wrote:
> > > Otherwise, cross compilation may fail with error messages like:
> > > 
> > > ...
> > > size: arch/arm/boot/compressed/../../../../vmlinux: File format is ambiguous
> > > size: Matching formats: elf32-littlearm elf32-littlearm-symbian elf32-littlearm-vxworks
> > >   LD      arch/arm/boot/compressed/vmlinux
> > >   arm-angstrom-linux-uclibcgnueabi-ld:--defsym _kernel_bss_size=: syntax error
> > > 
> > > Signed-off-by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
> > 
> > Trying to guess why this patch is still sitting in the Incoming queue in 
> > the Russell's patch system (7184/1) while others have found their way to 
> > the Applied queue meanwhile, I wonder if this is because I didn't 
> > mention explicitly that it is a fix to a regression introduced into 
> > 3.2-rc with the following commit:
> 
> It's because not all cross compiler in use have $(CROSS_COMPILE)size
> available, so it would have to be symlinked to host size to keep things
> compiling. So it's probably best to rather take the warning and keep
> things compiling rather than fix the warning and break compile for
> many people.

First of all, thanks for someone finally commenting the patch. It's really hard for me to guess if a patch is OK or not if I hear nothing. Once I hear from someone what is wrong with my patch, I'm always willing to enhance it. But I feel more and more like an intruder on the linux-arm-kernel list.

Back to the merit: I would take that warning, as you suggest, if things were compiling for me, but it's not the case. Compilation fails, as I tried to state in the commit message. The patch was not about fixing the warning, but fixing the compilation broken. Since things worked for me before, I find it a regression. Sorry if I was not clear enough in the commit message.

I'll prepare v2 which will call $(CROSS_COMPILE)size if size fails, OK?

Thanks,
Janusz
