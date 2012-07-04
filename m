From: gururaja.hebbar@ti.com (Hebbar, Gururaja)
Date: Wed, 4 Jul 2012 13:43:12 +0000
Subject: How to handle parameter variation across different boards but
 same platform
In-Reply-To: <20120704131749.GZ4111@opensource.wolfsonmicro.com>
References: <1BAFE6F6C881BF42822005164F1491C33EA3532A@DBDE01.ent.ti.com>
 <20120704131749.GZ4111@opensource.wolfsonmicro.com>
Message-ID: <1BAFE6F6C881BF42822005164F1491C33EA35456@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 04, 2012 at 18:47:50, Mark Brown wrote:
> On Wed, Jul 04, 2012 at 12:45:03PM +0000, Hebbar, Gururaja wrote:
> 
> You should fix your mailer to word wrap at less than 80 columns.

Sorry. Stupid outlook. Will take care of it manually.

> 
> > Using machine_is_xxx() is not sufficient because there are 2 other
> > boards on same Platform/machine but with different values.
> 
> > So, how to specify these parameters for the new board?
> 
> What do you mean by "board"?  If these are plugin modules for your
> platform you need to either identify this at runtime and register a
> different machine driver or select at compile time.
> 

By board I mean a new development board. 

New board
sysclk = 24MHz
codec_name = "tlv320aic3x-codec.1-001b"

Previous Board
sysclk = 12MHz
.codec_name = "tlv320aic3x-codec.2-001b",

Both boards share the same machine is API (machine_is_am33xx()).

So, is there any mechanism/api to differentiate these 2 boards inside 
Code?

Has anyone else faced such situation?

Regards, 
Gururaja
