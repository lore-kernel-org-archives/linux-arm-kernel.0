From: tim.bird@am.sony.com (Tim Bird)
Date: Tue, 16 Oct 2012 11:32:42 -0700
Subject: [Celinux-dev] PDF documentation
In-Reply-To: <20121016143522.086F2204292@gemini.denx.de>
References: <CAE7jHC83biZy7TNYSr+-X85tpenqtAHuwSO47Q-6+XRF0fUxLA@mail.gmail.com>
 <20121016143522.086F2204292@gemini.denx.de>
Message-ID: <507DA84A.2080904@am.sony.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/16/2012 07:35 AM, Wolfgang Denk wrote:
> Dear Constantine Shulyupin,
> 
> In message <CAE7jHC83biZy7TNYSr+-X85tpenqtAHuwSO47Q-6+XRF0fUxLA@mail.gmail.com> you wrote:
>>
>> I have some questions and ideas about documentation in PDF format.
>> During embedded SW development I often work with documentation,
>> especially datasheets in PDF format. I have some issues with such
>> documentation. It is not so easy to manage a lot of PDF documents
>> sometimes with strange code in file names.  It is not easy to store
>> and share links to documentation.
> 
> PDF has a lot of advantages in many situations, but I agree that it is
> also non-perfect for many other use cases.
> 
>> Questions:
>> - have same issues with PDF documentation and datasheets?
>> - do you think documentation and datasheets in HTML format on a site
>> can be more useful than PDF?
> 
> HTML is really useful in a web browser only.

I agree.  This has already been covered by others, but HTML
consists of multiple files, and so is not convenient to store
or transmit atomically.  Also, HTML is often difficult to print
(you have to explicitly remove the page decorations added by
the site (or find the 'print' option on the page).

> For documentation of the U-Boot boot loader we use a very different
> approach:  documentation is created, stored and edited in a wiki
> (using FosWiki, see http://foswiki.org/).  This has the advantage that
> you can make it either easily editable to the community, or put
> arbitrary access restrictions to it by using wiki user / group access
> permissions.  In combination with some plugins (like TocPlugin,
> BookmakerPlugin and PublishPlugin) we can then "linearize" the entries
> in the wiki to generate a "book" which can be read both online (as
> HTML) or offline (by publishing the content as a linerarized, single
> HTLP, plain text, PDF and/or PostScript document).
> 
> To give you a feeling how this works, please see for example 
> 	http://www.denx.de/wiki/view/DULG/Manual?stickboard=m28
> 	http://www.denx.de/wiki/publish/DULG/DULG-m28.html
> 	http://www.denx.de/wiki/publish/DULG/DULG-m28.ps
> and	http://www.denx.de/wiki/publish/DULG/DULG-m28.pdf
...
> And the nice thing is: all this is based on free software only...

This is really interesting.

Several years ago, CELF tried to add a similar capability to
MoinMoin (the ability to take arbitrary page lists, and
automatically publish them to PDF).  Unfortunately, it didn't
work very well.  The tools to produce PDF were pretty bad back then.

I think the wiki approach is very good for collecting the
information, and having a way to snapshot and publish the items
solves some of the problems wikis have (uneven editing across
multiple pages over time can lead to inconsistent pages).

It sounds like the tools have improved since we did this, and
maybe we should look again and see if there's something similar
we could add to the elinux wiki.
 -- Tim

=============================
Tim Bird
Architecture Group Chair, CE Workgroup of the Linux Foundation
Senior Staff Engineer, Sony Network Entertainment
=============================
