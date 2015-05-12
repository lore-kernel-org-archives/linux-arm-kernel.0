From: mike.turquette@linaro.org (Michael Turquette)
Date: Tue, 12 May 2015 12:01:34 -0700
Subject: [PATCH V4 1/3] OPP: Redefine bindings to overcome shortcomings
In-Reply-To: <20150512052033.GC32300@linux>
References: <20150505105714.GA22845@sirena.org.uk>
 <20150505171252.GI22845@sirena.org.uk>
 <CAKohpo=kJs076afzERPMqjELgwpN6nR2yoyEjW6XY7YSEbRuCA@mail.gmail.com>
 <20150507055231.GB32399@codeaurora.org>
 <20150507110233.GR15510@sirena.org.uk> <20150507211855.GA2455@codeaurora.org>
 <20150507221842.GW22845@sirena.org.uk>
 <CAKohpomU8wm0T=A7EkosdOjXbP8q2Cb726Hsjh08KTKYjoz3-A@mail.gmail.com>
 <555000B6.2010107@ti.com> <20150512052033.GC32300@linux>
Message-ID: <20150512190134.16410.89041@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Viresh Kumar (2015-05-11 22:20:33)
> On 10-05-15, 20:07, Nishanth Menon wrote:
> > just one minor concern being in the SoC end of the world :). In most
> > times, the current consumption for a specific OPP varies depending on
> > the specific location in the process node the die is -> this is even
> > true among a single lot of wafers as well. some SoC vendors use hot,
> > nominal and cold terminology to indicate the characteristics of the
> > specific sample.
> > 
> > it might help state which sample end of the spectrum we are talking
> > about here. reason being: if I put in values based on my board
> > measurement, the results may not be similar to what someone else's
> > sample be. Depending on technology, speed binning strategy used by the
> > vendor, temperature and few other characteristics, these numbers could
> > be widely divergent.
> 
> I don't have any clue about this.. :(
> 
> @Mark/stephen: Any inputs ?

Nishanth,

I do not think the idea of the mA property is to perfectly model current
consumption at a given opp. Instead it is a nominal value that may be
useful, e.g. for configuring a regulator in Stephen's case.

The TWLxxxx series of PMICs from TI have configurable SMPS which could
possibly benefit from this info as well. Most of the time those are left
in an "automatic mode", but there are manual programming steps to
achieve higher efficiencies and this property could potentially help you
do that.

Regards,
Mike
