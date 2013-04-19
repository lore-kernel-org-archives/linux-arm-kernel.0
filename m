From: amurray@embedded-bits.co.uk (Andrew Murray)
Date: Fri, 19 Apr 2013 18:15:19 +0100
Subject: [GIT PULL V2 1/4] mvebu driver changes for v3.10
In-Reply-To: <51716CD9.4030901@free-electrons.com>
References: <20130415182824.GN28693@titan.lakedaemon.net>
 <20130416150416.GB28693@titan.lakedaemon.net>
 <20130418053002.GB12816@quad.lixom.net>
 <CAOesGMjD-VAZW-zL-jm65xSJkFLpzbYOdvN6-5pV1OW_vJDCWg@mail.gmail.com>
 <517155FE.30406@free-electrons.com>
 <51716CD9.4030901@free-electrons.com>
Message-ID: <CAPcvp5Gq_K0w2QnmseX-D3x6Y765EabySeJfB51iXF-TXYMQDw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19 April 2013 17:12, Gregory CLEMENT
<gregory.clement@free-electrons.com> wrote:
> On 04/19/2013 04:34 PM, Gregory CLEMENT wrote:
>> On 04/19/2013 04:09 PM, Olof Johansson wrote:
>>> On Wed, Apr 17, 2013 at 10:30 PM, Olof Johansson <olof@lixom.net> wrote:
>>>> On Tue, Apr 16, 2013 at 11:04:16AM -0400, Jason Cooper wrote:
>>>>>
>>>>> The following changes since commit 8bb9660418e05bb1845ac1a2428444d78e322cc7:
>>>>>
>>>>>   Linux 3.9-rc4 (2013-03-23 16:52:44 -0700)
>>>>>
>>>>> are available in the git repository at:
>>>>>
>>>>>   git://git.infradead.org/users/jcooper/linux.git tags/drivers-3.10-2
>>>>>
>>>>> for you to fetch changes up to ac7b07ec369324063e52c37b3fb0ad1a1814d879:
>>>>>
>>>>>   clk: mvebu: add more PCIe clocks for Armada XP (2013-04-16 14:47:01 +0000)
>>>>
>>>> Pulled, thanks.
>>>
>>> Dropped due to build errors on powerpc64. 3.11 material now.
>>>
>>
>> Wait! That means dropping _all_ the change done in mvebu for 3.10 just
>> for one patch in the of/pci part?
>>
>> Jason, did you take the accurate patch? Because according to Grant
>> Likely, the build didn't fail on ppc, see:
>>
>> http://www.spinics.net/lists/arm-kernel/msg238517.html
>
> I investigated it a little more and my first assumption was wrong,
> the faulty commit was not the one I think. I didn't work directly
> on the PCIe part, and Thomas who did it is currently in the plane.

I thought the faulty commit with in the MIPS patch (last patch in the
set). And a patch to fix this was prepared by Gabor Juhos [2].

Or is there another faulty commit in my v7 set [1]? If you let me know
I can fix it

Andrew Murray

[1] http://www.spinics.net/lists/linux-pci/msg21708.html
[2] http://permalink.gmane.org/gmane.linux.ports.mips.general/37399

>
> So instead of throwing everything, could you just remove the
> offending commit, AFAIK we don't need it yet, (the patch
> depending of this one are located in the mvebu-late/pcie branch):
>
> 9ecbe03 pci: infrastructure to add drivers in drivers/pci/host
>
> Thanks!
>
>>
>>
>>>
>>> -Olof
>>>
>>
>>
>
>
> --
> Gregory Clement, Free Electrons
> Kernel, drivers, real-time and embedded Linux
> development, consulting, training and support.
> http://free-electrons.com
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
