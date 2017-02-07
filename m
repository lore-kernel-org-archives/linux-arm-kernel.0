From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 7 Feb 2017 19:06:02 +0000
Subject: [PATCH] efi/libstub/arm*: Set default address and size cells
 values for an empty dtb
In-Reply-To: <20170207190113.GG26173@leverpostej>
References: <1486490390-25251-1-git-send-email-jhugo@codeaurora.org>
 <CAKv+Gu963uZB4MaMDuwTGd5-AqEN53Er8tExVLMZNVx3krJrZw@mail.gmail.com>
 <1f47fcdd-c5d8-4082-70a3-ca9b1746d7ca@codeaurora.org>
 <20170207190113.GG26173@leverpostej>
Message-ID: <20170207190602.GH26173@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 07, 2017 at 07:01:14PM +0000, Mark Rutland wrote:
> On Tue, Feb 07, 2017 at 11:54:55AM -0700, Jeffrey Hugo wrote:

> > Kexec attempts to insert these values in the fdt.  The fdt only
> > accepts 32-bit values, so it truncates what is put in.  Then later
> > kexec/kdump read the values from the fdt, and get garbage.
> 
> I take it this is specific to the kdump properties? 
> 
> I can't immediately see what would matter for the !kdump case.
> properties inserted under /chosen are not truncated?

Whoops; please ignore the last line. I'd meant to delete that (and it
obviously makes no sense).

Mark.
