From: wsa@the-dreams.de (Wolfram Sang)
Date: Tue, 25 Mar 2014 17:48:12 +0100
Subject: [PATCH 4/5] ARM: shmobile: r8a7790: add IIC(B) clocks to dtsi
In-Reply-To: <CANqRtoQhi=vgLkYQciJska6XogyiJ1REO6HBOHNsPP3ajbq+Ag@mail.gmail.com>
References: <1394573078-20767-1-git-send-email-wsa@the-dreams.de>
 <1394573078-20767-5-git-send-email-wsa@the-dreams.de>
 <CANqRtoQhi=vgLkYQciJska6XogyiJ1REO6HBOHNsPP3ajbq+Ag@mail.gmail.com>
Message-ID: <20140325164812.GE6374@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 12, 2014 at 08:05:26PM +0900, Magnus Damm wrote:
> Hi Wolfram,
> 
> On Wed, Mar 12, 2014 at 6:24 AM, Wolfram Sang <wsa@the-dreams.de> wrote:
> > From: Wolfram Sang <wsa@sang-engineering.com>
> >
> > Signed-off-by: Wolfram Sang <wsa@sang-engineering.com>
> > ---
> > Note: Adding clocks whilst keeping the current sorting is very likely to
> > break a previously working clock IMO. Imagine adding PCIEC clock inbetween IIC0
> > and IIC1 here. Adding chronologically and grouped by similar function blocks is
> > easier to track. An example addition could then look like:
> >
> >         R8A7790_CLK_TPU0
> >         R8A7790_CLK_SDHI3 R8A7790_CLK_SDHI2 R8A7790_CLK_SDHI1 R8A7790_CLK_SDHI0
> >         R8A7790_CLK_MMCIF1 R8A7790_CLK_MMCIF0
> >         R8A7790_CLK_CMT1
> >         R8A7790_CLK_IIC2 R8A7790_CLK_IIC1 R8A7790_CLK_IIC0
> > +       R8A7790_CLK_PCIEC
> 
> Can you please care to explain a bit more about why you see a risk
> here? Is it a risk for typo or something else?

The risk here is if you put something in the "middle" then there is a
chance you might be off, and, for example, mix up parent clocks.
Especially when you need to reformat paragraphs because of too long
lines. Yeah, all this can be avoided by careful review, but this review
really needs to be careful.

> It looks to me that this is just a matter about adding the entry at
> the right position in several places.

Yes. IMO adding it with the pattern I sketched above will make it a
piece of cake since the diff is a lot more simple than the patch I
originally submitted.

That being said, I will keep the current sorting for consistency reasons
but I personally made up my mind ;)

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140325/622e9684/attachment.sig>
