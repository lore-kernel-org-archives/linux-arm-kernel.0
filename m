From: neko@bakuhatsu.net (Matt Sealey)
Date: Thu, 29 Aug 2013 12:23:02 -0500
Subject: [PATCH] dma: imx-sdma: Add ROM script addresses to driver
In-Reply-To: <20130820150252.GB31060@pengutronix.de>
References: <1376914563-10912-1-git-send-email-s.hauer@pengutronix.de>
 <CAHCPf3t1_5zhSOrfVFHgeVPa25sT+ewv1=OZA8X4_YZXb9cSeA@mail.gmail.com>
 <20130820070039.GH31036@pengutronix.de>
 <CAHCPf3sJDRXUkrkRtku06OvBav2idFvJwThsxsrHngXg3mEXJA@mail.gmail.com>
 <20130820150252.GB31060@pengutronix.de>
Message-ID: <CAHCPf3vYTW7=s663+mEnesRX=MoSc8VwN5i=RB0Zm3J727_t2Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 20, 2013 at 10:02 AM, Sascha Hauer <s.hauer@pengutronix.de> wrote:
>
>> What I'd really like to see is the "waiting on a firmware that doesn't
>> exist when there is a working ROM version of those scripts in the SoC"
>
> Then this patch is for you. This is exactly what the patch solves.

Only by changing the device tree and not specifying a firmware
filename. The driver probes, knows about ROM script addresses as per
your patch, tries to load a new file from disk; same hang. What you
have now is a way to use a potentially buggy script with several
functions missing (ROM script isn't as full-featured as the file-based
one on some chips) or a hang on boot if you misplaced a firmware which
is notoriously hard to get hold of..

How do we resolve this except to load the firmware pre-Linux (or put
the firmware in the tree, argh) and describe the loaded firmware and
offsets? Once it's in the internal SDMA code RAM all the versioning
and headers go away..
