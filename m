From: moinejf@free.fr (Jean-Francois Moine)
Date: Thu, 20 Mar 2014 16:54:40 +0100
Subject: [PATCH] ASoC: tda998x: Fix lack of required reg in DT
 documentation
In-Reply-To: <20140320151934.GV7528@n2100.arm.linux.org.uk>
References: <20140320092639.48F68A6279@smtp3-g21.free.fr>
 <532ADFD8.80301@gmail.com> <20140320140156.5d768b1f@armhf>
 <532AEDE2.3080306@gmail.com> <20140320145221.09252bf6@armhf>
 <20140320143110.GU7528@n2100.arm.linux.org.uk>
 <20140320155935.7a474173@armhf>
 <20140320151934.GV7528@n2100.arm.linux.org.uk>
Message-ID: <20140320165440.195cd2ea@armhf>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 20 Mar 2014 15:19:34 +0000
Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:

> I'm not saying that it has to match the physical device fitted - I'm
> merely suggesting not using nxp,tda1998x which could (and as Sebastian
> has found, does) conflict with other devices with different properties.
> 
> We still auto-detect the exact device type by reading the ID register
> because that's the most reliable way to detect exactly what kind of
> device is fitted to the board.

I don't see the problem.

Actually the driver handles the tda9989, tda19988 and tda19989 (2
variants). If some board has, for example, the tda9983 and if the
driver is extended to handle this chip (i.e. mainly ignore the CEC
part), setting 'nxp,tda998x' in the associated DT will still work.

There could be a problem if somebody would write a specific driver for,
say, a tda9985. But, then, the compatible would be 'nxp,tda9985'.

-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
