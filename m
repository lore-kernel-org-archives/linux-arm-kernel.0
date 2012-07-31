From: ian.molton@codethink.co.uk (Ian Molton)
Date: Tue, 31 Jul 2012 09:23:41 +0100
Subject: [PATCH 4/6] kirkwood: setup clock only in eth helpers.
In-Reply-To: <CAMW5UfahXv--UU5np9HroXWia7-PN9qy1eyCnc_Wf39H-_F+gA@mail.gmail.com>
References: <1343661359-10150-1-git-send-email-ian.molton@codethink.co.uk>
 <1343661359-10150-5-git-send-email-ian.molton@codethink.co.uk>
 <CAMW5UfahXv--UU5np9HroXWia7-PN9qy1eyCnc_Wf39H-_F+gA@mail.gmail.com>
Message-ID: <5017960D.3040101@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30/07/12 17:46, Josh Coombs wrote:
> If I'm reading this correctly, if kirkwood_ge00_init is called without
> any data, all that happens is the clock is enabled.  If the right data
> is passed in, the ethernet interface is initialized, and then the
> clock is enabled.
>
> Patch 6 in your series sets all the existing DT board files to call
> kirkwood_ge00_init with no data.
>
> Would it make more sense for readability to separate the clock prep
> and other interface initialization so DT board files don't appear to
> be calling for a full turn up despite now handling that in the DTS
> tree?  IE instead of converting all the board-XXX.c to call
> kirkwood_ge00_init(NULL) have them call a new function,
> kirkwood_ge00_clk_prep(NULL) instead, assuming the clock can't be
> handled directly via DTS.

This is certainly possible, but I was trying to avoid yet another
function being added to the sources with a (necessarily) short
lifespan - it will only be needed until such time as the clk stuff
is sorted out, which is on my TODO list.

My preference would be to add a comment explaining the
choice in the code.

If its preferred, however, I have no real objection to splitting
out the functionality.

-Ian
