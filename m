From: dianders@chromium.org (Doug Anderson)
Date: Tue, 20 Oct 2015 19:14:29 -0700
Subject: [PATCH 3/4] thermal: rockchip: change the TSHUT default state
In-Reply-To: <5626EEB2.50101@gmail.com>
References: <1445332264-6054-1-git-send-email-wxt@rock-chips.com>
 <1445332264-6054-4-git-send-email-wxt@rock-chips.com>
 <CAD=FV=Vo1Wf6opTc5jQjm-nXd=BCJxeggipPj4ER9Ehutxs_6w@mail.gmail.com>
 <5626EEB2.50101@gmail.com>
Message-ID: <CAD=FV=UNyjJmN4TtZ+1DOeM_OYikRAUhYsN=F_f-q5MA_MVFag@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Caesar,

On Tue, Oct 20, 2015 at 6:47 PM, Caesar Wang <caesar.upstream@gmail.com> wrote:
> Doug,
>
> ? 2015?10?21? 00:01, Doug Anderson ??:
>
> Caesar,
>
> On Tue, Oct 20, 2015 at 2:11 AM, Caesar Wang <wxt@rock-chips.com> wrote:
>
> As the TRM says, the TSHUT default state is high active.
> In general, the TSHUT state can get from the dts. Otherwise
> it gets the state from this.
>
> Can you point at where the TRM says that the default state is high active?
>
> With the manual I have, I look at TSADC_AUTO_CON and I look at the
> description of "Bit 8".  It says that "tshut polarity" is 0 for low
> active and 1 for high active.  It then said that the Reset Value is 0.
>
> ...the "Reset Value" in tables like this is notoriously unreliable, so
> I can totally believe that it's wrong.  If you can point me at the
> part of the TRM that says that TSHUT is high active by default then I
> can confirm that for you.  ;)
>
>
> Okay, I know that's my wrong, the polarity is high or low can be selected.
> :-(
>
> I remember the veyron why is the default HiGH active, since the opt is
> connected to the PMIC.(we need think about the devices)
>
> Why is the evb board LOW active, since the opt didn't connected to the
> devices. TSHUT is depend on the CRU to work.

I think we can drop this patch then, right?  Any boards that need a
change from the default can just set "rockchip,hw-tshut-polarity",
right?

-Doug
