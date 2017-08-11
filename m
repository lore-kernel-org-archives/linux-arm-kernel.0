From: michal.simek@xilinx.com (Michal Simek)
Date: Fri, 11 Aug 2017 14:31:36 +0200
Subject: [PATCH 2/2] char: xilinx_hwicap: Fix warnings in the driver
In-Reply-To: <CAL_JsqLy3yV60eoxL0s7vohpcCuh=d3-Z8zVyaEPe=g772yySA@mail.gmail.com>
References: <6da0afe2afd2c7a21d16da9a9c7acab09385ae2c.1501247838.git.michal.simek@xilinx.com>
 <79e2e616a8b7dbf38eb72ba0b620230017dcbc65.1501247838.git.michal.simek@xilinx.com>
 <20170803223218.ilryp5spqztsr3cz@rob-hp-laptop>
 <0e40a687-e11b-b5bb-24f0-465144c98929@xilinx.com>
 <CAL_JsqLy3yV60eoxL0s7vohpcCuh=d3-Z8zVyaEPe=g772yySA@mail.gmail.com>
Message-ID: <42e6baac-5b3f-5499-782f-9a8d901cac00@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10.8.2017 20:16, Rob Herring wrote:
> On Fri, Aug 4, 2017 at 2:49 AM, Michal Simek <michal.simek@xilinx.com> wrote:
>> On 4.8.2017 00:32, Rob Herring wrote:
>>> On Fri, Jul 28, 2017 at 03:17:26PM +0200, Michal Simek wrote:
>>>> From: Nava kishore Manne <nava.manne@xilinx.com>
>>>>
>>>> This patch fixes the below warning
>>>>         --> Use #include <linux/io.h> instead of <asm/io.h>
>>>>         --> Use #include <linux/uaccess.h> instead of <asm/uaccess.h>
>>>>         --> please, no space before tabs
>>>>         --> Block comments use a trailing */ on a separate line
>>>>         --> Possible unnecessary 'out of memory' message
>>>>         --> Block comments use * on subsequent lines
>>>>         --> Block comments use a trailing */ on a separate line
>>>>         --> braces {} are not necessary for any arm of this statement
>>>>         --> DT compatible string "xlnx,opb-hwicap-1.00.b"
>>>>          appears un-documented
>>>>         --> DT compatible string "xlnx,xps-hwicap-1.00.a"
>>>>             appears un-documented
>>>>
>>>> Signed-off-by: Nava kishore Manne <navam@xilinx.com>
>>>> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
>>>> ---
>>>>
>>>>  Documentation/devicetree/bindings/xilinx.txt |  2 ++
>>>
>>> It's preferred to split bindings to separate patches. No need unless you
>>> respin:
>>>
>>> Acked-by: Rob Herring <robh@kernel.org>
>>
>> thanks. Was there any outcome from that discussion to extract binding
>> out of kernel source code?
> 
> Well, the reason to split the patches is so the history of the
> filtered DT repository we generate from the kernel tree[1] looks
> saner.
> 

So many merge commits. It looks weird.

https://git.kernel.org/pub/scm/linux/kernel/git/devicetree/devicetree-rebasing.git/log/

> As far as actually moving things out, no there's not been any
> movement. My biggest concern with moving things out would be the loss
> of kernel subsystem maintainers' review. Once it's a separate tree and
> not merged thru their tree, we'd loose their reviews and I don't have
> confidence that we'd be gaining reviews from other places. Though some
> subsystem maintainers merge bindings and don't look at them already.

ok.

Thanks,
Michal
