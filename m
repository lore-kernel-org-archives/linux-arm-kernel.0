From: michal.simek@xilinx.com (Michal Simek)
Date: Wed, 2 May 2018 15:41:12 +0200
Subject: [PATCH] gpio: zynq: Setup chip->base based on alias ID
In-Reply-To: <CACRpkdYgw+HaC5bUCZKiD7j+2ZLYbCTG+DdPdAEkRDq0xF5b3w@mail.gmail.com>
References: <6ee982f8eb6e07f9ecbb0cc5093152f4a16b9c31.1523454899.git.michal.simek@xilinx.com>
 <CACRpkdbOa+AvhQT1RCWA_zQuTpp4qfNjZBFDOKLdaFqMGAe+cw@mail.gmail.com>
 <f9dd4f64-4026-f495-5810-32affb5b0944@xilinx.com>
 <CACRpkdaxwRc0zoDKogVGisXTPJ0EwLbOQjHzz1pSEjvWCsSCTQ@mail.gmail.com>
 <cc8d864a-e8e6-d30d-ae54-91819e5d0b8d@xilinx.com>
 <CACRpkdYgw+HaC5bUCZKiD7j+2ZLYbCTG+DdPdAEkRDq0xF5b3w@mail.gmail.com>
Message-ID: <60652f48-2a98-414b-5cff-25890a6da37f@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2.5.2018 15:01, Linus Walleij wrote:
> On Wed, May 2, 2018 at 12:15 PM, Michal Simek <michal.simek@xilinx.com> wrote:
>> On 2.5.2018 12:10, Linus Walleij wrote:
>>> On Thu, Apr 26, 2018 at 3:35 PM, Michal Simek <michal.simek@xilinx.com> wrote:
> 
>>>> Yes, it is about legacy application which I have seen recently and there
>>>> is no source code for application calls it because board vendor doesn't
>>>> provide it.
>>>>
>>>> You are right that -1 was used from the beginning in mainline but
>>>> unfortunately this driver was in vendor tree for a while and it uses 0
>>>> there.
>>>>
>>>> In upstreaming this was changed to -1 but customers have a lot of code
>>>> which developed against vendor tree and they want to use
>>>> latest&greatest. And without this they are not able to run that
>>>> applications.
>>>>
>>>> I found that this logic is already in 5 drivers in mainline that's why I
>>>> send this patch to be +1.
>>>
>>> I see.
>>>
>>> Sadly comaptibility with out-of-tree driver code is none of our
>>> (community) business.
>>>
>>> We do pay a lot of effort not to break the ABI to userspace, but
>>> it needs to be an ABI coming from the mainline kernel, not from
>>> a vendor tree.
>>>
>>> So to the mainline kernel this is no regression.
>>
>> I understand your statement. On the other hand it is feature which was
>> permitted in past for some drivers and this is +1.
> 
> But was it permitted because of breaking out of tree code?

You know how soc vendors are working. We need to develop code out of
mainline for certain time because we can't share details before.

When we get permission to upstream code a lot of application code is
done already with certain expectation.

Soren has sent this driver with using -1 for autodetection even at that
time Xilinx gpio driver had 0 there.

This patch is not breaking any current functionality and there is no any
gpio alias in zynq/zynqmp too. And from my point of view the usage of
gpio alias is similar to others aliases present in DTS file.

If you don't want this patch I understand that and it will become just
another soc vendor patch out of mainline.

Thanks,
Michal
