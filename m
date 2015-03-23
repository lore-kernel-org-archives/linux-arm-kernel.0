From: wens@csie.org (Chen-Yu Tsai)
Date: Mon, 23 Mar 2015 09:58:52 -0700
Subject: [PATCH v5 03/12] mfd: axp20x: add AXP22x PMIC support
In-Reply-To: <20150323115225.GA24422@x1>
References: <1425988764-23618-1-git-send-email-wens@csie.org>
 <1425988764-23618-4-git-send-email-wens@csie.org> <20150323115225.GA24422@x1>
Message-ID: <CAGb2v66Q+7t=wMUsEKFg57mCTcd6QE5=Q67YrYR40CQDgQo_Mw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Mar 23, 2015 at 4:52 AM, Lee Jones <lee.jones@linaro.org> wrote:
> On Tue, 10 Mar 2015, Chen-Yu Tsai wrote:
>
>> From: Boris BREZILLON <boris.brezillon@free-electrons.com>
>>
>> Add support for the AXP22x PMIC devices to the existing AXP20x driver.
>> This includes the AXP221 and AXP223, which are identical except for
>> the external data bus. Only AXP221 is added for now. AXP223 will be
>> added after it's Reduced Serial Bus (RSB) interface is supported.
>>
>> AXP22x defines a new set of registers, power supplies and regulators,
>> but most of the API is similar to the AXP20x ones.
>>
>> A new irq chip definition is used, even though the available interrupts
>> on AXP22x is a subset of those on AXP20x. This is done so the interrupt
>> numbers match those on the datasheet.
>>
>> This patch only enables the interrupts, system power-off function, and PEK
>> sub-device. The regulator driver must first support different variants
>> before we enable it from the mfd driver.
>>
>> Signed-off-by: Boris BREZILLON <boris.brezillon@free-electrons.com>
>> [wens at csie.org: fix interrupts and move regulators to separate patch]
>> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
>> ---
>>  drivers/mfd/axp20x.c       | 98 ++++++++++++++++++++++++++++++++++++++++++++++
>>  include/linux/mfd/axp20x.h | 86 ++++++++++++++++++++++++++++++++++++++++
>>  2 files changed, 184 insertions(+)
>
> For my own reference:
>
> Acked-by: Lee Jones <lee.jones@linaro.org>
>
> How do you wish for these patches to be managed?  Are they okay to be
> sucked up individually, or do you wish for them to go through together
> through a single tree?  If the latter, when which tree?

The driver code (both mfd and regulator) have compile time dependencies
which need to go through the same tree Mark already reviewed the
regulator patches, so if you could take all the mfd and regulator
patches, that would be great.

Maxime already merged some of the dt patches. I still need to fix
up one comment, but he can merge them individually.

Thanks!


Regards
ChenYu
