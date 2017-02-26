From: pavel@ucw.cz (Pavel Machek)
Date: Sun, 26 Feb 2017 21:28:32 +0100
Subject: Microphone gain on N900
Message-ID: <20170226202831.GA31405@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

v4.10 works quite nicely on N900, but I still have problems with
audio. Even GSM calls would be usable, if I had reasonable volume on
microphone and speaker... but I don't.

Both speaker and microphone are too quiet. I can get louder output by
plugging headset -- good. I can hear the other side nicely, but am too
quiet for them. Unfortunately, even if I plug in wired headset,
internal microphone is still used.

Now... I researched mixer settings in v4.4, v4.10 and v2.6.28... and
could not find way to control microphone. v2.6.28 is completely
different from the other two. v4.10 misses many controls from v4.4;
and I guess this might be related:

[    2.579925] rx51-audio n900-audio: tlv320aic3x-hifi <->
49022000.mcbsp mapping ok
[    2.586486] rx51-audio n900-audio: ASoC: no source widget found for
TPA6130A2 HPLEFT
[    2.592651] rx51-audio n900-audio: ASoC: Failed to add route
TPA6130A2 HPLEFT -> direct -> Headphone Jack
[    2.605163] rx51-audio n900-audio: ASoC: no source widget found for
TPA6130A2 HPRIGHT
[    2.611938] rx51-audio n900-audio: ASoC: Failed to add route
TPA6130A2 HPRIGHT -> direct -> Headphone Jack
[    2.625701] rx51-audio n900-audio: ASoC: no sink widget found for
TPA6130A2 LEFTIN
[    2.632965] rx51-audio n900-audio: ASoC: Failed to add route LLOUT
-> direct -> TPA6130A2 LEFTIN
[    2.640563] rx51-audio n900-audio: ASoC: no sink widget found for
TPA6130A2 RIGHTIN
[    2.648101] rx51-audio n900-audio: ASoC: Failed to add route RLOUT
-> direct -> TPA6130A2 RIGHTIN
[    2.655761] rx51-audio n900-audio: ASoC: no sink widget found for b
LINE2R
[    2.663208] rx51-audio n900-audio: ASoC: Failed to add route
MONO_LOUT -> direct -> b LINE2R
[    2.670501] rx51-audio n900-audio: ASoC: no source widget found for
b HPLOUT
[    2.677642] rx51-audio n900-audio: ASoC: Failed to add route b
HPLOUT -> direct -> Earphone
[    2.685058] rx51-audio n900-audio: ASoC: no source widget found for
b Mic Bias
[    2.692352] rx51-audio n900-audio: ASoC: Failed to add route b Mic
Bias -> direct -> HS Mic
[    2.706298] input: RX-51 AV Jack as
/devices/platform/n900-audio/sound/card0/input6

Pali, do you have maemo running on top of recent kernel (v4.1, v4.4,
v4.10?). Do voice calls work there?

Any ideas welcome...

Best regards,
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170226/26df08ad/attachment-0001.sig>
