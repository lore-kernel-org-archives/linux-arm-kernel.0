From: jarkko.nikula@bitmer.com (Jarkko Nikula)
Date: Wed, 28 Jan 2015 20:15:46 +0200
Subject: 3.19 on Nokia n900: audio quality awful
In-Reply-To: <54C63F1C.6010703@ti.com>
References: <20150106170433.GA5408@amd> <20150118120139.GA1509@amd>
 <54C63F1C.6010703@ti.com>
Message-ID: <54C92752.9000004@bitmer.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/26/2015 03:20 PM, Peter Ujfalusi wrote:
> On 01/18/2015 02:01 PM, Pavel Machek wrote:
>> In 2.6.28-nokia, it is neccessary to set "Input select" na "digital
>> mic", then it works. Input select being in "playback" option makes it
>> easy to miss.
>>
>> In 3.18 and 3.19-rc3, all I can record are zeros.
>>
>> Does playback/recording work for you on OMAP 3430-based machines?
> 
> Same codec (tlv320aic3106) works fine on my am335x and omap-l138 boards.
> BeagleBoard-xM also fine with twl4030 codec.
> 
> I don't have my n900 in hacking mode (it is still in use time-to-time) but
> looking at the dts file: you might want to add ai3x-micbias-vg property to the
> aic3x nodes to select the correct mic bias voltage. I can't recall what is
> appropriate for n900, but 2.6.28-nokia sources might give you the answer.
> 
No need to go that far. N900 has been supported in mainline since 2.6.39
or so. Part A of AIC34 (which is basically dual AIC33 in a same package)
drives 2 V for the digital microphone bias and part B 2.5 V for the headset.

Unfortunately I haven't had time recently to try what might have caused
that regression after 3.18.

-- 
Jarkko
