From: quentin.schulz@free-electrons.com (Quentin Schulz)
Date: Mon, 19 Dec 2016 13:28:11 +0100
Subject: [PATCH v2 02/11] mfd: axp20x: add volatile and writeable reg
 ranges for VBUS power supply driver
In-Reply-To: <CAGb2v66jDsU2rt4d-0ydWR926y-hHTfOBJQmyYVdKd7rcm1WWQ@mail.gmail.com>
References: <20161209110419.28981-1-quentin.schulz@free-electrons.com>
 <20161209110419.28981-3-quentin.schulz@free-electrons.com>
 <CAGb2v66jDsU2rt4d-0ydWR926y-hHTfOBJQmyYVdKd7rcm1WWQ@mail.gmail.com>
Message-ID: <98fa2460-b7fe-3a0b-5b93-7a2e4e6e83ce@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Chen-Yu,

On 14/12/2016 16:43, Chen-Yu Tsai wrote:
> On Fri, Dec 9, 2016 at 7:04 PM, Quentin Schulz
> <quentin.schulz@free-electrons.com> wrote:
>> The X-Powers AXP20X and AXP22X PMICs allow to choose the maximum voltage
>> and minimum current delivered by the VBUS power supply.
>>
>> This adds the register used by the VBUS power supply driver to the range
>> of volatile and writeable regs ranges.
>>
>> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
>> ---
>>
>> added in v2
>>
>>  drivers/mfd/axp20x.c | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
>> index ba130be..6ee2cc6 100644
>> --- a/drivers/mfd/axp20x.c
>> +++ b/drivers/mfd/axp20x.c
>> @@ -65,12 +65,14 @@ static const struct regmap_access_table axp152_volatile_table = {
>>
>>  static const struct regmap_range axp20x_writeable_ranges[] = {
>>         regmap_reg_range(AXP20X_DATACACHE(0), AXP20X_IRQ5_STATE),
>> +       regmap_reg_range(AXP20X_VBUS_IPSOUT_MGMT, AXP20X_VBUS_IPSOUT_MGMT),
> 
> This is already covered by the previous entry.
> 
>>         regmap_reg_range(AXP20X_DCDC_MODE, AXP20X_FG_RES),
>>         regmap_reg_range(AXP20X_RDC_H, AXP20X_OCV(AXP20X_OCV_MAX)),
>>  };
>>
>>  static const struct regmap_range axp20x_volatile_ranges[] = {
>>         regmap_reg_range(AXP20X_PWR_INPUT_STATUS, AXP20X_USB_OTG_STATUS),
>> +       regmap_reg_range(AXP20X_VBUS_IPSOUT_MGMT, AXP20X_VBUS_IPSOUT_MGMT),
> 
> And I'm not sure why you specify it as volatile? The PMIC doesn't change any
> of the bits in this register on its own.
> 

I got things mixed up between the work on the battery driver I'll soon
send (which actually needs updated reg ranges) and this VBUS driver.
Sorry for that.

> Same for the AXP22x bits. So basically I think you don't need this patch.
> 

Indeed. Should I send a v3 to remove this patch or is it fine for you to
ignore this one?

Thanks!
Quentin

-- 
Quentin Schulz, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
