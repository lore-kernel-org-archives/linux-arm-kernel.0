From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sat, 12 Dec 2009 15:28:51 +0100
Subject: [BUG] pxa27x_udc: possible recursive locking detected in
	pxa_ep_queue
References: <20091205115754.7e1dc0fd.ospite@studenti.unina.it>
Message-ID: <87fx7guuzg.fsf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Antonio Ospite <ospite@studenti.unina.it> writes:

> Hi,
>
> I've run into this recently, I get it with 2.6.32 (plus some code for
> the EZX platform) especially using ROOT_NFS over usblan. It looks like
> I can also trigger it regularly by connecting and disconnecting usb
> cable repeatedly while the kernel on the pxa system is loading
> (in a _non_ ROOT_NFS scenario).

Hi Antonio,

Could I ask you to try that patch please. I can't trigger the deadlock on my
hardware, and I'd like some confirmation before I submit that one. Notice that
the patch deals with all endpoints excepting control endpoint (ie. USB EP0), but
that's not what matters now.

If you can give me some feedback, I would appreciate.

Cheers.

--
Robert
