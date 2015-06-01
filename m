From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 01 Jun 2015 20:37:39 +0200
Subject: [PATCH 2/3] edac: Add L3/SoC support to the APM X-Gene SoC EDAC
 driver
In-Reply-To: <20150601183114.GE10169@pd.tnic>
References: <1432937075-16558-1-git-send-email-lho@apm.com>
 <CAPw-ZTm+1hfh4b-opq=HQDek-wc4A4nT=B6DcuyUBWsm8a-ZbQ@mail.gmail.com>
 <20150601183114.GE10169@pd.tnic>
Message-ID: <2884982.Ci49nmtWmA@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 01 June 2015 20:31:14 Borislav Petkov wrote:
> On Mon, Jun 01, 2015 at 10:46:55AM -0700, Loc Ho wrote:
> > You are right... Let me just prints the error code instead. Anyone who
> > care will have to do post processing.
> 
> Don't forget about the usability of the driver. If a user has to go
> open manuals when an error happens, you could just as well report naked
> register values and have a tool decode them.
> 
> And this strategy (mcelog) turned out to be a real PITA, IMO.
> 
> > Future or existent next generation may re-define them.
> 
> You could easily have a strings array of per-family or per-soc error
> descriptions. For an example, take a look at drivers/edac/mce_amd.c
> which decodes MCEs on all relevant AMD machines. This is much more
> user-friendly than dumping register values which most people have no
> idea of where to start looking (and they don't really need to).

That would require having a way to identify the SoC with a distinct
compatible string. I don't know if a name exists for X-Gene that could
be used here.

	Arnd
