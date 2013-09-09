From: magnus.damm@gmail.com (Magnus Damm)
Date: Mon, 9 Sep 2013 16:24:56 +0900
Subject: [PATCH 02/04] ARM: shmobile: r8a7791 SCIF support
In-Reply-To: <CACRpkdY=j_XRPd9-CV-wj9ajSDZMA1H=k8uK1T2040rmfY=R_A@mail.gmail.com>
References: <20130904034525.12546.24775.sendpatchset@w520>
 <20130904034608.12546.79411.sendpatchset@w520>
 <CACRpkdY=j_XRPd9-CV-wj9ajSDZMA1H=k8uK1T2040rmfY=R_A@mail.gmail.com>
Message-ID: <CANqRtoTP-mtneubW=Tx-VPyhL4tDiPpuKZRV6BYcGmd1Vcj2fQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

On Sat, Sep 7, 2013 at 1:27 AM, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Wed, Sep 4, 2013 at 5:46 AM, Magnus Damm <magnus.damm@gmail.com> wrote:
>
>> From: Yoshikazu Fujikawa <yoshikazu.fujikawa.ue@renesas.com>
>>
>> Add SCIF serial port support to the r8a7791 SoC by
>> adding platform devices for SCIFA0 -> SCIFA5 as well
>> as SCIFB0 -> SCIFB2 and SCIF0 -> SCIF5 together with
>> clock bindings. DT device description is excluded at
>> this point since such bindings are still under
>> development.
>
> A good way to get started with clock bindings may be to
> move the clocks to drivers/clk because in the neighboring
> drivers over there are many good examples of how to do
> this.
>
> Again this looks like it is piling up more legacy clk
> code instead of moving to the new frameworks.
>
> Please include Mike Turquette on future postings of the
> clk code, he's definately our best clock code reviewer.

Thanks for your recommendation about common clocks, but I believe this
patch really has nothing todo with clocks. It's about SCIF UART
support. The state for SCIF DT support is however similar to common
clocks, so we don't have any DT bindings yet.

Fortunately, SCIF DT support is also planned for the next 6 months, so
over time we can kill off these platform device bits.

Cheers,

/ magnus
