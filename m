From: wd@denx.de (Wolfgang Denk)
Date: Fri, 04 May 2012 22:54:41 +0200
Subject: Handling of modular boards
In-Reply-To: <201205042039.25794.arnd@arndb.de>
References: <20120504185850.GO14230@opensource.wolfsonmicro.com>
 <201205041934.08830.arnd@arndb.de>
 <20120504203357.6B79B206451@gemini.denx.de>
 <201205042039.25794.arnd@arndb.de>
Message-ID: <20120504205441.D293120645E@gemini.denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Arnd,

In message <201205042039.25794.arnd@arndb.de> you wrote:
>
> > On the other hand, some of the issues we're trying to solve here
> > for the kernel are also present in the boot loader, so this needs to
> > do this anyway - whether by inserting new or modifying (enabling or
> > disabling) existing properties in the DT is not really relevant here.
> 
> I haven't seen a case where the add-on board is actually required
> for booting. What examples are you thinking of?

There are systems (and I bet it will be a growing number) where U-Boot
itself uses the DT for configuration.  Also, there are functions that
are needed both by the boot loader and the kernel - for example to
dislay a splash screen the boot loader needs to initialize the
display, so it must be able to detect which type of LCD is attached
(resolution, color-depth, orientation) - the device tree comes in very
handy here.  Why should Linux re-do all such things?

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd at denx.de
I must follow the people.  Am I not their leader? - Benjamin Disraeli
