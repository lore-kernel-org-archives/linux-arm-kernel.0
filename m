From: David.Laight@ACULAB.COM (David Laight)
Date: Mon, 25 Sep 2017 16:09:56 +0000
Subject: [PATCH v3][for 4.14] xhci: allow TRACE to work with EVENT ring
 dequeue
In-Reply-To: <1506342365-11268-1-git-send-email-awallis@codeaurora.org>
References: <1506342365-11268-1-git-send-email-awallis@codeaurora.org>
Message-ID: <063D6719AE5E284EB5DD2968C1650D6DD007F5A1@AcuExch.aculab.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Adam Wallis
> Sent: 25 September 2017 13:26
> inc_deq() currently bails earlier for EVENT rings than the common return
> point of the function, due to the fact that EVENT rings do not have
> link TRBs. The unfortunate side effect of this is that the very useful
> trace_xhci_inc_deq() function is not called/usable for EVENT ring
> debug.

Is it actually worth using different functions for the different
ring types?
>From what I remember there are conditionals in a lot of the functions
but they are fixed for most of the call sites.

	David
