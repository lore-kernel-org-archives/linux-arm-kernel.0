From: sbabic@denx.de (Stefano Babic)
Date: Wed, 10 Jul 2013 10:10:00 +0200
Subject: [PATCH] ARM: dts: imx: add tempmon node for imx6q thermal support
In-Reply-To: <20130710070915.GA12605@S2101-09.ap.freescale.net>
References: <1370330008-5982-1-git-send-email-shawn.guo@linaro.org>
 <1370330226-6030-1-git-send-email-shawn.guo@linaro.org>
 <51DC256D.6040204@denx.de> <20130710070915.GA12605@S2101-09.ap.freescale.net>
Message-ID: <51DD16D8.8070803@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

On 10/07/2013 09:09, Shawn Guo wrote:

> Address 0x20C8180 is where TEMPMON control registers are - they are
> embedded in ANATOP block, while calibration data is stored in OCOTP fuse
> block.
> 

Thanks, it is clear now.

>> imx_thermal tempmon.7: invalid sensor calibration data
>> imx_thermal tempmon.7: failed to get sensor data
>> imx_thermal: probe of tempmon.7 failed with error -22
> 
> What's your chip revision?  Early revisions may not have the calibration
> data.  TO1.2 should have, I think.

That is the point - on the board I tested there is a T01.0 running.

> 
>> The driver is loaded successfully if I changed the tempdata to point to
>> 020C8180. Not sure if I get the right values from temp1_crit and
>> temp1_input, but no error at the initialisation. Am I missing something ?
> 
> It reads some data but that's not calibration data, so it should not work.
> 
> Also, you need a cpu_cooling fix [1], if you want to play the thermal
> patches on imx6q.

Understood, thanks.

Stefano

-- 
=====================================================================
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-53 Fax: +49-8142-66989-80 Email: sbabic at denx.de
=====================================================================
