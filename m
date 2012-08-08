From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 8 Aug 2012 10:49:52 +0100
Subject: [PATCH 1/1] Input: ab8500-ponkey: Make the distinction between
 DT and non-DT boots
In-Reply-To: <20120808080411.GB4728@gmail.com>
References: <20120807170333.GV16861@opensource.wolfsonmicro.com>
 <20120808080411.GB4728@gmail.com>
Message-ID: <20120808094952.GH16861@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 08, 2012 at 09:04:12AM +0100, Lee Jones wrote:

> During non-DT boot:
>  - Platform data is passed, which contains an IRQ base
>  - If an IRQ base is requested we use it to register a Legacy IRQ Domain
>  - MFD adds the IRQ base to the hwirq and registers it as a virq

Just don't do this step - the only reason to do it is for mapping back
into a linear domain but if you're going to do this...

>  - AB8500 child devices use *_get_virq() to convert virq to virq - *ERROR*

...then it's redundant.  The mapping functions in the domain code
replace this functionality.
