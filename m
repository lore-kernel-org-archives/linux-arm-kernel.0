From: Suzuki.Poulose@arm.com (Suzuki K. Poulose)
Date: Tue, 26 Jan 2016 16:21:43 +0000
Subject: [PATCH] arm64: Add support for Half precision floating point
In-Reply-To: <20160126160257.GB28238@arm.com>
References: <1453823566-26742-1-git-send-email-suzuki.poulose@arm.com>
 <20160126160257.GB28238@arm.com>
Message-ID: <56A79D17.2000009@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26/01/16 16:02, Will Deacon wrote:
> Hi Suzuki,
>
> On Tue, Jan 26, 2016 at 03:52:46PM +0000, Suzuki K Poulose wrote:
>> ARMv8.2 extensions [1] include an optional feature, which supports
>> half precision(16bit) floating point/asimd data processing
>> instructions. This patch adds support for detecting and exposing
>> the same to the userspace via HWCAPs


>> +#define HWCAP_FPHP		(1 << 9)
>> +#define HWCAP_ASIMDHP		(1 << 10)
>
> Where did we get to with the mrs trapping you proposed here?
>
>    http://lists.infradead.org/pipermail/linux-arm-kernel/2015-October/374609.html

We are yet to get some feedback from glibc/gcc folks. Siddhesh was looking
to make use of it [2]. But haven't heard anything back. Ramana mentioned
(in private) that they had some plans to take a look at it.

>
> At some point, we need to consider whether or not we want to continue
> adding new HWCAPs or whether your suggestion above is actually useful
> to userspace.

Definitely.


> Did the libc guys get anywhere with a prototype? What do we need to do
> to make progress with it?

I am not sure.

Siddesh, Ramana,

Could you please let us know your plans ?

[2] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-October/381422.html

Thanks
Suzuki
