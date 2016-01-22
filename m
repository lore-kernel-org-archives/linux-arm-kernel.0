From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 22 Jan 2016 15:02:56 +0000
Subject: [PATCH] Eliminate the .eh_frame sections from the aarch64
 vmlinux and kernel modules
In-Reply-To: <56A2400D.5080707@redhat.com>
References: <1453434986-19307-1-git-send-email-wcohen@redhat.com>
 <CAKv+Gu9j7VGqoOWOZ1T1CVQZfSy9HL9wzvAX83bRiks=6b3dzw@mail.gmail.com>
 <56A2400D.5080707@redhat.com>
Message-ID: <20160122150256.GC11645@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 22, 2016 at 09:43:25AM -0500, William Cohen wrote:
> On 01/22/2016 02:41 AM, Ard Biesheuvel wrote:
> > On 22 January 2016 at 04:56, William Cohen <wcohen@redhat.com> wrote:
> >> By default the aarch64 gcc generates .eh_frame sections.  Unlike
> >> .debug_frame sections, the .eh_frame sections are loaded into memory
> >> when the associated code is loaded.  On an example kernel being built
> >> with this default the .eh_frame section in vmlinux used an extra 1.7MB
> >> of memory.  The x86 disables the creation of the .eh_frame section.
> >> The aarch64 should probably do the same to save some memory.
> >>
> > 
> > With my GCC-4.9.3 Linaro toolchain, I am not getting .eh_frame
> > sections only .debug_frame sections. The patch still makes sense imo,
> > but it appears to be redundant in some cases, and it would be useful
> > to figure out why. Which toolchain have you tested this with?
> 
> Hi,
> 
> I have observed the .eh_frame being generated with gcc-5.3.1 that is in Fedora 23.

FWIW, I do not see this with the Linaro 15.08 GCC 5.1.1.

It would be interesting to know if that's something that changed
upstream between 5.1.x and 5.3.x or if that's a Fedora-specific
configuration option, but either way the patch seems reasonable.

Thanks,
Mark.
