From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 3 Sep 2012 13:34:31 +0100
Subject: [PATCH 3/3] i2c: nomadik: Add Device Tree support to the Nomadik
 I2C driver
In-Reply-To: <CACRpkdZ5VFhrbONy=0K5MFh4e6BDFckq0yqzjQ2QkW9MgwKqBg@mail.gmail.com>
References: <1345734087-21803-1-git-send-email-lee.jones@linaro.org>
 <1345734087-21803-3-git-send-email-lee.jones@linaro.org>
 <20120831112258.GA2624@pengutronix.de>
 <20120831122323.GC5962@gmail.com>
 <CACRpkdZ=C1EV4WO2b=1YLHPNhsDsQdq7Kfnpzm8i7uGRtVjJuQ@mail.gmail.com>
 <20120903094448.GB11780@pengutronix.de>
 <20120903100656.GC5782@gmail.com>
 <CACRpkdb8owKBxawAv4LVVYx5kUgZ9cUSiQ=BV0f3Pf3bHtknuQ@mail.gmail.com>
 <CAF2Aj3j25w1Nn9O6hV+=i-j1ts_p_Ucswk_M7r04S7i5BzPkHg@mail.gmail.com>
 <CACRpkdZ5VFhrbONy=0K5MFh4e6BDFckq0yqzjQ2QkW9MgwKqBg@mail.gmail.com>
Message-ID: <20120903123424.GA31163@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 03, 2012 at 01:58:04PM +0200, Linus Walleij wrote:
> On Mon, Sep 3, 2012 at 1:32 PM, Lee Jones <lee.jones@linaro.org> wrote:
> 
> > No, this is wrong. Platform data should not override DT.
> >
> > If DT is enabled and passed, it should have highest priority.
> 
> Oh is that so.

:)

> Rob: do we have a clear consensus on this? Then we should document
> it in Documentation/devicetree/usage-model.txt.
> 
> (That document isn't part of the binding I believe, so we could define
> Linux-specific behaviours in it.)
> 
> I always thought it was the other way around, that pdata took priority.
> 
> Usecase: hardcoded bootloader passer erroneous DT to a platform.
> No way out. What to do? Override with pdata.
> 
> Yours,
> Linus Walleij

Hmmm... I see your point, but this won't work.

When booting DT booting take a different path and no platform data
is passed. We can't boot DT AND register devices with platform data
or else we will double probe every device. The only way to pass
pdata when booting with DT is with AUX_DATA() and that's a hack to
get around things we don't have support for yet. Up until now that
has been DMA bindings, clock and pinctrl names and call-backs.

If DT is corrupt or missing the kernel will boot using platform 
data, but np will always be NULL, so we don't have the problem you
were alluding to above.

Let me know if I didn't explain that well enough and I will have
another go.

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
