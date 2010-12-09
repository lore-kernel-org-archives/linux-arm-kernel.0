From: vapier@gentoo.org (Mike Frysinger)
Date: Thu, 9 Dec 2010 11:07:49 -0500
Subject: [PATCH (sh-2.6) 1/2] sh: add stack smashing protection support
In-Reply-To: <4D00FC2A.8040309@st.com>
References: <1291717254-17455-1-git-send-email-filippo.arcidiacono@st.com>
	<20101208044052.GA31508@linux-sh.org> <4D00FC2A.8040309@st.com>
Message-ID: <201012091107.51911.vapier@gentoo.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, December 09, 2010 10:56:26 Carmelo AMOROSO wrote:
> I agree with you that the Kconfig and Makefile changes are not arch
> specific, so these changes can be moved to a common code (even if I
> don't know if other archs do support SSP).
> In the current kernel, only x86 and ARM added this support, so I'm
> wondering if, moving SSP to the common Makefile, it needs to depend on
> x86, ARM, SH being configured ?

i'm not sure it does.  ssp is designed to be arch independent, so really you 
only need a new enough gcc version.  which means i dont think it needs to 
depend on any arch code and you can simply add to the Makefile a compiler 
check.

> Regarding the __stack_chk_guard symbol defined in process[_32].c, I
> don't know if all archs need to define this global variable to implement
> SSP. For sure x86 does not need it. It depends on how the gcc implements
> this feature. This was mainly the reason for which we defined it
> specifically in an arch specific code.

the common gcc code too outputs __stack_chk_guard references.  none of that is 
in arch-specific places.
-mike
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20101209/18ba3db9/attachment-0001.sig>
