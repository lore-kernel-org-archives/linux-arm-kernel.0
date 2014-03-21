From: zhangfei.gao@gmail.com (Zhangfei Gao)
Date: Fri, 21 Mar 2014 20:59:27 +0800
Subject: [PATCH 1/3] Documentation: add Device tree bindings for Hisilicon
 hip04 ethernet
In-Reply-To: <20140318123451.GA2941@e106331-lin.cambridge.arm.com>
References: <1395132017-15928-1-git-send-email-zhangfei.gao@linaro.org>
 <1395132017-15928-2-git-send-email-zhangfei.gao@linaro.org>
 <20140318123451.GA2941@e106331-lin.cambridge.arm.com>
Message-ID: <CAMj5BkgDN94gy1v9RoAHF=UdO-9gD9M-nVDVLaM3ojCjVu1Mzw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Mark

Thanks for the suggestion, will update accordingly.

On Tue, Mar 18, 2014 at 8:34 PM, Mark Rutland <mark.rutland@arm.com> wrote:
> On Tue, Mar 18, 2014 at 08:40:15AM +0000, Zhangfei Gao wrote:
>> This patch adds the Device Tree bindings for the Hisilicon hip04
>> Ethernet controller, including 100M / 1000M controller.
>>
>> Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
>> ---
>>  .../bindings/net/hisilicon-hip04-net.txt           |   74 ++++++++++++++++++++
>>  1 file changed, 74 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/net/hisilicon-hip04-net.txt
>>
>> diff --git a/Documentation/devicetree/bindings/net/hisilicon-hip04-net.txt b/Documentation/devicetree/bindings/net/hisilicon-hip04-net.txt
>> new file mode 100644
>> index 0000000..c918f08
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/net/hisilicon-hip04-net.txt
>> @@ -0,0 +1,74 @@
>> +Hisilicon hip04 Ethernet Controller
>> +
>> +* Ethernet controller node
>> +
>> +Required properties:
>> +- compatible: should be "hisilicon,hip04-mac".
>> +- reg: address and length of the register set for the device.
>> +- interrupts: interrupt for the device.
>> +- port: ppe port number connected to the controller: range from 0 to 31.
>
> ppe?
>
> Will there ever be more than one ppe? If so, describing the linkage to
> the ppe with a phandle + args approach is preferable.
>
>> +- speed: 100 (100M) or 1000 (1000M).
>
> Can you not query this from the hardware?

Will remove speed.
>
>> +- id: should be different and fe should be 0.
>
> This description is useless.
>
> What is this for, and why does this need to be in the dt? What is "fe"?

Use alias instead.
>
>> +
>> +Optional Properties:
>> +- phy-handle : the phandle to a PHY node
>> +
>> +
>> +* Ethernet ppe node: control rx & tx fifos of all ethernet controllers
>> +
>> +Required properties:
>> +- compatible: should be "hisilicon,hip04-ppebase".
>
> Why "ppebase" rather than "ppe"?
>
>> +- reg: address and length of the register set for the node.
>
> s/node/device/

OK.

Thanks
