From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Tue, 10 Jun 2014 22:03:59 +0200
Subject: exynos5420-peach-pi: linux-next boot fails unless mau_epll left
 enabled?
In-Reply-To: <CAD=FV=UsVQm_pLNtPwZMNCQQSSVrx=6M8eJrNRS8VyWMQzYtAQ@mail.gmail.com>
References: <7hoay6sxjl.fsf@paris.lan>	<CAGa+x86ko1N+T+QAqnY+md4+nyzza_cDt0wa-s06TdCX+27fSA@mail.gmail.com>	<CAOD6ATpZWEg9d7WnZ8tg9_uQJ29vMoucaOwh0_tbdRSDRj25cw@mail.gmail.com>
 <CAD=FV=UsVQm_pLNtPwZMNCQQSSVrx=6M8eJrNRS8VyWMQzYtAQ@mail.gmail.com>
Message-ID: <539764AF.4090409@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Doug,

On 06/10/2014 07:39 PM, Doug Anderson wrote:
> Hi,
> 
> On Mon, Jun 9, 2014 at 11:48 PM, Shaik Ameer Basha
> <shaik.samsung@gmail.com> wrote:
>> Hi Kevin,
>>
>> We tested on 3 "peach-pi" boards. We are not observing this issue.
>>
>> Even I tried with the below defconfig mentioned by you. No issues observed.
>> https://chromium.googlesource.com/chromiumos/overlays/chromiumos-overlay/+/master/eclass/cros-kernel/exynos5_defconfig
>>
>> This is the u-boot version currently we are using.
>> U-Boot 2013.04 (Feb 13 2014 - 16:35:03) for Peach
>>
>> Can you provide us more inputs like uboot version or any extra patches
>> you applied?
>> Also try removing all power domain nodes from exynos5420.dtsi and
>> check whether it is reproduced.
> 
> OK, we've narrowed it down so you can reproduce this and debug it...
> 
> To reproduce, simply run "sound init" at the U-Boot command prompt
> before booting the kernel.  ...or, alternatively, run "mw.l 03810000
> 1".
> 
> Can you please confirm and then send up some patches to fix this?
> 
> --
> 
> I'm still a little confused about how Javier didn't run into this.
> Both Kevin and Javier are (I think) chain-booting nv-U-Boot from a
> kernel partition.  It appears that chain-booting U-Boot somehow runs
> the sound init code (at least for me).
>

Yes, I did not have this issue before. However... I installed the latest Peach
pit recovery image you provided me and mainline kernel started to hang on boot.
I remembered this thread so tested Kevin's patch which make it boot again.

You said that chain-booting u-boot runs the sound init code but did you try
booting a signed FIT image using the verified u-boot?

I'm asking because I'm see the hang both when chain-booting nv-u-boot from a
kernel partition and booting a signed FIT image with the verified u-boot.

So it seems this is a regression in latest U-boot and I didn't run into this
before due having an older RW U-Boot on my Peach pit?

> -Doug
> 

Best regards,
Javier
