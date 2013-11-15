From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 15 Nov 2013 22:05:00 +0100
Subject: [PATCH v2] ARM: remove name from machine_desc for DT platforms
In-Reply-To: <CAL_Jsq+3NgWHEjtZO-Dwsf-Xc2wbMP9e8z5yc-HbviDQhRuBZQ@mail.gmail.com>
References: <1383511801-31682-1-git-send-email-robherring2@gmail.com>
 <20131115191359.GS16735@n2100.arm.linux.org.uk>
 <CAL_Jsq+3NgWHEjtZO-Dwsf-Xc2wbMP9e8z5yc-HbviDQhRuBZQ@mail.gmail.com>
Message-ID: <201311152205.00914.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 15 November 2013, Rob Herring wrote:
> I was referring only to DT enabled machine_desc's. I don't think we'll
> touch non-DT machine_desc's. An example is combining several per SoC
> DT based machine_desc's into a single SoC family machine_desc.
> Ideally, we'd get rid of the machine_desc altogether, but that may not
> be possible.

Right. We may be able to make some fields of the machine_desc
#ifdef CONFIG_ATAGS at some point, but I think we will have legacy
platforms needing machine_desc callbacks for a very long time.

A different question is what to do about new hardware support.
I'm somewhat optimistic that at some point we can mandate that
new machines should no longer require a machine_desc, just
as we already require for ARM64.

	Arnd
