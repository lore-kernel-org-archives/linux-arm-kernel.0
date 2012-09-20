From: wd@denx.de (Wolfgang Denk)
Date: Thu, 20 Sep 2012 19:09:28 +0200
Subject: [PATCH] ARM: mxs: m28evk: Disable OCOTP OUI loading
In-Reply-To: <CADx9zJCnQCnGgvO6ui7m1buAt2S+OPyQVgyEBwt-u2ARcqh94Q@mail.gmail.com>
References: <1348007837-23187-1-git-send-email-marex@denx.de>
 <201209201420.55526.marex@denx.de> <20120920125631.GC2609@pengutronix.de>
 <201209201510.24631.marex@denx.de> <505B1FC2.2090609@free-electrons.com>
 <20120920151021.7307C203A17@gemini.denx.de>
 <CADx9zJCnQCnGgvO6ui7m1buAt2S+OPyQVgyEBwt-u2ARcqh94Q@mail.gmail.com>
Message-ID: <20120920170928.1E558203A0C@gemini.denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Gregory,

In message <CADx9zJCnQCnGgvO6ui7m1buAt2S+OPyQVgyEBwt-u2ARcqh94Q@mail.gmail.com> you wrote:
>
> > With device tree supoort enabled, the regular way to pass the MAC
> > address to a network interface (that needs one) is through the device
> > tree.
...
> I thought that device tree should provide information that we can't get
> by the hardware itslef. Here, if the hardware can provide the MAC address,
> why should we ignore it?

That was the "that needs one" part above.

Yet, using the DT is still the generic way to do this, and should be
fully supported.  And assuming there might be simple bootloaders (like
bootlets) that are not capable to write such data to any device
specific storage, this should probably even be the default.

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd at denx.de
Mirrors should reflect a little before throwing back images.
- Jean Cocteau
