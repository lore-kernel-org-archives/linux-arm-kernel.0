From: broonie@kernel.org (Mark Brown)
Date: Thu, 18 Dec 2014 14:22:05 +0000
Subject: [PATCH 4/5] cpufreq: imx6q: add ldo-bypass support
In-Reply-To: <CAJ+vNU3PQYCE4tABUiqU+vGkGqBEqdVKz25W88-ByOQZxunVLw@mail.gmail.com>
References: <1414729631-11005-1-git-send-email-tharvey@gateworks.com>
 <1414729631-11005-5-git-send-email-tharvey@gateworks.com>
 <CAOMZO5DzEe91pTv+UkCbj0DzgVDOb9hjuakt9NmpTJnEk-j8UA@mail.gmail.com>
 <CAJ+vNU3PQYCE4tABUiqU+vGkGqBEqdVKz25W88-ByOQZxunVLw@mail.gmail.com>
Message-ID: <20141218142205.GZ11764@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 18, 2014 at 06:11:15AM -0800, Tim Harvey wrote:
> On Wed, Dec 17, 2014 at 6:36 AM, Fabio Estevam <festevam@gmail.com> wrote:
> > On Fri, Oct 31, 2014 at 2:27 AM, Tim Harvey <tharvey@gateworks.com> wrote:
> >> When an external PMIC is used for VDD_SOC and VDD_ARM you can save power by
> >> bypassing the internal LDO's provided by the anantop regulator as long as
> >> you are running less than 1.2GHz. If running at 1.2GHz the IMX6 datasheets
> >> state that you must use the internal LDO's to reduce ripple on the suplies.
> >>
> >> A failure to bypass the LDO's when using an external PMIC will result in an
> >> extra voltage drop (~125mV) between VDD_ARM_IN and VDD_ARM and VDD_SOC_IN and
> >> VDD_SOC which violates the voltages specificed by the datasheets.

This description doesn't make much sense - there must of course always
be an external power source for the SoC and the discussion of bypassing
also suggests that it's not just a case of disconnecting the internal
LDOs.

> What is needed is to determine if the cpu vddsoc and vddarm regulators
> are both 'not' the same as the anatop provided regulators (then we
> bypass the anatop regulators) so I need to do such a check after all
> regulators are registered. Perhaps I need to have a late_init call (or
> some other init call that happens after all regulators are
> registered).

> Phillipp/Mark - what are your thoughts here? Do the regulator core
> functions regulator_is_same() [1] and regulator_is_bypass() [2] I
> propose make sense to determine if regulators are the same and in
> bypass mode and overcome the detection issues Phillipp discussed in a
> previous thread [3]?

Please provide a clear description of what's actually going on here.
What does the hardware actually look like and what is being configured?
You're telling me the solution you've decided on, not what the problem
that this is supposed to solve is.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141218/2741c50e/attachment.sig>
