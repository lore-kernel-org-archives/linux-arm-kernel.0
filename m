From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Thu, 20 Jun 2013 11:58:34 +0100
Subject: [PATCH 1/6] ARM: add CPU_BE8_BOOT_LE configuration
In-Reply-To: <20130619192904.0375c15c@skate>
References: <1371659404-20167-1-git-send-email-ben.dooks@codethink.co.uk>
 <1371659404-20167-2-git-send-email-ben.dooks@codethink.co.uk>
 <20130619192904.0375c15c@skate>
Message-ID: <51C2E05A.7000101@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19/06/13 18:29, Thomas Petazzoni wrote:
> Dear Ben Dooks,
>
> On Wed, 19 Jun 2013 17:29:58 +0100, Ben Dooks wrote:
>
>> +config CPU_BE8_BOOT_LE
>> +	bool "Boot BE system from LE loader"
>> +	depends on CPU_ENDIAN_BE8
>> +	help
>> +	  Support for running BE-8 (big-endian) from a boot environment that is
>> +	  running in LE mode.
>> +
>
> I'm not sure to understand how this option articulates with the
> CPU_ENDIAN_BE8 option, because your other patch series ("Initial
> big-endian support series") in its PATCH 4 ("ARM: set BE8 if LE in head
> code") already switches the kernel into BE mode even if it's booted
> from a Little Endian bootloader.
>
> Maybe what you wanted to achieve is:
>
>   * The first patch series "Initial big-endian support series" allows to
>     run the kernel big-endian if the bootloader has booted it big-endian.
>
>   * The second patch series "ARM big-endian - atags and loader updates",
>     allows to run the kernel big-endian even if the bootloader started
>     it little-endian.
>
> In this case, then the PATCH 4 of your first patch series ("ARM: set
> BE8 if LE in head code") should be in the second patch series, and
> the code be conditional under CPU_BE8_BOOT_LE.

I suppose the second series should be to allow little endian ATAGS
based loaders to boot the kernel. If the loader starts the kernel LE
with OF then it is easy to swap to big endian in the head code.

The secondary boots will always require the LE->BE switching as there
is no guarantee that if the primary processor started the kernel BE8
that any of the secondary cpus will be started in the same way.

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
