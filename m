From: geoff@infradead.org (Geoff Levand)
Date: Mon, 07 Dec 2015 10:47:14 -0800
Subject: [PATCH v12 08/16] arm64/kexec: Add core kexec support
In-Reply-To: <20151204035405.GB737@dhcppc13.redhat.com>
References: <cover.1448403503.git.geoff@infradead.org>
 <6ac232ad37d6b02cf2d5848b15236f26f5ac61ac.1448403503.git.geoff@infradead.org>
 <20151127131306.GE23908@dhcppc13.redhat.com>
 <1448909475.31214.27.camel@infradead.org>
 <20151201021615.GA5704@dhcppc13.redhat.com>
 <002101d12c66$ae985440$0bc8fcc0$@codeaurora.org>
 <1449096562.6139.74.camel@infradead.org>
 <000b01d12d84$4313a930$c93afb90$@codeaurora.org>
 <1449172587.24127.12.camel@infradead.org> <5660E0B0.8010507@codeaurora.org>
 <20151204035405.GB737@dhcppc13.redhat.com>
Message-ID: <1449514034.24127.18.camel@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2015-12-04 at 09:24 +0530, Pratyush Anand wrote:
> Hi Geoff,
> 
> On 03/12/2015:05:39:12 PM, Azriel Samson wrote:
> > This was a setup issue on my side. kdump with your v11 patches worked fine
> > without the above patch when I used your version of kexec-tools.
> > 
> > In kexec-tools, I had to skip check_cpu_nodes() since we are using ACPI and
> > the device tree does not contain cpu_info.
> 
> I think, something like following should be squashed into patch "arm64: Add arm64
> kexec support".
> https://github.com/pratyushanand/kexec-tools/commit/85f403cabb9ae0d7a37d1656a00fb609a9525086

I think it better to test for ACPI and then run
any meaningful checks than to just ignore the
check_cpu_nodes failure.

-Geoff
