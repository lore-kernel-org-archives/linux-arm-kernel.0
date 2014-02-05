From: grant.likely@linaro.org (Grant Likely)
Date: Wed, 05 Feb 2014 13:47:39 +0000
Subject: [PATCH v4] of: add functions to count number of elements in a
 property
In-Reply-To: <8812602.o5pus1vSFK@phil>
References: <27256277.YJ687suYy5@phil> <13514940.URVnEJ4NF0@phil> <
 20140205120652.9B1A7C40A89@trevor.secretlab.ca> <8812602.o5pus1vSFK@phil>
Message-ID: <20140205134739.52662C40A89@trevor.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 05 Feb 2014 13:45:36 +0100, Heiko St??bner <heiko@sntech.de> wrote:
> Am Mittwoch, 5. Februar 2014, 12:06:52 schrieb Grant Likely:
> > On Tue, 04 Feb 2014 19:48:17 +0100, Heiko St????bner <heiko@sntech.de> wrote:
> > > Hi Grant,
> > > 
> > > On Tuesday, 4. February 2014 17:30:34 Grant Likely wrote:
> > > > On Sat, 18 Jan 2014 09:07:30 -0600, Rob Herring <robherring2@gmail.com>
> > > 
> > > wrote:
> > > > > On Sat, Jan 18, 2014 at 6:02 AM, Heiko St????????bner <heiko@sntech.de> 
> wrote:
> > > > > > The need to know the number of array elements in a property is
> > > > > > a common pattern. To prevent duplication of open-coded
> > > > > > implementations
> > > > > > add a helper static function that also centralises strict sanity
> > > > > > checking and DTB format details, as well as a set of wrapper
> > > > > > functions
> > > > > > for u8, u16, u32 and u64.
> > > > > > 
> > > > > > Suggested-by: Mark Rutland <mark.rutland@arm.com>
> > > > > > Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> > > > > > ---
> > > > > 
> > > > > Looks good. Do you plan to convert some users to use this?
> > > > 
> > > > I'll take that as an acked-by. Merged, thanks.
> > > 
> > > before you taking this patch, I was planning on simply sending this as
> > > part of my rockchip-smp series - as I'm currently the only user of it :-)
> > > .
> > > 
> > > This going through your tree is most likely the better way, but now I need
> > > it to somehow make its way into arm-soc too ... I guess some sort of
> > > stable branch arm-soc could pull?
> > 
> > Nah, I'll drop it from my tree. Add my acked-by and merge it via
> > arm-soc.
> 
> As I said on IRC, now it seems like you can keep this patch in your tree :-)
> 
> If we're really going with reserved-memory like you suggested in the rockchip-
> smp series it removes the need to count u32-elements in a property for me, as 
> the reserved blocks move into individual subnodes.

Right, but I'm not going to merge a patch with no users. I'll leave it
out and it can be added to a series that converts some users to the new
API.

g.
