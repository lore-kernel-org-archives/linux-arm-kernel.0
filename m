From: felipe.contreras@gmail.com (Felipe Contreras)
Date: Wed, 15 Dec 2010 14:23:33 +0200
Subject: [PATCH 13/14] OMAP2/3: PRCM: split OMAP2/3-specific PRCM code
	into OMAP2/3-specific files
In-Reply-To: <alpine.DEB.2.00.1012142147040.15971@utopia.booyaka.com>
References: <20101207012242.3708.45451.stgit@twilight.localdomain>
	<20101207012516.3708.87606.stgit@twilight.localdomain>
	<alpine.DEB.2.00.1012142147040.15971@utopia.booyaka.com>
Message-ID: <AANLkTimTtdMeaz=k6H=GQMNTGciJ5uc+GGUnC1RdR_f2@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Dec 15, 2010 at 6:50 AM, Paul Walmsley <paul@pwsan.com> wrote:
> On Mon, 6 Dec 2010, Paul Walmsley wrote:
>
>> In preparation for adding OMAP4-specific PRCM accessor/mutator
>> functions, split the existing OMAP2/3 PRCM code into OMAP2/3-specific
>> files. ?Most of what was in mach-omap2/{cm,prm}.{c,h} has now been
>> moved into mach-omap2/{cm,prm}2xxx_3xxx.{c,h}, since it was
>> OMAP2xxx/3xxx-specific.
>>
>> This process also requires the #includes in each of these files to be
>> changed to reference the new file name. ?As part of doing so, add some
>> comments into plat-omap/sram.c and plat-omap/mcbsp.c, which use
>> "sideways includes", to indicate that these users of the PRM/CM includes
>> should not be doing so.
>
> This patch has been updated to also take care of getting DSPBridge to
> build again. ?Omar, Felipe, could you please take a look at the
> mach-omap2/dsp.c and _tiomap.h changes and ack them?

I would prefer the XX comments in a separate chunk:

/*
 * license notice
 */

/*
 * XXX
 */

But otherwise it's ok.

-- 
Felipe Contreras
