From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 2 Jun 2010 17:00:11 +0100
Subject: [PATCH] Add kto and kfrom to input operands list.
In-Reply-To: <19462.18892.533099.360440@pilspetsen.it.uu.se>
References: <1275379600-23498-1-git-send-email-raj.khem@gmail.com>
	<19462.18892.533099.360440@pilspetsen.it.uu.se>
Message-ID: <20100602160010.GB872@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 02, 2010 at 02:08:44PM +0200, Mikael Pettersson wrote:
> Khem Raj writes:
>  > When functions incoming parameters are not in input operands list gcc 4.5 does not
>  > load the parameters into registers before calling this function but the
>  > inline assembly assumes valid addresses inside this function. This
>  > breaks the code because r0 and r1 are invalid when execution enters
>  > v4wb_copy_user_page ()
>  > 
>  > Also the constant needs to be used as third input operand so account for that
>  > as well.
>  > 
>  > Tested on qemu arm.
>  > 
>  > Signed-off-by: Khem Raj <raj.khem@gmail.com>
>  > ---
>  >  arch/arm/mm/copypage-feroceon.c |    4 ++--
> 
> I've tested and verified that this bit enables a gcc-4.5 compiled kernel
> to boot on TS-119 (Kirkwood) when combined with my fix for __naked.
> With neither or only one of the patches applied, the kernel oopses hard
> in copy_user_page() as it tries to start /sbin/init.
> 
> So for the copypage-feroceon.c change:
> Tested-by: Mikael Pettersson <mikpe@it.uu.se>

Ok.
