From: jbaron@redhat.com (Jason Baron)
Date: Tue, 22 Nov 2011 18:39:50 -0500
Subject: [PATCH 4/4] ARM: add jump label support
In-Reply-To: <4ECC2A07.8050701@codeaurora.org>
References: <1321888429-3519-1-git-send-email-rabin@rab.in>
 <1321888429-3519-4-git-send-email-rabin@rab.in>
 <20111122194213.GC9581@n2100.arm.linux.org.uk>
 <4ECC2A07.8050701@codeaurora.org>
Message-ID: <20111122233949.GA24453@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 22, 2011 at 03:02:31PM -0800, Stephen Boyd wrote:
> On 11/22/11 11:42, Russell King - ARM Linux wrote:
> > On Mon, Nov 21, 2011 at 08:43:49PM +0530, Rabin Vincent wrote:
> >> Add the arch-specific code to support jump labels for ARM and Thumb-2.
> >>
> >> Note that to build succesfully it requires (what will be) GCC 4.7.0
> >> because of incomplete support for the '%c' specifier in earlier
> >> versions:
> >>
> >> 	http://gcc.gnu.org/bugzilla/show_bug.cgi?id=48637
> >>
> >> Cc: Jason Baron <jbaron@redhat.com>
> >> Signed-off-by: Rabin Vincent <rabin@rab.in>
> > This appears to imply that with this patch, we're upping the minimum
> > gcc version for successfully building kernels to 4.7.0.  That's _way_
> > too early (I'm using 4.3.5 here and don't have plans to update.)
> 
> Is there a way to detect that the compiler doesn't support %c? Perhaps
> we can do that in the same spirit of how we detect asm goto support for
> jump labels.
> 

Right, for jump labels we have a script at: scripts/gcc-goto.sh, which
basically just checks if we can compile 'asm goto' without error, so for
%c, you could probably have some simple 'asm()' that uses %c, and see if
it compiles. Although, I'm not sure if there's a arch specific dir, for
such a thing?

thanks,

-Jason
