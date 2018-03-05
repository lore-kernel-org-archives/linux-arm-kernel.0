From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 5 Mar 2018 20:22:26 -0300
Subject: Regulator regression in next-20180305
In-Reply-To: <20180305231246.GB5799@atomide.com>
References: <20180305231246.GB5799@atomide.com>
Message-ID: <CAOMZO5CXy=7ZKVapp_2Q4wq=mY-dJ0owZZN84vqUj1j1xasOKg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tony,

On Mon, Mar 5, 2018 at 8:12 PM, Tony Lindgren <tony@atomide.com> wrote:
> Hi Mark and Maciej,
>
> Looks like with next-20180305 there's a regulator regression
> where mmc0 won't show any cards or produces errors:
>
> mmcblk0: error -110 requesting status
> mmc1: new high speed SDIO card at address 0001
> mmcblk0: error -110 requesting status
> mmcblk0: recovery failed!
> print_req_error: I/O error, dev mmcblk0, sector 0
> Buffer I/O error on dev mmcblk0, logical block 0, async page read
> mmcblk0: error -110 requesting status
> mmcblk0: recovery failed!
>
> I bisected it down to the following commits:
>
> broken          71c33626a802 ("regulator: core: Change voltage setting path")
> fails to build  a7348f502ab7 ("regulator: core: Add voltage balancing mechanism")
> works           cf6fc8064766 ("regulator: core: Resolve coupled regulators")
>
> Any ideas?

I have also seen regulator issues due to this series:
https://lkml.org/lkml/2018/3/5/731
