From: balbi@ti.com (Felipe Balbi)
Date: Fri, 26 Dec 2014 09:26:20 -0600
Subject: [PATCH] arm: omap: reduce zImage size on omap2plus_defconfig
In-Reply-To: <549D5CC0.2090408@linaro.org>
References: <1419271535-4057-1-git-send-email-balbi@ti.com>
 <54991A25.2030804@compulab.co.il> <20141223161936.GA9147@saruman>
 <549AA94A.8030209@compulab.co.il> <20141224154948.GA423@saruman>
 <20141224190401.GN23854@atomide.com>
 <549BE333.9060709@compulab.co.il> <549D5CC0.2090408@linaro.org>
Message-ID: <20141226152620.GF17430@saruman>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Dec 26, 2014 at 03:04:00PM +0200, Grygorii.Strashko at linaro.org wrote:
> >>>
> >>> Tony, your call
> 
> May be it will be good thing to split this patch. That way more
> information will be stored in commit log about which set of options
> gives us what benefits.  And also, It will allow to continue with
> agreed changes.  ?

can be done, but then again, it's just a defconfig change. Tony, your
call.

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
> > Yes. That is exactly my point.
> > 
> 
> From my side I'd like to note that I know about few ongoing projects
> on DRA7x EVM where SATA is used as rootfs - now It is the fast
> possible way to start Android.

now this is something different. This is evidence that there are people
relying on SATA on rootfs. I'll leave to Tony again.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141226/42c8b39d/attachment.sig>
