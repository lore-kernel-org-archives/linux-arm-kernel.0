From: icenowy@aosc.io (Icenowy Zheng)
Date: Wed, 29 Mar 2017 00:40:09 +0800
Subject: About the thermal sensor driver on H3/A64/H5
Message-ID: <20170329004009.2aa6b7a9@x220i>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi everyone,
I'm trying to do a mainlinable thermal driver for H3/A64/H5 SoCs;
however, I found some problem:

Maxime have told me to reuse the code for A10/A13/A31/A33 thermal
driver -- I tried, and it works on H3.

However, as it is an IIO driver, some failure occured on H5 -- the
temperature sensor is not linear on H5: it has a different formula
when it's higher than 70 Celsius degree.

In addition, a lot of code for A33 is in fact rewrite for H3, due to
totally changed register map. But H3/A64/H5 become a new group with
nearly identical register map.

Is it still worth to implement it with the IIO driver? Or should we
start a new thermal sensor-based driver? (For both I have already
local tested code at least for H3)

Thanks,
Icenowy
