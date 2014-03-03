From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Mon, 03 Mar 2014 17:38:49 +0100
Subject: [PATCH] usb: gadget: atmel_usba: Fix crashed during stopping
 when DEBUG is enabled
In-Reply-To: <20140303163308.GA10987@saruman.home>
References: <1393598066-4016-1-git-send-email-gregory.clement@free-electrons.com>
 <20140303163308.GA10987@saruman.home>
Message-ID: <5314B019.9040505@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/03/2014 17:33, Felipe Balbi wrote:
> On Fri, Feb 28, 2014 at 03:34:01PM +0100, Gregory CLEMENT wrote:
>> The debug trace in the atmel_usba_stop function made the assumption
>> that the driver pointer passed in parameter was not NULL. Since the
>> commit "usb: gadget: udc-core: fix a regression during gadget driver
>> unbinding", it was no more always true. This lead to a kernel crash.
>>
>> This commit now use the driver pointer stored in udc which fixes this
>> issue.
>>
>> Since the commit which have triggered this issue was backported to the
>> 3.2 stable branch, then this one should also be backported to the same
>> kernel.
>>
>> Cc: stable at vger.kernel.org # v3.2+
>> Fixes: 511f3c5326ea (usb: gadget: udc-core: fix a regression during gadget driver unbinding)
> 
> this line shouldn't be here and you're missing a SoB line, can't take
> this patch, sorry.

Right, I forgot the -s option for this commit.

and you want the "Fixes" line be before the Cc: line, right?

Thanks,

Gregory



-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
