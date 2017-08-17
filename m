From: andre.przywara@arm.com (Andre Przywara)
Date: Thu, 17 Aug 2017 10:57:54 +0100
Subject: [PATCH v2 0/3] mailbox: arm: introduce smc triggered mailbox
In-Reply-To: <ffabbe33-5edd-4642-6038-5b48c87ad372@suse.de>
References: <1500852206-28771-1-git-send-email-andre.przywara@arm.com>
 <ffabbe33-5edd-4642-6038-5b48c87ad372@suse.de>
Message-ID: <a1faf9ae-f5f9-68d0-551f-73c4edd11e16@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

(sorry for the delay, cleaning up my inbox after holidays)

On 01/08/17 11:50, Alexander Graf wrote:
> Hi Andre,
> 
> On 24.07.17 01:23, Andre Przywara wrote:
>> This is a reworked version of my previous post. It addresses Jassi's
>> comments on the driver and also tries to cover Rob's and Mark's comments
>> on the binding documentation.
>> I dropped the more example-like DT changes from v1, as they are actually
>> not meant to be merged into the Linux tree, but instead are provided as
>> part of some firmware actually implementing this functionality.
>>
>> Please let me know what you think.
> 
> Could you please quickly explain what it would take to provide SCMI on
> top of this instead of SCPI?

On the Linux side basically nothing, that's actually the beauty of this
approach. This driver here is just a Linux mailbox interface provider.
And both SCMI and SCPI rely on one.
So all you would need to do is to provide compliant services on the
firmware side and add the proper nodes to the DT. Whether this is SCMI
or SCPI does not really make much of a difference, apart from the yet
missing upstream Linux support for SCMI, of course.

Cheers,
Andre.

> https://lkml.org/lkml/2017/6/7/624
> 
> I can certainly see that SCPI is an easier target because it's already
> upstream and widely spread. But wouldn't it make sense to jump on the
> SCMI train while it's taking steam?
> 
> 
> Thanks,
> 
> Alex
