From: epeer@tmtservices.co.za (Edwin Peer)
Date: Tue, 19 Jan 2010 07:37:59 +0200
Subject: [PATCH - 3rd attempt] ARM: Support for Embedian MXM-8x10 eval kit
In-Reply-To: <4B55400C.1050109@tmtservices.co.za>
References: <201001182134.14226.epeer@tmtservices.co.za>
	<20100118215124.GE8970@buzzloop.caiaq.de>
	<4B55400C.1050109@tmtservices.co.za>
Message-ID: <201001190737.59609.epeer@tmtservices.co.za>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 19 January 2010 07:15:56 Hennie van der Merwe wrote:

> I originally wrote it like this because I wanted the option for the
> machine implementing the MXM-8x10 module to initialise the MMC or not.
> I'm not sure static is appropriate (as it is exported in the header).
> Could we perhaps drop the inline and just  make it a void __init instead?

Indeed, those can't be made static. What I have done is make all the functions 
we call in barebones_init() static and remove their declarations from the 
header, since those are never optional.

> Agreed. This one must have just slipped by... Too much coffee, not
> enough sleep :)

Fixed. I've also corrected what I hope are the last formatting issues and 
fixed one more #include that I somehow missed before.

I'm giving the changes a quick test on the hardware before submitting what I 
hope will be the final patch.

Regards,
Edwin Peer
