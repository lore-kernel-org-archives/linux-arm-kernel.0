From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Thu, 8 Jul 2010 23:10:33 +0300
Subject: [PATCH 11/15] wireless: wl1271: introduce platform device support
In-Reply-To: <alpine.LFD.2.00.1007061316010.6020@xanadu.home>
References: <1278376666-3509-1-git-send-email-ohad@wizery.com>
	<1278376666-3509-12-git-send-email-ohad@wizery.com>
	<4C32EF19.1000604@nokia.com>
	<AANLkTintIz-N7MwwtqhVq2LR3Ln5JTNYSbJUBSSClcA-@mail.gmail.com>
	<4C3306F4.8060907@nokia.com>
	<AANLkTin5W52fPzWToRrAzm56SLZI-taSuI16rCEhLWqH@mail.gmail.com>
	<4C333E0D.2070601@nokia.com>
	<alpine.LFD.2.00.1007061316010.6020@xanadu.home>
Message-ID: <AANLkTin7jIAIiN_JHMxX74K-EBDtDNwUQMlIf4C6RCHD@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Nicolas and Roger,

On Tue, Jul 6, 2010 at 8:42 PM, Nicolas Pitre <nico@fluxnic.net> wrote:
> On Tue, 6 Jul 2010, Roger Quadros wrote:
> > If the Power enable GPIO can be treated as SDIO slot supply (i.e. vmmc), then
> > the SDIO/MMC core should tackle it, just like it deals with supply for slots
> > with removable cards.
>
...
> Another function pair would be needed instead, which would do almost
> like the suspend/resume code is already doing.  Something like:

Thanks a lot for your review and comments, and for taking the time to
present your approach.

I like it !

It'd allow us to lose the software (or fake if you want ;) card detect
mechanism, which is something that should have been added to each
platform we wanted to support.

We would only need to make it possible to deliver board-specific data
to the function driver (e.g., in the case of the wl1271, we need irq
and board_ref_clock data).  That would require some board-level
platform-data configuration, which will be specific to the controller
to which the device is hardwired to. This data should propagate
through the host controller to the SDIO core so it would eventually be
accessible by the function driver (e.g. via func->dev.pdata).

We'll adapt and post follow-up patches.

Thanks again,
Ohad.
