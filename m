From: voice.shen@atmel.com (Bo Shen)
Date: Thu, 4 Jul 2013 09:15:00 +0800
Subject: [RFC PATCH 01/13] misc: atmel_ssc: add device tree DMA support
In-Reply-To: <CACQ1gAgPaRm3gxxJNgfj9bR565Q0+SNY3+EcjA_mrh1N+yPzSA@mail.gmail.com>
References: <1372667978-4718-1-git-send-email-richard.genoud@gmail.com>
 <1372667978-4718-2-git-send-email-richard.genoud@gmail.com>
 <51D24299.9050209@atmel.com>
 <CACQ1gAgcc=j3kmcpjp8bbdHhxr_k=h8jJs6R_paJbPUMv74uGg@mail.gmail.com>
 <51D29927.80900@atmel.com>
 <CACQ1gAhnDk-qSt_5xrsMakXqGGDO5pEbA-9UDWCJG=AABDc+zg@mail.gmail.com>
 <CACQ1gAgPaRm3gxxJNgfj9bR565Q0+SNY3+EcjA_mrh1N+yPzSA@mail.gmail.com>
Message-ID: <51D4CC94.3020908@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Richard,

On 7/3/2013 23:51, Richard Genoud wrote:
>> >but there's a violent hang (kernel stops, no trace) when I try the record :
>> >arecord -v -V stereo -Dplug:default -f cd -t wav -c 2 /tmp/toto.wav
>> >last thing I see is :
>> >dma dma0chan3: atc_control (3)

I don't meet this issue. Playback and recording works well on my side on 
at91sam9g35ek board.

>> >I'll try to trace that.
> I think it's DMA related.
> the last thing done by the kernel is:
>   i2c i2c-0: i2c_outb: 0x34 A
>   i2c i2c-0: i2c_outb: 0x0c A
>   i2c i2c-0: i2c_outb: 0x5a A
> meaning: enable power on, LINE IN, ADC, OSC, on the WM8731
> so, after that, data is comming from the codec to the SSC and then is
> handled by the DMA.
> there must be something nasty on the DMA bus to hang everything like that...

Will you try i2c without DMA support to test this issue?

> Richard.

Best Regards,
Bo Shen
