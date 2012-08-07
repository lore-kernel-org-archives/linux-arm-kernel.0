From: hs@denx.de (Heiko Schocher)
Date: Tue, 07 Aug 2012 16:35:16 +0200
Subject: [PATCH v7] ARM: davinci: i2c: add OF support
In-Reply-To: <1343632872-25896-1-git-send-email-hs@denx.de>
References: <1343632872-25896-1-git-send-email-hs@denx.de>
Message-ID: <502127A4.2040505@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On 30.07.2012 09:21, Heiko Schocher wrote:
> add of support for the davinci i2c driver.
>
> Signed-off-by: Heiko Schocher<hs@denx.de>
> Signed-off-by: Sekhar Nori<nsekhar@ti.com>
> Cc: davinci-linux-open-source at linux.davincidsp.com
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: devicetree-discuss at lists.ozlabs.org
> Cc: linux-i2c at vger.kernel.org
> Cc: Ben Dooks<ben-linux@fluff.org>
> Cc: Wolfram Sang<w.sang@pengutronix.de>
> Cc: Grant Likely<grant.likely@secretlab.ca>
> Cc: Sekhar Nori<nsekhar@ti.com>
> Cc: Wolfgang Denk<wd@denx.de>
> Cc: Sylwester Nawrocki<s.nawrocki@samsung.com>
>
> ---
> - changes for v2:
> - add comments from Sylwester Nawrocki<s.nawrocki@samsung.com>:
>    - use "cell-index" instead "id"
>    - OF_DEV_AUXDATA in the machine code, instead pre-define platform
>      device name
> - add comment from Grant Likely:
>    - removed "id" resp. "cell-index" completely
>    - fixed documentation
>    - use of_match_ptr()
>    - use devm_kzalloc() for allocating plattform data mem
>    - fixed a whitespace issue
> - no changes for v3
> - changes for v4
>    remove "pinmux-handle" property as discussed here:
>    http://www.spinics.net/lists/arm-kernel/msg175701.html
>    with Nori Sekhar
>
> - changes for v5
>    add comments from Grant Likely:
>    - do not change value of dev->dev->platform_data, instead
>      hold a copy in davinci_i2c_dev.
>
> - changes for v6:
>    add comments from Sekhar Nori:
>    - removed unneccessary include
>    - merge patch from Sekhar Nori:
>      setup the newly introduced dev->pdata member correctly once in
>      probe ->  i2c_get_plattformdata(() not needed, remove a lot of
>      checks for pdata in code
>    - add Signed-off-by: Sekhar Nori<nsekhar@ti.com>
>    - patch no longer in patchserie, as it has no dependencies.
>
> - changes for v7:
>    add comments from Wolfram Sang:
>    - move Documentation/devicetree/bindings/arm/davinci/i2c.txt
>      to Documentation/devicetree/bindings/i2c/davinci.txt
>    - remove bus-delay property
>
>   Documentation/devicetree/bindings/i2c/davinci.txt |   28 ++++++++++++
>   drivers/i2c/busses/i2c-davinci.c                  |   48 ++++++++++++++++-----
>   2 files changed, 65 insertions(+), 11 deletions(-)
>   create mode 100644 Documentation/devicetree/bindings/i2c/davinci.txt

ping ... any comments?

bye,
Heiko
-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
