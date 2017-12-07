From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 7 Dec 2017 15:45:37 +0100
Subject: [PATCH v2] ARM: omap2: hide omap3_save_secure_ram on non-OMAP3
 builds
In-Reply-To: <20171206220436.GA28152@atomide.com>
References: <20171206214916.2856657-1-arnd@arndb.de>
 <20171206220436.GA28152@atomide.com>
Message-ID: <CAK8P3a0JYok7P+Xa89GZKedz_h5z6mmzoZn_myaEt89koU+Btg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 6, 2017 at 11:04 PM, Tony Lindgren <tony@atomide.com> wrote:
> * Arnd Bergmann <arnd@arndb.de> [171206 21:52]:
>> In configurations without CONFIG_OMAP3 but with secure RAM support,
>> we now run into a link failure:
>>
>> arch/arm/mach-omap2/omap-secure.o: In function `omap3_save_secure_ram':
>> omap-secure.c:(.text+0x130): undefined reference to `save_secure_ram_context'
>>
>> The omap3_save_secure_ram() function is only called from the OMAP34xx
>> power management code, so we can simply hide that function in the
>> appropriate #ifdef.
>>
>> Fixes: d09220a887f7 ("ARM: OMAP2+: Fix SRAM virt to phys translation for save_secure_ram_context")
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>> ---
>> v2: also check for CONFIG_PM
>
> Acked-by: Tony Lindgren <tony@atomide.com>

Applied now

       Arnd
