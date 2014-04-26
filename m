From: jason@lakedaemon.net (Jason Cooper)
Date: Fri, 25 Apr 2014 20:55:16 -0400
Subject: [PATCH v2 00/10] thermal: Armada 375/380 SoC support
In-Reply-To: <1398371004-15807-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1398371004-15807-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <20140426005516.GR28159@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 24, 2014 at 05:23:14PM -0300, Ezequiel Garcia wrote:
> This patchset adds the support for the thermal sensor in the recently
> introduced Armada 375 and 38x SoC. Compared to the previous patchset
> version, this v2 introduces the A380 SoC support.
> 
> The first five patches are preparation work. They add a generic
> infrastructure that allows to support similar thermal sensors in
> a non-intrusive way.
> 
> Patches six and seven uses this infrastructure to support the 
> Armada 375 and 380 SoC thermal sensor.
> 
> Since there are some issues in the Armada 375 Z1 SoC thermal sensor,
> patch eight adds a quirk to workaround such issues. The Z1 silicon stepping
> is detected and the compatible string is updated, so the driver can apply
> sensor initialization workarounds.
> 
> In addition, the quirk moves the offset of the thermal control register,
> and allows to specifiy the correct (A0 stepping) offset in the devicetree.
> This quirk is applied only for the A375-DB board, being the only board known
> to have the problematic Z1 SoC.
> 
> Finally, the last two patches enables the thermal sensor in the devicetree.
> for the Armada 375 A0 stepping SoC, and the Armada 380/385 SoCs.
> 
> The series applies on v3.15-rc1, and has been tested on A375-DB board
> and A385-DB board.
> 
> Feedback and comments are welcome!
> 
> Changes from v1:
> 
>   * Introduced the Armada 380 support. In order to support this in a clean
>     way, the 'inverted' field was added.
> 
>   * Cleaned the A375 workaround in the thermal driver, by detecting the
>     device compatible string, as suggested by Jason Cooper.
> 
>   * Added details about the register offset in the Z1 stepping to the
>     binding documentation as requested by Jason Cooper.
> 
> Ezequiel Garcia (10):
>   thermal: armada: Rename armada_thermal_ops struct
>   thermal: armada: Add infrastructure to support generic formulas
>   thermal: armada: Add generic infrastructure to handle the sensor
>   thermal: armada: Pass the platform_device to init_sensor()
>   thermal: armada: Allow to specify an 'inverted readout' sensor
>   thermal: armada: Support Armada 375 SoC
>   thermal: armada: Support Armada 380 SoC

Thermal series:

Acked-by: Jason Cooper <jason@lakedaemon.net>

>   ARM: mvebu: Add thermal quirk for the Armada 375 DB board

Applied to mvebu/soc

>   ARM: mvebu: Enable the thermal sensor in Armada 375 SoC
>   ARM: mvebu: Enable the thermal sensor in Armada 380/385 SoC

Applied to mvebu/dt

thx,

Jason.
