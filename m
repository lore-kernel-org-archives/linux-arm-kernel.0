From: bp@alien8.de (Borislav Petkov)
Date: Mon, 10 Oct 2011 09:00:28 +0200
Subject: [PATCH] PM: HIBERNATION: add resume_delay kernel param as well
	as resume_delay
In-Reply-To: <CAGsJ_4zSUYPrK3Bdo4p5bL25PO7orAJJByRAx2U=OT-JE62uHw@mail.gmail.com>
References: <1318225452-10397-1-git-send-email-Barry.Song@csr.com>
	<20111010062653.GB4139@liondog.tnic>
	<CAGsJ_4zSUYPrK3Bdo4p5bL25PO7orAJJByRAx2U=OT-JE62uHw@mail.gmail.com>
Message-ID: <20111010070028.GA11577@liondog.tnic>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 10, 2011 at 02:34:45PM +0800, Barry Song wrote:
> >> diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
> >> index b3da53c..f73a00e 100644
> >> --- a/kernel/power/hibernate.c
> >> +++ b/kernel/power/hibernate.c
> >> @@ -33,6 +33,7 @@
> >> ?static int nocompress = 0;
> >> ?static int noresume = 0;
> >> ?static int resume_wait = 0;
> >> +static int resume_delay = 0;
> >
> > These static variables get zeroed needlessly and checkpatch actually
> > warns about that. Maybe fix that up while you're there?
> 
> yes. right. i initilized it to 0 to keep consistent coding style with
> the context because there were other variants doing that.
> i'd like to delete all initialization together as a seperate patch. Or
> do you want to do that?

Nah, you go ahead :-).

Thanks.

-- 
Regards/Gruss,
    Boris.
