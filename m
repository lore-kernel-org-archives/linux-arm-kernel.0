From: horms@verge.net.au (Simon Horman)
Date: Tue, 23 Apr 2013 10:52:31 +0900
Subject: [PATCH v5 1/9] ARM: shmobile: Marzen: move USB EHCI, OHCI, and
 PHY devices to R8A7779 code
In-Reply-To: <51753C4D.4080701@cogentembedded.com>
References: <201304200156.23830.sergei.shtylyov@cogentembedded.com>
 <51743BC0.20506@cogentembedded.com>
 <20130422010917.GC15680@verge.net.au>
 <51753C4D.4080701@cogentembedded.com>
Message-ID: <20130423015230.GJ12017@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 22, 2013 at 05:34:05PM +0400, Sergei Shtylyov wrote:
> Hello.
> 
> On 22-04-2013 5:09, Simon Horman wrote:
> 
> >>>USB EHCI, OHCI, and common PHY are the SoC devices but are wrongly defined and
> >>>registered in the Marzen board file.  Move the data and code to their proper
> >>>place in setup-r8a7779.c; while at it, we have to rename 8a7779_late_devices[]
> >>>to 8a7779_standard_devices[] -- this seems legitimate since they are registered
> >>
> >>     I've been pointed to the types in the above variable names privately.
> >>Don't know should I resend or Simon could fix s/8a7779/r8a7779/ while
> >>applying... well, the USB patches haven't been ACK'ed yet.
> 
> >I can fix that up.
> 
> >Is the series waiting on anything?
> 
>    Probably on Felipe's ACKs on rcar-phy.c patches... Felipe hasn't
> appeared on this list for a week but I see his mails from today.

Thanks, lets wait a little longer for his feedback.
Please feel free to ping me if things stagnate.

> >>>from r8a7779_add_standard_devices() anyway.
> 
> >>>Note that I'm deliberately changing the USB PHY platform device's 'id' field
> >>>from (previously just omitted) 0 to -1 as the device is a single of its kind.
> 
> >>>Note also that the board and SoC code have to be in one patch to keep the code
> >>>bisectable...
> 
> >>>The patch has been tested on the Marzen board.
> 
> >>>Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> >>>Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> >>>Acked-by: Simon Horman <horms+renesas@verge.net.au>
> 
> WBR, Sergei
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
