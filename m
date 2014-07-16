From: dianders@chromium.org (Doug Anderson)
Date: Wed, 16 Jul 2014 08:09:27 -0700
Subject: [PATCH 2/6] ARM: rockchip: add debug uart used by rk3288
In-Reply-To: <4054962.m70Hhy4CVc@diego>
References: <1471578.ILeMmG2DL6@diego> <2866950.oXmKFGy9mh@diego>
 <CAD=FV=W3aWeT3RP5_g9r8kV8ToeHfyn57JY-py2zGVW9DF_7RQ@mail.gmail.com>
 <4054962.m70Hhy4CVc@diego>
Message-ID: <CAD=FV=U9NviQ24CkbUCEMrWTLyXFb2FwT2wAHtKA7SF2PSFVdw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Heiko,

On Wed, Jul 16, 2014 at 2:11 AM, Heiko St?bner <heiko@sntech.de> wrote:
> Am Dienstag, 15. Juli 2014, 21:13:10 schrieb Doug Anderson:
>> Heiko,
>>
>> On Tue, Jul 15, 2014 at 4:00 PM, Heiko St?bner <heiko@sntech.de> wrote:
>> > The uarts on rk3288 are still compatible with the dw_8250, but located
>> > at a different position and need DEBUG_UART_8250_WORD enabled.
>> >
>> > Signed-off-by: Heiko Stuebner <heiko@sntech.de>
>> > ---
>> >
>> >  arch/arm/Kconfig.debug | 12 +++++++++++-
>> >  1 file changed, 11 insertions(+), 1 deletion(-)
>> >
>> > diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
>> > index 8f90595..f68def0 100644
>> > --- a/arch/arm/Kconfig.debug
>> > +++ b/arch/arm/Kconfig.debug
>> > @@ -613,6 +613,14 @@ choice
>> >
>> >                   Say Y here if you want kernel low-level debugging
>> >                   support
>> >                   on Rockchip based platforms.
>> >
>> > +       config DEBUG_RK32_UART2
>>
>> It's slightly confusing that you didn't rename the old "DEBUG_RK3X_UART2".
>
> My problem is, to what :-) ... DEBUG_RK30_UART2 ?
>
> RK30xx and RK31xx share these, but I guess at least the description should be
> adapted.

Yeah, trying to get these things right is an impossible task.  The
only thing I've ever seen that's sane is to just name things after the
first person in the code base to use them rather than trying to guess
ahead of time how similar products with similar marketing name will be
in the future.

...agree that even if you don't do the rename here that updating the
description would be nice.

-Doug
