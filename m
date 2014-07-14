From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 14 Jul 2014 10:38:56 +0200
Subject: [PATCH 01/13] clk: tegra: Add binding for the Tegra124 DFLL
 clocksource
In-Reply-To: <53C01D17.2050906@nvidia.com>
References: <1405028569-14253-1-git-send-email-ttynkkynen@nvidia.com>
 <1405028569-14253-2-git-send-email-ttynkkynen@nvidia.com>
 <CAL1qeaFF0ZpUFovxTuLXrBPRg2Lbf-754Z=ztD5HFZPbfnDsAw@mail.gmail.com>
 <53C01558.3090607@nvidia.com>
 <CAL1qeaHETQ7kSGNjPiwi_9WNMtr9qZp0KwjZCCxY29+_N4AcuA@mail.gmail.com>
 <53C01D17.2050906@nvidia.com>
Message-ID: <20140714083854.GO2081@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 11, 2014 at 08:21:27PM +0300, Tuomas Tynkkynen wrote:
> 
> 
> On 11/07/14 20:08, Andrew Bresticker wrote:
> >On Fri, Jul 11, 2014 at 9:48 AM, Tuomas Tynkkynen <ttynkkynen@nvidia.com> wrote:
> >>
> >>
> >>On 11/07/14 19:28, Andrew Bresticker wrote:
> >>>
> >>>On Thu, Jul 10, 2014 at 2:42 PM, Tuomas Tynkkynen <ttynkkynen@nvidia.com>
> >>>wrote:
> >>>>
> >>>>The DFLL is the main clocksource for the fast CPU cluster on Tegra124
> >>>>and also provides automatic CPU rail voltage scaling as well. The DFLL
> >>>>is a separate IP block from the usual Tegra124 clock-and-reset
> >>>>controller, so it gets its own node in the device tree.
> >>>
> >>>
> >>>>diff --git
> >>>>a/Documentation/devicetree/bindings/clock/nvidia,tegra124-dfll.txt
> >>>>b/Documentation/devicetree/bindings/clock/nvidia,tegra124-dfll.txt
> >>>
> >>>
> >>>>+- nvidia,pmic-voltage-table: Array of 2-tuples.  Each entry should have
> >>>>the
> >>>>+  form <register-value voltage-in-uV>, indicating the register value
> >>>>that
> >>>>+  needs to be programmed to the PMIC for changing the VDD_CPU voltage to
> >>>>+  the specified voltage. The table must be in ascending order by the
> >>>>voltage.
> >>>
> >>>
> >>>Instead of listing the register values for each voltage in the DT,
> >>>can't you use regulator_list_voltage() to create this map?
> >>>
> >>
> >>I don't see a way to get the register values that way, unless we assume that
> >>the mapping is linear and doesn't have holes.
> >
> >Hmm... I guess if you don't assume it's linear and continuous you'd
> >have to iterate over all 256 selectors.
> >
> 
> I don't think we can assume that each selector maps to a concrete register
> value, though I'm not sure. include/linux/regulator/driver.h documents for
> @list_voltage "Selectors range from zero to one less
> regulator_desc.n_voltages." but maybe the consumer API could take different
> values.

I don't think the regulator API makes any guarantees that the selector
corresponds to a register value. Adding Mark Brown, maybe he can help
figure out the best way to do this.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140714/997fa9f6/attachment.sig>
