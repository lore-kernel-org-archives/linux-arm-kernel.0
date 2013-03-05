From: will.deacon@arm.com (Will Deacon)
Date: Tue, 5 Mar 2013 08:08:45 +0000
Subject: [PATCH LINUX v5] xen: event channel arrays are xen_ulong_t and
 not unsigned long
In-Reply-To: <513596F2.1000701@gmail.com>
References: <1361285327.1051.115.camel@zakaz.uk.xensource.com>
 <1361360886-2956-1-git-send-email-ian.campbell@citrix.com>
 <51340ACD.70904@gmail.com>
 <20130305030436.GA18040@mudshark.cambridge.arm.com>
 <513596F2.1000701@gmail.com>
Message-ID: <20130305080845.GA19097@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 05, 2013 at 06:55:46AM +0000, Rob Herring wrote:
> > I also can't immediately see why GCC would allocate oldval to an odd base
> > register. Can you share your .config please?
> >
> 
> Here's a config:

[...]

Cheers Rob, that was enough to reproduce for me. The problem is likely that
CONFIG_AEABI=n, so the ABI doesn't actually mandate even base registers for
64-bit values in registers.

Ian -- this would be fixed if you used our atomic64 routines instead of
inventing your own :)

Will
