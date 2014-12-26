From: balbi@ti.com (Felipe Balbi)
Date: Fri, 26 Dec 2014 09:24:38 -0600
Subject: [PATCH] arm: omap: reduce zImage size on omap2plus_defconfig
In-Reply-To: <549D4FAA.1040207@compulab.co.il>
References: <1419271535-4057-1-git-send-email-balbi@ti.com>
 <54991A25.2030804@compulab.co.il> <20141223161936.GA9147@saruman>
 <549AA94A.8030209@compulab.co.il> <20141224154948.GA423@saruman>
 <20141224190401.GN23854@atomide.com>
 <20141226043719.GA7661@saruman> <549D4FAA.1040207@compulab.co.il>
Message-ID: <20141226152438.GE17430@saruman>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Dec 26, 2014 at 02:08:10PM +0200, Igor Grinberg wrote:
> >> I think we should move omap2plus_defconfig to be mostly modular and
> >> usable for distros as a base. Most distros prefer to build almost
> >> everything as loadable modules. And my preference is that we should
> >> only keep the minimum rootfs for devices and serial support as
> >> built-in and rely on initramfs for most drivers. And slowly move
> >> also the remaining built-in drivers to be loadable modules.
> >>
> >> The reasons for having drivers as loadable modules are many. It
> >> allows distros to use the same kernel for all the devices without
> >> bloating the kernel. It makes developing drivers easier as just the
> >> module needs to be reloaded. And loadable modules protect us from
> >> cross-framework spaghetti calls in the kernel as the interfaces are 
> >> clearly defined.
> >>
> >> Are there people really using SATA as rootfs right now on omaps?
> > 
> > not that we know :-) The only platforms available today with SATA are
> > OMAP5432 uEVM and DRA7x EVM,
> 
> I'm sorry... that is not true.

That's not what you have said thus far. So far you only said it *can*
have, you have not explicitly said a customer really *is* using rootfs
on SATA.

Personally, I really don't care. It's just a defconfig patch and
kernel configuration is very, very easy to change at any time. You can
even have an out of tree config fragment just turning SATA=y again.

Have a look at scripts/kconfig/merge_config.sh

> > the latter being mostly used by TIers as of
> > now (at least from mainline point of view).
> 
> the keyword is mostly... And I'm also not sure this is true these days...
> 
> But, really, don't mind me. We will find our solutions (we always did).
> I mean, Felipe wants it out so badly...
> Who am I to say anything...

cute :-)

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141226/cc1531f5/attachment-0001.sig>
