From: wd@denx.de (Wolfgang Denk)
Date: Tue, 16 Oct 2012 16:35:22 +0200
Subject: [Celinux-dev] PDF documentation
In-Reply-To: <CAE7jHC83biZy7TNYSr+-X85tpenqtAHuwSO47Q-6+XRF0fUxLA@mail.gmail.com>
References: <CAE7jHC83biZy7TNYSr+-X85tpenqtAHuwSO47Q-6+XRF0fUxLA@mail.gmail.com>
Message-ID: <20121016143522.086F2204292@gemini.denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Constantine Shulyupin,

In message <CAE7jHC83biZy7TNYSr+-X85tpenqtAHuwSO47Q-6+XRF0fUxLA@mail.gmail.com> you wrote:
> 
> I have some questions and ideas about documentation in PDF format.
> During embedded SW development I often work with documentation,
> especially datasheets in PDF format. I have some issues with such
> documentation. It is not so easy to manage a lot of PDF documents
> sometimes with strange code in file names.  It is not easy to store
> and share links to documentation.

PDF has a lot of advantages in many situations, but I agree that it is
also non-perfect for many other use cases.

> Questions:
> - have same issues with PDF documentation and datasheets?
> - do you think documentation and datasheets in HTML format on a site
> can be more useful than PDF?

HTML is really useful in a web browser only.

For documentation of the U-Boot boot loader we use a very different
approach:  documentation is created, stored and edited in a wiki
(using FosWiki, see http://foswiki.org/).  This has the advantage that
you can make it either easily editable to the community, or put
arbitrary access restrictions to it by using wiki user / group access
permissions.  In combination with some plugins (like TocPlugin,
BookmakerPlugin and PublishPlugin) we can then "linearize" the entries
in the wiki to generate a "book" which can be read both online (as
HTML) or offline (by publishing the content as a linerarized, single
HTLP, plain text, PDF and/or PostScript document).

To give you a feeling how this works, please see for example 
	http://www.denx.de/wiki/view/DULG/Manual?stickboard=m28
	http://www.denx.de/wiki/publish/DULG/DULG-m28.html
	http://www.denx.de/wiki/publish/DULG/DULG-m28.ps
and	http://www.denx.de/wiki/publish/DULG/DULG-m28.pdf

[Actually this documentation does much more behind the scenes; all
examples in this documentation come from include files which are
automatically generated from our regression test suite (DUTS); so the
procedure is to come up with a new software version, run the test
suite over it, upload the generated log files to the web server, and
voila, there is a new version of the documentation matching exactly
the new software version.]

And the nice thing is: all this is based on free software only...

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd at denx.de
One difference between a man and a machine is that a machine is quiet
when well oiled.
