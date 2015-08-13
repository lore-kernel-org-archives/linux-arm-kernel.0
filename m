From: LW@KARO-electronics.de (Lothar =?UTF-8?B?V2HDn21hbm4=?=)
Date: Thu, 13 Aug 2015 10:41:50 +0200
Subject: [PATCH v3 1/4] edac: Add an function to retrieve the EDAC
 debugfs node
In-Reply-To: <20150813081537.GB20004@nazgul.tnic>
References: <1439326077-25507-1-git-send-email-lho@apm.com>
 <1439326077-25507-2-git-send-email-lho@apm.com>
 <20150812101219.GC14011@nazgul.tnic>
 <20150812104954.GD14011@nazgul.tnic>
 <CAPw-ZT=AFtyLt4CNGBzLZcdPr-ekJpQxKA4Y_AiDzqKfhF1-=w@mail.gmail.com>
 <CAPw-ZTkfAxqG6HQHU3WomrqRwXa+jyTWCg=ns1HKC323ds1yug@mail.gmail.com>
 <20150813081537.GB20004@nazgul.tnic>
Message-ID: <20150813104150.2c084a8c@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

> On Wed, Aug 12, 2015 at 09:30:58PM -0700, Loc Ho wrote:
> > Okay... The 'inline' helps with the compiler warning. If I move all to
> > header file with 'static inline' and wrapper around CONFIG_EDAC_DEBUG,
> > don't I need to export and declare the variable 'edac_debugfs'? Are
> > you okay with export this variable?
> 
> You need to make edac_debugfs extern in the header and define it in
> edac_mc_sysfs.c.
> 
> But that's ok because edac_core.h will be included only by EDAC drivers
> and they're supposed to see edac_debugfs anyway...
> 
What's the point in having an accessor function that returns a driver
internal variable when this variable is exported anyway?
This will only further inconsistencies because half of the users will
use the variable directly and the other half will use the accessor
function.


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
