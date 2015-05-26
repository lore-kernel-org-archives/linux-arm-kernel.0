From: lars@metafoo.de (Lars-Peter Clausen)
Date: Tue, 26 May 2015 11:38:40 +0200
Subject: [PATCH 2/2] iio: adc: xilinx-xadc: Add xlnx,extend-name as an
 optional argument for aux channels
In-Reply-To: <55606340.1090403@kernel.org>
References: <1431038644-41600-1-git-send-email-xander.huff@ni.com>
 <1431038644-41600-2-git-send-email-xander.huff@ni.com>
 <555B78A3.2030202@metafoo.de> <55606340.1090403@kernel.org>
Message-ID: <55643F20.4080306@metafoo.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/23/2015 01:23 PM, Jonathan Cameron wrote:
> On 19/05/15 18:53, Lars-Peter Clausen wrote:
>> On 05/08/2015 12:44 AM, Xander Huff wrote:
>>> To better facilitate user-mode access to optional aux channels, allow
>>> device trees to specify a custom extended name for defined channels.
>>
>> Hi,
>>
>> 'extend-name' is kind of a IIO specific term. I think a better name in the devicetree context would be 'label'. That's used everywhere else when giving a short description string to a node.
>>
> Hi Lars,
>
> What do you think of the general idea?  I'm unconvinced we want to do this in channel naming.
> Perhaps we want an additional attribute giving access to this sort of 'semantic' information?

I'm not convinced about it either. My gut feeling is that this is not the 
right approach, but I don't really have any better ideas at the moment.

Xander can you give a short description of how this information will be used 
by an application? Would having a label property for the channel also work 
for you (e.g. in_voltage0_label)?

- Lars
