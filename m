From: dianders@chromium.org (Doug Anderson)
Date: Tue, 26 Apr 2016 13:53:58 -0700
Subject: [PATCH 4/4] ARM64: dts: rockchip: add dts file for RK3399
 evaluation board
In-Reply-To: <9945516.Q6LYCrkl5z@diego>
References: <1461638206-20473-1-git-send-email-jay.xu@rock-chips.com>
 <1461638206-20473-5-git-send-email-jay.xu@rock-chips.com>
 <9945516.Q6LYCrkl5z@diego>
Message-ID: <CAD=FV=Wgnz-vBo71f3mqFxcOpL7fJX58hXPJ+vk9uHpymqdN5Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Apr 26, 2016 at 5:37 AM, Heiko St?bner <heiko@sntech.de> wrote:
>> +     model = "Rockchip RK3399 Evaluation Board";
>> +     compatible = "rockchip,rk3399-evb", "rockchip,rk3399",
>> +                  "google,rk3399evb-rev2", google,rk3399evb-rev1",
>> +                  "google,rk3399evb-rev0" ;
>
> can you check against which compatibles that coreboot really matches?
>
> As we said that the evb changed between rev1 and rev2, I would expect the
> compatible to be something like
>
>         compatible = "rockchip,rk3399-evb",  "google,rk3399evb-rev2",
>                         "rockchip,rk3399";
>
> leaving out the rev1 and rev0

What Heiko suggests seems reasonable to me.

It all depends on what your bootloader is doing and what you guys want
to do.  Chrome OS designs that I've worked on have had board
strappings that you can read a board ID from and that's how the BIOS
(like coreboot) will figure out which board ID it is running on.  I'm
not aware of such strappings on rk3399-evb.  Do they exist?

Of course, even without strappings it's possible to get the bootloader
to work sanely.  You can either define the revision number at build
time or you can store the revision number somewhere non-volatile.


-Doug
