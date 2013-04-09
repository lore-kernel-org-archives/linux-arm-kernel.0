From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 09 Apr 2013 09:36:45 -0600
Subject: [GIT PULL 3/8] ARM: tegra: cleanup
In-Reply-To: <201304091544.32377.arnd@arndb.de>
References: <1365181426-11547-1-git-send-email-swarren@wwwdotorg.org>
 <1365181426-11547-3-git-send-email-swarren@wwwdotorg.org>
 <201304091544.32377.arnd@arndb.de>
Message-ID: <5164358D.1050204@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/09/2013 07:44 AM, Arnd Bergmann wrote:
> On Friday 05 April 2013, Stephen Warren wrote:
>> This branch includes various cleanup of the core Tegra support.
>>
>> * Unification of the separate board-dt-tegra*.c files into a single
>>   tegra.c, now that everything is DT-driven and basically identical.
>> * Use of_clk_get() in the Tegra clocksource driver so that clocks are
>>   described in DT rather than hard-coding clock names.
>> * Some cleanup of the PMC-related code, with the aim that the PMC
>>   "driver" contains more of the code that touches PMC registers, rather
>>   than spreading PMC register accesses through other files.
>> * Conversion of the "PMC" driver to acquire resources describe in device
>>   tree rather than hard-coding them.
>> * Use of common code for the CPU sleep TLB invalidation.
>>
> 
> Pulled into next/cleanup branch and resolved the conflict against
> an earlier cleanup that was already present there, fixup below.

Oh yes, sorry I forgot to mention that; of course this conflict doesn't
show up when I build my own for-next, but rather only in
arm-soc/linux-next so I forgot about it:-(

Anyway, the resolution you posted looks good. Thanks.
