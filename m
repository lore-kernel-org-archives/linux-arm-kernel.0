From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Wed, 25 Mar 2015 15:07:25 +0100
Subject: [PATCH v4 2/4] mfd: lubbock_cplds: add lubbock IO board
In-Reply-To: <87a9088tam.fsf@free.fr>
References: <20150216130549.GF14545@x1>
 <1170550770.470129293.1424093248596.JavaMail.root@zimbra1-e1.priv.proxad.net>
 <20150216162712.GR14545@x1> <87fva5a4i2.fsf@free.fr>
 <20150217074310.GT14545@x1>
 <alpine.LFD.2.11.1502171221300.22104@knanqh.ubzr>
 <20150218080719.GB5781@x1> <87a9088tam.fsf@free.fr>
Message-ID: <20150325140725.GA11499@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 20, 2015 at 05:02:57PM +0100, Robert Jarzmik wrote:
> Lee Jones <lee.jones@linaro.org> writes:
> >> > Arnd, Greg,
> >> > 
> >> >   Perhaps you have some ideas WRT programmables (PLDs/CPLDs/FPGAs)?
> 
> Hi Arnd and Greg,
> 
> I have this driver I'm upstreaming, which comes out of
> arch/arm/mach-pxa/lubbock.c. As for the reason it is extracted, see submitted
> commit [1] for reference.
> 
> The main question is : where does it belong in the kernel ?
> 
> The driver is :
>  - for the CPLDs on the Lubbock development platform, which is more or less an
>    old motherboard for Intel Xscale pxa255 SoC (see [2] for more details)
>  - these CPLDs control :
>    - interrupt muxing towards the SoC
>    - several leds
>    - switches read back
>    For the whole patch, see [4]
> 
> Lee's position is that it doesn't belong to drivers/mfd, see [3].
> 
> So where should I submit it ? And more generally, where should CPLDs drivers be
> pushed in the kernel tree ?
> 
> If there is no solution, I'll fallback through arch/arm/plat-pxa, not very nice,
> but it has to land somewhere, I don't want lubbock to remain broken.

drivers/platform/arm ?
