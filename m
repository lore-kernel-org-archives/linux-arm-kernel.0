From: mina86@mina86.com (Michal Nazarewicz)
Date: Tue, 14 Jun 2011 18:58:35 +0200
Subject: [PATCH 08/10] mm: cma: Contiguous Memory Allocator added
In-Reply-To: <201106141803.00876.arnd@arndb.de>
References: <1307699698-29369-1-git-send-email-m.szyprowski@samsung.com>
	<201106141549.29315.arnd@arndb.de>
	<op.vw2jmhir3l0zgt@mnazarewicz-glaptop>
	<201106141803.00876.arnd@arndb.de>
Message-ID: <op.vw2r3xrj3l0zgt@mnazarewicz-glaptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>> On Tue, 14 Jun 2011 15:49:29 +0200, Arnd Bergmann <arnd@arndb.de> wrote:
>>> Please explain the exact requirements that lead you to defining  
>>> multiple contexts.

> On Tuesday 14 June 2011, Michal Nazarewicz wrote:
>> Some devices may have access only to some banks of memory.  Some devices
>> may use different banks of memory for different purposes.

On Tue, 14 Jun 2011 18:03:00 +0200, Arnd Bergmann wrote:
> For all I know, that is something that is only true for a few very  
> special Samsung devices,

Maybe.  I'm just answering your question. :)

Ah yes, I forgot that separate regions for different purposes could
decrease fragmentation.

> I would suggest going forward without having multiple regions:

Is having support for multiple regions a bad thing?  Frankly,
removing this support will change code from reading context passed
as argument to code reading context from global variable.  Nothing
is gained; functionality is lost.

> * Remove the registration of specific addresses from the initial patch
>   set (but keep the patch).
> * Add a heuristic plus command-line override to automatically come up
>   with a reasonable location+size for *one* CMA area in the system.

I'm not arguing those.

-- 
Best regards,                                         _     _
.o. | Liege of Serenely Enlightened Majesty of      o' \,=./ `o
..o | Computer Science,  Michal "mina86" Nazarewicz    (o o)
ooo +-----<email/xmpp: mnazarewicz@google.com>-----ooO--(_)--Ooo--
