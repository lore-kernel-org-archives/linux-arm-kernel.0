From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 9 Jul 2014 19:32:40 +0100
Subject: [PATCH RFC] drm: add of_graph endpoint helper to find possible
 CRTCs
In-Reply-To: <CAF6AEGt0yq-Feuq13ewY7_4YkgOW6FKjLHnNDELXiyzOWdO5=w@mail.gmail.com>
References: <E1X2kC1-0000sH-C6@rmk-PC.arm.linux.org.uk>
 <CAF6AEGtEUqK=YBWwOz8bf8a_e_p8-Y0vFYRfs2uxJ20015roOA@mail.gmail.com>
 <20140709151618.GU21766@n2100.arm.linux.org.uk>
 <CAF6AEGt0yq-Feuq13ewY7_4YkgOW6FKjLHnNDELXiyzOWdO5=w@mail.gmail.com>
Message-ID: <20140709183240.GV21766@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 09, 2014 at 02:11:18PM -0400, Rob Clark wrote:
> On Wed, Jul 9, 2014 at 11:16 AM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > Warning(.../include/drm/drm_flip_work.h:68): No description found for parameter ')'
> > Warning(.../include/drm/drm_flip_work.h:68): Excess struct/union/enum/typedef member 'fifo' description in 'drm_flip_work'
> > Warning(.../include/drm/drm_flip_work.h:68): No description found for parameter ')'
> > Warning(.../include/drm/drm_flip_work.h:68): Excess struct/union/enum/typedef member 'fifo' description in 'drm_flip_work'
> >   DOCPROC Documentation/DocBook/w1.xml
> >   DOCPROC Documentation/DocBook/writing_musb_glue_layer.xml
> >   PDF     Documentation/DocBook/z8530book.pdf
> > Making portrait pages on A4 paper (210mmx297mm)
> > sh: /usr/share/xmlto/format/docbook/../fo/pdf: No such file or directory
> > make[2]: *** [Documentation/DocBook/z8530book.pdf] Error 1
> > make[2]: *** Waiting for unfinished jobs....
> > make[1]: *** [pdfdocs] Error 2
> > make: *** [sub-make] Error 2
> 
> hmm, I usually use 'make htmldocs'.. hadn't really bothered to try to
> build pdf docs.   It was a while ago, but I think 'xmlto-tex' would be
> what you need for fedora to get docs to build.  Hopefully the package
> has a similar name on other distros.
> 
> There are unfortunately a lot of warnings..  the headerdoc stuff is
> not always as clever as you would like.

Thanks, that helps it get a bit further, but it spits out a whole truck
load of errors before it gets anywhere near DRM stuff.  Either this
stuff isn't maintained, or it's for a newer flavour of TEX.  From what
I read on the web, this kind of problem is fairly typical where TEX
stuff goes (no two tex versions are compatible.)

I think I'll leave the kerneldoc stuff to someone who knows (a) how to
deal with it.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
