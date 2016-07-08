From: hzpeterchen@gmail.com (Peter Chen)
Date: Fri, 8 Jul 2016 10:39:13 +0800
Subject: [PATCH 1/6] binding-doc: power: pwrseq-generic: add binding doc
 for generic power sequence library
In-Reply-To: <577EEB63.3020007@gmail.com>
References: <1467882892-27589-1-git-send-email-peter.chen@nxp.com>
 <1467882892-27589-2-git-send-email-peter.chen@nxp.com>
 <1467884834.4236.36.camel@pengutronix.de>
 <577EEB63.3020007@gmail.com>
Message-ID: <20160708023913.GD27779@shlinux2>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 07, 2016 at 04:53:07PM -0700, Joshua Clayton wrote:
> 
> 
> On 07/07/2016 02:47 AM, Philipp Zabel wrote:
> > Am Donnerstag, den 07.07.2016, 17:14 +0800 schrieb Peter Chen:
> >> Add binding doc for generic power sequence library.
> >>
> >> Signed-off-by: Peter Chen <peter.chen@nxp.com>
> >> ---
> >>  .../bindings/power/pwrseq/pwrseq-generic.txt       | 56 ++++++++++++++++++++++
> >>  1 file changed, 56 insertions(+)
> >>  create mode 100644 Documentation/devicetree/bindings/power/pwrseq/pwrseq-generic.txt
> >>
> >> diff --git a/Documentation/devicetree/bindings/power/pwrseq/pwrseq-generic.txt b/Documentation/devicetree/bindings/power/pwrseq/pwrseq-generic.txt
> >> new file mode 100644
> >> index 0000000..4b23834
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/power/pwrseq/pwrseq-generic.txt
> >> @@ -0,0 +1,56 @@
> >> +The generic power sequence library
> >> +
> >> +Some hard-wired USB/MMC devices need to do power sequence to let the
> >> +device work normally, the typical power sequence like: enable USB
> >> +PHY clock, toggle reset pin, etc. But current Linux USB driver
> >> +lacks of such code to do it, it may cause some hard-wired USB devices
> >> +works abnormal or can't be recognized by controller at all. The
> >> +power sequence will be done before this device can be found at USB
> >> +bus.
> >> +
> >> +The power sequence properties is under the device node.
> >> +
> >> +Required properties:
> >> +- power-sequence: this device needs to do power sequence before enumeration
> >> +
> >> +Optional properties:
> >> +- clocks: the input clock for device.
> >> +- clock-name: must be "pwrseq-clk"
> > The "-clk" in the clock name is redundant.
> >
> >> +- pwrseq-reset-gpios: Should specify the GPIO for reset.
> >> +- pwrseq-reset-duration-us: the duration in microsecond for assert reset signal.
> > I understand you want to make it explicit that this GPIO is for the
> > pwrseq library, but are we really gaining anything over just calling
> > these reset-gpios and reset-duration-us?
> > The same applies to the clock name above.
> using  reset-gpios makes sense to  me too.
> The above "power-sequence" might then be better called "reset-on-init",
> But really, if a device has a reset gpio shouldn't the default behavior be to
> reset it on boot and when coming back from sleep?
> Is a special property even needed?

The power sequence does not include reset process only, it may include clock
and power as well.

-- 

Best Regards,
Peter Chen
