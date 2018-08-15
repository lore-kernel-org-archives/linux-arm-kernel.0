From: robh@kernel.org (Rob Herring)
Date: Wed, 15 Aug 2018 08:45:36 -0600
Subject: [RFC PATCH 0/7] add at91sam9 LCDC DRM driver
In-Reply-To: <20180815044808.GA1806@ravnborg.org>
References: <20180812184152.GA22343@ravnborg.org>
 <f1f2a2d7-ae27-87af-8041-93d3f8fe07cc@microchip.com>
 <20180813181808.GA2357@ravnborg.org> <20180813220454.GA28913@rob-hp-laptop>
 <20180814164343.GA13848@ravnborg.org> <20180814224252.GA20667@rob-hp-laptop>
 <20180815044808.GA1806@ravnborg.org>
Message-ID: <CAL_JsqLwazj=7hOwSeAtcyvnYCmMDP-Nw3H8xHSr0n3YGUS21A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 14, 2018 at 10:48 PM Sam Ravnborg <sam@ravnborg.org> wrote:
>

[...]

> > > One DT related Q:
> > > The LCD Controller supports BGR565, but as this is less common some HW implmentations
> > > exchange R and B, expessed in the old binding as wiring-mode like this:
> > >
> > >     atmel,lcd-wiring-mode: lcd wiring mode "RGB" or "BRG"
> > >
> > > How can we express this wiring-mode in a generic way, both in DT and in code?
> > > Is it something that in DRM belongs to the panel, the encoder, the connector, or?
> > > And can any of the exisitng flags be used?
> >
> > I thought we had come up with a common definition, but I guess it didn't
> > make it upstream. It's definitely needed and I've been rejecting
> > anything new that's vendor specific.
> I found this: https://patchwork.ozlabs.org/patch/659570/
> The suggestion with a boolean seems simple and I will try that.

That's really too simple to be common. There's been a few other
attempts[1][2][3] (for Atmel HLCDC in fact) with [3] probably being
the closest to merging. The binding looked fine to me, but looks like
the DRM implementation had some issues.

Rob

[1] https://lists.freedesktop.org/archives/dri-devel/2018-April/173089.html
[2] https://patchwork.kernel.org/patch/9965079/
[3] http://lists.infradead.org/pipermail/linux-arm-kernel/2018-March/568731.html
