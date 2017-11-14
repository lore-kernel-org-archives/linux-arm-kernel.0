From: mans@mansr.com (=?iso-8859-1?Q?M=E5ns_Rullg=E5rd?=)
Date: Tue, 14 Nov 2017 13:22:50 +0000
Subject: [PATCH v3 2/4] net: nb8800: Simplify nb8800_pause_config()
In-Reply-To: <569542b1-8e56-d7da-f7a0-affd89bfed62@sigmadesigns.com> (Marc
 Gonzalez's message of "Tue, 14 Nov 2017 13:56:34 +0100")
References: <230165aa-eaf1-6e2b-7ff3-45b3ee4ffc62@sigmadesigns.com>
 <dd0c2014-8ef9-749c-16d3-6a56f4161658@sigmadesigns.com>
 <yw1x1sl12fx8.fsf@mansr.com>
 <569542b1-8e56-d7da-f7a0-affd89bfed62@sigmadesigns.com>
Message-ID: <yw1xk1yt0zbp.fsf@mansr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Marc Gonzalez <marc_gonzalez@sigmadesigns.com> writes:

> On 14/11/2017 13:38, M?ns Rullg?rd wrote:
>
>> Marc Gonzalez writes:
>> 
>>> The "flow control enable" bit can be tweaked, even if DMA is enabled.
>> 
>> No, it can't.  Maybe on some of your newer chips it can, but not on the
>> older ones.
>
> Again, I suppose you are referring to your SMP8642-based board.
>
> Are you saying you tested this patch, and it doesn't work?
> What are the symptoms?

I didn't test that patch per se.  I did initially try simply changing
that bit, and this didn't work.  Either it had no effect, or it locked
up the controller, I forget which.  The manual explicitly states that
writes are forbidden while the DMA enabled bit is set.

If shutting down the DMA really isn't possible, I would rather just
allow changing the flow control setting only when the interface is
stopped.  The normal case of getting the initial setting from the
auto-negotiation will still work properly.  It just won't be possible to
change it while the link is active.

-- 
M?ns Rullg?rd
