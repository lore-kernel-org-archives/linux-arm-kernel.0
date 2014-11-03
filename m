From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 3 Nov 2014 15:40:21 +0100
Subject: [PATCH RFC v2 8/8] ARM: zynq: DT: Add pinctrl information
In-Reply-To: <f2781e379e3348e39d30cb77b0dbca40@BN1AFFO11FD042.protection.gbl>
References: <1413479495-14206-1-git-send-email-soren.brinkmann@xilinx.com>
 <1413479495-14206-9-git-send-email-soren.brinkmann@xilinx.com>
 <CACRpkda9v=H9rQBq484c+UCwEKeca9qOE_78Wf+STB4rDwhuyA@mail.gmail.com>
 <5cf5e2e5cd154992b2896b98988a409a@BN1BFFO11FD007.protection.gbl>
 <CACRpkdZjJQTxVhvq5BT3mHBDHge_wHBNi9N_6u0WVbPB3wBDKw@mail.gmail.com>
 <030ed753d9764825b1bd5c845b360c7d@BN1AFFO11FD036.protection.gbl>
 <CACRpkdb9Gg90GwTpUm7S6SFkFjKTRaZLWa2JLnXJK4H-ZMbQ6A@mail.gmail.com>
 <4a2cb923ab264d7d99107a450d6ddcba@BN1BFFO11FD057.protection.gbl>
 <f2781e379e3348e39d30cb77b0dbca40@BN1AFFO11FD042.protection.gbl>
Message-ID: <CACRpkdZD+wqfxLxMJ+WGvAmaV+XL6bCcLFGD4BuB-0KXum+D_w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Nov 2, 2014 at 9:20 PM, S?ren Brinkmann
<soren.brinkmann@xilinx.com> wrote:
(...)
>                 common {
>                         groups = "uart1_10_grp";
>                         function = "uart1";
>                         bias-pull-up = <0>;
>                         slew-rate = <0>;
>                         io-standard = <1>;
>                 };
>
>                 rx {
>                         pins = "MIO49";
>                         bias-high-impedance = <1>;
>                 };
>
>                 tx {
>                         pins = "MIO48";
>                         bias-high-impedance = <0>;
>                 };
(...)
>                 common {
>                         groups = "uart1_10_grp";
>                         function = "uart1";
>                 };
>
>                 rx {
>                         pins = "MIO49";
>                         slew-rate = <0>;
>                         io-standard = <1>;
>                         bias-high-impedance;
>                 };
>
>                 tx {
>                         pins = "MIO48";
>                         slew-rate = <0>;
>                         io-standard = <1>;
>                 };
>         };
>
> In a nutshell, yes, it's possible to work without the arguments for
> pull-up or tri-state. But it adds complexity in the driver and the DT
> description.

But isn't it obvious that the latter is easier for a human to read
and understand (and not misunderstand) and remember readability
of config is one of the design goals of DT...

Yours,
Linus Walleij
