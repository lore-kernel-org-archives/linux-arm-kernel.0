From: pawel.moll@arm.com (Pawel Moll)
Date: Wed, 07 May 2014 10:57:36 +0100
Subject: [PATCH 04/12] clocksource: Sched clock source for Versatile
 Express
In-Reply-To: <CACRpkdZ2Chwm0xu+bf8UAEi_5DR8WhMTv0gDJ6NC+6bQwHeB6Q@mail.gmail.com>
References: <1392138636-29240-1-git-send-email-pawel.moll@arm.com>
 <1392138636-29240-5-git-send-email-pawel.moll@arm.com>
 <CACRpkdZ2Chwm0xu+bf8UAEi_5DR8WhMTv0gDJ6NC+6bQwHeB6Q@mail.gmail.com>
Message-ID: <1399456656.3706.10.camel@hornet>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2014-05-02 at 23:14 +0100, Linus Walleij wrote:
> On Tue, Feb 11, 2014 at 9:10 AM, Pawel Moll <pawel.moll@arm.com> wrote:
> 
> > This patch adds a trival sched clock source using free
> > running, 24MHz clocked counter present in the ARM Ltd.
> > Versatile Express platform's System Registers block.
> >
> > This code replaces the call in the VE machine code.
> >
> > Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Signed-off-by: Pawel Moll <pawel.moll@arm.com>
> 
> Even the Integrator is very similar, albeit using register 0x28 instead
> of register 0x5c. cd commit
> a79528e9d849803457b6235ddb1a1cfd4e11c6cd
> 
> It's one of these things where writing a device driver results in
> more code than just registering this counter with the sched_clock
> guts :-/
> 
> Getting the clock from the DT gives this nice feeling of having it all
> complete, and sched_clock cannot really change frequency anyway
> so I'm happy with this thing.
> 
> I'll augment it for Integrator when/if I find time.

Can I consider this as Reviewed-by? :-)

Pawel
