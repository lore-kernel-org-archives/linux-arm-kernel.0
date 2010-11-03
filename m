From: david-b@pacbell.net (David Brownell)
Date: Tue, 2 Nov 2010 19:15:16 -0700 (PDT)
Subject: [PATCH v4 08/12] gpio: add ti-ssp gpio driver
In-Reply-To: <1288124308-14999-9-git-send-email-cyril@ti.com>
Message-ID: <956998.65651.qm@web180302.mail.gq1.yahoo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



--- On Tue, 10/26/10, Cyril Chemparathy <cyril@ti.com> wrote:

> From: Cyril Chemparathy <cyril@ti.com>
> Subject: [PATCH v4 08/12] gpio: add ti-ssp gpio driver

On the assumptions you've tested this *AND* will
resubmit with the previously-requested change of
removing all references to non-existent
"virtual"ness in the driver ... I'll likely
add my ack to that resubmitted version

Also, chip2gpio seems an excessively generic name;
maybe chip2_ti_ssp_gpio or somesuch?

I'd still be happier seeing this "stack" packaged
as a hardware library called by various drivers
(like GPIO, SPI, etc) rather than a core driver
that's called by other drivers.  That seems like
a better structure for various vendors' "SSP"
hardware (multifunction serial interface logic)
since most function drivers just need to poke
the registers a bit differently, and don't have
much to share with a "core driver" beyond a few
setup routines (if that).

- Dave
