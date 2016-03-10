From: thierry.reding@gmail.com (Thierry Reding)
Date: Thu, 10 Mar 2016 18:54:38 +0100
Subject: [PATCH v3 00/12] pwm: add support for atomic update
In-Reply-To: <CAD=FV=W3KPf8tyMviVNB9=HjefMdP+FBbN01Zhh7RKH+gkj2WQ@mail.gmail.com>
References: <20160203145337.GD9650@ulmo>
 <CAD=FV=U_x1cxx6RrHuVgVV8GbOwm9DXXJcyiArbbQySUOaxrvQ@mail.gmail.com>
 <20160222175929.GA23899@ulmo>
 <CAD=FV=UCErW3EjYRtwt49_ztNR7cyY4U0o4R_dxdomer-Ac2Dg@mail.gmail.com>
 <20160223143859.GA27656@ulmo>
 <CAD=FV=UvxG3MYD4MKQJqN7W68uMjd-s+FH-e8tkrLCpS0RLmZQ@mail.gmail.com>
 <20160223181448.GA14754@ulmo.nvidia.com>
 <CAD=FV=VM3cOQ0HqwLANBw9MVBCyFTrSyPe_dGzgPucuMUEWRKA@mail.gmail.com>
 <CAD=FV=VckTVD8b1g+f0G2kMeoTjvY0pAGhoDnWQN_dAmqSxBxg@mail.gmail.com>
 <CAD=FV=W3KPf8tyMviVNB9=HjefMdP+FBbN01Zhh7RKH+gkj2WQ@mail.gmail.com>
Message-ID: <20160310175438.GA5648@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 07, 2016 at 08:34:19AM -0800, Doug Anderson wrote:
> Thierry,
> 
> On Thu, Feb 25, 2016 at 3:14 PM, Doug Anderson <dianders@google.com> wrote:
> > So just to summarize:
> >
> > * Add pwm_get_state(), pwm_apply_state(), pwm_get_args().
> > pwm_get_state() initially returns 0 for duty cycle if driver doesn't
> > support readout.
> >
> > * Re-implement pwm_get_period() (and maybe other similar functions)
> > atop pwm_get_state() as you describe earlier in the thread.
> >
> > * Document pwm_get_period() (and maybe other similar functions) as deprecated.
> >
> > * Fix drivers for all current 2 users of PWM regulator to support
> > hardware readout.
> >
> > * Update PWM regulator as you described earlier in the thread (Feb 23).
> >
> > * If PWM regulator is ever used on a new board whose PWM doesn't
> > support hardware readout, the voltage will change at probe time.
> >
> >
> > Did I get all that right?  Thanks!
> 
> Can you provide a "yes, you got that right" or a "no, you didn't
> understand"?  That will unblock Boris, I think.

Sounds about right. Hopefully this will eliminate any objections that
others had about the series.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160310/bd595f8a/attachment.sig>
