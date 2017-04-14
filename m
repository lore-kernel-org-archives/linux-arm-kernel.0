From: andrew.smirnov@gmail.com (Andrey Smirnov)
Date: Fri, 14 Apr 2017 07:33:49 -0700
Subject: [PATCH 3/8] ARM: dts: imx7s: Adjust anatop-enable-bit for
 'reg_1p0d'
In-Reply-To: <20170414032853.GF14915@dragon>
References: <20170413133242.5068-1-andrew.smirnov@gmail.com>
 <20170413133242.5068-4-andrew.smirnov@gmail.com>
 <20170414032853.GF14915@dragon>
Message-ID: <CAHQ1cqFpc5fqa5MvZ6sMyr-Q_ZbBsLvbatrNpV3Y_G1sogc=FA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 13, 2017 at 8:28 PM, Shawn Guo <shawnguo@kernel.org> wrote:
> On Thu, Apr 13, 2017 at 06:32:37AM -0700, Andrey Smirnov wrote:
>> In PMU_REG_1P0Dn ENABLE_LINREG is bit 0. Bit 31 is called OVERRIDE and
>> it serves the function of granting permission to GPC IP block to alter
>> various bit-fields of the register. The reason why this property, that
>> trickeld here from Freescale BSP, is set to 31 is because in the code
>> it came from it is used in conjunction with a notifier handler for
>> REGULATOR_EVENT_PRE_DO_ENABLE and REGULATOR_EVENT_PRE_DO_DISABLE
>> events (not found in upstream kernel) that triggers GPC to start
>> manipulating aforementioned other bitfields.
>>
>> Since:
>>       a) none of the aforementioned machinery is implemented by
>>          upstream
>>       b) using 'anatop-enable-bit' in that capacity is a bit of a
>>          semantic stretch
>>
>> simplify the situation by setting the value of 'anatop-enable-bit' to
>> point to ENABLE_LINREG (same as i.MX6).
>>
>> Cc: yurovsky at gmail.com
>> Cc: Sascha Hauer <kernel@pengutronix.de>
>> Cc: Fabio Estevam <fabio.estevam@nxp.com>
>> Cc: Rob Herring <robh+dt@kernel.org>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Cc: Russell King <linux@armlinux.org.uk>
>> Cc: devicetree at vger.kernel.org
>> Cc: linux-kernel at vger.kernel.org
>> Cc: linux-arm-kernel at lists.infradead.org
>> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
>
> Since patch 1 ~ 3 are all about adding anatop-enable-bit, can we squash
> them into one patch?

OK. Will do in v2.
