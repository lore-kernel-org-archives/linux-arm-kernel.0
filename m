From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Wed, 05 Feb 2014 12:05:15 +0000
Subject: [PATCH 1/2] clk: shmobile: rcar-gen2: Fix clock parent all non-PLL
 clocks
In-Reply-To: <4232876.LkjsLLbJbc@avalon>
References: <1389113273-10364-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <1389113273-10364-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <52F213C9.2020501@codethink.co.uk> <4232876.LkjsLLbJbc@avalon>
Message-ID: <52F228FB.5090900@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/02/14 10:51, Laurent Pinchart wrote:
> Hi Ben,
>
> On Wednesday 05 February 2014 10:34:49 Ben Dooks wrote:
>> On 07/01/14 16:47, Laurent Pinchart wrote:
>>> The lb, qspi, sdh, sd0 and sd1 clocks have the PLL1 (divided by 2) as
>>> their parent, not the main clock. Fix it.
>>
>> William Towle has already sent a patch to move this to device tree
>> which I think is a better solution for this.
>
> I actually disagree. The CPG is an IP core that generates a bunch of clocks
> from a single external parent. The fact that clocks are not flat but organized
> as a tree internally is an internal property of the CPG, and I prefer keeping
> it that way instead of exposing it in the device tree.

If you feel that the block is unlikely to change if it gets
re-used then that'll be fine. We can always revisit the changes
if needed.

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
