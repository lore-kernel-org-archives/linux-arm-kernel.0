From: khilman@kernel.org (Kevin Hilman)
Date: Mon, 01 Dec 2014 17:26:26 -0800
Subject: [PATCH v10 0/4] This suspend patch is only support cut off the
 power of cpu and some external
In-Reply-To: <CAD=FV=XuQk17CTNKJY++J+w9Ab9_OUX0ca0A99m7yKPAWSs2=w@mail.gmail.com>
 (Doug Anderson's message of "Mon, 1 Dec 2014 17:07:39 -0800")
References: <1417423940-1669-1-git-send-email-zyw@rock-chips.com>
 <7htx1f409k.fsf@deeprootsystems.com>
 <CAD=FV=V2go5BMFbiFKu73_aVz5ck949W-kJQ6WLkAQRPJbjPVA@mail.gmail.com>
 <CAD=FV=XuQk17CTNKJY++J+w9Ab9_OUX0ca0A99m7yKPAWSs2=w@mail.gmail.com>
Message-ID: <7hmw763kql.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Doug Anderson <dianders@chromium.org> writes:

> Hi,
>
> On Mon, Dec 1, 2014 at 2:08 PM, Doug Anderson <dianders@chromium.org> wrote:
>> Hi,
>>
>> On Mon, Dec 1, 2014 at 11:51 AM, Kevin Hilman <khilman@kernel.org> wrote:
>>> Chris Zhong <zyw@rock-chips.com> writes:
>>>
>>>> devices, since we still lack power_domain driver, so the other power rail
>>>> of rk3288 need keep power on.
>>>> I have tested it on rk3288-evb board, atop next-20141112. goto suspend by type
>>>> "echo mem > /sys/power/state", vdd_cpu is about 0mv by measuring, so it can be
>>>> determined in sleep mode, then press power button to wakeup it.
>>>
>>> I tested this on top of today's linux-next (next-20141201) and it
>>> suspends, but doesn't wake up from any of the button presses.  What
>>> wakeup sources are configured for the rk3288-evb-rk808?
>>
>> Just to close the loop (I talked with Kevin over IM about this, too):
>>
>> I have a huge description of how I tested this as part of my patch at
>> <https://patchwork.kernel.org/patch/5414941/>.  Chris:  I think Kevin
>> has asked you several times to include information like this in your
>> cover letter.  Please, please, please can you try to remember to do
>> this?
>
> Talked to Chris offline.  He said that in his tests the other patches
> weren't needed, so he didn't list any other patches.  Things just
> worked for him.  ...so I guess he did post the instructions that
> worked for him.  Sorry for the complaint.  Possibly things are
> different on "next-20141112" and that's where Chris said he tested.

This series doesn't apply cleanly to next-20141112.  Manually applying
(with fuzz), it boots but I have the same results: it suspends, but none
of the buttons wake it up.

Kevin
