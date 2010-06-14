From: viresh.kumar@st.com (Viresh KUMAR)
Date: Mon, 14 Jun 2010 11:11:34 +0530
Subject: [PATCH 1/5] SPEAr3xx: Make local structres static
In-Reply-To: <4C15BEB2.1030004@bluewatersys.com>
References: <1275717955-14545-1-git-send-email-ryan@bluewatersys.com>
	<1275717955-14545-2-git-send-email-ryan@bluewatersys.com>
	<4C15BB22.9010309@st.com> <4C15BEB2.1030004@bluewatersys.com>
Message-ID: <4C15C10E.9010404@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 6/14/2010 11:01 AM, Ryan Mallon wrote:
>>> -struct pmx_dev_mode pmx_plgpio_45_46_49_50_modes[] = {
>>> >> +static struct pmx_dev_mode pmx_plgpio_45_46_49_50_modes[] = {
>>> >>  	{
>>> >>  		.ids = 0x00,
>>> >>  		.mask = PMX_TIMER_3_4_MASK,
>> > 
>> > These structures are not local, they are used in spear3**_evb.c files,
>> > and hence can't be static.
> The pmx_dev structures are used by the spear3**_evb.c files, but the
> pmx_dev_mode structures are local. This patch is only making the latter
> static. I have done a build test which includes all three spear3**_evb
> board files and got no compilation warnings/errors.

sorry!! You were correct.
