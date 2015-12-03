From: will.deacon@arm.com (Will Deacon)
Date: Thu, 3 Dec 2015 09:32:13 +0000
Subject: [PATCH v12 05/16] arm64: Add back cpu_reset routines
In-Reply-To: <1449097050.6139.80.camel@infradead.org>
References: <cover.1448403503.git.geoff@infradead.org>
 <3279584774ba40f088b79f4df864d69a5b57b516.1448403503.git.geoff@infradead.org>
 <56586679.8060403@arm.com>
 <20151130052843.GG23908@dhcppc13.redhat.com>
 <20151130104027.7eeaa273@why.wild-wind.fr.eu.org>
 <1449097050.6139.80.camel@infradead.org>
Message-ID: <20151203093212.GC7023@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 02, 2015 at 02:57:30PM -0800, Geoff Levand wrote:
> On Mon, 2015-11-30 at 10:40 +0000, Marc Zyngier wrote:
> 
> > All that can be solved in C, and mostly at compile time. Using an
> > assembler trampoline is complicating things for no good reason:
> 
> I added this into my kexec-v12.1 branch.  After some more testing I'll
> post a v13 to the list.

You may well need some notrace annotations if you want to run C code
here. Can you give it a spin with things like ftrace and kprobes?

Will
