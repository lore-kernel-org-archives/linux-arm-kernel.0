From: olof@lixom.net (Olof Johansson)
Date: Fri, 23 Oct 2015 12:42:13 -0700
Subject: [GIT PULL 1/2] Broadcom Device Tree changes for 4.4 (part 2)
In-Reply-To: <562A8B32.5040906@gmail.com>
References: <1445280190-8812-1-git-send-email-f.fainelli@gmail.com>
 <1445280190-8812-2-git-send-email-f.fainelli@gmail.com>
 <20151023182652.GE18961@localhost> <562A8B32.5040906@gmail.com>
Message-ID: <CAOesGMh8p0pA2-ZsNyk=NmkeJrB3my4drHBT7rNY2tYSYdHQKQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 23, 2015 at 12:32 PM, Florian Fainelli <f.fainelli@gmail.com> wrote:
> On 23/10/15 11:26, Olof Johansson wrote:
>> Hi Florian,
>>
>> On Mon, Oct 19, 2015 at 11:43:10AM -0700, Florian Fainelli wrote:
>>> The following changes since commit eef228e3191de0b62ef5913be216f25ba6b23a4c:
>>>
>>>   ARM: dts: move aliases back to .dts in Cygnus (2015-09-24 18:30:10 -0700)
>>>
>>> are available in the git repository at:
>>>
>>>   http://github.com/Broadcom/stblinux tags/arm-soc/for-4.4/devicetree-part2
>>>
>>> for you to fetch changes up to da6b53a6f7abc3d84260a9f0ff9849a88b44e11f:
>>>
>>>   ARM: bcm2835: Switch to using the new clock driver support. (2015-10-19 11:32:24 -0700)
>>>
>>> ----------------------------------------------------------------
>>> This pull request contains the DT changes for BCM2835 in 4.4.  It
>>> pulls in clk/clk-bcm2835 (which Stephen Boyd has said would be stable)
>>> because the DT changes to enable the clock driver need the driver
>>> itself to be present. These changes include the following:
>>>
>>> - Eric Anholt, moves the bcm2835 clock driver under bcm/ where it belongs with
>>>   other Broadcom clock providers drivers, defines the binding for new clock
>>>   driver, adds support for programming the BCM2835 audio domain, adds the DDC I2C
>>>   controller to Device Tree, and finally migrates the Device Tree to use the new
>>>   clock driver binding
>>>
>>> - Lubomir Rintel adds support for the Raspberry Pi Model A+ and B revision 2, and
>>>   remove the I2S controller which is non-existent on Raspberry Pi Model B
>>>
>>> - Stefan Wahren adds an uart0 label for referencing the UART adapter
>>>
>>> ----------------------------------------------------------------
>>> Eric Anholt (5):
>>>       ARM: bcm2835: Add the DDC I2C controller to the device tree.
>>>       clk: bcm2835: Move under bcm/ with other Broadcom SoC clk drivers.
>>
>> I see this patch in the branch, and it's signed off both by Stephen and you,
>> which makes me suspect you cherry-picked it over from their tree?
>>
>> That means it'll exist in two copies and might cause pretty nasty conflicts at
>> merge time if other changes have gone in on top of the separate commits.
>> Instead, we ask that you share a branch with the same exact commits, since git
>> will handle that appropriately and the patch will only be in the tree once.
>
> Just to clarify, are you okay with me merging a branch from Eric's tree,
> or do you want to see individual commits, except for those that appear
> in Stephen's tree (the clock changes basically)?

I'm OK with you merging from Eric. I don't know how Stephen checked in
the clock patches -- if they're just applied patches in the full
history of his tree then it'll be really awkward to bring them in. If
he applied them on a topic branch then you should base your work on
top of that branch (without rebasing it).


-Olof
