From: robh@kernel.org (Rob Herring)
Date: Wed, 19 Apr 2017 19:12:42 -0500
Subject: [PATCH v3 00/21] eeprom: at24: Add OF device ID table
In-Reply-To: <20170414010445.21727-1-javier@osg.samsung.com>
References: <20170414010445.21727-1-javier@osg.samsung.com>
Message-ID: <20170420001242.vl3sga2bd65jlaoi@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 13, 2017 at 10:04:24PM -0300, Javier Martinez Canillas wrote:
> Hello Wolfram,
> 
> This series is a follow-up to patch [0] that added an OF device ID table
> to the at24 EEPROM driver. As you suggested [1], this version instead of
> adding entries for every used <vendor,device> tuple, only adds a single
> entry for each chip type using the "atmel" vendor as a generic fallback.
> 
> The first patch adds the OF device ID table for the at24 driver and the
> next patches adds a generic fallback compatible string to each DTS that
> defines a compatible I2C EEPROM device node.
> 
> Patches can be applied independently since the DTS change without the
> driver change is a no-op and the OF device table won't be used without
> the DTS changes.
> 
> [0]: https://lkml.org/lkml/2017/3/14/589

I don't have this patch in my inbox, but the i2c core will still match 
on compatibles with no vendor prefix? If not, those need to be added to 
the match table too.

Rob
