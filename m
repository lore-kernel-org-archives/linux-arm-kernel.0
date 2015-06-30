From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Tue, 30 Jun 2015 19:47:09 +0200 (CEST)
Subject: [PATCH v6 0/9] Add simple NVMEM Framework via regmap.
In-Reply-To: <558AFC0B.1050400@linaro.org>
References: <1435014459-26138-1-git-send-email-srinivas.kandagatla@linaro.org>
 <235181230.251177.1435088854197.JavaMail.open-xchange@oxbsltgw00.schlund.de>
 <558A7C92.2040102@linaro.org> <558AA2E2.1010606@i2se.com>
 <558AAA8D.8030209@linaro.org>
 <1641569650.41238.1435168054323.JavaMail.open-xchange@oxbsltgw35.schlund.de>
 <558AFC0B.1050400@linaro.org>
Message-ID: <1183639717.72990.1435686429623.JavaMail.open-xchange@oxbsltgw03.schlund.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Srinivas,

> Srinivas Kandagatla <srinivas.kandagatla@linaro.org> hat am 24. Juni 2015 um
> 20:50 geschrieben:
>
>
>
>
> On 24/06/15 18:47, Stefan Wahren wrote:
> > Hi Srinivas,
> >
> >> Srinivas Kandagatla <srinivas.kandagatla@linaro.org> hat am 24. Juni 2015
> >> um
> >> 15:03 geschrieben:
> >>
> >>
> >>
> >>
> >> On 24/06/15 13:30, Stefan Wahren wrote:
> >>>>> If the question is just about hexdump, then hexdump itself can read
> >>>>> file from given offset and size.
> >>> yes, this is my question at first. Let me show the difference between
> >>> the current implementation and my expectations as a user.
> >>>
> >>> $ hexdump /sys/class/nvmem/mxs-ocotp/nvmem
> >>>
> >>> Current implementation: dump the complete register range defined in DT
> >>>
> >> Its dumping the range which is specified in the provider regmap. If the
> >> requirement is to dump only particular range, this has to be made
> >> explicit while creating regmap, which is to specify the base address to
> >> start from "First data register" and max_register to be "Last data
> >> register "- "First data register"
> >
> > i know about max_register, but i can't find the base address in
> > regmap_config.
> >
> Base is not in the regmap config, its the value which you pass to the
>

thanks for you explanation. I was confused by the word base because in your
example
it is the context variable.

Now i've successful tested my first version of the OCOTP driver based on NVMEM
framework [1].

Currently only the raw sysfs access is working. So i have another question:

How do i get the cell info from the devicetree for the nvmem_config?

I expected a function like of_nvmem_cell_info_get() .

Regards
Stefan

[1] -
https://github.com/lategoodbye/fsl_ocotp/commit/7c98e19755b69f761885b0e1ceb2c258a7c47ade
