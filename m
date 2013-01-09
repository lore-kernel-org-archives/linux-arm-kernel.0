From: agraf@suse.de (Alexander Graf)
Date: Wed, 9 Jan 2013 16:56:45 +0100
Subject: [PATCH v5 01/12] KVM: ARM: Introduce KVM_SET_DEVICE_ADDRESS ioctl
In-Reply-To: <0c1e99864fe87de92aa86a70504b9f73@localhost>
References: <CANM98qL=tisS_6rqPYHvo+xJUfC_WzypHABK2H_Ac+4Sqwb3-A@mail.gmail.com>
 <1357687783.10453.9@snotra>
 <CANM98q+=5gZ+=muw4UHy5hQ8D6zqz--BLa4Z0C39dnUxeCOWfA@mail.gmail.com>
 <9D32C496-91DE-44FC-BB1A-305BCE4A90CD@suse.de>
 <CAFEAcA99j=9dVz1YwZPZJ5tXR7ODQ4rZN_vfN046Bf7Yc1SQKg@mail.gmail.com>
 <86D3D406-05C3-4569-AD03-3223B46D47D9@suse.de>
 <CAFEAcA9z+kaSpVU3c8dWDHEnuGEri1JRZeS2+F5d2EefnX0oyQ@mail.gmail.com>
 <2ebf41d65170b9534c54c0c5f91a4b99@localhost>
 <13B0CEB2-8D36-48AE-BE0E-02D6231052CF@suse.de>
 <0c1e99864fe87de92aa86a70504b9f73@localhost>
Message-ID: <54937915-46BE-4A50-B5AA-26940DEE6A92@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 09.01.2013, at 16:50, Marc Zyngier wrote:

> On Wed, 9 Jan 2013 16:28:03 +0100, Alexander Graf <agraf@suse.de> wrote:
>> On 09.01.2013, at 16:22, Marc Zyngier wrote:
>> 
>>> On Wed, 9 Jan 2013 15:11:39 +0000, Peter Maydell
>>> <peter.maydell@linaro.org>
>>> wrote:
>>>> On 9 January 2013 14:58, Alexander Graf <agraf@suse.de> wrote:
>>>>> 
>>>>> Yeah, that was the basic idea. Considering that the patch set hasn't
>>>>> been going
>>>>> in for another 2 months after that discussion indicates that this
> isn't
>>>>> too much of
>>>>> an issue though :).
>>>> 
>>>> We might get there faster if people didn't keep nitpicking the APIs at
>>> the
>>>> last minute :-)
>>> 
>>> Exactly. We're trying hard to get the damned thing merged, and the
>>> permanent API churn quickly becomes a burden.
>> 
>> As I said earlier, we have had a lot of experience in creating really
> bad
>> APIs in the past.
> 
> Is this one really bad? Again, what changed in the meantime that makes you
> think this API is wrong?

I complained about it 2 months ago already.

>> But how about making this one specific? Call it
> KVM_ARM_SET_VGIC_ADDRESS,
>> keep the rest as it is, resend it, and later we can come up with an
>> actually generic interface.
> 
> Let's pretend you never wrote that, shall we? ;-)

Why? The worst thing that happened to us so far were interfaces that looked generic and extensible and turned out not to be (see SET_SREGS in the ppc code). We have 2 options to circumvent this:

  1) Commonly agree on an interface that actually is extensible and use it throughout the code
  2) Create a very specific interface for a single use case, keep it implemented "forever" and as soon as we need more, implement a more generic one that goes back to 1

Since the ARM patches have been out of tree for too long, I'm happy with going route 2 until we go back to square 1.


Alex
