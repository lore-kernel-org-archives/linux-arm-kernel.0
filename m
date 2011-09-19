From: aliguori@us.ibm.com (Anthony Liguori)
Date: Mon, 19 Sep 2011 08:28:23 -0500
Subject: [RFC v3] arm: Add platform bus driver for memory mapped virtio
	device
In-Reply-To: <874o09ryzm.fsf@rustcorp.com.au>
References: <1316191623-3835-1-git-send-email-pawel.moll@arm.com>	<4E7380FD.1030200@us.ibm.com>
	<874o09ryzm.fsf@rustcorp.com.au>
Message-ID: <4E774377.8030703@us.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/18/2011 10:29 PM, Rusty Russell wrote:
> On Fri, 16 Sep 2011 12:01:49 -0500, Anthony Liguori<aliguori@us.ibm.com>  wrote:
>> On 09/16/2011 11:47 AM, Pawel Moll wrote:
>>> This patch, based on virtio PCI driver, adds support for memory
>>> mapped (platform) virtio  device. This should allow environments
>>> like qemu to use virtio-based block&   network devices.
>>>
>>> One can define and register a platform device which resources
>>> will describe memory mapped control registers and "mailbox"
>>> interrupt. Such device can be also instantiated using the Device
>>> Tree node with compatible property equal "virtio,mmio".
>>>
>>> Cc: Rusty Russell<rusty@rustcorp.com.au>
>>> Cc: Anthony Liguori<aliguori@us.ibm.com>
>>> Cc: Michael S.Tsirkin<mst@redhat.com>
>>> Signed-off-by: Pawel Moll<pawel.moll@arm.com>
>>
>> Have you written a specification for this device?
>>
>> Rusty maintains a formal spec for all virtio devices at:
>>
>> http://ozlabs.org/~rusty/virtio-spec/
>>
>> The spec should be written before merging the code to make sure that there
>> aren't future compatibility problems.
>
> A good idea, but the current spec is for PCI.  I wonder if we should
> move the PCI part out to an appendix and make it more general?
>
> Meanwhile, perhaps this would be suitable as an appendix.

I was thinking an appendix would be a good start.

Regards,

Anthony Liguori

>
> Cheers,
> Rusty.
