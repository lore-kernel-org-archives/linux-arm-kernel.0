From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 03 Jun 2014 17:05:36 +0200
Subject: [E1000-devel] ARM support for igb driver
In-Reply-To: <538DE069.5030804@codethink.co.uk>
References: <CAHH3p5KAwyMOY=ai_h0eM+JwYLtTO8d4jVaVOWVtOakhqPRTew@mail.gmail.com>
 <536800A8.7090801@intel.com> <538DE069.5030804@codethink.co.uk>
Message-ID: <4294251.h9ODuG21v5@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 03 June 2014 15:49:13 Ben Dooks wrote:
> On 05/05/14 22:20, Alexander Duyck wrote:
> > On 05/05/2014 01:38 PM, Thomas Petazzoni wrote:
> > 
> > Glad to hear that this is working on your ARM platform as expected.
> > 
> > I believe the issue Shiv is having is due to a problem with the specific
> > platform as the IGB device is reporting a Data Link Protocol error via
> > AER and I believe this is what is causing his platform issues.  On
> > enabling BME the device is likely signalling a Fatal Error message in
> > response to the DLP error.  The original error he was seeing was:
> > 
> > Unhandled fault: imprecise external abort (0x1406) at 0x00000000
> 
> I should sort out making these errors non-fatal to the system, there's
> not really much point in killing a process that may not have been the
> initiator of the problem.

We really shouldn't catch those errors system-wide, it belongs into
the specific host bridge driver, but Shiv refuses to say which one that
is, so we can't fix it.

	Arnd
