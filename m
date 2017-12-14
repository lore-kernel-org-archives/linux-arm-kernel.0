From: miquel.raynal@free-electrons.com (Miquel RAYNAL)
Date: Thu, 14 Dec 2017 12:27:33 +0100
Subject: [PATCH v3 09/11] thermal: armada: Wait sensors validity before
 exiting the init callback
In-Reply-To: <87ind9o8o0.fsf@free-electrons.com>
References: <20171214103011.24713-1-miquel.raynal@free-electrons.com>
 <20171214103011.24713-10-miquel.raynal@free-electrons.com>
 <87ind9o8o0.fsf@free-electrons.com>
Message-ID: <20171214122733.5c9264c0@xps13>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 14 Dec 2017 12:23:11 +0100
Gregory CLEMENT <gregory.clement@free-electrons.com> wrote:

> Hi Miquel,
>  
>  On jeu., d?c. 14 2017, Miquel Raynal
> <miquel.raynal@free-electrons.com> wrote:
> 
> > The thermal core will check for sensors validity right after the
> > initialization callback has returned. As the initialization routine
> > make a reset, the sensors are not ready immediately and the core
> > spawns an error in the dmesg. Avoid this annoying situation by
> > polling on the validity bit before exiting from these routines.
> > This also avoid the use of blind sleeps.  
> 
> You only modified the armada 380 and ap806 init function. Does it
> means that this feature is not supported on the other variant?

I can't tell for other boards, It does not seem they actually need it
so I did not hacked their init callback. Should I? IMOH, if there is
not problem, there is no fix to add neither.

Miqu?l
