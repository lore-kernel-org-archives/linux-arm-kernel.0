From: jason@lakedaemon.net (Jason Cooper)
Date: Mon, 18 Mar 2013 07:17:12 -0400
Subject: Kirkwood NSA 310 does not boot with 3.8.3
In-Reply-To: <loom.20130318T094229-725@post.gmane.org>
References: <loom.20130316T213930-150@post.gmane.org>
 <20130316215530.GZ12700@titan.lakedaemon.net>
 <loom.20130318T094229-725@post.gmane.org>
Message-ID: <20130318111712.GH13280@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 18, 2013 at 09:16:34AM +0000, Lukas Zapletal wrote:
> Jason Cooper <jason <at> lakedaemon.net> writes:
> > You'll need to enable ARM_APPENDED_DTB, concatenate your dtb onto your
> > zImage, then run mkimage on the result to get the uImage.
> 
> Jason, thanks for help. It worked great, just for completenes for googlers:
> 
> # grep "ARM_APPENDED_DTB|NSA" .config
> CONFIG_ARM_APPENDED_DTB=y
> CONFIG_MACH_NSA310_DT=y
> 
> # make zImage
> 
> # make dtbs
> 
> # cat arch/arm/boot/zImage arch/arm/boot/dts/kirkwood-nsa310.dtb > /tmp/X
> # mv /tmp/X arch/arm/boot/zImage


> # make uImage

Be careful using this in the future when we go multiplatform, it's not
supported (which Load Address and Entry Point?).  You'll need to use the
mkimage command by hand then.

thx,

Jason.
