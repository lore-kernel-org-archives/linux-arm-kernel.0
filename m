From: grant.likely@secretlab.ca (Grant Likely)
Date: Mon, 4 Jul 2011 00:11:44 -0600
Subject: [PATCH 1/2] gpio/mxc: get rid of the uses of cpu_is_mx()
In-Reply-To: <20110704061028.GE15152@ponder.secretlab.ca>
References: <1309681017-22970-1-git-send-email-shawn.guo@linaro.org>
	<1309681017-22970-2-git-send-email-shawn.guo@linaro.org>
	<20110704061028.GE15152@ponder.secretlab.ca>
Message-ID: <CACxGe6uXo0k4SEDPjZgMkpt7RpkV6M3O0wNN-1Yui=Nb0QW_7A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 4, 2011 at 12:10 AM, Grant Likely <grant.likely@secretlab.ca> wrote:
> On Sun, Jul 03, 2011 at 04:16:56PM +0800, Shawn Guo wrote:
>> The patch removes all the uses of cpu_is_mx(). ?Instead, it utilizes
>> platform_device_id to distinguish the gpio differences among SoCs.
>>
>> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
>> Cc: Grant Likely <grant.likely@secretlab.ca>
>> Cc: Sascha Hauer <s.hauer@pengutronix.de>
>> ---
>> ?arch/arm/mach-imx/mm-imx1.c ? ? ? ? ? ? ? ? ? | ? ?8 +-
>> ?arch/arm/mach-imx/mm-imx21.c ? ? ? ? ? ? ? ? ?| ? 12 +-
>> ?arch/arm/mach-imx/mm-imx25.c ? ? ? ? ? ? ? ? ?| ? ?8 +-
>> ?arch/arm/mach-imx/mm-imx27.c ? ? ? ? ? ? ? ? ?| ? 12 +-
>> ?arch/arm/mach-imx/mm-imx31.c ? ? ? ? ? ? ? ? ?| ? ?6 +-
>> ?arch/arm/mach-imx/mm-imx35.c ? ? ? ? ? ? ? ? ?| ? ?6 +-
>> ?arch/arm/mach-mx5/mm-mx50.c ? ? ? ? ? ? ? ? ? | ? 12 +-
>> ?arch/arm/mach-mx5/mm.c ? ? ? ? ? ? ? ? ? ? ? ?| ? 22 ++--
>> ?arch/arm/plat-mxc/devices/platform-gpio-mxc.c | ? ?4 +-
>> ?arch/arm/plat-mxc/include/mach/common.h ? ? ? | ? ?2 +-
>> ?drivers/gpio/gpio-mxc.c ? ? ? ? ? ? ? ? ? ? ? | ?123 +++++++++++++++++++++----
>> ?11 files changed, 151 insertions(+), 64 deletions(-)

... but other than the comments I made, I fully support making this
change.  It should also be able to be complete for v3.1

g.
