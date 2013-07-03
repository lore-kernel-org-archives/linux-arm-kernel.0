From: richard.genoud@gmail.com (Richard Genoud)
Date: Wed, 3 Jul 2013 14:21:06 +0200
Subject: [RFC PATCH 01/13] misc: atmel_ssc: add device tree DMA support
In-Reply-To: <51D29927.80900@atmel.com>
References: <1372667978-4718-1-git-send-email-richard.genoud@gmail.com>
 <1372667978-4718-2-git-send-email-richard.genoud@gmail.com>
 <51D24299.9050209@atmel.com>
 <CACQ1gAgcc=j3kmcpjp8bbdHhxr_k=h8jJs6R_paJbPUMv74uGg@mail.gmail.com>
 <51D29927.80900@atmel.com>
Message-ID: <CACQ1gAhnDk-qSt_5xrsMakXqGGDO5pEbA-9UDWCJG=AABDc+zg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2013/7/2 Bo Shen <voice.shen@atmel.com>:
> Hi Richard,
>
>
> On 7/2/2013 16:13, Richard Genoud wrote:
>>>
>>> Please hold on of this, as to the ASoC dmaengine will deal with this. So,
>>> we
>>> >not need do it manually.
>>> >
>>> >Now, I am working on it. And will send out the patch soon after testing
>>> > OK.
>>
>> Ok, I stay tuned !
>
>
> I think you can go on working with the two patches I send just now.
> [1]: ASoC: atmel_ssc_dai: move set dma data to startup callback
> https://patchwork.kernel.org/patch/2811241/
>
> [2]: ASoC: atmel-pcm: use generic dmaengine framework
> https://patchwork.kernel.org/patch/2811261/
>
> I use your patches 4 ~ 8 do a quick testing, it works. Please note the name
> of asound.state under /etc in your rootfs should the same with atmel,model
> in patch 6.

Thanks for testing !
I was just doing the same test, it works with
aplay  -Dplug:default  good_music.wav

but there's a violent hang (kernel stops, no trace) when I try the record :
arecord -v -V stereo -Dplug:default -f cd -t wav -c 2 /tmp/toto.wav
last thing I see is :
dma dma0chan3: atc_control (3)

I'll try to trace that.


Best regards,
Richard.
