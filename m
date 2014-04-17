From: jason@lakedaemon.net (Jason Cooper)
Date: Thu, 17 Apr 2014 10:23:36 -0400
Subject: [PATCH v2 2/4] ARM: mvebu: fix NOR bus-width in Armada XP GP
 Device Tree
In-Reply-To: <20140417090936.387c79c6@skate>
References: <1397489361-5833-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1397489361-5833-3-git-send-email-thomas.petazzoni@free-electrons.com>
 <20140417050832.GP28159@titan.lakedaemon.net>
 <20140417090936.387c79c6@skate>
Message-ID: <20140417142336.GU28159@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 17, 2014 at 09:09:36AM +0200, Thomas Petazzoni wrote:
> On Thu, 17 Apr 2014 01:08:32 -0400, Jason Cooper wrote:
> > Also, a gentle nit:  You're doing all the -stable info digging, would
> > you mind putting it in the following format so I don't have to hand edit
> > each patch?
> 
> Sure! So far I've just been blindly following
> Documentation/stable_kernel_rules.txt, and besides the "Cc:
> stable at vger.kernel.org" it doesn't say anything else of what you're
> suggesting below.
> 
> > ------
> > Link: ...
> 
> What should this link point to?

Oops, it was late.  I thought I was copying the relevant lines you added
under your SoB.  I forgot that I added code to my import script that
automagically adds a line:

Link: https://lkml.kernel.org/r/1397489361-5833-2-git-send-email-thomas.petazzoni at free-electrons.com

built from the Message-Id of the email.  Very helpful to lookup ML
conversations for a given commit.

Anyway, ignore that line because I automatically add it when I pull the
patch in.

> > Fixes: da8d1b383568 ('ARM: mvebu: Add support for NOR flash device on Armada XP-GP board')
> 
> Ok. But this is not described in Documentation/stable_kernel_rules.txt.

It's what we settled on at 2013 KS.  I could have sworn we updated the
docs to reflect that...  A quick grep says no. :(

> > Cc: stable at vger.kernel.org # v3.10+
> 
> The Cc: to stable@ is documented, but the use of a comment with the
> kernel version afterwards is only mentioned when the commit in question
> requires other commits as dependencies to be applied to stable. When
> the commit is self-sufficient, stable_kernel_rules.txt doesn't indicate
> that a comment is needed.

Indeed, I've always added the comment even for single patches because it
makes the -stable teams job easier.  We know the code better, so it's
easier for us to determine how far back it should go.

Just to be clear, I'm not asking you or anyone else to do the above for
patch submissions.  Only if you're inclined to do the digging for me, it
would be nice to have it in the proper format.

> Maybe an update to stable_kernel_rules.txt is in order? :-)

Yes, it would seem so.  Perhaps some young, motivated, new kernel hacker
would like to take a stab at it? :-)

thx,

Jason.
