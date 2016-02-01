From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Mon, 01 Feb 2016 22:17:22 +0100
Subject: [PATCH] PM / AVS: rockchip-io: add GRF and PMUGRF types to
 distinguish
In-Reply-To: <56AF1D4E.40307@rock-chips.com>
References: <1454155305-55516-1-git-send-email-david.wu@rock-chips.com>
 <5387650.lAgTxexlF2@phil> <56AF1D4E.40307@rock-chips.com>
Message-ID: <5354361.hQXgJ7cEGx@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi David,

Am Montag, 1. Februar 2016, 16:54:38 schrieb David.Wu:
> ? 2016/1/30 20:39, Heiko Stuebner ??:
> > Am Samstag, 30. Januar 2016, 20:01:45 schrieb David Wu:
> >> As rk3368 contained two separated iodomain areas, this was
> >> determined to use which regmap base address.
> >> 
> >> Signed-off-by: David Wu <david.wu@rock-chips.com>
> > 
> > I don't think we need to specify this on a driver level. Both GRF areas
> > are
> > "General register files" only located in two separate power-domains.
> > So the rockchip,grf property should work for both. Especially as nothing
> > keeps designers from introducing yet another GRF-area somewhere else ;-)
> > 
> > >From when I started working on the rk3368, I still have a preliminary
> > 
> > patches for that sitting here, so I've attached on how I envisoned that to
> > work.
> 
> Okay, i agree to you, but it make someone a little confused just from
> the drive code,
> not DT file,  about  pmugrf regmap base address.:-)
> 
> How do you feel about intergating GRF and PMU drivers in one driver?
> Thanks!

I will very strongly disagree here ;-) .
Similar to the power-domains being part of the pmu, the io-domains are
part of their individual GRFs. So if you want it really clean and tidy the way 
to go foward will be the attached patches. Compile-tested only.

Other things like the usbphy control should move there as well in the long 
run. But that's not immediate necessary.


Heiko
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-PM-AVS-rockchip-io-make-io-domains-a-child-of-the-GR.patch
Type: text/x-patch
Size: 2790 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160201/56da602b/attachment-0003.bin>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0003-arm64-dts-rockchip-add-rk3368-iodomains.patch
Type: text/x-patch
Size: 1174 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160201/56da602b/attachment-0004.bin>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0002-arm64-dts-rockchip-make-grf-syscons-simple-mfds.patch
Type: text/x-patch
Size: 1316 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160201/56da602b/attachment-0005.bin>
