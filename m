From: jhovold@gmail.com (Johan Hovold)
Date: Mon, 8 Apr 2013 10:46:18 +0200
Subject: [RFC 1/5] ARM: at91: add general purpose backup register (GPBR)
 support
In-Reply-To: <20130408073329.GO20693@game.jcrosoft.org>
References: <20130407150938.GA25605@localhost>
 <1365347572-14972-1-git-send-email-jhovold@gmail.com>
 <20130408073329.GO20693@game.jcrosoft.org>
Message-ID: <20130408084618.GB25605@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 08, 2013 at 09:33:29AM +0200, Jean-Christophe PLAGNIOL-VILLARD wrote:
> On 17:12 Sun 07 Apr     , Johan Hovold wrote:
> > 
> > Add General Purpose Backup Register (GPBR) support.
> > 
> > Most at91 SoCs have at least four 32-bit General Purpose Backup
> > Registers (GPBR) powered by backup-power (VDDBU). One such register is
> > currently used by rtc-at91sam9 driver to store the RTC time base.
> > 
> > Make sure the registers are mapped by arch setup code and add generic
> > accessors for in-kernel use.
> > 
> > This is a step in adding device-tree support to the rtc-at91sam9 driver.
> > 
> This is a regression
> 
> we loose the tracking of what request and use the GPBR

Implementing the GPBR accessors using a simple global resource was one
quick way forward to decouple and generalise the GPBR. Of course, this
could be turned into a more elaborate framework or driver where
registers are requested and released by other drivers and possibly also
by user-space.

Thanks,
Johan
