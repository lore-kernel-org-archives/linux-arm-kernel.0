From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Wed, 24 Jun 2015 19:47:34 +0200 (CEST)
Subject: [PATCH v6 0/9] Add simple NVMEM Framework via regmap.
In-Reply-To: <558AAA8D.8030209@linaro.org>
References: <1435014459-26138-1-git-send-email-srinivas.kandagatla@linaro.org>
 <235181230.251177.1435088854197.JavaMail.open-xchange@oxbsltgw00.schlund.de>
 <558A7C92.2040102@linaro.org> <558AA2E2.1010606@i2se.com>
 <558AAA8D.8030209@linaro.org>
Message-ID: <1641569650.41238.1435168054323.JavaMail.open-xchange@oxbsltgw35.schlund.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Srinivas,

> Srinivas Kandagatla <srinivas.kandagatla@linaro.org> hat am 24. Juni 2015 um
> 15:03 geschrieben:
>
>
>
>
> On 24/06/15 13:30, Stefan Wahren wrote:
> >> >If the question is just about hexdump, then hexdump itself can read
> >> >file from given offset and size.
> > yes, this is my question at first. Let me show the difference between
> > the current implementation and my expectations as a user.
> >
> > $ hexdump /sys/class/nvmem/mxs-ocotp/nvmem
> >
> > Current implementation: dump the complete register range defined in DT
> >
> Its dumping the range which is specified in the provider regmap. If the
> requirement is to dump only particular range, this has to be made
> explicit while creating regmap, which is to specify the base address to
> start from "First data register" and max_register to be "Last data
> register "- "First data register"

i know about max_register, but i can't find the base address in regmap_config.

Do you mean struct regmap_access_table *rd_table ?

>
> > User expectation: dump only the data from OCOTP block
> >
> > Let me explain it for i.MX28 OCOTP
> >
> > 0x8002c000 // Start of OCOTP register block (defined in DT)
> >
> > 0x8002c020 // First data register
> >
> > 0x8002c290 // Last data register
> >
> > 0x8002dfff // End of OCOTP register block (defined in DT)
> >
> > My knowledge about regmap is limited, but how can i achieve that hexdump
> > give me only the data registers? From my understanding this should be
> > handled in regmap and not in the read function.
>
> Setup the base and regmap_config correctly in the provider driver before
> calling regmap_init_mmio().
>
> Let me know if you need more details.

Yes, please.

Stefan

>
> --srini
>
> >
> > Are my expectations about the raw access wrong?
> >
> >
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
