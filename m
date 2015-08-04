From: lars@metafoo.de (Lars-Peter Clausen)
Date: Tue, 04 Aug 2015 10:01:36 +0200
Subject: [PATCH v3] iio: adc: xilinx-xadc: Push interrupts into threaded
 context
In-Reply-To: <55BFCC9C.5040305@ni.com>
References: <CAKfKVtGTO81wLWk50M303t2WjcBEMEt_LUnsJ3_WmvR_3izUjg@mail.gmail.com>
 <1437434050-32907-1-git-send-email-xander.huff@ni.com>
 <55B231DE.4080308@metafoo.de> <55BFCC9C.5040305@ni.com>
Message-ID: <55C07160.5040907@metafoo.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/03/2015 10:18 PM, Xander Huff wrote:
> On 7/24/2015 7:38 AM, Lars-Peter Clausen wrote:
>> Hi,
>>
>> Sorry, but I don't think this patch has been sufficiently tested against a
>> mainline kernel. The driver wont even probe the way it is right now.
>>
> Thanks for your responses. I'm not sure why it doesn't probe for you since I
> was able to do a fair amount of tests with it on our device.

genirq: Threaded irq requested with handler=NULL and !ONESHOT for irq 157
xadc: probe of f8007100.xadc failed with error -22

You can' request a threaded IRQ without having IRQF_ONESHOT set, since this
will effectively result in a IRQ storm.

> 
> I'll get to work on your suggestions and hopefully having a v4 out sometime
> next week.
> 
