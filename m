From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 29 Jun 2015 11:00:51 +0200
Subject: [PATCH v3] ARM: tegra: cpuidle: implement
 cpuidle_state.enter_freeze()
In-Reply-To: <CAAObsKCURyo-ujcA7r+UYqSw6ie-aBxKiYEdTKwe-HrL14RkBw@mail.gmail.com>
References: <1432046953-12945-1-git-send-email-tomeu.vizoso@collabora.com>
 <1773599.T1QStsTFTH@vostro.rjw.lan>
 <CAAObsKCURyo-ujcA7r+UYqSw6ie-aBxKiYEdTKwe-HrL14RkBw@mail.gmail.com>
Message-ID: <20150629090050.GD5431@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 18, 2015 at 09:09:29AM +0200, Tomeu Vizoso wrote:
> On 21 May 2015 at 03:02, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > On Tuesday, May 19, 2015 04:49:12 PM Tomeu Vizoso wrote:
> >> This callback is expected to do the same as enter() but it has to
> >> guarantee that interrupts aren't enabled at any point in its execution,
> >> as the tick is frozen.
> >>
> >> It will be called when the system goes to suspend-to-idle and will
> >> reduce power usage because CPUs won't be awaken for unnecessary IRQs.
> >>
> >> By setting the CPUIDLE_FLAG_TIMER_STOP flag, we can reuse the same code
> >> for both the enter() and enter_freeze() callbacks.
> >>
> >> Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
> >> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > Makes sense to me, but I suppose it should go in via arm-soc.
> 
> Hi Thierry,
> 
> what's the plan regarding merging of this patch?
> 
> It needs df8d9ee ("cpuidle: Run tick_broadcast_exit() with disabled
> interrupts") so it doesn't break boot.

By the looks of it the above patch was merged in 4.1, so I can easily
take this through the Tegra tree. The commit message doesn't say whether
or not this fixes a bug. Is this urgent? Should it go into 4.2? It
sounds more like it's a power-saving feature, so 4.3 is probably more
appropriate.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150629/fe9572c4/attachment.sig>
