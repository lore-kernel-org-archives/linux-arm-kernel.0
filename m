From: mw@semihalf.com (Marcin Wojtas)
Date: Mon, 19 Sep 2016 15:17:43 +0200
Subject: [PATCH v2 0/3] Armada 7k/8k CP110 system controller fixes
In-Reply-To: <1473183117-11889-1-git-send-email-mw@semihalf.com>
References: <1473183117-11889-1-git-send-email-mw@semihalf.com>
Message-ID: <CAPv3WKdoas6nJngFh2bLU0wvz2OZMga6G40UMPkfz9aunRawVw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen,

Did you have any chance to take a look at v2? Do you have any remarks?

Best regards.
Marcin

2016-09-06 19:31 GMT+02:00 Marcin Wojtas <mw@semihalf.com>:
> Hi,
>
> Here is the second version of the patchset adding fixes to CP110
> system controller clock driver. As requested during review,
> an additional patch is submitted, which covers migration of the
> driver to clk_hw registration and API.
>
> Any feedback would be very welcome.
>
> Best regards,
> Marcin
>
> Changelog:
> v1 -> v2
> * replace setting CLK_IS_BASIC flag with clearing init structure fields
>   with memset
> * minor improvements of allocation and error checking
> * add migration to clk_hw
>
> Marcin Wojtas (3):
>   clk: mvebu: fix setting unwanted flags in CP110 gate clock
>   clk: mvebu: dynamically allocate resources in Armada CP110 system
>     controller
>   clk: mvebu: migrate CP110 system controller to clk_hw API and
>     registration
>
>  drivers/clk/mvebu/cp110-system-controller.c | 155 +++++++++++++++-------------
>  1 file changed, 81 insertions(+), 74 deletions(-)
>
> --
> 1.8.3.1
>
