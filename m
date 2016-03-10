From: Dave.Martin@arm.com (Dave Martin)
Date: Thu, 10 Mar 2016 15:40:44 +0000
Subject: ARMv4 (not v4t) marked obsolete in gcc-6
In-Reply-To: <201603101013.04618.arnd@arndb.de>
References: <201603101013.04618.arnd@arndb.de>
Message-ID: <20160310154024.GA23883@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 10, 2016 at 10:13:04AM +0100, Arnd Bergmann wrote:
> I've found out that ARMv3 and ARMv4 is now on track to get removed from gcc in the future,
> so I'm trying to alert everyone that I have knowledge of using ARMv4 based platforms that
> we currenly support in the Linux kernel.
> 
> The architecture has been declared obsolete here: https://gcc.gnu.org/gcc-6/changes.html
> and it will be removed in the following release (gcc-7) one year later, unless someone
> raises concerns over it.
> 
> We will of course be able to compile kernels for a long time using older compilers, but
> this tends to get harder over the years as people upgrade to newer distros.
> 
> Here is an overview of which ARMv4 platforms we still have as of Linux-4.6:
> 
> * Moxart: this is the only one that was recently (2013) added, and is apparently
>   hardware that remains commercially available.
> 
> * Gemini: officially supported in OpenWRT today, with the latest compiler. This one
>   will likely cause the most issues for actual users. It would be helpful to get
>   some numbers about users or downloads here, to see whether it can be dropped
>   in a future OpenWRT release or if it might be possible to leave this on
>   gcc-6.x when the other platforms move on to gcc-7+
> 
> * sa1100: A lot of people have these, but I'm guessing this is mostly interesting
>   for hobbyists that are able to keep using older gcc versions.
> 
> * RiscPC, Footbridge, EBSA110: Classic systems that used to be popular in
>   the past but only remain in small quantities as far as I know. Russell still
>   uses them. He also uses older compilers, so probably isn't affected
>   immediately.
> 
> 	Arnd

_If_ gcc -march=armv4t -marm will still be generating R_ARM_V4BX relocs
and --fix-v4bx is being retained in the linker, then I think compiling
for v4 plain should still be possible, even if ARM/Thumb interworking
is mandatory, IIUC.

I don't know what gcc's plans are relating to that, though.

---Dave
