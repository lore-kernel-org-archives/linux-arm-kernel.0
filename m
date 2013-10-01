From: nico@fluxnic.net (Nicolas Pitre)
Date: Mon, 30 Sep 2013 23:21:20 -0400 (EDT)
Subject: [PATCH RESEND] ARM: add dtbImage.<dt> and dtbuImage.<dt> rules
In-Reply-To: <CAL_JsqJ4Fn93ULo1sAA=8VUm33XkKY9iVpdqjQm6jh0s4pNFBw@mail.gmail.com>
References: <504DFBBF.5010202@free-electrons.com>
 <1348733441-11626-1-git-send-email-richard.genoud@gmail.com>
 <20120927082955.GR17667@game.jcrosoft.org>
 <CACQ1gAgwv4pBFZBrVZiWM2_=OneUO-s16LufSENx27gMC3DUig@mail.gmail.com>
 <52416F97.802@keymile.com> <20130924120152.GI11119@titan.lakedaemon.net>
 <20130924121939.GD12758@n2100.arm.linux.org.uk>
 <CA+bK7J7=x6=ZsWnSkGByvDLbht9nD6G3wQ5d05P-D96v6udDgg@mail.gmail.com>
 <CAL_JsqJ4Fn93ULo1sAA=8VUm33XkKY9iVpdqjQm6jh0s4pNFBw@mail.gmail.com>
Message-ID: <alpine.LFD.2.03.1309302316580.6331@syhkavp.arg>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 30 Sep 2013, Rob Herring wrote:

> I don't think appended DTB will go away. In fact, use of it is now
> being added to flash-kernel in debian/ubuntu. However, this is only
> done at OS install time on running on the h/w.

Excellent!  That is exactly the use case this feature was designed for.  
Otherwise we would simply have linked the DTB into the kernel image 
directly.

Appending a DTB to zImage should be done at kernel installation time, 
not at build time.  The nuance might not mean a lot for some 
environment, but for a distro this is clearly separate operations.


Nicolas
