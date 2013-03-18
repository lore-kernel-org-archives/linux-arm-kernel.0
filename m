From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 18 Mar 2013 16:24:11 +0100
Subject: [PATCH v2 for 3.10] Introduce a Marvell EBU MBus driver
In-Reply-To: <201303181459.10954.arnd@arndb.de>
References: <1362589205-4726-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <51422AD5.9020203@free-electrons.com>
 <201303181459.10954.arnd@arndb.de>
Message-ID: <20130318162411.11c9e3ab@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Arnd Bergmann,

On Mon, 18 Mar 2013 14:59:10 +0000, Arnd Bergmann wrote:

> I would prefer not to merge the DT binding, but I'm fine with the
> current implementation, as in the pull request that Jason sent
> me. How about this:
> 
> * You remove the Documentation/devicetree/bindings/arm/mvebu-mbus.txt file
>   that is the main source of disagreement, along with the mvebu_mbus_dt_init
>   function.
> * All conversion patches get changed to not add properties to the soc
>   node but instead call mvebu_mbus_init directly. That code is there
>   already.
> 
> I can take those patches, and we can work on a better DT binding for
> a later release without having to hold up other conversions.

So even the DT-only sub-architecture (such as mvebu) should hard-code
the register base addresses?

The proposed DT binding in the current patch is very minimal, and I
don't see why the more elaborate DT binding that you proposed could not
be implemented as an improvement of it: the DT binding you proposed
seems backward compatible with the one currently implemented, no?

Anyway, whatever your decision is, I can submit an updated patch set
that implements this, and also fix the mv78xx0 patch (my colleague
Gregory Clement found a problem with the mv78xx0 when testing on real
hardware).

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
