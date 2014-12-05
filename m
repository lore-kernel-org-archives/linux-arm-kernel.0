From: dianders@chromium.org (Doug Anderson)
Date: Fri, 5 Dec 2014 11:31:47 -0800
Subject: [PATCH v2] i2c: rk3x: fix bug that cause measured high_ns doesn't
 meet I2C spec
In-Reply-To: <20141204190342.GM7944@katana>
References: <1415261514-4051-1-git-send-email-addy.ke@rock-chips.com>
 <1417574237-4328-1-git-send-email-addy.ke@rock-chips.com>
 <20141203111518.GB1039@katana>
 <CAD=FV=X5inPWZakhgDX0dX=1CWXygEi3_AH9FVFWXYT3LZA5bg@mail.gmail.com>
 <20141204184046.GL7944@katana>
 <CAD=FV=Vp3hwxbDzb+FUhNXy8qW8fTCkgd67jRDV3foT0o9HQuQ@mail.gmail.com>
 <20141204190342.GM7944@katana>
Message-ID: <CAD=FV=XViU9divqK1etjHfyjwXyfFMyuwgcVh=NDyvEZfgE0dA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Dec 4, 2014 at 11:03 AM, Wolfram Sang <wsa@the-dreams.de> wrote:
>
>> > New binding should have the "-ns" suffix, right? So, I'd vote to add the
>> > suffix to the new bindings and deprecate the ones used in the designware
>> > driver: "i2c-scl-rising-time-ns" and "i2c-scl-falling-time-ns"
>> >
>> > It might be a little more work now, but it will help us in the future,
>> > because it is the correct way to do it.
>>
>> OK, that sounds fair.  You're OK with my proposal otherwise?
>
> Yes.

OK, for simplicity I put my requested changes in
<https://chromium-review.googlesource.com/#/c/232774/3>


>> Are you looking for Addy or me to submit a patch supporting the "-ns"
>> suffix on the Designware i2c driver, or should we just use the "-ns"
>> suffix in the Rockchip driver and assume someone will later add
>> support for the new binding in the Designware i2c driver?
>
> I'd be really happy if you can do it. I'd love to have consistency right
> away.

Well that was easy.  https://patchwork.kernel.org/patch/5445231/

-Doug
