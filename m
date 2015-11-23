From: rostedt@goodmis.org (Steven Rostedt)
Date: Mon, 23 Nov 2015 15:58:34 -0500
Subject: [RFC/PATCH 2/3] recordmcount: Record locations of
 __aeabi_{u}idiv() calls on ARM
In-Reply-To: <20151123205335.GD19156@codeaurora.org>
References: <1448068997-26631-1-git-send-email-sboyd@codeaurora.org>
 <1448068997-26631-3-git-send-email-sboyd@codeaurora.org>
 <20151121101349.GI8644@n2100.arm.linux.org.uk>
 <20151123205335.GD19156@codeaurora.org>
Message-ID: <20151123155834.37b11beb@gandalf.local.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 23 Nov 2015 12:53:35 -0800
Stephen Boyd <sboyd@codeaurora.org> wrote:

 
> 
> This comment in recordmcount.pl may tell us something.
> 
> 	#
> 	# Somehow the make process can execute this script on an
> 	# object twice. If it does, we would duplicate the mcount
> 	# section and it will cause the function tracer self test
> 	# to fail. Check if the mcount section exists, and if it does,
> 	# warn and exit.
> 	#
> 	print STDERR "ERROR: $mcount_section already in $inputfile\n" .
> 	    "\tThis may be an indication that your build is corrupted.\n" .
> 	    "\tDelete $inputfile and try again. If the same object file\n" .
> 	    "\tstill causes an issue, then disable CONFIG_DYNAMIC_FTRACE.\n";
> 	exit(-1);

I believe I hit this by hitting ctrl-C during a build and then starting
it again. It's been a while so it could have been something else.

-- Steve


> 
> I don't think there's much that can be done here besides making
> it silent unless there's some verbose build flag set (-v?), but
> it is interesting that you see it spew thousands of times. I've
> never seen the error printed, but perhaps I'm not building the
> kernel the same way you are. Care to share how you're building
> and seeing these error messages?
> 
