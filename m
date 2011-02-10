From: khilman@ti.com (Kevin Hilman)
Date: Thu, 10 Feb 2011 13:12:52 -0800
Subject: [PATCH v5 0/5] omap: mailbox: hwmod support
In-Reply-To: <AANLkTimah86Mj37rCMYnuprUfeP1XwmxcNBD9S=8g6_N@mail.gmail.com>
	(Sourav Poddar's message of "Thu, 10 Feb 2011 11:04:41 +0530")
References: <1296674843-12718-1-git-send-email-omar.ramirez@ti.com>
	<AANLkTimah86Mj37rCMYnuprUfeP1XwmxcNBD9S=8g6_N@mail.gmail.com>
Message-ID: <8739nvioff.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

"Poddar, Sourav" <sourav.poddar@ti.com> writes:

> On Thu, Feb 3, 2011 at 12:57 AM, Omar Ramirez Luna <omar.ramirez@ti.com> wrote:
>> Mailbox hwmod support for OMAP 2,3,4.
>>
>> This was tested on OMAP3 (3430, 3630), minor testing
>> was made on OMAP4.
>>
>> No testing on OMAP2 since I don't have the hardware.
>>
>> Highlights from v5 include the comments received from
>> previous version v4[1].
>>
>> Benoit Cousson (1):
>> ?OMAP4: hwmod data: add mailbox data
>>
>> Felipe Contreras (2):
>> ?OMAP3: hwmod data: add mailbox data
>> ?OMAP: mailbox: build device using omap_device/omap_hwmod
>>
>> Omar Ramirez Luna (1):
>> ?OMAP: mailbox: use runtime pm for clk and sysc handling
>>
>> omar ramirez (1):
>> ?OMAP2: hwmod data: add mailbox data
>>
>> ?arch/arm/mach-omap2/devices.c ? ? ? ? ? ? ?| ? 98 +++++-----------------------
>> ?arch/arm/mach-omap2/mailbox.c ? ? ? ? ? ? ?| ? 67 ++-----------------
>> ?arch/arm/mach-omap2/omap_hwmod_2420_data.c | ? 74 +++++++++++++++++++++
>> ?arch/arm/mach-omap2/omap_hwmod_2430_data.c | ? 73 +++++++++++++++++++++
>> ?arch/arm/mach-omap2/omap_hwmod_3xxx_data.c | ? 72 ++++++++++++++++++++
>> ?arch/arm/mach-omap2/omap_hwmod_44xx_data.c | ? 67 +++++++++++++++++++
>> ?6 files changed, 308 insertions(+), 143 deletions(-)
>
> Boot tested mainline v2.6.38-rc4 along with this 5 patch series on
> Omap 2420,2430 SDPs.
>
> Tested-by: Sourav Poddar<sourav.poddar@ti.com>

Boot testing is a start, but I'm pretty sure that bootup does not use
the mailbox on any of these platforms.  This needs to be tested with
something that actually uses the mailbox.

Kevin
