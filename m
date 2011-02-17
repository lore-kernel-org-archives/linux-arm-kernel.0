From: sudhakar.raj@ti.com (Rajashekhara, Sudhakar)
Date: Thu, 17 Feb 2011 09:53:40 +0530
Subject: ALSA issue on DA850/OMAP-L138/AM18x
In-Reply-To: <4D5BDA3D.5080905@acn-group.ch>
References: <B85A65D85D7EB246BE421B3FB0FBB59302484734E0@dbde02.ent.ti.com>
	<4D5BDA3D.5080905@acn-group.ch>
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593024B83B5E4@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Christophe,

On Wed, Feb 16, 2011 at 19:37:57, Christophe Aeschlimann wrote:
> Hi Sudhakar,
> 
> On 18.01.2011 05:43, Rajashekhara, Sudhakar wrote:
> 
> [...]
> 
>  > With the above fixes, arecord and aplay does not work for the first time.
>  > Couple of times I get the below error:
>  >
>  > root at da850-omapl138-evm:~# arecord -f dat | aplay -f dat
>  > arecord: main:608: audio open error: Invalid argument
>  > aplay: playback:2297: read error
>  > root at da850-omapl138-evm:~# arecord -f dat | aplay -f dat
>  > aplay: main:608: audio open error: Invalid argument
>  > Recording WAVE 'stdin' : Signed 16 bit Little Endian, Rate 48000 Hz, 
> Stereo
>  >
>  > Third time arecord and aplay work normally.
>  >
>  > Has anyone seen such issues on DA850 or any other platform?
>  >
>  > I am currently debugging this issue. I'll submit the above patch to 
> community
>  > once the issue of fixed.
> 
> I'm facing the same issue here.
> 
> Did you make any progress on that one ?
> 

Reverting the commit 140176159597ea1f23dcccb47b5c38fdf7c7faa8 
(ASoC: Configure symmetric rates for tlv320aic3x) resolves the issue. We are
still working on the proper fix.

Thanks,
Sudhakar 
