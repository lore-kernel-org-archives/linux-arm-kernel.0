From: robherring2@gmail.com (Rob Herring)
Date: Fri, 11 Nov 2011 10:38:17 -0600
Subject: [PATCH] mach-ux500: add devicetree compat nodes
In-Reply-To: <CACRpkdZrWW2jUYC0P7yY322YMdn9+4_NaGPhKtpGwR+e=F6+0A@mail.gmail.com>
References: <1321023902-18870-1-git-send-email-niklas.hernaeus@linaro.org>
 <4EBD3C85.1010508@gmail.com>
 <CACRpkda-9OVP8E1qO3Nc5znw_v7cKFiv8T5HHwTCnY2C9Fg7iA@mail.gmail.com>
 <4EBD49A6.2020306@gmail.com>
 <CACRpkdZrWW2jUYC0P7yY322YMdn9+4_NaGPhKtpGwR+e=F6+0A@mail.gmail.com>
Message-ID: <4EBD4F79.90302@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/11/2011 10:26 AM, Linus Walleij wrote:
> On Fri, Nov 11, 2011 at 5:13 PM, Rob Herring <robherring2@gmail.com> wrote:
>> On 11/11/2011 09:59 AM, Linus Walleij wrote:
>>>
>>> So - different .init_machine() calls, needed to simplify the board
>>> files as of now. (Patch from Lee Jones.)
>>
>> But ultimately I would expect that the init_machine calls to be the same
>> with a DT based machine. This goes back to do we add DT to existing
>> boards or create a new clean DT machine and add to it as boards are
>> converted?
> 
> Yes that should be the ultimate goal. So the current per-board
> init functions register the I2C, MMC (SDI), SPI, UART and
> regulator devices etc. So then these drivers need to be patched to
> get their board/platform data from DT first.
> 
> In that case we should hold this patch off and only keep it for
> internal testing until all necessary drivers are ready and patched
> so we can replace all board files with a single DT-based one,
> instead of this compromise solution.
> 
I would not hold off. You only need to have a minimal set that's enough
to boot.

> Is this what everybody else does?

That was the the consensus in Budapest in May. It's much cleaner to
start with a new board file and then ultimately just delete the old
ones. But it's really up to the board/SOC maintainer.

Rob

> Thanks,
> Linus Walleij
