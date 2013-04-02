From: pawel.moll@arm.com (Pawel Moll)
Date: Tue, 02 Apr 2013 17:40:09 +0100
Subject: [PATCH 04/10] arm: zynq: Load scu baseaddress at run time
In-Reply-To: <CAHTX3d+1auKVLko+LKAA+a4rh4Rfw19ggzmS7DhvYuuCAWUwHA@mail.gmail.com>
References: <1364219596-4954-1-git-send-email-michal.simek@xilinx.com>
 <1364219596-4954-4-git-send-email-michal.simek@xilinx.com>
 <515059D4.5070903@gmail.com>
 <CAHTX3dJfvFNNuyJC54fS=NCpRxovVsxHTss8wJd_QOB2PaxL7g@mail.gmail.com>
 <51506F31.2080709@gmail.com>
 <CAHTX3d+1auKVLko+LKAA+a4rh4Rfw19ggzmS7DhvYuuCAWUwHA@mail.gmail.com>
Message-ID: <1364920809.3019.30.camel@hornet>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Greetings,

Apologies about "slightly" delayed response.

On Mon, 2013-03-25 at 16:07 +0000, Michal Simek wrote:
> Pawel: You are the author of this code in vexpress. Is there any
> particular reason
> to have there that ioremap?

At the time there was no standard DT->platsmp solution and the
traditional way was using the SCU to work out the CPUs.

If I was doing this today (and I'll re-do this code at some point) I'd
rely on the DT in the first place and maybe then have a SCU
"micro-driver" double-checking the DT data against the SCU information.
That way I could reduce the dependency on static mappings. And this is
what I want to get - if possible I don't want any static mapping at all.

Pawe?
