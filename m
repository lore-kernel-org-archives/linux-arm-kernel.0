From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Thu, 5 Oct 2017 14:29:33 -0400 (EDT)
Subject: [PATCH 2/2] of/fdt: skip unflattening of disabled nodes
In-Reply-To: <59D40813.4020009@gmail.com>
References: <20171003161815.25999-1-robh@kernel.org>
 <20171003161815.25999-2-robh@kernel.org>
 <nycvar.YSQ.7.76.1710031444060.5407@knanqh.ubzr> <59D40813.4020009@gmail.com>
Message-ID: <nycvar.YSQ.7.76.1710051427000.1693@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 3 Oct 2017, Frank Rowand wrote:

> On 10/03/17 11:46, Nicolas Pitre wrote:
> > On Tue, 3 Oct 2017, Rob Herring wrote:
> > 
> >> For static DT usecases, we don't need the disabled nodes and can skip
> >> unflattening. This saves a significant amount of RAM in memory constrained
> >> cases. In one example on STM32F469, the RAM usage goes from 118K to 26K.
> >>
> >> There are a few cases in the kernel that modify the status property
> >> dynamically. These all are changes from enabled to disabled, depend on
> >> OF_DYNAMIC or are not FDT based (PDT based).
> >>
> >> Cc: Nicolas Pitre <nicolas.pitre@linaro.org>
> >> Cc: Frank Rowand <frowand.list@gmail.com>
> >> Signed-off-by: Rob Herring <robh@kernel.org>
> > 
> > Tested-by: Nicolas Pitre <nico@linaro.org>
> > 
> >> ---
> >> For more background, see this presentation from Nico:
> >>
> >> https://connect.linaro.org/resource/sfo17/sfo17-100/
> > 
> > Oh my ... this is horrible ...
> 
> I found the presentation to be quite good and useful.

Thanks. I think the content is good. I'm just a terrible speaker.

> The Linaro site does not have the slides, could you please send
> me a copy?

I've asked for the slides to be uploaded to the site. I've sent you a 
copy privately in the mean time.


Nicolas
