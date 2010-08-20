From: tony@atomide.com (Tony Lindgren)
Date: Fri, 20 Aug 2010 09:56:50 +0300
Subject: [PATCH 3/6] OMAP3: PM: ensure IO wakeups are properly disabled
In-Reply-To: <4C6D7936.3090201@ru.mvista.com>
References: <20100813080034.18750.15410.stgit@baageli.muru.com>
	<20100813080200.18750.37791.stgit@baageli.muru.com>
	<4C651635.8000201@ru.mvista.com>
	<20100813102933.GN12706@atomide.com>
	<4C65238D.9080105@ru.mvista.com>
	<87sk2ao4fr.fsf@deeprootsystems.com>
	<4C6D7936.3090201@ru.mvista.com>
Message-ID: <20100820065649.GH25742@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Sergei Shtylyov <sshtylyov@mvista.com> [100819 21:27]:
> Hello.
> 
> Kevin Hilman wrote:
> 
> >>>>>From: Kevin Hilman <khilman@ti.com>
> >>>>>Commit 5a5f561 (convert OMAP3 PRCM macros to the _SHIFT/_MASK suffixes)
> >>>>>mistakenly removed the check for PER when disabling the IO chain.
> >>>>>During idle, if the PER powerdomain transitions and CORE does not (as
> 
> >>>>  Does not what?
> 
> >>>How about ".. and CORE does not transition"?
> 
> >>   Transition to what then? Sentense till won't parse right...
> 
> >>>Kevin, care to clarify that?
> >>   Yeah, looks like a considerable partt of that sentense got omitted...
> 
> >No.  Nothing was omitted.
> 
> >It's like saying "Tony drinks Fernet and Kevin does not."  Adding an
> >additional "drinks Fernet" at the end is redundant.
> 
>    Sorry, the sentence still doesn't parse for me. You don't say
> "Fernet" there BTW, so it's not clear where the PER powerdomain
> transitions to. What goes after the closing parenthesis doesn't
> clear things up either, it just describes what happens if...

I'll update it with the following to preserve the Fernet style,
and to describe the transition:

During idle, if the PER powerdomain transitions into a lower state
and CORE does not, the IO pad wakeups are not being disabled in
the idle path after they are enabled. This can happen with the
lower C-states when using CPUidle for example.

Updated patch attached.

Please reply ASAP if this is not OK, I'd like to get a pull
request for these fixes sent to Linus over the weekend.

Regards,

Tony
-------------- next part --------------
A non-text attachment was scrubbed...
Name: omap3-pm-ensure-io-wakeups-are-properly-disabled.patch
Type: text/x-diff
Size: 1872 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100820/16fe0adb/attachment.bin>
