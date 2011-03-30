From: viktor.rosendahl@nokia.com (Viktor Rosendahl)
Date: Wed, 30 Mar 2011 19:46:31 +0300
Subject: [PATCH] Reject kprobes when Rn==15 and writeback is set
In-Reply-To: <1301500340.2488.127.camel@computer2.home>
References: <alpine.LFD.2.00.1103291441160.11889@xanadu.home>	
	<1301492550-16747-1-git-send-email-viktor.rosendahl@nokia.com>
	<1301500340.2488.127.camel@computer2.home>
Message-ID: <4D935E67.8060203@nokia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/30/2011 06:52 PM, ext Tixy wrote:

> If we start littering the code with all these extra checks we risk
> introducing bugs and making the code more difficult to maintain.
>
> In my opinion we should not add any extra code to handle instructions
> combinations that the ARM ARM says are UNPREDICTABLE, or have fields
> which are SBZ/SBO. The toolchain shouldn't ever generate these bad
> instructions in which case the extra kprobes code is redundant.
>

I see your point. I guess we can decide to not care about those 
unpredictable cases, unless someone can come up with some decoding & 
checking code that covers all the cases and is easy to understand and 
maintain.

best regards,

Viktor
