From: manuel.schoelling@gmx.de (Manuel Schoelling)
Date: Sun, 22 Jun 2014 13:23:34 +0200
Subject: [PATCH] xilinx: Fix compiler warning
In-Reply-To: <53A6BAC5.80206@cogentembedded.com>
References: <1403432461-18296-1-git-send-email-manuel.schoelling@gmx.de>
 <53A6BAC5.80206@cogentembedded.com>
Message-ID: <1403436214.26292.4.camel@schoellingm.dzne.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On So, 2014-06-22 at 15:15 +0400, Sergei Shtylyov wrote:
> Hello.
> 
> On 06/22/2014 02:21 PM, Manuel Sch?lling wrote:
> 
> > The time comparsion functions require arguments of type unsigned long
> > instead of (signed) long.
> 
> > Signed-off-by: Manuel Sch?lling <manuel.schoelling@gmx.de>
> 
> [...]
> 
> > diff --git a/init/do_mounts.c b/init/do_mounts.c
> > index 60c4196..2d069a3 100644
> > --- a/init/do_mounts.c
> > +++ b/init/do_mounts.c
> > @@ -351,7 +351,6 @@ static void __init get_fs_names(char *page)
> >   				continue;
> >   			line++;
> >
> > -			/* append fsname */
> >   			memmove(fsnames, line, strlen(line)+1);
> >   			fsnames += strlen(fsnames)+1;
> >   		} while (page != NULL);
> >
> 
>    Seems like unrelated random change.
Thanks, you are right: somehow this change made it into my patch.
Probably I was not careful enough when using 'git commit -a'.

Sorry, I will resend a fixed patch in a second.

> 
> WBR, Sergei
> 
