From: patrikbachan@gmail.com (Patrik Bachan aka DiGGiT)
Date: Mon, 16 Feb 2015 23:38:49 +0100
Subject: n900 audio: any ideas how to get headset speaker to work?
In-Reply-To: <20150216095748.GA25918@amd>
References: <20150215102152.GA23736@amd>
 <CAK7bGn+NH9BOB25+dhNZXFxY_fD8TeoWvuSpTD-4cg-zU5dOmA@mail.gmail.com>
 <20150216095748.GA25918@amd>
Message-ID: <CAK7bGn+SUXCk+ydMmCPeP18dMdwj85zeHte2zdGdNLGX-YBRdw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-02-16 10:57 GMT+01:00 Pavel Machek <pavel@ucw.cz>:
> Ahoj!
>
>> > By default, output goes to loudspeaker (top right relative to
>> > keyboard). Any ideas how to switch it to the speaker on the left or
>> > wired headset? Because I suspect that echo cancelation is not going to
>> > be simple...
>> >                                                                         Pavel
>> > --
>> > (english) http://www.livejournal.com/~pavelmachek
>> > (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
>>
>> Hi,
>> in case of direct alsa output (not PA), setup is pretty complex.
>> Headphones referenced as line. All audio outputs are differential.
>> Here are controls that affects volumes...
>
> Aha, thanks for nice explanation. Now it starts to make sense... I got
> headset connected to 3.5" jack to work.
>
> Now, I guess I'd like the internal speaker on the left to work,
> too... Aha, so n900 has two stereo "loud" speakers on the keyboard
> part, plus extra speaker on the left display part for communication?
>

Yes, exactly.

> I got the two stereo ones to work now.
>
> Any idea what is the last speaker on display is called? HPCOM? Mono?

In schematics, earphone is connected to Left HP, channel B
(loudspeakers are channel A). But even after enabling all its
controls, earphone stays muted. My N900 may have broken flex causing
my touchscreen problems too. Better try it yourself.

>> global:
>>  PCM (volume)
>>  left/right DAC mux (below)
>>       -- DAC_L1/R1 passes sound to loudspeakers, line, (maybe others)
>>       -- DAC_L2/R2 passes sound to loudspeakers, NOT line, (maybe others)
>>       -- DAC_L3/R3 passes sound to NOT loudspeakers, line, (maybe others)
>>       if DAC_L1/R1 is chosen, you can hear lower volume on both
>> outputs in compare to dedicated outputs (DAC_L2/R2, DAC_L3/R3),
>> probabbly due to higher load of ADC
>>
>>
>> loudspeakers:
>>  Speaker function (on)
>>  HP (unmute)
>>  HP DAC (volume)
>>  left HP Mixer DACL1 (below)
>>  right HP Mixer DACR1 (below)
>>    --unmute theese two,  this will pass left channel sound to left
>> channel output and vice versa
>>  left HP Mixer DACR1 (below)
>>  right HP Mixer DACL1 (below)
>>   --mute these two, this controls channel crosstalk ( amount of left
>> channel sound going to right channel output and vice versa)
>>
>> line:
>>  line (unmute)
>>  line DAC (volume)
>>  jack function (headphone)
>>  TPA6130A2 Headphone (volume)
>>  left Line Mixer DACL1 (below)
>>  right Line Mixer DACR1 (below)
>>    --unmute theese two,  this will pass left channel sound to left
>> channel output and vice versa
>>  left Line Mixer DACR1 (below)
>>  right Line Mixer DACL1 (below)
>>   --mute these two, this controls channel crosstalk ( amount of left
>> channel sound going to right channel output and vice versa)
>
> Thanks a lot!
>                                                                         Pavel
> --
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
