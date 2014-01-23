From: khilman@linaro.org (Kevin Hilman)
Date: Thu, 23 Jan 2014 09:53:32 -0800
Subject: [PATCH] ARM: OMAP4+: move errata initialization to
 omap4_pm_init_early
In-Reply-To: <52E139C5.3090207@ti.com> (Grygorii Strashko's message of "Thu,
 23 Jan 2014 17:48:21 +0200")
References: <CAGa+x863_MQ22h+U=KtK++3aG2F_X4x57Xtfe16GYXKNiaWX4A@mail.gmail.com>
 <1390248397-14112-1-git-send-email-nm@ti.com>
 <52E139C5.3090207@ti.com>
Message-ID: <874n4uy483.fsf@paris.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Grygorii Strashko <grygorii.strashko@ti.com> writes:

> On 01/20/2014 10:06 PM, Nishanth Menon wrote:
>> Move all OMAP4 PM errata initializations to centralized location in
>> omap4_pm_init_early. This allows for users to utilize the erratas
>> in various submodules as needed.
>> 
> Tested-by: Grygorii Strashko <grygorii.strashko@ti.com>
>
> This patch fixes build failure caused by patch 
> https://patchwork.kernel.org/patch/3084521/ 
> in case if SMP is not enabled.

So does that mean that that patch can now be applied as is?

We could sure use that fix (or equivalent) for CPUidle breakage on 4460.

Kevin
