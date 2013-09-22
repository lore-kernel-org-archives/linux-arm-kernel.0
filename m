From: linux.melwyn@gmail.com (melwyn lobo)
Date: Sun, 22 Sep 2013 19:07:24 +0900
Subject: Vexpress config
In-Reply-To: <1379601512.3347.26.camel@hornet>
References: <CAHSGOuusvazUFFAAraCZmQgXr8LvwdV4zess=KsEMsCtbg0y2A@mail.gmail.com>
 <CAHSGOus7VsJh+-mpxOWeeyqfsB4jNYiG-vwRirFaJh39c3Heww@mail.gmail.com>
 <1379323515.3998.12.camel@hornet>
 <CAHSGOusEZtdVwnKo7fxLKQKnVVde1FRHtruRYG9BkBpNB6r3ag@mail.gmail.com>
 <1379601512.3347.26.camel@hornet>
Message-ID: <CAHSGOuuLx6Cfuq5otV+Jd1ZvdJ-Hg-an_3A2XXNik-AUsw+QVw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 19, 2013 at 11:38 PM, Pawel Moll <pawel.moll@arm.com> wrote:

> You won't find any extra patches. The addresses you see in
> arch/arm/mach-vexpress are not used for anything else but the V2P-CA9.
> All new core tiles (I'm talking real hardware here, an I can assure you
> it works) are defined in relevant device trees. You'll find a collection
> of those for *hardware* platforms in the kernel as well, look at
> arch/arm/boot/dts/vexpress*
>
> If you want to boot RTSM_VE_Cortex-A15x4, you should be able to simply
> use the boot wrapper I've mentioned without any change. The extra
> patches are required only for A5 & A9 models. All you need is to get
> yourself a correct DTB:
>
> http://linux-arm.org/git?p=arm-dts.git;a=blob_plain;f=fast_models/rtsm_ve-cortex_a15x4.dts
>
> compile it:
>
> dtc -I dts -O dtb rtsm_ve-cortex_a15x4.dts -o rtsm_ve-cortex_a15x4.dtb
>
> and pass it to the boot wrapper, following its README file.
>
> Pawe?
>
>

Thanks !!!! The CA15x14 fast model works. I can finally get some
kernel prints. There are however two things which fail and I need
clarified:
1. ARM pl11x CLCD driver fails (only clcd, whereas other peripherals
initialization is OK) :

clcd-pl11x: probe of 1c1f0000.clcd failed with error -22

On running prebuilt images from linaro releases site, they work just
fine on CA15x4 with four clean TUX logos on the simulated CLCD screen.

2. I don't have an initrd which boot till shell prompt. It could just
be a problem with my image but I would really like to have a clean
working initrd to start with. (Don't want to use Linaro's becuase they
boot till Android home screen)

Really will appreciate any inputs.

Thanks,
M.
