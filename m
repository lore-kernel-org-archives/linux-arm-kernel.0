From: michal.simek@xilinx.com (Michal Simek)
Date: Mon, 3 Feb 2014 16:13:47 +0100
Subject: [PATCH 09/10] watchdog: xilinx: Add missing binding
In-Reply-To: <201402031606.11753.arnd@arndb.de>
References: <ed4cb31c9a549343e6b492cf62fc962d39034bd0.1391177880.git.michal.simek@xilinx.com>
 <9c721b89ed2ceb6997809bb3363f852277e67dc2.1391177880.git.michal.simek@xilinx.com>
 <201402031606.11753.arnd@arndb.de>
Message-ID: <24ecacca-2714-4834-921c-b827c0e592a3@VA3EHSMHS003.ehs.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/03/2014 04:06 PM, Arnd Bergmann wrote:
> On Friday 31 January 2014, Michal Simek wrote:
>> +Optional properties:
>> +- clock-frequency      : Frequency of clock in Hz
>> +- xlnx,wdt-enable-once : 0 - Watchdog can be restarted
>> +                         1 - Watchdog can be enabled just once
>> +- xlnx,wdt-interval    : Watchdog timeout interval in 2^<val> clock cycles,
>> +                         <val> is integer from 8 to 31.
>> +
> 
> The latter two don't really seem to be xilinx specific, it would be
> reasonable to have a standard watchdog binding that mandates a common
> format for them.
> 
> I'm not sure about the enable-once flag, which seems to just map to the
> "nowayout" watchdog option that is not a hardware feature at all
> and should probably be kept as a software setting only, rather than
> settable through DT. If it is kept, it should have a standard name and
> get turned into a boolean (present/absent) property rather than a
> 0/1 integer property.
> 
> The interval should really be specified in terms of seconds or miliseconds,
> not in clock cycles.

Intention wasn't to fix binding but document current one
which is in mainline for a long time.

Apart of this - yes, wdt-enable-once is nowayout and wdt-interval should be timeout
is seconds, and clock-frequency should go out and use CCF for getting clock.

Thanks,
Michal
