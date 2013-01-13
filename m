From: andrew@lunn.ch (Andrew Lunn)
Date: Sun, 13 Jan 2013 22:42:59 +0100
Subject: [PATCH v2] mmc: mvsdio: Replace IS_ERR_OR_NULL() with IS_ERR()
In-Reply-To: <20130113204348.GR13433@titan.lakedaemon.net>
References: <20130111004323.GA12257@schnuecks.de>
 <1357889273-11553-1-git-send-email-andrew@lunn.ch>
 <20130113204348.GR13433@titan.lakedaemon.net>
Message-ID: <20130113214259.GE17242@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 13, 2013 at 03:43:48PM -0500, Jason Cooper wrote:
> On Fri, Jan 11, 2013 at 08:27:52AM +0100, Andrew Lunn wrote:
> > A NULL is a valid clk cookie, so we should not be tested with
> > IS_ERR_OR_NULL(). Replace it with IS_ERR().
> > 
> > Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> > ---
> > 
> > This patch depends on Thomas Petazzoni DT patches for mvsdio, which changed
> > the order of resource allocation etc.
> 
> grrr, I'm seeing fixes depending on features :(  Any way to avoid that?
> 
> In light of Russell's comments, shall I wait for a v3?  All of Thomas'
> mvsdio work is now waiting on this.  I'd like to get that in as early as
> possible.

Well, im guessing doing the fixes first will require changes to Thomas
features. 

Did you try putting Russells patch in first? How bad are the
conflicts?

	Andrew
