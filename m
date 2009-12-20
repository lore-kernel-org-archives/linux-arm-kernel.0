From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sun, 20 Dec 2009 19:36:52 +0100
Subject: [BUG] pxa27x_udc: possible recursive locking detected in
	pxa_ep_queue
In-Reply-To: <20091212173140.f9ac2a7b.ospite@studenti.unina.it> (Antonio
	Ospite's message of "Sat\, 12 Dec 2009 17\:31\:40 +0100")
References: <20091205115754.7e1dc0fd.ospite@studenti.unina.it>
	<87fx7guuzg.fsf@free.fr>
	<20091212173140.f9ac2a7b.ospite@studenti.unina.it>
Message-ID: <87ocltsda3.fsf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Antonio Ospite <ospite@studenti.unina.it> writes:

> Patch does not apply cleanly on top of 2.6.32: Hunk #13 FAILED at 2102.
> This is in handle_ep(), you have this snippet:
> 	/* some code below uses registers not available for ep0 */
>  	BUG_ON(is_ep0(ep));
>
> which is not in the code I have, I rebased the patch, and tested it,
> tho.
>
> I only tested the patch in one of my previous scenarios: the insanely repeated
> connect-disconnect manoeuvre, and I am hitting another problem, log appended
> below. Note that usblan is working even after I get this message.
>
> =================================
> [ INFO: inconsistent lock state ]
> 2.6.32-ezxdev #45
> ---------------------------------
<snip>

Hi Antonio,

I tried to trigger the same message, to no avail. Even after activating spinlock
debugging and plugging/unplugging like a mad man, nothing ...
Well, I must rely on your testing I'm afraid. Could you test this patch ? I
rebased my tree on v2.6.32 so you will have no git-am complaint.

Cheers.

-- 
Robert
