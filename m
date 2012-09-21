From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 21 Sep 2012 21:34:40 +0100
Subject: [PATCH 3/3] serial: pl011: allow very high baudrates
In-Reply-To: <20120921205603.436a0194@pyramind.ukuu.org.uk>
References: <1348134368-25663-1-git-send-email-linus.walleij@stericsson.com>
 <20120920190034.GB15609@n2100.arm.linux.org.uk>
 <CACRpkdY1ZxQoyGFO9OnKr0WYQzooxPGvZV8Gnr_YO_yT_+ddDw@mail.gmail.com>
 <20120921162543.1ed18775@pyramind.ukuu.org.uk>
 <CACRpkdakLAPmD0TQwe2VNhdePDuFv2KXD2U1xoP1C0axkx2p7A@mail.gmail.com>
 <20120921205603.436a0194@pyramind.ukuu.org.uk>
Message-ID: <20120921203440.GA6796@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 21, 2012 at 08:56:03PM +0100, Alan Cox wrote:
> If you are calling TCSETS2 passing BOTHER and an actual specific speed
> you should always be getting handed back the speed requested as it'll see
> the BOTHER flag is present and assume the caller is smart.

Is this something that should be handled by glibc?  If so, ARM for
whatever reason still seems to use the standard TCGETS and TCSETS
calls... at least stracing stty in ubuntu precise suggests that's
the case.
