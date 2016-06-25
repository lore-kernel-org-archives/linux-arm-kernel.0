From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 25 Jun 2016 23:07:43 +0200
Subject: [PATCH 2/2] serial: sirf: make uart register info static
In-Reply-To: <20160625210150.GA3305@kroah.com>
References: <1465322772-26125-1-git-send-email-ben.dooks@codethink.co.uk>
 <1465322772-26125-2-git-send-email-ben.dooks@codethink.co.uk>
 <20160625210150.GA3305@kroah.com>
Message-ID: <8401626.hVVxvI31N9@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday, June 25, 2016 2:01:50 PM CEST Greg Kroah-Hartman wrote:
> On Tue, Jun 07, 2016 at 07:06:12PM +0100, Ben Dooks wrote:
> > The driver does not export the two structures that
> > define the uart register mappings outside of the
> > driver, so make them static to avoid the following
> > warnings:
> > 
> > drivers/tty/serial/sirfsoc_uart.h:124:30: warning: symbol 'sirfsoc_usp' was not declared. Should it be static?
> > drivers/tty/serial/sirfsoc_uart.h:190:30: warning: symbol 'sirfsoc_uart' was not declared. Should it be static?
> > 
> > Note, we don't move these into the driver .c file as this would
> > be a larger change. However they really should not belong in the
> > header file like this.
> 
> Please do the correct thing here and move them into the .c file.

I guess the entire sirfsoc_uart.h file can just get moved in there,
nothing else includes it (obviously, as the symbols above would
otherwise clash).

	Arnd
