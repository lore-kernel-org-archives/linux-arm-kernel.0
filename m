From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 17 May 2017 17:32:59 -0300
Subject: PROBLEM: ARM Cache policy on single armv7 processor lead to low
 DRAM performance
In-Reply-To: <CAOEkoLwq1fdVuhkm_Z4Lf1BL0XxLyumSxLF7gDPyK_NkzUdVgQ@mail.gmail.com>
References: <CAOEkoLwq1fdVuhkm_Z4Lf1BL0XxLyumSxLF7gDPyK_NkzUdVgQ@mail.gmail.com>
Message-ID: <CAOMZO5DOV9Riho1FO_PNJnXhdxQA9YE55sXqygi8eOvEf+vY+A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Zhao,

On Tue, May 16, 2017 at 1:06 AM, Zhao Yibin <ybzhao1989@gmail.com> wrote:
> Hi, ARM maintainers,
>
> We met some DDR performance issue caused by armv7 cache policy, hope
> you can help.
> On a single armv7(Cortex-A7) processor system, the arm linux kernel,
> without CONFIG_SMP, the cache policy is set to write-back no-allocate,
> which lead to very low DRAM speed,
> around 7MB/s for write, 28MB/s for read.

I saw the same behaviour on a mx6ul, which also has a CortexA7.

To fix this issue we had to enable the SMP bit in the bootloader.

As a reference you can look at this U-Boot patch:
https://patchwork.ozlabs.org/patch/747074/
