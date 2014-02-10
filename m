From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Mon, 10 Feb 2014 14:54:22 +0000
Subject: [RFC PATCH] ARM: Add imprecise abort enable/disable macro
In-Reply-To: <20140210141634.GA2794@e103592.cambridge.arm.com>
References: <1391789955-26927-1-git-send-email-fabrice.gasnier@st.com>
 <1391789955-26927-2-git-send-email-fabrice.gasnier@st.com>
 <20140210141634.GA2794@e103592.cambridge.arm.com>
Message-ID: <52F8E81E.70804@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/02/14 14:16, Dave Martin wrote:
> On Fri, Feb 07, 2014 at 05:19:15PM +0100, Fabrice GASNIER wrote:
>> This patch adds imprecise abort enable/disable macros.
>> It also enables imprecise aborts when starting kernel.
>
> Relying on imprecise aborts for hardware probing would be considered bad
> hardware and/or software design for ARM-specific stuff.
>
> PCI is more generic though, so we may have to put up with this to some
> extent.  Can you point me to the affected probing code?  I'm not very
> familiar with that stuff...

The marvell pcie always had the option of delivering any bus
errors as imprecise aborts. However it was /annoying/ and therefore
easier just to turn it off and rely on the hardware returning 0xffff
for any configuration area it couldn't get to.


-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
