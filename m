From: robherring2@gmail.com (Rob Herring)
Date: Mon, 13 Aug 2012 16:48:11 -0500
Subject: [PATCH 1/2] ARM: mach-imx: Remove board entries in dt_board_compat
In-Reply-To: <20120813151509.GB27393@S2101-09.ap.freescale.net>
References: <1339941856-2836-1-git-send-email-festevam@gmail.com>
 <20120705071318.GO30009@pengutronix.de>
 <20120705074623.GG10610@S2101-09.ap.freescale.net>
 <20120813151509.GB27393@S2101-09.ap.freescale.net>
Message-ID: <5029761B.9080502@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/13/2012 10:15 AM, Shawn Guo wrote:
> On Thu, Jul 05, 2012 at 03:46:23PM +0800, Shawn Guo wrote:
>> On Thu, Jul 05, 2012 at 09:13:18AM +0200, Sascha Hauer wrote:
>>> Shawn,
>>>
>>> Is this ok with you?
>>>
>> No.
>>
>> http://thread.gmane.org/gmane.linux.ports.arm.kernel/172558/focus=172703
>>
> I change my mind.  Though it's really a pity to lose a concentrated
> place maintaining a full list of compatible strings of all supported
> board, I'm more concerned by the dt_board_compat matching efficiency
> when the table gets longer.
> 

I think this is needless churn. You can't say board entries are never
needed. Perhaps we've been overly active in adding all compatible
strings before they are needed. When you add a new board, it is fine to
match against the soc string without changing the kernel, but the dtb
should still have a more specific string. Then if you need to add
something board specific later, you can add the match entry and
corresponding board specific code.

Rob
