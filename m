From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 6 Nov 2009 18:36:06 +0000
Subject: [PATCH] Allow platforms to control which PXA uarts are registered
In-Reply-To: <200911061742.06476.schindele@nentec.de>
References: <20091105141337.GB21681@n2100.arm.linux.org.uk>
	<200911061742.06476.schindele@nentec.de>
Message-ID: <20091106183606.GA14557@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 06, 2009 at 06:42:06PM +0200, Juergen Schindele wrote:
> Dear Russell,
> this is a good idea because not all PXA based designs use all
> of the available uarts. 
> I think it would be even better if you could give the order of the
> UARTS at the same time in the platform initialisation.

No.  We did that with SA11x0 CPUs and it turned into a mess - it
became very difficult to sort out "my ttySA1 doesn't work" problems
because no one knew what port ttySA1 actually corresponded with.
