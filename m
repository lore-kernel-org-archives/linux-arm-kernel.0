From: dyoung@redhat.com (Dave Young)
Date: Wed, 23 Nov 2016 10:03:00 +0800
Subject: [PATCH 2/2] arm64: Pass RAM boundary and enable-dcache flag to
 purgatory
In-Reply-To: <54cad725-90f0-8dfe-bee6-fe1d3e02175d@redhat.com>
References: <cover.1479788404.git.panand@redhat.com>
 <b1b9e70db9d08364040436154cf0cf2f4600da49.1479788404.git.panand@redhat.com>
 <53ee2a62-7822-5457-e59f-e65e64a57019@infradead.org>
 <54cad725-90f0-8dfe-bee6-fe1d3e02175d@redhat.com>
Message-ID: <20161123020300.GA3481@dhcp-128-65.nay.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/23/16 at 07:16am, Pratyush Anand wrote:
> Hi Geoff,
> 
> On Wednesday 23 November 2016 12:27 AM, Geoff Levand wrote:
> > Hi Pratyush,
> > 
> > On 11/21/2016 08:32 PM, Pratyush Anand wrote:
> > > When "enable-dcache" is passed to the kexec() command line, kexec-tools
> > > passes this information to purgatory, which in turn enables cache during
> > > sha-256 verification.
> > 
> > What's the point of this enable-dcache option?  Why not just
> > always enable the cache if we can?
> 
> As I have written in changelog of patch 1/2
> 
> "We are supporting only 4K and 64K page sizes. This code will not work if a
> hardware is not supporting at least one of these page sizes.  Therefore,
> D-cache is disabled by default and enabled only when "enable-dcache" is
> passed to the kexec()."
> 
> 
> Although this is very unlikely that a hardware will support only 16K page
> sizes, however it is possible. Therefore, its better to keep it disabled by
> default.

If it is *unlikely* it could be better to make it as default and add a
--disable-dcache instead.

> 
> ~Pratyush
> 
> _______________________________________________
> kexec mailing list
> kexec at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec

Thanks
Dave
