From: anup@brainfault.org (Anup Patel)
Date: Fri, 6 Sep 2013 16:08:13 +0530
Subject: [RFC PATCH 0/3] Target CPU=Host implementation for KVM ARM/ARM64
In-Reply-To: <a917eed9bb3a02dd7b389187bd13b6bd@www.loen.fr>
References: <1378392362-6773-1-git-send-email-anup.patel@linaro.org>
 <CAFEAcA8z+_N3UQ-RQW9u65BpGRs+aKzhr2O34yOX0DhKZCAqRg@mail.gmail.com>
 <CAAhSdy1Qyum=v3_80SvGB3rKUP_Nxqg7858Uzf4QKdQd4YvzBA@mail.gmail.com>
 <BB11B00E-5EBD-45F5-89C7-7973919F7184@suse.de>
 <CAAhSdy1923zuSako480TTEoysZ6r_j9Z615=psQcQ8O=XyVeJQ@mail.gmail.com>
 <00DC6138-6D7D-442C-870B-6BE27931C71D@suse.de>
 <a917eed9bb3a02dd7b389187bd13b6bd@www.loen.fr>
Message-ID: <CAAhSdy2YJ6mQvZYWJO=LMU6PfnbP-cf-NL07LDwP_KKAWFT=nQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 6, 2013 at 4:04 PM, Marc Zyngier <marc.zyngier@arm.com> wrote:
> On 2013-09-06 11:24, Alexander Graf wrote:
>>
>> On 06.09.2013, at 12:05, Anup Patel wrote:
>>
>>> On Fri, Sep 6, 2013 at 2:24 PM, Alexander Graf <agraf@suse.de> wrote:
>>>>
>>>>
>>>> On 06.09.2013, at 09:44, Anup Patel wrote:
>
>
> [...]
>
>
>>>>> Another advantage I saw in extending KVM_ARM_VCPU_INIT ioctl is
>>>>> backward compatibility with current semantics. In other words, this
>>>>> patch
>>>>> does not break current KVMTOOL/QEMU and they can implement
>>>>> "-cpu host" whenever they wish without using any additional ioctl.
>>>>
>>>>
>>>> It's the opposite actually. By making the ioctl parameter in/out
>>>> direction you change the ioctl number, breaking the ABI, no?
>>>
>>>
>>> Originally the ioctl was only "in" and so we are preserving the "in"
>>> semantics. Thats why it is semantically backward compatible.
>>
>>
>> Great. So now we have an ioctl that says it's "in" in its ioctl
>> descriptor, but really it's in/out. This really only works by accident
>> because nobody is filtering the direction today.
>>
>> Nack.
>
>
> Agreed. We don't break the ABI, we don't try to fool the kernel. Please.

We are not breaking the ABI here and also not trying to fool the kernel.

>
> There's been previous suggestions on how to implement this feature, please
> consider them.

I am not convinced about how is this approach not better.

>
>         M.
> --
> Fast, cheap, reliable. Pick two.

--Anup
