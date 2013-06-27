From: baruch@tkos.co.il (Baruch Siach)
Date: Thu, 27 Jun 2013 12:46:49 +0300
Subject: [PATCH 2/8] clocksource: sun4i: Add clocksource and sched clock
 drivers
In-Reply-To: <20130627093558.GB8437@lukather>
References: <1372281421-2099-1-git-send-email-maxime.ripard@free-electrons.com>
 <1372281421-2099-3-git-send-email-maxime.ripard@free-electrons.com>
 <20130627060234.GD4824@tarshish> <20130627093558.GB8437@lukather>
Message-ID: <20130627094649.GM4824@tarshish>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxime,

On Thu, Jun 27, 2013 at 11:35:58AM +0200, Maxime Ripard wrote:
> On Thu, Jun 27, 2013 at 09:02:34AM +0300, Baruch Siach wrote:
> > On Wed, Jun 26, 2013 at 11:16:55PM +0200, Maxime Ripard wrote:
> > > +static u32 sun4i_timer_sched_read(void)
> > 
> > You commit message mentions "64 bits free running counter", but this one only 
> > returns 32 bit.
> 
> Yeah, the callback setup by setup_sched_clock is supposed to be
> returning a u32, and clocksource_mmio_init only accepts up to 32 bits as
> well, so I'm only using the lower 32bits of this 64 bits counter.
> 
> I'll amend the commit log to state this.

But using 64 bit counter for sched_clock is much easier that using 32 bit one. 
You can either wait for the rest of Stephen's patch set 
(http://thread.gmane.org/gmane.linux.ports.arm.msm/4092) before adding 64 bit, 
or you can just make the trivial change to the now generic sched_clock code.

baruch

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
