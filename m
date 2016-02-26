From: blogic@openwrt.org (John Crispin)
Date: Fri, 26 Feb 2016 16:24:47 +0100
Subject: [PATCH V2 03/12] net-next: mediatek: add embedded switch driver
 (ESW)
In-Reply-To: <20160226151813.GD12022@lunn.ch>
References: <1456496504-50429-1-git-send-email-blogic@openwrt.org>
 <1456496504-50429-4-git-send-email-blogic@openwrt.org>
 <20160226151813.GD12022@lunn.ch>
Message-ID: <56D06E3F.1020100@openwrt.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 26/02/2016 16:18, Andrew Lunn wrote:
> On Fri, Feb 26, 2016 at 03:21:35PM +0100, John Crispin wrote:
>> The ESW is found in many of the old 100mbit MIPS based SoCs. it has 5
>> external ports, 1 cpu port and 1 further port that the internal HW
>> offloading engine connects to.
>>
>> This driver is very basic and only provides basic init and irq support.
>> The SoC and switch core both have support for a special tag making DSA
>> support possible.
> 
> Hi Crispin
> 
> There was recently a discussion about adding switches without using
> DSA or switchdev. It was pretty much decided we would not accept such
> drivers.
> 
> Sorry
> 
> 	Andrew
> 
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
> 

Hi,

would the series be ok if we just dropped those parts and then have a
driver in the kernel that wont do much with the out of tree patches ?

the problem here is that on one side people complain about vendors not
sending code upstream. once they start being a good citizen and provide
funding to send stuff upstream the feedback tends to be very bad as seen
here. we are planning on doing a DSA driver but one step at a time. this
kind of feedback will inevitably lead to vendors doing second thoughts
of upstream contributions.

	John
