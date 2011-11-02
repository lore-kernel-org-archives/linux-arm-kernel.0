From: will.deacon@arm.com (Will Deacon)
Date: Wed, 2 Nov 2011 10:24:10 +0000
Subject: AT91 reboot code
In-Reply-To: <CAFumwP2m7=QsMTGAafPJs2ekm0R5FqCg8QxbOESBCq5r1PQkrA@mail.gmail.com>
References: <20111101144058.GP19187@n2100.arm.linux.org.uk>
	<CAFumwP2m7=QsMTGAafPJs2ekm0R5FqCg8QxbOESBCq5r1PQkrA@mail.gmail.com>
Message-ID: <20111102102410.GB645@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 02, 2011 at 05:43:28AM +0000, Andrew Victor wrote:
> hi Russell,
> 
> > Is there any reason this can't just be:
> >
> > void (*arch_reset)(char mode, const char *cmd);
> 
> I don't see any reason why not, except if arch_reset() can be called
> early in the setup code (before the platform initialization).

That's certainly the approach I took here:

http://lists.infradead.org/pipermail/linux-arm-kernel/2011-October/070729.html

but I only compile-tested it.

Will
