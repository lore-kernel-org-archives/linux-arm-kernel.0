From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 23 May 2014 21:28:51 +0200
Subject: [PATCH RESEND] ARM: trusted_foundations: fix compile error on
 non-SMP
In-Reply-To: <537F7E1F.4020706@wwwdotorg.org>
References: <1400804612-11876-1-git-send-email-acourbot@nvidia.com>
 <537F7E1F.4020706@wwwdotorg.org>
Message-ID: <201405232128.51247.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 23 May 2014, Stephen Warren wrote:
> On 05/22/2014 06:23 PM, Alexandre Courbot wrote:
> > The setup_max_cpus variable is only defined if CONFIG_SMP is set. Add
> > a preprocessor condition to avoid the following compilation error if
> > CONFIG_SMP is not set:
> > 
> >     arch/arm/include/asm/trusted_foundations.h: In function 'register_trusted_foundations':
> >     arch/arm/include/asm/trusted_foundations.h:57:2: error: 'setup_max_cpus' undeclared (first use in this function)
> > 
> > Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
> > Reported-by: Russell King <rmk+kernel@arm.linux.org.uk>
> 
> I spoke to Olof and IRC, and he said arm-soc would be OK taking this
> patch, since they applied the original code this fixes. IIUC, they'll
> pick this up directly.
> 
> Acked-by: Stephen Warren <swarren@nvidia.com>
> 

Pulled into the fixes branch now, thanks!

	Arnd
