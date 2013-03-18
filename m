From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 18 Mar 2013 14:59:10 +0000
Subject: [PATCH v2 for 3.10] Introduce a Marvell EBU MBus driver
In-Reply-To: <51422AD5.9020203@free-electrons.com>
References: <1362589205-4726-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <51422AD5.9020203@free-electrons.com>
Message-ID: <201303181459.10954.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 14 March 2013, Gregory CLEMENT wrote:
> Will you agree to take this patch set as is ?(modulo some fixes needed
> for the not yet tested platforms).
> 
> This patch set is a great step in the right way to move code outside
> arch/arm. I know that Arnd would like a greater step and a more
> radical approach to have a more accurate device tree bindings.
> However the purpose of this patch set was initially to ease the merge
> of the PCIe support not to delay it! And I fear that the large number
> of files to change and the resulting conflicts will prevent this patch
> set to be merged in a single release.
> 
> I agree that the bindings could be improve but can we consider this
> patch set as a first step ?

I would prefer not to merge the DT binding, but I'm fine with the
current implementation, as in the pull request that Jason sent
me. How about this:

* You remove the Documentation/devicetree/bindings/arm/mvebu-mbus.txt file
  that is the main source of disagreement, along with the mvebu_mbus_dt_init
  function.
* All conversion patches get changed to not add properties to the soc
  node but instead call mvebu_mbus_init directly. That code is there
  already.

I can take those patches, and we can work on a better DT binding for
a later release without having to hold up other conversions.

	Arnd
