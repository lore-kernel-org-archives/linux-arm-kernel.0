From: alex.shi@linaro.org (Alex Shi)
Date: Sat, 3 Mar 2018 08:52:07 +0800
Subject: [PATCH 00/45] arm Spectre fix backport review for LTS 4.9
In-Reply-To: <86r2p23h3v.wl-marc.zyngier@arm.com>
References: <1519908862-11425-1-git-send-email-alex.shi@linaro.org>
 <20180301164630.GB23321@kroah.com>
 <c96bc4d8-25b8-684b-83f6-7d6c6c0fea4b@linaro.org>
 <86r2p23h3v.wl-marc.zyngier@arm.com>
Message-ID: <a16dc104-2ede-77db-506e-266a7127e373@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 03/02/2018 06:29 PM, Marc Zyngier wrote:
> On Fri, 02 Mar 2018 09:02:32 +0000,
> Alex Shi wrote:
>>
>>
>>
>> On 03/02/2018 12:46 AM, Greg KH wrote:
>>> On Thu, Mar 01, 2018 at 08:53:37PM +0800, Alex Shi wrote:
>>>> Hi All,
>>>>
>>>> Resent without non-upstream patches.
>>>>
>>>> This backport patchset fixed the spectre issue, it's original branch:
>>>> https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git/log/?h=kpti
>>>> A few dependency or fixingpatches are also picked up, if they are necessary
>>>>  and no functional changes.
>>>>
>>>> No bug found from kernelci.org and lkft testing. It also could be gotten from:
>>>>
>>>> git://git.linaro.org/kernel/linux-linaro-stable.git v4.9-spectre-upstream-only
>>>
>>> Also, how did you test, what platforms did you test, and did you test
>>> that this actually did fix the spectre issue on your platforms?  If so,
>>> what test did you use?
>>>
>>
>> On the kernelci, there are 18 kinds of platoforms with different
>> configure tested booting, detailed info is here:
>> https://kernelci.org/boot/all/job/lsk/branch/linux-linaro-lsk-v4.9-test/kernel/lsk-v4.9-17.03-4844-g6f782cff6edb/
>>
>> I also tested the qemu boot on hikey620. and normal boot on
> 
> Did you try QEMU in conjunction with KVM? Or just in emulation?

Many many thanks for response!

Yes, I tried both of type boot with or w/o KVM. Both works.

> 
>> hikey620/db410c/junor2. The other testing include the LKFT testing which
>> is reported by email, same as test for LTS. None of testing show
>> regressions.
>>
>>
>> As testing the spectre bug fix, that's a good question. I also asked
>> this question to original patch authors, like Marc. They said they just
>> figure out these patches could block spectre or meltdown issue. From my
>> side, I just reproduced the process internal spectre. But all fix on arm
>> can not resolve the user space internal spectre. It can block from user
>> to kernel or kernel to user spectre according the code purose. So I
>> believe these patch could do their job. And arm cpu would drop the
>> spectre branches if it has 20+ 'nop' instructions...
> 
> What are you talking about? What's that story about NOPs? There are
> clear mitigation guidelines for ARM cores, please don't make things
> up.

Oops, sorry for misunderstanding! what's I meaning is, among many kind
of solution to mitigation issues, like ATF changes, compiler change, BT
changes, 'nop' is interesting for me. Sorry for bad expression.

Regards
Alex
