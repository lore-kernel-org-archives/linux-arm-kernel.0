From: julia.lawall@lip6.fr (Julia Lawall)
Date: Mon, 8 Dec 2014 07:43:16 +0100 (CET)
Subject: [PATCH 0/20] fix misspelling of current function in string
In-Reply-To: <CAGRGNgWDJqV=XD+6q26Ma=m1sEi1kvLWsjq6=RjRVSFTxow0Qg@mail.gmail.com>
References: <1417980062-25151-1-git-send-email-Julia.Lawall@lip6.fr>
 <CAGRGNgWDJqV=XD+6q26Ma=m1sEi1kvLWsjq6=RjRVSFTxow0Qg@mail.gmail.com>
Message-ID: <alpine.DEB.2.02.1412080738210.2100@localhost6.localdomain6>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 8 Dec 2014, Julian Calaby wrote:

> Hi Julia,
> 
> On Mon, Dec 8, 2014 at 6:20 AM, Julia Lawall <Julia.Lawall@lip6.fr> wrote:
> > These patches replace what appears to be a reference to the name of the
> > current function but is misspelled in some way by either the name of the
> > function itself, or by %s and then __func__ in an argument list.
> 
> Would there be any value in doing this for _all_ cases where the
> function name is written in a format string?

Probably.  But there are a lot of them.  Even for the misspellings, I have 
only don about 1/3 of the cases.

On the other hand, the misspelling have to be checked carefully, because a 
misspelling of one thing could be the correct spelling of the thing thst 
was actually intended.

Joe, however, points out that a lot of these prints are just for function 
tracing, and could be removed.  I worked on another semantic patch that 
tries to do that.  It might be better to remove those prints completely, 
rather than sending one patch to transform them and then one patch to 
remove them after that.  That is why for this series I did only the ones 
where there was actually a problem.

julia
