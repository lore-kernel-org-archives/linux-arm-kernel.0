From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 21 Jan 2016 12:11:04 +0000
Subject: [PATCH 00/19] arm64 kexec kernel patches v13
In-Reply-To: <20160120025621.GC2999@dhcp-128-65.nay.redhat.com>
References: <cover.1452884156.git.geoff@infradead.org>
 <20160119123230.GB2904@dhcp-128-65.nay.redhat.com>
 <1453248900.21755.8.camel@infradead.org>
 <20160120025621.GC2999@dhcp-128-65.nay.redhat.com>
Message-ID: <20160121121103.GE2581@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 20, 2016 at 10:56:21AM +0800, Dave Young wrote:
> On 01/19/16 at 04:15pm, Geoff Levand wrote:
> > On Tue, 2016-01-19 at 20:32 +0800, Dave Young wrote:
> > > Geoff, another question about kexec-tools part is, can the kexec
> > > -tools code
> > > been written in kernel? We have the infrastructure for kexec_file_load.
> > 
> > I see no technical reason why the arm64 kernel cannot support
> > kexec_file_load.
> 
> Cool, care to port it to kernel so that we have kexec_file_load only in arm64
> we do not need to support both kexec_load and kexec_file_load?

I have reasons for wanting kexec_load, even if we have kexec_file_load.
For example, being able to test modified DTBs during development, and
being able to kexec to non-Linux OSs.

I don't think we should drop kexec_load, as kexec_file_load is designed
such that it cannot be used for these purposes, while kexec_load is more
general.

I appreciate that we will need kexec_file_load for Secure Boot, and it
would be perfectly fine for your kdump userspace to require and always
use kexec_file_load.

Thanks,
Mark.
