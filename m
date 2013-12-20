From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 20 Dec 2013 10:47:03 +0100
Subject: pwm-backlight: 3.13-rc1 regression for old arm machine
In-Reply-To: <87iounuy6e.fsf@free.fr>
References: <87r49c6bea.fsf@free.fr> <20131217095658.GD13823@ulmo.nvidia.com>
 <87iounuy6e.fsf@free.fr>
Message-ID: <20131220094702.GD27787@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 17, 2013 at 07:31:21PM +0100, Robert Jarzmik wrote:
> Thierry Reding <thierry.reding@gmail.com> writes:
> 
> > I hadn't anticipated that =(. In fact I had been holding this patch back
> > for a release cycle because I was waiting for a specific regulator patch
> > to land which provides a dummy regulator if one wasn't specified. It
> > seems that that patch only works when booting from DT, though.
> >
> > The correct way to fix this would be to provide a lookup table with the
> > dummy regulator in the board file. I've attached a patch (compile-tested
> > only) that might work.
> >
> > If it does, please let me know and, if nobody else volunteers, I'll see
> > if I can come up with a set of patches to fix this for any other boards
> > that have the same issue.
> Actually, it needs a very small "tweak" to work :
> -	REGULATOR_SUPPLY("power", "pwm-backlight.0"),
> +	REGULATOR_SUPPLY("power", "pwm-backlight"),
> 
> Without it regulator_dev_lookup() won't match the device.
> 
> Moreover, it requires a config option, CONFIG_REGULATOR_FIXED_VOLTAGE=y. That's
> not a problem for my specific platform,

Okay. I'll submit a patch with that tweak of yours rolled in and Haojian
can merge that via the PXA tree.

> but I haven't seen *any* PXA platform
> with it activated, which means all defconfigs have to be patched, which is
> unfortunate.

Unfortunate indeed!

> As for my specific mioa701, your change with the tweak is perfectly fine and
> tested.

Great, I'll add your Tested-by.

Thanks,
Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131220/4349c1b7/attachment-0001.sig>
