From: michal.simek@xilinx.com (Michal Simek)
Date: Mon, 10 Sep 2018 14:35:04 +0200
Subject: [PATCH v11 03/11] firmware: xilinx: Add zynqmp IOCTL API for
 device control
In-Reply-To: <CAAtXAHfwpKagBUQSFLJ1bBsxvbvyg=+nCuQv11eD+nhuxD=1_A@mail.gmail.com>
References: <1533318808-10781-1-git-send-email-jollys@xilinx.com>
 <1533318808-10781-4-git-send-email-jollys@xilinx.com>
 <CAOesGMi7Q9L4oZkUubKtV-m8XD67MQ05ZFhPA_0Hwky_qVUxfg@mail.gmail.com>
 <CAAtXAHfwpKagBUQSFLJ1bBsxvbvyg=+nCuQv11eD+nhuxD=1_A@mail.gmail.com>
Message-ID: <0bc8f69a-2d44-7ee2-133b-29f6dd4c0929@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 9.9.2018 21:20, Moritz Fischer wrote:
> Hi Olof,
> 
> On Sat, Sep 8, 2018 at 6:18 PM, Olof Johansson <olof@lixom.net> wrote:
>> Hi,
>>
>> On Fri, Aug 3, 2018 at 10:53 AM, Jolly Shah <jolly.shah@xilinx.com> wrote:
>>> From: Rajan Vaja <rajanv@xilinx.com>
>>>
>>> Add ZynqMP firmware IOCTL API to control and configure
>>> devices like PLLs, SD, Gem, etc.
>>>
>>> Signed-off-by: Rajan Vaja <rajanv@xilinx.com>
>>> Signed-off-by: Jolly Shah <jollys@xilinx.com>
>>
>> This patch worries me somewhat. It's a transparent pass-through ioctl
>> driver. Is there a spec available for what the implemented IOCTLs are?
>>
>> Should some of them be proper drivers instead of an opaque
>> pass-through like this? Could some of them have stability impact on
>> the platform such that there are security concerns and the list of
>> arguments should somehow be sanitized?
> 
> I tend to agree with this, good catch.
> 
>> What's the intended usecase anyway? Just a debug tool during
>> development, or something that you expect heavy use of by some
>> userspace middleware?
> 
> I suspect it is another attempt to make userspace clocks/plls work? Scary.

none is trying to do that as far as I know.

Thanks,
Michal
