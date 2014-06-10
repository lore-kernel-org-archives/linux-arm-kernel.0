From: dianders@google.com (Doug Anderson)
Date: Tue, 10 Jun 2014 10:39:32 -0700
Subject: exynos5420-peach-pi: linux-next boot fails unless mau_epll left
 enabled?
In-Reply-To: <CAOD6ATpZWEg9d7WnZ8tg9_uQJ29vMoucaOwh0_tbdRSDRj25cw@mail.gmail.com>
References: <7hoay6sxjl.fsf@paris.lan>
 <CAGa+x86ko1N+T+QAqnY+md4+nyzza_cDt0wa-s06TdCX+27fSA@mail.gmail.com>
 <CAOD6ATpZWEg9d7WnZ8tg9_uQJ29vMoucaOwh0_tbdRSDRj25cw@mail.gmail.com>
Message-ID: <CAD=FV=UsVQm_pLNtPwZMNCQQSSVrx=6M8eJrNRS8VyWMQzYtAQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Jun 9, 2014 at 11:48 PM, Shaik Ameer Basha
<shaik.samsung@gmail.com> wrote:
> Hi Kevin,
>
> We tested on 3 "peach-pi" boards. We are not observing this issue.
>
> Even I tried with the below defconfig mentioned by you. No issues observed.
> https://chromium.googlesource.com/chromiumos/overlays/chromiumos-overlay/+/master/eclass/cros-kernel/exynos5_defconfig
>
> This is the u-boot version currently we are using.
> U-Boot 2013.04 (Feb 13 2014 - 16:35:03) for Peach
>
> Can you provide us more inputs like uboot version or any extra patches
> you applied?
> Also try removing all power domain nodes from exynos5420.dtsi and
> check whether it is reproduced.

OK, we've narrowed it down so you can reproduce this and debug it...

To reproduce, simply run "sound init" at the U-Boot command prompt
before booting the kernel.  ...or, alternatively, run "mw.l 03810000
1".

Can you please confirm and then send up some patches to fix this?

--

I'm still a little confused about how Javier didn't run into this.
Both Kevin and Javier are (I think) chain-booting nv-U-Boot from a
kernel partition.  It appears that chain-booting U-Boot somehow runs
the sound init code (at least for me).

-Doug
