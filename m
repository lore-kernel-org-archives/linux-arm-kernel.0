From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Wed, 25 Jan 2012 13:11:48 +0200
Subject: [alsa-devel] [PATCH v4 - resend 00/13] OMAP4: ASoC: Support for
 PandaBoard family
In-Reply-To: <CAJe_Zhfn3urdXfRgAKvdW2_ECYGbNO0b2BuZnCZxrGcL4_sVSg@mail.gmail.com>
References: <1327405950-6676-1-git-send-email-peter.ujfalusi@ti.com>
 <CAJe_Zhfn3urdXfRgAKvdW2_ECYGbNO0b2BuZnCZxrGcL4_sVSg@mail.gmail.com>
Message-ID: <4F1FE374.1010202@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/25/2012 12:50 PM, Jassi Brar wrote:
> Hi Peter,
>    I tried the patchset on my 4430 Panda. Playback works ok, but not Capture.
> All is get is a hiss.
>   Is capture supposed to work ? If yes, any amixer settings that need
> to be done?

Thanks for testing the series.

I do not have Panda on my own, but the capture depends on Panda version:
PandaBoard (4430): You record from HSMIC
PandaBoardES (4460): You record from AFML (line in).

Can you try:
amixer sset 'Analog Left' 'Headset Mic'
amixer sset 'Analog Right' 'Headset Mic'
Or
amixer sset 'Analog Left' 'Aux/FM Left'
amixer sset 'Analog Right' 'Aux/FM Right'

-- 
P?ter
