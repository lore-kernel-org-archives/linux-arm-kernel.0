From: joerg.krause@embedded.rocks (=?ISO-8859-1?Q?J=F6rg?= Krause)
Date: Wed, 25 Jan 2017 13:54:37 +0100
Subject: Still having noise issues when recording sound on i.MX28
Message-ID: <1485348877.16373.7.camel@embedded.rocks>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I am working on a custom i.MX28 based board using mainline Linux 4.9.
The hardware design is based on the i.MX28-EVK: SAIF0 is used for
playback, SAIF1 for record, and SAIF0 is the master of SAIF1:

&saif0 {
????????pinctrl-names = "default";
????????pinctrl-0 = <&saif0_pins_a>;
????????status = "okay";
};

&saif1 {
????????pinctrl-names = "default";
????????pinctrl-0 = <&saif1_pins_a>;
????????fsl,saif-master = <&saif0>;
????????status = "okay";
};

The test application is to start recording after boot-up with arecord,
and playback the recorded sound with aplay. Mostly, the result is
pretty good, but occasionally, the result contains noise. Furthermore,
the noise varies, sometimes I still can hear some samples of the
original sound, sometimes it's all garbage.

I verified that the codec, a WM8731, works properly, by connecting the
I2S interface to a seperate codec, where the DATA OUT pin of the WM8731
is connected to the second codecs DATA IN pin. The output of the second
codec does not contain any noise. So, it is not a codec problem, but
most probably a syncing issue with SAIF0 and SAIF1.

I have noticed the thread "noise issues when recording sound on i.MX28"
[1] opened by Uwe Kleine-K?nig, but it seems the problem was not
resolved, right?

Is anyone facing the same problem? Has anyone found a solution for this
using the mainline kernel?

[1] https://www.spinics.net/lists/arm-kernel/msg477349.html

Best regards,
J?rg Krause
