From: sedji.gaouaou@atmel.com (Sedji Gaouaou)
Date: Wed, 10 Mar 2010 10:02:36 +0100
Subject: AC97 audio broken on SAM9263EK?
In-Reply-To: <4B975C9A.3020106@visionsystems.de>
References: <4B85789D.6000704@billgatliff.com>
	<4B864C66.6060209@atmel.com>	<4B867108.2050806@billgatliff.com>
	<4B86AA29.8010806@atmel.com>	<4B89E1BB.6090504@billgatliff.com>
	<4B8B9849.5040203@atmel.com> <4B96571A.3040403@visionsystems.de>
	<4B96668E.6090805@atmel.com> <4B975C9A.3020106@visionsystems.de>
Message-ID: <4B97602C.6070608@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,
>
> I tried both files and the one really working is ac97c_alsa.c. As far as I understand it is combination of both patches for at91 support and full duplex?
>
> I've tried the following applications under Debian 5.0:
>
> mpg123
> vlc
> mplayer
> amarok
>
> Regards,
> Yegor
>

ac97c_alsa.c is the result of the 2 patches I have send to the alsa 
mailing list 
(http://mailman.alsa-project.org/pipermail/alsa-devel/2010-March/025709.html 
and 
http://mailman.alsa-project.org/pipermail/alsa-devel/2010-February/025628.html). 
It indeed adds support for AT91(1/2) and full duplex(2/2).But is is 
strange that if you only apply only the first patch you encounter errors...

On my side I have only tested these patches with mplayer and aplay.
Plus to test the full duplex I have done like this:
"arecord -d 10 -f cd -t wav test.wav & mplayer my_file.mp3"

Regards,
Sedji
