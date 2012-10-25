From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 25 Oct 2012 15:18:00 +0100
Subject: [PATCH 7/8] i2c: add 'transferred' field to struct i2c_msg
In-Reply-To: <20121025155633.609c5554@endymion.delvare>
References: <1350899218-13624-1-git-send-email-balbi@ti.com>
 <1350899218-13624-8-git-send-email-balbi@ti.com>
 <20121025145748.760c218b@endymion.delvare>
 <20121025131459.GG28061@n2100.arm.linux.org.uk>
 <20121025154202.41f3cbba@endymion.delvare>
 <20121025134609.GH28061@n2100.arm.linux.org.uk>
 <20121025155633.609c5554@endymion.delvare>
Message-ID: <20121025141800.GI28061@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 25, 2012 at 03:56:33PM +0200, Jean Delvare wrote:
> On Thu, 25 Oct 2012 14:46:09 +0100, Russell King - ARM Linux wrote:
> > On Thu, Oct 25, 2012 at 03:42:02PM +0200, Jean Delvare wrote:
> > > On Thu, 25 Oct 2012 14:14:59 +0100, Russell King - ARM Linux wrote:
> > > > You also miss one very very very big point.  This will break every I2C
> > > > using userspace program out there unless it is rebuilt - this change will
> > > > require the exact right version of those userspace programs for the
> > > > kernel that they're being used on.
> > > 
> > > How that? The extra field is added in a hole, so we don't change the
> > > struct size nor the relative positions of existing fields. Why would
> > > user-space care?
> > 
> > You know the layout of that struct for certain across all Linux supported
> > architectures, including some of the more obscure ones which may not
> > require pointers to be aligned?
> 
> No I don't, I naively supposed it would be fine. I would expect gcc to
> always align pointers even when the architecture doesn't need them to
> be, for performance reasons, even when it doesn't have to, as long as
> attribute packed isn't used. After all, integers don't _have_ to be
> aligned on x86, but gcc aligns them.
> 
> The original idea of using the hole in the i2c_msg structure is from
> David Brownell, who was apparently familiar with such practice, so I
> assumed it was OK. Actually I still assume it is, until someone comes
> with an supported architecture where it is not.

According to Al Viro, that would be m68k.
