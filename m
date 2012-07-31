From: ian.molton@codethink.co.uk (Ian Molton)
Date: Tue, 31 Jul 2012 12:04:16 +0100
Subject: [PATCH 4/6] kirkwood: setup clock only in eth helpers.
In-Reply-To: <CAMW5UfahXv--UU5np9HroXWia7-PN9qy1eyCnc_Wf39H-_F+gA@mail.gmail.com>
References: <1343661359-10150-1-git-send-email-ian.molton@codethink.co.uk>
 <1343661359-10150-5-git-send-email-ian.molton@codethink.co.uk>
 <CAMW5UfahXv--UU5np9HroXWia7-PN9qy1eyCnc_Wf39H-_F+gA@mail.gmail.com>
Message-ID: <5017BBB0.1000702@codethink.co.uk>
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

Actually Im thinking of dropping this change altogether - it would
seem that since adding aliases so that the driver can managed
the clocks itself (thanks Andrew), the DT code apparently doesnt
disable the clocks, so the MAC is preserved.

I see no reason to keep the calls now that the driver manages to
hang onto its clocks.

-Ian
