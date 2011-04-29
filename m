From: jean.pihet@newoldbits.com (Jean Pihet)
Date: Fri, 29 Apr 2011 16:00:40 +0200
Subject: [PATCH 5/5] OMAP3: cpuidle: change the power domains modes
	determination logic
In-Reply-To: <4DBAA12D.6070203@ti.com>
References: <1304069186-3086-1-git-send-email-j-pihet@ti.com>
	<1304069186-3086-6-git-send-email-j-pihet@ti.com>
	<4DBAA12D.6070203@ti.com>
Message-ID: <BANLkTinEwUukmE2LP6F3q_8KDBHvdRqkVA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Santosh,

On Fri, Apr 29, 2011 at 1:29 PM, Santosh Shilimkar
<santosh.shilimkar@ti.com> wrote:
> On 4/29/2011 2:56 PM, jean.pihet at newoldbits.com wrote:
>>
>> From: Jean Pihet<j-pihet@ti.com>
>>
>> The achievable power modes of the power domains in cpuidle
>> depends on the system wide 'enable_off_mode' knob in debugfs.
>> Upon changing enable_off_mode, do not change the C-states
>> 'valid' field but instead dynamically restrict the power modes
>> when entering idle.
>>
>> The C-states 'valid' field is just used to enable/disable some
>> C-states at init and shall not be changed later on.
>>
>> Signed-off-by: Jean Pihet<j-pihet@ti.com>
...

> Since you have started clean-up, we should get rid of the
> "enable_off_mode" some how. I got that done for OMAP4 using
> prepare() hook and IGNORE flag as per Kevin's suggestion
> but unfortunately its seems to getting removed from
> core cpuidle code.

The idea is to remove the enable_off_mode knob from debugfs and
instead have the devices constraints API control the power domains
behavior.
Cf. PATCH 0/5 of this series for some remarks about further clean-up work.

Thanks!
Jean

>
> Regards
> Santosh
>
