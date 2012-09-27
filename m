From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 27 Sep 2012 09:42:42 -0300
Subject: DA9053 support on mx53qsb
In-Reply-To: <3551104.eUMCmD9aXl@wuerfel>
References: <CAOMZO5BGGOJCVrF_NZP+gXg7wfKnKv7287Xqo=J_NfsMc=HeDg@mail.gmail.com>
 <3551104.eUMCmD9aXl@wuerfel>
Message-ID: <CAOMZO5C5o2QWUR0n8c4rgGVf0eD8veqwvy5URMzN9GHOLEqWBQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On Wed, Sep 26, 2012 at 5:04 PM, Arnd Bergmann <arnd@arndb.de> wrote:

> Maybe the pmic device gets created from DT before the GPIO controller
> registers the IRQ domain.

I managed to fix the issue. The problems were:

- Registration of the da9052: https://lkml.org/lkml/2012/9/26/551

- The imx53-qsb.dts was missing to register the IRQ GPIO and was not
keeping the power supplies on. Patch sent to the list.

Regards,

Fabio Estevam
