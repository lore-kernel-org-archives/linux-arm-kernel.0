From: dianders@chromium.org (Doug Anderson)
Date: Mon, 5 Jan 2015 17:07:18 -0800
Subject: [PATCH v3 1/4] mmc: dw_mmc: exynos: incorporate ciu_div into
 timing property
In-Reply-To: <CAGOxZ509kASim7keNkAGj5gAGO02=7vZM=VL-MRMObv3x+CzTg@mail.gmail.com>
References: <1420008185-24758-1-git-send-email-alim.akhtar@samsung.com>
 <1420008185-24758-2-git-send-email-alim.akhtar@samsung.com>
 <CAD=FV=WXzPt=VKxB=KHK+hC=RN6WbmdnQcLUT4zFQ0Ud7BFanQ@mail.gmail.com>
 <CAGOxZ509kASim7keNkAGj5gAGO02=7vZM=VL-MRMObv3x+CzTg@mail.gmail.com>
Message-ID: <CAD=FV=U0U2ycmd4jyVyFiEq0+3ujSpdBeFg27iYYbMRxpRCmmQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Alim,

On Sun, Jan 4, 2015 at 2:43 PM, Alim Akhtar <alim.akhtar@gmail.com> wrote:
>> You are breaking backward compatibility here.  If your change is
>> merged then all old boards will instantly break.  Since the "dts" and
>> code changes will likely be merged through different trees you'll end
>> up with a bunch of broken trees until everything is merged together.
>> Even if you don't subscribe to the stable bindings theory this is not
>> acceptable.
>>
> yes the major concern in this series is probably this, which breaks
> things unless everything merge in one go and via one tree. Thats why I
> re-based everything including dts change on mmc-tree for this case and
> added device-tree mailing list for more opinion etc.

Got it.  I doubt that folks will like this, but I could be wrong.  In
order for this to work, you'd need all changes in the series to land
in _both_ the ARMSoC tree and the MMC tree.  That's not unheard of,
but it doesn't seem ideal.

You also break bisect-ability here since without the code the DTS
change will break things and without the DTS change the code will
break things.

If you add all the above to the fact that bindings are supposed to be
stable (ish) I'm not convinced this will land.


-Doug
