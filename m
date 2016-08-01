From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 1 Aug 2016 14:31:20 +0100
Subject: [PATCH] arm64: fix address fault during mapping fdt region
In-Reply-To: <579F4BD5.9060300@zoho.com>
References: <579F197B.80101@zoho.com>
 <CAKv+Gu9QQdncCD_T8+tpdVP8qx=EKM9-PGLvb8J9RNA2qHddFw@mail.gmail.com>
 <579F2BA6.1010203@zoho.com> <20160801112450.GD11119@leverpostej>
 <579F4BD5.9060300@zoho.com>
Message-ID: <20160801133120.GA14267@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 01, 2016 at 09:17:09PM +0800, zijun_hu wrote:
> On 08/01/2016 07:24 PM, Mark Rutland wrote:
> > On Mon, Aug 01, 2016 at 06:59:50PM +0800, zijun_hu wrote:
> >> 2?it is more portable; we only need to call fdt_check_header() and don't
> >> care about fdt header filed layout; moreover,fdt module is another independent
> >> module and arm64 only uses it and should not depend on more details of fdt
> >> such as size and magic fields locate within the first MIN_FDT_ALIGN bytes;
> >> the decision whether a fdt header is corrupted should be left to fdt team
> > 
> > While it's true that we assume knowledge of the FDT format, and ideally
> > we'd leave this to common code, we do so regardless by requiring the
> > header size. So both approaches assume details regarding the FDT format.
> > 
> okay, the only thing my solution is depends on is the fdt header struct name
> which maybe remain unchanged in further fdt source modification
> regardless of fields layout or position or header size;
> 
> by the way, my solution only maps more one SWAPPER_BLOCK_SIZE at extreme condition
> (offset + sizeof(struct fdt_header)) > SWAPPER_BLOCK_SIZE, it can occurs very rarely,
> even it happens, it is no matter due to the fast mapping operations
> 
> That all said, ard.biesheuvel's can resolves address fault too, you can decide which
> solution to used, maybe ask fdt team for some advisements

As a member of the "fdt team" (at least for bindings and the spec), I'm
happy with Ard's patch. ;)

Regardless, many thanks for the report, and the proposed fix!

Thanks,
Mark.
