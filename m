From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 29 Aug 2013 15:45:37 +0200
Subject: [PATCH RFC v2 01/16] ARM: call clk_of_init from time_init
In-Reply-To: <521D2F1F.1070103@gmail.com>
References: <1376964271-22715-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <3837b119-baad-4e68-8805-2bc52c0135f9@DB9EHSMHS031.ehs.local>
 <521D2F1F.1070103@gmail.com>
Message-ID: <201308291545.37520.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 28 August 2013, Sebastian Hesselbarth wrote:
> >
> > This forces zynq to move some initialization our clock code relies on to
> > init_irq(). Also, the current code already takes an approach of
> > doing either common init or machine specific init.
> 
> Soeren,
> 
> you know that patch 16/16 takes care of zynq's clock init?
> 
> It's your own patch you provided from the last RFC. Looking at it, it
> moves  zynq_sclr_init() to .init_irq and removes the call to
> of_clk_init() from zynq_clock_init() which is called by
> zynq_sclr_init().
> 
> Isn't that solving the above issues for mach-zynq?

Please be careful with the patch ordering here. The patch series should
be bisectable, i.e. no patch should ever knowingly break any of the
platforms, with the fix getting added in a later patch.

You should be able to do that by cleaning up all platforms to not
rely on ordering first, then add this patch, and finally remove
the other calls.

	Arnd
