From: wulf@rock-chips.com (wlf)
Date: Tue, 15 Nov 2016 11:22:30 +0800
Subject: [PATCH v2 1/2] phy: rockchip-inno-usb2: correct clk_ops callback
In-Reply-To: <CAD=FV=W36tdw3LqPq3tp58U4trYX6n=qaotMTsP6tm0QzZrRWQ@mail.gmail.com>
References: <1479106911-16049-1-git-send-email-wulf@rock-chips.com>
 <1479106911-16049-2-git-send-email-wulf@rock-chips.com>
 <CAD=FV=W36tdw3LqPq3tp58U4trYX6n=qaotMTsP6tm0QzZrRWQ@mail.gmail.com>
Message-ID: <ee7f7cd7-cd77-dfa9-5075-3cc08b1cd79e@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Doug,

? 2016?11?15? 02:15, Doug Anderson ??:
> William
>
> On Sun, Nov 13, 2016 at 11:01 PM, William Wu <wulf@rock-chips.com> wrote:
>> Since we needs to delay ~1ms to wait for 480MHz output clock
>> of USB2 PHY to become stable after turn on it, the delay time
>> is pretty long for something that's supposed to be "atomic"
>> like a clk_enable(). Consider that clk_enable() will disable
>> interrupt and that a 1ms interrupt latency is not sensible.
>>
>> The 480MHz output clock should be handled in prepare callbacks
>> which support gate a clk if the operation may sleep.
>>
>> Signed-off-by: William Wu <wulf@rock-chips.com>
>> ---
>>   drivers/phy/phy-rockchip-inno-usb2.c | 12 ++++++------
>>   1 file changed, 6 insertions(+), 6 deletions(-)
> Reviewed-by: Douglas Anderson <dianders@chromium.org>

Thanks! I'll add  Reviewed-by.
>
>
>
