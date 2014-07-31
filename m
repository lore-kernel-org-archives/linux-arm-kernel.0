From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 31 Jul 2014 15:00:44 +0100
Subject: Bad Page dump (help)
In-Reply-To: <53D9E10F.6040408@xenomai.org>
References: <20140729190700.GN17808@saruman.home>
 <53D9E10F.6040408@xenomai.org>
Message-ID: <20140731140044.GL30282@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 31, 2014 at 08:24:15AM +0200, Gilles Chanteperdrix wrote:
> On 07/29/2014 09:07 PM, Felipe Balbi wrote:
> > Hi Russell,
> > 
> > I'm bringing up a new board on today's linux-next but I'm having a bunch
> > of bad_page() calls due to _mapcount not being zero (full logs
> > attached). What could cause that ? Any hints on how to debug ? It's as
> > if page_mapcount_reset() wasn't called for the pages which are causing
> > issues.
> 
> FWIW, the same issue appeared on a Cogent CSB637 board (the last board 
> I use not using DT) in between 3.13 and 3.14. I ran a bisect and found 
> that reverting the following commit:

I don't seem to have a bug report from you for this.

> Seemed to make the issue disappear. I later found out that changing the
> kernel options also made the issue disappear.

Which kernel options?

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
