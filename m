From: eric.y.miao@gmail.com (Eric Miao)
Date: Wed, 14 Apr 2010 06:47:49 +0800
Subject: [PATCH 1/2] [ARM] pxa: add minimal ULPI functionality for USB
	host port 2 on PXA310.
In-Reply-To: <20100413220642.GW30801@buzzloop.caiaq.de>
References: <cover.1270651775.git.grinberg@compulab.co.il>
	<fa93111b71cf1e43eef23869466072be4db67bcd.1270651775.git.grinberg@compulab.co.il>
	<20100413220642.GW30801@buzzloop.caiaq.de>
Message-ID: <q2of17812d71004131547n8a2384b5ta345e70997017acb@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 14, 2010 at 6:06 AM, Daniel Mack <daniel@caiaq.de> wrote:
> On Wed, Apr 07, 2010 at 06:05:22PM +0300, Igor Grinberg wrote:
>> Signed-off-by: Igor Grinberg <grinberg@compulab.co.il>
>> Signed-off-by: Mike Rapoport <mike@compulab.co.il>
>> ---
>> ?arch/arm/mach-pxa/Makefile ? ? ?| ? ?1 +
>> ?arch/arm/mach-pxa/pxa310-ulpi.c | ?240 +++++++++++++++++++++++++++++++++++++++
>> ?arch/arm/mach-pxa/pxa310-ulpi.h | ? 85 ++++++++++++++
>> ?3 files changed, 326 insertions(+), 0 deletions(-)
>> ?create mode 100644 arch/arm/mach-pxa/pxa310-ulpi.c
>> ?create mode 100644 arch/arm/mach-pxa/pxa310-ulpi.h
>
> The USB OTG/ULPI framework could well be reused for that I think. All
> that you would need is a struct otg_io_access_ops with two function
> pointers to read and write registers. Then you can use otg_ulpi_create()
> to set up an ULPI compliant device connected to the bus.
>

Right, that's what I'm thinking as well esp. since ULPI is a standard
(ok, kinds of) and I'm not seeing too much specialty of pxa3xx ULPI
except for the way to access registers. Cannot remember the detail
but the OTG might be a hybrid model on pxa310, and might be a
little bit different from others.
