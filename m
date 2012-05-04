From: wd@denx.de (Wolfgang Denk)
Date: Fri, 04 May 2012 22:33:57 +0200
Subject: Handling of modular boards
In-Reply-To: <201205041934.08830.arnd@arndb.de>
References: <20120504185850.GO14230@opensource.wolfsonmicro.com>
 <201205041934.08830.arnd@arndb.de>
Message-ID: <20120504203357.6B79B206451@gemini.denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Arnd,

In message <201205041934.08830.arnd@arndb.de> you wrote:
>
> One idea that I've heard before is to put device tree fragments into the
> kernel and dynamically add them to the device tree that was passed by the
> boot loader whenever we detect the presence of a specific device.
> This obviously means it works only for boards using DT for booting, but
> it allows us to use some infrastructure that we already have.
> 
> Another idea was to put all the possible extensions into the device tree
> for a given board and disable them by default, putting it into the
> responsibility of the boot loader to enable the one that is actually
> being used. This has serious scalibility problems when there are many
> possible extensions and also relies more on the boot loader than I would
> like.

On the other hand, some of the issues we're trying to solve here
for the kernel are also present in the boot loader, so this needs to
do this anyway - whether by inserting new or modifying (enabling or
disabling) existing properties in the DT is not really relevant here.


Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd at denx.de
Our business is run on trust.  We trust you will pay in advance.
