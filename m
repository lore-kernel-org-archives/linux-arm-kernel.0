From: alan@signal11.us (Alan Ott)
Date: Sat, 10 Mar 2012 15:06:06 -0500
Subject: [PATCH 1/2] ARM: at91: only RM9200 has ISA-style PIO
In-Reply-To: <201203101924.31710.arnd@arndb.de>
References: <1331405049-3186-1-git-send-email-alan@signal11.us>
 <1331405075-3231-1-git-send-email-alan@signal11.us>
 <201203101924.31710.arnd@arndb.de>
Message-ID: <4F5BB42E.3090201@signal11.us>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/10/2012 02:24 PM, Arnd Bergmann wrote:
> On Saturday 10 March 2012, Alan Ott wrote:
>> From: Arnd Bergmann <arnd@arndb.de>
>>
>> Most at91 systems have no support for PCMCIA or other
>> PC-style buses, so we can select NO_IOPORT in order to
>> disable compilationf or all drivers that need these.
>>
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>> Signed-off-by: Alan Ott <alan@signal11.us>
> You forgot to Cc the at91 maintainers on this patch (and on patch 0).
> Also, this patch relies on the another series I did to redefine
> the meaning of CONFIG_NO_IOPORT while renaming the existing one to
> CONFIG_NO_IOPORT_MAP. This patch will have to wait for the other
> series.

Hi Arnd,

I'm going to assume you mean randconfig/ioport in
git://git.linaro.org/people/arnd/linux.git .
I'll take this patch out for v2 and make a note that it needs to go with
the patches in randconfig/ioport.

I used scripts/get_maintainers.pl for the recipient list, but I now see
how that failed, since this patch modifies the AT91 section of a file
not in arc/arm/mach-at91.

Alan.
