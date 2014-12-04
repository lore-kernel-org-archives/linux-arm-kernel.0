From: dianders@chromium.org (Doug Anderson)
Date: Thu, 4 Dec 2014 10:43:19 -0800
Subject: [PATCH v2] i2c: rk3x: fix bug that cause measured high_ns doesn't
 meet I2C spec
In-Reply-To: <20141204184046.GL7944@katana>
References: <1415261514-4051-1-git-send-email-addy.ke@rock-chips.com>
 <1417574237-4328-1-git-send-email-addy.ke@rock-chips.com>
 <20141203111518.GB1039@katana>
 <CAD=FV=X5inPWZakhgDX0dX=1CWXygEi3_AH9FVFWXYT3LZA5bg@mail.gmail.com>
 <20141204184046.GL7944@katana>
Message-ID: <CAD=FV=Vp3hwxbDzb+FUhNXy8qW8fTCkgd67jRDV3foT0o9HQuQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Wolfram,

On Thu, Dec 4, 2014 at 10:40 AM, Wolfram Sang <wsa@the-dreams.de> wrote:
>
>> If you don't read all the below, my belief is that we should simply
>> rename the strings in Addy's patch.  We should change "rise-ns" to
>> "i2c-scl-rising-time" and "fall-ns" to "i2c-scl-falling-time".
>> Wolfram: can you confirm this is OK?  I'm voting to leave the "-ns"
>> off the end of both to avoid asymmetry.
>
> New binding should have the "-ns" suffix, right? So, I'd vote to add the
> suffix to the new bindings and deprecate the ones used in the designware
> driver: "i2c-scl-rising-time-ns" and "i2c-scl-falling-time-ns"
>
> It might be a little more work now, but it will help us in the future,
> because it is the correct way to do it.

OK, that sounds fair.  You're OK with my proposal otherwise?

Are you looking for Addy or me to submit a patch supporting the "-ns"
suffix on the Designware i2c driver, or should we just use the "-ns"
suffix in the Rockchip driver and assume someone will later add
support for the new binding in the Designware i2c driver?

-Doug
