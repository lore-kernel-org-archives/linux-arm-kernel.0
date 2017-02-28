From: jarkko.nikula@bitmer.com (Jarkko Nikula)
Date: Tue, 28 Feb 2017 20:45:14 +0200
Subject: Microphone gain on N900
In-Reply-To: <201702272053.37882@pali>
References: <20170226202831.GA31405@amd> <201702272053.37882@pali>
Message-ID: <4435ddd2-ca0e-b05d-727d-9f38416c0f97@bitmer.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/27/17 21:53, Pali Roh?r wrote:
> On Sunday 26 February 2017 21:28:32 Pavel Machek wrote:
>> Hi!
>>
>> v4.10 works quite nicely on N900, but I still have problems with
>> audio. Even GSM calls would be usable, if I had reasonable volume on
>> microphone and speaker... but I don't.
>>
>> Both speaker and microphone are too quiet. I can get louder output by
>> plugging headset -- good. I can hear the other side nicely, but am
>> too quiet for them. Unfortunately, even if I plug in wired headset,
>> internal microphone is still used.
>>
For me these settings provide reasonable playback and capture volumes
using v4.10.1:

amixer -D hw:0 set PCM 100%
amixer -D hw:0 set 'Line DAC' 80% on
amixer -D hw:0 set 'Line' on
amixer -D hw:0 set 'Left Line Mixer DACL1' on
amixer -D hw:0 set 'Right Line Mixer DACR1' on
amixer -D hw:0 set 'Jack Function' 'Headphone'
amixer -D hw:0 set 'TPA6130A2 Headphone' 80%

amixer -D hw:0 set 'Jack Function' 'Headset'
amixer -D hw:0 set 'AGC' off
amixer -D hw:0 set 'Input Select' 'ADC'
amixer -D hw:0 set 'Left PGA Mixer Line1L' on
amixer -D hw:0 set 'Left Line1L Mux' 'differential'
amixer -D hw:0 set 'Right PGA Mixer Line1L' on
amixer -D hw:0 set 'Right Line1L Mux' 'differential'
amixer -D hw:0 set 'ADC HPF Cut-off' '0.0045xFs' 'disabled'
amixer -D hw:0 set PGA 50% on
amixer -D hw:0 cset iface=MIXER,name='PGA Capture Switch',index=0 on

-- 
Jarkko
