From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 20 Sep 2013 09:58:20 +0200
Subject: [PATCH v4] PWM: PXA: add device tree support to PWM driver
In-Reply-To: <523B2C0B.4050204@newsguy.com>
References: <1379519982-7618-1-git-send-email-mikedunn@newsguy.com>
 <20130919122807.GH10852@ulmo> <523B2C0B.4050204@newsguy.com>
Message-ID: <20130920075819.GC8575@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 19, 2013 at 09:53:31AM -0700, Mike Dunn wrote:
> On 09/19/2013 05:28 AM, Thierry Reding wrote:
> > On Wed, Sep 18, 2013 at 08:59:42AM -0700, Mike Dunn wrote:
> > [...]
> >> Only an OF match table is added;
> > [...]
> > 
> > That's no longer true. You also add a custom .of_xlate() function.
> 
> 
> Is it acceptable to re-word the commit message in susbequent versions?

Yes, of course. The commit message should be an accurate description of
the patch. If as a result of review the patch changes in ways that make
the commit message wrong, then it must be updated as well.

> >> diff --git a/arch/arm/boot/dts/pxa27x.dtsi b/arch/arm/boot/dts/pxa27x.dtsi
> > 
> > I think this belongs in a separate patch so it can go through the
> > arm-soc tree.
> 
> 
> Is there anyone else or another list that should be CC'd in this case?  Thanks.

Well, the PXA maintainers would be the most likely to take the dtsi
change through their tree. Usually the mach trees are merged into
arm-soc, which then goes into Linus' tree.

> >> +{
> >> +	struct pwm_device *pwm;
> >> +
> > 
> > You probably want to check that pc->of_pwm_n_cells at least 1 here.
> 
> 
> Well OK, but I didn't bother because it's explicitly set to one elsewhere in
> this source file.

Okay, nevermind. It's probably fine as is.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130920/a168bd46/attachment.sig>
