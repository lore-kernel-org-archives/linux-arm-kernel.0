From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 16 Sep 2014 16:57:38 +0100
Subject: [PATCH 3.17-rc4 v6 2/6] arm: fiq: Replace default FIQ handler
In-Reply-To: <54176F7C.6030908@linaro.org>
References: <1410695835-10496-1-git-send-email-daniel.thompson@linaro.org>
 <1410695835-10496-3-git-send-email-daniel.thompson@linaro.org>
 <54176F7C.6030908@linaro.org>
Message-ID: <20140916155738.GI12361@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 16, 2014 at 12:00:12AM +0100, Daniel Thompson wrote:
> On 14/09/14 12:57, Daniel Thompson wrote:
> > This patch introduces a new default FIQ handler that is structured in a
> > similar way to the existing ARM exception handler and result in the FIQ
> > being handled by C code running on the SVC stack (despite this code run
> > in the FIQ handler is subject to severe limitations with respect to
> > locking making normal interaction with the kernel impossible).
> > 
> > This default handler allows concepts that on x86 would be handled using
> > NMIs to be realized on ARM.
> > 
> > Credit:
> > 
> >     This patch is a near complete re-write of a patch originally
> >     provided by Anton Vorontsov. Today only a couple of small fragments
> >     survive, however without Anton's work to build from this patch would
> >     not exist. Thanks also to Russell King for spoonfeeding me a variety
> >     of fixes during the review cycle.
> 
> I've send this patch to the your patch tracker as complete respin (#8150/2).
> 
> If you'd rather handle it as a follow on patch please let me know and I
> will prepare it as one.

Thanks, as you will see, I've merged this patch, along with my two
patches, one removing do_unexp_fiq() and the newline removal in
show_regs().  They should be appearing in a linux-next rsn.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
