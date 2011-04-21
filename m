From: ryan@bluewatersys.com (Ryan Mallon)
Date: Fri, 22 Apr 2011 09:28:15 +1200
Subject: [PATCH v2 20/23] at91: Make high speed USB gadget device common
In-Reply-To: <0D753D10438DA54287A00B027084269764D243016B@AUSP01VMBX24.collaborationhost.net>
References: <1303364535-11557-1-git-send-email-ryan@bluewatersys.com>
	<1303364535-11557-21-git-send-email-ryan@bluewatersys.com>
	<0D753D10438DA54287A00B027084269764D243016B@AUSP01VMBX24.collaborationhost.net>
Message-ID: <4DB0A16F.9030100@bluewatersys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22/04/11 09:21, H Hartley Sweeten wrote:
> On Wednesday, April 20, 2011 10:42 PM, Ryan Mallon wrote:
>>
>> Replace the individual high-speed UDC code for each at91 variant with
>> a single implementation in devices.c
>>
>> Signed-off-by: Ryan Mallon <ryan@bluewatersys.com>
>> ---
>>  arch/arm/mach-at91/at91cap9_devices.c    |  114 ++++++------------------------
>>  arch/arm/mach-at91/at91sam9g45_devices.c |   94 ++++---------------------
>>  arch/arm/mach-at91/at91sam9rl_devices.c  |  100 ++++----------------------
>>  arch/arm/mach-at91/devices.c             |   79 +++++++++++++++++++++
>>  arch/arm/mach-at91/devices.h             |   20 +++++
>>  5 files changed, 150 insertions(+), 257 deletions(-)
> 
> Thanks for sending part 12/23 of the series.
> 
> I tried applying all of the patches to linux-next and got this on part 20/23:
> 
> patching file arch/arm/mach-at91/at91cap9_devices.c
> Hunk #1 FAILED at 51.
> 1 out of 2 hunks FAILED -- saving rejects to file arch/arm/mach-at91/at91cap9_devices.c.rej
> patching file arch/arm/mach-at91/at91sam9g45_devices.c
> Hunk #1 FAILED at 66.
> 1 out of 2 hunks FAILED -- saving rejects to file arch/arm/mach-at91/at91sam9g45_devices.c.rej
> patching file arch/arm/mach-at91/at91sam9rl_devices.c
> Hunk #1 FAILED at 40.
> 1 out of 2 hunks FAILED -- saving rejects to file arch/arm/mach-at91/at91sam9rl_devices.c.rej
> patching file arch/arm/mach-at91/devices.c
> patching file arch/arm/mach-at91/devices.h
> 
> 
> What kernel should this apply to?

It should apply on top of 2.6.39-rc1. I can rebase it on top of -next if
needed.

~Ryan
