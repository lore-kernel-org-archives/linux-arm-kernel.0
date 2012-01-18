From: swarren@nvidia.com (Stephen Warren)
Date: Wed, 18 Jan 2012 11:52:27 -0800
Subject: Pinmux bindings proposal
In-Reply-To: <CAJuYYwSNuMAcjaTNeCq=LmeP8KrvGNjcn1FP6VY0NarEhkY_aA@mail.gmail.com>
References: <74CDBE0F657A3D45AFBB94109FB122FF17801D202F@HQMAIL01.nvidia.com>
 <CAJuYYwSNuMAcjaTNeCq=LmeP8KrvGNjcn1FP6VY0NarEhkY_aA@mail.gmail.com>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF1780DAAEB8@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thomas Abraham wrote at Wednesday, January 18, 2012 5:16 AM:
> On 14 January 2012 02:09, Stephen Warren <swarren@nvidia.com> wrote:
> > I thought a bit more about pinmux DT bindings. I came up with something
> > that I like well enough, and is pretty similar to the binding that Dong
> > posted recently. I think it'll work for both Tegra's and IMX's needs.
> > Please take a look!
...
> The pinmux_get() function checks if there is an active user of the
> pinmux and declines requests if the pinmux has been taken. With the dt
> bindings that you have listed, can such a check be still enforced.

I believe so.

I see these bindings as simply providing the data to populate the same
pinmux mapping table that's currently used by the pinctrl subsystem.
therefore, there are no changes to the operation of the pinctrl subsystem
(beyond a little extra code to parse the map from DT instead of receiving
a static table from a board file), and no changes to the way drivers
use the pinctrl APIs. Hence, all that error-checking will still operate
as-is.

> Also, will it be possible to support runtime pinmuxing with the above
> listed dt bindings?

Yes, the pinctrl/pinctrl-names properties allow defining a set of names
states, just like the mapping table does, and a driver can get one,
release it, then get a different named state, etc.

-- 
nvpublic
