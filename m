From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 30 Jul 2015 14:31:20 +0100
Subject: [PATCH v2 3/6] mailbox: Add support for ST's Mailbox IP
In-Reply-To: <1438260522.25464.12.camel@tiscali.nl>
References: <1437990272-23111-1-git-send-email-lee.jones@linaro.org>
 <1437990272-23111-4-git-send-email-lee.jones@linaro.org>
 <1438121215.30903.27.camel@tiscali.nl> <20150730114545.GG14642@x1>
 <1438260522.25464.12.camel@tiscali.nl>
Message-ID: <20150730133120.GA3208@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 30 Jul 2015, Paul Bolle wrote:

> On do, 2015-07-30 at 12:45 +0100, Lee Jones wrote:
> > On Wed, 29 Jul 2015, Paul Bolle wrote:
> > > Besides, if I read sti_max_probe() correctly, without OF support
> > > loading
> > > this module won't accomplish much. So what would another way of
> > > autoloading this module buy you?
> > 
> > I think this line can be safely removed.
> 
> Looking at this patch a little more I notice there's no line reading
>      MODULE_DEVICE_TABLE(of, sti_mailbox_match);
> 
> The three mailbox drivers that currently support OF do have such a line.
> So "another way of autoloading" was rather sloppy as now I don't see how
> this driver, if build as a module, will get auto-loaded. Maybe there's
> an auto-loading mechanism that I'm not aware of here. Or perhaps auto
> -loading is not needed.
> 
> Similar question for patch 5/6 and the lack of a line reading
>     MODULE_DEVICE_TABLE(of, mbox_test_match);

Yes, both of those lines should be present.

FYW, I don't test these drivers as modules and have no desire to.  I
always build everything into a single kernel binary, so any feedback
regarding the module enabling code is appreciated.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
