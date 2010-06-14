From: ryan@bluewatersys.com (Ryan Mallon)
Date: Mon, 14 Jun 2010 17:31:30 +1200
Subject: [PATCH 1/5] SPEAr3xx: Make local structres static
In-Reply-To: <4C15BB22.9010309@st.com>
References: <1275717955-14545-1-git-send-email-ryan@bluewatersys.com>
	<1275717955-14545-2-git-send-email-ryan@bluewatersys.com>
	<4C15BB22.9010309@st.com>
Message-ID: <4C15BEB2.1030004@bluewatersys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Viresh KUMAR wrote:
> On 6/5/2010 11:35 AM, Ryan Mallon wrote:
>> Several structures in arch/arm/mach-spear3xx are not marked static
>> like they should be. Fix this.
>>
>> Signed-off-by: Ryan Mallon <ryan@bluewatersys.com>
>> ---
>>  arch/arm/mach-spear3xx/spear300.c |   33 ++++++++++----------
>>  arch/arm/mach-spear3xx/spear310.c |   16 +++++-----
>>  arch/arm/mach-spear3xx/spear320.c |   56 +++++++++++++++++-----------------
>>  arch/arm/mach-spear3xx/spear3xx.c |   60 ++++++++++++++++++------------------
>>  4 files changed, 83 insertions(+), 82 deletions(-)
>>

<snip>

>> -struct pmx_dev_mode pmx_plgpio_45_46_49_50_modes[] = {
>> +static struct pmx_dev_mode pmx_plgpio_45_46_49_50_modes[] = {
>>  	{
>>  		.ids = 0x00,
>>  		.mask = PMX_TIMER_3_4_MASK,
> 
> These structures are not local, they are used in spear3**_evb.c files,
> and hence can't be static.

The pmx_dev structures are used by the spear3**_evb.c files, but the
pmx_dev_mode structures are local. This patch is only making the latter
static. I have done a build test which includes all three spear3**_evb
board files and got no compilation warnings/errors.

~Ryan
