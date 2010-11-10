From: david-b@pacbell.net (David Brownell)
Date: Tue, 9 Nov 2010 22:16:22 -0800 (PST)
Subject: [PATCH v4 08/12] gpio: add ti-ssp gpio driver
In-Reply-To: <20101110044530.GB4110@angua.secretlab.ca>
Message-ID: <79124.87409.qm@web180307.mail.gq1.yahoo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> I thought the point of this device was that a single [SSP] device
> hosted a
> pair of multi-function serial interfaces, with each
> implementing a
> separate function.

function chosen based on what the board needs.
Codec interface, SPI, GPIO, etc.

? If so, then it makes sense for the
> base driver to
> register child devices of the appropriate kinds.

I'd normally say board setup registers them; a
"core"driver can't know what children would be needed.

But the point I was making was about code factoring
not driver setup.  When  the functions don't have
much commonality, they might as well just write to
the relevant registers instead of expecting to have
a non-register programming interface (of dubious
generality of a "core" driver, but much complexity).

Easier just to have children use registers directly,
in several similar cases.  Less overhead, too.

- Dave
