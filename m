From: padma.kvr@gmail.com (Padma Venkat)
Date: Fri, 28 Sep 2012 14:33:55 +0530
Subject: [PATCH V2] ASoC: SAMSUNG: Add DT support for i2s
In-Reply-To: <506470A5.3070307@wwwdotorg.org>
References: <1348741532-29412-1-git-send-email-padma.v@samsung.com>
 <506470A5.3070307@wwwdotorg.org>
Message-ID: <CAAgF-Bc_KwJgcDOOkzrqcondGnmHDQ08s9Ooq61DbON7ZZtvmA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 27, 2012 at 8:58 PM, Stephen Warren <swarren@wwwdotorg.org> wrote:
> On 09/27/2012 04:25 AM, Padmavathi Venna wrote:
>> Add support for device based discovery.
>
>> +++ b/Documentation/devicetree/bindings/sound/samsung-i2s.txt
>
>> +i2s at 03830000 {
>> +     compatible = "samsung,samsung-i2s";
>> +     reg = <0x03830000 0x100>;
>
>> +     tx-dma-channel-secondary = <&pdma0 8>;
>> +     tx-dma-channel = <&pdma0 10>;
>> +     rx-dma-channel = <&pdma0 9>;
>> +     supports-6ch;
>> +     supports-rstclr;
>> +     supports-secdai;
>
> Those 6 properties are custom to this binding so should have a vendor
> prefix, e.g. "samsung,supports-6ch".
Okay. I will change this.
>
> Also, I wonder if this shouldn't wait for the forthcoming standardized
> DT DMA bindings (or perhaps document custom bindings that are identical
> to the new standardized bindings)? Otherwise, the DMA stuff will all
> have to be redefined again. Apparently it's hoped the bindings will be
> in 3.7, or if not there, in 3.8.
Okay. Once the generic DT DMA bindings are available I will use that.
But It will be good if atleast other things get reviewed.

Thanks
Padma
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
