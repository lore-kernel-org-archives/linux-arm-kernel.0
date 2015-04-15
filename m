From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 15 Apr 2015 10:04:25 +0100
Subject: [RFC PATCH 5/5] arm64: qcom: add cpu operations
In-Reply-To: <552D9A37.6070107@redhat.com>
References: <1428601031-5366-1-git-send-email-galak@codeaurora.org>
 <1428601031-5366-6-git-send-email-galak@codeaurora.org>
 <20150414162953.GL28709@leverpostej> <552D9A37.6070107@redhat.com>
Message-ID: <20150415090425.GA2866@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 14, 2015 at 11:52:39PM +0100, Al Stone wrote:
> On 04/14/2015 10:29 AM, Mark Rutland wrote:
> >> diff --git a/Documentation/devicetree/bindings/arm/cpus.txt b/Documentation/devicetree/bindings/arm/cpus.txt
> >> index 8b9e0a9..35cabe5 100644
> >> --- a/Documentation/devicetree/bindings/arm/cpus.txt
> >> +++ b/Documentation/devicetree/bindings/arm/cpus.txt
> >> @@ -185,6 +185,8 @@ nodes to be present and contain the properties described below.
> >>                           be one of:
> >>                              "psci"
> >>                              "spin-table"
> > 
> > In the case of these two, there's documentation on what the OS, FW, and
> > HW are expected to do. There's a PSCI spec, and spin-table is documented
> > in booting.txt (which is admittedly not fantastic).
> > [snip...]
> 
> Perhaps a side topic, but I thought spin-table was being actively discouraged
> for arm64.  Forgive me if I missed the memo, but is that not correct?

We prefer that people implement PSCI, and if they must use spin-table,
each CPU has its own release address.

However, we don't want implementation-specific mechanisms, and
spin-table is preferable to these.

Mark.
