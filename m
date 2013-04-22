From: balbi@ti.com (Felipe Balbi)
Date: Mon, 22 Apr 2013 16:04:59 +0300
Subject: linux-next ARM multi-platform randconfig errors
In-Reply-To: <517530E5.5050901@ti.com>
References: <5170B4C6.1030300@gmail.com> <20130419161257.GI10155@atomide.com>
 <5174E58D.8080800@ti.com> <20130422082149.GK10536@arwen.pp.htv.fi>
 <20130422115243.GD10797@arwen.pp.htv.fi> <517530E5.5050901@ti.com>
Message-ID: <20130422130459.GI10797@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Apr 22, 2013 at 06:15:25PM +0530, Kishon Vijay Abraham I wrote:
> Hi,
> 
> On Monday 22 April 2013 05:22 PM, Felipe Balbi wrote:
> >Hi,
> >
> >On Mon, Apr 22, 2013 at 11:21:49AM +0300, Felipe Balbi wrote:
> >>>-Kevin Hilman <khilman@ti.com>
> >>>+Kevin Hilman <khilman@deeprootsystems.com>
> >>>
> >>>On 04/19/2013 07:12 PM, Tony Lindgren wrote:
> >>>>* Rob Herring <robherring2@gmail.com> [130418 20:11]:
> >>>>>Current errors in linux-next for ARM multi-platform randconfig builds.
> >>>>>
> >>>>>Rob
> >>>>>
> >>>>>arch/arm/mach-omap2/built-in.o:dss-common.c:(.init.text+0x6830): more undefined references to `usb_bind_phy' follow
> >>>>
> >>>>Felipe & Roger, can you guys take a look at the usb_bind_phy issue
> >>>>in linux next? I have not seen that in the multiplatform randconfigs
> >>>>I've built, but I have had some omap2+ specific things enabled there.
> >>>
> >>>These problems happen if USB_PHY is not enabled as a built-in driver.
> >>>I had pointed this out earlier [1] and Felipe should have a fix for it.
> >>
> >>yeah, ideally we wouldn't do any 'select' and just update defconfig with
> >>the necessary changes. We need the patch below to update defconfig and
> >>another patch to stub out usb_bind_phy when !USB_PHY.
> >
> >the stub is already there, this should fix the other part though:
> 
> Denis had sent a patch for it 4 days back [1]. Lets use that instead.

makes sense :-)

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130422/91bbce4c/attachment.sig>
