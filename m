From: guodong.xu@linaro.org (Guodong Xu)
Date: Fri, 2 Jun 2017 17:01:18 +0800
Subject: [PATCH 1/6] dt-bindings: mfd: Add hi6421v530 bindings
In-Reply-To: <20170531180755.on4jcgwxpnli3mly@rob-hp-laptop>
References: <20170526063518.21246-1-guodong.xu@linaro.org>
 <20170526063518.21246-2-guodong.xu@linaro.org>
 <20170531180755.on4jcgwxpnli3mly@rob-hp-laptop>
Message-ID: <CAFGCpxzxQfC+mf6Ltjzq=rtk+1C_R2x0+eu3s+zszK58x0OS8Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 1, 2017 at 2:07 AM, Rob Herring <robh@kernel.org> wrote:
> On Fri, May 26, 2017 at 02:35:13PM +0800, Guodong Xu wrote:
>> DT bindings for hisilicon HI655x PMIC chip.
>>
>> Signed-off-by: Guodong Xu <guodong.xu@linaro.org>
>> ---
>>  .../bindings/mfd/hisilicon,hi6421v530.txt          | 25 ++++++++++++++++++++++
>>  1 file changed, 25 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/mfd/hisilicon,hi6421v530.txt
>>
>> diff --git a/Documentation/devicetree/bindings/mfd/hisilicon,hi6421v530.txt b/Documentation/devicetree/bindings/mfd/hisilicon,hi6421v530.txt
>> new file mode 100644
>> index 0000000..6ffe6f6
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/mfd/hisilicon,hi6421v530.txt
>> @@ -0,0 +1,25 @@
>> +Hisilicon Hi6421v530 Power Management Integrated Circuit (PMIC)
>> +
>> +The hardware layout for access PMIC Hi6421v530 from AP SoC Hi3660.
>> +Between PMIC Hi6421v530 and Hi3660, the physical signal channel is SSI.
>> +We can use memory-mapped I/O to communicate.
>> +
>> ++----------------+             +-------------+
>> +|                |             |             |
>> +|    Hi3660      |   SSI bus   |  Hi6421v530 |
>> +|                |-------------|             |
>> +|                |(REGMAP_MMIO)|             |
>> ++----------------+             +-------------+
>
> regmap is a Linuxism and should not be part of the binding.
>
> So there some sort of controller that generates SSI packets? based on
> MMIO addresses? That should be more fully described here. For example,
> the PMIC should probably be a child of the controller.

Hi, Rob

Thanks for review. I just sent v2 of this patchset, according to
review comments I got. In v2, I discarded this new binding file.
Actually, I extended the existing
Documentation/devicetree/bindings/mfd/hi6421.txt to make it support
v530. There is no regmap in that.

Yes, there is a controller to generate SSI packets. However that is
completely blind to main SoC. It's more MMIO.

-Guodong
