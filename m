From: wsa@the-dreams.de (Wolfram Sang)
Date: Tue, 2 Dec 2014 14:16:11 +0100
Subject: [PATCH 3/4] devicetree: bindings: Add defeature-repeated-start
 property for Cadence I2C
In-Reply-To: <CAFcVECJwFoFd6GrmF282CG+fELnYb=FNCTDq=RYKky_dHha=Jg@mail.gmail.com>
References: <1417514749-24319-1-git-send-email-harinik@xilinx.com>
 <1417514749-24319-4-git-send-email-harinik@xilinx.com>
 <20141202111907.GC23671@leverpostej>
 <CAFcVECLtPx6shBXJbg9Uf_8fnhkMoO1zpoxGcdda7PSA7z_2rA@mail.gmail.com>
 <20141202125203.GA4072@katana>
 <CAFcVECJwFoFd6GrmF282CG+fELnYb=FNCTDq=RYKky_dHha=Jg@mail.gmail.com>
Message-ID: <20141202131611.GC4072@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> But given the bugs, it will be useful to just disable it if the system doesn't
> require repeated start.

What do you do when disable repeated start? Sending STOP and START? If
so, this is really something different than repeated start. By using
I2C_FUNC_I2C a user expects repeated start, so if the HW does not
support it, we should say so and don't try to emulate it with something
different.

> If you think DT entry is not the way to go, do you think a CONFIG option or
> something better will work?

No, check at runtime if the transfer is possible on this HW. Bail out if
not.

> We chose a DT property because there is a good chance the user has multiple
> cadence I2C controllers - one connected to a slave that needs repeated start
> (like a power controller) and another that doesn't care.

The user should not need to know with this level of detail if we can
avoid it IMO.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141202/f108c6a4/attachment.sig>
