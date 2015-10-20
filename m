From: michal.simek@xilinx.com (Michal Simek)
Date: Tue, 20 Oct 2015 13:15:11 +0200
Subject: [PATCHv2 2/3] ARM: zynq: dt: Updated devicetree for Zynq 7000
 platform.
In-Reply-To: <20151019182416.GL12756@jcartwri.amer.corp.natinst.com>
References: <1445035350-3569-1-git-send-email-moritz.fischer@ettus.com>
 <1445035350-3569-3-git-send-email-moritz.fischer@ettus.com>
 <20151018175324.GH12756@jcartwri.amer.corp.natinst.com>
 <5624F985.8050905@xilinx.com>
 <20151019182416.GL12756@jcartwri.amer.corp.natinst.com>
Message-ID: <5626223F.6040008@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/19/2015 08:24 PM, Josh Cartwright wrote:
> On Mon, Oct 19, 2015 at 04:09:09PM +0200, Michal Simek wrote:
>> On 10/18/2015 07:53 PM, Josh Cartwright wrote:
>>> On Fri, Oct 16, 2015 at 03:42:29PM -0700, Moritz Fischer wrote:
> [..]
>>>> @@ -294,6 +294,11 @@
>>>>  		devcfg: devcfg at f8007000 {
>>>>  			compatible = "xlnx,zynq-devcfg-1.0";
>>>>  			reg = <0xf8007000 0x100>;
>>>> +			interrupt-parent = <&intc>;
>>>
>>> You shouldn't need interrupt-parent here.  In fact, I suspect it can be
>>> removed from all sibling nodes as well.
>>
>> Correct. But I tend to do it vice-versa. To remove it from amba node and
>> keep it in every IP here. The reason is simple to let everybody know
>> that setting up right interrupt controller is something what they have
>> to care. If you have more interrupt controllers in the system it can be
>> messy.
> 
> If you like that, then you'd like the interrupt-extended properly even
> better (I think).

yep. That works for me too.

Thanks,
Michal
