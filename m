From: anilkumar@ti.com (AnilKumar, Chimata)
Date: Mon, 19 Nov 2012 04:14:52 +0000
Subject: [PATCH v2 4/4] ARM: dts: AM33XX: Enable system power off
 control in am335x-bone
In-Reply-To: <87r4ntcqk3.fsf@deeprootsystems.com>
References: <1353067706-29491-1-git-send-email-anilkumar@ti.com>
 <1353067706-29491-5-git-send-email-anilkumar@ti.com>
 <87r4ntcqk3.fsf@deeprootsystems.com>
Message-ID: <331ABD5ECB02734CA317220B2BBEABC13EA75BDF@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 17, 2012 at 00:40:04, Kevin Hilman wrote:
> AnilKumar Ch <anilkumar@ti.com> writes:
> 
> > Enable system power off control for BeagleBone in am335x-bone.dts file
> > under rtc node. RTC is the incharge of controlling the system power.
> > This flag is used by the driver to hook up the pm_power_off system call.
> >
> > Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
> > ---
> >  arch/arm/boot/dts/am335x-bone.dts |    4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/arch/arm/boot/dts/am335x-bone.dts b/arch/arm/boot/dts/am335x-bone.dts
> > index 1d55190..206c3eb 100644
> > --- a/arch/arm/boot/dts/am335x-bone.dts
> > +++ b/arch/arm/boot/dts/am335x-bone.dts
> > @@ -52,6 +52,10 @@
> >  			};
> >  
> >  		};
> > +
> > +		rtc at 44e3e000 {
> > +			ti,system-power-controller;
> > +		};
> >  	};
> 
> Also, I think this series is missing a patch that allows the RTC driver
> to be compiled on AM335x.
> 

Hi Kevin,

Yes I missed; I will submit that as a separate patch.

Thanks
AnilKumar
