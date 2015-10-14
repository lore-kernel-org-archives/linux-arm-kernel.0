From: robin.murphy@arm.com (Robin Murphy)
Date: Wed, 14 Oct 2015 19:19:44 +0100
Subject: [PATCH v6 0/3] arm64: IOMMU-backed DMA mapping
In-Reply-To: <20151014115013.GM27420@8bytes.org>
References: <cover.1443718557.git.robin.murphy@arm.com>
 <561CF53E.7000809@arm.com> <20151014115013.GM27420@8bytes.org>
Message-ID: <561E9CC0.40701@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14/10/15 12:50, joro at 8bytes.org wrote:
> Hi Robin,
>
> On Tue, Oct 13, 2015 at 01:12:46PM +0100, Robin Murphy wrote:
>> Anyway, what are your thoughts on taking this for 4.4? Since the
>> dependencies are now in and we're at -rc5 already, I'm on the verge
>> of reposting a self-contained version to go through arm64, as we
>> really need to unblock all the follow-on development there (it's a
>> shame that of the people I'm aware want this, it's only me and the
>> Mediatek/Chrome guys here on the list saying so).
>
> I plan to take it for 4.4, given the missing ack arrives. What are your
> plans to resolve the remaining issues, like with the probe deferral
> patch-set?

That's great, thanks. I've been keeping an eye on the on-demand probing 
series[0], and now that things are looking promising there I'm having a 
go at pulling it in as it lets us solve the device dependency issue in 
an even neater way than deferral. With the rest of Laurent's patches to 
move the OF dma_ops configuration into the probe path, I just need to 
finish working out how to handle probe failure/deferral, and we should 
be good to go. That's my priority for 4.5, in parallel with properly 
wiring up the ARM SMMU driver to work nicely with this stuff.

Sorting out the configuration order also gets us a lot closer to 
handling multiple IOMMU drivers for platform devices, and moving 32-bit 
ARM over to the common code - plus I now have some RK3288 hardware which 
can serve to test both of those, too.

Robin.

[0]:http://thread.gmane.org/gmane.linux.acpi.devel/78653
