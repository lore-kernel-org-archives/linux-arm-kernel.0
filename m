From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 09 Apr 2014 11:38:45 +0200
Subject: Big endian working?
In-Reply-To: <53450D3A.7030909@linaro.org>
References: <20140408095446.0520dd28@skate>
 <CAA3XUr3gR-R1X6+CxP-Z0fv7kiSzENtm0NsYd539BNVWKCgdNw@mail.gmail.com>
 <53450D3A.7030909@linaro.org>
Message-ID: <4880190.MJBhke5aDa@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 09 April 2014 12:04:58 Taras Kondratiuk wrote:
> 
> > Maybe Nico's zImage change was under atags umbrella by mistake and
> > it really addresses general zImage issue. In this case we need to add
> > this commit to main line. However, I don't think we need to carry
> > CPU_BE8_BOOT_LE option forward, why we just use
> > CONFIG_CPU_BIG_ENDIAN instead. Note in all cases when BE
> > image used loader is always in LE mode. Never seen case
> > otherwise.
> 
> That makes sense, but I'm concerned about BE32 systems.
> Do they also have LE bootloaders? I don't remember kernel code which
> switches to BE32. I'd think that switch is done by bootloader or 
> ROMcode. Or even BE hardwired in HW. So BE32 bootloader may expect to
> see BE zImage header.
> Maybe instead of CONFIG_CPU_BIG_ENDIAN use CONFIG_CPU_ENDIAN_BE8?

Agreed. CONFIG_CPU_ENDIAN_BE32 basically means ixp4xx. Whatever those
systems do today, I think we should better not change anything
for them. If nobody has complained for the last 10 years, everyone
who cares must have already found a working solution by now.

For BE8, I think we should just try to do the right thing before
we see mass deployments of broken boot loaders.

	Arnd
