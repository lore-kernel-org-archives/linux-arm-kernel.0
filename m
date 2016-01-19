From: andrew@lunn.ch (Andrew Lunn)
Date: Tue, 19 Jan 2016 15:48:46 +0100
Subject: [PATCH 1/2] ARM: dts: kirkwood: split lswxl into linkstation
 lswsxl and lswxl
In-Reply-To: <CAEQ9gE=saHf0TZ5aBDYC0cCMCXgHOSON8-oPwmVXuU-h4XPbFA@mail.gmail.com>
References: <1453211342-25214-1-git-send-email-rogershimizu@gmail.com>
 <1453211342-25214-2-git-send-email-rogershimizu@gmail.com>
 <20160119140507.GG6554@lunn.ch>
 <CAEQ9gE=saHf0TZ5aBDYC0cCMCXgHOSON8-oPwmVXuU-h4XPbFA@mail.gmail.com>
Message-ID: <20160119144846.GI6554@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 19, 2016 at 11:15:35PM +0900, Roger Shimizu wrote:
> On Tue, Jan 19, 2016 at 11:05 PM, Andrew Lunn <andrew@lunn.ch> wrote:
> > On Tue, Jan 19, 2016 at 10:49:01PM +0900, Roger Shimizu wrote:
> >> With a few gpio/led-pin changes, including fix for the issue mentioned
> >> in Debian BTS #810894.
> >
> > Hi Roger
> >
> > This fix should be a separate patch. We can then get it applied to
> > stable, so it makes its way back to older kernels.
> 
> Dear Andrew,
> 
> So this patchset would be reviewed or not?

I will review it and give comments, but won't accept it.

> Or I have to create another patchset including both fix for
> "kirkwood-lswxl.dts" and the dts split?

Yes please. And the fix patch should come first, and have a fixes:
tag.

As a general rule of thumb, it is better to have lots of small, easy
to review patches, than an couple of big patch. So i would probably
have:

1) Fix
2) License change.
3) Split patch LS-WXL/WSXL
4) Split patch LS-WVL/VL

The license change needs a different sort of review to the other
patches, so having it as a separate patch helps with the review
process.

	Andrew
