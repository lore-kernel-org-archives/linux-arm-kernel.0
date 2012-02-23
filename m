From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Thu, 23 Feb 2012 17:04:20 +0100
Subject: [PATCH v3 02/10] pwm: Allow chips to support multiple PWMs.
In-Reply-To: <201202231407.12981.arnd@arndb.de>
References: <1329923841-32017-1-git-send-email-thierry.reding@avionic-design.de>
 <201202221634.45159.arnd@arndb.de>
 <20120223081235.GC8621@avionic-0098.mockup.avionic-design.de>
 <201202231407.12981.arnd@arndb.de>
Message-ID: <20120223160420.GA9899@avionic-0098.mockup.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Arnd Bergmann wrote:
> On Thursday 23 February 2012, Thierry Reding wrote:
> > > Is this only used for the device tree functions? If so, I would recommend
> > > making it less generic and always search for a device node.
> > 
> > It is currently only used to look up a struct pwm_chip for a given struct
> > device_node, yes. But I can see other uses for this. For instance this could
> > be useful if we ever want to provide an alternative way of requesting a PWM
> > on a per-chip basis.
> 
> Nah, just keep it simple for now. If we need it later, we can still
> add something like this back, but for now it's just a source of
> confusion and possible bugs.

Will do.

> > I was again basically looking at gpiolib for inspiration (maybe I should stop
> > doing that :-). Maybe gpiolib should be reworked to use seq_file's iterator
> > interface as well? Just in case anybody else turns to gpiolib for
> > inspiration.
> 
> Good idea. Would you be able to send a patch for that, too? I would guess
> converting both at the same time would be easier for you than splitting
> the work between two people.

I'll take a shot at it. It may take some time, though.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120223/bf3ef144/attachment.sig>
