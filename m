From: myungjoo.ham@samsung.com (MyungJoo Ham)
Date: Fri, 20 Aug 2010 14:24:22 +0900
Subject: [PATCH] MAX8952 PMIC Driver Initial Release
In-Reply-To: <20100819104654.GA23404@rakim.wolfsonmicro.main>
References: <1282201515-11385-1-git-send-email-myungjoo.ham@samsung.com>
	<20100819104654.GA23404@rakim.wolfsonmicro.main>
Message-ID: <AANLkTimO7u1846M_D8E+GLvyRqyrcQh_G0TJ9mx5vu2f@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thank you for the comments. They will be applied to the next patch
revision releasing soon.

On Thu, Aug 19, 2010 at 7:46 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Thu, Aug 19, 2010 at 04:05:15PM +0900, MyungJoo Ham wrote:
>
(snip)
>
>> + ? ? max8952_write_reg(max8952, MAX8952_REG_SYNC,
>> + ? ? ? ? ? ? ? ? ? ? (max8952_read_reg(max8952, MAX8952_REG_SYNC) & 0x3F) |
>> + ? ? ? ? ? ? ? ? ? ? ((pdata->sync_freq & 0x3) << 6));
>> + ? ? max8952_write_reg(max8952, MAX8952_REG_RAMP,
>> + ? ? ? ? ? ? ? ? ? ? (max8952_read_reg(max8952, MAX8952_REG_RAMP) & 0x1F) |
>> + ? ? ? ? ? ? ? ? ? ? ((pdata->ramp_speed & 0x7) << 5));
>
> This looks like it should be platform data.

However, could you please clarify more about this? They are already
from platform data (pdata->ramp_speed and pdata->sync_freq).

-- 
MyungJoo Ham (???), Ph.D.
Mobile Software Platform Lab,
Digital Media and Communications (DMC) Business
Samsung Electronics
cell: 82-10-6714-2858
