From: thierry.reding@gmail.com (Thierry Reding)
Date: Thu, 28 Aug 2014 15:10:18 +0200
Subject: [PATCH V2 1/2] ARM: dts: Add DT changes for display on snow
In-Reply-To: <CAEC9eQN+EJmrG70O+2Sg5GD0OHudhqo5beGDN8K4_kmOKKPOmw@mail.gmail.com>
References: <1409150908-12801-1-git-send-email-ajaykumar.rs@samsung.com>
 <20140827150146.GB9737@leverpostej>
 <CAEC9eQMKfso-rmMdqyDZeCdaxf21O1fqN6Z2YrS=njqGHh5d5Q@mail.gmail.com>
 <20140828091509.GA14650@leverpostej>
 <CAEC9eQN+EJmrG70O+2Sg5GD0OHudhqo5beGDN8K4_kmOKKPOmw@mail.gmail.com>
Message-ID: <20140828131017.GD14388@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 28, 2014 at 03:04:32PM +0530, Ajay kumar wrote:
> On Thu, Aug 28, 2014 at 2:45 PM, Mark Rutland <mark.rutland@arm.com> wrote:
> > On Thu, Aug 28, 2014 at 06:34:33AM +0100, Ajay kumar wrote:
> >> On Wed, Aug 27, 2014 at 8:31 PM, Mark Rutland <mark.rutland@arm.com> wrote:
> >> > On Wed, Aug 27, 2014 at 03:48:27PM +0100, Ajay Kumar wrote:
> >> >> Add DT nodes for ptn3460 bridge chip and panel.
> >> >> Add backlight enable pin and backlight power supply for pwm-backlight.
> >> >> Also add bridge phandle needed by dp to enable display on snow.
> >> >>
> >> >> Note that, snow doesn't support "chunghwa,claa101wb01" panel,
> >> >> but still we choose to reuse the binding since "chunghwa,claa101wb01"
> >> >> has similar LCD timings.
> >> >
> >> > What does it actually have?
> >> >
> >> > It's fine to have "chunghwa,claa101wb01" as a fallback but we should
> >> > have an identifier for the actual display, too.
> >> Actual display used is "AUO,B116XTN0", for which no data currently exists
> >> in panel file. Instead of adding a new panel_desc for B116XTN0,
> >> why not we reuse existing ones? what is the "identifier" you are talking about?
> >
> > The compatible string.
> >
> > So in the dts we'd have compatible = "au0,b116xtn0", "chunghwa,claa101wb01";
> Sorry, hardware engineer says actual LCD name is "auo,b116xw03".
> 
> > That way if we need specific data we can add it later.
> I think we can add a new panel_desc for "auo,b116xw03".
> Because its actual LCD dimension is 256x144, but "chungwa, claa101wb01" has
> LCD dimension 223x125.
> What is Thierry's opinion on adding this new LCD?

I think you should simply add a new panel_desc for the panel. It may use
similar timings, but it's likely not "compatible" in the way required by
device tree. As you say, dimensions are different and those may have an
influence on the DPI setting. There's really no reason why this should
share the panel_desc with another panel.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140828/45546ce0/attachment-0001.sig>
