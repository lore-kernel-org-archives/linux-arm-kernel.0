From: pavel@ucw.cz (Pavel Machek)
Date: Thu, 2 Mar 2017 15:28:22 +0100
Subject: Microphone gain on N900
In-Reply-To: <4435ddd2-ca0e-b05d-727d-9f38416c0f97@bitmer.com>
References: <20170226202831.GA31405@amd> <201702272053.37882@pali>
 <4435ddd2-ca0e-b05d-727d-9f38416c0f97@bitmer.com>
Message-ID: <20170302142822.GA30427@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> >> v4.10 works quite nicely on N900, but I still have problems with
> >> audio. Even GSM calls would be usable, if I had reasonable volume on
> >> microphone and speaker... but I don't.
> >>
> >> Both speaker and microphone are too quiet. I can get louder output by
> >> plugging headset -- good. I can hear the other side nicely, but am
> >> too quiet for them. Unfortunately, even if I plug in wired headset,
> >> internal microphone is still used.
> >>
> For me these settings provide reasonable playback and capture volumes
> using v4.10.1:
> 
> amixer -D hw:0 set PCM 100%
> amixer -D hw:0 set 'Line DAC' 80% on
> amixer -D hw:0 set 'Line' on
> amixer -D hw:0 set 'Left Line Mixer DACL1' on
> amixer -D hw:0 set 'Right Line Mixer DACR1' on
> amixer -D hw:0 set 'Jack Function' 'Headphone'
> amixer -D hw:0 set 'TPA6130A2 Headphone' 80%
> 
> amixer -D hw:0 set 'Jack Function' 'Headset'
> amixer -D hw:0 set 'AGC' off
> amixer -D hw:0 set 'Input Select' 'ADC'
> amixer -D hw:0 set 'Left PGA Mixer Line1L' on
> amixer -D hw:0 set 'Left Line1L Mux' 'differential'
> amixer -D hw:0 set 'Right PGA Mixer Line1L' on
> amixer -D hw:0 set 'Right Line1L Mux' 'differential'
> amixer -D hw:0 set 'ADC HPF Cut-off' '0.0045xFs' 'disabled'
> amixer -D hw:0 set PGA 50% on
> amixer -D hw:0 cset iface=MIXER,name='PGA Capture Switch',index=0 on

This seems to correspond to volumes I have had before. They are enough
for phone call in quiet environment, but not really for normal usage.

Do you have settings where microphone on wired headset works?

Thanks,
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170302/2b464f00/attachment.sig>
