From: zlim.lnx@gmail.com (Z Lim)
Date: Wed, 14 Jan 2015 10:24:18 -0800
Subject: [PATCH boot-wrapper-aarch64 1/4] psci: use MPIDR_INVALID instead
 of -1
In-Reply-To: <20150114110343.GC12069@leverpostej>
References: <1421115304-19580-1-git-send-email-zlim@broadcom.com>
 <1421115304-19580-2-git-send-email-zlim@broadcom.com>
 <20150114110343.GC12069@leverpostej>
Message-ID: <CABg9mcsP_P4YoPoDjt+KP=6YZRAXE4jKSVuHvTU5Tsvggst=Gg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On Wed, Jan 14, 2015 at 3:03 AM, Mark Rutland <mark.rutland@arm.com> wrote:
> Hi,
>
> On Tue, Jan 13, 2015 at 02:15:01AM +0000, Zi Shen Lim wrote:
>> MPIDR_INVALID was already defined, so use it.
>
> MPIDR_INVALID is meant to be an invalid MPIDR value, rather than an
> error code in the case of an invalid MPIDR.
>
> __find_logical_index is meant to return a logical CPU ID, so returning
> MPIDR_INVALID isn't quite right.
>
> I'd be happier if we used a separate macro for the logical IDs (e.g.
> ID_INVALID).

I follow your argument here.

I guess I should've reordered patches 1 and 2.
In patch 2, following removal of the sentinel, MPIDR_INVALID is no
longer found in id_table itself.
So MPIDR_INVALID is indeed the "ID_INVALID" you're suggesting.

Are you comfortable with this repurposing of MPIDR_INVALID?
Now, MPIDR_INVALID (-1) is consistently used as return value of
find_logical_id for an invalid/unknown MPIDR.

>
> Thanks,
> Mark.
>
