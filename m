From: andreiw@motorola.com (Andrei Warkentin)
Date: Mon, 14 Feb 2011 15:06:32 -0600
Subject: [PATCH 3/5] ARM: l2x0: Errata fix for flush by Way operation can
	cause data corruption
In-Reply-To: <AANLkTinfx3eEgvPpeUAAxcrDOtQ+G_PkkoQH4V9E+N=7@mail.gmail.com>
References: <1297510187-31547-1-git-send-email-santosh.shilimkar@ti.com>
	<1297510187-31547-4-git-send-email-santosh.shilimkar@ti.com>
	<AANLkTimkqZ5datA+7shggbWz3+j=TDg5beUkQK=b1AmK@mail.gmail.com>
	<13596bec9184b117d6a1d02da8e017bf@mail.gmail.com>
	<AANLkTimjXG5-kEW=1vodnGo3Ct_xOS_HihdqN0TeL9ba@mail.gmail.com>
	<33573d5cfc91cf45dc58ee861cccc2ae@mail.gmail.com>
	<AANLkTinfx3eEgvPpeUAAxcrDOtQ+G_PkkoQH4V9E+N=7@mail.gmail.com>
Message-ID: <AANLkTimaH=Gw4xZC4o_kfMyvx6cYTDEZ=gYkpiRfLyd0@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 14, 2011 at 1:33 PM, Andrei Warkentin <andreiw@motorola.com> wrote:
>
> Fair enough, but you're doing it right now :-). I believe the smarter
> approach would be to start abstracting all accesses to secure-only
> resources (like the DCR reg). This would be your "hypervisor"
> interface. Then provide an implementation for your TI secure monitor.
> Obviously over time :).
>

Santosh,

Maybe this can influence you in some ways. I have this old patch
sitting around, although it does #ifdef around the TI stuff, simply
because I wasn't really interested in moving it out.
I group the errata by revs so it's simpler to see what you need and
what you don't. Obviously there aren't that many, but it does provide
a pattern to follow...

Thanks,
A
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-ARM-PL310-Cleanup-errata-handling-for-cache-controll.patch
Type: text/x-diff
Size: 9798 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110214/842681d4/attachment-0001.bin>
