From: magnus.damm@gmail.com (Magnus Damm)
Date: Wed, 12 Mar 2014 20:05:26 +0900
Subject: [PATCH 4/5] ARM: shmobile: r8a7790: add IIC(B) clocks to dtsi
In-Reply-To: <1394573078-20767-5-git-send-email-wsa@the-dreams.de>
References: <1394573078-20767-1-git-send-email-wsa@the-dreams.de>
 <1394573078-20767-5-git-send-email-wsa@the-dreams.de>
Message-ID: <CANqRtoQhi=vgLkYQciJska6XogyiJ1REO6HBOHNsPP3ajbq+Ag@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Wolfram,

On Wed, Mar 12, 2014 at 6:24 AM, Wolfram Sang <wsa@the-dreams.de> wrote:
> From: Wolfram Sang <wsa@sang-engineering.com>
>
> Signed-off-by: Wolfram Sang <wsa@sang-engineering.com>
> ---
> Note: Adding clocks whilst keeping the current sorting is very likely to
> break a previously working clock IMO. Imagine adding PCIEC clock inbetween IIC0
> and IIC1 here. Adding chronologically and grouped by similar function blocks is
> easier to track. An example addition could then look like:
>
>         R8A7790_CLK_TPU0
>         R8A7790_CLK_SDHI3 R8A7790_CLK_SDHI2 R8A7790_CLK_SDHI1 R8A7790_CLK_SDHI0
>         R8A7790_CLK_MMCIF1 R8A7790_CLK_MMCIF0
>         R8A7790_CLK_CMT1
>         R8A7790_CLK_IIC2 R8A7790_CLK_IIC1 R8A7790_CLK_IIC0
> +       R8A7790_CLK_PCIEC

Can you please care to explain a bit more about why you see a risk
here? Is it a risk for typo or something else?

It looks to me that this is just a matter about adding the entry at
the right position in several places.

Thanks,

/ magnus
