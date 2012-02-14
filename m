From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Tue, 14 Feb 2012 17:28:33 +0100
Subject: remoteproc: Load coprocessor code to the specific main memory
 location
In-Reply-To: <4F391C1D.9020402@monstr.eu>
References: <4F1EE861.4030405@monstr.eu>
 <CAK=Wgba5kT8AwLtuHyosucYnWf-EA+xpE1kzmssfhSC7ZXQA=g@mail.gmail.com>
 <4F1FF870.3000105@monstr.eu>
 <CAK=WgbZwaxMPsMiNcq5yFvBLrcODqGgDT6b=mmQ91JBVtTEyXA@mail.gmail.com>
 <4F200F64.9060203@monstr.eu>
 <CAK=WgbZDADRf1OF=uWbbsF+t2dx36tqj=kRftn5nd4RA7DtEnA@mail.gmail.com>
 <4F212E9E.9060807@monstr.eu>
 <CAK=WgbYMBDp3Qm8TErNrnDwn2ZTFt62+OuyyQvVE-jrnNsL6kg@mail.gmail.com>
 <4F391C1D.9020402@monstr.eu>
Message-ID: <CAK=WgbYn6hrS4YLEdfp=0jSEfEwy-HkJmt5S06_j6gZFf0UTmQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 13, 2012 at 3:20 PM, Michal Simek <monstr@monstr.eu> wrote:
> Here is how it is achieve
> ? ? ? ?ret = dma_declare_coherent_memory(&zynq_freertos.dev, 0,
> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?0, 0x10000000, DMA_MEMORY_MAP);
>
> which is fully compatible with remoteproc.

Great, this is what we've been doing with davinci too.

> Do you have any example of using it?

What exactly are you looking for ? RTOS or Linux side ?

On the Linux side, you can just make the rpmsg sample work (it's part
of the rpmsg patch set). For the RTOS side, feel free to just take our
code (it's BSD licensed and hosted on github) and adapt it to your
environment.

Ohad.
