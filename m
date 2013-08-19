From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 19 Aug 2013 11:19:22 +0100
Subject: [RFC PATCH v2 3/4] powerpc: refactor of_get_cpu_node to
 support other architectures
In-Reply-To: <1376777376.25016.11.camel@pasglop>
References: <1376586580-5409-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
 <1376674791-28244-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
 <1376674791-28244-2-git-send-email-Sudeep.KarkadaNagesha@arm.com>
 <2032060.4bgTKOdEX2@flatron> <1376777376.25016.11.camel@pasglop>
Message-ID: <20130819101922.GI3719@e106331-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Aug 17, 2013 at 11:09:36PM +0100, Benjamin Herrenschmidt wrote:
> On Sat, 2013-08-17 at 12:50 +0200, Tomasz Figa wrote:
> > I wonder how would this handle uniprocessor ARM (pre-v7) cores, for
> > which 
> > the updated bindings[1] define #address-cells = <0> and so no reg 
> > property.
> > 
> > [1] - http://thread.gmane.org/gmane.linux.ports.arm.kernel/260795
> 
> Why did you do that in the binding ? That sounds like looking to create
> problems ... 
> 
> Traditionally, UP setups just used "0" as the "reg" property on other
> architectures, why do differently ?

The decision was taken because we defined our reg property to refer to
the MPIDR register's Aff{2,1,0} bitfields, and on UP cores before v7
there's no MPIDR register at all. Given there can only be a single CPU
in that case, describing a register that wasn't present didn't seem
necessary or helpful.

Thanks,
Mark.
