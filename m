From: pratyush.anand@st.com (Pratyush Anand)
Date: Mon, 23 Jun 2014 11:02:49 +0530
Subject: [PATCH v2 0/8] Add Keystone PCIe controller driver
In-Reply-To: <14956334.eDhb2zObBc@wuerfel>
References: <1402426287-31157-1-git-send-email-m-karicheri2@ti.com>
 <53A453D1.4040308@ti.com> <53A46B49.3040009@ti.com>
 <14956334.eDhb2zObBc@wuerfel>
Message-ID: <20140623053249.GD2666@pratyush-vbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jun 21, 2014 at 03:05:30AM +0800, Arnd Bergmann wrote:
> On Friday 20 June 2014 13:11:37 Santosh Shilimkar wrote:

> > > 
> > Arnd suggestion was to have the version 3.65 code in generic place since
> > its IP specific and just in case some other vendor using the same version
> > can leverage the code.

Sorry, I do not follow PCIe mailing list these days, doing something else
now. So coming to this topic a bit delayed.

> > 
> > Concern here seems toe really those name of the files. I can't think of
> > any other appropriate name. 
> 
> We should definitely keep the version in the DT "compatible" strings
> wherever we know it. Regarding a better file name, I have no idea.

In my opinion, we do not need any of dw-v3_65 files, as code in these
files will not be usable by other vendors.

Anything which is implemented in application space, will not be same
across all IP users. For example, MSI0_IRQ_ENABLE_SET has been defined
at offset 0x108 in keystone PCIe application space.Other vendor may
not have this register at the same offset. Moreover, other vendors are
not even obliged to implement MSI Enable signals in same way, so
internal bit definition of the register may change.
      
Therefore code is not reusable if all register offset and bit
definitions are not same across vendors. So, in case of DW driver none
of the code which are accessed using va_app_base should go to common
area.

Regards
Pratyush

> 
> 	Arnd
