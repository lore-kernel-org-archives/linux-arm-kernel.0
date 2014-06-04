From: pmeerw@pmeerw.net (Peter Meerwald)
Date: Wed, 4 Jun 2014 08:47:21 +0200 (CEST)
Subject: XADC
In-Reply-To: <e2cd1349-5cfb-4456-a1f5-74e7affff085@BN1AFFO11FD006.protection.gbl>
References: <e2cd1349-5cfb-4456-a1f5-74e7affff085@BN1AFFO11FD006.protection.gbl>
Message-ID: <alpine.DEB.2.01.1406040843120.32323@pmeerw.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

> I recently found that you developed a driver for XADC and I thought I
> enable it (see patch below). But it seems something is not working
> correctly. The values I tested don't seem to be right and also fixed.
> I.e. they don't change over time or across boards:
> 
>   # cat in_temp0_scale 
>   123.040771484
>   # cat in_voltage0_vccint_scale 
>   0.732421875
>   # cat in_voltage0_vccint_raw 
>   1384
>   # cat in_voltage1_vccaux_s[ 1203.660637] random: nonblocking pool is initialized
>   # cat in_voltage1_vccaux_scale 
>   0.732421875
>   # cat in_voltage3_vccpint_scale 
>   0.732421875

the _scale values are supposed to be constant; their purpose is to scale a 
measurement so that the result is in a given unit

e.g. in_temp0_scale scales in_temp0_raw so that the result 
(in_temp0_raw * in_temp0_scale) in milli Celsius

in_voltage0_vccint_raw * in_voltage0_vccint_scale is supposed to give 
milli Volts

so in_voltage0_vccint_raw should vary accross time / boards (and voltage 
hopefully :), but not the _scales

regards, p.

-- 

Peter Meerwald
+43-664-2444418 (mobile)
