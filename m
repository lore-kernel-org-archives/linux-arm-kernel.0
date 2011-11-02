From: rpurdie@rpsys.net (Richard Purdie)
Date: Wed, 02 Nov 2011 13:49:07 +0000
Subject: [RFC 0/5] restart cleanups
In-Reply-To: <20111101170225.GS19187@n2100.arm.linux.org.uk>
References: <20111101160731.GQ19187@n2100.arm.linux.org.uk>
	<20111101170225.GS19187@n2100.arm.linux.org.uk>
Message-ID: <1320241747.20107.41.camel@ted>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2011-11-01 at 17:02 +0000, Russell King - ARM Linux wrote:
> (Poodle doesn't have any MAINTAINERS entry, I think Richard Purdie last
> touched Poodle in a 'maintainery' way back in 2006.)
> 
> poodle does this:
> 
> static void poodle_restart(char mode, const char *cmd)
> {
>         arm_machine_restart('h', cmd);
> }
> 
> Given that the default value of 'mode' (in the absense of any reboot=
> command line argument to the kernel) is 'h', this seems to be a no-op.
> Below is the history; I suspect that the reason this first appeared was
> because of the need to fiddle with RCSR - that's now gone so I suspect
> the entire restart handler can be deleted.
> 
> What I don't understand in that case is why 'mode' wasn't simply passed
> through in the first patch.
