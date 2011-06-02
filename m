From: wd@denx.de (Wolfgang Denk)
Date: Thu, 02 Jun 2011 17:46:59 +0200
Subject: i.MX consolidation patches
In-Reply-To: <BANLkTi=HqEBRzyU4_HXnNHTeOPL9vPW8PA@mail.gmail.com>
References: <1305823648-2428-1-git-send-email-s.hauer@pengutronix.de>
	<20110530075745.GA31492@S2100-06.ap.freescale.net>
	<20110601123522.GE23771@pengutronix.de>
	<20110601134749.GI3660@n2100.arm.linux.org.uk>
	<20110601141847.GG23771@pengutronix.de>
	<20110601210855.663A3CEFB4E@gemini.denx.de>
	<BANLkTi=HqEBRzyU4_HXnNHTeOPL9vPW8PA@mail.gmail.com>
Message-ID: <20110602154659.697EFD09481@gemini.denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Matt,

In message <BANLkTi=HqEBRzyU4_HXnNHTeOPL9vPW8PA@mail.gmail.com> you wrote:
>
> In this case, just a load address in the uImage header of 0 (or some
> other totally-impossible value like 0xffffffff
> in case 0 is perfectly valid somewhere) and then just jump to the
> entry point by deriving the value from the
> header size - based on the fact that ARM images are PIC and the Linux
> kernel always puts the entry point
> at 0 offset - to the address of the uImage header + size of the uImage
> header (which U-Boot knows already
> from parsing the header).

I'm not a friend of using magic values that are "totally-impossible".
This is confusing, and here it is not needed.

If we could agree to interpret load address and entry point as
offsets, the only remaining problem is to find out if we can use a
common offset.

> So the solution is
> 
> * Assuming all ARM kernels are PIC (guaranteed, right?)
> * Assuming all ARM kernels start at entry point 0 (true for Image and zImage)

You mean offset 0 to the start of the image here.

> * Assuming there is a globally invalid magic value you can set in the
> uImage header as load address (not sure)

I dislike this.

> Set that magic value, U-Boot magically derives the correct entry point
> as the first address of the payload,
> and jumps to it?

That means you would not want to encode a load address in the image,
and always run from the current location, no matter where it is?

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd at denx.de
Power is danger.
	-- The Centurion, "Balance of Terror", stardate 1709.2
