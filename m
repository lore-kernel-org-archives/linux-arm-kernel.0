From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Tue, 6 Mar 2012 20:17:12 +0100
Subject: [PATCH v3 02/10] pwm: Allow chips to support multiple PWMs.
In-Reply-To: <201203061538.11709.arnd@arndb.de>
References: <1329923841-32017-1-git-send-email-thierry.reding@avionic-design.de>
 <20120223160420.GA9899@avionic-0098.mockup.avionic-design.de>
 <20120303193249.GA22021@avionic-0098.mockup.avionic-design.de>
 <201203061538.11709.arnd@arndb.de>
Message-ID: <20120306191712.GB13882@avionic-0098.mockup.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Arnd Bergmann wrote:
> On Saturday 03 March 2012, Thierry Reding wrote:
> > I turns out that this is not as easy to do as I thought. The problem is that
> > if I remove the pwmchip_find() from the core and move the lookup
> > functionality into the OF support code I no longer have access to the list of
> > PWM chips. So I guess it will have to stay in to keep things encapsulated
> > properly.
> 
> Well, or you move everything into the one file. If you have the device tree
> support function in the same file as everything else, you no longer need
> the additional complexity.

Okay, I think it makes the most sense to move all of the OF support code into
drivers/pwm/core.c. That way we can also check off the discussion about the
OF support code's location.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120306/09ec7a2e/attachment.sig>
