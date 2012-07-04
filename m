From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 4 Jul 2012 15:01:18 +0100
Subject: How to handle parameter variation across different boards but
 same platform
In-Reply-To: <1BAFE6F6C881BF42822005164F1491C33EA35456@DBDE01.ent.ti.com>
References: <1BAFE6F6C881BF42822005164F1491C33EA3532A@DBDE01.ent.ti.com>
 <20120704131749.GZ4111@opensource.wolfsonmicro.com>
 <1BAFE6F6C881BF42822005164F1491C33EA35456@DBDE01.ent.ti.com>
Message-ID: <20120704140118.GA4111@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 04, 2012 at 01:43:12PM +0000, Hebbar, Gururaja wrote:
> On Wed, Jul 04, 2012 at 18:47:50, Mark Brown wrote:

> > What do you mean by "board"?  If these are plugin modules for your
> > platform you need to either identify this at runtime and register a
> > different machine driver or select at compile time.

> By board I mean a new development board. 

> New board
> sysclk = 24MHz
> codec_name = "tlv320aic3x-codec.1-001b"

> Previous Board
> sysclk = 12MHz
> .codec_name = "tlv320aic3x-codec.2-001b",

> Both boards share the same machine is API (machine_is_am33xx()).

> So, is there any mechanism/api to differentiate these 2 boards inside 
> Code?

> Has anyone else faced such situation?

If these are totally different boards they should have different machine
IDs set so machine_is_() should identify.  If that isn't there then you
need to do something custom to your products to identify the boards
further.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120704/6089f919/attachment.sig>
