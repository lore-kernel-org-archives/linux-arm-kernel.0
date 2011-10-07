From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 7 Oct 2011 12:50:47 +0100
Subject: Long stalls during boot with -next
In-Reply-To: <20110929125035.GA2085@sirena.org.uk>
References: <20110929125035.GA2085@sirena.org.uk>
Message-ID: <20111007115047.GC24534@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 29, 2011 at 01:50:36PM +0100, Mark Brown wrote:
> Since Tuesday I've been experiencing stalls on boot with -next kernels.
> The boot appears to proceed normally but there appears to be a good ten
> second delay somewhere around the late_initcall() stage with no
> indication in the logs:

I identified the problem here, the behaviour of LL_DEBUG was changed to
make it select DEBUG_ICEDCC by default which is unfortunate if one
doesn't have an EmbeddedICE connected.
