From: olof@lixom.net (Olof Johansson)
Date: Mon, 19 Dec 2011 21:29:26 -0800
Subject: [GIT PULL v2] at91: drivers for 3.3
In-Reply-To: <4EEB388A.1040906@atmel.com>
References: <4EEA0DF6.3050408@atmel.com>
	<4EEB388A.1040906@atmel.com>
Message-ID: <CAOesGMgQVRRCURQ_Lxx21igq9RecMHo3Kz4Jx286Spp3500FPQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Nicolas, Jean-Christophe,

On Fri, Dec 16, 2011 at 4:24 AM, Nicolas Ferre <nicolas.ferre@atmel.com> wrote:

> Jean-Christophe PLAGNIOL-VILLARD (1):
> ? ? ?net/macb: add DT support for Cadence macb/gem driver


This patch breaks build for non-OF configs. I hit this at least with
afeb9260_defconfig, at91cap9_defconfig and at91sam9263_defconfig.
Still building other defconfigs:

drivers/net/ethernet/cadence/macb.c:1503: error: implicit declaration
of function 'of_match_ptr'
drivers/net/ethernet/cadence/macb.c:1503: error: 'macb_dt_ids'
undeclared here (not in a function)
drivers/net/ethernet/cadence/macb.c:1503: error: initializer element
is not constant
drivers/net/ethernet/cadence/macb.c:1503: error: (near initialization
for 'macb_driver.driver.of_match_table')


-Olof
