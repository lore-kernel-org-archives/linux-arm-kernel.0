From: nico@fluxnic.net (Nicolas Pitre)
Date: Sun, 08 Nov 2009 20:42:51 -0500 (EST)
Subject: [PATCH] Use definition for cmpxchg swi
In-Reply-To: <20091108200459.GA32760@n2100.arm.linux.org.uk>
References: <20091108200459.GA32760@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.00.0911082033580.16711@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 8 Nov 2009, Russell King - ARM Linux wrote:

> Use a definition for the cmpxchg SWI instead of hard-coding the number.

Well...  Initially I didn't use a definition in unistd.h because I 
didn't want user space to "see" it and assume this was part of the 
kernel ABI since this is actually just an implementation detail that 
depends on a particular kernel configuration.  If you want to define it 
with this patch then I'd suggest copying the related comment from 
traps.c near the definition as well:

         * *NOTE*: This is a ghost syscall private to the kernel.  Only the
         * __kuser_cmpxchg code in entry-armv.S should be aware of its
         * existence.  Don't ever use this from user code.


Nicolas
