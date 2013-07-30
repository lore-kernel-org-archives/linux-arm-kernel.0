From: richard.genoud@gmail.com (Richard Genoud)
Date: Tue, 30 Jul 2013 14:15:45 +0200
Subject: [PATCH v6 8/8] ASoC: sam9x5: get codec MCLK via device tree
In-Reply-To: <20130730120304.GU9858@sirena.org.uk>
References: <1375180329-4860-1-git-send-email-richard.genoud@gmail.com>
 <1375180329-4860-9-git-send-email-richard.genoud@gmail.com>
 <20130730120304.GU9858@sirena.org.uk>
Message-ID: <CACQ1gAj=HpEbiNTaPrGO-XxgVy9s-0Nya+pp4-nh7TzOLhxrNg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2013/7/30 Mark Brown <broonie@kernel.org>:
> On Tue, Jul 30, 2013 at 12:32:09PM +0200, Richard Genoud wrote:
>
>> --- a/Documentation/devicetree/bindings/sound/atmel-sam9x5-wm8731-audio.txt
>> +++ b/Documentation/devicetree/bindings/sound/atmel-sam9x5-wm8731-audio.txt
>> @@ -8,6 +8,8 @@ Required properties:
>>    - atmel,audio-routing: A list of the connections between audio components.
>>      Each entry is a pair of strings, the first being the connection's sink,
>>      the second being the connection's source.
>> +  - clocks: Must contain an entry for the codec master clock.
>> +  - clock-names : Must be "mclk" (clock that feeds the codec master clock)
>
> This should be part of the CODEC binding, not part of the machine driver
> binding.  The machine driver should currently have the code to fetch the
> clock but since the clock physically goes to the CODEC it should be part
> of the CODEC binding.
That makes sense.

Thanks !
