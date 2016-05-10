From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Tue, 10 May 2016 11:31:45 +0100
Subject: [PATCH V2 3/3] nvmem: imx-ocotp: handling clock
In-Reply-To: <20160509124140.GA20259@linux-7smt.suse>
References: <1461173177-11930-1-git-send-email-van.freenix@gmail.com>
 <1461173177-11930-3-git-send-email-van.freenix@gmail.com>
 <5730825E.5030101@linaro.org> <20160509124140.GA20259@linux-7smt.suse>
Message-ID: <5731B891.4040303@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 09/05/16 13:41, Peng Fan wrote:
> Hi Srinivas,
>
> On Mon, May 09, 2016 at 01:28:14PM +0100, Srinivas Kandagatla wrote:
>> Thanks for the Ping, I totally missed this thread.
>>
>> On 20/04/16 18:26, Peng Fan wrote:
>>> Before access ocotp nvmem area, the clock should be enabled.
>>> Or, `hexdump nvmem` will hang the system. So, use such flow:
>>> "
>>>    1. clock_enable_prepare
>>>    2. read nvmem ocotp area
>>>    3. clock_disable_unprepare
>>> "
>>>
>>> Signed-off-by: Peng Fan <van.freenix@gmail.com>
>>> Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>>> Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
>>> Cc: Shawn Guo <shawnguo@kernel.org>
>>> ---
>>>
>>> V2:
>>>   Follow Fabio's comments, check return value of clk_prepare_enable
>>>
>>>   drivers/nvmem/imx-ocotp.c | 16 +++++++++++++++-
>>>   1 file changed, 15 insertions(+), 1 deletion(-)
>>
>> Changes to the driver looks good to me,
>> Only one comment, As the clock property is now made mandatory, you should
>> update the dt-bindings with this info too.
>
> In Documentation/devicetree/bindings/nvmem/imx-ocotp.txt,
> the clock property is already marked Required properties:

Ok, I can take this patch, dt patch should go via the dt maintainers.

thanks,
--srini
